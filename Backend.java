import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.net.InetSocketAddress;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.io.*;
import java.util.*;

public class Backend {
    private static final String URL = "jdbc:mysql://localhost:3306/disaster_relief";
    private static final String USER = "root";
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    private static final Map<String, List<String>> COLUMNS = new HashMap<>();
    private static final Map<String, String> PRIMARY = new HashMap<>();
    static {
        COLUMNS.put("disasters", Arrays.asList("disaster_id","disaster_name","disaster_type","location","start_date","status")); PRIMARY.put("disasters","disaster_id");
        COLUMNS.put("relief_camps", Arrays.asList("camp_id","camp_name","location","capacity","occupied","status","disaster_id")); PRIMARY.put("relief_camps","camp_id");
        COLUMNS.put("relief_resources", Arrays.asList("resource_id","item_name","category","total_quantity","quantity_distributed")); PRIMARY.put("relief_resources","resource_id");
        COLUMNS.put("beneficiaries", Arrays.asList("victim_id","name","phone","age","gender","camp_id","family_members","status")); PRIMARY.put("beneficiaries","victim_id");
        COLUMNS.put("assistance_requests", Arrays.asList("request_id","requester","category","camp_id","priority","status","description")); PRIMARY.put("assistance_requests","request_id");
        COLUMNS.put("sos_requests", Arrays.asList("sos_id","name","location","request_type","request_time","status")); PRIMARY.put("sos_requests","sos_id");
        COLUMNS.put("medical_cases", Arrays.asList("case_id","patient","medical_condition","camp_id","priority","status","referral_notes")); PRIMARY.put("medical_cases","case_id");
        COLUMNS.put("public_notices", Arrays.asList("notice_id","title","body","created_at","status")); PRIMARY.put("public_notices","notice_id");
        COLUMNS.put("activities", Arrays.asList("activity_id","activity_time","activity_text")); PRIMARY.put("activities","activity_id");
        COLUMNS.put("audit_logs", Arrays.asList("audit_id","log_time","role","action","target")); PRIMARY.put("audit_logs","audit_id");
    }

    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection c = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("MYSQL CONNECTION SUCCESSFUL!");
        }
        HttpServer server = HttpServer.create(new InetSocketAddress("localhost", 8080), 0);
        server.createContext("/api/", Backend::handle);
        server.createContext("/", Backend::serveApp);
        server.start();
        System.out.println("BACKEND SERVER RUNNING!");
        System.out.println("API: http://localhost:8080/api/disasters");
        System.out.println("Keep this window open while using the website.");
    }
private static void serveApp(HttpExchange ex) throws IOException {
    if (!ex.getRequestMethod().equalsIgnoreCase("GET")) {
        send(ex, 405, "Method not allowed");
        return;
    }

    String path = ex.getRequestURI().getPath();

    if (!path.equals("/") && !path.equals("/index.html")) {
        send(ex, 404, "Not found");
        return;
    }

    File file = new File("disaster_relief_management_system_FINAL_FIXED.html");

    if (!file.exists()) {
        send(ex, 404, "HTML file not found");
        return;
    }

    byte[] body = java.nio.file.Files.readAllBytes(file.toPath());

    ex.getResponseHeaders().set(
        "Content-Type",
        "text/html; charset=UTF-8"
    );

    ex.getResponseHeaders().set("Cache-Control", "no-store");

    ex.sendResponseHeaders(200, body.length);

    try (OutputStream out = ex.getResponseBody()) {
        out.write(body);
    }
}

    private static void handle(HttpExchange ex) throws IOException {
        ex.getResponseHeaders().set("Access-Control-Allow-Origin", "*");
        ex.getResponseHeaders().set("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS");
        ex.getResponseHeaders().set("Access-Control-Allow-Headers", "Content-Type");
        ex.getResponseHeaders().set("Content-Type", "application/json; charset=UTF-8");
        String method = ex.getRequestMethod();
        if (method.equals("OPTIONS")) { ex.sendResponseHeaders(204, -1); ex.close(); return; }
        try {
            String path = ex.getRequestURI().getPath().substring("/api/".length());
            String[] parts = path.split("/");
            String table = parts[0];
            if (!COLUMNS.containsKey(table)) { send(ex,404,"{\"error\":\"Unknown API endpoint\"}"); return; }
            if (method.equals("GET") && parts.length == 1) { getTable(ex, table); return; }
            if (method.equals("POST") && parts.length == 1) { insert(ex, table, readForm(ex)); return; }
            if (method.equals("PUT") && parts.length == 2) { update(ex, table, parts[1], readForm(ex)); return; }
            send(ex,405,"{\"error\":\"Unsupported method or endpoint\"}");
        } catch (SQLException e) {
            e.printStackTrace(); send(ex,500,"{\"error\":\"Database operation failed: " + jsonEscape(e.getMessage()) + "\"}");
        } catch (Exception e) {
            e.printStackTrace(); send(ex,400,"{\"error\":\"Request failed: " + jsonEscape(e.getMessage()) + "\"}");
        }
    }

    private static void getTable(HttpExchange ex, String table) throws SQLException, IOException {
        try (Connection c=DriverManager.getConnection(URL,USER,PASSWORD); Statement st=c.createStatement(); ResultSet rs=st.executeQuery("SELECT * FROM `"+table+"`")) {
            ResultSetMetaData md=rs.getMetaData(); int n=md.getColumnCount(); StringBuilder out=new StringBuilder("["); boolean first=true;
            while(rs.next()) { if(!first) out.append(','); first=false; out.append('{');
                for(int i=1;i<=n;i++){ if(i>1)out.append(','); out.append('"').append(jsonEscape(md.getColumnLabel(i))).append("\":"); Object v=rs.getObject(i); if(v==null)out.append("null"); else if(v instanceof Number || v instanceof Boolean)out.append(v); else out.append('"').append(jsonEscape(v.toString())).append('"'); }
                out.append('}'); }
            out.append(']'); send(ex,200,out.toString());
        }
    }

    private static void insert(HttpExchange ex, String table, Map<String,String> form) throws SQLException, IOException {
        List<String> allowed=COLUMNS.get(table); List<String> names=new ArrayList<>(); List<String> vals=new ArrayList<>();
        boolean autoPrimary = Arrays.asList("disasters","relief_camps","relief_resources","public_notices","activities","audit_logs").contains(table);
        for(String key:form.keySet()) { if(allowed.contains(key) && !(autoPrimary && key.equals(PRIMARY.get(table))) && !key.equals("created_at") && !key.equals("log_time")) { names.add(key); vals.add(form.get(key)); } }
        if(names.isEmpty()) { send(ex,400,"{\"error\":\"No valid fields supplied\"}"); return; }
        StringBuilder sql=new StringBuilder("INSERT INTO `"+table+"` (");
        for(int i=0;i<names.size();i++){if(i>0)sql.append(',');sql.append('`').append(names.get(i)).append('`');}
        sql.append(") VALUES ("); for(int i=0;i<names.size();i++){if(i>0)sql.append(',');sql.append('?');} sql.append(')');
        try(Connection c=DriverManager.getConnection(URL,USER,PASSWORD); PreparedStatement ps=c.prepareStatement(sql.toString(),Statement.RETURN_GENERATED_KEYS)) {
            for(int i=0;i<vals.size();i++){ String v=vals.get(i); if(v==null || v.isEmpty()) ps.setNull(i+1, Types.VARCHAR); else ps.setString(i+1,v); }
            ps.executeUpdate(); String id=""; try(ResultSet keys=ps.getGeneratedKeys()){if(keys.next())id=String.valueOf(keys.getObject(1));}
            send(ex,200,"{\"success\":true,\"id\":\""+jsonEscape(id)+"\"}");
        }
    }

    private static void update(HttpExchange ex, String table, String id, Map<String,String> form) throws SQLException, IOException {
        List<String> allowed=COLUMNS.get(table); String pk=PRIMARY.get(table); List<String> names=new ArrayList<>();
        for(String key:form.keySet()) if(allowed.contains(key) && !key.equals(pk) && !key.equals("created_at") && !key.equals("log_time") && !key.equals("activity_id") && !key.equals("audit_id") && !key.equals("notice_id")) names.add(key);
        if(names.isEmpty()){send(ex,400,"{\"error\":\"No valid update fields supplied\"}");return;}
        StringBuilder sql=new StringBuilder("UPDATE `"+table+"` SET "); for(int i=0;i<names.size();i++){if(i>0)sql.append(',');sql.append('`').append(names.get(i)).append("`=?");} sql.append(" WHERE `"+pk+"`=?");
        try(Connection c=DriverManager.getConnection(URL,USER,PASSWORD);PreparedStatement ps=c.prepareStatement(sql.toString())){
            for(int i=0;i<names.size();i++){String v=form.get(names.get(i));if(v==null||v.isEmpty())ps.setNull(i+1,Types.VARCHAR);else ps.setString(i+1,v);} ps.setString(names.size()+1,URLDecoder.decode(id,StandardCharsets.UTF_8)); int count=ps.executeUpdate();
            if(count==0){send(ex,404,"{\"error\":\"Record not found\"}");return;} send(ex,200,"{\"success\":true}");
        }
    }

    private static Map<String,String> readForm(HttpExchange ex) throws IOException {
        String body=new String(ex.getRequestBody().readAllBytes(),StandardCharsets.UTF_8); Map<String,String> map=new LinkedHashMap<>();
        if(!body.isEmpty()) for(String pair:body.split("&")){String[] kv=pair.split("=",2);String k=URLDecoder.decode(kv[0],StandardCharsets.UTF_8);String v=kv.length>1?URLDecoder.decode(kv[1],StandardCharsets.UTF_8):"";map.put(k,v);} return map;
    }
    private static String jsonEscape(String s){if(s==null)return "";return s.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","\\r").replace("\t","\\t");}
    private static void send(HttpExchange ex,int status,String body)throws IOException{byte[] b=body.getBytes(StandardCharsets.UTF_8);ex.sendResponseHeaders(status,b.length);try(OutputStream o=ex.getResponseBody()){o.write(b);}}
}

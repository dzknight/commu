package www.silver.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class HttpConnection {
    public static final String ENCODING = "UTF-8";
    
    private static class HttpConnectionSingleton {
        private static final HttpConnection instance = new HttpConnection();
    }
    
    public static HttpConnection getInstance() {
        return HttpConnectionSingleton.instance;
    }
    
    public StringBuffer HttpPostConnection(String apiURL, Map<String, String> params) throws IOException {
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("POST");
        con.setDoOutput(true);
        
        if(params.get("Authorization") != null) {
            con.setRequestProperty("Authorization", params.get("Authorization"));
            params.remove("Authorization");
        }
        
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
        StringBuilder sb = new StringBuilder();
        int amp = 0;
        for(String key : params.keySet()) {
            if(amp >= 1) sb.append("&");
            amp += 1;
            sb.append(key + "=" + params.get(key));
        }
        
        bw.write(sb.toString());
        bw.flush();
        bw.close();
        
        return responseHttp(con);
    }
    
    private StringBuffer responseHttp(HttpURLConnection con) throws IOException {
        StringBuffer response = new StringBuffer();
        int responseCode = con.getResponseCode();
        BufferedReader br;
        
        if(responseCode == 200) {
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        
        String inputLine;
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        
        return response;
    }
}
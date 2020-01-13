package JL;

import java.util.HashMap;
import java.util.ArrayList;

class Frame {
    
    String type;
    String val;
    HashMap<String,Frame> slot;
    ArrayList<Frame> nest;
    
    Frame(String V) {
        type = "frame";
        val  = V;
        slot = new HashMap<>();
        nest = new ArrayList<>();
    }

    public String toString() { return head(""); }

    public String head(String prefix) {
        return prefix + "<" + type + ":" + val + ">";
    }

};

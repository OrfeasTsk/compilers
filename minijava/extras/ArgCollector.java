package extras;

import java.util.List;
import java.util.ArrayList;

public class ArgCollector{
    
    private List<ExprInfo> arguments;

    public ArgCollector(){
        arguments = new ArrayList<>();
    }

    public void add(ExprInfo info){
        this.arguments.add(info);
    }

    public ExprInfo get(int x){
        return this.arguments.get(x);
    }

    public int getArgNumber(){
        return this.arguments.size();
    }

    public String concatArgs(){
        String str = "";
        for(ExprInfo arg: this.arguments)
            str += arg.getName();
        return str;
    }

}
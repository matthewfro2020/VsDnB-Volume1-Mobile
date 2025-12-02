package macro;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;

class RenameNilMacro {

    public static function run() {
        // Get all modules after typing
        var modules = Context.getTypedModules();

        for (mod in modules) {
            for (t in mod.types) {
                switch (t) {

                    case TClassDecl(c):
                        var td = c.get();

                        // Match thx.Nil
                        if (td.pack.length == 1 
                            && td.pack[0] == "thx"
                            && td.name == "Nil")
                        {
                            Context.warning("Renaming thx.Nil → thx.ThxNil", td.pos);

                            // Modify the name *in place*
                            td.name = "ThxNil";
                        }

                    default:
                }
            }
        }

        return Context.getTypedModules();
    }
}

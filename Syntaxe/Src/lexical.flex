// ---------------------------------------------------------------------------
// Fichier d'entrée JFLex pour l'analyseur lexical
// ---------------------------------------------------------------------------

package ProjetCompil.Syntaxe.Src;

import java_cup.runtime.*;
import java.util.Hashtable;

/**
 * La classe Lexical permet de realiser l'analyse lexicale.
 */

%%

// -------------------------------------
// Début de la partie "directives JFLex"
// -------------------------------------

// Nom de la classe qui contient l'analyseur lexical.
// En l'absence de cette directive, cette classe s'appelle Yylex.
%class Lexical

// Cette classe doit être publique.
%public

// On crée un analyseur lexical compatible avec Cup.
%cup

// Active le comptage des lignes 
%line

// Declaration des exceptions qui peuvent etre levees par l'analyseur lexical
%yylexthrow{
   ErreurLexicale
%yylexthrow}

%{
   /**
    * Le dictionnaire associe à chaque mot réservé le code du lexème 
    * correspondant.
    */
   private final Hashtable<String,Integer> 
      dictionnaire = initialiserDictionnaire(); 

   /**
    * Initialisation du dictionnaire.
    */
   static Hashtable<String,Integer> initialiserDictionnaire() {
      Hashtable<String,Integer> dico = new Hashtable<String,Integer>();
      dico.put("and", sym.AND);
      dico.put("array", sym.ARRAY);
      dico.put("begin", sym.BEGIN);
      dico.put("div", sym.DIV);
      dico.put("do", sym.DO);
      dico.put("downto", sym.DOWNTO);
      dico.put("end", sym.END);
      dico.put("else", sym.ELSE);
      dico.put("for", sym.FOR);
      dico.put("if", sym.IF);
      dico.put("mod", sym.MOD);
      dico.put("new_line", sym.NEW_LINE);
      dico.put("not", sym.NOT);
      dico.put("null", sym.NULL);
      dico.put("of", sym.OF);
      dico.put("or", sym.OR);
      dico.put("program", sym.PROGRAM);
      dico.put("read", sym.READ);
      dico.put("then", sym.THEN);
      dico.put("to", sym.TO);
      dico.put("while", sym.WHILE);
      dico.put("write", sym.WRITE);
      return dico;
   }

   /**
    * Le numéro de la ligne courante.
    */
   int numLigne() {
      return yyline + 1;
   }

   private Symbol symbol(int code_lexeme) {
      return new Symbol(code_lexeme, numLigne(), 0);
   }

   private Symbol symbol(int code_lexeme, Object value) {
      return new Symbol(code_lexeme, numLigne(), 0, value);
   }

   /**
    * Convertit un code de lexème en String correspondante.
    */
   static String toString(int code_lexeme) {
      switch (code_lexeme) {
         case sym.IDF: 
            return "IDF";
         case sym.CONST_ENT:
            return "CONST_ENT";
         case sym.CONST_REEL:
            return "CONST_REEL";
         case sym.CONST_CHAINE:
            return "CONST_CHAINE";
         case sym.AND:
            return "AND";
         case sym.ARRAY:
            return "ARRAY";
         case sym.BEGIN:
            return "BEGIN";
         case sym.DIV:
            return "DIV";
         case sym.DO:
            return "DO";
         case sym.DOWNTO:
            return "DOWNTO";
         case sym.ELSE:
            return "ELSE";
         case sym.END:
            return "END";
         case sym.FOR:
            return "FOR";
         case sym.IF:
            return "IF";
         case sym.MOD:
            return "MOD";
         case sym.NEW_LINE:
            return "NEW_LINE";
         case sym.NOT:
            return "NOT";
         case sym.NULL:
            return "NULL";
         case sym.OF:
            return "OF";
         case sym.OR:
            return "OR";
         case sym.PROGRAM:
            return "PROGRAM";
         case sym.READ:
            return "READ";
         case sym.THEN:
            return "THEN";
         case sym.TO:
            return "TO";
         case sym.WHILE:
            return "WHILE";
         case sym.WRITE:
            return "WRITE";
         case sym.INF:
            return "INF";
         case sym.SUP:
            return "SUP";
         case sym.EGAL:
            return "EGAL";
         case sym.DIFF:
            return "DIFF";
         case sym.INF_EGAL:
            return "INF_EGAL";
         case sym.SUP_EGAL:
            return "SUP_EGAL";
         case sym.PLUS:
            return "PLUS";
         case sym.MOINS:
            return "MOINS";
         case sym.MULT:
            return "MULT";
         case sym.DIV_REEL:
            return "DIV_REEL";
         case sym.PAR_OUVR:
            return "PAR_OUVR";
         case sym.PAR_FERM:
            return "PAR_FERM";
         case sym.DOUBLE_POINT:
            return "DOUBLE_POINT";
         case sym.DEUX_POINTS:
            return "DEUX_POINTS";
         case sym.VIRGULE:
            return "VIRGULE";
         case sym.POINT_VIRGULE:
            return "POINT_VIRGULE";
         case sym.CROCH_OUVR:
            return "CROCH_OUVR";
         case sym.CROCH_FERM:
            return "CROCH_FERM";
         case sym.AFFECT:
            return "AFFECT";
         case sym.POINT:
            return "POINT";
         default:
            throw new ErreurInterneLexical(
               "Token inconnu dans toString(int code_lexeme)");
      }
   }


   /**
    * Convertit un lexème ("Symbole") en String correspondante.
    */
   static String toString(Symbol s) {
      String ts;
      switch (s.sym) {
         case sym.IDF:
            String nom = (String) s.value;
            ts = "(" + nom + ")";
            break;
         case sym.CONST_ENT:
            Integer n = (Integer) s.value;
            ts = "(" + n.intValue() + ")";
            break;
         case sym.CONST_REEL:
            Float f = (Float) s.value;
            ts = "(" + f.floatValue() + ")";
            break;
         case sym.CONST_CHAINE:
            String chaine = (String) s.value;
            ts = "(" + chaine + ")";
            break;

         default:
            ts = "";
      }
      return toString(s.sym) + ts + " " + s.left + ":" + s.right;
   }
%}

// -------------------------------------
// Définition des macros
// -------------------------------------

CHIFFRE        = [0-9]
LETTRE         = [a-zA-Z]

NUM	       = {CHIFFRE}+
DEC 	       = {NUM}"."{NUM}
EXP	       = "E" {SIGNE} {NUM} | "e" {SIGNE} {NUM}

INT	       = {NUM}
REEL	       = {DEC}|({DEC}{EXP})
SIGNE	       = "+"| "-"| ""

IDF	       = {LETTRE}({LETTRE}|{CHIFFRE}|"_")*

CHAINE_CAR     = [^\"]
CHAINE         = "\""({CHAINE_CAR}|"\"\"")* "\""

COMMENTAIRE    = "--"(.)*"\n"

%%

// ---------------------------
// Debut de la partie "regles"
// ---------------------------

[ \t]+                 { }

\n                     { }

COMMENTAIRE {}

{CHAINE} 	{ return symbol(sym.CONST_CHAINE, new String((yytext().substring(1,yytext().toString().length()-1))) );}

{IDF} 	    { return symbol(sym.IDF, yytext()); }
        
("a"|"A")("n"|"N")("d"|"D") { return symbol(sym.AND); }

("a"|"A")("r"|"R")("r"|"R")("a"|"A")("y"|"Y") { return symbol(sym.ARRAY); }

("b"|"B")("e"|"E")("g"|"G")("i"|"I")("n"|"N") { return symbol(sym.BEGIN); }

("d"|"D")("i"|"I")("v"|"V") { return symbol(sym.DIV); }

("d"|"D")("o"|"O") { return symbol(sym.DO); }

("d"|"D")("o"|"O")("w"|"W")("n"|"N")("t"|"T")("o"|"O") { return symbol(sym.DOWNTO); }

("e"|"E")("n"|"N")("d"|"D") { return symbol(sym.END); }

("e"|"E")("l"|"L")("s"|"S")("e"|"E") { return symbol(sym.ELSE); }

("f"|"F")("o"|"O")("r"|"R") { return symbol(sym.FOR); }

("i"|"I")("f"|"F")    { return symbol(sym.IF); }

("m"|"M")("o"|"O")("d"|"D") { return symbol(sym.MOD); }

("n"|"N")("e"|"E")("w"|"W")"_"("l"|"L")("i"|"I")("n"|"N")("e"|"E") { return symbol(sym.NEW_LINE); }

("n"|"N")("o"|"O")("t"|"T") { return symbol(sym.NOT); }

("n"|"N")("u"|"U")("l"|"L")("l"|"L") { return symbol(sym.NULL); }

("o"|"O")("f"|"F") { return symbol(sym.OF); }

("o"|"O")("r"|"R") { return symbol(sym.OR); }

("p"|"P")("r"|"R")("o"|"O")("g"|"G")("r"|"R")("a"|"A")("m"|"M") { return symbol(sym.PROGRAM); }

("r"|"R")("e"|"E")("a"|"A")("d"|"D") { return symbol(sym.READ); }

("t"|"T")("h"|"H")("e"|"E")("n"|"N") { return symbol(sym.THEN); }

("t"|"T")("o"|"O") { return symbol(sym.TO); }

("w"|"W")("h"|"H")("i"|"I")("l"|"L")("e"|"E") { return symbol(sym.WHILE); }

("w"|"W")("r"|"R")("i"|"I")("t"|"T")("e"|"E") { return symbol(sym.WRITE); }


{INT}     { try { 
                 return symbol(sym.CONST_ENT, 
                               new Integer(yytext())); 
               } catch (NumberFormatException e) {
                  // Ici : Afficher message d’erreur
                   { System.out.println("Erreur Lexicale : depassement de limite entier ligne " + 
                            numLigne()) ;
                         throw new ErreurLexicale() ; }
              }
              }
                            
{REEL}		{ try {
		return symbol(sym.CONST_REEL, 
			      new Float(yytext()));
		} catch (NumberFormatException e) {
                  // Ici : Afficher message d’erreur
                   { System.out.println("Erreur Lexicale : depassement de limite reel ligne " + 
                            numLigne()) ;
                         throw new ErreurLexicale() ; }
              }
              }

":=" 			{ return symbol(sym.AFFECT); }

".." 			{ return symbol(sym.DOUBLE_POINT); }
 
"<"     		{ return symbol(sym.INF); }      

">" 			{ return symbol(sym.SUP); }

"=" 			{ return symbol(sym.EGAL); }

"+" 			{ return symbol(sym.PLUS); }

"-" 			{ return symbol(sym.MOINS); }

"*" 			{ return symbol(sym.MULT); }

"/" 			{ return symbol(sym.DIV); }

"." 			{ return symbol(sym.POINT); }

"[" 			{ return symbol(sym.CROCH_OUVR); }

"]" 			{ return symbol(sym.CROCH_FERM); }

"," 			{ return symbol(sym.VIRGULE); }

":" 			{ return symbol(sym.DEUX_POINTS); }

"(" 			{ return symbol(sym.PAR_OUVR); }

")" 			{ return symbol(sym.PAR_FERM); }

";" 			{ return symbol(sym.POINT_VIRGULE); }              

"/=" 			{ return symbol(sym.DIFF); }

">=" 			{ return symbol(sym.SUP_EGAL); }

"<=" 			{ return symbol(sym.INF_EGAL); }

.                      { System.out.println("Erreur Lexicale : '" +
                            yytext() + "' non reconnu ... ligne " + 
                            numLigne()) ;
                         throw new ErreurLexicale() ; }


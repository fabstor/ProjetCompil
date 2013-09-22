package ProjetCompil.Global.Src;

/**
 * Le type des différentes natures d'un type.
 */

public enum NatureType {
   String,
   Boolean,
   Real,
   Interval, 
   Array;

   /**
    * Affichage d'une nature de type.
    */
   public String toString() {
      return "NatureType." + super.toString();
   }
}


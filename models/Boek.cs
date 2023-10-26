using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Linq;

namespace models
{
    public class Boek
    {
        public Auteur Auteur { get; set; }
        public string Beschrijving { get; set; }
        public string ibnNummer { get; set; }
        public int Id { get; set; }
        public Illustrator Illustrator { get; set; }
        public string Titel { get; set; }

        public Boek()
        {
        }

        public Boek(string titel, string ibnNummer, string beschrijving, Auteur auteur, Illustrator illustrator)
        {
            Auteur = auteur;
            Beschrijving = beschrijving;
            this.ibnNummer = ibnNummer;
            Illustrator = illustrator;
            Titel = titel;
        }

        public string ToonDetails()
        {
            return $"{Titel}\n\n-Auteur: {Auteur}\n\n-Illustrator: {Illustrator}\n\n" +
                    $"-ISBN-Nummer: {ibnNummer}\n\n-Beschrijving:\n{Beschrijving}";
        }

        public override string ToString()
        {
            return $"{Titel}\n-Auteur: {Auteur},\n-Illustrator: {Illustrator}";
        }
    }
}
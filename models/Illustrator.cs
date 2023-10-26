using System;
using System.Collections.Generic;
using System.Text;

namespace models
{
    public class Illustrator
    {
        public int Geboortejaar { get; set; }
        public int Id { get; set; }
        public string Naam { get; set; }
        public string Voornaam { get; set; }

        public override string ToString()
        {
            return $"{Voornaam} {Naam}\n(Geboortejaar: {Geboortejaar})";
        }
    }
}
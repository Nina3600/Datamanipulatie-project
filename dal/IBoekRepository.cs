using System;
using System.Collections.Generic;
using System.Text;
using models;

namespace dal
{
    public interface IBoekRepository
    {
        //Methodes declareren die we in de repositories gaan uitwerken
        public bool BewerkenBoek(Boek boek);

        public IEnumerable<Auteur> OphalenAuteurs();

        public IEnumerable<Boek> OphalenBoeken();

        public IEnumerable<Boek> OphalenGefilterdeBoeken(string titel);

        public IEnumerable<Illustrator> OphalenIllustrators();

        public bool ToevoegenBoek(Boek boek);

        public bool VerwijderenBoek(int id);
    }
}
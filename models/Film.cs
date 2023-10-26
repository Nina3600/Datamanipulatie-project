using System;
using System.Collections.Generic;
using System.Text;

namespace models
{
    public class Film
    {
        public Genre Genre { get; set; }
        public int Id { get; set; }
        public string Inhoud { get; set; }
        public DateTime ProductieDatum { get; set; }
        public string Titel { get; set; }
        public DateTime UitgaveDatum { get; set; }

        public Film(string titel, DateTime productieDatum, DateTime uitgaveDatum, Genre genre, string inhoud)
        {
            Genre = genre;
            Inhoud = inhoud;
            ProductieDatum = productieDatum;
            Titel = titel;
            UitgaveDatum = uitgaveDatum;
        }

        public Film()
        {
        }

        public string ToonDetails()
        {
            return $"{Titel}\n\n-Genre: {Genre}\n\n-Productiedatum: {ProductieDatum}\n\n" +
                    $"-Uitgavedatum: {UitgaveDatum}\n\n-Inhoud:\n{Inhoud}";
        }

        public override string ToString()
        {
            return $"{Titel}\n(Genre: {Genre})";
        }
    }
}
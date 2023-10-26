using models;
using System;
using System.Collections.Generic;
using System.Text;

namespace dal
{
    public interface IFilmRepository
    {
        //Methodes declareren die we in de repositories gaan uitwerken
        public bool BewerkenFilm(Film film);

        public IEnumerable<Film> OphalenFilms();

        public IEnumerable<Film> OphalenGefilterdeFilms(string titel);

        public IEnumerable<Genre> OphalenGenres();

        public bool ToevoegenFilm(Film film);

        public bool VerwijderenFilm(int id);
    }
}
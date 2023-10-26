using models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using Dapper;
using System.Linq;
using System.Security.Policy;

namespace dal
{
    public class FilmRepository : BaseRepository, IFilmRepository
    {
        public bool BewerkenFilm(Film film)
        {
            //SQL query
            string sql = @"UPDATE HarryPotter.Films SET titel = @titel,
                                            productieDatum = @productieDatum,
                                            inhoud = @inhoud,
                                            genreId = @genreId,
                                            uitgaveDatum = @uitgaveDatum
                          WHERE id = @id";

            //Parameters declareren
            var parameters = new
            {
                @id = film.Id,
                @titel = film.Titel,
                @productieDatum = film.ProductieDatum,
                @inhoud = film.Inhoud,
                @genreId = film.Genre.Id,
                @uitgavedatum = film.UitgaveDatum
            };

            //Connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert true als er één rij wordt beïnvloed, anders retourneert het false
                var affectedRows = db.Execute(sql, parameters);
                if (affectedRows == 1)
                {
                    return true;
                }
            }

            return false;
        }

        public IEnumerable<Film> OphalenFilms()
        {
            //SQL query
            string sql = @"SELECT f.*, '' AS SplitCol, g.*
                            FROM HarryPotter.Films f
					        INNER JOIN HarryPotter.Genre g ON f.genreId = g.id
                            ORDER BY uitgaveDatum;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Film-objecten, waarbij elk Film-object is gekoppeld aan bijbehorende
                //Genre-objecten op basis van de queryresultaten
                return db.Query<Film, Genre, Film>(
                    sql,
                    (film, genre) =>
                    {
                        film.Genre = genre;
                        return film;
                    },
                    splitOn: "SplitCol" //Splitsing tussen de verschillende kolommen
                    );
            }
        }

        public IEnumerable<Film> OphalenGefilterdeFilms(string titel)
        {
            //SQL query
            string sql = @"SELECT f.*, '' AS SplitCol, g.*
                            FROM HarryPotter.Films f
					        INNER JOIN HarryPotter.Genre g ON f.genreId = g.id
                            WHERE f.titel LIKE '%' + @titel + '%'
                            ORDER BY uitgaveDatum;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Film-objecten, waarbij elk Film-object is gekoppeld aan bijbehorende
                //Genre-objecten op basis van de queryresultaten
                return db.Query<Film, Genre, Film>(
                    sql,
                    (film, genre) =>
                    {
                        film.Genre = genre;
                        return film;
                    },
                    new { @titel = titel },
                    splitOn: "SplitCol" //Splitsing tussen de verschillende kolommen
                    );
            }
        }

        public IEnumerable<Genre> OphalenGenres()
        {
            //SQL query
            string sql = @"SELECT * FROM HarryPotter.Genre ORDER BY naam;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Genre-objecten die overeenkomen met de resultaten van de query
                return db.Query<Genre>(sql).ToList();
            }
        }

        public bool ToevoegenFilm(Film film)
        {
            //SQL query
            string sql = @"INSERT INTO HarryPotter.Films(titel, productieDatum, inhoud, genreId, uitgaveDatum)
                            VALUES (@titel, @productieDatum, @inhoud, @genreId, @uitgaveDatum);";

            //Parameters declareren
            var parameters = new
            {
                @titel = film.Titel,
                @productieDatum = film.ProductieDatum,
                @inhoud = film.Inhoud,
                @genreId = film.Genre.Id,
                @uitgaveDatum = film.UitgaveDatum
            };

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert true als er één rij wordt beïnvloed, anders retourneert het false
                var affectedRows = db.Execute(sql, parameters);

                if (affectedRows == 1)
                {
                    return true;
                }

                return false;
            }
        }

        public bool VerwijderenFilm(int id)
        {
            //SQL query
            string sql = @"DELETE FROM HarryPotter.Films WHERE id = @id;";

            //Parameters declareren
            var parameters = new { @id = id };

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert true als er één of meerdere rijen worden beïnvloed, anders retourneert het false
                var affectedRows = db.Execute(sql, parameters);

                if (affectedRows >= 1)
                {
                    return true;
                }

                return false;
            }
        }
    }
}
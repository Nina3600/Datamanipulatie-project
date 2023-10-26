using Dapper;
using models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace dal
{
    public class BoekRepository : BaseRepository, IBoekRepository
    {
        public bool BewerkenBoek(Boek boek)
        {
            //SQL query
            string sql = @"UPDATE HarryPotter.Boeken SET titel = @titel,
                                            ibnNummer = @ibnNummer,
                                            beschrijving = @beschrijving,
                                            auteurId = @auteurId,
                                            illustratorId = @illustratorId
                          WHERE id = @id";

            //Parameters declareren
            var parameters = new
            {
                @id = boek.Id,
                @titel = boek.Titel,
                @ibnNummer = boek.ibnNummer,
                @beschrijving = boek.Beschrijving,
                @auteurId = boek.Auteur.Id,
                @illustratorId = boek.Illustrator.Id
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

        public IEnumerable<Auteur> OphalenAuteurs()
        {
            //SQL query
            string sql = @"SELECT * FROM HarryPotter.Auteur ORDER BY naam;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Auteur-objecten die overeenkomen met de resultaten van de query
                return db.Query<Auteur>(sql).ToList();
            }
        }

        public IEnumerable<Boek> OphalenBoeken()
        {
            //SQL query
            string sql = @"SELECT b.*, '' AS Splitcol, a.*, '' AS SplitCol, i.*
                            FROM HarryPotter.Boeken b
                            INNER JOIN HarryPotter.Illustrator i ON i.id = b.illustratorId
                            INNER JOIN HarryPotter.Auteur a ON b.auteurId = a.id
                            ORDER BY b.id;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Boek-objecten, waarbij elk Boek-object is gekoppeld aan bijbehorende
                //Auteur- en Illustrator-objecten op basis van de queryresultaten
                return db.Query<Boek, Auteur, Illustrator, Boek>(
                    sql,
                    (boek, auteur, illustrator) =>
                    {
                        boek.Auteur = auteur;
                        boek.Illustrator = illustrator;
                        return boek;
                    },
                    splitOn: "SplitCol" //Splitsing tussen de verschillende kolommen
                    );
            }
        }

        public IEnumerable<Boek> OphalenGefilterdeBoeken(string titel)
        {
            //SQL query
            string sql = @"SELECT b.*, '' AS Splitcol, a.*, '' AS SplitCol, i.*
                            FROM HarryPotter.Boeken b
                            INNER JOIN HarryPotter.Illustrator i ON i.id = b.illustratorId
                            INNER JOIN HarryPotter.Auteur a ON b.auteurId = a.id
                            WHERE b.titel LIKE '%' + @titel + '%'
                            ORDER BY b.id;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Boek-objecten, waarbij elk Boek-object is gekoppeld aan bijbehorende
                //Auteur- en Illustrator-objecten op basis van de queryresultaten
                return db.Query<Boek, Auteur, Illustrator, Boek>(
                    sql,
                    (boek, auteur, illustrator) =>
                    {
                        boek.Auteur = auteur;
                        boek.Illustrator = illustrator;
                        return boek;
                    },
                    new { @titel = titel },
                    splitOn: "SplitCol" //Splitsing tussen de verschillende kolommen
                    );
            }
        }

        public IEnumerable<Illustrator> OphalenIllustrators()
        {
            //SQL query
            string sql = @"SELECT * FROM HarryPotter.Illustrator ORDER BY naam;";

            //Sql connectie met de database
            using (IDbConnection db = new SqlConnection(ConnectionString))
            {
                //Retourneert een lijst van Illustrator-objecten die overeenkomen met de resultaten van de query
                return db.Query<Illustrator>(sql).ToList();
            }
        }

        public bool ToevoegenBoek(Boek boek)
        {
            //SQL query
            string sql = @"INSERT INTO HarryPotter.Boeken(titel, ibnNummer, beschrijving, auteurId, illustratorId)
                            VALUES (@titel, @ibnNummer, @beschrijving, @auteurId, @illustratorId);";

            //Parameters declareren
            var parameters = new
            {
                @titel = boek.Titel,
                @ibnNummer = boek.ibnNummer,
                @beschrijving = boek.Beschrijving,
                @auteurId = boek.Auteur.Id,
                @illustratorId = boek.Illustrator.Id
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

        public bool VerwijderenBoek(int id)
        {
            //SQL query
            string sql = @"DELETE FROM HarryPotter.Boeken WHERE id = @id;";

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
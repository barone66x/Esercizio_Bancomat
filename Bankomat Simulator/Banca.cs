using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static BankomatSimulator.ContoCorrente;

namespace BankomatSimulator
{

    class Banca
    {
        public Banca(Banche data)
        {
            _utenti = new List<Utente>();
            _funzionalita = new SortedList<int, Funzionalita>();
            _nome = data.Nome;
            int key = 0;
            foreach (var item in data.Utentis)
            {

                Utente utente = new Utente(item);

                _utenti.Add(utente);

            }

            foreach (var fun in data.Banche_Funzionalita)
            {
                Funzionalita funzionalita = Funzionalita.Uscita;
                key++;

                long test = fun.IdFunzionalita;
                var test2 = fun.Funzionalita;
                if (fun.Funzionalita.Nome.Equals("Versamento"))
                {
                    funzionalita = Funzionalita.Versamento;
                }
                else if (fun.Funzionalita.Nome.Equals("Prelievo"))
                {
                    funzionalita = Funzionalita.Prelievo;
                }
                else if (fun.Funzionalita.Nome.Equals("ReportSaldo"))
                {
                    funzionalita = Funzionalita.ReportSaldo;
                }
                else if (fun.Funzionalita.Nome.Equals("RegistroOperazioni"))
                {
                    funzionalita = Funzionalita.RegistroOperazioni;
                }

                _funzionalita.Add(key, funzionalita);



            }

        }

        public Banca()
        {

        }


        public enum Funzionalita
        {
            Versamento, //= 2,
            Prelievo, //= 3,
            ReportSaldo,// = 3,
            Sblocco,
            RegistroOperazioni,// = 4,
            Uscita //= 5,
        }


        public enum EsitoLogin
        {
            AccessoConsentito,
            UtentePasswordErrati,
            PasswordErrata,
            AccountBloccato
        }


        private string _nome;
        private List<Utente> _utenti;
        private SortedList<int, Funzionalita> _funzionalita;


        private Utente _utenteCorrente;

        public string Nome { get => _nome; set => _nome = value; }

        public List<Utente> Utenti { get => _utenti; set => _utenti = value; }
        public Utente UtenteCorrente { get => _utenteCorrente; set => _utenteCorrente = value; }
        public SortedList<int, Funzionalita> ElencoFunzionalita { get => _funzionalita; set => _funzionalita = value; }

        /// <summary>
        /// Verifica che sia presente un utente con NomeUtente uguale a quello indicato
        /// e, nel caso, verifica la password.
        /// </summary>
        /// <param name="credenziali">Dati inseriti dall'utente </param>
        /// <returns></returns>
        public EsitoLogin Login(Utenti credenziali, out Utente utente)
        {
            Utente utenteDaValidare = null;
            //ricerco utente sul 
            utente = null;

            foreach (var elem in Utenti)
            {
                if (elem.NomeUtente == credenziali.NomeUtente)
                {
                    utenteDaValidare = elem;
                    break;
                }
            }
            if (utenteDaValidare == null)
            {
                return EsitoLogin.UtentePasswordErrati;
            }


            if (credenziali.Password != utenteDaValidare.Password)
            {
                utente = utenteDaValidare;
                utenteDaValidare.TentativiDiAccessoErrati++;
                if (utenteDaValidare.Bloccato)
                {
                    return EsitoLogin.AccountBloccato;
                }
                return EsitoLogin.PasswordErrata;
            }
            else
            {
                utente = utenteDaValidare;
                if (utenteDaValidare.Bloccato)
                {
                    return EsitoLogin.AccountBloccato;
                }
                utenteDaValidare.TentativiDiAccessoErrati = 0;
                return EsitoLogin.AccessoConsentito;
            }
        }



    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankomatSimulator
{
    public class Utente
    {
        public Utente(Utenti data)
        {

            _nomeUtente = data.NomeUtente;
            _password = data.Password;
            _contoCorrente = new ContoCorrente(data.ContiCorrentes.First());
        }
        private string _nomeUtente;
        private string _password;
        private int _tentativiDiAccessoErrati = 0;
        private bool _bloccato = false;
        private const int _tentativiDiAccessoPermessi = 3;
        private ContoCorrente _contoCorrente;
        public string NomeUtente { get => _nomeUtente; set => _nomeUtente = value; }
        public string Password { get => _password; set => _password = value; }
        public bool Bloccato { get => _bloccato; }

        public ContoCorrente contoCorrente { get => _contoCorrente; set => _contoCorrente = value; }

        public int TentativiDiAccessoResidui
        {
            get
            {
                return _tentativiDiAccessoPermessi - _tentativiDiAccessoErrati;
            }
        }
        public int TentativiDiAccessoErrati
        {
            get => _tentativiDiAccessoErrati;
            set
            {
                _tentativiDiAccessoErrati = value;
                if (_tentativiDiAccessoErrati >= _tentativiDiAccessoPermessi)
                {
                    _bloccato = true;
                }
            }
        }
    }
}

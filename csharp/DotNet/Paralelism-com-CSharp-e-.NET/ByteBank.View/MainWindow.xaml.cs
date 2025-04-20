using ByteBank.Core.Model;
using ByteBank.Core.Repository;
using ByteBank.Core.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ByteBank.View
{
    public partial class MainWindow : Window
    {
        private readonly ContaClienteRepository r_Repositorio;
        private readonly ContaClienteService r_Servico;
        private CancellationTokenSource cts;

        public MainWindow()
        {
            InitializeComponent();

            r_Repositorio = new ContaClienteRepository();
            r_Servico = new ContaClienteService();
        }

        private void BtnCancelar_Click(object sender, RoutedEventArgs e)
        {
            BtnCancelar.IsEnabled = false;
            cts.Cancel();
        }

        private async void BtnProcessar_Click(object sender, RoutedEventArgs e)
        {
            var contas = r_Repositorio.GetContaClientes();

            cts = new CancellationTokenSource();

            PrepareView(contas.Count());
            
            var progress = new Progress<string>((_) => {
                PgrBar.Value++; 
            });
            List<string> resultado = new List<string>();

            var inicio = DateTime.Now;
            try
            {
                resultado = (await ConsolidaTodasMovimentacoes(
                                contas,
                                ct: cts.Token,
                                progress: progress
                            )).ToList();

                var fim = DateTime.Now;
                ShowResults(resultado, fim - inicio);
            }
            catch (OperationCanceledException ex)
            {
                TxtTempo.Text = "Processo cancelado pelo usuário.";
                TxtTempo.Visibility = Visibility.Visible;
            }
            finally
            {
                PgrBar.Visibility = Visibility.Hidden;
                BtnProcessar.IsEnabled = true;
                BtnCancelar.IsEnabled = false;
            }


        }

        private void PrepareView(int numContas)
        {
            TxtTempo.Visibility = Visibility.Hidden;
            TxtTempo.Text = "";

            BtnCancelar.IsEnabled = true;
            BtnProcessar.IsEnabled = false;
            LstResultados.ItemsSource = new List<string>();
            
            PgrBar.Value = 0;
            PgrBar.Visibility = Visibility.Visible;
            PgrBar.Maximum = numContas;
        }

        private Task<string[]> ConsolidaTodasMovimentacoes(IEnumerable<ContaCliente> contas, CancellationToken ct, IProgress<string> progress)
        {
            var threads = contas.Select(conta => Task.Factory.StartNew(() =>
            {
                ct.ThrowIfCancellationRequested();

                var result =  r_Servico.ConsolidarMovimentacao(conta, ct);
                progress.Report(result);

                ct.ThrowIfCancellationRequested();

                return result;

            }, cancellationToken: ct));

            return Task.WhenAll(threads);
        }

        private void ShowResults(List<String> result, TimeSpan elapsedTime)
        {

            var tempoDecorrido = $"{ elapsedTime.Seconds }.{ elapsedTime.Milliseconds} segundos!";
            var mensagem = $"Processamento de {result.Count} clientes em {tempoDecorrido}";
            
            LstResultados.ItemsSource = result;
            TxtTempo.Visibility = Visibility.Visible;
            TxtTempo.Text = mensagem;

        }
    }
}

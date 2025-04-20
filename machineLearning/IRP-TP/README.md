# IRP-TP
Algoritmos usados para a classificação de imagens. Utiliza a linguagem R e implementa três métodos: Bayes, KDE e CNN. O problema foi proposto por um tabalho da matéria de Introdução à Reconhecimento de Padrões da UFMG.

## Descrição do repositório
* `trainReduzido.csv` : Amostras para treinamento
* `validacao.csv`: Amostras para validação
* `porKDE.R`: Código em R que aplica o método KDE para solução do problema de classificação
* `porBayes.R`: Código em R que aplica o método Bayes para solução do problema de classificação
* `porCNN.R`: Código em R que aplica o método CNN para solução do problema de classificação
* `output.csv`: Classificaçã do conjunto de validação utilizando a técnica CNN. Este arquivo será utilizado para a classificação da equipe na competição.

## Especificação do trabalho
O trabalho deve ser feito em grupos de até 3 pessoas. Cada grupo vai competir com os demais grupos da sala para resolverem este problema de reconhecimento de padrões.

O grupo deverá propor uma solução para o problema de reconhecimento de padrões aplicando um ou mais métodos aprendidos em sala de aula. O grupo também deverá tentar melhorar o desempenho do método proposto inserindo alguma técnica encontrada na literatura ou propondo alguma inovação na metodologia aplicada.  

O grupo deve entregar um relatório em pdf, no formato de duas colunas, contendo os seguintes itens:

1) Descrição do problema a ser resolvido. 

2) Revisão bibliográfica sobre o assunto. O grupo deve pesquisar o estado da arte do assunto hoje, ou seja, o que tem sido feito hoje para a solução deste tipo de problema. Deve incluir neste item uma revisão sobre o método visto em sala de aula que foi escolhido para resolver o problema. Como o grupo deve procurar na literatura o que pode ser feito para melhorar o desempenho do método visto em sala de aula, a revisão também deve conter explicações sobre essas técnicas.

3) Metodologia utilizada. Neste item o grupo deve explicar como utilizou o método visto em sala de aula, que foi escolhido para resolver o problema. Deve explicar também que outra técnica (ou técnicas) e como foram aplicadas em conjunto com o método escolhido para melhorar seu desempenho. Se vocês vão propor alguma inovação para a melhoria do desempenho, criem aqui um subitem explicando a proposta.

4) Descrição dos dados. Neste item o grupo deve descrever a estrutura do banco de dados e suas variáveis.

5) Experimentos. Neste item o grupo deve projetar as simulações levando em conta o que foi aprendido em sala de aula. Lembre-se de utilizar a técnica de validação cruzada para você poder concluir corretamente sobre a generalização da rede. Explique com detalhes como os experimentos serão executados.

6) Resultados. Apresente aqui os resultados, gráficos e as discussões que se fizerem necessárias sobre eles. Sobretudo, a acurácia no conjunto de treinamento/teste.

7) Conclusão. Escreva as conclusões sobre o seu trabalho.

8) Os alunos devem enviar também o arquivo CSV de classificação do conjunto de validação conforme o arquivo "sample_submission.csv". Este arquivo será utilizado para a classificação da equipe na competição. A equipe que acertar mais neste conjunto ganha o prếmio máximo que será 5 pontos extras. O segundo lugar receberá 2 pontos extras e o terceiro receberá 1 ponto extra.



#### Critérios de avaliação:

- Qualidade do trabalho. Trabalho bem feitos serão melhores avaliados;

- Nível de profundidade da solução .  

- Resultados do trabalho (Sobretudo a acurácia). Resultados positivos já falam por si só, mas resultados negativos devem ser bem discutidos para não prejudicar a avaliação;

- Qualidade do texto;

- PRAZO: trabalhos entregues fora do prazo serão penalizados.



#### Dados
Os arquivos de dados trainReduzido.csv e validacao.csv contêm imagens em escala de cinza de dígitos desenhados à mão, de zero a nove.

Cada imagem tem 28 pixels de altura e 28 pixels de largura, para um total de 784 pixels no total. Cada pixel tem um único valor de pixel associado a ele, indicando a claridade ou escuridão desse pixel, com números mais altos significando mais escuro. Este valor de pixel é um número inteiro entre 0 e 255, inclusive.

O conjunto de dados de treinamento, (trainReduzido.csv), tem 785 colunas. A primeira coluna, chamada de "rótulo", é o dígito que foi desenhado pelo usuário. O restante das colunas contém os valores de pixel da imagem associada.

Cada coluna de pixel no conjunto de treinamento tem um nome como pixelx, onde x é um número inteiro entre 0 e 783, inclusive. Para localizar este pixel na imagem, suponha que tenhamos decomposto x como x = i * 28 + j, onde i e j são inteiros entre 0 e 27, inclusive. Então pixelx está localizado na linha i e coluna j de uma matriz 28 x 28, (indexação por zero).

Por exemplo, pixel31 indica o pixel que está na quarta coluna da esquerda e na segunda linha do topo, como no diagrama ascii abaixo.

Visualmente, se omitirmos o prefixo "pixel", os pixels formarão a imagem assim:

```
000 001 002 003 ... 026 027
028 029 030 031 ... 054 055
056 057 058 059 ... 082 083
 |   |   |   |  ...  |   |
728 729 730 731 ... 754 755
756 757 758 759 ... 782 783 
```
Com este arquivo o grupo deve treinar e testar seu modelo usando técnicas como validação cruzada por exemplo.

O conjunto de dados de validação, (validacao.csv), é igual ao conjunto de treinamento, exceto que não contém a coluna "rótulo".

Seu arquivo de envio deve estar no seguinte formato: Para cada uma das 4.000 imagens no conjunto de validação, imprima uma única linha contendo o ImageId (linha do arquivo de validação) e o dígito previsto. Por exemplo, se você prever que a primeira imagem é de 3, a segunda imagem é de 7 e a terceira imagem é de 8, então seu arquivo de envio seria assim:

```
ImageId,Label
1,3
2,7
3,8 
(3997 more lines)
```


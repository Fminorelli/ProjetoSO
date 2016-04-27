% Guia para as atividades do JOS
% Felipe Torres Minorelli


Nestes tutoriais teremos como objetivo o estudo do booting e gerenciamento de memoria do JOS, um sistema operacional desenvolvido por estudantes do MIT. O estudo sera feito através de analises de partes do código ja implementadas pelos criadores do SO, e implementações de partes essenciais para o funcionamento do sistema.


# [**LAB 1**](https://pdos.csail.mit.edu/6.828/2014/labs/lab1/)

**Este lab é dividido em três partes, onde a primeira é responsável pela familiarização com as ferramentas utilizadas na simulação e das linguagens a serem utilizadas, a segunda tem como foco o boot  do sistema, e a terceira da inicio ao estudo do kernel.**

**Este lab pode ser acessado em [https://pdos.csail.mit.edu/6.828/2014/labs/lab1/](https://pdos.csail.mit.edu/6.828/2014/labs/lab1/).**

## Parte 1

  Dando inicio ao lab, a primeira parte é constituída, em sua maioria, por teoria.  Conta com documentações sobre assembly, uma breve introdução sobre memoria e arquitetura dos primeiros PCs, arquitetura que até hoje é utilizada na maioria dos PCs, e uma breve explicação sobre a BIOS, como esta é armazenada e executada durante a inicialização do sistema.

  Para a execução dos exercícios, utilizaremos o qemu, um emulador de sistemas operacionais que facilitará nosso desenvolvimento, pois através dele emularemos o SO e com a ajuda do GDB sera possível a analise dos acontecimentos em tempo de execução. Muitos exercícios deste lab requerem a analise de instruções durante o boot do SO, portanto é recomendado a leitura da documentação do qemu [http://wiki.qemu.org/Main_Page](http://wiki.qemu.org/Main_Page) e do GDB [http://www.gnu.org/software/gdb/](http://www.gnu.org/software/gdb/).

  Devido a grande quantidade de teoria, esta parte requer atenção durante sua leitura, pois apresenta informações e conceitos que serão utilizados futuramente. A falta de exercícios práticos torna esta seção um pouco cansativa, mas como dito anteriormente, dados aqui apresentados serão de grande uso nos próximos exercícios.

## Parte 2

  Dando sequencia a primeira parte, nesta seção o foco é o boot do sistema. Os exercícios aqui encontrados são referentes a analise das instruções do boot via GDB, carregamento do kernel, e compreensão do formato ELF.

<!-- O que você precisou aprender pra fazer estes exercícios? Explique os conceitos que se mostraram os maiores obstáculos. Divida as explicações por exercício, usando uma nova subseção por exercício. Claro, se o exercício não tem grandes desafios, ou vc já explicou o desafio anteriormente, não é necessário repetir.-->

  Apesar de bem explicativa, esta parte introduz conceitos do formato ELF que podem se mostrar confusos a iniciantes no assunto. A desmontagem dos arquivos do kernel, e do boot com o comando objdump apresentam resultados de difícil interpretação devido a grande quantidade de informação resultante. Mas além deste obstáculo é possível concluir as instruções sem muitos problemas. Abaixo temos o exemplo do primeiro objdump solicitado:

    $objdump -h obj/kern/kernel

      obj/kern/kernel: formato do arquivo elf32-i386

      Seções:
      Idx Tamanho do Nome do Arquivo VMA LMA sem Algn
        0 .text         000037d5  f0100000  00100000  00001000  2**4
                        CONTENTS, ALLOC, LOAD, READONLY, CODE
        1 .rodata       000013b0  f0103800  00103800  00004800  2**6
                        CONTENTS, ALLOC, LOAD, READONLY, DATA
        2 .stab         00005e21  f0104bb0  00104bb0  00005bb0  2**2
                        CONTENTS, ALLOC, LOAD, READONLY, DATA
        3 .stabstr      00001d6f  f010a9d1  0010a9d1  0000b9d1  2**0
                        CONTENTS, ALLOC, LOAD, READONLY, DATA
        4 .data         0000a300  f010d000  0010d000  0000e000  2**12
                        CONTENTS, ALLOC, LOAD, DATA
        5 .bss          00000690  f0117300  00117300  00018300  2**6
                        ALLOC
        6 .comment      00000025  00000000  00000000  00018300  2**0
                        CONTENTS, READONLY


  Neste exemplo temos na primeira coluna todas as seções da ELF do arquivo selecionado, tais como a seção .text que contem todos os textos e instruções executáveis deste arquivo, e a .rodata que contem as informações que são somente de leitura. Mais informações sobre as divisões do formato ELF podem ser encontrados em [http://www.skyfree.org/linux/references/ELF_Format.pdf](http://www.skyfree.org/linux/references/ELF_Format.pdf) na seção Special Sections. Já na segunda coluna temos informações como o tamanho do conteúdo, localização destas informações e a quantidade de memoria ocupada por estas.  



<!-- Pq é de difícil interpretação? Seria legal explicar uma saída, por exemplo, para facilitar para a galera. Lembra, o nosso objetivo é suavizar os obstáculos hehe.

**** https://support.codebasehq.com/articles/tips-tricks/syntax-highlighting-in-markdown

-->

## Parte 3

Na terceira parte é dada continuidade a explicação sobre o mapeamento da memoria do sistema, introdução às funções de print, e pilha do sistema. Após a conclusão de cada teoria, teremos alguns exercícios práticos.

O primeiro exercício tem como intuito demostrar como é feita a implementação de um print, e como são feitas as chamadas no sistema. Durante a analise do printfmt.c podemos constatar como é feito o tratamento de cada parâmetro de um print, feito isso a conclusão do exercício, que requer uma impressão de um numero octal, se resume apenas a algumas linhas de código que se assemelham com a impressão de um decimal, porem com uma base diferente.

 Os dois seguintes exercícios tratam-se apenas da analise de código via GDB e analise do código do kernel, ambos com a intenção de nos familiarizar com os conceitos de pilha do kernel. Tenha em mente que os seguintes ponteiros utilizados na pilha do kernel serão de grande importância no próximo exercício:

    ESP: Ponteiro de pilha (aponta sempre para o topo da pilha)
    EBP: Ponteiro de base da pilha (aponta para a base da pilha do processo atual)
    EIP: Ponteiro de instrução (aponta para qual instrução do programa esta sendo executada no momento)

Com tais informações podemos partir para o exercicio 11. Aqui sua implementação deverá imprimir todas as funções executadas ate o momento da chamada da sua função. Pontos que podem ajudar sua implementação:

1. A base da pilha do kernel se encontra em 0x0.
2. Criar um EIP ira lhe ajudar a se localizar.
3. Existem funções como a read_ebp() e read_esp(), que facilitam a leitura dos registradores.
4. Uma soma subsequente de inteiros em EBP lhe mostrara as instruções seguintes.


# [**LAB 2**](https://pdos.csail.mit.edu/6.828/2014/labs/lab2/)

**No inicio deste Lab trabalharemos primeiramente com a alocação das paginas físicas, portanto as funções abaixo deveram ser implementadas.**

 A partir daqui trabalharemos com novos tipos de dados, tais como o PTE e PDE , para a compreensão do funcionamento dessas estruturas, e mais informações sobre a manipulação de memoria estude os capítulos 5 e 6 do [manual do Intel 386](https://pdos.csail.mit.edu/6.828/2014/readings/i386/toc.htm), principalmente os subcapítulos 5.2 e 6.4 que tratam do funcionamento das tabelas de memoria, e do gerenciamento de acesso de paginas.

**Este lab pode ser acessado em [https://pdos.csail.mit.edu/6.828/2014/labs/lab2/](https://pdos.csail.mit.edu/6.828/2014/labs/lab2/).**

## boot_alloc

  Nesta função após recebida a quantidade bytes a serem alocados, devemos separar paginas suficientes para estes.

  Para isto deveremos seguir os seguintes passos:

  1. Verificar o numero de bytes, caso seja 0, nenhuma pagina deve ser alocada.
  2. Verificar se há espaço para alocação.
  3. Separar o numero de paginas suficientes para os bytes solicitados, sempre arrendondando para o teto.
  4. Mover o ponteiro que indica qual a próxima posição livre após n paginas.
  5. Retornar este ponteiro.


## mem_init parte 1

  Aqui faremos a alocação do vetor responsável pelo controle das paginas físicas, sendo que em cada posição deste vetor se encontra uma estrutura PageInfo, a qual contem informações sobre cada pagina física.

  Dado que o SO utiliza um vetor chamado pages, teremos duas simples funções:

  1. Fazer a alocação deste vetor utilizando a função boot_alloc implementada anteriormente.
  2. Realizar a limpeza deste vetor com memset, para que quaisquer lixo de memoria não nos cause problemas futuramente.


## page_init

  Nesta função faremos a inicialização de todas as paginas de memoria física.

  Utilizando a função page2pa, a qual faz a transformação do descritor PageInfo em um endereço físico, devemos realizar a alocação respeitando as seguintes condições :

  1. A pagina 0 não deve ser alocada.
  2. Os endereços referentes a memoria base não devem ser alocados.
  3. A memoria estendida também não deve ser alocada.

  Após respeitadas tais condições as paginas restantes devem ter seu contador de referencia zerado, e a mesma colocada no vetor de paginas livres, page_free_list.


## page_alloc

  O page_alloc como o nome sugere, aloca uma pagina para quem o executa, portanto, os seguintes elementos devem ser encontrados em seu escopo:

  1. Verificação da existência de paginas disponíveis.
  2. Uma pagina da lista de paginas livres deve ser removida desta lista.
  3. A lista de paginas livres deve ser atualizada.
  4. O ponteiro referente a próxima pagina livre, da pagina selecionada, deve ser setado para NULL.
  5. Caso alloc_flags & ALLOC_ZERO a pagina toda deve ser setada com "0", lembre-se que a alocação ocorre no endereço virtual do kernel.  


## page_free

  Esta é a função responsável em dizer ao SO que uma pagina previamente utilizada esta agora disponível novamente. Portanto o page_free deve seguir os seguintes passos:

  1. Verificar se o contador de referencias da pagina é 0.
  2. Caso seja, a mesma deve ser devolvida a lista de paginas livres.
  3. Caso contrario, a pagina ainda não esta pronta para ser liberada, pois algum processo ainda á esta utilizando.


**Agora com as funções responsáveis pela alocação física implementadas, podemos partir pra a alocação virtual.**

## pgdir_walk

  O pgdir_walk tem como função estabelecer um link entre um endereço virtual e uma pagina de memoria. Para isto é necessário analisarmos em qual diretório de paginas este endereço reside, e qual o deslocamento dentro deste diretório.

  Para que isto seja realizado com sucesso, o pgdir_walk deve trabalhar da seguinte maneira:

  1. Verificar se a pagina esta presente no diretório.
  2. Criar ou não esta pagina se solicitado.
  3. Atualizar as entradas e permissões no diretório;
  4. Devolver o PTE da pagina a função principal.


## boot_map_region

  Aqui faremos o mapeamento dos endereços virtuais para os endereços físicos utilizados durante o boot.

  Com os endereços físicos e virtuais iniciais, e com a quantidade de paginas necessárias, implementaremos as seguintes instruções:

  1. Utilizando o pgdir_walk, obteremos o PTE do primeiro intervalo do endereço virtual (sempre múltiplo de PGSIZE).
  2. Atribuiremos a este PTE um endereço físico, junto com as permissões solicitadas.
  3. Repetiremos estes passos, avançando de pagina em pagina, até a quantidade desejada.

## page_lookup

  page_lookup tem como objetivo obter o descritor de uma pagina de memoria a partir de seu endereço virtual.

  Assim com um endereço virtual, podemos obter o PTE com o pgdir_walk, e deste PTE extraímos seu descritor, com esta ideia em mente faremos o seguinte:

  1. Através do pgdir_walk conseguiremos o PTE deste endereço virtual.
  2. Utilizando o pa2page obteremos nosso PageInfo.
  3. Caso necessário o endereço deste PTE deve ser salvo.


## page_remove

  O page_remove remove o mapeamento entre um endereço virtual e uma pagina de memoria física, para que tal endereço físico possa ser usado futuramente por outro processo.

 Utilizaremos das funções anteriores pare que esta remoço ocorra sem problemas, seguindo a seguinte ordem:

 1. Caso a pagina exista, uma referencia a esta deve ser decrementada.
 2. Caso as referencias a esta pagina cheguem a 0, a mesma deve ser liberada.
 3. Caso removida, o PTE deve ser atualizado, já que esta, a partir de agora, não pertence a um diretório.
 4. A entrada na tabela de paginas deve ser atualizada, utilizando o comando tlb_invalidate.


## page_insert

 No page_insert é realizado o mapeamento das paginas de memorias físicas aos endereços virtuais dos processos.

 Algumas verificações devem ser feitas com fim de evitar erros durante a execução do programa, tais como a limpeza de uma pagina caso esta já esteja presente. Portanto:

 1. Deve ocorrer uma verificação se a pagina solicitada já esta alocada e presente.
 2. Caso esteja, suas permissões devem ser atualizadas;
 3. Caso contrario a pagina deve ser inserida, com as devidas permissões e seu contador de referencias incrementado.
 4. Porem se a pagina não estava alocada previamente, e não foi possível sua alocação, deve-se retornar -E_NO_MEM indicando que o limite de memoria do SO foi atingido.

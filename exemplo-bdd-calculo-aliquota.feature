# calculo-aliquota-efetiva.feature

Funcionalidade: Cálculo da Alíquota Efetiva para RBA dentro do limite ano-calendário
  Como um sistema de contabilidade
  Quero calcular a alíquota efetiva para empresas do Simples Nacional  
  Para determinar os valores corretos de impostos a serem pagos

  Contexto:
    Dado que o sistema está configurado para o exercício de 2025
    E o Anexo III - Seção 09 - Tabela 01 está disponível
    E os percentuais de repartição estão configurados:
      | Imposto | Percentual |
      | IRPJ    | 4,00%      |
      | CSLL    | 3,50%      |
      | COFINS  | 13,64%     |
      | PIS     | 2,96%      |
      | CPP     | 43,40%     |
      | ICMS    | 33,50%     |
      | IPI     | 0,00%      |
      | ISS     | 32,50%     |

  @cenario-oficial @formula-base
  Cenário: Cálculo com dados do exemplo oficial
    Dado que a empresa possui os seguintes dados:
      | Campo | Valor      |
      | RPA   | 14.296,80  |
      | RBA   | 367.720,90 |
      | RBAA  | 84.373,54  |
      | RBT12 | 410.092,96 |
    E a alíquota nominal é 13,50%
    E a parcela a deduzir é 17.640,00
    Quando eu solicitar o cálculo da alíquota efetiva
    Então a alíquota efetiva deve ser 9,19853625382889%
    E o valor total de impostos deve ser R$ 1.755,66
    E os valores individuais devem ser:
      | Imposto | Alíquota Efetiva    | Valor  |
      | IRPJ    | 0,367941450153155   | 52,60  |
      | CSLL    | 0,321948768884011   | 46,03  |
      | COFINS  | 1,25468034502226    | 179,38 |
      | PIS     | 0,272276673113335   | 38,93  |
      | CPP     | 3,99216473416174    | 570,75 |
      | ICMS    | 3,08150964503268    | 440,56 |
      | IPI     | 0,00000000000000    | 0,00   |
      | ISS     | 2,98952428249439    | 427,41 |

  @limite-superior
  Cenário: Empresa no limite exato de RBA
    Dado que a empresa possui RBA de R$ 3.600.000,00
    E RBT12 de R$ 3.600.000,00
    E RPA de R$ 100.000,00
    Quando eu solicitar o cálculo da alíquota efetiva
    Então o cálculo deve ser executado normalmente
    E não deve retornar erro de limite excedido

  @limite-excedido @validacao
  Cenário: Empresa acima do limite de RBA
    Dado que a empresa possui RBA de R$ 3.600.000,01
    Quando eu solicitar o cálculo da alíquota efetiva
    Então deve retornar erro "RBA excede limite de R$ 3.600.000,00"
    E o cálculo não deve ser executado
    E o código de resposta deve ser 400

  @valores-extremos @precisao
  Cenário: Cálculo com valores decimais extremos
    Dado que a empresa possui os seguintes dados:
      | Campo | Valor      |
      | RPA   | 0,01       |
      | RBA   | 1.000,00   |
      | RBT12 | 999.999,99 |
    E a alíquota nominal é 4,50%
    E a parcela a deduzir é 0,00
    Quando eu solicitar o cálculo da alíquota efetiva
    Então o resultado deve manter precisão de 8 casas decimais
    E todos os valores de impostos devem ser >= R$ 0,01
    E não deve haver arredondamentos incorretos

  @performance
  Cenário: Performance do cálculo
    Dado que eu tenho dados válidos para cálculo
    Quando eu solicitar o cálculo da alíquota efetiva
    Então a resposta deve ser retornada em menos de 500ms
    E o sistema deve suportar 1000 cálculos por minuto

  @validacao-entrada
  Esquema do Cenário: Validação de dados de entrada inválidos
    Dado que eu informo <campo> com valor <valor>
    Quando eu solicitar o cálculo da alíquota efetiva
    Então deve retornar erro de validação
    E a mensagem deve indicar "<mensagem>"
    E o código de resposta deve ser 400

    Exemplos:
      | campo | valor    | mensagem                        |
      | RPA   | -100,00  | RPA deve ser maior que zero     |
      | RBA   | 0,00     | RBA deve ser maior que zero     |
      | RBT12 | -1,00    | RBT12 deve ser maior que zero   |
      | RPA   |          | RPA é obrigatório              |

  @impostos-individuais
  Esquema do Cenário: Validação de cálculo por imposto individual
    Dado que a alíquota efetiva calculada é 10,00%
    E o percentual de repartição do <imposto> é <percentual>
    E a RPA é R$ 1.000,00
    Quando eu calcular o <imposto> individual
    Então a alíquota efetiva do <imposto> deve ser <aliquota_efetiva>
    E o valor do <imposto> deve ser R$ <valor>

    Exemplos:
      | imposto | percentual | aliquota_efetiva | valor |
      | IRPJ    | 4,00%      | 0,40%           | 4,00  |
      | CSLL    | 3,50%      | 0,35%           | 3,50  |
      | COFINS  | 13,64%     | 1,364%          | 13,64 |
      | PIS     | 2,96%      | 0,296%          | 2,96  |

  @api-integracao
  Cenário: Integração completa via API REST
    Dado que eu faço uma requisição POST para "/api/calculo-aliquota"
    E o corpo da requisição contém:
      """
      {
        "exercicio": 2025,
        "anexo": "III",
        "secao": "09",
        "tabela": "01", 
        "periodoApuracao": "setembro",
        "rpa": 14296.80,
        "rba": 367720.90,
        "rbaa": 84373.54,
        "rbt12": 410092.96
      }
      """
    Quando eu enviar a requisição
    Então o código de resposta deve ser 200
    E o corpo da resposta deve conter:
      """
      {
        "aliquotaEfetiva": 9.19853625382889,
        "impostos": {
          "irpj": {
            "aliquotaEfetiva": 0.367941450153155,
            "valor": 52.60
          },
          "csll": {
            "aliquotaEfetiva": 0.321948768884011, 
            "valor": 46.03
          }
        },
        "aliquotaTotal": 12.28004589886157,
        "impostoTotal": 1755.66
      }
      """

  @auditoria
  Cenário: Rastreabilidade dos cálculos
    Dado que eu solicito um cálculo válido
    Quando o cálculo for executado
    Então deve ser gerado um log estruturado contendo:
      | Campo                | Conteúdo                    |
      | UserId              | ID do usuário logado         |
      | Timestamp           | Data/hora da execução        |
      | DadosEntrada        | Todos os parâmetros enviados |
      | ResultadoCalculado  | Resultado completo           |
      | TempoProcessamento  | Tempo em millisegundos       |
    E o log deve ser persistido para auditoria
    E deve ser possível rastrear a origem do cálculo
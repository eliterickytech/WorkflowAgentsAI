# Exemplos Práticos - Requirements Analyst Agent

Este documento contém exemplos reais de como usar o **Requirements Analyst Agent** para extrair regras, criar cenários BDD e mapear dependências.

---

## 📊 **Exemplo 1: Análise de Documentos Tributários**

### **Contexto:**
Extrair regras de cálculo de impostos de documentos da Receita Federal.

### **Prompt:**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 02, Activity: analise-regras-tributarias
Contexto: "Extrair regras de cálculo tributário de documentos oficiais da Receita Federal. Transformar em regras estruturadas RN-0030 a RN-0045 + cenários BDD para sistema de e-commerce multi-estado."

Entrada disponível:
- Portaria_RF_2024_Tributacao.pdf: 85 páginas de regulamentação fiscal
- Tabela_Aliquotas_Estados.xlsx: 27 planilhas com alíquotas por UF
- Casos_Teste_Homologacao.docx: 150 cenários de validação do SPED
- Manual_ICMS_Substituicao.pdf: 45 páginas ST + MVA por NCM

Domínio específico: 
- E-commerce B2C multi-estado (26 UFs + DF)
- Produtos: Eletrônicos, roupas, livros, medicamentos
- Regimes: Simples Nacional, Lucro Presumido, Lucro Real
- Operações: Vendas internas, interestaduais, exportação

Foco da análise:
- Regras ICMS por UF de origem/destino
- Substituição Tributária (ST) por NCM
- Cálculo PIS/COFINS por regime tributário  
- Casos especiais: Zona Franca, benefícios fiscais
- Validações obrigatórias para SPED Fiscal

Saída esperada:
- RN-0030: Cálculo base ICMS normal
- RN-0031: ICMS interestadual (diferencial alíquota)
- RN-0032: Substituição Tributária + MVA
- RN-0033: PIS/COFINS por regime
- RN-0034: Benefícios fiscais por UF
- RN-0035 a RN-0045: Casos especiais + validações SPED
- Features BDD: 50+ cenários Gherkin automatizáveis

Complexidades identificadas:
- Legislação muda frequentemente (atualizações trimestrais)
- Interpretação jurídica necessária (não apenas técnica)
- Dependências entre regras (ICMS afeta PIS/COFINS)
- Exceções estaduais (cada UF tem particularidades)
```

### **Resultado Esperado:**
- Regras estruturadas RN-00xx com examples práticos
- Cenários BDD Gherkin para automação de testes
- Mapeamento de dependências entre regras tributárias
- Validação de consistência terminológica fiscal
- Documentação para auditoria fiscal

---

## 🏥 **Exemplo 2: Sistema de Prontuário Eletrônico**

### **Contexto:**
Analisar regulamentações médicas para implementar prontuário digital.

### **Prompt:**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 03, Activity: requisitos-prontuario-eletronico
Contexto: "Extrair requisitos de prontuário eletrônico baseado nas resoluções CFM, LGPD saúde e padrões HL7 FHIR. Criar regras RN-0050 a RN-0070 para sistema hospitalar."

Documentos de entrada:
- Resolucao_CFM_1821_Prontuario_Digital.pdf: Regulamentação médica obrigatória
- LGPD_Dados_Saude_Ministerio.pdf: Tratamento dados sensíveis saúde
- HL7_FHIR_R4_Implementation_Guide.pdf: Padrão internacional interoperabilidade
- Manual_Certificacao_Digital_ICP_Brasil.pdf: Assinatura digital médica
- Auditoria_ANS_Prontuarios.xlsx: Checklist conformidade operadoras

Contexto regulatório:
- CFM: Conselho Federal de Medicina (obrigatório)
- ANS: Agência Nacional de Saúde Suplementar
- LGPD: Proteção dados pessoais sensíveis
- ICP-Brasil: Infraestrutura chaves públicas
- HL7 FHIR: Interoperabilidade internacional

Funcionalidades a normatizar:
1. **Criação prontuário:** Identificação unívoca paciente + dados mínimos obrigatórios
2. **Registro consultas:** Anamnese + exame físico + diagnóstico + prescrição
3. **Assinatura digital:** Certificado ICP-Brasil + timestamp + integridade
4. **Compartilhamento:** Consentimento paciente + auditoria acessos + finalidade
5. **Retenção dados:** Prazos legais + arquivamento + descarte seguro
6. **Auditoria:** Logs imutáveis + rastreabilidade + relatórios ANS

Casos especiais médicos:
- Menores de idade: Consentimento responsáveis + sigilo médico
- Dados genéticos: Proteção extra + consentimento específico
- Telemedicina: Validação identidade + gravação consulta + prescrição digital
- Emergência: Acesso sem consentimento + justificativa + auditoria posterior
- Óbito: Acesso familiares + inventário + tempo retenção diferenciado

Integrações obrigatórias:
- DATASUS: Cartão Nacional de Saúde + notificações compulsórias
- ANS: Relatórios operadoras + indicadores qualidade
- Receita Federal: Receita digital + rastreabilidade medicamentos controlados
- Laboratórios: Resultados exames + laudos + imagens DICOM

Saída estruturada:
- RN-0050 a RN-0055: Criação e identificação prontuários
- RN-0056 a RN-0060: Registros médicos obrigatórios  
- RN-0061 a RN-0065: Assinatura digital + certificação
- RN-0066 a RN-0070: LGPD + compartilhamento + auditoria
- Features BDD: Cenários compliance automatizados
```

### **Resultado Esperado:**
- Regras médicas estruturadas com base legal
- Cenários BDD para compliance CFM + ANS + LGPD
- Mapeamento fluxos de consentimento e auditoria
- Validação terminologia médica padronizada
- Checklist para certificação hospitalar

---

## 🏦 **Exemplo 3: Regulamentação Open Banking**

### **Contexto:**
Implementar APIs Open Banking conforme regulamentação Banco Central.

### **Prompt:**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 01, Activity: open-banking-compliance
Contexto: "Analisar regulamentação Banco Central do Brasil para Open Banking. Extrair requisitos técnicos e de negócio para APIs obrigatórias + consent management + security."

Regulamentação oficial:
- Resolucao_BCB_32_2020_Open_Banking.pdf: Regulamentação principal (120 páginas)
- Manual_APIs_Open_Banking_v3.1.pdf: Especificações técnicas detalhadas
- Diretrizes_Seguranca_Open_Banking.pdf: Security requirements obrigatórios
- Cronograma_Implementacao_Fases.pdf: Timeline compliance por porte instituição
- Multas_Penalidades_Nao_Conformidade.pdf: Riscos regulatórios + valores

Fases obrigatórias:
**Fase 1 (já obrigatória):** Dados abertos
- Produtos e serviços bancários
- Canais de atendimento  
- Tarifas e taxas
- Correspondentes bancários

**Fase 2 (implementar):** Dados cadastrais + transacionais
- Cadastro clientes (com consentimento)
- Contas corrente/poupança
- Cartão de crédito
- Operações de crédito

**Fase 3 (próxima):** Iniciação de pagamentos
- PIX via Open Banking
- TED/DOC iniciadas por terceiros
- Pagamentos recorrentes
- Agendamentos

**Fase 4 (futura):** Outros serviços
- Investimentos
- Seguros  
- Previdência complementar
- Câmbio

Requisitos técnicos críticos:
- **Security:** OAuth 2.0 + FAPI + mTLS + JWE + JWS
- **Consent:** Consentimento granular + expiração + revogação
- **APIs:** REST + JSON + rate limiting + SLA 95%
- **Monitoring:** Logs auditoria + métricas disponibilidade
- **Certification:** Testes conformidade OPIN + certificação trimestral

Riscos de não conformidade:
- Multas: R$ 2M a R$ 2B (conforme porte instituição)
- Suspensão: Atividades bancárias suspensas
- Reputacional: Perda credibilidade + clientes
- Operacional: Exclusão ecossistema financeiro

Saída detalhada:
- RN-0080 a RN-0090: Security requirements (OAuth + FAPI)
- RN-0091 a RN-0095: Consent management lifecycle
- RN-0096 a RN-0100: API specifications + SLA
- RN-0101 a RN-0105: Auditoria + compliance + monitoring
- Features BDD: Testes automatizados conformidade BCB
```

### **Resultado Esperado:**
- Requisitos Open Banking estruturados por fase
- Cenários BDD para certificação automática
- Matriz de compliance vs funcionalidades
- Mapeamento de riscos regulatórios
- Timeline de implementação obrigatória

---

## 🏭 **Exemplo 4: Sistema de Controle Ambiental**

### **Contexto:**
Compliance ambiental para indústria química com múltiplas normas.

### **Prompt:**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 04, Activity: compliance-ambiental-industrial
Contexto: "Extrair requisitos de controle ambiental de normas ISO 14001, licenciamento IBAMA, CONAMA e legislação estadual. Sistema de monitoramento + relatórios automáticos."

Normas e legislação:
- ISO_14001_2015_Sistema_Gestao_Ambiental.pdf: Padrão internacional obrigatório
- Licenca_Operacao_IBAMA_2024.pdf: Condicionantes específicas da empresa
- Resolucoes_CONAMA_Efluentes.pdf: Limites emissões + monitoramento
- Lei_Estadual_Controle_Poluicao.pdf: Regulamentação local mais restritiva
- Manual_SINIMA_Relatorios.pdf: Sistema Nacional Informações Meio Ambiente

Aspectos ambientais identificados:
**Emissões atmosféricas:**
- SO2, NOx, Material Particulado: Limits por mg/Nm³
- Monitoramento contínuo: Sensores + calibração + relatório mensal
- Equipamentos controle: Filtros, lavadores, precipitadores
- Alertas: Ultrapassagem 80% limite → ação corretiva imediata

**Efluentes líquidos:**
- DBO, DQO, pH, metais pesados: Análise laboratorial semanal
- Tratamento: ETE + controle qualidade + certificação lab
- Descarte: Rede pública vs corpo hídrico (licenças diferentes)
- Emergência: Vazamentos → contenção + notificação 24h

**Resíduos sólidos:**
- Classificação: Perigosos (Classe I) vs não-perigosos (II)
- Manifesto: MTR eletrônico + rastreabilidade + destinação final
- Armazenamento: Normas ABNT + inspeções + treinamento
- Destinação: Empresas licenciadas + certificados + auditoria

**Ruído e vibração:**
- Medição: dB(A) períodos diurno/noturno + mapas acústicos
- Limites: NBR 10151 + legislação municipal específica  
- Controle: Enclausuramento + EPI + medicina ocupacional
- Vizinhança: Monitoramento pontos críticos + reclamações

Relatórios obrigatórios:
1. **RAPP (Anual):** Relatório Atividades Potencialmente Poluidoras
2. **CTF/APP (Trimestral):** Cadastro Técnico Federal + taxa
3. **GIRS (Municipal):** Gerenciamento Integrado Resíduos Sólidos  
4. **Estadual (Mensal):** Conforme licença operação específica
5. **SINIMA (Sob demanda):** Sistema Nacional Informações

Não conformidades críticas:
- Ultrapassagem limites: Auto de infração + multa + interdição possível
- Relatórios atrasados: Multa diária + suspensão licenças
- Acidentes ambientais: Notificação imediata + plano emergência
- Auditoria reprovada: Renovação licença negada + paralização

Saída compliance:
- RN-0110 a RN-0120: Monitoramento emissões + limites
- RN-0121 a RN-0125: Tratamento efluentes + qualidade  
- RN-0126 a RN-0130: Gestão resíduos + rastreabilidade
- RN-0131 a RN-0135: Relatórios automáticos + prazos
- Features BDD: Compliance automatizado + alertas preventivos
```

### **Resultado Esperado:**
- Requisitos ambientais estruturados por aspecto
- Cenários BDD para compliance automático
- Matriz de normas vs funcionalidades do sistema
- Alertas preventivos antes de não conformidades
- Integração com órgãos ambientais (APIs quando disponíveis)

---

## 📊 **Exemplo 5: Sistema de Gestão Escolar**

### **Contexto:**
Regulamentações MEC para sistema acadêmico de ensino superior.

### **Prompt:**
```
@agents/manual/requirements-analyst.agent.md

Sprint: 02, Activity: regulamentacao-mec-ensino-superior
Contexto: "Analisar regulamentações MEC para sistema de gestão acadêmica: SINAES, e-MEC, Censo da Educação Superior, ENADE. Compliance para credenciamento institucional."

Regulamentação MEC:
- Lei_9394_LDB_Educacao_Nacional.pdf: Lei de Diretrizes e Bases (fundamental)
- Decreto_5773_MEC_Regulacao_Ensino.pdf: Regulação + supervisão + avaliação
- Portaria_MEC_840_SINAES.pdf: Sistema Nacional Avaliação Educação Superior
- Manual_eMEC_Processos_Regulatorios.pdf: Credenciamento + autorização cursos
- Instrucoes_Censo_Educacao_Superior.pdf: Relatórios anuais obrigatórios

Processos regulatórios:
**Credenciamento institucional:**
- PDI: Plano Desenvolvimento Institucional (5 anos)
- Corpo docente: Titulação + regime trabalho + experiência
- Infraestrutura: Bibliotecas + laboratórios + acessibilidade
- Avaliação in loco: Comissão MEC + relatório aprovação

**Autorização cursos:**
- PPC: Projeto Pedagógico Curso + matriz curricular
- Coordenador: Titulação + experiência + dedicação
- Bibliografia: Acervo bibliográfico + periódicos + bases dados
- Estágio: Convênios + supervisão + relatórios

**Reconhecimento:**
- Funcionamento mínimo 50% integralização
- ENADE: Participação obrigatória + CPC satisfatório
- Egresso: Acompanhamento + inserção mercado trabalho
- Autoavaliação: CPA + relatórios anuais

Dados obrigatórios (Censo):
**Instituição:**
- Cursos oferecidos + modalidades + turnos
- Vagas autorizadas + oferecidas + preenchidas
- Docentes: CPF + titulação + regime + disciplinas
- Funcionários: Categorias + escolaridade + funções

**Estudantes:**
- Ingressantes: Vestibular + ENEM + transferência + reopção
- Matriculados: Presencial + EAD + semipresencial
- Concluintes: Por curso + ano ingresso + tempo integralização
- Mobilidade: Intercâmbios + programas específicos

**Financeiro acadêmico:**
- Receitas: Mensalidades + convênios + financiamentos
- Bolsas: ProUni + FIES + institucionais + percentuais
- Inadimplência: Controle + renegociação + impactos
- Investimentos: Infraestrutura + tecnologia + capacitação

Compliance crítico:
- **Prazos Censo:** Março (prazo fatal) + retificações abril
- **Relatórios CPA:** Anual + publicação site institucional  
- **ENADE:** Inscrição estudantes + aplicação + divulgação resultados
- **e-MEC:** Processos tramitação + documentos + manifestações

Penalidades não conformidade:
- Supervisão especial: Acompanhamento rigoroso MEC
- Protocolo compromisso: Metas + prazo + acompanhamento
- Redução vagas: Autorização diminuída + impacto receita
- Descredenciamento: Fechamento instituição + transferência alunos

Saída acadêmica:
- RN-0140 a RN-0150: Gestão acadêmica + lifecycle estudante
- RN-0151 a RN-0155: Docentes + titulação + regime trabalho
- RN-0156 a RN-0160: Cursos + autorização + reconhecimento  
- RN-0161 a RN-0165: Censo + relatórios + prazos MEC
- Features BDD: Compliance MEC automatizado + alertas
```

### **Resultado Esperado:**
- Requisitos MEC estruturados por processo regulatório
- Cenários BDD para compliance educacional
- Calendário de obrigações com alertas preventivos
- Integração com sistemas MEC (e-MEC, Censo, ENADE)
- Documentação para visitas de avaliação MEC

---

## 🎯 **Dicas para Usar Requirements Analyst Eficientemente:**

### **1. Prepare Documentos Organizadamente:**
- Coloque arquivos na pasta correta (`attachments/`)
- Nomeie arquivos de forma clara e consistente
- Inclua versões e datas nos nomes
- Organize por categoria (legal, técnico, referência)

### **2. Seja Específico sobre o Domínio:**
- Mencione setor (financeiro, saúde, educação, industrial)
- Inclua terminologia específica do domínio
- Referencie normas e regulamentações aplicáveis
- Considere particularidades regionais/locais

### **3. Defina Escopo de Análise:**
- Quais regras extrair (números RN-00xx específicos)
- Que tipo de cenários BDD criar
- Nível de detalhamento necessário
- Integração com sistemas existentes

### **4. Considere Dependências:**
- Regras que afetam outras regras
- Sequência de validações obrigatórias
- Impacto de mudanças regulatórias
- Versionamento e rastreabilidade

### **5. Foque em Compliance:**
- Identifique obrigações legais vs opcionais
- Mapeie penalidades por não conformidade
- Estabeleça prazos e cronogramas
- Preveja auditoria e evidências necessárias

---

**💡 O Requirements Analyst transforma documentos complexos em regras estruturadas e cenários BDD automatizáveis!**
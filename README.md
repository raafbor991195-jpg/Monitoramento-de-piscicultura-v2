# Monitor da Piscicultura — versão 2

Esta versão adiciona:
- Dashboard geral.
- Histórico de alterações por tanque.
- Usuário responsável por cada alteração.
- Gráfico de linha do histórico.
- Alertas de atualização há mais de 30 dias.
- Alertas básicos de água: OD < 4 mg/L, pH < 6 ou > 9, amônia > 0,05 e nitrito > 0,20.
- Atualização em tempo real entre aparelhos.
- Cadastro e edição de tanques.

## Instalação

1. Crie um projeto no Supabase.
2. Abra SQL Editor.
3. Execute `database.sql`.
4. No `index.html`, substitua:
   `COLOQUE_SUA_URL_SUPABASE`
   e
   `COLOQUE_SUA_CHAVE_ANON`
   pelos dados de Project URL e anon public key do Supabase.
5. Publique o `index.html` em uma hospedagem estática (Vercel, Netlify ou GitHub Pages).
6. Cada usuário cria sua própria conta.

## Observação sobre os alertas

Os alertas aparecem dentro do aplicativo quando os dados são carregados. Para enviar uma notificação push no celular mesmo com o aplicativo fechado, é necessário adicionar Web Push/FCM e uma rotina agendada no servidor.

## Importante

Os limites de qualidade de água incluídos são apenas valores iniciais de demonstração. Eles devem ser ajustados às espécies, fase de cultivo e orientação técnica adotada na propriedade.

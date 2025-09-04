# HelpMe - App de Ajuda Comunitária

## 📱 Etapa 1 - Estrutura Inicial

### Descrição do Projeto
O HelpMe é um aplicativo que conecta pessoas que precisam de ajuda com voluntários da comunidade dispostos a ajudar.

### Telas Implementadas

1. **Home Screen** (`/home`)
   - Lista de pedidos de ajuda próximos
   - Cada card mostra: título, descrição, categoria, distância e tempo
   - Botão flutuante para criar novo pedido
   - Acesso ao perfil pelo ícone no AppBar

2. **Create Help Screen** (`/create`)
   - Formulário com campos: título, descrição e categoria
   - Dropdown para seleção de categoria
   - Botão para publicar o pedido

3. **Profile Screen** (`/profile`)
   - Avatar e informações do usuário
   - Estatísticas de ajudas realizadas e recebidas
   - Menu com opções de histórico, configurações e logout


## 📱 Etapa 2 - Funcionalidades Avançadas

### Descrição do Projeto
Expansão das funcionalidades com autenticação, mapa interativo e notificações.

### Telas Implementadas

1. **Login Screen** (`/login`)
   - Campo de email e senha
   - Botão para login
   - Link para tela de cadastro

2. **Signup Screen** (`/signup`)
   - Formulário de cadastro com nome, email e senha
   - Botão para criar conta

3. **Notifications Screen** (`/notifications`)
   - Lista de notificações recebidas
   - Opção de marcar como lidas

4. **Map Screen** (`/map`)
   - Exibição dos pedidos em mapa (OpenStreetMap)
   - Marcadores coloridos por categoria
   - Clique em marcador abre detalhes do pedido

5. **My Requests Screen** (`/my`)
   - Lista apenas com os pedidos criados pelo usuário logado
   - Selo "Meu" nos pedidos do próprio usuário


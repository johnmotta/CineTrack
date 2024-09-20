# 🎬 CineTrack

| CineTrack é um aplicativo iOS que consome a API do TheMovieDB para exibir informações sobre filmes populares, próximos lançamentos e filmes mais bem avaliados. Este projeto foi desenvolvido utilizando **UIKit** com **view code** e segue os princípios do padrão **MVVM-C** (Model-View-ViewModel-Coordinator). | ![Imagem do CineTrack](https://i.imgur.com/wk07u0P.png) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------:|

## 📱 Funcionalidades

- Exibição de filmes nas categorias: **Próximos Lançamentos**, **Populares** e **Mais Bem Avaliados**.
- Navegação com **segmented control** para alternar entre categorias.
- Interface de usuário desenvolvida com **UIKit** e organizada em view code, sem o uso de storyboards.
- Consumo e tratamento de dados da API do TheMovieDB.
- Detalhamento de filmes com informações adicionais ao selecionar um item.
- Utilização do padrão **MVVM-C** para organização do projeto.

## 🛠️ Tecnologias Utilizadas

- Swift
- UIKit com view code
- MVVM-C (Model-View-ViewModel-Coordinator)
- API TheMovieDB para fornecimento de dados
- UICollectionView para exibição de listas de filmes em colunas
- URLSession para requisições de rede e tratamento de JSON

## ⚙️ Estrutura do Projeto

### Padrão MVVM-C
O projeto segue o padrão de arquitetura **MVVM-C**, separando responsabilidades em:

- **Model**: Estrutura que representa os dados do filme.
- **ViewModel**: Intermediação entre os dados e a view, fazendo a lógica de transformação e preparação.
- **ViewController**: Camada de interface que exibe os dados preparados pela ViewModel.
- **Coordinator**: Gerencia a navegação entre telas.

### Exibição dos Filmes
- Os filmes são exibidos utilizando uma `UICollectionView` customizada para mostrar os filmes em uma grade de três colunas.
- O layout da `UICollectionView` é dinâmico e calculado programaticamente.

### Comunicação com a API
- Utilizamos a API pública do [TheMovieDB](https://www.themoviedb.org/documentation/api) para obter dados dos filmes, como nome, gênero e descrição.
- O tratamento do JSON é realizado por meio do `Decodable`.

### Tela Principal
A tela principal apresenta um **UISegmentedControl** que permite alternar entre as categorias de filmes:

- **Próximos Lançamentos (Upcomming)**
- **Populares (Popular)**
- **Mais Bem Avaliados (Top Rated)**

### Detalhes dos Filmes
Ao selecionar um filme, o usuário é redirecionado para uma tela de detalhes, onde são exibidas mais informações sobre o filme, como sinopse e gênero.

## 📦 Como Instalar e Executar

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/cineTrack.git
   ```
   
2. Instale as dependências do projeto.

3. Obtenha uma chave de API no [TheMovieDB](https://www.themoviedb.org/documentation/api) e configure no código para habilitar a busca de filmes.

4. Compile e execute o projeto no **Xcode**.

## 🗂 Estrutura do Código

```bash
├── CineTrack
│   └── Components
│   ├── Controllers
│   ├── Coordinator
│   ├── Model
│   └── Source
│   └── Service
│   └── View
│   ├── ViewModel
```
- **Components**: Componentes reutilizáveis da interface, como botões e células customizadas.
- **Controllers**: ViewControllers responsáveis por exibir a interface e interagir com a ViewModel.
- **Coordinator**: Gerenciamento de navegação entre as telas.
- **Model**: Estruturas de dados que representam os filmes e outros elementos.
- **Source**: Arquivos fontes que fazem parte do código principal da aplicação.
- **Service**: Configuração e chamadas de serviços de rede, como a comunicação com a API TheMovieDB.
- **View**: Implementação das views usando UIKit e view code.
- **ViewModel**: Lógica de transformação dos dados para serem exibidos na view.

Com essa estrutura, o projeto fica bem organizado e fácil de manter!
## 🔄 Funcionalidades Futuras

- [ ] Integração com CoreData para salvar filmes favoritos.
- [ ] Implementação de buscas por filmes.

## 🧑‍💻 Contribuições

Sinta-se à vontade para contribuir com melhorias ou correções para o projeto. Basta seguir os passos:

1. Faça um fork deste repositório.
2. Crie um branch para sua feature (`git checkout -b minha-feature`).
3. Faça commit das suas alterações (`git commit -m 'Adiciona minha nova feature'`).
4. Envie o branch para o repositório remoto (`git push origin minha-feature`).
5. Abra um **Pull Request** para revisão.


class ArtefatoInfo {
  final int position;
  final String? name;
  final String? iconImage;
  final String? description;
  ArtefatoInfo(
    this.position, {
    this.name,
    this.iconImage,
    this.description,
  });
}

List<ArtefatoInfo> planets = [
  ArtefatoInfo(
    1,
    name: 'Alimentos',
    iconImage: 'assets/images/alimento.png',
    description:
        "Experimente uma nova maneira de adquirir alimentos deliciosos ou transformar suas habilidades culinárias em um negócio lucrativo. Nosso aplicativo simplifica a compra e venda de alimentos, conectando compradores e vendedores de maneira conveniente. \n\nPara Compradores: \n🍒 Descubra uma variedade incrível de pratos caseiros e culinária artesanal. \n🍒 Faça pedidos de suas refeições favoritas, apoiando chefs locais e pequenos produtores. \n🍒 Satisfaça seus desejos gastronômicos com apenas alguns cliques. \n\nPara Vendedores: \n📝Transforme suas receitas em um negócio de sucesso. \n📝Crie seu cardápio, defina preços e alcance uma audiência faminta por novos sabores. \n📝Ganhe dinheiro fazendo o que ama, compartilhando sua paixão pela comida com os outros. \n\nDescubra o mundo de possibilidades que nosso aplicativo oferece. Compre e venda alimentos com facilidade e desfrute de uma experiência gastronômica sem igual!\n",
  ),
  ArtefatoInfo(
    2,
    name: 'Empregos',
    iconImage: 'assets/images/emprego.png',
    description:
        "Nosso aplicativo simplifica a busca por oportunidades de emprego e o processo de cadastramento de vagas. Encontre vagas que se adequam ao seu perfil ou anuncie oportunidades para atrair os melhores talentos. \n\nPara Candidatos: \n🔎Explore uma variedade de vagas de emprego disponíveis. \n🔎Filtre as vagas por localização, setor e requisitos. \n🔎Visualize detalhes das vagas e candidate-se com apenas alguns cliques. \n🔎Acompanhe o status das suas candidaturas. \n\nPara Empregadores: \n💡Cadastre vagas de emprego em minutos. \n💡Defina critérios específicos para encontrar candidatos ideais. \n💡Receba candidaturas diretamente no aplicativo. \n💡Gerencie todas as vagas e candidatos em um só lugar. \n💡Facilite sua busca por empregos ou encontre os melhores candidatos para suas vagas. \n\nNosso aplicativo é a ferramenta perfeita para conectar talentos e oportunidades de forma rápida e eficiente.\n",
  ),
  ArtefatoInfo(
    3,
    name: 'Moradias',
    iconImage: 'assets/images/moradia.png',
    description:
        "Nosso aplicativo torna a busca por moradia mais simples do que nunca. \nEncontre o lar dos seus sonhos ou alcance um amplo público para ocupar seu imóvel de maneira rápida e eficaz. Comprar ou alugar nunca foi tão fácil! \n\nPara Buscadores de Moradia: \n🏡 Explore uma variedade de opções de moradia, desde apartamentos a casas. \n🏡 Refine sua pesquisa por localização, tamanho, comodidades e preço. \n🏡 Visualize detalhes das propriedades, incluindo fotos e descrições. \n🏡 Entre em contato com os anunciantes para agendar visitas. \n\nPara Anunciantes: \n🏚 Cadastre seu espaço para moradia em poucos passos simples. \n🏚 Inclua fotos e informações detalhadas para destacar sua propriedade. \n🏚 Receba mensagens de interessados diretamente pelo aplicativo. \n🏚 Gerencie todos os seus anúncios em um único lugar. \n\nDescubra como nosso aplicativo facilita a jornada em busca de empregos ou na contratação de talentos.\n",
  ),
  ArtefatoInfo(
    4,
    name: 'Eventos',
    iconImage: 'assets/images/evento.png',
    description:
        "Celebre em Grande Estilo ou Anuncie Seu Evento com Facilidade! \n\nNosso aplicativo é o seu parceiro ideal para encontrar e anunciar festas e eventos incríveis na cidade. Se você está procurando uma noite memorável ou deseja promover o seu próprio evento, estamos aqui para ajudar. Com uma ampla gama de festas emocionantes, shows e eventos especiais, você encontrará algo para todos os gostos. \n\nPara os Festeiros: \n🎉 Explore uma variedade de eventos emocionantes, desde festas exclusivas em clubes noturnos até shows ao ar livre e festivais animados. \n🎉 Navegue pelas opções, verifique os detalhes e garanta seu lugar na diversão. \n🎉 Não perca as melhores festas da cidade e esteja pronto para dançar a noite toda! \n\nPara os Organizadores de Eventos: \n🪩 Você está planejando um evento especial? Nosso aplicativo oferece uma plataforma fácil de usar para promover seu evento. \n🪩 Alcance um público maior e venda ingressos com facilidade. \n🪩 Compartilhe detalhes importantes, como localização, data e atrações para garantir que seu evento seja um sucesso estrondoso. \n\nViva experiências inesquecíveis e faça com que seus eventos se destaquem!\n",
  ),
  ArtefatoInfo(
    5,
    name: 'Objetos perdidos',
    iconImage: 'assets/images/objetos_perdidos.png',
    description:
        "Encontre Seus Itens Perdidos ou Ajude Outros a Reencontrarem os Deles! \n\nNosso aplicativo é a solução perfeita para localizar itens perdidos ou reportar objetos encontrados. Se você perdeu algo de valor ou encontrou algo importante, estamos aqui para facilitar a busca e a recuperação. Com nossa plataforma simples e eficaz, você pode se reunir com seus pertences perdidos ou ajudar alguém a fazer o mesmo. \n\nPara Quem Perdeu Algo: \n🕳️ Não deixe que a perda de um objeto estrague o seu dia. \n🕳️ Use nosso aplicativo para criar um anúncio detalhado do item perdido. \n🕳️ Inclua descrições precisas, data e local onde você acredita que o objeto foi extraviado. \n🕳️ Outros usuários atentos poderão ver seu anúncio e entrar em contato se encontrarem seu item. \n\nPara Quem Encontrou Algo: \n📌 Se você encontrou um objeto que não pertence a você, seja um smartphone, carteira, chave ou qualquer outro item, você pode ajudar a pessoa certa a recuperá-lo. \n📌 Use nosso aplicativo para relatar o objeto encontrado. \n📌 Forneça detalhes sobre o item, como sua descrição e local onde foi encontrado. \n\nIsso pode fazer toda a diferença para alguém que perdeu algo valioso. Compartilhe solidariedade e faça parte da comunidade de ajuda mútua.\n\n\n\n",
  ),
  ArtefatoInfo(
    6,
    name: 'Transportes',
    iconImage: 'assets/images/transporte.png',
    description:
        "Encontre ou Ofereça Meios de Transporte com Facilidade! \nNosso aplicativo é a solução ideal para quem procura ou oferece meios de transporte. Seja para se locomover na cidade, fazer viagens curtas ou longas, estamos aqui para simplificar sua busca por opções de transporte confiáveis. \n\nPara Quem Precisa de Transporte: \n🚗 Esqueça as complicações de encontrar um transporte adequado. Com nosso aplicativo, você pode procurar diversas opções de transporte, desde carros compartilhados a motoristas particulares, táxis e muito mais. \n🚗 Veja as avaliações dos motoristas, compare preços e escolha a opção que melhor atende às suas necessidades. \n\nPara Quem Oferece Transporte: \n🚙 Se você possui um veículo e deseja ganhar dinheiro extra, nosso aplicativo é o seu parceiro perfeito. \n🚙 Cadastre-se como motorista e comece a receber solicitações de passageiros. \n🚙 Você escolhe quando e onde deseja dirigir. \n🚙 Tenha controle total sobre seus ganhos e crie sua própria agenda. \n\nTorne a locomoção mais fácil para todos na sua comunidade e faça parte de uma rede que conecta pessoas que precisam de transporte a motoristas confiáveis. Seja para viagens diárias ou ocasiões especiais, estamos aqui para facilitar sua vida em movimento!\n",
  ),
];

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
        "Experimente uma nova maneira de adquirir alimentos deliciosos ou comercializar o seu. Nosso aplicativo simplifica a compra e venda de alimentos, conectando compradores e vendedores de maneira conveniente. \n\nPara Compradores: \n🍒 Descubra o que o comércio local está produzindo; \n🍒 Entre em contato com o fornecedor em segundos; \n🍒 Conheça várias opções, com seus dados; \n🍒 Filtre por suas preferências. \n\nPara Vendedores: \n📝 Divulgue seus alimentos; \n📝 Informe dados importantes para seus clientes; \n📝 Ganhe um extra. \n\nDescubra o mundo de possibilidades que nosso aplicativo oferece. Compre e venda alimentos com facilidade e desfrute de nosso aplicativo!\n",
  ),
  ArtefatoInfo(
    2,
    name: 'Empregos',
    iconImage: 'assets/images/emprego.png',
    description:
        "Nosso aplicativo simplifica a busca por oportunidades de emprego e o processo de cadastramento de vagas. Encontre vagas ou anuncie oportunidades. \n\nPara Candidatos: \n🔎 Explore as vagas de emprego disponíveis; \n🔎 Filtre as vagas por localização, empresa e modalidade; \n🔎 Visualize detalhes das vagas. \n🔎Acompanhe o status das suas candidaturas. \n\nPara Empregadores: \n💡 Divulgue vagas de emprego em minutos; \n💡Forneça dados relevantes para os candidatos; \n\nNosso aplicativo é a ferramenta perfeita para conectar talentos e oportunidades de forma rápida e eficiente.\n",
  ),
  ArtefatoInfo(
    3,
    name: 'Moradias',
    iconImage: 'assets/images/moradia.png',
    description:
        "Nosso aplicativo facilita a busca e divulgação por moradia. \nEncontre um lar para seu período de estudos. \n\nPara Buscadores de Moradia: \n🏡 Explore uma variedade de opções de moradia; \n🏡 Filtre por localização e valores; \n🏡 Visualize detalhes das propriedades, incluindo fotos e descrições. \n\nPara Anunciantes: \n🏚 Cadastre seu espaço para moradia; \n🏚 Inclua fotos e informações detalhadas para destacar sua propriedade; \n🏚 Gerencie todos os seus anúncios em um único lugar; \n\nDescubra como nosso aplicativo pode de ajudar a divulgar ou encontrar um lar!\n",
  ),
  ArtefatoInfo(
    4,
    name: 'Eventos',
    iconImage: 'assets/images/evento.png',
    description:
        "Celebre em grande estilo ou anuncie seu evento com facilidade! \n\nEm nosso aplicativo você pode encontrar e anunciar festas e eventos incríveis na cidade. Se você está procurando uma noite memorável ou deseja promover o seu próprio evento, estamos aqui para ajudar. Com uma ampla gama de festas emocionantes, shows e eventos especiais, você encontrará algo para todos os gostos. \n\nPara os Festeiros: \n🎉 Explore uma variedade de eventos emocionantes, desde festas exclusivas em clubes noturnos até shows ao ar livre e festivais animados. \n🎉 Navegue pelas opções, verifique os detalhes e garanta seu lugar na diversão. \n🎉 Não perca as melhores festas da cidade e esteja pronto para dançar a noite toda! \n\nPara os Organizadores de Eventos: \n🪩 Você está planejando um evento especial? Nosso aplicativo oferece uma plataforma fácil de usar para promover seu evento. \n🪩 Alcance um público maior e venda ingressos com facilidade. \n🪩 Compartilhe detalhes importantes, como localização, data e atrações para garantir que seu evento seja um sucesso estrondoso. \n\nViva experiências inesquecíveis e faça com que seus eventos se destaquem!\n",
  ),
  ArtefatoInfo(
    5,
    name: 'Objetos perdidos',
    iconImage: 'assets/images/objetos_perdidos.png',
    description:
        "Encontre seus itens perdidos ou ajude os outros a reencontrarem os deles! \n\nNosso aplicativo pode te ajudar a localizar itens perdidos ou reportar objetos encontrados. \n\nPara quem perdeu: \n🕳️ Use nosso aplicativo para criar um anúncio do item perdido; \n🕳️ Inclua descrições, local onde você acredita que o objeto foi perdido. \n\nPara quem encontrou algo: \n📌 Se você encontrou um objetom, você pode ajudar a pessoa certa a recuperá-lo; \n📌 Use nosso aplicativo para relatar o objeto encontrado; \n📌 Forneça detalhes sobre o item, como sua descrição, local onde foi encontrado e localização atual; \n\nIsso pode fazer toda a diferença para alguém que perdeu algo.\n\n\n\n",
  ),
  ArtefatoInfo(
    6,
    name: 'Transportes',
    iconImage: 'assets/images/transporte.png',
    description:
        "Encontre ou ofereça meios de transporte com facilidade! \nNosso aplicativo te ajuda na procura e divulgação meios de transporte. \n\nPara quem precisa de transporte: \n🚗 Você pode procurar diversas opções de transporte, desde carros compartilhados a motoristas a fim de dividir; \n🚗 \n\nPara Quem Oferece Transporte: \n🚙 Se você possui um veículo e deseja ofercer caronas, aqui é permitido a divulgação; \n\nTorne a locomoção mais fácil para todos na sua comunidade.\n",
  ),
];

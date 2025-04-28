enum Sample {
  smartHome._(
    title: 'Smart Home',
    description: 'Parallax Effect + Animations + Custom Hero ',
    designer: 'giulio_cuscito',
    pathImage: 'assets/img/samples/smart_home.gif',
    route: 'smart_home',
    heightCard: 250,
  ),

  // Add more samples here
  loginPage._(
    title: 'Login Page',
    description: 'Login Page + Custom Hero + Animations',
    designer: 'Disa11',
    pathImage: 'assets/img/samples/smart_home.gif',
    route: 'login_page',
    heightCard: 250,
  );

  const Sample._({
    required this.title,
    required this.description,
    required this.designer,
    required this.pathImage,
    required this.route,
    this.heightCard = 220,
  });

  final String title;
  final String description;
  final String designer;
  final String pathImage;
  final String route;

  final double heightCard;
}

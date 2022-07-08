class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome + Benefit',
      image: 'assets/images/intro1.png',
      discription:
          "Lorem Ipsum is simply dummy text of\nLorem Ipsum is simply dummy text of\nLorem Ipsum is simply dummy text of"),
  UnbordingContent(
      title: 'Enjoy The Rides + Extra Services',
      image: 'assets/images/intro2.png',
      discription:
          "Lorem Ipsum is simply dummy text of the\n Printing and typesetting industry. Lorem Ipsum \n Has been the industry's"),
  UnbordingContent(
      title: 'Invite Friends & Earns Miles',
      image: 'assets/images/intro3.png',
      discription:
          "Lorem Ipsum is simply dummy text of the \nPrinting and typesetting industry. Lorem Ipsum \nHas been the industry's"),
];

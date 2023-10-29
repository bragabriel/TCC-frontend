import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../model/descriptions_model.dart';

class DetailsView extends StatefulWidget {
  final ArtefatoInfo? artefatoInfo;
  const DetailsView({super.key, this.artefatoInfo});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientStartColor, // Defina a cor cinza aqui
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 32),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  Text(
                    widget.artefatoInfo!.name.toString(),
                    style: TextStyle(
                        shadows: const [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-1.0, -1.5),
                              color: Color.fromARGB(255, 53, 43, 159)),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.0, -1.5),
                              color: Color.fromARGB(255, 53, 43, 159)),
                          Shadow(
                              // topRight
                              offset: Offset(1.0, 1.5),
                              color: Color.fromARGB(255, 53, 43, 159)),
                          Shadow(
                              // topLeft
                              offset: Offset(-1.0, 1.5),
                              color: Color.fromARGB(255, 53, 43, 159)),
                        ],
                        fontSize: 55,
                        fontFamily: 'Avenir',
                        color: primaryTextColor,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                  const Divider(
                    color: Color.fromARGB(148, 232, 229, 229),
                  ),
                  SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Text(
                        widget.artefatoInfo!.description.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Avenir',
                            color: contentTextColor,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                        maxLines: 600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: -70,
              child: Hero(
                  tag: widget.artefatoInfo!.position,
                  child: Image.asset(
                    widget.artefatoInfo!.iconImage.toString(),
                    width: 340,
                    height: 340,
                  ))),
          Positioned(
              top: 60,
              left: 32,
              child: Text(
                widget.artefatoInfo!.position.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 247,
                    color: Colors.grey.withOpacity(0.0)),
              )),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ))
        ],
      )),
    );
  }
}

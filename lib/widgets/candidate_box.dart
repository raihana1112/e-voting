import 'package:flutter/material.dart';

class CandidateBox extends StatelessWidget {
  final String candidateImgURL;
  final String candidateName;
  final String candidateDesc;
  final Function onTap;
  final double height;

  const CandidateBox(
      {super.key,
      required this.candidateImgURL,
      required this.candidateName,
      required this.candidateDesc,
      required this.onTap,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: height,
        padding:
            const EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 161, 170, 220),
                  const Color.fromARGB(255, 189, 224, 252)
                ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(candidateImgURL)),
              ),
              Center(
                child: Text(candidateName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
              Text(
                candidateDesc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

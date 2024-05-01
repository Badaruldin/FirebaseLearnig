import 'package:flutter/material.dart';

class ImageWidgetClass extends StatelessWidget {
  const ImageWidgetClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deep Dive into Image Widget"),
        leading: Image.asset('assets/images/flower.png'),
      ),
      body: const Center(
        child: CustomImageWidget(imgAddress: 'assets/images/round_block.png'),
      ),
    );
  }
}

//https://images.pexels.com/photos/596710/pexels-photo-596710.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
class CustomImageWidget extends StatelessWidget {
  final double height, width;
  final String imgAddress;

  const CustomImageWidget(
      {Key? key, this.width = 250, this.height = 270, required this.imgAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 270,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(25)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image(
          height: height,
          width: width,fit: BoxFit.cover,
          // image: NetworkImage(imgAddress),
          image: AssetImage(imgAddress),
          errorBuilder: (context, error, stackTrace) {
            return const Center(
                child: Icon(Icons.error_outline, color: Colors.pink));
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            // await Future.delayed(Duration(seconds: 1));
            if (loadingProgress == null) return child;
            return SizedBox(
              width: width,
              height: height,
              child: Center(
                child: CircularProgressIndicator(
                    color: Colors.green,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null),
              ),
            );
          },
        ),
      ),
    );
  }
}

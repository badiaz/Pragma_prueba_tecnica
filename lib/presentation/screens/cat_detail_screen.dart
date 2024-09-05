import 'package:flutter/material.dart';
import 'package:catbreeds/utils/colors.dart';
import 'package:catbreeds/domain/entities/entities.dart';

class CatDetailScreen extends StatelessWidget {
  final BreedEntity? catInfo;
  const CatDetailScreen({super.key, this.catInfo});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkGreyBackgroundColor,
      appBar: _buildAppBar(size),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeaderImage(size),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: ListView(
                  children: [
                    _buildInfoText(
                        size, '* Description: ', catInfo!.description),
                    _buildInfoText(size, '* Origin country: ', catInfo!.origin),
                    _buildInfoText(size, '* Intelligence: ',
                        '${catInfo!.intelligence.toString()}/5'),
                    _buildInfoText(size, '* Adaptability: ',
                        '${catInfo!.adaptability.toString()}/5'),
                    _buildInfoText(
                        size, '* Life Span: ', '${catInfo!.lifeSpan} years'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(Size size, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryGreenColor,
              ),
            ),
            TextSpan(
              text: subtitle,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(Size size) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.greyBackgroundColor,
      toolbarOpacity: 0.6,
      title: Text(
        catInfo!.name,
        style: TextStyle(
            color: AppColors.primaryGreenColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.045),
      ),
    );
  }

  Widget _buildHeaderImage(Size size) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)),
      child: SizedBox(
        height: size.height * 0.5,
        width: size.width,
        child: Hero(
          tag: catInfo!.id,
          child: FadeInImage(
            width: size.width * 0.35,
            height: size.height * 0.17,
            fadeInDuration: const Duration(milliseconds: 300),
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/images/placeholder.png'),
            image: catInfo!.image != null && catInfo!.image!.url.isNotEmpty
                ? NetworkImage(catInfo!.image!.url)
                : const AssetImage('assets/images/placeholder.png')
                    as ImageProvider,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/placeholder.png');
            },
          ),
        ),
      ),
    );
  }
}

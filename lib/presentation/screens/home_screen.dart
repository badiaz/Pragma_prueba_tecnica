import 'package:flutter/material.dart';
import 'package:catbreeds/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catbreeds/domain/entities/breed_entity.dart';
import 'package:catbreeds/presentation/blocs/breed/breed_bloc.dart';
import 'package:catbreeds/presentation/delegates/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        BlocProvider.of<BreedBloc>(context).add(LoadMoreBreedsEvent());
        setState(() {
          _isLoadingMore = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildHeader(size),
            _buildBody(size, context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.15,
      color: AppColors.whiteBackgroundColor,
      child: SafeArea(
          child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cat.png'),
            Text(
              'Catbreeds',
              style: TextStyle(
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreenColor),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildBody(Size size, BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.85,
      decoration: BoxDecoration(
          color: AppColors.greyBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            _buildSearchBar(size, context),
            _buildCatList(size),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          showSearch(context: context, delegate: BreedSearchDelegate()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Container(
          width: size.width,
          height: size.height * 0.07,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!,
                    spreadRadius: 1.0,
                    blurRadius: 10.0)
              ],
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Search a cat breed',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.grey[400]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCatList(Size size) {
    return BlocConsumer<BreedBloc, BreedState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is BreedLoadedState) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      },
      builder: (context, state) {
        if (state is BreedErrorState) {
          return Expanded(
            child: Center(
              child: Icon(
                Icons.wifi_off_outlined,
                color: Colors.grey[400],
                size: size.width * 0.4,
              ),
            ),
          );
        }
        if (state is BreedLoadedState) {
          return Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: state.breeds.length + (state.hasReachedMax ? 0 : 1),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20.0,
              ),
              itemBuilder: (context, index) {
                if (index < state.breeds.length) {
                  BreedEntity catInfo = state.breeds[index];
                  return _buildCatCard(size, catInfo, context);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGreenColor,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else {
          return Expanded(
            child: Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryGreenColor,
            )),
          );
        }
      },
    );
  }

  Widget _buildCatCard(Size size, BreedEntity catInfo, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, 'catDetail', arguments: catInfo),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: size.width * 0.5 - 21,
                  height: size.height * 0.15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        catInfo.name,
                        style: TextStyle(
                            color: AppColors.primaryGreenColor,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.045),
                      ),
                      Text(
                        'Origin: ${catInfo.origin}',
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                      Text(
                        'Intelligence: ${catInfo.intelligence}',
                        style: TextStyle(fontSize: size.width * 0.04),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -10.0,
              child: Hero(
                tag: catInfo.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: FadeInImage(
                    width: size.width * 0.35,
                    height: size.height * 0.17,
                    fadeInDuration: const Duration(milliseconds: 300),
                    fit: BoxFit.cover,
                    placeholder:
                        const AssetImage('assets/images/placeholder.png'),
                    image:
                        catInfo.image != null && catInfo.image!.url.isNotEmpty
                            ? NetworkImage(catInfo.image!.url)
                            : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                          width: size.width * 0.35,
                          height: size.height * 0.17,
                          child: Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          ));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

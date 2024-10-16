import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/widgets/build_favorite_list_product.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/cubit/auth/auth_cubit.dart';
import 'package:shop_app/cubit/search/search_cubit.dart';
import 'package:shop_app/utils/app_theme.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Search',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      prefixIcon: const Icon(Icons.search),
                      borderColor:
                          AuthCubit.get(context).currentTheme == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                      textInputType: TextInputType.text,
                      hintText: 'search a product',
                      onSubmitted: (String text) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).searchProduct(text: text);
                        }
                      },
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(color: defaultColor,),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildFavoritesListProducts(
                            index: index,
                            context: context,
                            model: state.searchModel!.data.dataData[index],
                            oldPrice: false,
                          ),
                          separatorBuilder: (context, index) => Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                          itemCount: state.searchModel!.data.dataData.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

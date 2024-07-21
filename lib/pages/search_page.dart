import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/build_list_product.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/cubit/search/search_cubit.dart';

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
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    customTextFormField(
                      prefixIcon: const Icon(Icons.search),
                      textInputType: TextInputType.text,
                      hintText: 'search a product',
                      onSubmitted: (String text) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).searchProduct(text: text);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProducts(
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teast2/core/network/network_info.dart';
import 'package:teast2/features/posts/data/datasources/post_local_data_source.dart';
import 'package:teast2/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:teast2/features/posts/data/repositories/post_repository_impl.dart';
import 'package:teast2/features/posts/domain/usecases/add_post.dart';
import 'package:teast2/features/posts/domain/usecases/delete_post.dart';
import 'package:teast2/features/posts/domain/usecases/get_all_posts.dart';
import 'package:teast2/features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/pages/posts_pages.dart';
import 'injection_container.dart' as di;
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences,));
}

class MyApp extends StatelessWidget {

final SharedPreferences sharedPreferences;
  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>PostsBloc(getAllPosts: GetAllPostsUserCase(PostsRepositoryImpl(
            remoteDateSource: PostRemoteDataSourceImpl(client: Client()), 
            localDateSource: PostLocalDataSourceImpl(sharedPreferences: sharedPreferences),
            netWorkInfo: NetworkInfoImpl(InternetConnection())
        )))..add(GetAllPostsEvent())),
        BlocProvider(create: (_)=>AddDeleteUpdatePostsBloc(addPosts: AddPostUseCase(PostsRepositoryImpl(
            remoteDateSource: PostRemoteDataSourceImpl(client: Client()),
            localDateSource: PostLocalDataSourceImpl(sharedPreferences: sharedPreferences),
            netWorkInfo: NetworkInfoImpl(InternetConnection())
        )), updatePosts: UpdatePostUseCase(PostsRepositoryImpl(
            remoteDateSource: PostRemoteDataSourceImpl(client: Client()),
            localDateSource: PostLocalDataSourceImpl(sharedPreferences: sharedPreferences),
            netWorkInfo: NetworkInfoImpl(InternetConnection())
        )), deletePosts: DeletePostsUseCase(PostsRepositoryImpl(
            remoteDateSource: PostRemoteDataSourceImpl(client: Client()),
            localDateSource: PostLocalDataSourceImpl(sharedPreferences: sharedPreferences),
            netWorkInfo: NetworkInfoImpl(InternetConnection())
        ))))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostsPages(),

      ),
    );

  }
}
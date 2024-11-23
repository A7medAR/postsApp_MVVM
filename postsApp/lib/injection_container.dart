// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:teast2/features/posts/data/repositories/post_repository_impl.dart';
// import 'core/network/network_info.dart';
// import 'features/posts/data/datasources/post_local_data_source.dart';
// import 'features/posts/data/datasources/post_remote_data_source.dart';
// import 'features/posts/domain/usecases/add_post.dart';
// import 'features/posts/domain/usecases/delete_post.dart';
// import 'features/posts/domain/usecases/get_all_posts.dart';
// import 'features/posts/domain/usecases/update_post.dart';
// import 'features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
// import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

// GetIt sl = GetIt.instance;
// Future<void> init() async{
//
//   /// features - posts
//
//   // Bloc
//
//   sl.registerFactory(()=> PostsBloc(getAllPosts: sl()));
//   sl.registerFactory(()=> AddDeleteUpdatePostsBloc( addPosts:  sl(),
//       updatePosts: sl(),
//       deletePosts: sl()));
//
//   //UseCases
//
//   sl.resetLazySingleton(()=>GetAllPostsUserCase(sl()));
//   sl.resetLazySingleton(instance: ()=>AddPostUseCase(sl()));
//   sl.resetLazySingleton(instance: ()=>DeletePostsUseCase(sl()));
//   sl.resetLazySingleton(instance: ()=>UpdatePostUseCase(sl()));
//
//   //Repository
//
//
//   sl.resetLazySingleton(
//       instance: () => PostsRepositoryImpl(
//           remoteDateSource: sl(),
//           localDateSource: sl(),
//           netWorkInfo: sl(),
//       )
//   );
//
//   // DataSources
//
//   sl.resetLazySingleton(()=>PostRemoteDataSourceImpl( client: sl(),));
//   sl.resetLazySingleton(instance:()=>PostLocalDataSourceImpl(sharedPreferences: sl(),));
//
//   /// core
//
//   sl.resetLazySingleton(instance:()=>NetworkInfoImpl(sl())) ;
//
//   /// External
// final sharedPreferences = await SharedPreferences.getInstance();
//
//   sl.resetLazySingleton(instance:()=>sharedPreferences);
//
//   sl.resetLazySingleton(instance:()=>http.Client());
//
//   sl.resetLazySingleton(instance:()=>InternetConnection());
//
//
//
// }
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';


GetIt locator = GetIt.instance;

Future<void> init() async {

  locator.registerLazySingleton(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton(() => InternetConnectionChecker());


}

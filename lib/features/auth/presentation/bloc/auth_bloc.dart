import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    late GoogleSignInAccount? gUser; //google ga kirish uchun google signIn accaunt
    late GoogleSignInAuthentication gAuth;
    late OAuthCredential credential;
    late String? accessToken;
    on<SignInWithGoogleEvent>((event, emit) async {
      //google account orqali sistemaga kirishni amalga oshirish, bu google accauntni tanlaydigan
      // yoki accaunt kiritiladgan oynani ochib berishi kere
      gUser = await googleSignIn.signIn();
      //endi shu tanlangan accaunt bilan Googledan autentifikatsiyadan o'tishga harakat qilib ko'ramiz.
      gAuth = await gUser!.authentication;
      //agar autentifikatsiya muvaffaqiyatli bo'lsa user malumotlarini olib unga yangi credential yaratamiz.
      //u uchun google accauntdan access va id tokenlar kere boladi.
      credential = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      //endi bizda user credentiali bor(uchetny dannylari), endi sistemaga kirish uchun Firebase metodidan foydalanamiz.
      var signInGoogle = await FirebaseAuth.instance.signInWithCredential(credential);
      //google sign in uchun yuqoridagilar yetarli,
      //agar biz uni bizga berilgan apiga yuborishimiz kere bosa pasdagi codelar kere boladi.
      emit(
        state.copyWith(
            firstName: signInGoogle.additionalUserInfo?.profile![0],
            lastName: signInGoogle.additionalUserInfo?.profile![1]),
      );
      // accessToken = signInGoogle.credential?.accessToken;
      // if (accessToken != null) {
      // final result = await postGoogleLoginUseCase(accessToken);
      // if (result.isRight) {
      //   // StorageRepository.putString(StoreKeys.refresh, result.right.refreshToken);
      //   // StorageRepository.putString(StoreKeys.token, result.right.accessToken);
      //   // StorageRepository.putString(StoreKeys.email, result.right.user.email);
      //   // StorageRepository.putBool(key: StoreKeys.isAuthenticated, value: true);
      //   emit(
      //     state.copyWith(firstName: result.right.user.firstName, lastName: result.right.user.lastName),
      //   );
      event.onSuccess();
      // } else {
      //   event.onError();
      // }
      // }
    });

    on<SignOutWithGoogleEvent>((event, emit) async {
      return await googleSignIn
          .signOut()
          .then((value) => {emit(state.copyWith(firstName: null, lastName: null)), event.onSuccess()});
    });
  }
}

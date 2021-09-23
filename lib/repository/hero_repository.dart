import 'package:super_hero/models/hero.dart';
import 'package:super_hero/services/dio_provider_base.dart';

class HeroRepository {
  Future<List<HeroModel>> getList(String filter) async {
    List<HeroModel> listHero;
    final dataResult = await DioProviderBase().get('search/$filter', {});
    final results = dataResult.data['results'];

    if (results != null) {
      var list = results.map((doc) => HeroModel.fromJson(doc)).toList();
      listHero = list.cast<HeroModel>();
    }

    return listHero;
  }
}

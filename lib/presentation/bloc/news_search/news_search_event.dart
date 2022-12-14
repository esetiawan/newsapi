part of 'news_search_bloc.dart';

abstract class NewsSearchEvent extends Equatable
{
    const NewsSearchEvent();
    @override
    List<Object> get props => [];
}
//memproses input dari user yang menyebabkan perubahan state
class OnQueryNewsChanged extends NewsSearchEvent {
  final String query;
  OnQueryNewsChanged(this.query);
  @override
  List<Object> get props => [query]; //diisi semua input dari user
}
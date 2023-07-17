import 'package:flutter/cupertino.dart';
import 'package:spotted/app/model/job_model.dart';
import 'package:spotted/app/repository/job_repository.dart';

class JobController{
  List<JobModel> todos = [];

  final _repository = JobRepository();

  //Setando estado inicial
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    
    try {
      todos = await _repository.getJobModels();

      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState {
  start, loading, success, error
}
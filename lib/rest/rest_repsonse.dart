class RestResponse<T> {
  Status status;
  T data;
  String message;

  RestResponse.loading(this.message) : status = Status.LOADING;
  RestResponse.completed(this.data) : status = Status.COMPLETED;
  RestResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

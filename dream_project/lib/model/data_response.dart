typedef ErrorMsgCode(int errorCode);

class DataResponse<T>
{
  T? data;
  int errorCode = -1;
  ErrorMsgCode? _errorMsgCode;

  DataResponse({T? data, int? errorCode})
  {
    this.data = data;
    this.errorCode = errorCode ?? -1;
  }

  void setErrorMsgCode({required ErrorMsgCode errorMsgCode})
  {
    _errorMsgCode = errorMsgCode;
  }

  String errorMsg()
  {
    return _errorMsgCode != null?_errorMsgCode!(errorCode): "";
  }

  bool isError()
  {
    return errorCode != -1;
  }

}
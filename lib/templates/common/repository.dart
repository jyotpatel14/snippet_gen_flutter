import 'dart:io';

import 'package:snippet_gen/my_print.dart';

void generateRepository(
  String path,
  String pascal,
  String lower,
  bool isAbstract,
) {
  MyPrint.printOnConsole("IsRepoAbs $isAbstract");
  final file = File('$path/${lower}_repository.dart');

  file.writeAsStringSync('''

import '../../api/api_call_model.dart';
import '../../api/api_endpoints.dart';
import '../../api/rest_client.dart';
import '../../model/commons/data_response_model.dart';
import '../../model/commons/model_data_parser.dart';
import '../../utils/my_print.dart';

class ${pascal}Repository {
  final ApiController apiController;

  const ${pascal}Repository({required this.apiController});

  Future<DataResponseModel<dynamic>> getAll() async {

    ${!isAbstract ? '''
    
    ApiEndpoints apiEndpoints = apiController.apiEndpoints;

    MyPrint.printOnConsole("${pascal} -> Get All");

    ApiCallModel apiCallModel =
        await apiController.getApiCallModelFromData<String>(
      restCallType: RestCallType.simpleGetCall,
      parsingType: ModelDataParsingType.${lower}List,
      url: apiEndpoints.getAll${pascal}(),
      isAuthenticatedApiCall: true,
    );

    return await apiController.callApi<dynamic>(
      apiCallModel: apiCallModel,
    );
  ''' : "// TODO: implement to fetch all"}
    
  }

  Future<DataResponseModel<dynamic>> getById(String id) async {

    ${!isAbstract ? '''
 ApiEndpoints apiEndpoints = apiController.apiEndpoints;

    MyPrint.printOnConsole("${pascal} -> Get By Id: \$id");

    ApiCallModel apiCallModel =
        await apiController.getApiCallModelFromData<String>(
      restCallType: RestCallType.simpleGetCall,
      parsingType: ModelDataParsingType.${lower}Detail,
      url: apiEndpoints.get${pascal}ById(id),
      isAuthenticatedApiCall: true,
    );

    return await apiController.callApi<dynamic>(
      apiCallModel: apiCallModel,
    );
''' : "// TODO: implement to get by id"}
   
  }

  Future<DataResponseModel<dynamic>> create(dynamic request) async {
    ${!isAbstract ? '''
  ApiEndpoints apiEndpoints = apiController.apiEndpoints;

    MyPrint.printOnConsole("${pascal} -> Create");

    ApiCallModel apiCallModel =
        await apiController.getApiCallModelFromData<dynamic>(
      restCallType: RestCallType.simplePostCall,
      parsingType: ModelDataParsingType.${lower}Detail,
      url: apiEndpoints.create${pascal}(),
      requestBody: request,
      isAuthenticatedApiCall: true,
    );

    return await apiController.callApi<dynamic>(
      apiCallModel: apiCallModel,
    );
''' : "// TODO: implement to create"}
  }

  Future<DataResponseModel<dynamic>> update(String id, dynamic request) async {
    ${!isAbstract ? ''' 
      ApiEndpoints apiEndpoints = apiController.apiEndpoints;

    MyPrint.printOnConsole("${pascal} -> Update: \$id");

    ApiCallModel apiCallModel =
        await apiController.getApiCallModelFromData<dynamic>(
      restCallType: RestCallType.simplePutCall,
      parsingType: ModelDataParsingType.${lower}Detail,
      url: apiEndpoints.update${pascal}(id),
      requestBody: request,
      isAuthenticatedApiCall: true,
    );

    return await apiController.callApi<dynamic>(
      apiCallModel: apiCallModel,
    );
    ''' : "// TODO: Implement update item"}
  }

  Future<DataResponseModel<dynamic>> delete(String id) async {
    ${!isAbstract ? '''
  ApiEndpoints apiEndpoints = apiController.apiEndpoints;

    MyPrint.printOnConsole("${pascal} -> Delete: \$id");

    ApiCallModel apiCallModel =
        await apiController.getApiCallModelFromData<String>(
      restCallType: RestCallType.simpleDeleteCall,
      parsingType: ModelDataParsingType.defaultResponse,
      url: apiEndpoints.delete${pascal}(id),
      isAuthenticatedApiCall: true,
    );

    return await apiController.callApi<dynamic>(
      apiCallModel: apiCallModel,
    );
''' : "// TODO: Implement to delete item"}
  }
}
''');
}

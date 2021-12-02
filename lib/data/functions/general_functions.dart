

class GeneralFunctions {
  static Future<Map<String, String>> getHeaders(
     ) async {
    var token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IksxIiwicGkuYXRtIjoid2FvMyJ9.eyJzY29wZSI6Im9wZW5pZCIsImNsaWVudF9pZCI6ImludGVsbGlkZWFsIiwiYWdpZCI6ImVMUkdvNEZCckp1UzU4MUplR1kxQlV3TXhoQUpaUm5RIiwiZW1haWxBZGRyZXNzIjoiRGVhbGVyMVVzZXIxVUFUQ0xHWEBtYWlsaW5hdG9yLmNvbSIsInVzZXJuYW1lIjoiRGVhbGVyMVVzZXIxVUFUQ0xHWEBtYWlsaW5hdG9yLmNvbSIsImV4cCI6MTYxMzgyNzM2NH0.VQDuo6ySx0gKf6dPh9Mha309ah1oBdyGz3Qqe2ybIGoDFo1jjROxkWQXy-QAO-b_wL05Vlxm1DyZL-ChKqm_qULtmfnVdg1bTNZmWMLjMkKtkqUfsVdQ6TL1gO4gu3JLGyiZlwef7o9X_BzfCawfhxSjT11PE7xHIOQXFF77wxUIe7PSrISRcJiK18SJftHD5HbaiXlPwPbn8fDA0QMZe24wZSlNUYMGYwt5gA5t7qINayiDq_6kDTJPAGe4nyRcQ0SVX73GQwQyFQBovsPhQhfVMJCCpT5DoN9q-XLNf77hR0PklXzQdItq3w4OoZuF3mwUG3l4JKesJbGQi1e0Ww";
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return headers;
  }


}
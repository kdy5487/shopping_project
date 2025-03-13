import 'package:shopping_project/shopping_project.dart' as shopping_project;
import 'dart:io'; //사용자의 입력을 받는 라이브러리

class Product {
  //상품을 정의하는 'product'클래스
  //속성 2개

  String name; //상품 이름
  int price; // 상품 1개당 가격

  Product(this.name, this.price); //매개변수 생성자, this 필수
}

class ShoppingMall {
  //쇼핑몰을 정의하는 'shoppingmall'클래스
  //속성 2개
  List<Product> products = [
    //'product'객체를 리스트: 판매하는 상품 목록 5개
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];
  int total = 0; //장바구니에 담은 상품들의 총 가격

  //메서드 3개
  //네임드 생성자

  void showProducts() {
    // 1) 상품 목록을 출력하는 메서드
    for (var product in products) {
      //products list의 요소를 순회하니까 for-in 사용
      print('${product.name} / ${product.price}원'); //하나씩 상품 목록 출력
    }
  }

  void addToCart() {
    // 2) 상품을 장바구니에 담는 메서드
    // 상품이름과 상품갯수 입력 받기.
    print('상품 이름을 입력해 주세요 !');
    String? productName = stdin.readLineSync(); //상품 이름 입력받기(string)
    print('상품 갯수를 입력해 주세요 !');
    String? numberOfProduct =
        stdin.readLineSync(); //상품 갯수 입력받기(string) << int로 바꿔줄 필요 있음.

    //예외처리 및 int 변환
    int numberOfProductInt;
    try {
      numberOfProductInt = int.parse(numberOfProduct!);
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
      return;
    }
    //상품이 존재하는지 확인.
    bool containproduct = products.any(
      (Product) => Product.name == productName,
    );

    if (containproduct && (numberOfProductInt > 0)) {
      print('장바구니에 상품이 담겼어요 !');
    } else if (!containproduct) {
      print('입력값이 올바르지 않아요 !');
      return;
    } else if (numberOfProductInt <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }

    //상품 객체 가져오기 (firstWhere 사용)
    Product selectedProduct = products.firstWhere(
      (product) => product.name == productName,
    );

    total += selectedProduct.price * numberOfProductInt;
  }

  void showTotal() {
    // 3) 장바구니에 담은 상품의 총 가격을 출력하는 메서드

    print('장바구니에 $total원 어치를 담으셨네요 !');
  }
}

//메인 함수
void main() {
  ShoppingMall mall = ShoppingMall(); //클래스의 메서드를 호출
  bool isRunning = true;
  while (isRunning) {
    //프로그램 항상 실행하도록 함.
    print(
      "[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료",
    );
    String? input = stdin.readLineSync(); //사용자 입력 받기
    // 4개의 값에 대한 경우를 한번에 처리하므로 switch를 통해 사용자의 입력 처리
    switch (input) {
      case "1":
        mall.showProducts(); // 상품 목록 보기
        break;

      case "2":
        mall.addToCart(); //장바구니 담기
        break;

      case "3":
        mall.showTotal(); //장바구니에 담긴 상품의 총 가격보기
        break;

      case "4": //프로그램 종료
        isRunning = false; // 거짓을 통해 반복문 탈출
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}

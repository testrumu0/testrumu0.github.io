$(function () {
    /*공통적용 left box 마우스오버 한꺼번에 적용*/
    $('#gnb01, #gnb02, #gnb03, #gnb04, #gnb05').hover(function(){
            $(this).css('backgroundColor','#3b3759');
            $(this).find('a').css('color','#fff');
        }, function(){
            $(this).css('backgroundColor','#fff'),
            $(this).find('a').css('color','#000');
    });
    
 
    /*마우스 오버시 버튼 텍스트 색 변경 book_add_sub_page*/
    $('.btn1, .btn2').hover(function(){
        $(this).css({
            'color': '#000',
            'font-weight':'600'
        });
    }, function(){
        $(this).css('color','#fff');
    });
    
    /*마우스 오버시 버튼 스타일 변경 book_alarm_page*/
    $('#pro_btn, #submit_btn, #cancel_btn').hover(function(){
        $(this).css({
            'color':'#fff',
            'backgroundColor':'#3b3759' 
        });
        
    },function(){
         $(this).css({
            'color':'#000',
            'backgroundColor':'#fff'         
        });       
    });
    
    /*마우스 오버시 버튼 스타일 변경 record_page*/
    $('#add, #upd, #del, #back').hover(function(){
        $(this).css({
            'color':'#fff',
            'backgroundColor':'#3b3759'
        });
        
    },function(){
         $(this).css({
            'color':'#000',
            'backgroundColor':'#fff'         
        });       
    });

    
    /*마우스 오버시 버튼 색 변경 mylibrary_page*/
    $('.list_btn').find('a').hover(function(){
        $(this).css('color','#000');
    }, function(){
        $(this).css('color','#ccc');
    });



    
});
        $(function(){
           /* 서비스소개 left 메뉴 누를시 */
           if($(window).width() >= 800){
                $('div.left_menu li').click(function() {
                    var scrollAnchor1 = $(this).attr('data-scroll'),
                        scrollPoint1 = $('section[data-anchor="' + scrollAnchor1 + '"]').offset().top - 86;
                $('body,html').animate({
                        scrollTop: scrollPoint1
                    }, 500);
                });
            }
            
            if($(window).width() < 799){
                $('div.sub1 ul > li').click(function() {
                    var scrollAnchor2 = $(this).attr('data-scroll'),
                        scrollPoint2 = $('section[data-anchor="' + scrollAnchor2 + '"]').offset().top - 90;
                    $('body,html').animate({
                        scrollTop: scrollPoint2
                    }, 500);
                }); 
                
                $('div.sub2 ul > li').click(function() {
                    var scrollAnchor3 = $(this).attr('data-scroll'),
                        scrollPoint3 = $('section[data-anchor="' + scrollAnchor3 + '"]').offset().top - 136;    
                    $('body,html').animate({
                        scrollTop: scrollPoint3
                    }, 500);
                });     
            }  	
			/* // 서비스소개 left 메뉴 누를시 */
			
			/* 맨위로 이동 */
			$('div.go_top').bind("click",function(){
                $('html, body').animate({scrollTop : 0}, {queue: false}, 500); 
                event.preventDefault();
            });
            /* // 맨위로 이동 */
           
           /* 스크롤시 div 이동 및 누를시 해당되는 div 이동 */
			var leftInit = $(".menu").offset().left; 
            $(window).scroll(function() {
                var x = 0 - $(this).scrollLeft();
        
                $(".menu").offset({
                    left: x + leftInit
                });
                
                var windscroll = $(window).scrollTop();
                
                if ($(this).scrollTop() > 330) {
                    $('div.go_top').fadeIn();
                } else {
                    $('div.go_top').fadeOut();
                }
                
                if (windscroll >= 10) {
                    $('div.introduction section').each(function(i) {
                        if ($(this).position().top <= windscroll + 350) {
                            $('div.sub1 li.active').removeClass('active');
                            $('div.sub1 li').eq(i).addClass('active');
                        }
                    });
                    
                    $('div.main_function section').each(function(i) {
                        if ($(this).position().top <= windscroll + 350) {
                            $('div.sub2 li.active').removeClass('active');
                            $('div.sub2 li').eq(i).addClass('active');
                        }
                    });
                }else{
                    $('div.sub1 li').removeClass('active');
                    $('div.sub2 li').removeClass('active');
                    $('div.sub1 li:first').addClass('active');
                    $('div.sub2 li:first').addClass('active');
                }
            
            }).scroll();
            /* // 스크롤시 div 이동 및 누를시 해당되는 div 이동 */
        });
        

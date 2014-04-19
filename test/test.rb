require 'liquid'


fs =Liquid::LocalFileSystem.new("../template/")
Liquid::Template.file_system = fs

puts Liquid::Template.parse("{% include 'people' %}").render({'people'=>{
  'name'=>'黄帝',
  'xing'=>'公孙',
  'ming'=>'轩辕',
  'relations'=>[
    {
      'name'=>'父',
      'peoples'=>[
        {
          'name'=>'少典',
          'id'=>'shaodian'
        }
      ]
    },{
      'name'=>'妻',
      'peoples'=>[
        {
          'name'=>'嫘祖',
          'id'=>'luozhu'
        }
      ]
    },{
      'name'=>'子',
      'peoples'=>[
        {
          'name'=>'玄嚣',
          'id'=>'xuanxiao'
        },
        {
          'name'=>'昌意',
          'id'=>'changyi'
        }
      ]
    },{
      'name'=>'孙',
      'peoples'=>[
        {
          'name'=>'颛顼',
          'id'=>'zhuanxu'
        }
      ]
    }
  ]
}})


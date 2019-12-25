// raid.flow
// 只杀韦一笑,殷天正,张无忌,杨逍,范遥五个人
// 四区白三三
[if] (_DungeonHpThreshold) == null
    ($_DungeonHpThreshold) = 50
[if] (_DungeonWaitSkillCD) == null
    ($_DungeonWaitSkillCD) = 打开
[if] (_DungeonBagCleanWay) == null
    ($_DungeonBagCleanWay) = 存仓及售卖
#select ($_DungeonHpThreshold) = 副本内疗伤，当气血低于百分比,100|90|80|70|60|50|40|30|20|10,(_DungeonHpThreshold)
#select ($_DungeonWaitSkillCD) = 进副本前先等待技能冷却,打开|关闭,(_DungeonWaitSkillCD)
#select ($_DungeonBagCleanWay) = 背包清理方案,不清理|售卖|存仓及售卖,(_DungeonBagCleanWay)
#input ($_repeat) = 重复次数,1
#config
[if] (arg0) != null
    ($_DungeonHpThreshold) = (arg0)
[if] (arg1) != null
    ($_DungeonWaitSkillCD) = (arg1)
[if] (arg2) != null
    ($_DungeonBagCleanWay) = (arg2)
[if] (arg3) != null
    ($_repeat) = (arg3)
<-stopSSAuto
stopstate
<---
($hpPer) = (_DungeonHpThreshold)/100
[if] (:hpPer) < (hpPer)
    @liaoshang
--->
<-recordGains
($_i) = 0
[while] (_i) < (_repeat)
    @renew
    [if] (_DungeonBagCleanWay) == 售卖
        @cleanBag
    [else if] (_DungeonBagCleanWay) == 存仓及售卖
        @tidyBag
    // 副本
    [if] (_DungeonWaitSkillCD) == 打开
        @cd
    jh fb 26 start1
    cr mj/shanmen
    go north;go west;go northwest
    go north[5]
    @kill 韦一笑,殷天正
    go north[2]
    @kill 张无忌,杨逍,范遥
    cr;cr over
    ($_i) = (_i) + 1
[if] (_DungeonBagCleanWay) == 售卖
    @cleanBag
[else if] (_DungeonBagCleanWay) == 存仓及售卖
    @tidyBag
$to 住房-练功房;dazuo
recordGains->
stopSSAuto->
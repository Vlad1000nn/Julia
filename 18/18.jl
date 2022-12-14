function spiral_1!(stop_condition::Function, robot)           #Спираль_1
    n=0
    side=Nord
    while !stop_condition()
        n+=1
        for _i in 1:2
        along_1!(robot,side,n,stop_condition)
        side=left(side)
        end
    end
end

function along_1!(robot,side,n,stop_condition::Function)
    for _i in 1:n
        if (!stop_condition())
            wall_recursion!(robot,side)
        end
    end
end


function wall_recursion!(robot,side)            #Рекурсивно обход стены
    if (isborder(robot,side))
        move!(robot,right(side))
        wall_recursion!(robot,side)
        move!(robot,inverse(right(side)))
    else
        move!(robot,side)
    end

end


function  shuttle!(stop_condition::Function, robot, side)       #Челнок обход стены
    n=0 
    start_side=side
while !stop_condition() 
 n += 1
 along_shuttle!(robot, right(side), n,()->!isborder(robot,start_side))
 side = inverse(side)
 if (stop_condition())
    break
 end
 along_shuttle!(robot,right(side),2n,()->!isborder(robot,start_side))
 side=inverse(side)
 if (stop_condition())
    break
 end
 along_shuttle!(robot,right(side),n,()->!isborder(robot,start_side))
end
if (n!=0)
    move!(robot,start_side)
    for _i in 1:n
        move!(robot,(right(side)))
    end
end
if (n==0)
    move!(robot,start_side)
end
end

function  along_shuttle!(robot, side, n,stop_condition::Function)        
for _i in 1:n
    if (!stop_condition())
    move!(robot,side)
    end
end
end


function spiral_2!(stop_condition::Function, robot)           #Спираль_2
n=0
side=Nord
while !stop_condition()
    n+=1
    for _i in 1:2
    along!(robot,side,n,stop_condition)
    side=left(side)
    end
end
end

function along!(robot,side,n,stop_condition::Function)
for _i in 1:n
    if !stop_condition()
    shuttle!(()->!isborder(robot,side),robot,side)
    end
end
end

function main1!(robot)
spiral_1!(()->ismarker(robot),robot)
end

function main2!(robot)
spiral_2!(()->ismarker(robot),robot)
end

right(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+1, 4))
left(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)-1, 4))
inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))
pico-8 cartridge // http://www.pico-8.com
version 5
__lua__
--cash castle
--by ashley pringle

debug=false
debug_l={}
debug_l[4]=0

function debug_u()
	debug_l[1]=timer
	debug_l[2]="mem="..stat(0)
	debug_l[3]="cpu="..stat(1)
	if stat(1)>debug_l[4] then
		debug_l[4]=stat(1)
	end
	debug_l[5]="actors:"..#actors
	debug_l[6]="creats:"..#actors.creatures
	debug_l[7]="items:"..#actors.items
	debug_l[8]="cursors:"..#actors.cursors
	if p!=nil then
	debug_l[9]="inv:"..#p.inventory
--	debug_l[10]="px="..p.x
--	debug_l[11]="py="..p.y
	debug_l[10]="curx="..cur.x
	debug_l[11]="cury="..cur.y
	debug_l[12]="lvl="..level
	end
	if actortypes[2]!=nil then
	debug_l[13]=actortypes[2].ch
	debug_l[14]=actortypes[2].ch2
	end
	if rltns!=nil then
	for a=1,#rltns do
		debug_l[14+a]=feelings[rltns[a].fe].." li:"..feelings[rltns[rltns[a].li].fe].." ha:"..feelings[rltns[rltns[a].ha].fe]
		--debug_l[13+a]=
	end
	end
	--debug_l[20]=closestactor(p,actors.items)
--	debug_l[13]=control_inv
end

function words()
	feelings={}
	feelings[1]="lugubrious"
	feelings[2]="winsome"
	feelings[3]="ineffable"
	feelings[4]="morose"
	feelings[5]="arrested"
	feelings[6]="polite"
	feelings[7]="obvious"
	feelings[8]="trite"	
	feelings[9]="prideful"
	feelings[10]="forward"
	feelings[11]="oblivious"
	feelings[12]="artful"
	feelings[13]="princessly"
	feelings[14]="angelic"
	feelings[15]="friendly"
	feelings[16]="ostentatious"
	
	adjectives={}
	adjectives[1]="jaunty"
	adjectives[2]="gibbous"
	adjectives[3]="chattering"
	adjectives[4]="tumescent"
	adjectives[5]="unctuous"
	adjectives[6]="effervesent"
	adjectives[7]="subcutaneous"
	adjectives[8]="deplorable"
	adjectives[9]="analytic"
	adjectives[10]="loathsome"
	adjectives[11]="incomprehensible"
	adjectives[12]="greater"
	adjectives[13]="lesser"
	adjectives[14]="conservative"
	adjectives[15]="moderate"
	adjectives[16]="impatient"
	adjectives[17]="alright"
	adjectives[18]="reasonable"
	adjectives[19]="decent"
	adjectives[20]="unloved"
	adjectives[21]="failed"
	adjectives[22]="prospering"
	adjectives[23]="learned"
	adjectives[24]="disappointing"
	adjectives[25]="mundane"
	adjectives[26]="misunderstood"
	adjectives[27]="hairy"
	adjectives[28]="sartorial"
	adjectives[29]="swarthy"
	
	pronouns={}
	pronouns[1]="half-"
	pronouns[2]="demi-"
	pronouns[3]="hyper-"
	pronouns[4]="aqua-"
	pronouns[5]="anti-"
	pronouns[6]="meta-"
	pronouns[7]="robo-"
	pronouns[8]="hoary-"
	pronouns[9]="gnar-"
	pronouns[10]="were-"
	pronouns[11]="semi-"
	pronouns[12]=""
	
	species={}
	species[1]="bear"
	species[2]="fish"
	species[3]="blog"
	species[4]="crow"
	species[5]="wyrm"
	species[6]="griffin"
	species[7]="serpent"
	species[8]="boar"
	species[9]="stud"
	species[10]="whal"
	species[11]="cock"
	species[12]="hippo"
	species[13]="t rex"
	species[14]="bot"
	species[15]="sleuth"
	species[16]="sloth"
	species[17]="wicca"
	species[18]="mummy"
	species[19]="ghoul"
 species[20]="gull"
	species[21]="manticore"
	species[22]="bro"
	species[23]="zorse"
	
	objects={}
	objects[1]="pillar"
	objects[2]="mass of vines"
	objects[3]="obelisk"
	objects[4]="pile of tires"
	objects[5]="strange machine"
	
	places={}
	places[1]="marsh"
	places[2]="vista"
	places[3]="palace"
	places[4]="garden"
	places[5]="mine"
	places[6]="isle"
	places[7]="cavern"
	places[8]="tundra"
	places[9]="lagoon"
	places[10]="desert"
	places[11]="aerie"
	places[12]="strait"
	places[13]="plateau"
	places[14]="mountain"
	places[15]="valley"
	places[16]="spaceship"
	
	items={}
	items[1]="cash"
	items[2]="potion"
	items[3]="lazer"
	items[4]="a butt"
	
	dial={}
	dial[1]="chubby wubby!"
	dial[2]="ceh'thoen vho..."
	dial[3]="szrt. oreh mmern!"
	dial[4]="my mom is mean!"
	dial[5]="hello......."
	
	tut={"","","button 1 to examine","button 2 to inventory"}
end

function actortypes_i(l,r)
	chars="@abcdefghijklmnopqrstuvwxyz0123456789!#%^*():;,.{}&$ "
	local enemycolours={2,8,3,12}

	rltns={}
	--temp index to delete feelings that have been selected already
	local ind={}
	for a=1,#feelings do
		ind[a]=a
	end
	for a=1,r do
		rltns[a]={}
		local fe=ind[rndint(#ind)]
		rltns[a].fe=fe
		--rltns[a].li=a --this is just to set up the below code that stops liking your own feeling
		rltns[a].li=a --this is just to set up the below code that stops liking your own feeling
		rltns[a].ha=a --samesies
		del(ind,fe) --remove assigned feeling from temp index so it doens't get assigned to another actor
	end
	for a=1,r do
		--while rltns[a].li==a do
		--	rltns[a].li=flr(rnd(r))+1
		--end
		while rltns[a].ha==a or rltns[a].ha==rltns[a].li do
			rltns[a].ha=rndint(r)
		end
	end
	
	actortypes={}
	for a=1,13 do
		actortypes[a]={}
	end		
	--player attributes
	local ad=rndint(#adjectives)
	local pn=#pronouns if rnd(1)<=0.5 then pn=rndint(#pronouns) end
	local sp=rndint(#species)
	local rl=rndint(#rltns)

	actortypes[1].ch=sub(chars,1,1)
	actortypes[1].c=7
	actortypes[1].m=1
	actortypes[1].ad=ad
	actortypes[1].pn=pn
	actortypes[1].sp=sp
	actortypes[1].rl=rl
	actortypes[1].solid=true
	
	--wall attributes
	local ch=rndint(#chars)
	local ch2=rndint(#chars)
	actortypes[2].ch=sub(chars,39,39)
	actortypes[2].ch2=sub(chars,1,1)
	actortypes[2].c=1
	actortypes[2].c2=13
	actortypes[2].sp=rndint(#objects)
	actortypes[2].solid=true
	
	--enemy attributes
	ch=rndint(#chars)
	actortypes[3].ch=sub(chars,1,1)
	actortypes[3].ch2=sub(chars,1,1)
	actortypes[3].c=choose(enemycolours,true)
	actortypes[3].c2=5
	actortypes[3].m=2
	actortypes[3].ad=rndint(#adjectives)
	actortypes[3].pn=#pronouns if rnd(1)<=0.5 then actortypes[3].pn=rndint(#pronouns) end
	actortypes[3].sp=rndint(#species)
	actortypes[3].rl=rndint(#rltns)
	actortypes[3].solid=true
	actortypes[3].dial=rndint(#dial)

	--cash attributes
	local ch=rndint(#chars)
	actortypes[4].ch=sub(chars,16,16)
	actortypes[4].c=10
	actortypes[4].m=0
	actortypes[4].sp=1
	actortypes[4].solid=false
	actortypes[4].snd=4

	--exit attributes
	actortypes[5].ch="&"
	actortypes[5].c=11
	actortypes[5].m=0
	actortypes[5].solid=false
	actortypes[5].snd=6

	--potion?
	actortypes[6].ch="~"
	actortypes[6].c=13
	actortypes[6].m=0
	actortypes[6].sp=2
	actortypes[6].solid=false
	actortypes[6].snd=5

	--enemy attributes
	ch=rndint(#chars)
	actortypes[7].ch=sub(chars,1,1)
	actortypes[7].ch2=sub(chars,1,1)
	actortypes[7].c=choose(enemycolours,true)
	actortypes[7].c2=5
	actortypes[7].m=2
	actortypes[7].ad=rndint(#adjectives)
	actortypes[7].pn=#pronouns if rnd(1)<=0.5 then actortypes[7].pn=rndint(#pronouns) end
	actortypes[7].sp=rndint(#species)
	actortypes[7].rl=rndint(#rltns)
	actortypes[7].solid=true
	actortypes[7].dial=rndint(#dial)

	--enemy attributes
	ch=rndint(#chars)
	actortypes[8].ch=sub(chars,1,1)
	actortypes[8].ch2=sub(chars,1,1)
	actortypes[8].c=choose(enemycolours,true)
	actortypes[8].c2=5
	actortypes[8].m=2		
	actortypes[8].ad=rndint(#adjectives)
	actortypes[8].pn=#pronouns if rnd(1)<=0.5 then actortypes[8].pn=rndint(#pronouns) end
	actortypes[8].sp=rndint(#species)
	actortypes[8].rl=rndint(#rltns)
	actortypes[8].solid=true
	actortypes[8].dial=rndint(#dial)

	--tree attributes
--	local ch=rndint(#chars)
--	local ch2=rndint(#chars)
	actortypes[9].ch=sub(chars,44,44)
	actortypes[9].ch2=sub(chars,41,41)
	actortypes[9].c=4
	actortypes[9].c2=11
	actortypes[9].sp=rndint(#objects)
	actortypes[9].solid=true

	--ground attributes
	local ch=48
	actortypes[10].ch=sub(chars,ch,ch)
	actortypes[10].c=5
	actortypes[10].sp=rndint(#objects)
	actortypes[10].solid=false

	--cursor abilities
	actortypes[11].ch=sub(chars,#chars,#chars)
	actortypes[11].c=8
	actortypes[11].solid=false
	actortypes[11].m=1

	--enemy attributes
	ch=rndint(#chars)
	actortypes[12].ch=sub(chars,1,1)
	actortypes[12].ch2=sub(chars,1,1)
	actortypes[12].c=choose(enemycolours,true)
	actortypes[12].c2=5
	actortypes[12].m=2
	actortypes[12].ad=rndint(#adjectives)
	actortypes[12].pn=#pronouns if rnd(1)<=0.5 then actortypes[12].pn=rndint(#pronouns) end
	actortypes[12].sp=rndint(#species)
	actortypes[12].rl=rndint(#rltns)
	actortypes[12].solid=true
	actortypes[12].dial=rndint(#dial)
	
	--flower attributes
	local ch=rndint(#chars)
	local ch2=rndint(#chars)
	actortypes[13].ch=sub(chars,41,41)
	actortypes[13].ch2=sub(chars,46,46)
	actortypes[13].c=9
	actortypes[13].c2=3
	actortypes[13].sp=rndint(#objects)
	actortypes[13].solid=true

end

function rooms_i(ss,sa)
	rooms={}
	for b=0,3 do
		rooms[b]={}
		rooms[b].sector_s=ss
		rooms[b].sector_a=sa --6 is max here!
		rooms[b].room_w=rooms[b].sector_s*rooms[b].sector_a
		rooms[b].dark=false

		rooms[b].c=flr(rnd(6))
		rooms[b].ad=rndint(#adjectives)
		rooms[b].pl=rndint(#places)
		for a=0,sa*sa-1 do
			--sets sector of map to load
			--rooms[b][a]=flr(rnd(8))
			rooms[b][a]=0
		end
	end
	rooms[0].sector_s=16
	rooms[0].sector_a=3
	rooms[0].room_w=16*3
	rooms[0].dark=false
--	rooms[0][0]=0
--	rooms[0][1]=0
--	rooms[0][2]=0
--	rooms[0][3]=0
	rooms[0][4]=1
--	rooms[0][5]=0
--	rooms[0][6]=0
--	rooms[0][7]=0
--	rooms[0][8]=0

	rooms[1][3]=3
	rooms[1].dark=true
end

function reset()
	level=0
	actortypes={}
	destroyactors()
	menus={}
end

function rndint(n)
	return	flr(rnd(n))+1
end

function choose(ar,d)
	local r=ar[rndint(#ar)]
	if d then del(ar,r) end
	return r
end

function loadsector(sx,sy,mx,my)
	--sx+sy=sector of room[] to be set
	--mx+my=sector from map to load into room[]
	local rsec=0.4
	--local rsec=rnd(1)
	local ss=rooms[level].sector_s
	for b=0,ss-1 do
		for a=0,ss-1 do
			--room[a+sx*rooms[level].sector_s][b+sy*rooms[level].sector_s]=mget(a+mx*rooms[level].sector_s,b+my*rooms[level].sector_s)
			local rand=rnd(1)
			local cell=0
			if rand<0.2 then cell=9 end
			if rand<0.05 then cell=13 end
			room[a+sx*ss][b+sy*ss]=cell
			local mc=mget(a+mx*ss,b+my*ss)
			if rsec<=0.4 then
				if mc!=0 then
					room[a+sx*ss][b+sy*ss]=mc
				end
			end
			if mc==10 then if rand<0.1 then cell=4 end end
			local en={} en[0]=3 en[1]=7 en[2]=8 en[3]=12
			if rand<0.03 then cell=en[flr(rnd(4))] end
			if rand<0.001 then cell=4 end
			if cell==3 or cell==4 or cell==7 or cell==8 or cell==12 then
				room[a+sx*ss][b+sy*ss]=cell
				local sp=a+sx*ss-1
				if sp<0 then sp=rooms[level].room_w-1
				elseif sp>rooms[level].room_w-1 then sp=0
				end
				room[sp][b+sy*ss]=0
			end
		end
	end
end

function loadmap(rw,sa)
	--rw=# of cells in room
	--sa=# of sectors in room
	room={}
	for a=0,rw-1 do
		room[a]={}
		for b=0,rw-1 do
			room[a][b]=0
		end
	end
	for ys=0,sa-1 do
		for xs=0,sa-1 do
			--loadsector(xs,ys,rooms[level][ys*sa+xs],flr(rnd(3))+1)
			--loadsector(xs,ys,rooms[level][ys*sa+xs],level)
			--loadsector(xs,ys,rooms[level][ys*sa+xs],flr(rnd(4)))
			loadsector(xs,ys,rooms[level][ys*sa+xs],0)
		end
	end
end

function loadactors(r)
	--r=room width in cells
	for b=0,r-1 do
		for a=0,r-1 do
			local cell=room[a][b]
			if cell>0 then
				makeactor(cell,a,b)
			end
		end
	end
	if actors.exits[1]==nil then
		makeactor(5,flr(rnd(r)),flr(rnd(r)))
	end
end

function makeactor(t,x,y)
	local a={}
	a.t=t
	a.x=x
	a.y=y
--	a.secx=flr(a.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
--	a.secy=flr(a.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
	a.shakex=0
	a.shakey=0
	a.movex=0
	a.movey=0

	if a.t==5 then
		add(actors.exits,a)
	end
	if a.t==4 or a.t==6 then
		add(actors.items,a)
	end
	if a.t==12 or a.t==8 or a.t==7 or a.t==3 or a.t==1 then
		if a.t==1 then
			a.args={1,2,3,4}
			a.buy={4,6}
		end
		a.attack=0
		a.attackdir=0
		a.attackpwr=2
		a.hit=0
		a.tar=nil
		a.inventory={}
		if rnd(1)<0.5 then
			a.inventory[1]=4+flr(rnd(2))*2
		end
		add(actors.creatures,a)
	end
	if a.t==11 then
		a.hit=0
		add(actors.cursors,a)
	end
	add(actors,a)
	return a
end

function makemenu(t,x,y,w,h)
	m={}
	m.t=t
	m.x=x
	m.y=y
	m.w=w
	m.h=h
	m.me={}
	m.sel=1
	m.display=false
	m.control=false
	m.target=nil
	add(menus,m)
end

function drawactor(a)
	if p!=nil and rooms[level].dark then
		if comparedistance(a,p)<10 then
			if actortypes[a.t].ch2!=nil then
				print(actortypes[a.t].ch2,a.x*cellw+a.shakex+a.movex+camoffx+2,a.y*cellh+a.shakey+a.movey+camoffy+1,5)
			end
			if comparedistance(a,p)<6 then
				if actortypes[a.t].ch2!=nil then
					print(actortypes[a.t].ch2,a.x*cellw+a.shakex+a.movex+camoffx+2,a.y*cellh+a.shakey+a.movey+camoffy+1,actortypes[a.t].c2)
				end
				print(actortypes[a.t].ch,a.x*cellw+a.shakex+a.movex+camoffx+2,a.y*cellh+a.shakey+a.movey+camoffy+1,actortypes[a.t].c)
--				if menus[1].control then
--					if a.tar!=nil then
--						line(a.tar.x*cellw+3+2,a.tar.y*cellh+3+2,a.x*cellw+3+2,a.y*cellh+3+2,8)
--					end
--				end
			end
		end
	else
		if actortypes[a.t].ch2!=nil then
			print(actortypes[a.t].ch2,a.x*cellw+a.shakex+a.movex+camoffx+2,a.y*cellh+a.shakey+a.movey+camoffy+1,actortypes[a.t].c2)
--			print(actortypes[a.t].ch2,a.x*cellw+a.shakex+camoffx+2,a.y*cellh+a.shakey+camoffy+2,actortypes[2].c2)
		end
--		print(actortypes[a.t].ch,a.x*cellw+a.shakex+camoffx+2,a.y*cellh+a.shakey+camoffy+2,actortypes[a.t].c)
			print(actortypes[a.t].ch,a.x*cellw+a.shakex+a.movex+camoffx+2,a.y*cellh+a.shakey+a.movey+camoffy+1,actortypes[a.t].c)
	end
	if menus[1].control then
		if a.tar!=nil then
			line(a.tar.x*cellw+3+2,a.tar.y*cellh+3+2,a.x*cellw+3+2,a.y*cellh+3+2,8)
		end
	end
end

function drawmenu(m)	
	--hacky background fix
--	rectfill(cam[1]+m.x-3,cam[2]+m.y-2,cam[1]+m.x-4,cam[2]+m.y+m.h,0)
--	rectfill(cam[1]+m.x-2,cam[2]+m.y-3,cam[1]+m.x+m.w,cam[2]+m.y-4,0)
	if m.control then
		if m.t==1 then
			--draw cursor
			if flr(timer/10)%2==0 then
				rect(cur.x*cellw+camoffx,cur.y*cellh+camoffy,cur.x*cellw+cellw+camoffx+1,cur.y*cellh+cellh+camoffy+1,8)
			end
		end
	end
	if m.display then
		rectfill(cam[1]+m.x-2,cam[2]+m.y-2,cam[1]+m.x+m.w,cam[2]+m.y+m.h,0)
		rect(cam[1]+m.x-2,cam[2]+m.y-2,cam[1]+m.x+m.w,cam[2]+m.y+m.h,rooms[level].c+4)
		local l=#m.me-1 if l>flr(m.h/cellh) then l=m.h/cellh end
		for a=0,l do
			print(m.me[a+1],m.x+cam[1],m.y+a*cellh+cam[2],6)
		end
	end
end

function taketurn()
	for m in all(menus) do
		m.display=false
		m.me={}
	end
	foreach(actors.creatures,doactor)
	foreach(actors.items,doactor)
	foreach(actors.exits,doactor)
	debug_l[4]=0
end

function direction(d)
	local dire={}
	dire[1]=0 dire[2]=0
	if d==1 then dire[1]=-1 end
	if d==2 then dire[1]= 1 end
	if d==4 then dire[2]=-1 end
	if d==8 then dire[2]= 1 end
	return dire
end

function actoroob(a,dire)
	local out=false
	if a.x+dire[1]<0       then dire[1]=rooms[level].room_w-1 out=true  end
	if a.x+dire[1]>=rooms[level].room_w then dire[1]=-rooms[level].room_w+1 out=true  end
	if a.y+dire[2]<0       then dire[2]=rooms[level].room_w-1 out=true  end
	if a.y+dire[2]>=rooms[level].room_w then dire[2]=-rooms[level].room_w+1 out=true  end	
	if a==p and out then
		level+=1
		if level>3 then level=0 end
		changelevel(level)
	end
	return dire	
end

function comparedistance(a,t)
	return sqrt( ((t.x-a.x)^2)+((t.y-a.y)^2) )
end

function closestactor(a,ar)
	local d=-1 local close={} local temp=0
	for v in all(ar) do
		temp=comparedistance(a,v)
		if temp<d or d==-1 then
			if v!=a then
			d=temp
			close=v
			end
		end
	end
	return close
end

function closesthated(a,ar)
	local d=-1 local close={} local temp=0
	for v in all(ar) do
		temp=comparedistance(a,v)
		if temp<d or d==-1 then
--			if temp.hate==v.rl then
			if v!=a then
			d=temp
			close=v
			end
--			end
		end
	end
	return close
end

function getrltn(t)
	return rltns[actortypes[t].rl]
end

function settarget(a)
	local tars={} local d={}
	tars[1]=closestactor(a,actors.items)
	tars[2]=closestactor(a,actors.creatures)
	if actors.items[1]!=nil then
		for b=1,2 do
			d[b]=comparedistance(a,tars[b])
		end
		if d[2]<d[1]
		and getrltn(a.t).ha==actortypes[tars[2].t].rl 
		and d[2]<8 then
			a.tar=tars[2]
			return followactor(a,tars[2])
		elseif actors.items[1]!=nil
		and d[1]<8 then
			a.tar=tars[1]
			return followactor(a,tars[1])
		else
			a.tar=nil
			return 2^flr(rnd(4))
		end
	end
end

function movetype(a)
	local m=actortypes[a.t].m
	if m==1 then
		return btnp()
	elseif m==2 then
		return settarget(a)
	end
end

function followactor(a,t)
	--a=follower t=target
	--returns keystroke direction
	if t!=nil then
		local xdist=t.x-a.x local ydist=t.y-a.y
		if abs(xdist)==abs(ydist) then
			if xdist<0 then return 1
			else return 2
			end
		elseif abs(xdist)>abs(ydist) then
			if xdist<0 then return 1
			else return 2
			end
		else
			if ydist<0 then return 4
			else return 8
			end
		end
	end
end

function countcash(a)
	local c=0
	for b=1,#a.inventory do
		if a.inventory[b]==4 then
			c+=1
		end
	end
	return c
end

function colactor(a,d,t)
	local dire=direction(d)
	if t!=a then
		if a.x+dire[1]==t.x and a.y+dire[2]==t.y then
			sfx(0)
			for b=1,2 do
				if dire[b]!=0 then a.attackdir=b end
			end
			a.attack=6
			if t.hit==0 then
				t.hit=a.attackpwr
				moveactor(t,2^flr(rnd(4)))
				if t==p then
					sendtomenu(menus[1],tut)
				end
			elseif t.hit==2 then
				moveactor(a,2^flr(rnd(4)))
			else
				sfx(1)
				local mes={}
				room[t.x][t.y]=0
				dropitem(t)
				if a==p then	
					mes[1]=species[actortypes[t.t].sp].." screams:"
					mes[2]=" blargharaghghr!!!..."
					mes[3]="*"..species[actortypes[t.t].sp].." now hates you!*"
					getrltn(t.t).ha=actortypes[p.t].rl
				elseif t==p then
					sendtomenu(menus[2],listinventory(p.inventory,"inventory:"))
					mes[1]="you are dead!"
					mes[2]="you got "..countcash(p).." cash"
					mes[3]=" press button to continue"
					players[1]=nil
					p=nil
					sfx(21)
				end
				sendtomenu(menus[1],mes)
				del(actors,t)
				del(actors.creatures,t)
			end
		end
	end
end

function moveactor(a,d)
	if d!=0 then
		local dire=actoroob(a,direction(d))
		local cell=room[a.x+dire[1]][a.y+dire[2]]
		if a.t==11 then
			a.x+=dire[1] a.y+=dire[2]
		elseif cell==0 or not actortypes[cell].solid then
			room[a.x][a.y]=0
			a.x+=dire[1] a.y+=dire[2]
			a.movex=-dire[1]*cellw
			a.movey=-dire[2]*cellh
			room[a.x][a.y]=a.t
--			a.secx=flr(a.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
--			a.secy=flr(a.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
		elseif cell==2 or cell==9 then
			--for b=0,3 do
			--	dire=actoroob(a,direction(b))
			--	cell=room[a.x+dire[1]][a.y+dire[2]]
				
			--end
			moveactor(a,2^flr(rnd(4)))
		else
		 return true
		end
	end
end

function doactor(a)
	if a.t==5 then
		if p!=nil then
			if p.x==a.x and p.y==a.y then
				sfx(actortypes[a.t].snd)
				level+=1
				if level>3 then level=0 end
				changelevel(level)
			end
		end
	elseif a.t==4 or a.t==6 then
		for v in all(actors.creatures) do
			if v.x==a.x and v.y==a.y then
				pickupitem(v,a)
				if v==p then
					sendtomenu(menus[2],listinventory(p.inventory,"inventory:"))
				end
			end
		end
	elseif p!=nil then
--		if a==p then
--			sendtomenu(menus[2],listinventory(p.inventory,"inventory:"))
--		end
		if comparedistance(a,p)<5.5 or a.t==11 then
			if a.hit==0 then
				local d=movetype(a)
				if moveactor(a,d) then
					for cr in all(actors.creatures) do
					colactor(a,d,cr)
					end
				end
			else
				a.hit-=1
			end
		end
	end
end

function destroyactors()
	actors={}
	actors.creatures={}
	actors.items={}
	actors.exits={}
	actors.cursors={}
end

function doitem(m,it)
	del(p.inventory,it)
	if it==4 then
		changemenu(m,3)
	elseif it==6 then
		p.hit=0
		quitmenu(m,m.t,true,listinventory(p.inventory,"inventory"))
	end
end

function pickupitem(a,i)
	local c=#a.inventory
	while c>0 do
		a.inventory[c+1]=a.inventory[c]
		c-=1
	end
	a.inventory[1]=i.t
	sfx(actortypes[i.t].snd)
	del(actors,i)
	del(actors.items,i)
end

function dropitem(a)
	if a.inventory[1]!=nil then
		makeactor(a.inventory[1],a.x,a.y)
		del(a.inventory,a.inventory[1])
	end
end

function changemenu(m,ty)
	m.sel=1
	m.t=ty
end

function quitmenu(m,ty,tu,me)
	m.control=false
	changemenu(m,ty)
	if tu then
		taketurn()
	end
	sendtomenu(m,me)
end

function listinventory(l,title)
--todo: make this take a title input "inventory:" or "use:" etc
	me={}
	me[1]=title
	for b=1,#l do
		me[b+1]=items[actortypes[l[b]].sp]
	end
	return me
end

function sendtomenu(m,me)
	if m.t==2 then
		for a=2,#me do
			me[a]="  "..me[a]
		end
	end
	m.display=true
	m.me=me
end

function domenu(m)
	--examine menu
	if m.t==1 then
		if m.control==true then
			local target=room[cur.x][cur.y]
			local ty=nil
			if target!=0 then
				ty=actortypes[target]
			end
			
			if target==1 then	
				sendtomenu(m,{"you are:"," a "..adjectives[ty.ad].." "..pronouns[ty.pn]..species[ty.sp]," in a "..adjectives[rooms[level].ad].." "..places[rooms[level].pl]," feeling *"..feelings[rltns[ty.rl].fe].."*"})
			elseif target==3 or target==7 or target==8 or target==12 then
				sendtomenu(m,{"you see:"," a "..species[ty.sp],">>button 1 to interact"})
				if btnp(4) then
					changemenu(m,4)
					m.target=target
				end
			elseif target==2 or target==9 then	
				sendtomenu(m,{"you see:"," a "..objects[ty.sp]})
			elseif target==4 or target==6 then
				sendtomenu(m,{"you see:"," a "..items[ty.sp]})
			else
				sendtomenu(m,{""})
			end
			if btnp(5) then
				quitmenu(m,m.t,false,tut)
			end
		end
	--inventory menu
	elseif m.t==2 then
		if p!=nil then
			controlmenu(m,2,#p.inventory,listinventory(p.inventory,"use:"))
		end
	--buy menu
	elseif m.t==3 then
		local buy={} buy[1]="buy:"
		for a=1,#p.buy do
			buy[a+1]=items[actortypes[p.buy[a]].sp]
		end
		controlmenu(m,2,#p.buy,buy)
	--dialogue menu
	elseif m.t==4 then
		local flav=""
		--rltns[actortypes[p.t].rl]
		local prl=getrltn(p.t)
		local trl=actortypes[m.target].rl
		if prl.ha==trl then
			flav="you hate >( !!"
		elseif prl.li==trl then
			flav="you looooove <3"
		else
			flav="you face:"
		end
		controlmenu(m,3,2,{flav," a "..species[actortypes[m.target].sp],"talk","argue"})
	elseif m.t==5 then
		local arg={}
		for a=1,#p.args do
			arg[a]=feelings[rltns[p.args[a]].fe].." is best!"
		end
		controlmenu(m,1,#p.args,arg)
	end
end

function controlmenu(m,mi,ma,me)
	if m.control then
		m.me=me
		for a=1,ma do
			local s=" -"
			if a==m.sel then s=">>" end
			m.me[a+mi-1]=s..m.me[a+mi-1]
		end
		if btnp(2) then m.sel-=1 if m.sel<1 then m.sel=ma end
		elseif btnp(3) then m.sel+=1 if m.sel>ma then m.sel=1 end
		elseif btnp(4) then
			if m.t==2 then
				--use item
				doitem(m,p.inventory[m.sel])
			elseif m.t==3 then
				--buy item
				makeactor(p.buy[m.sel],p.x,p.y)
				quitmenu(m,2,true,listinventory(p.inventory,"inventory:"))
			elseif m.t==4 then
				--dialogue
				if m.sel==1 then
					--talk choice
					sfx(flr(rnd(2))+8)
					quitmenu(m,1,true)
					local en={} en[1]=3 en[2]=7 en[3]=8
					local r=rndint(#en)
--					flr(rnd(#en))+1
					if players[1]!=nil then
						local trl=actortypes[m.target].rl
						local prl=actortypes[p.t].rl
						if     rltns[trl].ha==prl then
							--they hate you
							--todo: make it so each result ahs its own quit menu
							sendtomenu(m,{"they say:"," no i hate you!"})
						elseif rltns[prl].ha==trl then
							--you hate them
							sendtomenu(m,{"they say:"," you're mean...","*"..species[actortypes[m.target].sp].." now hates you!*"})

							--now they hate you
							--rltns[actortypes[m.target].rl].ha=actortypes[p.t].rl
							getrltn(m.target).ha=actortypes[p.t].rl
							while getrltn(m.target).li==prl do
								getrltn(m.target).li=rndint(#rltns)
							end
						elseif rltns[trl].li==prl then
							--they like you
							sendtomenu(m,{"they say:"," i like you! ;)"," "..species[actortypes[en[r]].sp].." hates "..feelings[rltns[rltns[actortypes[en[r]].rl].ha].fe].."!"})
						else
							--mutual ambivalence
							local ta={}
							ta[1]={"they say:"," "..dial[actortypes[m.target].dial]}
							ta[2]={"they say:"," "..species[actortypes[en[r]].sp].." hates "..feelings[rltns[rltns[actortypes[en[r]].rl].ha].fe].."!"}
--							sendtomenu(m,{"they say:"," "..species[actortypes[en[r]].sp].." hates "..feelings[rltns[rltns[actortypes[en[r]].rl].ha].fe].."!"})
							sendtomenu(m,choose(ta))
						end
					end
				else
					--argue choice
					changemenu(m,5)
				end
			elseif m.t==5 then
				--arguing
				if p.args[m.sel]==actortypes[m.target].rl then
					--they like you now
					--todo: for now this works but it's technically making them have the same feelings as you, not making them like you
					actortypes[m.target].rl=actortypes[p.t].rl
					actortypes[m.target].m=1
					del(p.args,p.args[m.sel])
					quitmenu(m,1,false,{"the "..species[actortypes[m.target].sp].." says:"," hm good point ..","*"..species[actortypes[m.target].sp].. " now likes you!*"})
--					sendtomenu(m,{"the x says:"," hm, good point ..","*x now likes you!*"})
				elseif p.args[m.sel]==getrltn(m.target).ha then
					getrltn(m.target).ha=actortypes[p.t].rl
					actortypes[m.target].m=2
					del(p.args,p.args[m.sel])
					quitmenu(m,1,true,{"they howl:"," how dare you say such thiiiiing!"})
				else
					quitmenu(m,1,true,{"they murmur:"," yeah sure uh see ya later..."})
					del(p.args,p.args[m.sel])
					actortypes[m.target].m=2
				end
			end
		elseif btnp(5) then
			--quit control menu
			--todo: make default menu attr?
			local mt=m.t
			if mt==4 then mt=1 end
			if mt==5 then mt=1 end
			if mt==1 then
				quitmenu(m,mt,false,tut)
			else
				quitmenu(m,mt,false,listinventory(p.inventory,"inventory:"))
			end
		end
	end
end

function shakeactor(a)
	if a.attack>0 then
		if a.attackdir==1 then
			a.shakex=cos(timer*1/6)*4
		else
			a.shakey=cos(timer*1/6)*4
		end
		a.attack-=1
	elseif a.hit>0 then
		a.shakex=cos(timer*1/16)*2
	else
		a.shakex=0 --a.shakey=0
		a.shakey=-abs(cos(timer*1/40))*2+1
	end
	if a.movex!=0 then
		if   a.movex>0 then a.movex-=1
		else a.movex+=1
		end
	elseif a.movey!=0 then
		if   a.movey>0 then a.movey-=1
		else a.movey+=1
		end
	else
		a.movex=0
		a.movey=0
	end
end

function changelevel(l)
	destroyactors()
	if players[1]!=nil then
		p=players[1]
		add(actors,p)
		add(actors.creatures,p)
		p.args={1,2,3,4}
	end
	cur=makeactor(11,p.x,p.y)
	loadmap(rooms[level].room_w,rooms[level].sector_a)
	loadactors(rooms[level].room_w)
end

function state_i(s)
	timer=0
	cam[1]=0 cam[2]=0
	reset()
	
	if s==0 then
		music(0)
	end
	if s==1 then
		music(-1)
		rltns_c=4
		actortypes_i(level,rltns_c)
		rooms_i(16,4)
		loadmap(rooms[level].room_w,rooms[level].sector_a)
		players={}
		add(players,makeactor(1,rooms[level].room_w/2,rooms[level].room_w/2))
		if players[1]!=nil then
			p=players[1]
			cur=makeactor(11,p.x,p.y)
			cam[1]=flr(p.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
			cam[2]=flr(p.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
			makemenu(1,2,103,125,24)
			sendtomenu(menus[1],tut)
			makemenu(2,86,2,41,96)
		end
		cash=0
		loadactors(rooms[level].room_w)
		--del(adjective,adjective[n])
	end
end

function stateupdate(s)
	if s==0 then
		if btnp()>8 then
			state=1
			state_i(state)
		end
	elseif s==1 then
		if not menus[1].control and not menus[2].control then
			if p!=nil then
				--control inventory
				if btnp(5) then
					if p.inventory[1]!=nil then
						sendtomenu(menus[2],listinventory(p.inventory,"use:"))
						menus[2].control=not menus[2].control
					end
				--control examine
				elseif btnp(4) then
					for v in all(actors.creatures) do
						if v!=p then
							if comparedistance(v,p)<5.5 then
								settarget(v)
							end
						end
					end
--					cur.display=not cur.display
					menus[1].control=not menus[1].control
					sendtomenu(menus[2],listinventory(p.inventory,"inventory:"))
					cur.x=p.x cur.y=p.y
				elseif btnp()>0 then
				--if timer%4==0 then
					local dire=actoroob(p,direction(btnp()))
					local cell=room[p.x+dire[1]][p.y+dire[2]]
					if cell!=2 and cell!=9 then
						
					else
						sfx(3)
						for b=1,2 do
							if dire[b]!=0 then p.attackdir=b end
						end
						p.attack=6
					end
					taketurn()
				end
			elseif btnp()>8 then
			 state=0 state_i(state)
			--else
				--taketurn()
				--if timer%4==0 then taketurn() end
			end
			foreach(actors.creatures,shakeactor)
			if p!=nil then
				cam[1]=(p.x-rooms[level].sector_s/2)*cellw+p.movex
				cam[2]=(p.y-rooms[level].sector_s/2)*cellh+p.movey
				--cam[1]=flr(p.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
				--cam[2]=flr(p.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
			end
		else
			foreach(actors.cursors,doactor)
			foreach(menus,domenu)
		end
		
		if debug then
		--if btnp(4) then
		--	level+=1
		--	if level>3 then level=0 end
		--	changelevel(level)
		--elseif btnp(5) then
			--state=0
			--state_i(state)
		--	end
		end
	end

	camera(cam[1],cam[2])	
	timer+=1
	debug_u()
end

function drawtitle(tx,yl,st,td,col)
	local title={}
	title[1] ="     ccccc aaaaa sssss h   h"
	title[2] ="     c     a   a s     h   h"
	title[3] ="     c     aaaaa  sss  hhhhh"
	title[4] ="     c     a   a     s h   h"
	title[5] ="     ccccc a   a sssss h   h"
	title[6] =""
	title[7] ="ccccc aaaaa sssss ttttt l    eeeee"
	title[8] ="c     a   a s       t   l    e"    
	title[9] ="c     aaaaa  sss    t   l    eee"  
	title[10]="c     a   a     s   t   l    e"    
	title[11]="ccccc a   a sssss   t   llll eeeee"
	local ind=0
	for a=0,2 do
		if timer>st*2^a then ind=a+1 end
	end
	for a=1,#title do
		print(title[a],tx,(yl+a)*cellh,8+((timer+(a-1)*10)/td[ind+1])%col[ind+1])
	end
	if flr(timer/20)%2==0 and timer>st*2 then
		print("press button to start",25,17*cellh,7)
	end
	if timer==1140 then timer=0 end
end

function statedraw(s)
	cls()
	if s==0 then
		drawtitle(-1,3,255,{16,16,10,30},{1,6,10,10})
	end
	if s==1 then
		foreach(actors,drawactor)
--		rect(cam[1],cam[2],cam[1]+rooms[level].sector_s*cellw+1,cam[2]+rooms[level].sector_s*cellh+2,rooms[level].c+4)
		foreach(menus,drawmenu)
	end
	if debug then
		for a=1,#debug_l do
			print(debug_l[a],cam[1]+0,cam[2]+(a-1)*6,6)
		end
	end
end

function _init()
	cellw=5 cellh=6
	cam={}
	camoffx=2
	camoffy=2
	words()
	
	level=0
	state=0
	state_i(state)
end

function _draw()
	statedraw(state)
end

function _update()
	stateupdate(state)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000880000088880008888880080008000888880008888800088888800888888008888880080888800080080008088880080088800000808008008880
00000000008880000000080000000080080008000800000008000000000000800800008008000080080800800080080008000080080000800880808008008000
00000000000080000088880008888880088888000800000008888800000000800888888008000080080800800080080008088880080088800800808008008000
00000000000080000080000000000080000008000888880008000800000000800800008008888880080800800080080008080000080008800800088808008880
00000000000080000080000000000080000008000000080008000800000000800800008000000080080800800080080008080000080000800800008008000080
00000000000080000088880008888880000008000888880008888800000000800888888008888880080888800000088008088880000088800800008000008880
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800008000000000
00000000000000000000000000000000000000000000000000000000888888888888888888888888888888888888888888888888888888888888888888888888
08088880080888800808888008088880888088800880080088808880888888888888888888888888888888888888888888888888888888888888888888888888
08080000080000800808008008080080008080800080080000800080888888888888888888888888888888888888888888888888888888888888888888888888
08088880080000800808888008088080008080800080080000800080888888888888888888888888888888888888888888888888888888888888888888888888
08080080080008000808008008008880888080800080080088808880888888888888888888888888888888888888888888888888888888888888888888888888
08080080080080000808008008000080800080800880080080008000888888888888888888888888888888888888888888888888888888888888888888888888
08088880080800000808888008000880888088800800080080008000888888888888888888888888888888888888888888888888888888888888888888888888
00000000000000000000000000000000000000000880000088808880888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888880888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888880000008
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888880888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888880080008
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888880080008
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888880888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000000020000000a000000000000000000000000000000000000000
20202020202020202020202020a0202020202020a02020202020202020a02020a0a0a0a0a000a0a0a0a0a000a0a0a0a00000000000000000a000000000000000
00000000000000000000000000000000a020a020a020a020a020a020a020a020a0a0000000000020200000a0a000000000202020202020202020202020202000
20200000000000a0a0a0a0a020a0a020a0a0a020a0a0a0a0a0a0a02020a02020a0000000a0000000a000a0a0a000a0a000000000000000a0a000000000000000
00000000000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000a0a0000000202000a0a0a00000202000200000000000000000000000002000
20200000002020a0002020a0a020a020a020a020202020202020a02020a02020a0a0a0a0a0a0a0a0a000a00000a000a000000000000000a00000000000000000
0000000000000000000000000000000020a020a020a020a020a020a020a020a00000a0a00000202000a000000020200000200000000000000000000000002000
20000020002020a020000020a020a020a020a0a0a0a0a0a0a020a020a0a02020a0a0a00000a0a000a0a000000000a0a000000000000000a00000002020200000
00a0a0a0a0a0a0a0a000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0000000a0a0000020a00000202000000000200000000000000000000000002000
2020202020a0a0a000000020a020a0a0a020a020202020202020a020a0202020a000a0000000a00000a000000000a0a000000000000000a000000020a0200000
a0a0000000000000a0a0a00000000000a020a020a020a020a020a020a020a02000000000a0a00020202020200000000000200000000000000000000000002000
0000000000a0202000000020a020a0202020a020a0a0a0a0a0a0a020a0a0a020a0a0a0000000a0a000a0a00000a0a0a000000000000000a0000000a0a0200000
00000000000000000000a00000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a000202000000000000000200000000000000000000000002000
000000a0a0a0002000002020a020a020a0a0a020a0202020202020202020a020a0a0a0000000a000a0a0a0a0a0a000a0000000000000a0a00000002050200000
00000000000000a0a0a0a0000000000020a020a020a0a0a0a0a020a020a020a0000000000000a0a0a0a0a0000000000000202020202020200000000000002000
a0a0a0a0000000200020a0a0a020a020a0202020a020202020a0a0a02020a020a000a0a0a0a0a0a0a0a000a000a0a0a00000000000a0a0a00000002020200000
000000000000a0a00000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000000000002020200000a0a0000000000020a0a0a0a0a0200000000000002000
000000000000000020a0a0202020a020a0a0a020a0a0a0a0a0a020a02020a020a000a0a000a0000000a0a000a00000a0000000a0a0a000a0a000000000000000
000000000000a0000000000000000000a020a020a020a0a0a020a020a020a020000000002000a0a0200000a0000000000020a0a0a0a0a0200000000000002000
000020202000000000a0202020a0a0202020a020a0202020202020a02020a020a0a0a000a0a00000a0a0a0a0a0a0a0a0000000a000000000a000000000000000
00000000a0a0a0000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000202000a0a02020000000a00000000020a0a0a0a0a0200000000000002000
202020200020202000a0202020a020202020a020a02020a0a0a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000a0a000a0000000a0a0000000a000000000000000
000000a0a0000000000000000000000020a020a020a020a020a020a020a020a00020200000a0002000000000a0a0000000202020a02020200000000000002000
2000000000200000a0a0002020a0a02020a0a0a0a02020a020a0202020202020a0a000000000a000a00000000000a0a000000000a0a0a0a0a000000000000000
000000a0000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a020200000a0a000200000000000a0a00000200020a02000000000000000002000
2000202020000000a00000002020a02020a02020a02020a0202020a0a0a02020a0a000000000a0a000a000000000a0a00000000000a0a0000000000000000000
000000a0a00000000000a0a0a0a0a0a0a020a020a020a020a020a020a020a02000000000a0000020200000000000a0a000200020a02000000000000000002000
2000000000000000a0000000a0a0a02020a02020a0a020a0a0a020a020a02020a000000000a0a0a0a0a0000000a0a0a0000000000000a0a0a0a0a00000000000
00000000a0a0a0a0a0a0a00000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000a0a0a0a0000000200000000000000000200020a02000000000000000002000
20202000000000a0a0000000a0002000a0a0202020a0a0a020a0a0a020a0a020a000000000a0a000a000a0a0a0a000a000000000000000000000a0a000000000
0000000000000000000000000000000020a020a020a020a020a020a020a020a0a0a0000000000000200000000000000020200020a02000000000000000002020
20200000000000a000000000a00000202020202020202020202020202020a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000000000000000a0a0000000
0000000000000000000000000000000020000000000000000000a000000000000000000000000000000000002020a0a000000000000000002000000000000000
00000000000000000000a000000000000000000020a0200020a02000000000000000000000000000000000000000000000000000002000000000000000000000
0000000000000000000000000000000020202020202020200000a0000000200000000000000000000000002020a0a0a000000000000000002000000000000000
00000000000000000000a000000000000000000020a0200020a02000000000000000000000000000000000000000000000000000002000000000000000000000
0000000000000000000000000000000020000000000000002000a00000200000000000000000000020202020a0a0a0a000000000000000002000000000000000
00000000000000000000a0a00000000000000020a0a0200020a02000000000000000000000000000000000000000000000000000000020000000000000000000
00000000000000000000000000000000000000000000002000a0a00020002000000000000000000020a0a0a0a0a0202000000000000000002000000000000000
0000000000000000000000a0a000000000000020a0a0200020a0a020000000000000000000000000000000000000000000000000000000200000000000000000
0000000000000000000000000000000020000000002020a0a0a0000020002000000000000000000020a0a0a02020200000000000000000002000000000000000
00000000000000000000a0a00000000000000020a02000000020a020200000000000000000000000000000000000000000000000000000002000000000000000
000000000020000000002000000000002020202020a0a0a0a00000200000200000000000000000002020a0202000000000000000000000002000000000000000
000000000000000000a0a0000000000000000020a02000000020a0a0200000000000000000002020000000000000000000000000000000002000000000000000
00000000000000000000000000000000200000a0a0a0202020202000000020000000000000000000002020200000000000000000000000002000000000000000
000000000000000000a0a0000000000000000020a02000000020a0a0200000002000000000200000200000000000000000000000000000002000000000000000
00000000000000000000000000000000200000a00020000000000000000020000000000000000000000000000000000020202020202020202020202020202020
00000000000000000000a00000000000000020a0a02000000020a0a0200000000020000020000000002000000000002000000000000000002000000000000000
00000000000000000000000000000000202000a0a0a0200000000000000020000000000020200000000000000000000000000000000000002000000000000000
00000000000000002020a02020000000000020a0a02000000020a0a0200000000000202000000000002000000020200000000000000000200000000000000000
000000000000000000000000000000002000200000a00020000000000000200000002020a0a02000000000000000000000000000000000002000000000000000
000000000000000020a0a0a020000000000020a0a0a0202020a0a020000000000000000000000000000020202000000000000000000020000000000000000000
000000000000000000000000200000002000002000a0a0a02000002020200000000020a0a0a0a020000000000000000000000000000000002000000000000000
000000000000000020a0a0a02000000000000020a0a0a050a0a02000000000000000000000000000000000000000000000000000000020000000000000000000
0000002020000000000000202000000020000000200000a0a0202000a0a0a0a0000020a0a0a0a020000000000000000000000000000000002000000000000000
000000000000000020a050a020000000000000002020202020200000000000000000000000000000000000000000000000000000000000200000000000000000
000000002020202020202000000000002000000000202000a0a0a0a0a000000000000020a0202000000000000000000000000000000000002000000000000000
00000000000000002020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000
000000000000000000000000000000002000000000000020200000002020000000000020a0200000000000000000000000000000000000002000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000
000000000000000000000000000000002000000000000000002000200000200000000020a0200000000000000000000000000000000000002000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000
000000000000000000000000000000000020202020202020202020202020000000000020a0200000000000000000000000000000000000002000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
000000000000000000000000000000000202020202000000000000020202020202020a020200000000000002020200000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a020202000000000000000000000202020000000000020a0a0a0a02000000000000000000000000000000000000000000000000020a0a0a0a0a0a0a0200000000
00000000000000000000000000000000020a0a0a02020202020202020a0a0a02020a0a0a0200000000000000000000000a02020202020202020202020202020a0a0a02000000020a0a02000000020a0a0000000000020a0a0a0a020000000000000000000000000000000000000000000000020a0a0a0a0a0a0a0a0a02000000
00000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0a0a02020a0a0a0200000000000000000000000a020a0a0a0a0a0a0a0a0a0a0a0a020a0a0a02000000020a0a02000000020a0a0000000000020a0a0a0a0200000000000000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a020000
00000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0a0a02020a0a0a0200000000000000000000000a020a02020a0202020a0202020a020a0a0a02000000020a0502000000020a0a0000000000020a0a0a0a0200000000000000000000000000000000000000000000020a0a0a0a0a0a0a020a0a0a0a0200
0000000000000000000000000000000002020a0a0a0a0a0a0a0a0a0a0a0a0202020202020200000000000000000000000a020a02020a020a0a0a0a0a020a020a0a0a0200000002020202000000020a0a0000000000020a0a0a0a0200000000000000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200
0000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a020a0a0a0a020a020a020a020a020a0a0a0200000000000000000000020a0a0202020202020a0a0a0a0202020202020000000000000a0a0a0a00000000000000020a0a020a0a0a0a0a0a0a0a0a0200
0000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a020a02020a020a020a020a020a0a0a0a0a0202020202020202020202020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a020a0a020a000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200
0000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a020a020a0a020a02050202020a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0a050a0a000000000000020a0a0a0a0a0a0a0a0a0a020a0200
0000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a020a02020a020a020a020a0a0a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0a0a0a0a000000000000020a0a0a0a0a020a0a0a0a0a0a0200
0000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a020a0a0a0a020a0a0a020a020a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0a0a0a0a000000000000020a0a020a0a0a0a0a0a0a0a0a0200
0000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a020202020a02020a02020a020a020a0a0a0202020202020202020202020a0a0202020202020a0a0a0a020202020202000000000000020a0a0200000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200
0000000000000000000000000000000002020a0a0a0a0a0a0a0a0a0a0a0a0202000000000000000000000000000000000a020a0a0a0a0a0a0a0a0a0a020a020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a02000000000000000000000000000a0000000000000000020a0a0a02020a02020a0a0a0a0200
00000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0a0a02000000000000000000000000000000000a020202020a02020202020a020a020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a020000000000000000000000000a0a0000000000000000020a0a020a0a0a0a0a020a0a020000
00000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0a0a02000000000000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a020000000000000000000000000a00000000000000000002020a020a050a0a0a020202000000
00000000000000000000000000000000020a0a0a02020205020202020a0a0a02000000000000000000000000000000000a02020202020202020202020202020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a020000000000000000000000000a0a0000000000000000000002020a0a0a0a02000000000000
0000000000000000000000000000000002020202020000000000000202020202000000000000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a020202000000000000000000000202020000000000020a0a0a0a02000000000000000000000000000a0000000000000000000000000202020200000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000020000000000000a0000000000000002020a0a0a0a0a0a0200000000000000020002020202020200020a0200000000000000000000000000000000000a000000
000202020a020a0a0a0a0a0a0a020a000000000000000000000000000000000a0002020202000000000000020202020200000000000000000a00000000000000020000000002020a020200000000000202020a0a0a0a0a02000000000000000202020a0a0a0a0202020a0202020202000000000000000000000000000a000000
00020a020a0a0a0a0a0a0a0a0a0a0a0000000000000000000000000000000a0a00020a0a0a0202020202020a0a0a0a02000000000000000000000000000000000200000000020a0a0a02000000000002020a020a0a0a0a0202000202020a02020a0a0a0a0a0a0a0a0a0a0a0a0a0a020000000000000000000000000a0a000000
00020a020a0a0a0a0a020202020a0a00000000000000000000000000000a0a0000020a0a0a0a0a0a0a020a0a0a0a0a0200000000000000000a000a00000000000200000000020a0a0a02000000000002020a020202020a0a0202020a0a0a0a0202020a0a0a0a020202020202020a020000000000000000000000000a00000000
000a0a0a0a0a0a0a0a020a0a020a0a000000000000000a0a0a0a0a0a0a0a000000020a0a0a0a0a0a0a0a0a0a0a0a0a02000000000000000a000000000a00000002000000000202020202000000000002020a0a0a0a020a0a0a0a02020a0a0a02000202020202020a0a0a0202020a020000000000000000000000000a00000000
000a0a0a0a020a0a0a020a0a020a0a0000000000000a0a000a0000000a0000000000020a0a0a0a0a0a020a0a0a0a02000000000002000000000000000000000002000000000000000000000000000002020a0a0a0a020a0a0a0a0a020202020200020a0a0a0a0a0a0a0a0202020a020000000000000000000000000a00000000
000a0a0a0a0a0a0a0a020a0a020a0a000000000a0a0a00000a000000000000000000020a0a0a0202020202020a0a02000000000000020a00000a000200000000020202020202020202020202020202020202020a020202020a0a0a0a0a0a0a0a00020a020202020a0a0a0202020a0200000000000000000000000a0a00000000
000202020a0a0a0a0a0a0a0a0a0a0a00000a0a0a000000000a00000000000000000002020a02020a0a0a0a020a0a020000000a000a000a000000000a00000a0a0a0a0a0a0a0a020a0a0a0a0a0a020a0a0200000000000002020a0a0a0a0a0a0a00020a02000002020a020202020a02000a0a0a0a0a00000000000a0000000000
00020a0a0a0a0a0a0a0a0a0a0a0a0a000a0a00000000000a0a000000000000000000020a0a0a020a0a0205020a0a0200000a0000000a00000a000000000a00000a0a0a020a0a0a0a0a0a020a0a0a0a0a02000000000000000202020a0a0a0a0a00020a02000000020a020202020a0200000000000a0a0000000a0a0000000000
000202020a0a0a0a0a020a0a020a0a00000000000000000a00000000000000000000020a0a0a020a0a0202020a0202000000000000000000000a000a00000000020202020202020a0a020202020202020200000000000000000000020202020202020a02020002020a020202020a020200000000000a00000a0a000000000000
000a020a0a0a0a0a0a020a0a020a0a00000000000000020a020000000000000000020a0a0a0a020a0a020a0a0a0a0a02000000000002000a0000000000000000020000000000000a0a0000000000000202000000000000000000000000000002020a0a0a0200020a0a0a0202020a0a0200000000000a000a0a00000000000000
000a0a0a0a0a0a020a020202020a0a000000000000020a0a0a0200000000000000020a0a0a0a0a0a0a020a0a0a0a0a020000000002000000000a000002000000020000000000000a0a00000000000002020000000000000000020a0200000002020a0a0a0200020a0a0a0a0a0a0a0a0200000000000a0a0a0000000000000000
000a0a0a020a0a020a0a0a0a0a0a0a000000000000020a0a0a0200000000000000020a0a0a0a020a0a020a0a0a0a0a0a00000000000000000a00000000000000020000000000000a0a00000000000002020000020a020000000a0a0a0000000202020a020200020a0a0a0202020a0a020000000000000a0a0000000000000000
000a0a0a020a0a020a0a0a0a0a0a0a000000000000020a0a0a0200000000000000020a0a0a02020a0a02020a0a0a0a02000000000000000a0000000000000000020000000000000a0a000000000000020200000a0a0a000000020a020000000202020a02000002020a02020002020202000000000000000a0000000000000000
000a0a0a020202020a0a0a0a0a020a0000000000000002020200000000000000000202020200020a0a0200020202020200000000000000000a00000000000000020000000000000a0a00000000000002020000020a02000000000000000000020a0a0a02000000000a00000000000000000000000000000a0000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000020a0a0200000000000000000000000000000a00000000000000020000000000000a0a000000000000020200000000000000000000000000000202020202000000000a00000000000000000000000000000a0000000000000000
__sfx__
000300000f1300d120000000000012640156500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002824025240212401b14017140141401014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500000717008170000001727019270000000b1700a170000001127011170112701217012270131701327013170000000000000000000000000000000000000000000000000000000000000000000000000000
000600002762001610046001300013000120001300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000f5400f540275402b54033340333403333033330333203332033310333103331033310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000090500906012540135200e0500e0601d5401f5200c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500001f240201401f2301c1301823014130102200c1100a1100711003110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000700000161002500036100250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500000714008150000001724019250000000b1500a140000001124011150112401215012240131501324013150000000000000000000000000000000000000000000000000000000000000000000000000000
0006000015050191401605000000120501414000000100501d1402375000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000800000a4400a4400a4000a4000a4400a4400d4400d440144000f4000f4400f4401e2000b4000a4400a4401d2001d2000d4400d4400f4400f44000000000000a4400a44000000000000d4400d4400d40000000
000800000a4400a4400a4000a4000a4400a4400d4400d440144000f4000f4400f4401e2000b4000a4400a4401d2001d2000d4400d4400f4400f44000000000000b4400b4400b4400b4400b4400b4400000000000
000800000a4400a4400a4000a4000a4400a4400d4400d440144000f4000f4400f4401e2000b4000a4400a4000a4400a4000f4400f4400d4400d4400c4000c400104401044010440104400f4400f4400f4000f400
000800001653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530
000800001653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301753017530175301753017530175301753017530
000800001653016530165301653016530165301653016530165301653016530165301653016530165301653016530165301953019530175301753017530175301653016530165301653017530175301753017530
0008000005300056000000008700053000a600086000860008700087000a3000870008700087000a340000000a340087000b640000000a3400000008340000000634006300086000a2000b440000000000000000
00080000033400560000000087000334005600086400860008700087000a340087000870008700086400000000000087000a340000000000000000086400000000000086000a3400000008640000000000000000
0008000003340056000000008700033400a600086400860008700087000a3400870008700087000a340000000a340087000b640000000a3400000008340000000634006300086000a2000b440000000000000000
000f00001952019520195201952019520195201952019520195201952019520195201952019520195201952017520175201752017520175201752017520175201652016520165201652016520165201652016520
000f00001c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201c3201b3201b3201b3201b3201b3201b3201b3201b3201932019320193201932019320193201932019320
001900001e5401e5401e5401e5401e5401d5401d5401d5401d5401d5401c5401c5401c5401c5401c5401b5401b5401b5401b5401b540195401a540195401a540195401a540195401a54019540195301953019520
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 0a424344
00 0b424344
00 0a424344
00 0c424344
00 0a0d4344
00 0b0e4344
00 0a0d4344
00 0c0f1044
00 0a0d1144
00 0b0e1144
00 0a0d1144
00 0c0f1244
00 0a0d1144
00 0b0e1144
00 0a0d1144
00 0c0f1244
02 49131444
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344


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
	if p!=nil then
	debug_l[8]="inv:"..#p.inventory
	debug_l[9]="px="..p.x
	debug_l[10]="py="..p.y
	debug_l[11]="lvl="..level
	end
	if actortypes[2]!=nil then
	debug_l[12]=actortypes[2][level+1].ch
	debug_l[13]=actortypes[2][level+1].ch2
	end
	if rltns!=nil then
	for a=1,#rltns do
		debug_l[13+a]=feelings[rltns[a].fe].." li:"..feelings[rltns[rltns[a].li].fe].." ha:"..feelings[rltns[rltns[a].ha].fe]
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
end

function actortypes_i(l,r)
	chars="@abcdefghijklmnopqrstuvwxyz0123456789!#%^*():;,.{}&$"

	rltns={}
	--temp index to delete feelings that have been selected already
	local ind={}
	for a=1,#feelings do
		ind[a]=a
	end
	for a=1,r do
		rltns[a]={}
		local fe=ind[flr(rnd(#ind))+1]
		rltns[a].fe=fe
		rltns[a].li=a --this is just to set up the below code that stops liking your own feeling
		rltns[a].ha=a --samesies
		del(ind,fe) --remove assigned feeling from temp index so it doens't get assigned to another actor
	end
	for a=1,r do
		while rltns[a].li==a do
			rltns[a].li=flr(rnd(r))+1
		end
		while rltns[a].ha==a or rltns[a].ha==rltns[a].li do
			rltns[a].ha=flr(rnd(r))+1
		end
		--rltns[a].ha=flr(rnd(4))+1
	end
	--words()
	
	actortypes={}
	for a=1,10 do
		actortypes[a]={}
		for b=1,4 do actortypes[a][b]={} end
	end		
	--player attributes
	local ad=flr(rnd(#adjectives))+1
	local pn=#pronouns if rnd(1)<=0.5 then pn=flr(rnd(#pronouns))+1 end
	local sp=flr(rnd(#species))+1
	--local fe=flr(rnd(#feelings))+1
	local rl=flr(rnd(#rltns))+1
	for a=1,4 do
		actortypes[1][a].ch=sub(chars,1,1)
		actortypes[1][a].c=7
		actortypes[1][a].m=1
		actortypes[1][a].ad=ad
		actortypes[1][a].pn=pn
		actortypes[1][a].sp=sp
		actortypes[1][a].rl=rl
		actortypes[1][a].solid=true
	end
	--tree attributes
	for a=1,4 do
		local ch=flr(rnd(#chars)+1)
		local ch2=flr(rnd(#chars)+1)
		actortypes[2][a].ch=sub(chars,ch,ch)
		actortypes[2][a].c=flr(rnd(14))+1
		--actortypes[2][a].m=0
		actortypes[2][a].ch2=sub(chars,ch2,ch2)
		actortypes[2][a].c2=flr(rnd(14))+1
		--actortypes[2][a].ad=flr(rnd(#adjectives))+1
		--actortypes[2][a].pn=#pronouns if rnd(1)<=0.5 then actortypes[2][a].pn=flr(rnd(#pronouns))+1 end
		actortypes[2][a].sp=flr(rnd(#objects))+1
		--actortypes[2][a].fe=flr(rnd(#feelings))+1
		actortypes[2][a].solid=true
	end
	--enemy attributes
	for a=1,4 do
		ch=flr(rnd(#chars)+1)
		actortypes[3][a].ch=sub(chars,ch,ch)
		actortypes[3][a].c=flr(rnd(14))+1
		actortypes[3][a].m=2
		actortypes[3][a].ad=flr(rnd(#adjectives))+1
		actortypes[3][a].pn=#pronouns if rnd(1)<=0.5 then actortypes[2][a].pn=flr(rnd(#pronouns))+1 end
		actortypes[3][a].sp=flr(rnd(#species))+1
		--actortypes[3][a].fe=flr(rnd(#feelings))+1
		actortypes[3][a].rl=flr(rnd(#rltns))+1
		actortypes[3][a].solid=true
		actortypes[3][a].dial=flr(rnd(#dial))+1
	end
	--item attributes
	for a=1,4 do
		actortypes[4][a].ch="$"
		actortypes[4][a].c=10
		actortypes[4][a].m=0
		actortypes[4][a].sp=1
		actortypes[4][a].solid=false
		actortypes[4][a].snd=4
	end
	--exit attributes
	for a=1,4 do
		actortypes[5][a].ch="&"
		actortypes[5][a].c=11
		actortypes[5][a].m=0
		actortypes[5][a].solid=false
		actortypes[5][a].snd=6
	end
	--potion?
	for a=1,4 do
		actortypes[6][a].ch="~"
		actortypes[6][a].c=13
		actortypes[6][a].m=0
		actortypes[6][a].sp=2
		actortypes[6][a].solid=false
		actortypes[6][a].snd=5
	end
		--enemy attributes
	for a=1,4 do
		ch=flr(rnd(#chars)+1)
		actortypes[7][a].ch=sub(chars,ch,ch)
		actortypes[7][a].c=flr(rnd(14))+1
		actortypes[7][a].m=2
		actortypes[7][a].ad=flr(rnd(#adjectives))+1
		actortypes[7][a].pn=#pronouns if rnd(1)<=0.5 then actortypes[2][a].pn=flr(rnd(#pronouns))+1 end
		actortypes[7][a].sp=flr(rnd(#species))+1
		--actortypes[3][a].fe=flr(rnd(#feelings))+1
		actortypes[7][a].rl=flr(rnd(#rltns))+1
		actortypes[7][a].solid=true
		actortypes[7][a].dial=flr(rnd(#dial))+1
	end
		--enemy attributes
	for a=1,4 do
		ch=flr(rnd(#chars)+1)
		actortypes[8][a].ch=sub(chars,ch,ch)
		actortypes[8][a].c=flr(rnd(14))+1
		actortypes[8][a].m=2
		actortypes[8][a].ad=flr(rnd(#adjectives))+1
		actortypes[8][a].pn=#pronouns if rnd(1)<=0.5 then actortypes[2][a].pn=flr(rnd(#pronouns))+1 end
		actortypes[8][a].sp=flr(rnd(#species))+1
		--actortypes[3][a].fe=flr(rnd(#feelings))+1
		actortypes[8][a].rl=flr(rnd(#rltns))+1
		actortypes[8][a].solid=true
		actortypes[8][a].dial=flr(rnd(#dial))+1
	end
	--wall attributes
	for a=1,4 do
		local ch=flr(rnd(#chars)+1)
		local ch2=flr(rnd(#chars)+1)
		actortypes[9][a].ch=sub(chars,ch,ch)
		actortypes[9][a].c=flr(rnd(14))+1
		--actortypes[9][a].m=0
		actortypes[9][a].ch2=sub(chars,ch2,ch2)
		actortypes[9][a].c2=flr(rnd(14))+1
		--actortypes[9][a].ad=flr(rnd(#adjectives))+1
		--actortypes[9][a].pn=#pronouns if rnd(1)<=0.5 then actortypes[2][a].pn=flr(rnd(#pronouns))+1 end
		actortypes[9][a].sp=flr(rnd(#objects))+1
		--actortypes[9][a].fe=flr(rnd(#feelings))+1
		actortypes[9][a].solid=true
	end
	--ground attributes
	for a=1,4 do
		local ch=48
		--local ch2=flr(rnd(#chars)+1)
		actortypes[10][a].ch=sub(chars,ch,ch)
		actortypes[10][a].c=flr(rnd(14))+1
		--actortypes[10][a].m=0
		--actortypes[10][a].ch2=sub(chars,ch2,ch2)
		--actortypes[10][a].c2=flr(rnd(14))+1
		--actortypes[10][a].ad=flr(rnd(#adjectives))+1
		--actortypes[10][a].pn=#pronouns if rnd(1)<=0.5 then actortypes[2][a].pn=flr(rnd(#pronouns))+1 end
		actortypes[10][a].sp=flr(rnd(#objects))+1
		--actortypes[10][a].fe=flr(rnd(#feelings))+1
		actortypes[10][a].solid=false
	end
end

function rooms_i(ss,sa)
	rooms={}
	for b=0,3 do
		rooms[b]={}
		rooms[b].sector_s=ss
		rooms[b].sector_a=sa --6 is max here!
		rooms[b].room_w=rooms[level].sector_s*rooms[level].sector_a

		rooms[b].c=flr(rnd(6))
		rooms[b].ad=flr(rnd(#adjectives))+1
		rooms[b].pl=flr(rnd(#places))+1
		for a=0,sa*sa-1 do
			--sets sector of map to load
			rooms[b][a]=flr(rnd(8))
		end
	end
end

function reset()
	level=0
	actortypes={}
	destroyactors()
	menus={}
end

function loadsector(sx,sy,mx,my)
	--sx+sy=sector of room[] to be set
	--mx+my=sector from map to load into room[]
	local rsec=rnd(1)
	local ss=rooms[level].sector_s
	for b=0,ss-1 do
		for a=0,ss-1 do
			--room[a+sx*rooms[level].sector_s][b+sy*rooms[level].sector_s]=mget(a+mx*rooms[level].sector_s,b+my*rooms[level].sector_s)
			local rand=rnd(1)
			local cell=0
			if rand<0.2 then cell=9 end
			if rand<0.01 then cell=3 end
			if rand<0.005 then cell=4 end
			local mc=mget(a+mx*ss,b+my*ss)
--			if a==0 or a==15 or b==0 or b==15 then cell=0 end
			room[a+sx*ss][b+sy*ss]=cell
			if rsec<=0.4 then
			if mc!=0 then
				room[a+sx*ss][b+sy*ss]=mget(a+mx*ss,b+my*ss)
			end
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
			loadsector(xs,ys,rooms[level][ys*sa+xs],flr(rnd(4)))
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
end

function makeactor(t,x,y)
	local a={}
	a.t=t
	a.x=x
	a.y=y
	a.secx=flr(a.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
	a.secy=flr(a.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
	a.shakex=0
	a.shakey=0
	if a.t==5 then
		add(actors.exits,a)
	end
	if a.t==4 or a.t==6 then
		add(actors.items,a)
	end
	if a.t==8 or a.t==7 or a.t==3 or a.t==1 then
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
	m.control=false
	m.target=nil
	add(menus,m)
end

function drawactor(a)
	if p!=nil then
	if comparedistance(a,p)<7 then
		if actortypes[a.t][level+1].ch2!=nil then
			print(actortypes[a.t][level+1].ch2,a.x*cellw+a.shakex+camoffx+2,a.y*cellh+a.shakey+camoffy+2,actortypes[2][level+1].c2)
		end
	if comparedistance(a,p)<5 then
	--if flr(a.x/8)==flr(p.x/8) then
		--if flr(a.y/8)==flr(p.y/8) then
	--if a.secx==cam[1] then 
		--if	a.secy==cam[2] then
			print(actortypes[a.t][level+1].ch,a.x*cellw+a.shakex+camoffx+2,a.y*cellh+a.shakey+camoffy+2,actortypes[a.t][level+1].c)
			
			if menus[1].control then
			if a.tar!=nil then
--		rect(a.tar.x*cellw,a.tar.y*cellh,a.tar.x*cellw+5,a.tar.y*cellh+5,8)
				line(a.tar.x*cellw+3,a.tar.y*cellh+3,a.x*cellw+3,a.y*cellh+3,8)
--				print(comparedistance(a.tar,a),a.x*cellw+cellw,a.y*cellh+cellh,8)
			end
			end

		end
	end
	else
		if actortypes[a.t][level+1].ch2!=nil then
			print(actortypes[a.t][level+1].ch2,a.x*cellw+a.shakex+camoffx,a.y*cellh+a.shakey+camoffy,actortypes[2][level+1].c2)
		end
			print(actortypes[a.t][level+1].ch,a.x*cellw+a.shakex+camoffx,a.y*cellh+a.shakey+camoffy,actortypes[a.t][level+1].c)
	end
	
end

function drawmenu(m)
	rectfill(cam[1]+m.x-2,cam[2]+m.y-2,cam[1]+m.x+m.w,cam[2]+m.y+m.h,0)
--	rect    (cam[1]+m.x-2,cam[2]+m.y-2,cam[1]+m.x+m.w,cam[2]+m.y+m.h,5)
	if m.control then
		rect(cam[1]+m.x-2,cam[2]+m.y-2,cam[1]+m.x+m.w,cam[2]+m.y+m.h,rooms[level].c+4)
	end
	--hacky background fix
	rectfill(cam[1]+m.x-3,cam[2]+m.y-2,cam[1]+m.x-4,cam[2]+m.y+m.h,0)
	rectfill(cam[1]+m.x-2,cam[2]+m.y-3,cam[1]+m.x+m.w,cam[2]+m.y-4,0)
	--if not debug then
	local l=#m.me-1 if l>flr(m.h/cellh) then l=m.h/cellh end
	for a=0,l do
		print(m.me[a+1],m.x+cam[1],m.y+a*cellh+cam[2],6)
	--end
	end
end

function taketurn()
	foreach(actors.creatures,doactor)
	foreach(actors.items,doactor)
	foreach(actors.exits,doactor)
	foreach(menus,domenu)
	debug_l[4]=0
end

--function checkinventory(t)
--	for k,v in pairs(p.inventory) do
--		if v==t then return true end
--	end
--	return false
--end

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
	if a.x+dire[1]<0       then dire[1]=rooms[level].room_w-1 end
	if a.x+dire[1]>=rooms[level].room_w then dire[1]=-rooms[level].room_w+1 end
	if a.y+dire[2]<0       then dire[2]=rooms[level].room_w-1 end
	if a.y+dire[2]>=rooms[level].room_w then dire[2]=-rooms[level].room_w+1 end	
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

function movetype(a)
	local m=actortypes[a.t][level+1].m
	if m==1 then
		return btnp()
	elseif m==2 then
		local tars={} local d={}
		tars[1]=closestactor(a,actors.items)
		tars[2]=closestactor(a,actors.creatures)
--		tars[2]=actors.creatures[1]
		if actors.items[1]!=nil then
		for b=1,2 do
			d[b]=comparedistance(a,tars[b])
		end
		if d[2]<d[1]
		and rltns[actortypes[a.t][level+1].rl].ha==actortypes[tars[2].t][level+1].rl 
		and d[2]<8 then
			a.tar=tars[2]
			return followactor(a,tars[2])
		elseif actors.items[1]!=nil
		and d[1]<8
		then
			a.tar=tars[1]
			return followactor(a,tars[1])
		else
			return 2^flr(rnd(4))
		end
		end
--		if p!=nil then
--			if rltns[actortypes[a.t][level+1].rl].ha!=actortypes[p.t][level+1].rl then
--				if actors.items[1]!=nil then
--					return followactor(a,closestactor(a,actors.items))
--				else
--					return 2^flr(rnd(4))
--				end
--			else
--				return followactor(a,p)
--			end
--		else
--			return 2^flr(rnd(4))
--		end
	end
end

function followactor(a,t)
	--a=follower t=target
	--returns a keystroke direction
	if t!=nil then
	--if t.secx==a.secx and t.secy==a.secy then
		local xdist=t.x-a.x local ydist=t.y-a.y
		if abs(xdist)==abs(ydist) then
			--return 2^flr(rnd(4))
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
		--end
		end
	--end
	end
end

function colactor(a,d,t)
	local dire=direction(d)
	if t!=a then
		if a.x+dire[1]==t.x and a.y+dire[2]==t.y then
			--local cell=room[a.x+dire[1]][a.y+dire[2]]
			--if cell==1 or cell==3 or cell==7 or cell==8 then
				sfx(0)
				for b=1,2 do
					if dire[b]!=0 then a.attackdir=b end
				end
				a.attack=6
				if t.hit==0 then
					if rltns[actortypes[a.t][level+1].rl].li==actortypes[t.t][level+1].rl then
						a.attackpwr=1
					else
						a.attackpwr=2
						--dropitem(t)
					end
					t.hit=a.attackpwr
					moveactor(t,2^flr(rnd(4)))
				else
					sfx(1)
					room[t.x][t.y]=0
					dropitem(t)
					if t==p then
						players[1]=nil
						p=nil
					end
					del(actors,t)
					del(actors.creatures,t)
				end
			--else
			--	moveactor(a,2^flr(rnd(4)))
			--end
		end
	end
end

function moveactor(a,d)
	if d!=0 then
		local dire=actoroob(a,direction(d))
		local cell=room[a.x+dire[1]][a.y+dire[2]]
		if cell==0 or not actortypes[cell][level+1].solid then
--			sfx(7)
			room[a.x][a.y]=0
			a.x+=dire[1] a.y+=dire[2]
			room[a.x][a.y]=a.t
			a.secx=flr(a.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
			a.secy=flr(a.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
		elseif cell==2 or cell==9 then
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
			sfx(actortypes[a.t][level+1].snd)
			level+=1
			if level>3 then level=0 end
			changelevel(level)
		end
		end
	elseif a.t==4 or a.t==6 then
		--if p!=nil then
		--if p.x==a.x and p.y==a.y then
		for k,v in pairs(actors.creatures) do
			if v.x==a.x and v.y==a.y then
				pickupitem(v,a)
			end
		end
		--end
		--end
	elseif p!=nil then
	--if p.secx==a.secx and p.secy==a.secy then
	if comparedistance(a,p)<8 then
	if a.hit==0 then
		local d=movetype(a)
		if moveactor(a,d) then
			for cr in all(actors.creatures) do
			--for cr in all(actors) do 
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
end

function dodialogue(m,t)
	m.t=4
	m.sel=1
	m.control=not m.control
	m.target=t
end

function doitem(m,it)
	del(p.inventory,it)
	if it==4 then
		changemenu(m,3)
	elseif it==6 then
		p.hit=0
		quitmenu(m,m.t,true)
--		m.me={}
--		m.me[1]="recovered!"
	end
end

function pickupitem(a,i)
	local c=#a.inventory
	while c>0 do
		a.inventory[c+1]=a.inventory[c]
		c-=1
	end
	a.inventory[1]=i.t
	sfx(actortypes[i.t][level+1].snd)
	del(actors,i)
	del(actors.items,i)
end

function dropitem(a)
	if a.inventory[1]!=nil then
		makeactor(a.inventory[1],a.x,a.y)
		del(a.inventory,a.inventory[1])
	end
end

function controlmenu(m,mi,ma,def)
	if m.control then
		for a=1,mi-1 do
			m.me[a]=def[a]
		end
		for a=1,ma do
			local s=""
			if a==m.sel then s=">>" else s=" -" end
			if m.t==2 then
				m.me[a+1]=s..items[actortypes[p.inventory[a]][level+1].sp]
			elseif m.t==3 then
				m.me[a+1]=s..items[a]
			elseif m.t==4 then
				local talk={} talk[1]="talk" talk[2]="argue"
				m.me[a+2]=s..talk[a]
			end
		end
		if btnp(2) then m.sel-=1 if m.sel<1 then m.sel=ma end
		elseif btnp(3) then m.sel+=1 if m.sel>ma then m.sel=1 end
		elseif btnp(4) then
			if m.t==2 then
			--use item
				doitem(m,p.inventory[m.sel])
			elseif m.t==3 then
			--buy item
				makeactor(6,p.x,p.y)
				quitmenu(m,2,true)
			elseif m.t==4 then
			--talk
				if m.sel==1 then
					sfx(flr(rnd(2))+8)
					quitmenu(m,1,true)
					m.me={}
					m.me[1]="they say:"
					local trl=actortypes[m.target][level+1].rl
					local prl=actortypes[p.t][level+1].rl
					if     rltns[trl].ha==prl then
						m.me[2]=" no i hate you!"
					elseif rltns[prl].ha==trl then
						m.me[2]=" you're mean..."
						m.me[3]="*"..species[actortypes[m.target][level+1].sp].." now hates you!*"
						rltns[actortypes[m.target][level+1].rl].ha=actortypes[p.t][level+1].rl
						while rltns[actortypes[m.target][level+1].rl].li==prl do
							rltns[actortypes[m.target][level+1].rl].li=flr(rnd(#rltns))+1
						end
					elseif rltns[trl].li==prl then
						m.me[2]=" i like you! ;)"
					else
						m.me[2]=" no talk.. only get cash."
					end
				else
				end
			end
		elseif btnp(5) then
			if m.t!=3 then
				local mt=m.t
				if mt==4 then mt=1 def={} end
				m.me=def
				quitmenu(m,mt,false)
			end
		end
	else
		m.sel=1
		if m.t==4 then m.t=1 def={} end
		m.me=def
	end
end

function changemenu(m,ty)
	m.sel=1
	m.t=ty
end

function quitmenu(m,ty,tu)
	m.control=not m.control
	changemenu(m,ty)
	if tu then
		taketurn()
	end
end

function domenu(m)
	m.me={}
	local def={}
	--examine menu
	if m.t==1 then
		if players[1]==nil then
			m.me[1]="you are dead!"
			m.me[2]=""
			m.me[3]=" press button to continue"
		elseif m.control==true then
			m.me[1]="examine:"
			m.me[2]=" choose a direction"
			if p.hit>0 then
				m.me={}
				m.me[1]=" status: stunned "..(p.hit).." turns"
			elseif btnp()>0 and btnp()<16 then
				m.control=not m.control
				local dire=actoroob(p,direction(btnp()))
				local target=room[p.x+dire[1]][p.y+dire[2]]
				if target!=0 then
					if target==3 or target==7 or target==8 then
						dodialogue(m,target)
					elseif target==2 then
						m.me[1]="you face:"
						m.me[2]=" a "..objects[actortypes[target][level+1].sp]
					end
				else
					local ty=actortypes[p.t][level+1]
					m.me[1]="you are:"
					m.me[2]=" a "..adjectives[ty.ad].." "..pronouns[ty.pn]..species[ty.sp]
					m.me[3]=" in a "..adjectives[rooms[level].ad].." "..places[rooms[level].pl]
					m.me[4]=" feeling *"..feelings[rltns[ty.rl].fe].."*"
				end
			end
			if btnp(5) then
				m.control=not m.control
				m.me={}
			end
		end
	--inventory menu
	elseif m.t==2 then
		def[1]="inventory:"
		if p!=nil then
			for a=1,#p.inventory do
				def[a+1]=" -"..items[actortypes[p.inventory[a]][level+1].sp]
			end
			local ma=#p.inventory if ma>3 then ma=3 end
			controlmenu(m,2,ma,def)
		end
	--buy menu
	elseif m.t==3 then
		def[1]="buy:"
		controlmenu(m,2,#items,def)
	--talk menu
	elseif m.t==4 then
		if rltns[actortypes[p.t][level+1].rl].ha==actortypes[m.target][level+1].rl then
			def[1]="you hate >( !!"
		elseif rltns[actortypes[p.t][level+1].rl].li==actortypes[m.target][level+1].rl then
			def[1]="you looooove <3"
		else
			def[1]="you face:"
		end
		def[2]=" a "..species[actortypes[m.target][level+1].sp].." feeling *"..feelings[rltns[actortypes[m.target][level+1].rl].fe].."*"
		controlmenu(m,3,2,def)
	end
end

function shakeactor(a)
	if a.attack>0 then
		if a.attackdir==1 then
			a.shakex=cos(timer*1/6)*2
		else
			a.shakey=cos(timer*1/6)*2
		end
		a.attack-=1
	elseif a.hit>0 then
		a.shakex=cos(timer*1/16)*2
	else
		a.shakex=0 --a.shakey=0
		a.shakey=-abs(cos(timer*1/40))*2+1
	end
end

function changelevel(l)
	destroyactors()
	if players[1]!=nil then
		p=players[1]
		add(actors,p)
		add(actors.creatures,p)
	end
--	actortypes_i(l)
	loadmap(rooms[level].room_w,rooms[level].sector_a)
	loadactors(rooms[level].room_w)
end

function state_i(s)
	timer=0
	cam[1]=0 cam[2]=0
	reset()
	
	if s==0 then
	end
	if s==1 then
		rltns_c=4
		actortypes_i(level,rltns_c)
		rooms_i(16,4)
		loadmap(rooms[level].room_w,rooms[level].sector_a)
		players={}
		add(players,makeactor(1,flr(rnd(rooms[level].room_w)),flr(rnd(rooms[level].room_w))))
		if players[1]!=nil then
			p=players[1]
			cam[1]=flr(p.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
			cam[2]=flr(p.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
			makemenu(1,2,103,125,24)
			makemenu(2,86,2,41,96)
		end
		loadactors(rooms[level].room_w)
		--del(adjective,adjective[n])
	end
end

function stateupdate(s)
	if s==0 then
		if btnp(5) then
			state=1
			state_i(state)
		end
	elseif s==1 then
		if not menus[1].control and not menus[2].control then
			if p!=nil then
			if btnp(5) then
				if p.inventory[1]!=nil then
				menus[2].control=not menus[2].control
				end
			elseif btnp(4) then
				menus[1].control=not menus[1].control
			elseif btnp()>0 then
			--if timer%4==0 then
				local dire=actoroob(p,direction(btnp()))
				local cell=room[p.x+dire[1]][p.y+dire[2]]
				if cell!=2 and cell!=9 then
					taketurn()
				else
					sfx(3)
					for b=1,2 do
						if dire[b]!=0 then p.attackdir=b end
					end
					p.attack=6
				end
			end
			elseif btnp()>0 then
			 state=0 state_i(state)
			end
			foreach(actors.creatures,shakeactor)
			if p!=nil then
			cam[1]=flr(p.x/rooms[level].sector_s)*rooms[level].sector_s*cellw
			cam[2]=flr(p.y/rooms[level].sector_s)*rooms[level].sector_s*cellh
			end
		else
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

function statedraw(s)
	cls()
	if s==0 then
		print("title\npress button to start",30,30,7)
	end
	if s==1 then
		foreach(actors,drawactor)
		rect(cam[1],cam[2],cam[1]+rooms[level].sector_s*cellw+1,cam[2]+rooms[level].sector_s*cellh+2,rooms[level].c+4)
		foreach(menus,drawmenu)
	end
	if debug then
		for a=1,#debug_l do
			print(debug_l[a],cam[1]+0,cam[2]+(a-1)*6,6)
			--x=84
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
00000000000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000000020000000a000000020200000000000000000000000000000
20202020202020202020202020a0202020202020a02020202020202020a02020a0a0a0a0a000a0a0a0a0a000a0a0a0a00000000000000000a000000000000000
00000000000000000000000000000000a020a020a020a020a020a020a020a020a0a0000000000020200000a0a0000000a0200000000000000000000000000000
20200000000000a0a0a0a0a020a0a020a0a0a020a0a0a0a0a0a0a02020a02020a0000000a0000000a000a0a0a000a0a000000000000000a0a000000000000000
00000000000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000a0a0000000202000a0a0a000002020a0200000000000000000000000000000
20200000002020a0002020a0a020a020a020a020202020202020a02020a02020a0a0a0a0a0a0a0a0a000a00000a000a000000000000000a00000000000000000
0000000000000000000000000000000020a020a020a020a020a020a020a020a00000a0a00000202000a0000000202000a0200000000000000000000000000000
20000020002020a020000020a020a020a020a0a0a0a0a0a0a020a020a0a02020a0a0a00000a0a000a0a000000000a0a000000000000000a00000002020200000
00a0a0a0a0a0a0a0a000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0000000a0a0000020a000002020000000a0200000000000000000000000000000
2020202020a0a0a000000020a020a0a0a020a020202020202020a020a0202020a000a0000000a00000a000000000a0a000000000000000a000000020a0200000
a0a0000000000000a0a0a00000000000a020a020a020a020a020a020a020a02000000000a0a000202020202000000000a0200000000000000000000000000000
0000000000a0202000000020a020a0202020a020a0a0a0a0a0a0a020a0a0a020a0a0a0000000a0a000a0a00000a0a0a000000000000000a0000000a0a0200000
00000000000000000000a00000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0002020000000000000a0200000000000000000000000000000
000000a0a0a0002000002020a020a020a0a0a020a0202020202020202020a020a0a0a0000000a000a0a0a0a0a0a000a0000000000000a0a000000020a0200000
00000000000000a0a0a0a0000000000020a020a020a0a0a0a0a020a020a020a0000000000000a0a0a0a0a00000000000a0202020202020200000000000000000
a0a0a0a0000000200020a0a0a020a020a0202020a020202020a0a0a02020a020a000a0a0a0a0a0a0a0a000a000a0a0a00000000000a0a0a00000002020200000
000000000000a0a00000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000000000002020200000a0a000000000a020a0a0a0a0a0200000000000000000
000000000000000020a0a0202020a020a0a0a020a0a0a0a0a0a020a02020a020a000a0a000a0000000a0a000a00000a0000000a0a0a000a0a000000000000000
000000000000a0000000000000000000a020a020a020a0a0a020a020a020a020000000002000a0a0200000a000000000a020a0a0a0a0a0200000000000000000
000020202000000000a0202020a0a0202020a020a0202020202020a02020a020a0a0a000a0a00000a0a0a0a0a0a0a0a0000000a000000000a000000000000000
00000000a0a0a0000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000202000a0a02020000000a0000000a020a0a0a0a0a0200000000000000000
202020200020202000a0202020a020202020a020a02020a0a0a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000a0a000a0000000a0a0000000a000000000000000
000000a0a0000000000000000000000020a020a020a020a020a020a020a020a00020200000a0002000000000a0a00000a0202020a02020200000000000000000
2000000000200000a0a0002020a0a02020a0a0a0a02020a020a0202020202020a0a000000000a000a00000000000a0a000000000a0a0a0a0a000000000000000
000000a0000000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a020200000a0a000200000000000a0a000a0200020a02000000000000000000000
2000202020000000a00000002020a02020a02020a02020a0202020a0a0a02020a0a000000000a0a000a000000000a0a00000000000a0a0000000000000000000
000000a0a00000000000a0a0a0a0a0a0a020a020a020a020a020a020a020a02000000000a0000020200000000000a0a0a0200020a02000000000000000000000
2000000000000000a0000000a0a0a02020a02020a0a020a0a0a020a020a02020a000000000a0a0a0a0a0000000a0a0a0000000000000a0a0a0a0a00000000000
00000000a0a0a0a0a0a0a00000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000a0a0a0a00000002000000000000000a0200020a02000000000000000000000
20202000000000a0a0000000a0002000a0a0202020a0a0a020a0a0a020a0a020a000000000a0a000a000a0a0a0a000a000000000000000000000a0a000000000
0000000000000000000000000000000020a020a020a020a020a020a020a020a0a0a0000000000000200000000000000020200000000000000000000000000000
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
00000000000000002020202020000000000020a0a02000000020a0a0200000000000202000000000002000000020200000000000000000200000000000000000
000000000000000000000000000000002000200000a00020000000000000200000002020a0a02000000000000000000000000000000000002000000000000000
000000000000000020a0a0a020000000000020a0a0a0202020a0a020000000000000000000000000000020202000000000000000000020000000000000000000
000000000000000000000000200000002000002000a0a0a02000002020200000000020a0a0a0a020000000000000000000000000000000002000000000000000
000000000000000020a0a0a02000000000000020a0a0a0a0a0a02000000000000000000000000000000000000000000000000000000020000000000000000000
0000002020000000000000202000000020000000200000a0a0202000a0a0a0a0000020a0a0a0a020000000000000000000000000000000002000000000000000
000000000000000020a0a0a020000000000000002020202020200000000000000000000000000000000000000000000000000000000000200000000000000000
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
0202020202000000000000020202020202020a0202000000000000020202000000000000000a000000000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a020202000000000000000000000202020000000000020a0a0a0a02000000000000000000000000000000000000000000000000020a0a0a0a0a0a0a0200000000
020a0a0a02020202020202020a0a0a02020a0a0a02000000000000000000000000000000000a000000000000000000000a02020202020202020202020202020a0a0a02000000020a0a02000000020a0a0000000000020a0a0a0a020000000000000000000000000000000000000000000000020a0a0a0a0a0a0a0a0a02000000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a02020a0a0a02000000000000000000000000000000000a000000000000000000000a020a0a0a0a0a0a0a0a0a0a0a0a020a0a0a02000000020a0a02000000020a0a0000000000020a0a0a0a0200000000000000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a020000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a02020a0a0a02000000000000000000000000000000000a0a0000000000000000000a020a02020a0202020a0202020a020a0a0a02000000020a0a02000000020a0a0000000000020a0a0a0a0200000000000000000000000000000000000000000000020a0a0a0a0a0a0a020a0a0a0a0200
02020a0a0a0a0a0a0a0a0a0a0a0a0202020202020200000000000000000000000000000000000a0000000000000000000a020a02020a020a0a0a0a0a020a020a0a0a0200000002020202000000020a0a0000000000020a0a0a0a0200000000000000000000000000000000000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200
00020a0a0a0a0a0a0a0a0a0a0a0a020000000000000000000000000000000000000000000000000a00000000000000000a020a0a0a0a020a020a020a020a020a0a0a0200000000000000000000020a0a0202020202020a0a0a0a0202020202020000000000000a0a0a0a00000000000000020a0a020a0a0a0a0a0a0a0a0a0200
00020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000000000000020a0a0a020000000000000a020a02020a020a020a020a020a0a0a0a0a0202020202020202020202020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a020a0a020a000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200
00020a0a0a0a0a0a0a0a0a0a0a0a02000000000000000000000000000000000000000000000a0a0a0a0a000a0a0a00000a020a020a0a020a020a0202020a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0a0a0a0a000000000000020a0a0a0a0a0a0a0a0a0a020a0200
00020a0a0a0a0a0a0a0a0a0a0a0a02000000000000000000000000000000000000000a0a0a0a0a0a0a0a0a0a000a0a0a0a020a02020a020a020a020a0a0a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0a0a0a0a000000000000020a0a0a0a0a020a0a0a0a0a0a0200
00020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000a0a0a00000a0a0a0a0a0000000000000a020a0a0a0a020a0a0a020a020a020a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000a0a0a0a0a0a000000000000020a0a020a0a0a0a0a0a0a0a0a0200
00020a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000000000000020a0a0a020000000000000a020202020a02020a02020a020a020a0a0a0202020202020202020202020a0a0202020202020a0a0a0a020202020202000000000000020a0a0200000000000000020a0a0a0a0a0a0a0a0a0a0a0a0200
02020a0a0a0a0a0a0a0a0a0a0a0a020200000000000000000000000000000000000000000000000a00000000000000000a020a0a0a0a0a0a0a0a0a0a020a020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a02000000000000000000000000000a0000000000000000020a0a0a02020a02020a0a0a0a0200
020a0a0a0a0a0a0a0a0a0a0a0a0a0a0200000000000000000000000000000000000000000000000a0a000000000000000a020202020a02020202020a020a020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a020000000000000000000000000a0a0000000000000000020a0a020a0a0a0a0a020a0a020000
020a0a0a0a0a0a0a0a0a0a0a0a0a0a02000000000000000000000000000000000000000000000a0a00000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a020000000000000000000000000a00000000000000000002020a020a0a0a0a0a020202000000
020a0a0a02020202020202020a0a0a02000000000000000000000000000000000000000000000a0a00000000000000000a02020202020202020202020202020a0a0a0200000000000000000000020a0a0000000000020a0a0a0a020000000000000000000000000a0a0000000000000000000002020a0a0a0a02000000000000
0202020202000000000000020202020200000000000000000000000000000000000000000000000a00000000000000000a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a020202000000000000000000000202020000000000020a0a0a0a02000000000000000000000000000a0000000000000000000000000202020200000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000020000000000000a0000000000000002020a0a0a0a0a0a0200000000000000020002020202020200020a0200000000000000000000000000000000000a000000
000202020a020a0a0a0a0a0a0a020a000000000000000000000000000000000a0002020202000000000000020202020200000000000000000a00000000000000020000000002020a020200000000000202020a0a0a0a0a02000000000000000202020a0a0a0a0202020a0202020202000000000000000000000000000a000000
00020a020a0a0a0a0a0a0a0a0a0a0a0000000000000000000000000000000a0a00020a0a0a0202020202020a0a0a0a02000000000000000000000000000000000200000000020a0a0a02000000000002020a020a0a0a0a0202000202020a02020a0a0a0a0a0a0a0a0a0a0a0a0a0a020000000000000000000000000a0a000000
00020a020a0a0a0a0a020202020a0a00000000000000000000000000000a0a0000020a0a0a0a0a0a0a020a0a0a0a0a0200000000000000000a000a00000000000200000000020a0a0a02000000000002020a020202020a0a0202020a0a0a0a0202020a0a0a0a020202020202020a020000000000000000000000000a00000000
000a0a0a0a0a0a0a0a020a0a020a0a000000000000000a0a0a0a0a0a0a0a000000020a0a0a0a0a0a0a0a0a0a0a0a0a02000000000000000a000000000a00000002000000000202020202000000000002020a0a0a0a020a0a0a0a02020a0a0a02000202020202020a0a0a0202020a020000000000000000000000000a00000000
000a0a0a0a020a0a0a020a0a020a0a0000000000000a0a000a0000000a0000000000020a0a0a0a0a0a020a0a0a0a02000000000002000000000000000000000002000000000000000000000000000002020a0a0a0a020a0a0a0a0a020202020200020a0a0a0a0a0a0a0a0202020a020000000000000000000000000a00000000
000a0a0a0a0a0a0a0a020a0a020a0a000000000a0a0a00000a000000000000000000020a0a0a0202020202020a0a02000000000000020a00000a000200000000020202020202020202020202020202020202020a020202020a0a0a0a0a0a0a0a00020a020202020a0a0a0202020a0200000000000000000000000a0a00000000
000202020a0a0a0a0a0a0a0a0a0a0a00000a0a0a000000000a00000000000000000002020a02020a0a0a0a020a0a020000000a000a000a000000000a00000a0a0a0a0a0a0a0a020a0a0a0a0a0a020a0a0200000000000002020a0a0a0a0a0a0a00020a02000002020a020202020a02000a0a0a0a0a00000000000a0000000000
00020a0a0a0a0a0a0a0a0a0a0a0a0a000a0a00000000000a0a000000000000000000020a0a0a020a0a020a020a0a0200000a0000000a00000a000000000a00000a0a0a020a0a0a0a0a0a020a0a0a0a0a02000000000000000202020a0a0a0a0a00020a02000000020a020202020a0200000000000a0a0000000a0a0000000000
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


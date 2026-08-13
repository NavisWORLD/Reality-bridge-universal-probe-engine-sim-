#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <string>

static double clamp(double v,double a=0,double b=1){return std::max(a,std::min(b,v));}
static std::uint64_t fnv1a(const std::string&s){std::uint64_t h=1469598103934665603ull;for(unsigned char c:s){h^=c;h*=1099511628211ull;}return h;}
static std::uint64_t splitmix(std::uint64_t&x){std::uint64_t z=(x+=0x9e3779b97f4a7c15ull);z=(z^(z>>30))*0xbf58476d1ce4e5b9ull;z=(z^(z>>27))*0x94d049bb133111ebull;return z^(z>>31);}
static double rand01(std::uint64_t&s){return (splitmix(s)>>11)*(1.0/9007199254740992.0);}

struct Planet{std::string name;std::uint64_t seed;double gravityG,tempC,water,biosphere;};
struct Player{double x=0,z=0,y=2,vy=0,heading=0,speed=0;bool onGround=true;};
struct World{double biosphere=.22,storm=0,cycles=0;int anomalies=0,outposts=0;};
struct State{std::array<float,54> v{};double lx=.1,ly=.2,lz=.3;};

Planet makePlanet(const std::string&name){
 if(name=="Earth") return{name,fnv1a(name),1,15,.71,.22};
 if(name=="Mars") return{name,fnv1a(name),.379,-63,.02,0};
 if(name=="Europa") return{name,fnv1a(name),.134,-160,.8,0};
 std::uint64_t s=fnv1a(name);return{name,s,.15+rand01(s)*2.2,-170+rand01(s)*430,rand01(s),0};
}

double terrain(const Planet&p,double x,double z){return std::sin((x+z)*.018 + double(p.seed%997)*.001)*7 + std::sin(x*.043)*3 + std::cos(z*.031)*2;}

void update(State&st,const Planet&p,const World&w,const Player&pl,double dt){
 double dx=10*(st.ly-st.lx),dy=st.lx*(28-st.lz)-st.ly,dz=st.lx*st.ly-(8.0/3.0)*st.lz;st.lx+=dx*dt*.035;st.ly+=dy*dt*.035;st.lz+=dz*dt*.035;
 double chaos=clamp(std::hypot(st.lx,st.ly,st.lz)/55.0),inst=clamp(chaos*.45+w.storm*.4),coh=clamp(.65*(1-inst)+.35*w.biosphere),res=clamp((coh+(1-chaos)+w.biosphere)/3);
 for(int i=0;i<54;i++)st.v[i]=float(clamp(.5+.45*std::sin(w.cycles*.13+i*.31+p.gravityG*.7)));
 st.v[15]=float(chaos);st.v[41]=float(coh);st.v[52]=float(res);st.v[53]=float(clamp(inst*.6+(1-coh)*.4));
}

int main(){
 Planet p=makePlanet("Earth");World w;Player pl;State st;constexpr double dt=1.0/60.0;
 for(int i=0;i<600;i++){
  double target=4.6/std::sqrt(std::max(.15,p.gravityG));pl.speed += (target-pl.speed)*std::min(1.0,dt*5);pl.x += std::cos(pl.heading)*pl.speed*dt;pl.z += std::sin(pl.heading)*pl.speed*dt;
  pl.vy -= 9.80665*p.gravityG*dt;pl.y += pl.vy*dt;double ground=terrain(p,pl.x,pl.z)+1.72;if(pl.y<=ground){pl.y=ground;pl.vy=0;pl.onGround=true;}
  w.cycles += dt/60.0;if(w.biosphere>0)w.biosphere=clamp(w.biosphere+dt*.000003*(1-w.biosphere));update(st,p,w,pl,dt);
 }
 auto a=makePlanet("Cory Prime"),b=makePlanet("Cory Prime");if(a.gravityG!=b.gravityG)return 2;
 std::cout<<"REALITY BRIDGE HEADLESS OK\n"<<"planet="<<p.name<<" x="<<pl.x<<" z="<<pl.z<<" coherence="<<st.v[41]<<"\n";
 return 0;
}

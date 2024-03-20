RSRC                    RDShaderFile            ��������                                                  resource_local_to_scene    resource_name    bytecode_vertex    bytecode_fragment    bytecode_tesselation_control     bytecode_tesselation_evaluation    bytecode_compute    compile_error_vertex    compile_error_fragment "   compile_error_tesselation_control %   compile_error_tesselation_evaluation    compile_error_compute    script 
   _versions    base_error           local://RDShaderSPIRV_iiix8 ;         local://RDShaderFile_q7q3b u         RDShaderSPIRV            Failed parse:
ERROR: 0:17: 'this' : Reserved word. 
ERROR: 0:17: '' : compilation terminated 
ERROR: 2 compilation errors.  No code generated.




Stage 'compute' source code: 

1		#version 450
2		
3		layout(local_size_x = 4, local_size_y = 4, local_size_z = 4) in;
4		
5		layout(set = 0, binding = 0, std430) restrict buffer DataBuffer {
6			vec3 selfCoords;
7		    float selfMass;
8		    float gravConst;
9		    vec4 otherCords[];
10		}
11		data_buffer;
12		
13		void main() {
14			vec3 curr_planet = data_buffer.otherCords[gl_GlobalInvocationID.x].xyz;
15		    float curr_planet_mass = data_buffer.otherCords[gl_GlobalInvocationID.x].w;
16		    float this_mass = data_buffer.selfMass;
17		    vec3 this = data_buffer.selfCoords;
18		    vec3 diff = curr_planet - this;
19		    vec3 dir = normalize(diff);
20		    float len = length(diff);
21		    float new_force = (data_buffer.gravConst * this_mass * curr_planet_mass) / (len * len)
22		    vec3 new_grav_pull = dir * new_force
23		    float isnear;
24		    if(len < 1){
25		        isnear = 1.0;
26		    }else{
27		        isnear = 0.0;
28		    }
29		    vec4 output = vec4(new_grav_pull.x, new_grav_pull.y, new_grav_pull.z, isnear)
30		    data_buffer.otherCords[gl_GlobalInvocationID.x] = output;
31		}
32		
          RDShaderFile                                    RSRC
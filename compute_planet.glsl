#[compute]
#version 450

layout(local_size_x = 4, local_size_y = 4, local_size_z = 4) in;

layout(set = 0, binding = 0, std430) restrict buffer DataBuffer {
	vec3 selfCoords;
    float selfMass;
    float gravConst;
    vec4 otherCords[];
}
data_buffer;

void main() {
	vec3 curr_planet = data_buffer.otherCords[gl_GlobalInvocationID.x].xyz;
    float curr_planet_mass = data_buffer.otherCords[gl_GlobalInvocationID.x].w;
    float this_mass = data_buffer.selfMass;
    vec3 this = data_buffer.selfCoords;
    vec3 diff = curr_planet - this;
    vec3 dir = normalize(diff);
    float len = length(diff);
    float new_force = (data_buffer.gravConst * this_mass * curr_planet_mass) / (len * len)
    vec3 new_grav_pull = dir * new_force
    float isnear;
    if(len < 1){
        isnear = 1.0;
    }else{
        isnear = 0.0;
    }
    vec4 output = vec4(new_grav_pull.x, new_grav_pull.y, new_grav_pull.z, isnear)
    data_buffer.otherCords[gl_GlobalInvocationID.x] = output;
}
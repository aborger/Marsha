f = open("tundra.urdf", "w")

def write(str):
    f.write(str)
    f.write('\n')


write('<robot name="marsha">')
for i in range(0, 8):
    write('    <link name="Link_' + str(i) + '"/>')
write('')
for i in range(0, 7):
    write('    <joint name="Joint_' + str(i) + '" type="continuous">')
    write('        <parent link="Link_' + str(i) + '"/>')
    write('        <child link="Link_' + str(i+1) + '"/>')
    write('        <origin xyz="0 0 0" rpy="0 0 0" />')
    write('    </joint>')
    write('')
write('</robot>')

f.close()
    



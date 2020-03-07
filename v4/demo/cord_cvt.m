function [x, y] = cord_cvt(long, lat, angle)


    x = long * cos(angle * pi/180) + lat * sin(angle * pi/180);
    y = long * sin(angle * pi/180) + lat * cos(angle * pi/180);


end
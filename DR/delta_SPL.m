function delta = delta_SPL(r,g)

% project -r/|g|^2 onto [-1,1]
esc = -r/norm(g)^2;
if esc < 1 && esc > -1
    delta = esc*g;
elseif esc >= 1
    delta = g;
else
    delta = -g;
end
end
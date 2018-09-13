function bisseccao(f ::Function, g ::Function, a::Real, b::Real; atol=1e-6, rtol=1e-6, maxiter=10_000)
    (fa, fb) = (f(a), f(b))
    ϵ = atol + rtol * (abs(fa) + abs(fb)) / 2
    if abs(fa) <= ϵ
        return a, fa, 0
    elseif abs(fb) <= ϵ
        return b, fb, 0
    elseif fa * fb > 0
        error("f(a) e f(b) devem ter sinais diferentes")
    end
    x=g(a,b)
    #x = (a + b) / 2
    fx = f(x)
    iter = 1
    while !(abs(fx) <= ϵ || iter > maxiter) #!negação
        if fx * fa < 0
            b = x
        else
            a = x
        end

        x=g(a,b)
        fx = f(x)
        iter += 1
    end


    return x, fx, iter
end

function bisseccao(f, a::Real, b, estrategia)

    g(a,b)=0
    if estrategia == :bisseccao
        g(a,b) =0.5*a+0.5*b

    elseif estrategia == :esquerda
        g(a,b) = 0.1*a+0.9*b

    elseif estrategia == :direita
        g(a,b) =0.9*a+0.1*b

    elseif estrategia == :aletorio
        r=rand()
        g(a,b)=a * r + b * (1 - r)

    elseif estrategia == :falsa_posicao
        g(a,b)=(a * f(b) - b * f(a)) / (f(b) - f(a))

    end


    return bisseccao(f, g, a, b)
end

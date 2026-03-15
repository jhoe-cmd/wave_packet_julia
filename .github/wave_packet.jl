using FFTW
using Plots

ħ = 1.0
m = 1.0

Nx = 512
L = 100
dx = L/Nx
x = (-Nx/2:Nx/2-1) .* dx

dk = 2π/L
k = (-Nx/2:Nx/2-1) .* dk

dt = 0.05
steps = 220

# barreira de potencial
V = zeros(Nx)
for i in eachindex(x)
    if abs(x[i]) < 2
        V[i] = 2
    end
end

# pacote gaussiano inicial
x0 = -25
k0 = 2
sigma = 2

ψ = exp.(-(x .- x0).^2 ./ (2*sigma^2)) .* exp.(im*k0*x)
ψ = ψ ./ sqrt(sum(abs2.(ψ))*dx)

anim = @animate for n in 1:steps

    ψ .= ψ .* exp.(-im*V*dt/(2ħ))

    ψk = fftshift(fft(ψ))
    ψk .= ψk .* exp.(-im*(ħ*k.^2/(2m))*dt)
    ψ = ifft(ifftshift(ψk))

    ψ .= ψ .* exp.(-im*V*dt/(2ħ))

    prob = abs2.(ψ)

    plot(
        x,
        prob,
        ylim=(0,0.6),
        xlabel="x",
        ylabel="|ψ|²",
        title="Quantum Wave Packet Tunneling",
        legend=false
    )

end

gif(anim,"wave_packet.gif",fps=30)
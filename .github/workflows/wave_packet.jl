using Plots

gr()

σ = 1.0
x0 = -5.0
k = 5.0
ω = 2.0
v = 1.0

function wave_packet(x,t)
    envelope = exp(-((x - x0 - v*t)^2)/(2σ^2))
    carrier = cos(k*x - ω*t)
    envelope * carrier
end

x = range(-10,10,length=400)

anim = @animate for t in range(0,8,length=120)

    ψ = wave_packet.(x,t)

    plot(
        x,
        ψ,
        ylim=(-1.2,1.2),
        linewidth=3,
        xlabel="x",
        ylabel="ψ(x,t)",
        title="Gaussian Wave Packet",
        label="wave packet",
        color=:blue
    )

end

mkpath("results")

gif(anim,"results/wave_packet.gif",fps=30)
Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793224813;
	b=FyutIntXVsPYpW9NvrNRI5Dn291nBtRVtwU25tu+AXVUUGphfYoACywCQPpndTAklgYS
	 BBiwVPqCH1zL6czwicyWxEe3wV45tzLarBMWawhi7Gq17BrhIpiOqusQWO126D/H+B9cY
	 KaoqpeRPcMs77mmSgOmgGtsUr8jjtiD0yLc6IIWOQeTzy+sZ3EFuxET6UrhKgaRci5bPn
	 hV6En87lyXkvUp1NGLqiwA0h8fmMwbE2c36J5aTFepunNU9toRlu23/FOtGBa3J8EOwxr
	 qBY1trBhf6gMvonB9RONlS6RS/C2WrBrdgAZ6RnAM7UP3IAV6hNEXpWaZ2T8dnbnIUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Zd8GwumqtnoBvLyA8njp+tA2dovdp6CzXPw6aKHUqHA=;
	b=19F8o/wSveahlbYoUG1HcENCivaXg2lUqMD7XkffNeuRnOKGAz8b9o2wXZhXr8xy3ktq
	 WkG4W1C0FjqXUvt7db1dWfUXIoDfwB/x8PTeogiEc80RfppQJauITylaDQvGyVOh1t4wn
	 XbKCbl2Y3WZIvftTf0Thk4EDUC2j3KfzdILiQOmu7bupMHr8bHmHetaB7GeLPWak5/alq
	 oJcEkDLdub/6xyPSU+UUCCGDUtKXAD+spbIFEI0K/BzGDOmGhB90Fuho8SBH0CqQHHQ2X
	 y4eI6dxDsjA/sVY1ICjKzJXjyalxb6e4rTMrSduahRppuTAU9gQ130jUB1/Exu6XVtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cGEijWkU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825C606A31E
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 22:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8825C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cGEijWkU
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so4341a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793224811; cv=none;
        d=google.com; s=arc-20260327;
        b=VUf9yhl24oYCMvkfIGEPH4/bPJkONB1euQqbElNmH5CzFAA+cdg0xE9X3nyrnuOcbV
         dSBXViqeuQbc3PWM1ZU/4IKRe8MUXaoBd97f01p/puRGiA+g1kfoo4ITketOtfkOyFS8
         acf12qAx4i9NgUalwwY7xF2HZ2W6HhAvgzV7WbyPiHybr2nFcsjSaBCYJv+ZySBz0fGQ
         3KWIJivnMCV/nu1QBLrF+rI0R6YStpCUXu8KTJpCKLJgQWud3n1yU17wALGFCC1RY/DG
         Pl8dLgTxRvO4avK88WzNi3UZWdECwtgi0FM1SrDM2251bNg55yJi3fwJ6JnojvUupUJP
         fmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zd8GwumqtnoBvLyA8njp+tA2dovdp6CzXPw6aKHUqHA=;
        fh=6xzRActEDnjRRL7u7zpt3hiooDzw7Dnkpa5Z4Y2eFbM=;
        b=llLb8Ch4Y53YBPOWXJmDSi2zqdBbeQYUimUc/ZsciyI5pdsjEuRFebmJwXdbJm6qef
         8XWSESRIm3vd6jMFGd9ZMjbLzft5e3iMzpK2Rwz07dSDe8LbguqSMTv0kuRmdwdJackZ
         NKiW0HxJ7ZtlRnl/96SY8tVMoxzFOjuDq/5ouoxKpPBi4BVCO1wVtLNj+t88oA4YWhlj
         k4qH+1Ws1AyaI9+wZ3unmD4Zj05gvBUbu0F7Y96WuXD1LcfZEDt4wp4pB0LgSzDLNhKf
         Vd5+gd9furVGUsdjBDH4YGm6nwwIuBlSG2vXYslenIdvXmiRhQexLOlRHXQsX/14nZD9
         /sRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793224811; x=1793829611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zd8GwumqtnoBvLyA8njp+tA2dovdp6CzXPw6aKHUqHA=;
        b=cGEijWkU8d3u8I4DeLf0OBEZHdOnUTbvXgTJBs//K8zjj+wvyhhgmGzt7LB2uVNPdJ
         5BzzTvSqi32PdWYa6Vs3BJWESnVJE/reximmLDqIKfJ++ei3SoZic7Sxul71ogeGk2Ik
         FA6bDsgpHzeOM6kHBPcyZm/Rrb304oDDQPWLmk87ktaOQ9ULxCRwKtgz1stEVsWeRXx0
         E1wDXiwfLSCyglmOkLq5FyjiEiRbHLmbd1bnHnsycOq3GGg3BtJD2mbTd4V8pjy8pG1y
         ZuR38i+9mNdIApE7ph2XUpnShAmIY6ZmkTgjmB+0XN9+PqYNNYpGmbK9r9q+BFcYkdDZ
         WUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224811; x=1793829611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zd8GwumqtnoBvLyA8njp+tA2dovdp6CzXPw6aKHUqHA=;
        b=RgT+Re6RmZgM8JA3j1O2KoPy19seVu19N99D32wVzNos+nMofPCjKuW1yh9+Bsubzs
         9BLCSdsmZVCMAR/a2IIUY8jj1m1QUqcGIbhsqHfwPsfFs6LeqCxI+FJi7SktvVVwuzr2
         bybCmx99lPZ4ZoG920XcoyAVI442OjK0dqaP6Qx77txgeNb5/9qkECRDoeFbi3+xfnpX
         D6xb1ZznDB+K6zAwBAHyeZ3H4aCG+Df8/3uKOsqGzN9IVvkoQuJKVISkcAWSMaPjEQEY
         ZYe7OhFG8AZdo5UWusm+LIsNgghJ2XU52zK+sVptC2P8Rc7Dn6Yp6XqkubqYchf8jHMy
         mW7A==
X-Forwarded-Encrypted: i=1; AKwUvBxmEYH91SWAt+iKx5X+sjFp3EEao8u94KpmK2DJLtQxe3EG4U0IO5ydAH3RAg9hT2cZbkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJoURVGbTyJsFRmUClgv7CFiTuwd7TjRZCzf8YPyQsBOdTubFt
	Gd9BI+zsd1BJoDNWcVph+iWtkwlAtbQZM9D4x4qtvVaE9i/7vNhFC/vqdiiugxlKLU0S6NmjznX
	PjLqhmKTy4Zo7oCtLaAzzq0FPzGZH54vHjpC7qc8+
X-Gm-Gg: AYBFou0vcmTkiJJqO0KwVXWyLF9CwbpZ/7fTqpAAwQ49JENq4EIFEU37C8l7v2J1I6/
	GjP353i2WeIFRKPlBaQw5sBFT948g81KkdaXuNh7TSIHwXokOV6D/aW0D7rIBv4IoJZxf5Tl7V5
	KeOo5xbeMX4jYm8B08ta9gqpIfW/EPnu6lL2kIGWP7sKCLTogytdsu2QFbt0sEYlSTE2hkviILS
	3e/eQYjCiMg4+dYC/ETihAsUJi1MQDtyicFgOZAKqWHe0hy+IUbWLv2gCMCdLPufUlw132zss0q
	66SPnSZwOjCKL5mW9zyk6Ne5XiZQsYDlL4m97GfPraamColMSUmdP3K62qV8whfbF9/Qqm5294M
	VtrE9ANRNACvLcghD5VGtjF6n/8sjFU1Uc1Ob
X-Received: by 2002:a05:6402:460e:20b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6b4b3dcbc10mr10028a12.11.1793224810422; Wed, 28 Oct 2026
 15:00:10 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-16-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-16-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 14:59:58 -0700
X-Gm-Features: AclHuK8PnD4hDj7w7FAway9rxYKulg8rm0HEMNYmqHvDAoVs2zXnBvFZD5wfoD8
Message-ID: <CALMp9eSvh5+PqSXVQAAMoWwvZiMCVEooxuVd-e-sM8mODoLb9A@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] KVM: x86/pmu: Advertise PerfMon version 5 on
 Intel hosts
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:48=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> KVM currently caps the guest PerfMon version at 2 for all Intel
> platforms. Now that KVM emulates the basic architectural PMU features
> introduced in PerfMon versions 3 through 5, raise the guest PerfMon
> version to 5. Features that require additional emulation support, e.g.
> architectural LBR will be enabled separately.
>
> PerfMon versions 3 and 4 continue to be exposed as version 2 because
> KVM cannot safely virtualize AnyThread due to cross-VM information
> leakage. PerfMon v5 is supported because it provides the
> AnyThread-deprecated capability, allowing KVM to indicate that
> AnyThread is deprecated.
>
> When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
> retains the existing cap of version 2.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
>   (Sashiko)
> ---
>  arch/x86/kvm/pmu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 4cb7c796daac..1a7be7d73b62 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -175,7 +175,21 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu=
_ops)
>         }
>
>         memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
> -       kvm_pmu_cap.version =3D min(kvm_pmu_cap.version, 2);
> +
> +       if (is_intel && enable_mediated_pmu) {
> +               kvm_pmu_cap.version =3D min(kvm_pmu_cap.version, 5);
> +
> +               /*
> +                * PMU v3/v4 has AnyThread support, which KVM cannot safe=
ly
> +                * virtualize. Expose PMU v2 instead of advertising a par=
tially
> +                * functional PMU v3/v4 to guests.
> +                */
> +               if (kvm_pmu_cap.version =3D=3D 3 || kvm_pmu_cap.version =
=3D=3D 4)
> +                       kvm_pmu_cap.version =3D 2;

Nit: on Intel, enable_mediated_pmu already requires host_pmu->version >=3D =
4
(see intel_is_mediated_pmu_supported()), so kvm_pmu_cap.version =3D=3D 3 is
impossible when (is_intel && enable_mediated_pmu) is true. Hence, I think t=
his
can be simplified to:

        if (is_intel && enable_mediated_pmu && kvm_pmu_cap.version >=3D 5)
                kvm_pmu_cap.version =3D 5;
        else
                kvm_pmu_cap.version =3D min(kvm_pmu_cap.version, 2);

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004542;
	b=WUdUTEIyU3V75fxxbKBfGJWRDY4RzochwlF4yHSnNVgT3X/W60Kfj63cGks2XUmgc0iG
	 IdC2l7NmFBnyJ/1y0l/IQ4gpa8URyJCD6hqyrx2BwcaDE6Ou9ryRr6t2nAL9HVp6yUfyp
	 RuXwrSObv8Ra1I+7GABAgF7XtR6TtcL2sYmwcSK6py1J29Hw4yrySAM6spMmfIGfXBMs8
	 fbz/+9MoPdiJNzQ9U62epGHhITmIPKsOzkJdlge9dLBd1/lM7QOFB9m7N83o212IzJZcR
	 Cm4plwzmmsZBDU7iP883NoBJUoH3dIvzWZ+8XJI4srj3lYbmX5JnFkRZBEJf25hjDhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004542;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UavySZ+OeIKq2CthQuXeeB3YfvoHKnTgBFS2bFiccoo=;
	b=qfgqhhLKojjvmvLo/aWjRYPMst1BZIxsyCZl4cvLG8mWn0Lz2rr9FiVgu7sPuF6LM0aT
	 knvBPlxcwzQKe2Sp7bolTD7R1TTBBPQyRShVzJC1u6CZJTzG5/vwGAO8hGUiVB3F8C0Em
	 S3f4zUuAH4Q2WH3JvZTU1EQcQTkEmzvSs4xGYgQ+8sdN+4KJ4LU4aQCS0LrNF3SGLTTZL
	 Vm1dtOZqbH62BgWEUODBdrC2oYT6aBC1v7oZO/voUWQeDEfHppGWEVAFOvYqv0o32acOz
	 NGY9N10ncEu2m4Na04nRQ4MCN2pyHQ+0L/UKwusNxTPy52HPc1Tj8SiV77xRlbnOn1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPRM1fig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F8606A32E
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPRM1fig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBC01F00903
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794004541;
	bh=UavySZ+OeIKq2CthQuXeeB3YfvoHKnTgBFS2bFiccoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nPRM1fig4mV2k6m7RKcPFyXNlgjxc/bUp/DiSsUeC34MP8x5DBQUT1ywMrlVBv11T
	 KzZFI5SEP85RrzRQxAu81Wj+c9q3RxNb/WbRSJ4BG+omGGxp/HkzrenkLTpCPFmvdw
	 SK9/7rW0eqRKWpP477t8bgHisxj+eJQ/WPfbI80+5ZJfur67H1dq+Nkh6tE4MPFqkR
	 U63funfTSpw98uVZAerExeZFV/g9jfg6qHEKAkEYcHWYUfhIO5RaZOWInk/v0vXVUc
	 ed70vNuA+WlJcKaHmRbczxLJfqKfiJ2kWUGfHqA51vwhWLS+7Ql9yXIInK22LQ1FeW
	 ZLX3JeaE2Mb+A==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4ced671398so144947066b.3
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 14:35:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwKOmRsEs5keOIpwbfgvYN2T5B61eJ9SJIBdjDkSn1HzEs2AZGLkhFV7kIARAMcVkR/c1I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ws+okE2ucizm7JXk8dy9h5xGXaHjf1v15cTc1gxureHgjuAkH
	rx21NBjI+7hQr3UunCEQD/Eb1RHnJAOFUuRtyF8rQK0sErkJvvtF4enRCrbiE91+RDgg3bJtWM7
	oPDCuaGIutfQQAVGESTz80Z/064o4UrI=
X-Received: by 2002:a17:907:5c4:b0:c29:5172:6151 with SMTP id
 a640c23a62f3a-c4d35542b5dmr321291666b.45.1794004540573; Fri, 06 Nov 2026
 14:35:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-5-zide.chen@intel.com>
 <au4kyULjUYdqbfIq@google.com> <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
In-Reply-To: <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 6 Nov 2026 14:35:27 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
X-Gm-Features: AclHuK-VoUhifM_qge0s6Rn8NEfCDJVzOUdT48Q-413RN0Wf6-4xq5DSBFi-OSs
Message-ID: <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:19=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wro=
te:
>
>
>
> On 11/6/2026 1:09 PM, Yosry Ahmed wrote:
> >> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kv=
m_host.h
> >> index b8875ed5502c..4f192429ed93 100644
> >> --- a/arch/x86/include/asm/kvm_host.h
> >> +++ b/arch/x86/include/asm/kvm_host.h
> >> @@ -595,7 +595,10 @@ struct kvm_pmu {
> >>              DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
> >>              atomic64_t __reprogram_pmi;
> >>      };
> >> -    DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> >> +    union {
> >> +            DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> >> +            u64 pmc_exists64;
> >
> > __pmc_exists would be more consistent with __reprogam_pmi above.
>
> I used the *64 suffix and without '__' to match the cntr_mask/cntr_mask64
> and fixed_cntr_mask/fixed_cntr_mask64 pattern in struct x86_pmu_capabilit=
y
> (patch 7), whereas __reprogram_pmi used '__' because it is an atomic64_t
> rather than a scalar mask.

I don't follow why the '__' prefix is specific to atomics, but anyway,
I will leave this up to you and Sean.

>
> Also, arch/x86/events/perf_event.h has similar names:
>
>         union {
>                         u64             cntr_mask64;
>                         unsigned long
> cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>         };
>         union {
>                         u64             fixed_cntr_mask64;
>                         unsigned long
> fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>         };
>
> Seems either way won't be absolutely unifie
>
> >> @@ -120,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(=
struct kvm_pmu *pmu, int idx)
> >>                      continue;                               \
> >>              else                                            \
> >>
> >> +/*
> >> + * @mask is expected to be a scalar unsigned long derived from pmu->p=
mc_exists,
> >> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_=
COUNTERS,
> >> + * so iteration up to KVM's maximum counter count is safe.
> >> + */
> >> +#define kvm_for_each_gp_counter(i, mask)    \
> >> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> >> +
> >> +#define kvm_for_each_fixed_counter(i, mask) \
> >> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> >
> > These are not used in this patch, are they?
> >
> > They should probably be introduced when they are used. Also, do we
> > always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
> > yes, maybe we should pass in the pmu here instead?
>
> The intent was to group all bitmap accessor helpers together in this
> patch for easier review so that the big patch 5/18 could be kept to
> mostly mechanical replacements.
>
> But if you prefer introducing them on first use, I'll move their
> definitions to patch 5.

Yeah I think it's clearer to see what their definitions are with their usag=
e.

>
> Regarding passing 'pmu' directly, I initially implemented it in this
> way, but I can't recall why I discarded it. I will take another look.

Thanks.

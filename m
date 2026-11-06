Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004698;
	b=m5iQKZzsxQEnodTwMWlIk9ZxyMCT243i8RlRzl1SdDPxYyqoMDRKfe8oTcnyVdFsXeaE
	 +JIMhTNLaqkobMExVqjRpb7y57pV1eKq3HrFWPNTrsU7J4oykCiQDy2H6a0ZDm/C9NXQ7
	 JQ6aFkGobXX8f+emu/C8xVY7s5qhD8UbDc5zSQSd36JclJTxDWt7GwUI64Kcc1zYKkMhD
	 Zq79C6ISB34ZapsxXhA6/K38LudHcmvoadPEZWE99KOpX2nlbM2VmOq+1EN1nBTDpqocQ
	 HU+IWyQ8n+gc/ZCV240ADejWH4FBFj8KkdqZwLbOF/hFKyRXxbx+CzZer/dhQ+ieh+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004698;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VV1Mfm3TCiX+PFest0QA96zqc7lpSirF2QO8NESV8gw=;
	b=RABDGx9yKiONHXWkTQKq8IW4iA7OZ92QZ4FJ5AaE/WueaKMJKXkOTqvoesSMm2Fd2fQR
	 GyjdktftmnHizR9IQKNqTCGzCLgArEkMAQEwZEhB3l6tgnvtKQnBxVPGPzDFXlWSkoFnZ
	 5p3vOV1iPOO5UvYyjZAsxGuo2jLNO7geRC3iKUhizxiv0QLAPuP1JIF/egdnhy8FX+uqh
	 +N/cPcilkZWw0PGWoa53A9J5uRs8uJDpW9rXR6O1RgA/OR3bNvSGL2tP8emGmxtqC7QG3
	 O5pVhAAoLpIaBOzy98/L4odEVKdPrgQc2npyP21VMp6AiTmX2LzmUgc1lvNUkqCWNqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+hkREkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2519606A32C
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+hkREkJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3FF1F008AB
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794004697;
	bh=VV1Mfm3TCiX+PFest0QA96zqc7lpSirF2QO8NESV8gw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a+hkREkJvfNJfQXxIl7bMHmaTWEO4rXPI/43cIn1nSAylWA38p12smeLkfoz68Yqa
	 Yh7B/xDqo3qV8BGzZdXTmpclEDITBd40LxvZI6UL7X/qFSAzIJD87ShHJ7R0BOLtuO
	 XcMMLnhCGoKHpcC3RBJrm4w4MNGtkGUdrr5xMZi+0b1Q58hfes4O+ZxkJ+ZfTyuyS5
	 ZNSNT9abFbRt39pfD3OHtRNKZtvk3V+sJr/4nVy41iBilVsWDSaLPb9gsyaPZlKWOE
	 8uUIMtmZcrUsOfEfYpzxcTy0fXIwjvF2OZ0zKT4uhxzW4NT5dPvXyl3VWhhUlmHi/0
	 dDS2k1N9+GtxQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c49b431f022so166796366b.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 14:38:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw6Swgt4dH66Zqw7trBForMT5X0XQJVdCpOGEjR6SxD69XgjWuOAm+LR0kkCi73crxohkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mgq/igZVrGvwFZGKYEHbH7Zny+nFSCyN/pij0Lii9OPF3ausj
	s09tUDf91B9tcmMCHobuz1ul2rMVURsBl7AROMtNTdudfUF5+ZpZ/qrp6ZVgFNceD9ITRsR3MDu
	K/5vuIjunGEZbZp553jpywubWwFlPlSM=
X-Received: by 2002:a17:907:9803:b0:c40:f9ea:7387 with SMTP id
 a640c23a62f3a-c4d346923b7mr295391666b.6.1794004696138; Fri, 06 Nov 2026
 14:38:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-4-zide.chen@intel.com>
 <au4dVD2cZbvoqEa4@google.com> <49798d13-f426-4834-9996-5d8f1f7dad4c@intel.com>
In-Reply-To: <49798d13-f426-4834-9996-5d8f1f7dad4c@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 6 Nov 2026 14:38:03 -0800
X-Gmail-Original-Message-ID: <CAO9r8zNQX_fzYpiF8sC2i+S2E4XvxrMarmLg75J=kgX_2Npu0w@mail.gmail.com>
X-Gm-Features: AclHuK9hbPxh7eWR_k3ODCU3ex8SniyHqugMgQFLThIlqSvJYYwfWvKiIvfdme4
Message-ID: <CAO9r8zNQX_fzYpiF8sC2i+S2E4XvxrMarmLg75J=kgX_2Npu0w@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] KVM: x86/pmu: Rename reserved_bits to
 eventsel_rsvd in kvm_pmu
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

On Fri, Nov 6, 2026 at 1:16=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wro=
te:
>
>
> >> @@ -214,9 +214,15 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu=
)
> >>
> >>      pmu->counter_bitmask[KVM_PMC_GP] =3D BIT_ULL(48) - 1;
> >>
> >> -    pmu->reserved_bits =3D 0xfffffff000280000ull;
> >> +    /*
> >> +     * AMD PerfEvtSeln registers do not support PinControl, and KVM d=
oes
> >> +     * not emulate AnyThread due to cross-VM information leakage on S=
MT
> >> +     * cores (as on the Intel side).
> >> +     */
> >> +    pmu->eventsel_rsvd =3D GENMASK_ULL(63, 36) | ARCH_PERFMON_EVENTSE=
L_PIN_CONTROL |
> >> +                         ARCH_PERFMON_EVENTSEL_ANY;
> >
> > It's probably better if we diff against the generic pmu->eventsel_rsvd
> > set by kvm_pmu_refresh(), and explicitly add/remove bits as needed here=
,
> > like the Intel code. Then we also avoid re-iterating the AnyThread
> > rationale here.
> >
> > What do you think?
>
>
> Yes, I think this is better. How about this:

LGTM, with that feel free to add:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

>
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index fb5a298244ec..15d4b94826f8 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -213,12 +213,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>         pmu->counter_bitmask[KVM_PMC_GP] =3D BIT_ULL(48) - 1;
>
> /*
> -      * AMD PerfEvtSeln registers do not support PinControl, and KVM doe=
s
> -        * not emulate AnyThread due to cross-VM information leakage on S=
MT
> -        * cores (as on the Intel side).
> +        * AMD PerfEvtSeln registers do not support PinControl, but suppo=
rt
> +        * a 12-bit EventSelect (bits 35:32 in addition to 7:0).
>          */
> -       pmu->eventsel_rsvd =3D GENMASK_ULL(63, 36) |
> ARCH_PERFMON_EVENTSEL_PIN_CONTROL |
> -                            ARCH_PERFMON_EVENTSEL_ANY;
> +       pmu->eventsel_rsvd |=3D ARCH_PERFMON_EVENTSEL_PIN_CONTROL;
> +       pmu->eventsel_rsvd &=3D ~AMD64_EVENTSEL_EVENT;
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
> kvm_vcpu_has_mediated_pmu(vcpu))
>                 pmu->eventsel_rsvd &=3D ~AMD64_EVENTSEL_HOST_GUEST_MASK;
>
> >
> >
> >>      if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_medi=
ated_pmu(vcpu))
> >> -            pmu->reserved_bits &=3D ~AMD64_EVENTSEL_HOST_GUEST_MASK;
> >> +            pmu->eventsel_rsvd &=3D ~AMD64_EVENTSEL_HOST_GUEST_MASK;
>

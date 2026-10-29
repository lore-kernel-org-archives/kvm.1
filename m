Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311603;
	b=NyHUhIs8nVP5pNIJdX6oeVQAFw4H8n1Yvv2jEr34j5ut3YWMS5mnD5C8WvmaF8CaLIeK
	 Fc+T7ZthheEfw2+cnJZb3O8/7cg6E5vsZWOKUkqJKOZH8Z6Wa9yo7q1cFKQsHDWp+Cbj/
	 p3DOI/vmAIvV3FObMls/c4ls4OOKBVGFNjptO277YA8xWBOckWW7WbQ/qxuP8DyiwqUab
	 8CpwoGWCa6oHdv40d96mApukeL7m1E2Bd0OJfUxDkMNtUVEyGlIM8Dem5KDfn9aAAc4Sx
	 wUjnH/NU25F+2cPCOZdPt0BA8fBAZc7KySAICngHuqKnwtsrz0wUYvscAtZDKb5Mcvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311603;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=vfDsYkb1rupmnaoE26fc2eH1wSISvhn3BAdlNxMy260=;
	b=Xo/3ulgcHUcVbgzbLVYS09O9JfH+b7HndrdtR4BIk028oEgNubHMYpz8Gx6e5ZfIk4tg
	 N/+LVeSEeef3vWoTlrmqQ0SGWHZbHpmflDzQN8/bSPaeb9LQ+J7F475s63IklwOISruqv
	 x8fPm6TfkS1vhu+7MEEkp7lGFslfVxGKitXSUvC3gRfJUISGhNt+uGiMATKALNpLr6PnF
	 XzzmNBgPtsc9Tk2opmq3DAoboQEhKr8DPD7uQ2WXwaW5CXoC6S8Ry9JaAlTJxoZW91G5n
	 yVHY0zjROWpOvT7h0Df9DTd2FZo7D8pxcxr8q8S2DfkB7YhVOwIGSGCK8+JAAqwQAnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Id73sxy8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBD606A32C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Id73sxy8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C531F031E3
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793311601;
	bh=vfDsYkb1rupmnaoE26fc2eH1wSISvhn3BAdlNxMy260=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Id73sxy8FQws9662a48X3WJ155EdYs1sKdjseAOifu6aMxceu2kV2X/E/kL8uFrse
	 rYsgZ1rH7wOdQn/P8N2Zes1J9QuPu5Jhp0WjItFxuzXWggT/+N5uW2s59px19vleYO
	 TxFWIHTLp4nh69tjwjNg2Jy2GwXin52E78x9KIa102a3TiHjPhkqPm5xiHlcqOmaoo
	 fpuV/LW+kvWM+wg3ORlZefZJ/ym5zIZ9L76th4F1uPN9HrB7RbAFYf0ChXGdMRRp4K
	 +9vLgYBWPi3ciskd221/ooktYgyVZaI0kcA9WWSztkiHu8Sti08O695BRPYVpIIFTA
	 o5C5Oa3egNKeQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c34bff61551so3055566b.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:06:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwUE5WF0uxDDqL3uuNpxbzIYotAtCctQFOsUG4kBN65Ck839ADx3rTq40PAjk3TAlFHyi4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIL3eryZgS7b1W6qWh+RaETdN8zJ2otF2HAoyUI8dqp1+fqDHl0
	aOlJ9pqW0bWs5ikuy6k1O5XDFAC+/tGTaMpWS4N+Ysu+ichSrUWNuAZMDJ3oJ8R0gQHEGLP9Dsm
	t69un7C4WzP6QXqRIglp0JHX56ZtAah0=
X-Received: by 2002:a17:906:c109:b0:c46:9ba4:872f with SMTP id
 a640c23a62f3a-c4ca7acbaf8mr32137666b.36.1793311600609; Thu, 29 Oct 2026
 15:06:40 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918193937.569414-1-zide.chen@intel.com> <20260918193937.569414-6-zide.chen@intel.com>
In-Reply-To: <20260918193937.569414-6-zide.chen@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 29 Oct 2026 15:06:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
X-Gm-Features: AclHuK_h6YwuBizUsxN-GdymIVz4fJ18vw0iMYEWjNc1ZjkVmTudt-64at2AUZE
Message-ID: <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 448044a2b121..f4d3801b97bc 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>                pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
>  }
>
> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)

The name is confusing, this doesn't control the intercept of
PERF_METRICS (and it wouldn't be correct to use it for that AFAICT).

> +{
> +       return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
> +               !kvm_vcpu_has_perf_metrics(vcpu);
> +}
>

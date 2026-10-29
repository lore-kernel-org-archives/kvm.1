Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315977;
	b=X3+698ZXuZ7F7rfu3fTtKzXqnChK6HtK4P+YrYbILV4+eZX8vVrzlJGXZrYrV5RB0ngd
	 wxlq8VaCs7twM3NQVZ75B9wC7UGRwWCyguuNtC7OSJyC9tnIldTm8a0BgnvhgCvTYuxie
	 5I5ISAdZkSpMashJz26YUL6Z6D4oqIXh+kiXDh8DKGvYWP/+2l8z9YmAv2e8Zak689L1F
	 FyGrfZA29NOWQNFAVOWCuc7ZjJcrML7HLbW5xlP9HT19PQzKPh+Gyyow6G0fGhO0uWwR1
	 7QmAtbgIcqdEHFs3EOQxUdwUpVFfJsKzaZphWk7v6QQQ9zFhar/yb/Kpa0WLWp1CGRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315977;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4o4yx6uKrIgl2Ge60xAHsUJZAj2BU5ETNvNPMJDaFcU=;
	b=TBE0bi6Dc3OspMYQHVW1oHvlF8X8Ra/5WFfkyBsvOvlZQpY6UwQ3Cie66hXFpEHUBFlX
	 0/PenpwV7bbqGl4ct7xeyJiZhuLpEXFfbScx9lHfCNlFAXqSdRDj91anX/baeuy4FYu0b
	 JQTLg3RpLHmjLHdx/RJbSO7+wlMdky6drghS3uatQAWddKTLw3sj1LSqe2SwGNIxt8QWx
	 JlLlDZ8kKKEq9sJSLpZWfayKyPHww+s2ajehfBIY1e141LqKRzXg81KyyD1GBOfg1YFMC
	 lfgy6HdOArVcMWKDU7IPRl8JVDPZ209vOB3afOYhl0OeunYofrExQS6479ylwLsBDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcwpuPC2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF27606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcwpuPC2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DCC1F031E1
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793315976;
	bh=4o4yx6uKrIgl2Ge60xAHsUJZAj2BU5ETNvNPMJDaFcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NcwpuPC2Op2XiOCN3CxK7du7I1HYVo0DRcXSENw650aCofdptif3ICtsFm/lu7spv
	 NHps+vRbV2EovrEu9aVivxBaNGreLvER/7qObQYGph2Zg6odAVAENlj8+ICNZRNKt5
	 OiXnxb7VoK6WQQRxY5WINR639bshwUbA0h8spf2O1DKafJbIIaoImrSP2vnYA1fcMr
	 wwkzj7rhVYy+8tgD5vqQCZEayIe2CKzCL8g1X2NoNihoVxzUL+jklcUDVeYVgk4haM
	 KnOTuzoidjraKymlIrs2k6jLvrJfqy45hC8gElIP0j3AtL2im2ghSAVxnHfSxTGmSW
	 IDOp3MrhRCd1Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c414e5d282eso9485466b.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:19:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1wdA6VkUrj9oadd1A4Rrg/TL2V0FNPvFQfpmUxOKVWxWSLaQizL/MHZ0C98B4tDO04NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXTl2wwt85EoNq5FfhWifov/kErimW4Vlu6u3IjbdCHeLgrI6z
	Fk3ZPqRAbxTn/fDXh30xV4ecHHLvDp7BJ5aT9o+mdKiplh8FmfKnQFA5HpfLh9MYbGr1fr+2S6N
	bLdeFQQPkAbdP7PGW3d8Iy0rNY7SHw2I=
X-Received: by 2002:a17:907:96a1:b0:c45:d8aa:6ae5 with SMTP id
 a640c23a62f3a-c4ca7b605e4mr47008066b.42.1793315975074; Thu, 29 Oct 2026
 16:19:35 -0700 (PDT)
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
 <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com> <e5e719ec-7012-413c-a446-86fd35aca33d@intel.com>
In-Reply-To: <e5e719ec-7012-413c-a446-86fd35aca33d@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 29 Oct 2026 16:19:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOLCBhWZ5P1BEU24p8++3jVLTPSOdNreBk3RUC10Z79TQ@mail.gmail.com>
X-Gm-Features: AclHuK-HIDxM5PvTgWzHqGOjwQ4_GIVyrAYkUpF_p4ww4kQ0W2ZOlnH7mE27Ag0
Message-ID: <CAO9r8zOLCBhWZ5P1BEU24p8++3jVLTPSOdNreBk3RUC10Z79TQ@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
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

On Thu, Oct 29, 2026 at 4:17=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
>
>
> On 10/29/2026 5:06 PM, Yosry Ahmed wrote:
> >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >> index 448044a2b121..f4d3801b97bc 100644
> >> --- a/arch/x86/kvm/pmu.c
> >> +++ b/arch/x86/kvm/pmu.c
> >> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm=
_vcpu *vcpu)
> >>                pmu->nr_arch_fixed_counters !=3D kvm_host_pmu.num_count=
ers_fixed;
> >>  }
> >>
> >> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> >
> > The name is confusing, this doesn't control the intercept of
> > PERF_METRICS (and it wouldn't be correct to use it for that AFAICT).
>
> Right, these two APIs do not directly determine whether the mentioned
> resources need interception:
>
> kvm_need_any_pmc_intercept()
> kvm_need_perf_metrics_intercept()

Jim suggested folding kvm_need_perf_metrics_intercept() into
kvm_need_any_pmc_intercept(). The name of kvm_need_any_pmc_intercept()
might be confusing as well, but at least it's one less interface to
worry about?

>
> This is different from kvm_need_perf_global_ctrl_intercept() and
> kvm_need_rdpmc_intercept().
>
> How about change them to something like these?
>
> kvm_pmu_has_unexposed_pmcs()
> kvm_pmu_has_unexposed_perf_metrics()
>
> Or merge them into one single API? kvm_pmu_has_unexposed_resources()

I don't like this name any better, but I don't have better
suggestions. Since we already have kvm_need_any_pmc_intercept(), let's
just use it for now?

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316767;
	b=iKi5wBnubIug9+uDIK8QAXhsAYTFJO4uzjYX0Aw8nukzGF0IKmYuhoR6F5eE1wiTOjPN
	 PKTwEHru3K9iQ4gux1Ali0NvSCpXJ3VysVqb92maIkPiYy8FZ8AKVP3tuxZ5c5waf+JwM
	 bnQmyZxYUIlSSy5l2acdmKri6DjrQjn9H9WL4H9w/08evWacrRZ0/vhU2Abr5kN8+bzhT
	 7PHPTX5+S5iMn8xpjZunmkZM/Y+odLXDjSamEsL7bu8AzmEh5bVVSYK41eouJYtBeZyC5
	 I3oIBKUsVctNzeWRJkQcfpWDookKLsYAPt/gomCoSia7MA+S6EvyS8FPPNpUN16MIxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316767;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WQ+R1Wi6/OkFtKp/Hx8pPIEYSzqwbjd3PW+lXZaX1Uc=;
	b=L7gBYi//BPYg93m0sV/pACNLyTcGwVOqSoGszLRY9CTNPMl2rJSKHuHUT+vS/qRYsBmJ
	 cBHkFoPz999tRl2fk/xNBSDF7v2QM2V6lhIgflK1dsLm2aiwt5Po7/oMo5Isys+vQw6ZK
	 naKnOu1SkuqsfVcdtcR7d3Q4pgt0yMowyojiHwO2WxFvx9mZ/R7fKy6WZK8sDe/VydmZ6
	 wk5L/0u6pO39RLRwgCyv96Uvnszoi4dNbgXvOWyiMEjmqdSYYLiHOtFGVQt1eZct6OZSB
	 VjJ4NJVBcaKqXni3kNQZWqI3PCvK82AZoI5vH7j4Ls+za7Q8G7op7x+CHy1Z2EgQF8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJF2NBSf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8560A2610
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJF2NBSf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C11F00919
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316766;
	bh=WQ+R1Wi6/OkFtKp/Hx8pPIEYSzqwbjd3PW+lXZaX1Uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aJF2NBSfxF8pcWoOL5/L9kWpf9XVTEXDugwJXfNidUxaXuEIOTBIclc4OrZeBoe47
	 YyPgWp7qGR2aKCbM0vmQaAEFVHYtLZDB6ZH8PaaHKjpTE+qSs+uHZ2lfQ97eLx4/Lu
	 siapPMGdX/QK1xuEigRbf8dDgZAT9wQRHgYWs8yoakKpmXNJkqgJ1PWyoqsXCqbxgh
	 tG4onBrMC1TveojI3Sa/oJAM1epEWw6xMPuBvAiw93dXFnxt/+fffnVojEvo+8C8zs
	 juKcZD9H/d/mCFJljQ6rqyX5St/2qKfi2MspcjU+4ckiJKFNQb/zFwN02lqvB+E9vg
	 1XjUVE99DCBbg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso2104478a12.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:32:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3ERjIv0wofbpQcZw+gFdbWRdKxgn3JWAGh+aCHbpAaNsb+a0uoWpubfshjxHmb6d+r3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH9pxQ1pRyxpiB6VNHfv0UWQ5xki8dJhRNYa3gi9btLBK5ovpu
	ZHpEoDIkKOqxEWlOCLiwPU46BDBKaemT+UUNTg3QIz8mTCMqZSNgreDf3+HJ6MTPnl1cUe1YoZo
	TwoUA0SMXMSVKVedU4LoY5X5QQTNT7Cg=
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id
 a640c23a62f3a-c49d143133dmr362183566b.24.1793316765640; Thu, 29 Oct 2026
 16:32:45 -0700 (PDT)
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
 <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
 <e5e719ec-7012-413c-a446-86fd35aca33d@intel.com> <CAO9r8zOLCBhWZ5P1BEU24p8++3jVLTPSOdNreBk3RUC10Z79TQ@mail.gmail.com>
 <CALMp9eTOvhiLw7L--DQp_0QaFS=O1TaCQ3q0jPh=70273DA+=w@mail.gmail.com>
In-Reply-To: <CALMp9eTOvhiLw7L--DQp_0QaFS=O1TaCQ3q0jPh=70273DA+=w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 29 Oct 2026 16:32:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM0rTuROCTYdMQhdghDcbYBhfK=ezU_wU2GeM_w7FBPDw@mail.gmail.com>
X-Gm-Features: AclHuK_CqRlcCxOt3bEGnIs9tv1L0BiKuCxmnqMGOdWdJV47rykw9eUii-wSjC4
Message-ID: <CAO9r8zM0rTuROCTYdMQhdghDcbYBhfK=ezU_wU2GeM_w7FBPDw@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: Jim Mattson <jmattson@google.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:26=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Oct 29, 2026 at 4:19=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Thu, Oct 29, 2026 at 4:17=E2=80=AFPM Chen, Zide <zide.chen@intel.com=
> wrote:
> > >
> > >
> > >
> > > On 10/29/2026 5:06 PM, Yosry Ahmed wrote:
> > > >> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > > >> index 448044a2b121..f4d3801b97bc 100644
> > > >> --- a/arch/x86/kvm/pmu.c
> > > >> +++ b/arch/x86/kvm/pmu.c
> > > >> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct=
 kvm_vcpu *vcpu)
> > > >>                pmu->nr_arch_fixed_counters !=3D kvm_host_pmu.num_c=
ounters_fixed;
> > > >>  }
> > > >>
> > > >> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu=
)
> > > >
> > > > The name is confusing, this doesn't control the intercept of
> > > > PERF_METRICS (and it wouldn't be correct to use it for that AFAICT)=
.
> > >
> > > Right, these two APIs do not directly determine whether the mentioned
> > > resources need interception:
> > >
> > > kvm_need_any_pmc_intercept()
> > > kvm_need_perf_metrics_intercept()
> >
> > Jim suggested folding kvm_need_perf_metrics_intercept() into
> > kvm_need_any_pmc_intercept(). The name of kvm_need_any_pmc_intercept()
> > might be confusing as well, but at least it's one less interface to
> > worry about?
> >
> > >
> > > This is different from kvm_need_perf_global_ctrl_intercept() and
> > > kvm_need_rdpmc_intercept().
> > >
> > > How about change them to something like these?
> > >
> > > kvm_pmu_has_unexposed_pmcs()
> > > kvm_pmu_has_unexposed_perf_metrics()
> > >
> > > Or merge them into one single API? kvm_pmu_has_unexposed_resources()
> >
> > I don't like this name any better, but I don't have better
> > suggestions. Since we already have kvm_need_any_pmc_intercept(), let's
> > just use it for now?
>
> How about kvm_pmu_incomplete_passthrough()?

Better than kvm_need_any_pmc_intercept() imo.

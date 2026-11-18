Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016786;
	b=re5mNCVF/sct0GcAcr7O+L7uyGNN3bPjMOHztQMfYtKt6ZlQSBujGY8sYxBnehViK7Ue
	 Hg4LCRkiw+l2OWGshQjys8sztq5e0TDyEn8rBqYiNzMvgXHBu/SJt01VOti7inmMgXZMS
	 Lx3aee2svxyjU5xhY6RYq4l8rOlDRrandw4oNwdQrJ3+QMdtMa4/B+D4jWOcEoVA7KMbC
	 3Cl7k4h9qmHYfTwRQKeB3CUhErhyDDFugK0paRBP6cEVMrOAwN+LtlHV5Tb4Z/53Crd+2
	 D3ZvZLwwhEQ+t+xnOk81Ka/dNPx3KbwAraqWabgFR3zo+bW9Wkr4FqTWi5Abml33ThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BEwIdIu+KrMDBK5eBH1rZ544ZlhtoEyfveo49Aa+So4=;
	b=3pBsHo2fZeOBigBnebTBx1Z/0QoKf8OwMObDGf4beK3M1OJFZKdq38PBTYm/qS0p3xha
	 ju12X2QO/wiQ4mlnddvgROhAJw8BHp3vbvhWOFYsk9visZtRLHhFHkur0do7X3ERjIqke
	 RbXl1drGUt5iMZhOkFwlt1k6E6EeD6BcjE/GUZ06VYYba5pwNO49yfGFTQw0IcwG4NlSS
	 uUihu+Y9xICrBnQGsVcvH2P4ZlmP5n0egos2IuRGobPM0ebr2BO/eyOjQjQMLHO0u5yfn
	 sx5FBTg5zJ6QJJ7bbGPPR4olI1wyU7EQkotlZeSkgrVlUijucOY/sQ6E+O/1uSZ5XYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjxhkCXe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C1606A320;
	Wed, 18 Nov 2026 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjxhkCXe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC771F000C5;
	Wed, 18 Nov 2026 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795016786;
	bh=BEwIdIu+KrMDBK5eBH1rZ544ZlhtoEyfveo49Aa+So4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FjxhkCXepVQ0gmpO+4K085SjTi6qUOwoIYpnZBaNJLJkti231dFtqBcOZ8FLtwoa1
	 YxIyASnq7FnfY+2R6pnlGQ2Sjw7rwqNDBWeDsHjARttT3mzNrrqcsmEUuiABqyjCS0
	 024jylVPEl33ofMcj3T4cknaYjfeQXuucH1alyOgjN6rfrFgmx679rQTWOa9Q4hIyQ
	 gGKyRH9cx621FE5fvVxKAmZloxP4G1OnQWXvJ5XZXTtwcEdZ9SM3jg7PUEHMjiKani
	 Cl6C1x+fgQkRhFWiS8w29jFMPHIrQViv5Kw6aF2KHwnP/eZFGUcKxhXxcy9vnriwXH
	 nhSq0svo3z2MA==
Date: Wed, 18 Nov 2026 15:46:24 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
Message-ID: <av3IHMi-DiXMk1f3@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-7-zide.chen@intel.com>
 <CAO9r8zPD_i2aWc3jaKRr-=1Pz0td=6nqBpgBfVVaV3jfzVTAjw@mail.gmail.com>
 <e090723f-cc02-40c2-af57-ab5dfda91dcc@intel.com>
 <avz4LTEOcubVykim@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avz4LTEOcubVykim@google.com>

On Wed, Nov 18, 2026 at 12:59:07AM +0000, Yosry Ahmed wrote:
> On Tue, Nov 17, 2026 at 02:02:08PM -0600, Chen, Zide wrote:
> > 
> > 
> > On 11/17/2026 11:23 AM, Yosry Ahmed wrote:
> > >>  static void amd_pmu_init(struct kvm_vcpu *vcpu)
> > >> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > >> index 136069dfcd44..e21abcedea70 100644
> > >> --- a/arch/x86/kvm/svm/svm.c
> > >> +++ b/arch/x86/kvm/svm/svm.c
> > >> @@ -761,24 +761,21 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
> > >>  {
> > >>         bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
> > >>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> > >> +       unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> > >>         int i;
> > >>
> > >>         if (!enable_mediated_pmu)
> > >>                 return;
> > >>
> > >>         /* Legacy counters are always available for AMD CPUs with a PMU. */
> > >> -       for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
> > >> +       for (i = 0; i < AMD64_NUM_COUNTERS; i++)
> > >>                 svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
> > >> -                                         MSR_TYPE_RW, intercept);
> > >> +                                         MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
> > > 
> > > This fixes a pre-existing bug that was reported internally, that can
> > > happen if a malicious VMM reduces the number of counters after
> > > initiating KVM_RUN but before VM-entry. The current code would fail to
> > > re-enable the intercept on the counters that become unsupported.
> > > 
> > > Might be worth splitting this out into a standalone fix.
> > 
> > My hesitation on a separate patch was to avoid throwaway code churn.
> > A standalone patch would add:
> > 
> >         for ( ; i < AMD64_NUM_COUNTERS; i++)
> >                 svm_enable_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
> >                                              MSR_TYPE_RW);
> > 
> > and then it will be immediately overwritten and collapsed into a single
> > loop in this patch.
> > 
> > So basically cleaner logic vs. avoiding immediate churn. I'm happy to
> > split it out if you prefer.
> 
> I think it's fine. You can also fix it by using the same loop struct we
> end up with instead of adding another loop? i.e. loop until
> AMD64_NUM_COUNTERS and intercept based on i < nr_arch_gp_counters
> instead of testing the GP mask?

Thinking about this a bit more, I think having two different loop
structures might be confusing when they are later changed/dropped. So
I'd rather do what you suggested initially and add the second loop as a
standalone fix.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963549;
	b=4mFhThKPC/IWqXTIdC9h8Tpx97zRz+dNB0ujibRSUWj+3AcXM2/Z1VwfdgHikjrblGBi
	 BQKR9Y8H3eigMkDxpJ5pYb11bEEIYcO3e6O+QgsuDbLqMeGaJu6l+4avuiyb7+8bUTPra
	 xr1wyGFzV38bBHaUk2UiyWnhNC1wznsQZPovnloO8N5uo7FBRO7ZqCbDdA5e38Hz1FpMp
	 rde5ekEVCABDb/OMHGTll7J1jd8ggMr5jT9DsMOB9sk2izWDn7dNuYSYYawCyL2VXhaWt
	 xPrfarAHi8Jj2mdYSzITg8tDMP7Y5AFowFJ7Rrv3aNedba0o18ncvlBJhuZoZUDJkLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963549;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b08D7Z/QJlyiger4HOgkC1C66KOTyyBg7hQbqrfAMRc=;
	b=Gz1s9oo+9P4y0RHKWhoRWfV6iYg4BxgOEjZ3bZ75T7BsIPaukff9DfSoZSJ+QhY7qgHh
	 pAd9mAF9898alDyx+smBzsQsPkW1WGM9/qzVx6mF02LeRl/bMdkirsmKYnE+R/vIbZStf
	 qit61+4V5yo//IFmt3H0d+wyObuP0oXwe1WWYX38SHsaplHAhvYOyBV2tiTz0l0t+jGJw
	 M9H8sLV4wp/3H/E9l7VExoP3WZUzRgRDiIiEDn17iJM2Fu92VRXwszLZi52/JLNMrXyuE
	 ALWIaCFSz1SMJ9YDxqdqgGtdkT3rIam6H6yJF9qz2p0Wlpre5MrMCnkMynhBy2m6IrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEBRoiyI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C393606A31C;
	Wed, 18 Nov 2026 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEBRoiyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581671F000C4;
	Wed, 18 Nov 2026 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963548;
	bh=b08D7Z/QJlyiger4HOgkC1C66KOTyyBg7hQbqrfAMRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bEBRoiyIJTS0soBaV/sxsEVKUL/UrreqrFToJKCF0VDIJh4HGdKx98jfb7Au1NFC/
	 SnfZJ7fCIq8SDEJ+s/8+o8e9Dhb9PORicR0T8LfjhfZPkzyc1VmEsgLP6vdKH6bHPI
	 8x8210NEXMJ8LwcJxOL7aHKtQUzcuOvh6oLsR06cLfi62JtxTEgX+5hS8uxbfyghNi
	 xXqDwikA1sTKiYUwY9aADaHunk0aWIX4xojjhWaN0dxYzOihRn7h3gcolqElVtjwHS
	 6glsCrcXqpw+xSmY2DIJK3XvVO/gfKrUVGMW7Y1bIg5ostylrZKtIOEBLN5BqVfGdu
	 GZeWUFubnKn1w==
Date: Wed, 18 Nov 2026 00:59:07 +0000
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
Message-ID: <avz4LTEOcubVykim@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-7-zide.chen@intel.com>
 <CAO9r8zPD_i2aWc3jaKRr-=1Pz0td=6nqBpgBfVVaV3jfzVTAjw@mail.gmail.com>
 <e090723f-cc02-40c2-af57-ab5dfda91dcc@intel.com>
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
In-Reply-To: <e090723f-cc02-40c2-af57-ab5dfda91dcc@intel.com>

On Tue, Nov 17, 2026 at 02:02:08PM -0600, Chen, Zide wrote:
> 
> 
> On 11/17/2026 11:23 AM, Yosry Ahmed wrote:
> >>  static void amd_pmu_init(struct kvm_vcpu *vcpu)
> >> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >> index 136069dfcd44..e21abcedea70 100644
> >> --- a/arch/x86/kvm/svm/svm.c
> >> +++ b/arch/x86/kvm/svm/svm.c
> >> @@ -761,24 +761,21 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
> >>  {
> >>         bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
> >>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> >> +       unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> >>         int i;
> >>
> >>         if (!enable_mediated_pmu)
> >>                 return;
> >>
> >>         /* Legacy counters are always available for AMD CPUs with a PMU. */
> >> -       for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
> >> +       for (i = 0; i < AMD64_NUM_COUNTERS; i++)
> >>                 svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
> >> -                                         MSR_TYPE_RW, intercept);
> >> +                                         MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
> > 
> > This fixes a pre-existing bug that was reported internally, that can
> > happen if a malicious VMM reduces the number of counters after
> > initiating KVM_RUN but before VM-entry. The current code would fail to
> > re-enable the intercept on the counters that become unsupported.
> > 
> > Might be worth splitting this out into a standalone fix.
> 
> My hesitation on a separate patch was to avoid throwaway code churn.
> A standalone patch would add:
> 
>         for ( ; i < AMD64_NUM_COUNTERS; i++)
>                 svm_enable_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>                                              MSR_TYPE_RW);
> 
> and then it will be immediately overwritten and collapsed into a single
> loop in this patch.
> 
> So basically cleaner logic vs. avoiding immediate churn. I'm happy to
> split it out if you prefer.

I think it's fine. You can also fix it by using the same loop struct we
end up with instead of adding another loop? i.e. loop until
AMD64_NUM_COUNTERS and intercept based on i < nr_arch_gp_counters
instead of testing the GP mask?

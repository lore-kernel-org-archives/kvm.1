Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682151;
	b=ZcyHaky4nd8/TZu5lleFuSP2ElKJJ767uTB42TfLXOtdluDYqukYFss/jTx0qnWv51AI
	 yBg7EPyeEMbG8I2QcnF+LBfTzn9SXo+hZ90VI/V2RkBv1EpcTMu7EfiZ6qczLZBhUFrhu
	 gXGc5/aVbKlCWzYMGf2eYDqwCbbWKzZFtnx2sMeDQmhu8731Nuo25wCmULemAeR6b9Qxq
	 7ZgQsqAMYyMCqFqNzRp1dWsnXd8jc1GWALbw0JRKNiEnmkA3YGljY5LFhEHN2o3oOYWDL
	 Ii8zDADvCNB+IFMt40V89GKbjyuM6Ek1c9MgyfGsp9Xu1TJonYRcP3B4xwnxCBl2kBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4j5FMF5C4EhW1bxk07JPFMLAnl1AANpWbiGuP7NZOZQ=;
	b=ESC1K4cXOQZ9Gr+5SEowhsVuOVJHXiLHTXts5yD0iqax+fA2wtQ+4UGlu2w120GBur2x
	 Hth2Xy+5HOKrWqHsLQk/ysKSxs9H5tGMLy8jFOj0lw/Nu1QLjDP5sW0+VXy/tcFBmNkqg
	 By65meAFhWtkMPKr8bVdPphhotreG7uZv8B1B/H6isD27GreVtuuv9CoMg+ntOPYrp2Mk
	 2DbLSNGupNBQhzWSwztauc7kmmYOzc3MCSknAVdirCEXh2m3QA9O842eKdvyZO7Hhv7SU
	 1bLk9AqgZuxSNeYMB+Ly1huJPFyk87jectWvZ2YUJK0l1peXo+m5H7ghNhcFSs1OGjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrWLf64z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA3606A323;
	Sat, 14 Nov 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrWLf64z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D791F000C4;
	Sat, 14 Nov 2026 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682150;
	bh=4j5FMF5C4EhW1bxk07JPFMLAnl1AANpWbiGuP7NZOZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nrWLf64z26dKbtwiJU0scBzerlSr8X31TWZdpQoEwyFJr/4jeE69GwTRmA2VlrDVq
	 lgp9/zZLgztThA+eu+X4aJECDZoQN04otHbP6AvTrh997qBxKgJBRRY3URgbnnzQ6Y
	 7t964v8ZiuOKqNwvrN7xr0msSLz+8DgbaRYni6Cag1GBNFm2XTO3WeVMsEA+TgcQ1U
	 3q397dwRUmLSkjToYXIjtQ+RyerKfGkuOYaPLSIVIc2eZ2tHTwCWP6Wqwv+ZY3jvXY
	 y7tntkc3SVFmgzeAy1GDKdXTmXdfQoOFPO3gwrI3nsvfVGuMKT/vvulf2AVHDvJlDf
	 J9XdlZPOz159g==
Date: Sat, 14 Nov 2026 18:49:09 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 01/21] KVM: SVM: Drop counter MSR checks in
 amd_is_valid_msr()
Message-ID: <avis5Ose25IiYM2S@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-2-zide.chen@intel.com>
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
In-Reply-To: <20261112203227.289379-2-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:07PM -0700, Zide Chen wrote:
> amd_msr_idx_to_pmc() accurately validates individual counter MSRs by
> checking whether the corresponding counter is supported for the vCPU.
> Validating counter MSRs again in amd_is_valid_msr() is redundant.
> 
> Furthermore, validating counter MSRs using broad checks like
> "pmu->version > 0" or "PERFCTR_CORE" is inaccurate and misleading. It
> falsely validates unexposed counters, which then fail in
> amd_pmu_{get,set}_msr(), injecting an errant #GP instead of taking
> KVM's fallback (read 0, write ignored) and breaking migration for
> unadvertised counters.
> 
> Finally, the range check in the default case is dead code because AMD
> CPUs currently support at most 6 Core Perf counters. Even if future AMD
> CPUs support more than 6, counter MSRs would still be sufficiently
> validated by amd_msr_idx_to_pmc().
> 
> Drop the counter cases and dead range check from amd_is_valid_msr(),
> leaving counter validation solely to amd_msr_idx_to_pmc().
> 
> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Should we also drop the get_gp_pmc(.., MSR_IA32_PERFCTR0),
get_gp_pmc(.., MSR_P6_EVNTSEL0), and get_fixed_pmc() calls from the
default case in intel_is_valid_msr()?

They are also covered by intel_msr_idx_to_pmc() IIUC.

> ---
> v4:
> - New patch. (Jim)
> ---
>  arch/x86/kvm/svm/pmu.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index c18286545a7a..bf2f23c30afc 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -106,23 +106,16 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  
>  	switch (msr) {
> -	case MSR_K7_EVNTSEL0 ... MSR_K7_PERFCTR3:
> -		return pmu->version > 0;
> -	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
> -		return guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  		return pmu->version > 1;
>  	default:
> -		if (msr > MSR_F15H_PERF_CTR5 &&
> -		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
> -			return pmu->version > 1;
>  		break;
>  	}
>  
> -	return amd_msr_idx_to_pmc(vcpu, msr);
> +	return false;
>  }
>  
>  static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> -- 
> 2.56.1
> 

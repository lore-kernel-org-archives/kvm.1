Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017957;
	b=RmEPhk7dE0WspHfX51PSXkLWaxz82Dq0/Wz4l8AnfIHfShkNW3nj71ajXbZ+9Ygr21DM
	 3f1WKP7ZxGAk2Snlnamen7eV0wMHod2mKXuPyLZmc8xI7fUxLEOu5CgiFitkz89pHPpYj
	 UoH55M1h+vDmUvAT3qjh3xoDKgwBVYZkjSv2CEQPXiywwP1Yikf7lQ5tGq95loWTOdg55
	 JICh/A0rtuoorCk7UmBDQzTdAAJEvhKYSKe1imWfShNjLLsd1J4z3m1ZpLGFr9TJb1ukX
	 LhTbgIoJEKmw8vUwSJ80kkRIafx+QzUsE2JyYuhgtkSR9bZlbh3rTNUnYradgHQkxQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1RVqWIfkTvyv8AsAHX64ZBvtbT+TV/A33QmNQPtvMiI=;
	b=UFsqjUhADh5F4hIDYMG9TJDCncDyTejcIOdsbwtfRh+138DIKWz3AGoo7JjrwLuHLjTp
	 3V5ZswGygrDb7tp3fSiV2k7UkN4gXGKHH6dX7DiC0AZHqLwlSwJVSzw5sGND+Re04Qdfq
	 Wrx7MYYv25hPX19elP5CXGPskV9lhbDrSKLM7Ev3OzsY2zXALTdlHQRfUam6rY819BhSv
	 quVvxk0vv/w7BsVROIH/3aE8mXzJe6L50/Pq7I2r3UO0aDtmu5cTsOK0jNdw3MpGHFAjc
	 fIp45pEzJvvhBdlLSMb6RcaKmE9xGTTlMrhoPSCUHsoySDRuidFeo4qF9dpnBYD0u/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQaAjXrc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFF606A31C;
	Wed, 18 Nov 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQaAjXrc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB02A1F000C5;
	Wed, 18 Nov 2026 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017957;
	bh=1RVqWIfkTvyv8AsAHX64ZBvtbT+TV/A33QmNQPtvMiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQaAjXrcc2xgCfgCZ8fK+bb5zP1hxMuLfviNVGGi+WS4OK+jsAZplCfAiwzvWgoDw
	 1dxmx+VYTJBdhUn367YjK+++Hnek1hkh+d94HIC8LLECHTHSE5cAVXp6Hui3DpGDD4
	 dxE6y4KfM/sR1uPuZasFlsr1cc9VqwTHhb7AobVof1Sdnyvad0I67qpeCVY4rAkMy4
	 S/FRhDLyps95jhxQrZuQO9cIGhRAxkKUVs0xSPsPvy6E7lvxnYAr8oYBocO7gGSEex
	 ENAPqwmlF80Uq5M2KrODLL4PwpsFRcw5C1JKOg4uML6I8AY1EOrFt0ZkAsD+DLivYm
	 DW8DMSeIs0Z5A==
Date: Wed, 18 Nov 2026 16:05:55 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 09/21] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
Message-ID: <av3MeWKmCRprVNWx@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-10-zide.chen@intel.com>
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
In-Reply-To: <20261112203227.289379-10-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:15PM -0700, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
> starting with PerfMon v5, and support non-contiguous GP counters
> through the Architectural PerfMon Extension (CPUID leaf 23H).
> 
> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
> which may contain sparse bits representing non-contiguous counters.
> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
> bitmask fields, including iterating kvm_host_pmu bitmasks directly in
> VMX and SVM PMU MSR intercept setup.
> 
> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
> the number of consecutive counters starting at index 0.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v4:
> - Cleanly substitute kvm_pmu_cap.num_counters_{gp,fixed} with
>   find_first_zero_bit() in intel_pmu_refresh() without throwaway
>   code churn.
> - Use find_first_zero_bit() instead of hweight64() for AMD CPUID
>   0x80000022 EBX[3:0] (NumCorePmc) and svm_set_cpu_caps() to enumerate
>   contiguous counters. (Yosry)
> - Do not carry over Jim's Reviewed-by from v3 due to reworking counter
>   clamping in intel_pmu_refresh().
> 
> v3:
> - Iterate kvm_host_pmu bitmasks directly in VMX and SVM intercept loops.
> - Clamp nr_{gp,fixed}_counters to the number of contiguous counters
>   supported by KVM in intel_pmu_refresh(). (Jim, Sashiko)
> - Drop redundant !enable_mediated_pmu clamp on fixed_cntr_mask64.
>   (Sashiko)
> ---
>  arch/x86/kvm/cpuid.c         | 17 ++++++++++++++---
>  arch/x86/kvm/msrs.c          | 12 ++++++------
>  arch/x86/kvm/pmu.c           | 17 ++++++++---------
>  arch/x86/kvm/svm/pmu.c       |  2 +-
>  arch/x86/kvm/svm/svm.c       |  8 ++++----
>  arch/x86/kvm/vmx/pmu_intel.c | 18 +++++++++++++++---
>  arch/x86/kvm/vmx/vmx.c       |  4 ++--
>  7 files changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index adafd6fa2c54..427871ec365f 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1535,10 +1535,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		}
>  
>  		eax.split.version_id = kvm_pmu_cap.version;
> -		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
> +
> +		/* Contiguous GP counters only. */
> +		eax.split.num_counters =
> +			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +					    KVM_MAX_NR_GP_COUNTERS);

Should we add helpers for the find_first_zero_bit() calls across?
Perhaps kvm_pmu_nr_contig_gp_counters() and
kvm_pmu_nr_contig_fixed_counters()?


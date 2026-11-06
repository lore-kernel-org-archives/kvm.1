Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998827;
	b=vHJkLVXCQ1Wzzcq1xKbYtM60VAevHtYnRVr/HsGRCEpcPd39cu3dUnkgNzddrevEfGl7
	 fQMvSyjyWQlJcC+qAC6ZuiniTORSBJUPEQqEGjvEytU6a2x0BvefbVKZmvvVunhYFzLNZ
	 +ZtRiTPM5Dkb7rrzTpmhMWJDAskBE6erKM+uiLIAOfirgORMQTDBWTmLwNjcTFerDA0E+
	 o8IVNA8mXA0lTtS/noRw1/TtnQVoM5k/eUifTEsKvOC285a5pk3GBzHrmEe1Uujh2mN/M
	 PXDLzG8hZJC8iH27vqd83AbOw3BWBu4iLtVj3i7hjBYqS26EC4vLUfgCSwL61CVVDtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WNl7m/hXi4gHMAflyroY/+DNB2PoxFpjxeHVm3WBpSg=;
	b=xOUAQ247DuCKgs+e2lRj0uWxvPfCQJb2nYL9KywwDg8I5GDdNBsFRssMXiW498/en4zF
	 qzTmHL2KZwirivvpBKh0pmBDfmnEZpBD9v+qzN/68YFlUONrTHGlw7v0wXDQ6polEHtMi
	 8wRardJ8kInJfXzSyuiyyTMzjVaqYjEPs3bSWG8TQXViP7qOMH41uXFV9XeJiI/8lQwpz
	 FOybMrKqA3FnjGUbnieRqjOKX8kcW+e0iH/QRo3zTpdChYvW8HuACDgB1Wq3jPPlxEPLK
	 KtvNcwptcLEZx3Adx0rEasA8D7yk0u36lA58WJFi0ZAcSlxrAFrfYFf+sSDKbNhHF7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIoreleJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95D606A329;
	Fri,  6 Nov 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIoreleJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9031F008A2;
	Fri,  6 Nov 2026 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998826;
	bh=WNl7m/hXi4gHMAflyroY/+DNB2PoxFpjxeHVm3WBpSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nIoreleJB5v0uMZFXZGVblDwl9VmuZ57G5YdznQyyKNTJbLihoTIMLak89t+SeWSI
	 6/WR0Es2i6nuUzY+pZ/PseW8adDcpPI2HtCBTTqEq6Ldyl5tkmGKRNuH5VqNNGcGHZ
	 Xq2kcbUjQUBAlqh5M4Q0gCWamK7xL73VPbbS6LD+WMGEVJZxEmn8r8il3O8z58kwOA
	 P0ONn8OoWeXwpkjzY/mJBOFC8QufLpkkNDodyzbYGU4YH9T4tScWG6L5i6UEGDEe2t
	 gbu1oqm9Nd2L3FyyOyXRTDKRaieXp0M44TPCBuTNFxRUJXJxR4TwboCiOIuQuR3mo1
	 3qsnB2BY79urQ==
Date: Fri, 6 Nov 2026 21:00:24 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
Message-ID: <au491iiV7koeP0t6@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-14-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-14-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:22PM -0700, Zide Chen wrote:
> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
> This is the superset of EDX[4:0] which indicates the contiguous
> counters starting from 0. For backward compatibility, it's recommended
> to use the following to determine if a fixed counter is supported:
> 
> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
> 
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v3:
> - Remove '&' when populating entry->ecx. (Jim)
> - Gate entry->ecx on kvm_pmu_cap.version >= 5 in intel_pmu_refresh() to
>   avoid enabling v5 fixed counters on hosts where KVM caps PMU at v2.
> ---
>  arch/x86/kvm/cpuid.c         | 5 ++++-
>  arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3310c370c5fa..00a2ca6d3049 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1554,7 +1554,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  		entry->eax = eax.full;
>  		entry->ebx = kvm_pmu_cap.events_mask;
> -		entry->ecx = 0;
> +		if (kvm_pmu_cap.version >= 5)
> +			entry->ecx = (u32)kvm_pmu_cap.fixed_cntr_mask64;
> +		else
> +			entry->ecx = 0;
>  		entry->edx = edx.full;
>  		break;
>  	}
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 1372091dc1f8..37b34b588601 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -597,7 +597,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>  						      KVM_MAX_NR_FIXED_COUNTERS));
>  
> +	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
> +	/*
> +	 * Do not enable fixed counters via the v5 ECX bitmap if KVM caps
> +	 * PMU version below 5 (e.g. when mediated PMU is disabled or on
> +	 * older hosts), matching KVM's advertised CPUID.0AH:ECX capability.
> +	 */
> +	if (kvm_pmu_cap.version >= 5 && pmu->version >= 5)

Having to check both versions is confusing. Can they go out of sync?
Should we clamp pmu->version to kvm_pmu_cap.version and only check the
former?

> +		fixed_mask |= entry->ecx;
>  	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;

I see why this is needed now, to re-apply KVM's fixed counter mask after
reading it, but if this is only needed there, it's probably clearer to
do:

	if (version >= 5)
		fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);

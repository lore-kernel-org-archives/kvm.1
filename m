Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018373;
	b=w9Rqd0iaSoKdchBHlN0ktHfMP5k0CCqotHiXDDwwExHpkkR7FVMDyp0Gt7avH359lBI0
	 vNxUfjHO+8iVCeBEW+SUAZfv2ArjddTFgOUIuz9855Y8qjx8JFxKcO9XgmDqt9brNzn74
	 WGlErMYnx6JP50PTDPX53eJM0EjPO5YFNW8Mkx2x4ZaowmFTdUcwgsQBhhuSZaKUagkBj
	 SUoYkV8T8mHFvEK+eL95PnuImuh2zjGytIQRFBCwtHIqVnQYOj8kTZa0LrsvGso5cQY/Q
	 sv1Ul234JqRi9n+OhZeEecxX7B9qdNA4VH9TQ7nIONQwnJSfDZLtydfZS2dDyyT9Sxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018373;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y9WaZRfIR6gID15FeZtBIwQrLK8oAcd6vPRViQo7VQo=;
	b=ZPcypy3Fdc3jeFCCsi/0Uf4O+Q8AAx2piQ0rZStlZYAPyZo+Xrmwv6p/I9dZEYwd7mgh
	 j80c5HPBMqWUj/LK7tMaVhk7EkViefS5KP2d0G+OSIUj3GaXca+28bSMT/5R9NmF+Rm62
	 e6etvKLNFZBtFlvChDXQ2hweAb1fl01ozfl/PxNvBNz41kBJ3EMtKn4kHT3dXWPsPUP/R
	 YhN76CWaV5mT6PdPM6Vynz9RHS5YQ1pKCBsu/o+J6cZHsyYmeVqUbXzO4/s9WFqZpzBPE
	 G8MRZVoUqf/+9vYPml1FO9V3KglNMifE+E5gVI8F6IkJU1AgSbJEgd2eGWd4c5sfBug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If1HgjTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F56606A325;
	Wed, 18 Nov 2026 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If1HgjTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903B31F000C4;
	Wed, 18 Nov 2026 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018373;
	bh=y9WaZRfIR6gID15FeZtBIwQrLK8oAcd6vPRViQo7VQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=If1HgjTx8uKjn28zc7DD0NUJoDOiD/fNxiQwrO+qLWKOqzr+rUfr0fVcwBKATI0fB
	 W/KWTnpqL2ckH1lrFTP2riEenzWZYRQY82/gpGrdF5gWk3MhYjUwgpuzuWZwyZsEr/
	 NTpJXY3hKIHBmAoAfrpmMM3wjhc4igmIH+SbzGifJjv1sOcE5I+Zelb/ENJk/o0aR5
	 +1A0j/b3KuDLV2Cn1sQIVF/D/idOXh0evQIMuV66hP1YQHeZcDMp/JXkRW8W19CNju
	 wHBX/zDdxP8Acl0zaDgXcJe+vL0PR3GZ8ylW6qh0SY+4SllVMLTpDCs/nCzJ2rlNcW
	 ELx62dyTSm4vw==
Date: Wed, 18 Nov 2026 16:12:51 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 13/21] KVM: x86/pmu: Emulate
 IA32_PERF_GLOBAL_STATUS_SET MSR
Message-ID: <av3OV2p5xvGS8Mqe@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-14-zide.chen@intel.com>
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
In-Reply-To: <20261112203227.289379-14-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:19PM -0700, Zide Chen wrote:
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
> allow software to set individual bits in the global status MSR. Reads
> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
> 
> IA32_PERF_GLOBAL_STATUS_SET is not part of the VM state, so it doesn't
> need to be advertised to userspace, nor saved and restored during live
> migration.
> 
> Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent the guest from
> modifying status bits that are not virtualized by KVM.
> 
> Bit 63 (CondChgd) is architecturally reserved in STATUS_SET per the SDM.
> Reject writes to bit 63, injecting #GP for guest writes. While older
> processors had silicon errata that accepted writes without #GP (e.g.
> SKX95), strictly enforce the architectural specification for
> deterministic behavior across migrations.
> 
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v4:
> - Split out CondChgd specific handling into a separate patch since it
>   impacts MSR 0x38e and 0x390 as well.
> - Move the defensive filtering code in pmu load to the new patch.
> - Do not carry over Jim's Reviewed-by due to above changes.
> 
> v3:
> - Split from combined v2 patch into standalone GLOBAL_STATUS_SET patch.
> - Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent passthrough of
>   unvirtualized status bits. (Jim)
> - Reject writing bit 63 (CondChgd) to IA32_PERF_GLOBAL_STATUS_SET. (Jim)
> - Filter out bit 63 before writing to hardware in
>   intel_mediated_pmu_load().
> - Store status set bits in a local variable in
>   intel_mediated_pmu_load(). (Yosry)
> - Move validation for MSR_CORE_PERF_GLOBAL_STATUS_SET to pmu_intel.c
>   rather than common pmu.c to avoid exposing the Intel MSR on AMD.
> ---
>  arch/x86/kvm/pmu.c           | 7 +++++++
>  arch/x86/kvm/vmx/pmu_intel.c | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 7ba1a3b38184..bd5954e62080 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -855,6 +855,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>  		msr_info->data = 0;
>  		break;
>  	default:
> @@ -923,6 +924,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!msr_info->host_initiated)
>  			pmu->global_status &= ~data;
>  		break;
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		if (data & pmu->global_status_rsvd)
> +			return 1;
> +		if (!msr_info->host_initiated)
> +			pmu->global_status |= data;
> +		break;

Nit: Perhaps we should follow what MSR_CORE_PERF_GLOBAL_OVF_CTRL does
and fallthrough, leaving the pmu->global_status update shared with
MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET.

>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  		if (!msr_info->host_initiated)
>  			pmu->global_status |= data & ~pmu->global_status_rsvd;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 4d05ec50f24f..c18d24b5c385 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -196,6 +196,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		return pmu->version >= 4;
>  	case MSR_IA32_PEBS_ENABLE:
>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>  		break;
> -- 
> 2.56.1
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997319;
	b=0deFY7IMRxGfyRKvn5WNEz7ewfhVbKNkWfWRUWFTH2zBuVUzh++Ce4+AKM9VTFt/oS77
	 2XecHKrtbH/8Fvb9Ki6nxHvKgALZklzig0jmeInqlyH/q4k8urjKaLBJ6FVq1jotYZXT+
	 66zZVb1nOM+XqC16dj2Ln12qrIKBYQqJGCeD0Zs0jSr//sl2zWIYIqb+r2PPQAlhn75w+
	 uxR5mKX4mvOlj7rQVprTDbqIX12IZy7/TfBoG5vJL2sWq/mh9mVRds6fk8LgprmShCLRK
	 0LsvVlkkt2ROdk5fy8UxU97lBRg167mUeOa91fuxqWEmvhddK/soRFjWP8utwL6DzHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997319;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t2PKG6ft0uQ0Jp0pnLvRhw5qbjOJj0JEcw/PXEMCoY8=;
	b=iucNKDaZIif5S7bsaBNL9/T9TaGmdpYdDS+vZciI3nwQiz2B6q6HHFecoxOjmzkF0Gd4
	 S8uDG6TsDZFZmkEBCfQg86qBPyG6EHNTr9Ak49f2BIuKTkdtADVHCC0CabJlcRJS1vIDT
	 crvGc47yRdGX5rX/2cjRomh8ZpMQPXrJgOPMxJqgY0fNmT19S01I6YBAo+u060Kiv26S0
	 SqKXqCxq6inJzXwEMpZnr8NJUgN1LT6OgLL+UOQyT97tfcMV+S80c0locvWxYYbep+Pix
	 X+cYo/hDwds7ZslyhlLNbo6RDwmhoV7N6CnhZaJSmRmXNrIUZaJpVMPxDQ7b+ycBnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEQPqsz6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF96606A329;
	Fri,  6 Nov 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEQPqsz6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77C21F0089F;
	Fri,  6 Nov 2026 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997319;
	bh=t2PKG6ft0uQ0Jp0pnLvRhw5qbjOJj0JEcw/PXEMCoY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEQPqsz6k7rJc27U0CYanNJRkWGN32n4tBzQ1uN1mTwhUsEW8VcPBq3bOiGW7Ddwb
	 HJgeZr1W4lvLQ/720jV2SIsD6UBcNr9vf5x139yuPqkR1OOhSdU/eWl8sl1WJUHZJh
	 f+0+vvrP+6kmofWTfrp+L6btps3kB7qRnjNZS8qxN6/TEpIrAv8ivXwg6+PJjT6Z1Q
	 6UPNlGAaEG/6OBzO6yoKoESbGw3v2gzJ2Kec0FeEcxSlPSkmyUo7kt2PmhaLNzZ3OC
	 0gvUau7waMIIdERRwS95iU2BdALwVfO6k9ACEOEbuvqM14DMsDirTT/Brd8kBKh1c2
	 LtgCgiLJnMUTA==
Date: Fri, 6 Nov 2026 20:35:17 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 11/18] KVM: x86/pmu: Emulate
 IA32_PERF_GLOBAL_STATUS_SET MSR
Message-ID: <au44SIwBF52nsIkk@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-12-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-12-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:20PM -0700, Zide Chen wrote:
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
> Bit 63 (CondChgd) stays unreserved in pmu->global_status_rsvd to
> architecturally allow the guest to write this bit on STATUS_RESET (0x390)
> to clear it, and allow userspace to set it on GLOBAL_STATUS (0x38E).
> 
> However, bit 63 is architecturally reserved in STATUS_SET per the SDM.
> Reject writes to bit 63, injecting #GP for guest writes. While older
> processors had silicon errata that accepted writes without #GP (e.g.
> SKX95), strictly enforce the architectural specification for
> deterministic behavior across migrations.
> 
> Platform-specific EDS clarifies that CondChgd indicates a change to
> IA32_MISC_ENABLE[7], which KVM intercepts and keeps strictly read-only
> for guests. This guarantees hardware will never assert CondChgd during
> guest execution.
> 
> Thus, the architectural asymmetry among these three MSRs is safe; being
> unable to restore bit 63 to hardware via STATUS_SET is benign because
> the guest will never legitimately observe CondChgd. Filter it out
> defensively before writing to hardware in intel_mediated_pmu_load().
> 
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v3:
> - Split from combined v2 patch into standalone GLOBAL_STATUS_SET patch.
> - Always intercept IA32_PERF_GLOBAL_STATUS_SET to prevent passthrough of
>   unvirtualized status bits. (Jim)
> - Reject writing bit 63 (CondChgd) to IA32_PERF_GLOBAL_STATUS_SET. (Jim)
> - Filter out bit 63 before writing to hardware in intel_mediated_pmu_load().
> - Move validation for MSR_CORE_PERF_GLOBAL_STATUS_SET to pmu_intel.c rather
>   than common pmu.c to avoid exposing the Intel MSR on AMD.
> 
> v2:
> - Add the missing vmcs02 updates for these two MSRs.
> - Change "> 3" to ">= 4" to make the "v4-gated" more obvious and match
>   the existing code style.
> ---
>  arch/x86/kvm/pmu.c           | 13 +++++++++++++
>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 27d6a9169821..2cb5bccc7044 100644
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
> @@ -921,6 +922,18 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!msr_info->host_initiated)
>  			pmu->global_status &= ~data;
>  		break;
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		/*
> +		 * Bit 63 (CondChgd) is architecturally reserved in STATUS_SET.
> +		 * Older CPUs errantly accepted writes without #GP (e.g. SKX95),
> +		 * but KVM strictly enforces the architectural spec to ensure
> +		 * consistent behavior across migrations.
> +		 */
> +		if (data & (pmu->global_status_rsvd | GLOBAL_STATUS_COND_CHG))
> +			return 1;

Is it intentional to disallow userspace from writing
GLOBAL_STATUS_COND_CHG through MSR_CORE_PERF_GLOBAL_STATUS_SET, even tho
it's allowed through MSR_CORE_PERF_GLOBAL_STATUS?

> +		if (!msr_info->host_initiated)
> +			pmu->global_status |= data;
> +		break;
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  		if (!msr_info->host_initiated)
>  			pmu->global_status |= data & ~pmu->global_status_rsvd;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index ce668ea08da5..e81a3f8b9b02 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -197,6 +197,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		return pmu->version >= 4;
>  	case MSR_IA32_PEBS_ENABLE:
>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>  		break;
> @@ -827,8 +829,16 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>  	toggle = pmu->global_status ^ global_status;
>  	if (global_status & toggle)
>  		wrmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status & toggle);
> -	if (pmu->global_status & toggle)
> -		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
> +
> +	/*
> +	 * CondChgd is architecturally reserved in GLOBAL_STATUS_SET. Unless
> +	 * set by malicious userspace, this bit should never be set in
> +	 * pmu->global_status; filter it out defensively to protect against
> +	 * a host #GP.

IIUC, this will ignore bit 63 completely when written by userspace,
should KVM be doing this?

> +	 */
> +	if ((pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG)

Maybe store this in a variable as it's used in wrmsrq() as well?

> +		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET,
> +		       (pmu->global_status & toggle) & ~GLOBAL_STATUS_COND_CHG);
>  
>  	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
>  }
> -- 
> 2.56.0
> 

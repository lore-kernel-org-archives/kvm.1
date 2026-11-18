Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961702;
	b=RmIuxZEc059A02JJoyQHTcYp74h1QMHrHxfuK4K0p3aJSuMbNJYmy1UlDozyG3T88Dvn
	 QxX4I9H045NgzNYNyTYBKqz+L0t0HGJl9fwHdHCVrsrstC5xnAkvKOjE1mEF8Kaey10+F
	 6f4U0EHKwx0/gaiHTnem77shcvaNCD7vXiW4TqFzy+1vbFoTtkb4gLho/X9MDAgXtx0DM
	 MwSL4DdTgxKbwcxQlyhx2mYAunA3+Zotcc+nQdJ83qWPT9K3Ky0clR808apxdecybXWfu
	 xEd/CmW6VZC/cFSGYzQ9eeECeQLDGJrBlWvneTjpiOQFlsi2C01BAVBedSLV6gh4R8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961702;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uFBSiDjaodXEfe0pKUcpw/rrtkJmRQYfvMmGY6lnVd0=;
	b=vqJ36ghLIQgPBd9+NWD7z0TBtlCtpqZbMmaX4+FQE5k6i7KySUALqvCjRqGZIFanjLYh
	 /DqpEHjDg7hElN6TfjTYJMeGuhibQgAhSTRHIak6Z5dgF/bdMmx71baj680OdQFKQz1eZ
	 dYgExtR/noCeVnRLHKMwY6ExIvKoe5yCQXLI0L3OpeXqUBaqOaeIShEr/bA29JmdI3lIo
	 Qv5A2CYqw5aIAYJ7UlSUeUo0rwyuMj+CnleZUgNnArOnmvK0NjoCDUnQEOodLoPRPFvjL
	 P2/w1/yYKbzg+8qhWyV2i534jBU5+KrJoDl4lXIy3hfer3APxYs0x4TmX3KTG0KspPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzNDDXN6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D6606A31C;
	Wed, 18 Nov 2026 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzNDDXN6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A977B1F000C8;
	Wed, 18 Nov 2026 00:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961702;
	bh=uFBSiDjaodXEfe0pKUcpw/rrtkJmRQYfvMmGY6lnVd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzNDDXN6N0xWRrhpBnc+W3KTGvAFvr86p2oyCKvDRN48enAkKdr2LzLju+I8OI2Hw
	 GeJTD9Gs9ZyNw3m9Rs9RfNUkL+V6wS4RNOoyS0+lYhgIEYDulHiVIUustHhWL1WmE/
	 /XszZghXRwTXs+a8HuexXD3gWb1WbPVOCztP+CMxavyL8Jlq7ZaTba6EWmj69QY55J
	 QJmjszbtjPRXBuVJSu1u+nVbDNGno0mZ1nbqrRqteMcLm22B06tL2dFLD3n5INsLoP
	 ht9Zyde1kpNwHgaAdPUXO/Yiy6YsQgbkl72xjnyhwt/o+fbtZEdQwF6rlpb3+g7o4M
	 61jkRXv5qIsmg==
Date: Wed, 18 Nov 2026 00:28:20 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 01/21] KVM: SVM: Drop counter MSR checks in
 amd_is_valid_msr()
Message-ID: <avzw_akHKkLkb-iD@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-2-zide.chen@intel.com>
 <avis5Ose25IiYM2S@google.com>
 <553050b3-bcda-48e0-af03-754f0b697943@intel.com>
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
In-Reply-To: <553050b3-bcda-48e0-af03-754f0b697943@intel.com>

On Mon, Nov 16, 2026 at 01:02:49PM -0600, Chen, Zide wrote:
> 
> 
> On 11/14/2026 12:49 PM, Yosry Ahmed wrote:
> > On Thu, Nov 12, 2026 at 01:32:07PM -0700, Zide Chen wrote:
> >> amd_msr_idx_to_pmc() accurately validates individual counter MSRs by
> >> checking whether the corresponding counter is supported for the vCPU.
> >> Validating counter MSRs again in amd_is_valid_msr() is redundant.
> >>
> >> Furthermore, validating counter MSRs using broad checks like
> >> "pmu->version > 0" or "PERFCTR_CORE" is inaccurate and misleading. It
> >> falsely validates unexposed counters, which then fail in
> >> amd_pmu_{get,set}_msr(), injecting an errant #GP instead of taking
> >> KVM's fallback (read 0, write ignored) and breaking migration for
> >> unadvertised counters.
> >>
> >> Finally, the range check in the default case is dead code because AMD
> >> CPUs currently support at most 6 Core Perf counters. Even if future AMD
> >> CPUs support more than 6, counter MSRs would still be sufficiently
> >> validated by amd_msr_idx_to_pmc().
> >>
> >> Drop the counter cases and dead range check from amd_is_valid_msr(),
> >> leaving counter validation solely to amd_msr_idx_to_pmc().
> >>
> >> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> >> Reported-by: Jim Mattson <jmattson@google.com>
> >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> > 
> > Should we also drop the get_gp_pmc(.., MSR_IA32_PERFCTR0),
> > get_gp_pmc(.., MSR_P6_EVNTSEL0), and get_fixed_pmc() calls from the
> > default case in intel_is_valid_msr()?
> > 
> > They are also covered by intel_msr_idx_to_pmc() IIUC.
> It's a shame that I didn't take one step further to check the Intel code.

FWIW, for the patch itself:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

> 
> I completely agree that intel_is_valid_msr() should be simplified:

Looks good, I assume that would be a separate patch.

> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 4824e7eb98d3..77ce713101a4 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -229,10 +229,7 @@ static bool intel_is_valid_msr(struct kvm_vcpu
> *vcpu, u32 msr)
>                         ((perf_capabilities & PERF_CAP_PEBS_FORMAT) > 3);
>                 break;
>         default:
> -               ret = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0) ||
> -                       get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0) ||
> -                       get_fixed_pmc(pmu, msr) || get_fw_gp_pmc(pmu,
> msr) ||
> -                       intel_pmu_is_valid_lbr_msr(vcpu, msr);
> +               ret = intel_pmu_is_valid_lbr_msr(vcpu, msr);
>                 break;
>         }
> 
> Additionally, intel_msr_idx_to_pmc() currently misses get_fw_gp_pmc(),
> which leaves FW counter writes untracked in kvm_pmu_mark_pmc_in_use().
> Moving get_fw_gp_pmc() into intel_msr_idx_to_pmc() fixes that bug and
> allows dropping all counter checks from intel_is_valid_msr():
> 
> @@ -247,6 +244,7 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct
> kvm_vcpu *vcpu, u32 msr)
>         pmc = get_fixed_pmc(pmu, msr);
>         pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0);
>         pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0);
> +       pmc = pmc ? pmc : get_fw_gp_pmc(pmu, msr);
> 
>         return pmc;
>  }
> 
> This seems a little bit too complicated in intel_msr_idx_to_pmc(),
> especially once PMU v6 is introduced and more v6 specific MSRs are
> available. We may do some cleanup (not in this series though)

Yeah we can clean this up later.

> 
> - Fold get_fw_gp_pmc() into get_gp_pmc() and hide the base MSR from the
>   API signature to keep the callers clean.
> - Move these helpers from pmu.h to pmu_intel.c, since AMD already uses
>   its own helpers.
> 
> @@ -245,10 +294,9 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct
> kvm_vcpu *vcpu, u32 msr)
>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>         struct kvm_pmc *pmc;
> 
> -       pmc = get_fixed_pmc(pmu, msr);
> -       pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0);
> -       pmc = pmc ? pmc : get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0);
> -       pmc = pmc ? pmc : get_fw_gp_pmc(pmu, msr);
> +       pmc = intel_get_fixed_pmc(pmu, msr);
> +       pmc = pmc ? pmc : intel_get_gp_eventsel_pmc(pmu, msr);
> +       pmc = pmc ? pmc : intel_get_gp_counter_pmc(pmu, msr);
> 
>         return pmc;
>  }
> 
> @@ -419,18 +467,17 @@ static int intel_pmu_get_msr(struct kvm_vcpu
> *vcpu, struct msr_data *msr_info)
>                 msr_info->data = pmu->pebs_data_cfg;
>                 break;
>         default:
> -               if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
> -                   (pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> +               if ((pmc = intel_get_gp_counter_pmc(pmu, msr))) {
>                         u64 val = pmc_read_counter(pmc);
>                         msr_info->data =
>                                 val & pmu->counter_bitmask[KVM_PMC_GP];
> 

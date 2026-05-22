Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3333390600
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487633; cv=none; b=hAUYKjmt2hgAgXl6ca1QHY37S8mcnLeOYMrkGvg5Qw8NuDJhHsRXvrhi0RRJHO9rGLnvBGH4vsW6maqZs8bqYNNiBelxrzDACpAAECYRoTdIFiJJx2bAF3UPGCZW2QXGvlEL4G6OViI5CDHk/yDmHJRdpYlfgxulksaxlNIpZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487633; c=relaxed/simple;
	bh=weIOYOoYwUEJnGTRzvrq9QI273piyq5zOcDRq6wzLOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDokODK1stcP+Qta0XFtRdCFUsVbAsjfscYOZyAeJ9ll5ehf8OX7mzsvqm0B5iXCUUqPLHA8DhIesKLZKRY0EQxGHYtRGtqF98ztC4BepVAStpGmM6WN3qKyAXITT0P8GuWNLeADrtNQWxi93dnmCDnRYVfsZMQFDLIv+lQGOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hR81aWW4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hR81aWW4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8276c91addso4336285a12.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487631; x=1780092431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCdCZEjKvlZtlqOkeaWzkWlPEbrRaCif9riAKiYZuos=;
        b=hR81aWW4GjUqr3pbSVvtuVQMOSouPoZPRTxiEdkw7G8HPfnNiREVvMCMpN+HIEk9d1
         AwP8BQFRy5pxCouMBsC8BJfIWQiCFhrddbY1f+Jn2WWXySmOwNN/YSCP0rUQbEuwfnxV
         mN5vBRRm2fc+ffbGbWAy52wQk8/1n3kBLVprAoBGOGltATNBEM+45aMKwREvK7odCp/f
         qWSZTtyoojBufm8ETDJX+8fH90CEa/9ZyOAQO17ju/apRrC5c+XJIN11Zw/VdPLUNSeA
         xx93sto+SKWAn0dhzaRZ9L0BfAzpJHD2w33pd8+em8au7upKAXK2efAaBwXXwb2loE2z
         ctFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487631; x=1780092431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCdCZEjKvlZtlqOkeaWzkWlPEbrRaCif9riAKiYZuos=;
        b=hIbhnax0WWHnruphnJBisrTRCQdc/UFBZmn1n92JVSSjINDl//sUQVamQY0xcqGqbv
         KgiDDtfsyQi8puBzZ7AueLua03bu3iq/628R0/o9xHJQFXWn6grSqk9tcS/FaWiNYBrb
         9SXwdCtkzzKS7DnuHzY2TcD335LRZrIrGJvWlrLXMt1GanlZ9onCayEd/LT360i1NKTb
         8rK8RKbUuk9JVaoni/MPkV+k2f2ANm8SZsmsA2Fs3oR386yG/ETwWlxKoyz2QZGQe0BJ
         JLdYKSCMZnIxDmpL0NIbjNTaOt4Zn3/oy0uOEyeYQtnXxZ00c5SgZI6BAYLVuy4SzoDb
         R9PQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K1uvT6NmWCI0vFCVPlHYKdwwmtXvO+TRqPkyvsiz4+KD1q7J8Kte3MAP50tOhQo2asbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9K7Ea3J9nKJj/Q59EBxOhEfnLRi2b0mDMUWxZ1MPQn1iQ1nbY
	xk8/eyvD+lMPeDieQABANFaZRvK3NMNpB6byvjNHLzc6WX9/k5Qs9SOA9iWe+SYAmIs+XrTr4CV
	fV06+fA==
X-Received: from pgbcb21.prod.google.com ([2002:a05:6a02:715:b0:c80:22ee:7357])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9098:b0:3b2:b1f8:c745
 with SMTP id adf61e73a8af0-3b328d4cd6cmr6312238637.20.1779487630819; Fri, 22
 May 2026 15:07:10 -0700 (PDT)
Date: Fri, 22 May 2026 15:07:10 -0700
In-Reply-To: <20260313071033.4153209-4-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com> <20260313071033.4153209-4-chengkev@google.com>
Message-ID: <ahDTjhbEGe1HwwpG@google.com>
Subject: Re: [PATCH V3 3/4] KVM: VMX: Fix nested EPT violation injection of
 GVA_IS_VALID/GVA_TRANSLATED bits
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Kevin Cheng wrote:
> Make the OR of EPT_VIOLATION_GVA_IS_VALID and
> EPT_VIOLATION_GVA_TRANSLATED from the hardware exit qualification
> conditional on the fault originating from a hardware EPT violation
> exit. The hardware exit qualification reflects the original VM exit,
> which may not be an EPT violation at all, e.g. if KVM is emulating
> an I/O instruction and the memory operand's translation through L1's
> EPT fails. In that case, bits 7-8 of the exit qualification have
> completely different semantics (or are simply zero), and OR'ing them
> into the injected EPT violation corrupts the GVA_IS_VALID/
> GVA_TRANSLATED information.
> 
> Use the hardware_nested_page_fault flag introduced in the previous
> patch to distinguish hardware EPT violation exits from
> emulation-triggered faults. For hardware exits, take the
> GVA_IS_VALID/GVA_TRANSLATED bits from the hardware exit qualification.
> For emulation faults, take them from fault->exit_qualification, which
> is populated by the nested_mmu walker in paging_tmpl.h.
> 
> Replace the #if PTTYPE != PTTYPE_EPT preprocessor guards in
> paging_tmpl.h with a runtime kvm_nested_fault_is_ept() helper that
> checks guest_mmu to determine whether the nested fault is EPT vs NPT,
> and sets the appropriate field (exit_qualification for EPT, error_code
> for NPF) accordingly.

Same comments on the changelog.

> Signed-off-by: Kevin Cheng <chengkev@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c         | 10 ++++++++++
>  arch/x86/kvm/mmu/paging_tmpl.h | 22 +++++++++++++++-------
>  arch/x86/kvm/vmx/nested.c      |  9 +++++----
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3dce38ffee76..aabf4ac39c43 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5272,6 +5272,9 @@ static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
>  	return false;
>  }
>  
> +static bool kvm_nested_fault_is_ept(struct kvm_vcpu *vcpu,
> +				    struct x86_exception *exception);
> +
>  #define PTTYPE_EPT 18 /* arbitrary */
>  #define PTTYPE PTTYPE_EPT
>  #include "paging_tmpl.h"
> @@ -5285,6 +5288,13 @@ static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
>  #include "paging_tmpl.h"
>  #undef PTTYPE
>  
> +static bool kvm_nested_fault_is_ept(struct kvm_vcpu *vcpu,
> +				    struct x86_exception *exception)
> +{
> +	WARN_ON_ONCE(!exception->nested_page_fault);
> +	return vcpu->arch.guest_mmu.page_fault == ept_page_fault;

Happily, on top the MBEC+GMET support, this goes away.

> +}
> +
>  static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
>  				    u64 pa_bits_rsvd, int level, bool nx,
>  				    bool gbpages, bool pse, bool amd)
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index ea2b7569f8a4..15be93d735ab 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -386,9 +386,15 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  					     nested_access, &walker->fault);
>  
>  		if (unlikely(real_gpa == INVALID_GPA)) {
> -#if PTTYPE != PTTYPE_EPT
> -			walker->fault.error_code |= PFERR_GUEST_PAGE_MASK;
> -#endif
> +			/*
> +			 * Set EPT Violation flags even if the fault is an
> +			 * EPT Misconfig, fault.exit_qualification is ignored
> +			 * for EPT Misconfigs.
> +			 */
> +			if (kvm_nested_fault_is_ept(vcpu, &walker->fault))
> +				walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
> +			else
> +				walker->fault.error_code |= PFERR_GUEST_PAGE_MASK;
>  			return 0;
>  		}
>  
> @@ -447,9 +453,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  
>  	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
>  	if (real_gpa == INVALID_GPA) {
> -#if PTTYPE != PTTYPE_EPT
> -		walker->fault.error_code |= PFERR_GUEST_FINAL_MASK;
> -#endif
> +		if (kvm_nested_fault_is_ept(vcpu, &walker->fault))
> +			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID |
> +							    EPT_VIOLATION_GVA_TRANSLATED;
> +		else
> +			walker->fault.error_code |= PFERR_GUEST_FINAL_MASK;
>  		return 0;

And these become:

diff --git arch/x86/kvm/mmu/paging_tmpl.h arch/x86/kvm/mmu/paging_tmpl.h
index 5b2410ed7e45..b3a2f7b59797 100644
--- arch/x86/kvm/mmu/paging_tmpl.h
+++ arch/x86/kvm/mmu/paging_tmpl.h
@@ -502,7 +502,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
         * [2:0] - Derive from the access bits. The exit_qualification might be
         *         out of date if it is serving an EPT misconfiguration.
         * [5:3] - Calculated by the page walk of the guest EPT page tables
-        * [7:11] - Derived from [7:11] of real exit_qualification
+        * [7:8] - Dervived from "fault stage" access bits
+        * [9:11] - Derived from [9:11] of real exit_qualification
         *
         * The other bits are set to 0.
         */
@@ -516,6 +517,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
                else
                        walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
 
+               /*
+                * KVM doesn't emulate features that access GPAs directly, e.g.
+                * Intel Processor Trace.  Assume the GVA is always valid; when
+                * propagating faults from hardware, KVM will discard this info
+                * and use the EXIT_QUALIFICATION bits from the VMCS.
+                */
+               walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
+
                /*
                 * Accesses to guest paging structures are either "reads" or
                 * "read+write" accesses, so consider them the latter if write_fault
@@ -523,6 +532,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
                 */
                if (access & PFERR_GUEST_PAGE_MASK)
                        walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
+               else
+                       walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;
 
                /*
                 * Note, pte_access holds the raw RWX bits from the EPTE, not

>  	}
>  
> @@ -496,7 +504,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  	 * [2:0] - Derive from the access bits. The exit_qualification might be
>  	 *         out of date if it is serving an EPT misconfiguration.
>  	 * [5:3] - Calculated by the page walk of the guest EPT page tables
> -	 * [7:8] - Derived from [7:8] of real exit_qualification
> +	 * [7:8] - Set at the kvm_translate_gpa() call sites above
>  	 *
>  	 * The other bits are set to 0.
>  	 */
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 937aeb474af7..39f8504f5cf2 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -443,11 +443,12 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
>  			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
>  			exit_qualification = 0;
>  		} else {
> -			exit_qualification = fault->exit_qualification;
> -			exit_qualification |= vmx_get_exit_qual(vcpu) &
> -					      (EPT_VIOLATION_GVA_IS_VALID |
> -					       EPT_VIOLATION_GVA_TRANSLATED);
>  			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
> +			exit_qualification = fault->exit_qualification;
> +			if (fault->hardware_nested_page_fault)
> +				exit_qualification |= vmx_get_exit_qual(vcpu) &
> +						      (EPT_VIOLATION_GVA_IS_VALID |
> +						       EPT_VIOLATION_GVA_TRANSLATED);

Similar to the goof in NPT, effectively merging emulated and hardware information
is wrong.  On top of the MBEC+GMET changes:

			u64 mask = EPT_VIOLATION_GVA_IS_VALID |
				   EPT_VIOLATION_GVA_TRANSLATED;

			if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
				mask |= EPT_VIOLATION_GVA_USER |
					EPT_VIOLATION_GVA_WRITABLE |
					EPT_VIOLATION_GVA_NX;

			exit_qualification = fault->exit_qualification & ~mask;

			/*
			 * Use the EXIT_QUALIFICATION from the VMCS if and only
			 * if the hardware VM-Exit from L2 was an EPT Violation.
			 * If the fault is synthesized, then EXIT_QUALIFICATION
			 * is stale and/or holds entirely different data.  And
			 * conversely, KVM _must_ rely on EXIT_QUALIFICATION if
			 * the fault came from hardware, because KVM only sees
			 * and walks the faulting GPA.
			 */
			if (from_hardware)
				exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
			else
				exit_qualification |= fault->exit_qualification & mask;

			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F53AFB1F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961973; cv=none; b=YRcKiv1ARqGLHOOYL6nzkd+2EICZll7DmGtJiHKwVrF+UJoA/o+JOmAea99nT23H2RCrsQCnfZ4tOLdJLlAGRS5eT9KSQshJtYHY2Edy+dtqLexki8q3A9e//sCh34bPpQjHUgD/bYbm5ET21yMYfYByLfXzR2Y9jLl/zPmr9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961973; c=relaxed/simple;
	bh=R3pGkrNPTeHg8E9HeX+JUH5Kx59Y1n+O7Hz2fTZw7wU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CB4LLPHU1jb4cKyVIN2To+MRbgG6YkATTtcqchFJUDk81nb/JfQWScP55uNCggRcS6I3njSXND458GLHMdwgW1e5igIBBeBFAwJfWj66tov33rgdmxQSWmi4REHuredAvI/IveP6ZAN0f9OuAeS5gwuWKm3HyxeNozhuCD5XjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYoNtaJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYoNtaJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669351F000E9;
	Thu, 28 May 2026 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779961971;
	bh=x0yqGLlXjgZAIHTHHhlDpIEBMiXZ/x6k6zteUR4bLcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYoNtaJmOOBPc6MbpgBZk6ncDw3U/yTOcQarMNbgAe9MN+k2629KzUvQv3UPYD19r
	 /Og6ED3hAvLzQuV0YA5cO4zqr/ExWMD/mAO7vca/L55uVaY3NhCFW4wS1MZD5jCKB7
	 hldjiOHKqd9swLianR9gwWC+BpbKt3ZsJ/aMgyAdoTl5/MdKTeoRulfVDLvolEgiPH
	 KDPs06esssRtcaCys1lfQzE7117O7g996sfNo6v1MEEhj0J5e3soCFi4u71CSNESqT
	 TdA8VsihyA1CTDAPVr+qdW2cyMjHuTL7tSahV1BQwjFIJBEI47VjkO+7mPmMfmryIz
	 hjSeSnGeOoKHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/15] KVM: x86/tdp_mmu: Centrally propagate
 to-present/atomic zap updates to external PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yan Zhao" <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528081225.10348-1-yan.y.zhao@intel.com>
References: <20260528081225.10348-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 09:52:51 +0000
Message-Id: <20260528095251.669351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Mutually exclusive `else if` logic in `__handle_changed_spte()=
` prevents external page table updates for parent SPTEs, and incorrect orde=
ring creates a use-after-free hazard on error rollback.
- [High] Propagating deterministic errors from `set_external_spte()` causes=
 an infinite retry loop in callers of `tdp_mmu_set_spte_atomic()`.
--

commit e8401f58d2841529854a98f404633950aa40f76c
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to exte=
rnal PTEs

This commit moves the propagation of to-present changes and atomic zap
changes to external PTEs from __tdp_mmu_set_spte_atomic() to
__handle_changed_spte(), centralizing SPTE change handling.

Link: https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com [1]
Link: https://lore.kernel.org/kvm/aY_Dq3riRLUNFZfr@google.com [2]

> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c

[ ... ]

> @@ -578,29 +576,51 @@ static void handle_changed_spte(struct kvm *kvm, st=
ruct kvm_mmu_page *sp,

[ ... ]

>  	/*
>  	 * Recursively handle child PTs if the change removed a subtree from
>  	 * the paging structure.  Note the WARN on the PFN changing without the
>  	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
>  	 * pages are kernel allocations and should never be migrated.
> +	 *
> +	 * For the mirror page table, propagate changes to present or changes of
> +	 * leaf SPTEs to !present under shared mmu_lock to the external SPTE via
> +	 * set_external_spte() op.
>  	 */
>  	if (was_present && !was_leaf &&
> -	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
> +	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
>  		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
> +	} else if (is_mirror_sp(sp) && (is_present || shared)) {
> +		int r;
> +
> +		r =3D kvm_x86_call(set_external_spte)(kvm, gfn, old_spte, new_spte, le=
vel);
> +		if (r)
> +			return r;
> +	}

[Severity: Critical]
Does this mutually exclusive else if logic skip external page table updates
for parent SPTEs?=20

When replacing a non-leaf mirror SPTE with a leaf SPTE (such as during a
hugepage collapse) or performing a shared atomic zap on a non-leaf SPTE, the
first condition is met and handle_removed_pt() is called. Because of the
else if, the set_external_spte() call is skipped entirely, leaving the
hardware external page table desynchronized.

Additionally, if this is changed to an independent if block, could the order
of operations create a use-after-free on error rollback?

If handle_removed_pt() executes first, it irreversibly unlinks and schedules
child page tables for RCU freeing. If set_external_spte() then runs and
fails (e.g. TDX rejects it), __handle_changed_spte() returns an error. The
caller tdp_mmu_set_spte_atomic() will attempt to roll back by restoring the
parent SPTE to its old value. However, since the child page tables were
already freed, the restored SPTE would point to RCU-freed memory.

Should set_external_spte() be called before handle_removed_pt() to allow a
safe rollback?

> @@ -673,14 +668,51 @@ static inline int __must_check tdp_mmu_set_spte_ato=
mic(struct kvm *kvm,

[ ... ]

> +	ret =3D __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> +				    new_spte, iter->level, true);
> +	/*
> +	 * Unfreeze the mirror SPTE.  If updating the external SPTE failed,
> +	 * restore the old value so that the mirror SPTE isn't frozen in
> +	 * perpetuity, otherwise set the mirror SPTE to the new desired value.
> +	 */
> +	if (is_mirror_sptep(iter->sptep)) {
> +		if (ret)
> +			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
> +		else
> +			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
> +	} else {
> +		/*
> +		 * Bug the VM if handling the change failed, as failure is only
> +		 * allowed if KVM couldn't update the external SPTE.
> +		 */
> +		KVM_BUG_ON(ret, kvm);
> +	}
> +	return ret;
>  }

[Severity: High]
Will propagating deterministic error codes from set_external_spte() cause
infinite retry loops in callers of tdp_mmu_set_spte_atomic()?

Callers of tdp_mmu_set_spte_atomic() generally assume that any non-zero
return value is a transient cmpxchg race (which typically returns -EBUSY),
and they implement an unconditional retry pattern on failure.

If set_external_spte() rejects an operation and returns a deterministic
error like -EINVAL (e.g. rejecting an atomic zap as mentioned in the commit
message) or -ENOMEM, this error is propagated back. Because callers do not
check the specific error code before retrying, won't this result in a
kernel livelock where the caller infinitely loops attempting the same doomed
operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528080856.1014=
1-1-yan.y.zhao@intel.com?part=3D9

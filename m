Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95E4071CA
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721030; cv=none; b=pE41taew95cO7E6iMscPq4LEzxn/JFHvkdMWTa8uu+vEV5jRtBW63dtOrx014/Alzl57fHhCF4SmpvEWxkOm7hKSkRDFanHXPieO4s/frRfYMYRTiuEUlJ/4/FDUKytOjxLQ6fFgRWuOjWoUtsn2QvAfYtJ4Nd2gz2U0E1ZTwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721030; c=relaxed/simple;
	bh=MiViv+W337/PdW4LE9kxVBMCbKg7khgBw1rtJBaAj+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q8HzD9Z9hKohJNI0YyARjfah+AT/m9fBOQA0UVLGBXRFPorhW0H3/84E6k0eGMIa7E6G0jUVs2Cv0s1D1jyDa22a8LsalDdH4Ec81yLPeXytdJ8HddBpSFSkvZsnWf1XlhQi88YeIzKPRhfDDD8e/+xyBSafju1rjsHSifIgOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjVLEP8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjVLEP8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CE81F00893;
	Fri, 18 Sep 2026 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721028;
	bh=9pHj3GRphBoLNttdG5fj6aOsL07VLoc4zklW4pYwAsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjVLEP8suRj6BmhzkvvcccK1oaqQg74Ots4ukEAJiac0fK5GaYPVZe2pL5blM1qu8
	 9qP4lRMCNtXymfW9DNRv4XSSikwWZ/SIpTY1x0vOCdMPItkG+93WxY+cEepNTCbj3s
	 p3eteLq8xmRfkXkha79t5KYKbzKN67UKgYvRlB9BdvNVq/gDgSNyvCmUyGhv9R6Jem
	 z/sqfd+5cN7x2Tem47uC9N39ceOzhLUX21NoRcJI7vRx3a3DPSt5sNg372EgAOMXST
	 eYTcjJOZiRqefYlPWxKCHElGuQphWaORg5eNk4UNDHEfwW83/Ql9Zhv1IYfZkNjvgz
	 nLlHbPrSbNgUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/28] KVM: x86/mmu: Obsolete all roots if memattr
 contains gPTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-26-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-26-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:43:47 +0000
Message-Id: <20260918084347.E2CE81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kvm: mixed-attribute hugepage mapping via race when mmu_lock i=
s dropped
- [High] kvm: soft lockup in kvm_arch_post_set_memory_attributes() due to u=
nbounded loop
--

commit 33f579fe7310efff8ad87a283b4a1e970511e847
Author: Paolo Bonzini <pbonzini@redhat.com>
Subject: KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs

This commit introduces a mechanism to invalidate all MMU roots when applying
memory protection attributes against a GPTE page. It splits the fast zap
operation into a locked front-half and an unlocked back-half.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 097095f71d605..d658cfe31cd9b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -8320,9 +8321,40 @@ bool kvm_arch_post_set_memory_attributes(struct kv=
m *kvm,
>  				hugepage_set_mixed(slot, gfn, level);
>  		}
>  	}
> +
> +	/*
> +	 * There are special considerations when applying an memory protection
> +	 * attibute against a GPTE page. If set read-only, access/dirty bits
> +	 * within that page shouldn't be updated. If set non-accesible,
> +	 * accessing a virtual address that requires traversing that GPTE page
> +	 * should fault.
> +	 *
> +	 * On TDP enabled guests, the CPU faults on the GPTE address upon
> +	 * detecting such a situation.
> +	 *
> +	 * On non-TDP, upon detecting this situation, and based on the fact it
> +	 * should be a rare occasion, invalidate all the mmu roots.
> +	 */
> +	for (gfn_t gfn =3D range->start; gfn < range->end; gfn++) {

[Severity: High]
Could this loop cause a host soft lockup and RCU stalls?

If host userspace issues a KVM_SET_MEMORY_ATTRIBUTES ioctl with a massive
memory range, this loop will iterate over the entire guest-controlled GFN
range.

Because it executes hash table lookups via for_each_gfn_valid_sp_with_gptes=
()
while holding mmu_lock for write without any cond_resched(), could a
malicious guest or VMM orchestrate massive memslot updates to degrade host
availability?

> +		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
> +			__kvm_mmu_zap_all_fast_front_half(kvm);

[Severity: Critical]
Can this lead to memory isolation breakage by allowing mixed-attribute
hugepage mappings?

During kvm_vm_set_mem_attributes(), kvm_handle_gfn_range() is called with
post_set_range. When processing the first memslot, it triggers range->on_lo=
ck,
which maps to kvm_mmu_invalidate_end() and sets mmu_invalidate_in_progress
to 0.

When __kvm_mmu_zap_all_fast_front_half() is called here, it can drop and
reacquire mmu_lock via cond_resched_rwlock_write().

While the lock is dropped and mmu_invalidate_in_progress is 0, could a
concurrent page fault on a subsequent memslot proceed? If that memslot's
disallow_lpage flag hasn't been updated yet, KVM might map a hugepage using
the specific faulted GFN's attributes, bypassing the mixed attributes in the
xarray entirely.

> +			return false;
> +		}
> +	}
>  	return false;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D25

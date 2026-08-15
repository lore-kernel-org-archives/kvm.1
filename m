Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264481ACD
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786789319; cv=none; b=TC4jyeajDKn+CMaco5jO7FShswP9Oba8GlG5UfnPXsiLxx3BvU1NmL0Pf+3o6/QFG2JPEYOOuEt9TopK60vEqgRi4BIGN55S6lk5PqqFRgK7q4bxvXt0a3nM0xDpSeIvTYJnFdCF5vW05MH6jpmmL2DdmkctWDsgk6sKBgaNwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786789319; c=relaxed/simple;
	bh=Ph2sdaVMPZtQcUsVYtJ0jvFeyJM6OyeUqo1uD6jvxxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqpXPvC4W4VSKGRcHbxcu1K2OclIQbr5Z+tAb4agp5p3NO7iPJcgr8/psCZr8XrrP4zC+8776xE+x/UOSpO9tA1fhV44mqTz+v7tQgVpxsDpVFNMAV3s4SfYvcFqvhCwk+hBNC7xgEHKNAnQPYDg1NeeDq4KJFwAas4GvAvrv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDhaipjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDhaipjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C494D1F000E9;
	Sat, 15 Aug 2026 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786789317;
	bh=Rrfr18mCI8cDFfKCq8KqkQuAWXX9ihkjCtdizmfzYuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDhaipjUOKEXPzzZWk4im/tEIEcU2+YukcEnR45aXrSC5p2sSMeAd26SyeA71aab9
	 nA894QJm+x+dsY1OZS/1sSmZrG6jFHi82O1/lMGpd2rOHSnhZ5MErB+odcp2T1Q72N
	 anl/X+yWaVrvYadbirK34xYW166BkEsp7sC5jGTf3Ae02m8G4ltp5MRUftaJk0MdRG
	 3UkqE52HW7h4UJQtXqjJg40PjWwBM3frZcHks+W1zrlnoWL/U34xH27G0pkvJ91FLn
	 EnF9MwMDi5FCkGBe9a59Jq6bGSS4vkDRDbrO8GZbe4HLffIDG8+MPaRSe6Dfz6+gx1
	 oZOLQqe2f4rOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260815100636.861901-1-jinyu.tang@linux.dev>
References: <20260815095548.860018-1-jinyu.tang@linux.dev>
 <20260815100636.861901-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 10:21:57 +0000
Message-Id: <20260815102157.C494D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Returning `-EFAULT` on `KVM_PFN_ERR_HWPOISON` in `kvm_riscv_mmu_ma=
p` breaks `KVM_RUN` execution and normal KVM signal delivery.
- [High] Incorrect map advancement calculation in `kvm_arch_vcpu_pre_fault_=
memory` causes skipped pages and false completion for unaligned and split h=
uge pages.
--

--- Patch [3]: [PATCH v4 3/5] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY ---
commit d1fe5f152fd69a51f4bc7397e89186eff774f433
Author: Jinyu Tang <jinyu.tang@linux.dev>
Subject: KVM: riscv: Implement KVM_PRE_FAULT_MEMORY

The patch implements the KVM_PRE_FAULT_MEMORY ioctl for RISC-V by adding the
kvm_arch_vcpu_pre_fault_memory() hook. It reuses the existing G-stage fault
mapping path to populate KVM page tables.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 54d45addf18f9..dff315dfd24ed 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -286,6 +286,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gsta=
ge,
>  						    out_map->level, true);
>  		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) =
=3D=3D hpa) {
>  			kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa, ptep, prot);
> +			out_map->addr =3D ALIGN_DOWN(gpa, page_size);
> +			out_map->level =3D ptep_level;
> +			out_map->pte =3D ptep_get(ptep);
>  			return 0;
>  		}
>  	}

[ ... ]

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 2fabcd4099919..f6ca86da53eb8 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -717,7 +717,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>  	if (hfn =3D=3D KVM_PFN_ERR_HWPOISON) {
>  		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
>  				vma_pageshift, current);
> -		return 0;
> +		return -EFAULT;

[Severity: High]
Does returning -EFAULT here break KVM's standard exit-to-userspace flow on a
signal?

If a guest accesses a poisoned memory page, returning 0 allows KVM to bubble
up 1 to kvm_arch_vcpu_ioctl_run(), which checks signal_pending() (set by
send_sig_mceerr) and correctly exits to userspace with -EINTR.

Returning -EFAULT causes the KVM_RUN ioctl to immediately fail with -EFAULT,
which can cause the VMM to crash instead of gracefully handling the Machine
Check Exception.

[ ... ]

> @@ -782,6 +782,49 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
[ ... ]
> +	for (;;) {
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
> +			return -EIO;
> +
> +		cond_resched();
> +		ret =3D kvm_riscv_mmu_map(vcpu, memslot, range->gpa, hva, false, &out_=
map);
> +		if (ret)
> +			return ret;
> +
> +		if (!pte_val(out_map.pte))
> +			continue;
> +
> +		map_size =3D PAGE_SIZE << (out_map.level * kvm_riscv_gstage_index_bits=
);
> +		end =3D out_map.addr + map_size;
> +		break;
> +	}
> +
> +	return min_t(u64, range->size, end - range->gpa);
> +}

[Severity: High]
Can end - range->gpa underflow here when handling unaligned offsets or split
huge pages?

In kvm_riscv_gstage_map_page() above, out_map.addr is aligned to the
requested huge page size rather than the actual leaf size installed.=20

If out_map.level is set to the 4K leaf level, but out_map.addr is aligned to
the huge page size, and range->gpa is beyond the first 4K of that huge page,
end will be calculated as less than range->gpa.

This would cause end - range->gpa to underflow into a large u64, making
min_t() evaluate to range->size and prematurely terminating the ioctl while
skipping regions of guest physical address space.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815095548.8600=
18-1-jinyu.tang@linux.dev?part=3D3

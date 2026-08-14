Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F65339399
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709086; cv=none; b=XtKg/wt/iwKBBtX3hIobtMcBVVYWykCggAMcyRPMOHs3Za6UYc4pjvKs361SO2v0aI52hNXJbZs13ZLxZplCp9HMem0KFEdEY2Uru32FEzxyNQq6jY44sk32/3fD/DarixTTPDa/vNvlRzVMd3qImDqTzxpUDk+PBGUHh/9YWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709086; c=relaxed/simple;
	bh=VerDLJfCU78lktImv4eb3uegv6JdMKTI46vNwYmI5c8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P7ra4vOuu6AKubIAhPvHx/sIj79Yydy+TBPXsTvLq8cjCCe1oTIjugscMz7CgBrR4yAXg6mZ0IuscGCSeOSRo60q95UyAIcOwm+CSulu5Kb/ytgn+XubHCERpfFbueefZBu0eVE7wJjx09sxtiOtH2LLAxk9B/0xGJ1Dccxh3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLJSre87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLJSre87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3324C1F00A3A;
	Fri, 14 Aug 2026 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786709085;
	bh=BVqwMgFc5QR2OxC5NYKUReIxVJb42kIU9Y5Tm0SUteM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLJSre87pe7/CjCc4FZatUzhajUi6kNX4OVfs3tNvcQINUM0vW2BKoin7yBdKNkEK
	 W3yackfzuX1PxaNGte3q2Gkmu6S8QEjInVVMWJnkEtToJ+5VPqEL2fA3az0UsC68aM
	 qZysgdyp1swysBvoGLqlMfl9I5cpGyhZ97pPOpmCAepro6DYo/WaiDSWn9GKrebm4Q
	 W7htLSXLzc6cjR5pnz6bvFS1LsBJF6zZpJtDKiU0b9Mib/oZ77OGNtAiP9+urkFAFh
	 Y1wb8fWeAqLKT1OdRqTGg8ryM8921OEniwtik99kpqB2hE7DsBxJrANJ6x7j0k5fYb
	 VKAeVnjvQomyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814114507.583424-2-jinyu.tang@linux.dev>
References: <20260814114507.583424-1-jinyu.tang@linux.dev>
 <20260814114507.583424-2-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:04:44 +0000
Message-Id: <20260814120445.3324C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The KVM_PRE_FAULT_MEMORY ioctl handler loops infinitely in the ker=
nel if it encounters a HWPOISON page and the userspace thread has blocked S=
IGBUS.
- [Medium] kvm_arch_vcpu_pre_fault_memory() can silently skip requested pag=
es and report false progress when mapping a split THP page.

Pre-existing issues:
- [High] Infinite VMExit page fault loop when a guest accesses an unaligned=
 THP address on a split page table.
- [High] Physical page table leak when overwriting a lower-level page table=
 directory with a huge page leaf PTE.
--

--- Patch [1]: [PATCH v3 1/3] KVM: riscv: Implement KVM_PRE_FAULT_MEMORY ---
commit ac8ca417e02ba68eb7b7c58fbc637ee417dc2c72
Author: Jinyu Tang <jinyu.tang@linux.dev>

KVM: riscv: Implement KVM_PRE_FAULT_MEMORY

This commit introduces the KVM_PRE_FAULT_MEMORY ioctl handler for RISC-V.
It reuses the existing G-stage fault mapping path with a read access to
populate KVM page tables before running a vCPU, looping until a mapping
is installed or an exit condition is met.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b0474fcf065aa..ebd1e8a4b9e38 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -280,6 +280,9 @@ int kvm_riscv_gstage_map_page(...)
>  		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) =
=3D=3D hpa) {
>  			kvm_riscv_gstage_update_pte_prot(gstage, ptep_level, gpa, ptep, prot);
> +			out_map->addr =3D ALIGN_DOWN(gpa, page_size);
> +			out_map->level =3D ptep_level;
> +			out_map->pte =3D ptep_get(ptep);
>  			return 0;
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this lead to an
infinite VMExit loop when a guest accesses an unaligned THP address on
a split page table?

During fault handling, transparent_hugepage_adjust() in kvm_riscv_mmu_map()
can silently overwrite the original faulting gpa with the 2MB-aligned
base address.

If the G-stage page table is currently split into 4KB PTEs, this block in
kvm_riscv_gstage_map_page() intentionally updates only the 4KB PTE at the
newly aligned gpa. The originally faulting 4KB page remains unmapped,
causing the guest to immediately fault again upon resumption.

[ ... ]

>  	out_map->pte =3D pfn_pte(PFN_DOWN(hpa), prot);
>  	out_map->pte =3D pte_mkdirty(out_map->pte);
> =20
>  	return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
>  }

[Severity: High]
This is a pre-existing issue, but does this leak physical page tables when
overwriting a lower-level page table directory with a huge page leaf PTE?

If 4KB leaf PTEs inside a THP-backed region are zapped (for example, via
MADV_DONTNEED) but the page directory remains, a subsequent fault triggers
a THP mapping. kvm_riscv_gstage_get_leaf() fails to find a leaf.

The code then falls through here to kvm_riscv_gstage_set_pte(), which blind=
ly
overwrites the existing directory entry with a huge page leaf PTE. Because
freeing page tables is not yet supported, the orphaned child page tables
appear to be leaked.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 8a0aa5e0e216e..c71c1ebb07857 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

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
> +		if (pte_val(out_map.pte))
> +			break;
> +	}

[Severity: High]
Can this loop spin infinitely if the userspace thread blocks SIGBUS and
KVM encounters a hardware-poisoned page?

Looking at kvm_riscv_mmu_map(), it handles HWPOISON by calling
send_sig_mceerr() and returning 0 without populating out_map.

If the userspace thread has SIGBUS blocked, send_sig_mceerr() queues the
signal but might not set TIF_SIGPENDING. In that scenario, signal_pending()
won't catch the pending signal, out_map.pte remains empty, and the loop
will retry infinitely without yielding back to userspace.

> +
> +	map_size =3D PAGE_SIZE << (out_map.level * kvm_riscv_gstage_index_bits);
> +	end =3D ALIGN_DOWN(range->gpa, map_size) + map_size;
> +
> +	return min_t(u64, range->size, end - range->gpa);
> +}

[Severity: Medium]
Does this miscalculate the mapped progress when handling a split THP page?

If transparent_hugepage_adjust() aligns the gpa down to the 2MB base and
kvm_riscv_gstage_map_page() falls back to a 4KB mapping, the 4KB PTE is
populated at the base address. out_map.addr is correctly set to this base.

However, the progress here is calculated using the original unaligned
range->gpa instead of out_map.addr. If the requested GPA was at an offset,
KVM might falsely report progress for the unmapped requested page while
actually mapping the unrequested base page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814114507.5834=
24-1-jinyu.tang@linux.dev?part=3D1

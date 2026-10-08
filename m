Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D52208D0
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791420355; cv=none; b=T9WAj5Ttlq/kNJVksIo4YJBhI1iL0Uz5nZ0HZJ5B+FR6nMOGCvMKBJ8+CJfW/0nLbeV+/M5tvzLlSKEuq+ahZZqSx1dRKwJqzqeDofd8pPW2er9PRRDEmfkOGq3H5/yr9YbVH2ucM+pZ1Cnv5o44ATW8+EnQ1HLl7AtZ3ZaceNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791420355; c=relaxed/simple;
	bh=nvlQjgrG8JdSCMILVngzrSYyovqBmup0Xajc8kgqvGM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=O9dkwzpHDRdjDXMCY5QvAVnLViEMYQq5QSYRR2ZnxhY7CBw7T8S+god6G1hnYGSm6YvxLTSRtoSb3GyiQZa6Re8lDHrvrU8eabeBy+bxm80HB27o3pKBhKse/S71wnosuZUYE4KeNu1WgBj1Sfe+yoac/+tp7yuL7d7pIH16VP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwCZAlUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwCZAlUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917861F000FF;
	Thu,  8 Oct 2026 00:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791420353;
	bh=WkAcwK7KbPAqEzcWmMDaTj1H5XjCYkJPO8uasvakMjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwCZAlUXzvHta6nJr5RoPRiSwzLlAcIVNkv0MLs28Wzf7tdXIv/38V3E50HkGTPPk
	 5l7/WiNz2PC4KwJfxVt8245k4KqaJ5b70rLI2kHIVneZBT3oc4FiK/TXi/Ocnld1z5
	 SYRRv3y9nE8MLvVUQzycZQS2TbNpNIeP5cINwgVjNzgdn0d6Jb9NypKcW1LjXK1nL5
	 lfEvuFA/jWkAnzO2KsEE8m4bHEkm8KHbwVQWurPPLMbBc8Uuz324cwR1ndvr4RnwUH
	 yGRyAm5mszeA30Y8y4lp//6yYfWIx5L0C9EtQgUn9oDWBZr/PiM8iItI82ho3cmteb
	 SnSp0Cxa4rWQg==
Message-ID: <sashiko-outbox-163479@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/29] KVM: nSVM: Flush L2's ASID when emulating
 INVLPGA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-27-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-27-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:45:53 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: host BUG_ON in shadow_walk_init_using_root on nested INVLPGA
--

commit 37c7f867aa6cefc5df5eab301ccc6b7b444c6816
Author: Yosry Ahmed <yosry@kernel.org>
Subject: KVM: nSVM: Flush L2's ASID when emulating INVLPGA

This commit handles INVLPGA differently depending on whether L1 is flushing
its own ASID or a different L2 ASID. If it's a different ASID, the GVA flus=
h is
skipped for the current context, and the L2 ASID is flushed in hardware or
via VMCB fallback.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f37cba4f34c2b..4b95a05c37f60 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2468,17 +2468,51 @@ static int clgi_interception(struct kvm_vcpu *vcp=
u)
> =20
[ ... ]
>  static int invlpga_interception(struct kvm_vcpu *vcpu)
>  {
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	/* FIXME: Handle an address size prefix. */
>  	gva_t gva =3D kvm_rax_read(vcpu);
>  	u32 asid =3D kvm_ecx_read(vcpu);
> +	int cpu;
> =20
>  	if (nested_svm_check_permissions(vcpu))
>  		return 1;
> =20
>  	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
> =20
> -	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
> -	kvm_mmu_invlpg(vcpu, gva);
> +	/*
> +	 * INVLPG on a non-canonical address is a NOP according to the SDM,
> +	 * assume the same behavior from INVLPGA since the APM doesn't specify.
> +	 */
> +	if (is_noncanonical_invlpg_address(gva, vcpu))
> +		return kvm_skip_emulated_instruction(vcpu);
> +
> +	/*
> +	 * Do nothing if L1 is flushing a different L2 ASID than the one KVM is
> +	 * currently tracking.  KVM tracks a single L2 ASID, and performs a TLB
> +	 * flush (and MMU resync if needed) when L1 switches ASIDs anyway.
> +	 */
> +	if (asid && asid !=3D svm->nested.last_asid)
> +		return kvm_skip_emulated_instruction(vcpu);
> +
> +	/*
> +	 * Handle INVLPGA similar to INVLPG, with one caveat. If the specified
> +	 * ASID is non-zero (i.e. L1 is not flushing its own ASID), skip
> +	 * flushing the TLB for the current context (L1's), and use INVLPGA to
> +	 * flush L2's ASID in hardware if running on the same CPU (otherwise
> +	 * fallback to a full ASID flush).
> +	 *
> +	 * Note, if NPT is disabled, this will sync all the shadow page tables.
> +	 * This can be optimized by keying off guest_mode.
> +	 */
> +	__kvm_mmu_invlpg(vcpu, gva, !asid);

[Severity: High]
Does this code trigger a host kernel panic when a 64-bit L1 guest switches =
to
a 32-bit PAE L2 guest?

When KVM uses shadow paging (e.g. nested NPT disabled), L1 and L2 share the
same MMU context (vcpu->arch.root_mmu).  If a 64-bit L1 guest switches to a
32-bit PAE L2 guest, KVM's fast_pgd_switch() will cache the old 64-bit root=
 in
vcpu->arch.mmu->prev_roots.

If L2 then executes INVLPGA, or L1 intercepts it and KVM emulates it, we ca=
ll
into __kvm_mmu_invlpg():

arch/x86/kvm/mmu/mmu.c:__kvm_mmu_invlpg() {
    ...
	__kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.gva_walk, gva,
				  KVM_MMU_ROOTS_ALL, flush_gva);
}

Which blindly iterates over all prev_roots:

arch/x86/kvm/mmu/mmu.c:__kvm_mmu_invalidate_addr() {
    ...
	for (i =3D 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
		if (roots & KVM_MMU_ROOT_PREVIOUS(i))
			kvm_mmu_sync_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
	}
}

kvm_mmu_sync_addr() then calls shadow_walk_init_using_root() via
for_each_shadow_entry_using_root().  Because the active MMU role is PAE,
iterator->level evaluates to PT32E_ROOT_LEVEL (3), which hits a hardcoded
assertion:

arch/x86/kvm/mmu/mmu.c:shadow_walk_init_using_root() {
    ...
	if (iterator->level =3D=3D PT32E_ROOT_LEVEL) {
		/*
		 * prev_root is currently only used for 64-bit hosts. So only
		 * the active root_hpa is valid here.
		 */
		BUG_ON(root !=3D vcpu->arch.mmu->root.hpa);
    ...
}

Because the 64-bit root from prev_roots does not match the currently active=
 PAE
root, it appears this will panic the host, resulting in a Denial of Service
directly triggerable by a nested guest.

> +	if (asid) {
> +		cpu =3D get_cpu();
> +		if (cpu =3D=3D svm->nested.vmcb02.cpu)
> +			invlpga(gva, svm->nested.asid02);
> +		else
> +			vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
> +		put_cpu();
> +	}
> =20
>  	return kvm_skip_emulated_instruction(vcpu);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D26

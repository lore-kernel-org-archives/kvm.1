Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3137F742
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483729; cv=none; b=V7aE5CDDL5FXYh+PP9ushfuTm9z0oGlsGto9oGUFGjxN79ltF6BVcNgYZkoXJWJDpzXeSDSyIByhmI3hvYF2bqEIrE80cai3F+O3g8epe8MrPFPQvV9ZS3wPDXwJ+kZFgMd/QFKyqQ4dNTSJB3uekqKotIwIGvzQEswGEToHMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483729; c=relaxed/simple;
	bh=+Qg4k8GM9Lu7IaND2YmULX+MFzX5vEUMcIqK/Xyk7mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V3rzmfSHrsH6QQbhz4UtdPP3ntLF/psG6/AdzpfNhamJJVYGBlC/LgSkRQOrfJTj71Cn5FkXFIYeSf8oClnISnVJhJZx6TcEqcVlkEgjKkNXHpY8k4QS5NRugDbhbgyq9bl1LQqnIxnlzMVY5ZmCgajRcAAhKFWC3eZt9NfciUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiDPWuHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiDPWuHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9692C1F00893;
	Wed,  3 Jun 2026 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780483728;
	bh=cqzKjdKWU4+9rgSwOWAGR2yb+OiHxdU8gBEluKnuiT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NiDPWuHS9lU+QyWd2nBu540lIiWjPYgzHp+OCzV+opxjRAjqIGiouSpoMW3/7Oyjt
	 SemAe4lBzRCGD27VVPyLGLW2HH1AWNzuttU88Dtc74jBBVwLZ630cyHe2yBfjbfLYE
	 uOePGwNEuy79GCJEOUFlwZiv2Elm9YwLZsdQnrDooMdphqIk76Sw/4Wf0x1BqcPL+U
	 6GyhFzDlKc3b8b9XfmUHxejDNcOLzqIvp/1h4xf/QUTsixTVywfNWFGngU8u/nBSuL
	 TZJrtV0hPMYbhLTrTdRPK5W1MqNbgfGgEIzHC6zKMEHI1/oaoH8vQEl0zjdKRUqtwU
	 og8Q+RPRUfs3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] RISC-V: KVM: Split huge pages during
 KVM_CLEAR_DIRTY_LOG
Reply-To: sashiko-reviews@lists.linux.dev
To: wang.yechao255@zte.com.cn
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603175829412hzKDF23RSPIQCliiSiIwg@zte.com.cn>
References: <20260603175829412hzKDF23RSPIQCliiSiIwg@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 10:48:47 +0000
Message-Id: <20260603104847.9692C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Caching `gstage.pgd` across `mmu_lock` drops in `mmu_split_hug=
e_pages` leads to a Use-After-Free if the page table is concurrently destro=
yed.
- [High] Eager huge page splitting skips PMDs when the address range is una=
ligned, leaving huge pages unsplit.

Pre-existing issues:
- [Critical] Non-atomic SPTE updates in `kvm_riscv_gstage_op_pte` clobber c=
oncurrent hardware Access/Dirty bit updates.
--

commit 80c4b9b5e74f99371bb99acaee95451275e9865f
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG

This commit splits huge pages on the range specified using
KVM_CLEAR_DIRTY_LOG. It also ensures that splitting does not occur when
enabling dirty logging if KVM_DIRTY_LOG_INITIALLY_SET is set.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 51bd1db74e1aa..d04680687f4a1 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -149,6 +149,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>  	kvm_riscv_gstage_init(&gstage, kvm);
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);

[Severity: Critical]
This is a pre-existing issue, but does kvm_riscv_gstage_wp_range()
non-atomically update PTEs, risking lost hardware A/D bit updates?

When kvm_riscv_gstage_wp_range() calls kvm_riscv_gstage_op_pte(), the
write-protection is done with a read-modify-write:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_op_pte() {
    ...
    else if (op =3D=3D GSTAGE_OP_WP)
        set_pte(ptep, __pte(pte_val(ptep_get(ptep)) & ~_PAGE_WRITE));
    ...
}

If the hardware page-table walker sets the Dirty (D) bit after KVM reads the
PTE but before KVM writes it back, will the hardware's update be lost? This
could lead to silent data corruption during live migration since KVM might
miss guest memory writes.

> +
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +		mmu_split_huge_pages(&gstage, start, end, true);

[Severity: Critical]
When calling mmu_split_huge_pages(), is it possible to encounter a
use-after-free if the page table is concurrently destroyed?

In mmu_split_huge_pages(), kvm->mmu_lock can be dropped:

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
		if (need_topup_split_caches_or_resched(pcache, count)) {
			spin_unlock(&kvm->mmu_lock);
			cond_resched();
			...
			spin_lock(&kvm->mmu_lock);
		}

		ret =3D kvm_riscv_gstage_split_huge(gstage, pcache, addr, 0, flush);
    ...
}

While the lock is dropped, what happens if a concurrent
kvm_mmu_notifier_release() acquires mmu_lock and frees the PGD pages? When
mmu_split_huge_pages() reacquires the lock, it continues using the cached
gstage->pgd pointer to access the now-freed page table memory. Should the
KVM PGD be re-validated after re-acquiring the lock?

[Severity: High]
Does this code skip splitting PMDs when the address range is unaligned?

Looking at the loop inside mmu_split_huge_pages():

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
	phys_addr_t addr =3D start;
    ...
	while (addr < end) {
        ...
		addr +=3D PMD_SIZE;
	}
}

If the starting address is not aligned to PMD_SIZE, addr retains this
unaligned offset. If the range [start, end) spans across a PMD_SIZE
boundary, adding PMD_SIZE to the unaligned addr could make it strictly
greater than or equal to end prematurely. Will this cause the loop to
terminate early and leave the last huge page unsplit?

>  }
> =20
>  void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *me=
mslot)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603175256408L0=
jnqGs1cJGc0ijCdujci@zte.com.cn?part=3D3

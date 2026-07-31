Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81838D011
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490694; cv=none; b=AD5V1fhpQrON00JhCnA0F+1+lQW3c9K0Od3MdWY2xB5a/eJZNr1mMaedwHwsVu8TLCW8EkgqtUNGjMrWqcEtsKRfb3lhf4mV2xdWUXGVo3mu79SOZSJ3T1Qcg1ZPnNZwvCEvB1KQElFzWBZnAVUFixgaEj6PurBaxf9Cm/etLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490694; c=relaxed/simple;
	bh=3EFw8k8pDZYQa2zack7N3o9bJ9LwAaSgr+B00Q853fc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u5wXFM+zzvyYCogphIfGjxE6SjZ4+HdXKab+sF0C00esOgvhHADxzjNW0Hvd7FWejglw4Nc5dC5uWfLQdmkpvTPVrUyBALeuIa5M/dSj4pN5e1tjIf4fZoHaUBXvB1KHxYrVaEDr9eECuh3BjC+sK3g/M6sMHPoLyqSinwQC2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7tVMbsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7tVMbsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3911F000E9;
	Fri, 31 Jul 2026 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490692;
	bh=ZQqa+mob1LmYAjB+4ZpVYk7MB1YlHM9nyQ6jyzIHLPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7tVMbskIayufK2GvS8xw/l7sWlnQsV5GidgfNMdJu7azxkoojTDzp4URTf4CtARz
	 9otLXp7MnAyaUePrtpgDEXoJzRoDyX5k/elVAEztGcWy4SgRYwyPCYMludPiFsZ5He
	 HUeOplcdvoxzb1x/8KooDLqQR3UcfwfjI1ivhupDIYBrVEqyVsy7boVuA99wgtn4zd
	 6ugyBQpvreGFzZUXuQ+g9LnAjRBlSkbSmmjuQL8XSnAXTluEEO2h/rCoxOfJZboUEi
	 A+l2KerxwdhbcaamV9cRIsJew6NeKMDPJBWG00FzQfaZ9XMKzCynwaif+DeFZh6aQS
	 sVTKIDAgQRgpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] RISC-V: KVM: Split huge pages during
 KVM_CLEAR_DIRTY_LOG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731091215.1549430-5-wang.yechao255@zte.com.cn>
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
 <20260731091215.1549430-5-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:38:12 +0000
Message-Id: <20260731093812.9B3911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dropping `mmu_lock` inside `mmu_split_huge_pages` before flushing =
the TLB for write-protected pages breaks caller atomicity and allows untrac=
ked guest writes.
- [Medium] Splitting huge pages after write-protecting them causes all resu=
lting 4KB pages to inherit read-only permissions, unintentionally write-pro=
tecting memory outside the requested mask.
--

--- Patch [4]: [PATCH v5 4/5] RISC-V: KVM: Split huge pages during KVM_CLEA=
R_DIRTY_LOG ---
commit 7f655ea60f5c58e768006af9329d81bc92d97d34
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG

Split huge pages on the range specified using KVM_CLEAR_DIRTY_LOG.
And do not split when enabling dirty logging if KVM_DIRTY_LOG_INITIALLY_SET
is set.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 5a93cffa9ad7f..722637a85bdf9 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -168,6 +168,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);
> =20
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +		mmu_split_huge_pages(&gstage, start, end);

[Severity: Medium]
Since mmu_split_huge_pages() is called after kvm_riscv_gstage_wp_range(),
won't the newly split 4KB child PTEs inherit the read-only permission from
the huge PTE?

If KVM_CLEAR_DIRTY_LOG targets only a subset of pages in a 2MB huge page,
this would unintentionally write-protect memory outside the requested mask
and cause spurious page faults.

Could this be resolved by performing the split before write-protecting?

[Severity: High]
Does dropping the mmu_lock inside mmu_split_huge_pages() before the TLB is
flushed break caller atomicity and allow untracked guest writes?

Looking at arch/riscv/kvm/mmu.c:mmu_split_huge_pages():

	while (addr < end) {
		if (need_topup_split_caches_or_resched(kvm, count)) {
			...
			write_unlock(&kvm->mmu_lock);
			cond_resched();

If kvm_riscv_gstage_wp_range() write-protects the PTE, and then
mmu_split_huge_pages() drops kvm->mmu_lock, the hardware TLB is still
writable because the caller hasn't flushed the TLB yet.

Can concurrent guest writes succeed without a VM-exit during this window,
bypassing the cleared software dirty bitmap and violating the dirty logging
contract?

> +
>  	/*
>  	 * remote TLB flush is not needed here since callers of
>  	 * kvm_arch_mmu_enable_log_dirty_pt_masked() already do it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731091215.1549=
430-1-wang.yechao255@zte.com.cn?part=3D4

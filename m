Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C34B8DFD
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909148; cv=none; b=CA6f5c68F6LmSEU1JoIRv2x1szXlEE7rg0i9nFIQYKkIXuKj/ZDwTtOj+s5xAKDY2RayMzsUpQSAyBXtaEQo7wMUA/zWwnnd5foVaQ+3i1H3Ig77KErB7BuG81MiXeN4bCHdqkj5QO3BokRvtfvOU0s1LZdbfFPH+3+RgaDANLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909148; c=relaxed/simple;
	bh=19inzZ6/lR/nuyBYcmmFV6IqnEBk6EXFi8zOwN2tfG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QyB4exzd1F/UQs5s4bFk88mBILxEtCcdPcRzH/lssAFvNznHifRShW+IVUm32bbd/MC4s2qXkGF4Ewo0sCg/r9Hwdu3s6X0v37FQsgXBaqYj4MybSa6GE9Fpkvct0scekLol1F2f4sOCRhtMDKqySAlKnZAF3C3N/K7Zl5aStTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+IGPGdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+IGPGdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEF11F000E9;
	Wed,  1 Jul 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909146;
	bh=94NcWZcOlOB9Xt8ZNJ7iKxXNYhPgRSK+dn1k+tVxrQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R+IGPGdlUUeH1/7RxaiGYWKFGByIa36TTYObmgbefT1tgfRtUqVAzm+beUqz7yYw3
	 gWlcwovPmTqoCgtaGY7MqZnaK3Tyu2nrJaO1BIqi53CEr8lRzz1TE3EuxwSLUxyWDy
	 FXM0oiW4JRpqydVtyksUcesaUOMLt1U9kuKq2jnLkNnixH2saBnpvt0BIz8g7B2I79
	 58GEXhOLyot9ZlpQTWrQrFvbearhqDFcaM9PL8JE1Cf2TxjMBzOHT0tOfPYm6Rvu3k
	 zlcdpiHpz98xbtbgkoNXXrzpgZy2H4PXkmzKFXafuhiiDeI1s/stwlUCzxw92k7rz5
	 HKi1BbcMGhFGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] RISC-V: KVM: Split huge pages during
 KVM_CLEAR_DIRTY_LOG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701120954.129873-5-wang.yechao255@zte.com.cn>
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn>
 <20260701120954.129873-5-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:32:25 +0000
Message-Id: <20260701123226.1AEF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping `mmu_lock` after write-protecting page tables but before =
flushing the TLB leads to lost dirty pages.

Pre-existing issues:
- [Critical] `kvm_riscv_gstage_split_huge` overwrites leaf PTEs non-atomica=
lly, clobbering concurrent hardware A/D bit updates.
--

commit d0195abbe59e08ad1f5c62c2d279ff75e0b3a3f5
Author: Wang Yechao <wang.yechao255@zte.com.cn>
RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG

This commit splits huge pages on the range specified using the clear dirty =
log
ioctl. It also avoids splitting when enabling dirty logging if the initially
set flag is present.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 056c0abe278af..29a7ac023d4db 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -166,6 +166,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct k=
vm *kvm,
>  	kvm_riscv_gstage_init(&gstage, kvm);
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);
> +
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +		mmu_split_huge_pages(&gstage, start, end);

[Severity: High]
Does ignoring the boolean return value from kvm_riscv_gstage_wp_range() cre=
ate
a vulnerability window?

If mmu_split_huge_pages() drops the mmu_lock and yields before the TLB is
flushed:

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
		if (need_topup_split_caches_or_resched(kvm, count)) {
			...
			write_unlock(&kvm->mmu_lock);
			cond_resched();
			...
}

vCPUs could continue writing to these pages using stale writable TLB entrie=
s.

Since the software dirty bitmap was already cleared by the clear dirty log
ioctl prior to this call, could these writes be completely lost during
migration?

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at
mmu_split_huge_pages() led me to kvm_riscv_gstage_split_huge() which
overwrites leaf PTEs non-atomically:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_split_huge() {
    ...
		huge_pte =3D pte_val(ptep_get(ptep));
        ...
		set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
				__pgprot(_PAGE_TABLE)));
    ...
}

Does this set_pte() clobber concurrent hardware accessed/dirty bit updates?

If the hardware page table walker sets the dirty bit on the huge leaf PTE
between the initial read of huge_pte and this unconditional set_pte()
overwrite, those hardware updates appear to be lost.

Should this use an atomic operation (like a cmpxchg loop) when modifying le=
af
PTEs shared with hardware to avoid missing dirty pages?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701120954.1298=
73-1-wang.yechao255@zte.com.cn?part=3D4

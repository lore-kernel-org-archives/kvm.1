Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372A481FDA
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908695; cv=none; b=nE7qTLd+oQ2JaGCIIGrMDmvBOm4eYMes6lKdNHbFLC/KZ6CQ11dV+JvtaYXMTGcy2574Ex+N0GNuBV3uPF8Po195CpgjapZ94JXHV/auLanEGqn58zIgPKu077p++EKa0NbYPhL4kdqE9XHipc9a6wMB6V3ni3z0gImiR9E+aoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908695; c=relaxed/simple;
	bh=4LEwITUbIw13cJ7tp3FXTpA5jKrtyPZ7Q1hzsWDZfzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jhSm09DQ/NpF/sy/TcbMo3ySXdzKxFMt/ej1CzB9JYTL5UhZ2nyJ3Qd2jOIFIXnW/0Dnas5PHePbhAvTH0tjKxkUy6PFWsoejwzx0+Zem5cdwlS6nr0jBppTGxuNrwMRZrWloUkivWHkA7D35nx06zixGCUntUo6ccnnuFgIy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjl112EI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjl112EI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FA31F000E9;
	Wed,  1 Jul 2026 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782908694;
	bh=dJqqStNJj6G7QtunQQ/VpNKx3oXTNuHey33l4BqOwGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vjl112EIyNYezF+fA0oGHEYSyq3MyBs2EhhwYHKPgDmh43nTsvoDBjyBCa/NjlmA5
	 cTVc4Ea0yx5LyJ1VGvLRqJ8cIhxho4RrSVe/bCNiHZknXdWUNxGUx+V7hHDBGe3Mw9
	 VxZOobNxd7gsi/Q5DTa9e0QYbpaaFA0rdeS4ezVfmWf6Pj5Wu/0xiL6z9VCGX6RkwO
	 LFlAGvApo3a5tZekhPQdpKUiC0P00bPssuCV+YlCc3XlcgA71iKqLp3ZxUVYTWvxe3
	 LzhmkDCgQcW5kp2EHguKt5eMaTYewBvxj9jnGhwFxnlQd4J2DjSsVuT7+p+/U5PHOP
	 VC0VVZhWlcMLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] RISC-V: KVM: Add the eager_page_split module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701120954.129873-6-wang.yechao255@zte.com.cn>
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn>
 <20260701120954.129873-6-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:24:53 +0000
Message-Id: <20260701122454.39FA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lost dirty tracking bits when yielding `mmu_lock` during eager pag=
e splitting.
--

commit c10dcf7c74a70f5a554a9a6c72e02322a9c48b68
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Add the eager_page_split module parameter

This patch adds an eager_page_split module parameter for RISC-V KVM, follow=
ing
the same approach as on x86. It controls whether eager page splitting is
enabled during dirty logging. Disabling it can benefit VM workloads that
rarely perform writes by keeping huge pages intact.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 29a7ac023d4db..a534f596c8ca0 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> @@ -167,8 +170,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
kvm *kvm,
> =20
>  	kvm_riscv_gstage_wp_range(&gstage, start, end);
> =20
> -	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> -		mmu_split_huge_pages(&gstage, start, end);
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +		if (READ_ONCE(eager_page_split))
> +			mmu_split_huge_pages(&gstage, start, end);
> +	}
>  }

[Severity: High]
This is a pre-existing issue, but since we're modifying this path, could th=
is
lead to lost dirty tracking bits?

In kvm_arch_mmu_enable_log_dirty_pt_masked(), kvm_riscv_gstage_wp_range()
write-protects the page tables and returns a boolean indicating if a TLB
flush is needed, but this return value is currently ignored.

When mmu_split_huge_pages() is called immediately after, it can drop the
mmu_lock and yield:

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
    if (need_topup_split_caches_or_resched(kvm, count)) {
        if (flush) {
            ...
        }

        write_unlock(&kvm->mmu_lock);
        cond_resched();
    ...
}

If the lock is dropped without flushing the TLBs for the newly
write-protected pages, couldn't guest vCPUs continue executing and write
to these pages without taking a page fault?

This seems like it would allow the hardware to use stale writable TLB entri=
es
while KVM has already cleared its software dirty bitmap, potentially leading
to silent memory corruption during live migration.

Should we ensure the TLBs are flushed for the write-protected range before
yielding the mmu_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701120954.1298=
73-1-wang.yechao255@zte.com.cn?part=3D5

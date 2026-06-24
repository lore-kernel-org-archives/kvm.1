Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C838299A84
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289865; cv=none; b=RgaDbtmjqatqrDnjFHiI6XKCkC1W945fyZkYSdtQkfDYM6iAeRUyFScPg+/QFKD+Q6r+BQsGv5OdzkRHxHNoVFP8DX15UT3sPnfdHn9DBst/SCxi9Y21hSNsty7dYm+Uybdu/dOA44aICxh5YbJV38L1zj7GmbLjrE+Ecb+Akxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289865; c=relaxed/simple;
	bh=KflSald9kxxAiBdKpYQAMWIRii+S3ehQ88rNVpIE8UA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=punphodDTM4tulPzWGCd0jPHeIQpJMXldklUcZ/wGuqwHu5xaKWgTpw0ZW6ukcYJq8agIeYWBRM0is7WqDq/TR1p50raEW5B39feTR3IgFh3ZILVAXL+vsJEGVRqajxra6RYbisAKmafI97D1gMoByoK+CcqE2bATayYPj0jiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC/cBkbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC/cBkbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF181F000E9;
	Wed, 24 Jun 2026 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782289864;
	bh=GY/obA5DJl5XHfMpXvNYXLPev5qPJlOzjR1KCYxMiTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FC/cBkbv52I88bBLVlHgOIxLCp6aH3pnjTj0g1j+5aJhQ8PbYE9SiuxQp/XnTOlWF
	 FIuIjSq/KHd2W/Fyl+X7ojduKNDZ9PaHqxfUt/gIM19axL0MNMNKeN6iOGWvXtZ1sX
	 rw2z4rgjG9bAD3uushMVC2fON6RFOyQDM7foe/pL7/oYPNGlX8evC+Uli0FQl7o4Vf
	 dRPuZehPPZx6msSvbyZ3PTxhcaDquGolNLxEbsYZPi9uBoGRqVHRaztblF761AsgSF
	 Vllcr33nOUf/6sCGejLVSR3QmYgkrUcItF+bL7+XIrmxFaVW0Uzo5ukD7AISdQUkUK
	 gt2BaJll4elAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 RESEND 5/5] RISC-V: KVM: Add the eager_page_split
 module parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: wang.yechao255@zte.com.cn
Cc: kvm@vger.kernel.org
In-Reply-To: <202606241613317585xwq5rcUKFZQtDleCa7ES@zte.com.cn>
References: <20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn>
 <202606241613317585xwq5rcUKFZQtDleCa7ES@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 08:31:03 +0000
Message-Id: <20260624083103.EFF181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dropping `mmu_lock` during eager page splitting without flushi=
ng the TLB allows guest writes to be silently lost from the dirty log.
--

commit 76d7c935b026714d65bf09e853c93dff6ddf2853
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Add the eager_page_split module parameter

This commit adds an eager_page_split module parameter for RISC-V KVM.
When enabled, KVM proactively splits large pages into smaller pages for
dirty logging operations.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index cbda927dd24e3..278dd3bba680e 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> @@ -165,8 +168,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct =
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

[Severity: Critical]
This is a pre-existing issue, but does dropping the mmu_lock here without
flushing the TLB allow guest writes to be silently lost?

In kvm_arch_mmu_enable_log_dirty_pt_masked(), kvm_riscv_gstage_wp_range()
write-protects the stage-2 page tables, but its return value is ignored,
deferring the TLB flush.

It then calls mmu_split_huge_pages(), which can drop the kvm->mmu_lock
if it needs to reschedule or top up caches:

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
    if (need_topup_split_caches_or_resched(pcache, count)) {
        if (flush) {
            ...
        }
        write_unlock(&kvm->mmu_lock);
        cond_resched();
    ...
}

If the lock is dropped here during eager page splitting before the deferred
TLB flush happens, can guest vCPUs still write to these pages using their
stale, writable TLB entries?

Because the dirty bitmap was already cleared by the caller
kvm_clear_dirty_log_protect(), and no page fault would occur to invoke
KVM's fault handler, these writes wouldn't be recorded in the dirty log.

Would this result in silent data corruption where the destination VM
resumes with stale memory after a live migration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624160054463wc=
DvJaMoydSggcNOWgcfB@zte.com.cn?part=3D5

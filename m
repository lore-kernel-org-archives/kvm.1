Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0643546CB
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218095; cv=none; b=maFmgynNJb2O2AV70eHaqyUI+GcHguB4bL9AowbjvndtLPQM12E45d18ZvliNR2Odu1O5SgKT9kRq6jl6h4Hx/X8RcikHNaqoJPNmCdPS1+kF2zT7rHQS1G2/H9g87iaXeNX9TgOjkkqLPRqP4qzDyT1DpXMLm3PgjSQFBTdMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218095; c=relaxed/simple;
	bh=djnndNOih8cR+4RfLt1cq7t4RZaXpDx5RmYvjYyBbrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VKg41dOVcKhoQFFUeEyGXgesVg2lBdKRDTmHOUxRcSEbjT4k5ESfl2nrtbKegsSGGlJKFvYmsH7CLWUZa+Ng0x+b2kc0kVkAEpz62ryy1SIUJ2m7qvXnCKtb5bvzZjodN2vdj6HIBs3BZrgoIpiZm2hnPOAgYx+7UXOXbQRYoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guu9CvmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guu9CvmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B68A1F000E9;
	Tue, 23 Jun 2026 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218094;
	bh=2uxxFJAIqKAtJZBLAeS2Vv12CgOcnw/FSnS02rXempQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guu9CvmD0lKM4IDt15gQJM0DYJMeWfYoDuYtN4tA2SxuHJ9HyQ6r1kPQgEzGLJY31
	 UdGnypR0yif/bKCDhaXkdNsYqfJY3ES9gePzVXY2yVDhsXp69y/xTZ1+d9JhWvoqUx
	 xsMfl1LA6lmjm11A1fvkBcwiP3S6p9KxWisURzPZiwji2+Y5GABRwEDLr88c+jnSep
	 bx59VVRRU2OK7JZuCdB0+9MQMlcdrXgPpPzN0hHa7Gskkt+mFoWS29FVLlxCjYKChS
	 I9HVYQZEBZrPNc5rE9Nm8wUX7BzPYJ6xMcwHjlAhkk6HqMOglfy8K/W7nbZEP8A2wx
	 F0tOqFuRcaxQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] RISC-V: KVM: Add the split page cache for ioctl
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260623121332.78514-2-wang.yechao255@zte.com.cn>
References: <20260623121332.78514-1-wang.yechao255@zte.com.cn>
 <20260623121332.78514-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:34:53 +0000
Message-Id: <20260623123454.5B68A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lockless freeing of `pgd_split_page_cache` in `kvm_riscv_mmu_free_=
pgd()` introduces a structural data race with concurrent KVM ioctls.

Pre-existing issues:
- [Critical] Guest memory fault after `mmu_notifier_release` causes a host =
kernel panic due to unchecked NULL pgd.
--

commit 4369101385f8b6b3e99f16d6f89e641a21847559
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Add the split page cache for ioctl context

This commit adds a split page cache for dirty logging enablement and the
KVM_CLEAR_DIRTY_LOG ioctl on RISC-V.

> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 082f9b2617338..d69fba7d8e9a6 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c

[ ... ]

> @@ -703,6 +704,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
> =20
>  	if (pgd)
>  		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
> +
> +	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);

[Severity: High]
Does freeing this cache locklessly introduce a use-after-free race with
concurrent KVM ioctls?

If mmu_notifier_release() is executed by exit_mmap() while a concurrent
process (sharing the KVM fd) executes KVM_CLEAR_DIRTY_LOG, they can race.

KVM_CLEAR_DIRTY_LOG calls mmu_split_huge_pages(), which drops kvm->mmu_lock
and locklessly tops up the cache:

arch/riscv/kvm/mmu.c:mmu_split_huge_pages() {
    ...
            write_unlock(&kvm->mmu_lock);
            cond_resched();

            ret =3D kvm_mmu_topup_memory_cache(pcache, count);
    ...
}

Concurrently, kvm_riscv_mmu_free_pgd() (invoked by mmu_notifier_release())
takes and releases kvm->mmu_lock, and then locklessly calls
kvm_mmu_free_memory_cache() here, which can free the cache while it is being
accessed by the top-up.

[Severity: Critical]
This is a pre-existing issue, but does setting kvm->arch.pgd to NULL earlier
in kvm_riscv_mmu_free_pgd() expose a host kernel panic if a guest memory
fault occurs afterward?

If mmu_notifier_release() runs (e.g., via exit_mmap()), it sets
kvm->arch.pgd =3D NULL. If another process holding the KVM fd subsequently
invokes KVM_RUN, a guest memory fault will enter kvm_riscv_mmu_map() and
eventually kvm_riscv_gstage_get_leaf() without checking if pgd is NULL.

In kvm_riscv_gstage_get_leaf(), the NULL pgd is offset and blindly
dereferenced:

arch/riscv/kvm/gstage.c:kvm_riscv_gstage_get_leaf() {
    ...
        ptep =3D (pte_t *)gstage->pgd;
        ptep =3D &ptep[gstage_pte_index(gstage, addr, current_level)];
        while (ptep && pte_val(ptep_get(ptep))) {
    ...
}

Can this lead to a host panic via an unprivileged userspace process?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623121332.7851=
4-1-wang.yechao255@zte.com.cn?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475538B7BC
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914617; cv=none; b=Tk7sqgc2suhwIJoma1eUadzAosYCZmTKbNnwBe81oMtuXXV0xxKiADE0dcjgjagRxd9ZHbsNXQQOcvhPP4+7GvSy1VLdXxplmJcRH1QlClN4rX9M95ZFhZKPoedy2YHTyEPHUlkLQYhKUi+xZQ++/vyYY2fycWSdG+tynbHgEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914617; c=relaxed/simple;
	bh=1GXXCYnoSzgl8fbLS/j1zzxqrBoTtPoebTnLHaJ6Cmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rzqrjGI5H1l0V+0IgIbaeNV8u1jxwfaw9oAmvE4h1bDtQVbfTuCzAwC64nQJ6vUPgYrE55kOoDwFT1qbvpYnwPdGoIlMyLMB4lf7ZM+nGMEMVAgk7orQ4t8z8ifoJ6qOgX8ounkoFZdp6QuvqeRbply/c6WkzN2437oTcPFMPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V00rD5Gc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V00rD5Gc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD47A1F008A3;
	Sun, 20 Sep 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789914610;
	bh=cvSHl/T5RLW87fYsS7D4DZcWNwiIkIZ08zF32HkRmIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V00rD5Gcl2T6jc+Ipod9fotJ8ICxtX7hEP55OR1+bRf4Nc0H9mUApQQDDptwkSdI+
	 Kgpx/EKeXRl9naIHDQAQGuC/IEE/dLOKFttc73DuDvcprWKies8QeiLmqeLNiH2UwT
	 XMZo0JteXeilGkiiqAkPWT93zOqmQZ2IAjWYVd5XnQvpg6Nz9uYHg6ygcZfvC23Eia
	 h8OZsSeN7RCw6oUhz/rXtVd2Ke4seu93uD0QIC/L/S/3VRTzdn6Gym48lo4UYvg+Xl
	 BmuDjrhHa9hi+lbDXpjWvuvbzV3H0rPqnHWnRTbVUTZdycjmZ3xiMcJ61RUfhEATLC
	 UpMsgCeXMYWhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: riscv: Free detached G-stage page tables
 outside mmu_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Can Qi" <qican5708@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260920140831.75097-1-qican5708@163.com>
References: <20260920123117.49830-1-qican5708@163.com>
 <20260920140831.75097-1-qican5708@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:30:10 +0000
Message-Id: <20260920143010.AD47A1F008A3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kvm: premature MMU notifier abort during teardown allows use-a=
fter-free
- [High] kvm: stale TLB exposed when dropping mmu_lock with pending flushes
--

commit cab834ddbb040506be1fc3bc033afe85ed6f46cc
Author: Can Qi <qican5708@163.com>
Subject: KVM: riscv: Free detached G-stage page tables outside mmu_lock

This commit changes KVM RISC-V to detach the active G-stage root under
mmu_lock and free the page tables after dropping the lock. It also replaces
the KVM-wide split page cache with a per-operation cache, dropping the
lock to top it up.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef1..5ab3c4ba5a6a4 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
[ ... ]
> @@ -426,6 +457,12 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage =
*gstage,
>  	bool flush =3D false;
> =20
>  	while (addr < end) {
> +		/* cond_resched_rwlock_write() may have let teardown detach us. */
> +		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) &&
> +		    (!gstage->kvm->arch.pgd ||
> +		     gstage->pgd !=3D gstage->kvm->arch.pgd))
> +			break;
> +

[Severity: Critical]
Can this sequence cause a use-after-free by aborting an MMU notifier
prematurely?

If an in-progress kvm_riscv_gstage_unmap_range() loop yields and observes t=
he
detached root here, it breaks out early and fails to complete the unmap
operation requested by the MMU notifier.

Since kvm_riscv_mmu_free_pgd() drops the mmu_lock before the vCPUs are
quiesced, the host MM could trigger an MMU notifier (e.g., page reclaim)
during this window. If the unmap aborts early, the host MM might free the
page while the guest is still executing and has it mapped.

>  		found_leaf =3D kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_le=
vel);
>  		ret =3D gstage_level_to_page_size(gstage, ptep_level, &page_size);
>  		if (ret)
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 6035b5ec95039..2d7ad70ff7654 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
[ ... ]
> @@ -141,19 +139,22 @@ static bool mmu_split_huge_pages(struct kvm_gstage =
*gstage,
>  			if (ret) {
>  				kvm_err("Failed to toup split page cache\n");
>  				write_lock(&kvm->mmu_lock);
> -				return flush;
> +				break;
>  			}
>  			write_lock(&kvm->mmu_lock);
>  		}
> =20
> -		if (!kvm->arch.pgd)
> -			return flush;
> +		if (!kvm->arch.pgd || gstage->pgd !=3D kvm->arch.pgd)
> +			break;
> =20
>  		flush |=3D kvm_riscv_gstage_split_huge(gstage, pcache, addr, 0, false);
> =20
>  		addr +=3D PMD_SIZE;
>  	}
> =20
> +	write_unlock(&kvm->mmu_lock);
> +	kvm_mmu_free_memory_cache(pcache);
> +	write_lock(&kvm->mmu_lock);
>  	return flush;
>  }

[Severity: High]
Does this code expose stale hardware translations to the guest?

If flush is true at the end of the loop, the mmu_lock is dropped to free the
memory cache before returning the flush status to the caller. This creates a
window where the mmu_lock is dropped, but the accumulated split pages have =
not
yet been flushed from the TLB.

Could a guest trigger huge page splits and access memory during this window,
retaining a stale mapping in the hardware TLB while the host MM subsystem
believes the page is unmapped?

[ ... ]
> @@ -772,41 +768,45 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
>  void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>  {
>  	struct kvm_gstage gstage;
> -	void *pgd =3D NULL;
> -	bool flush =3D false;
> =20
>  	write_lock(&kvm->mmu_lock);
> -	if (kvm->arch.pgd) {
> -		kvm_riscv_gstage_init(&gstage, kvm);
> -		flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
> -			kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
> -		pgd =3D READ_ONCE(kvm->arch.pgd);
> -		kvm->arch.pgd =3D NULL;
> -		kvm->arch.pgd_phys =3D 0;
> -		kvm->arch.pgd_levels =3D 0;
> +	if (!kvm_riscv_gstage_init(&gstage, kvm)) {
> +		write_unlock(&kvm->mmu_lock);
> +		return;
>  	}
> +	/* Live walkers must acquire mmu_lock and check the active root. */
> +	WRITE_ONCE(kvm->arch.pgd, NULL);
> +	kvm->arch.pgd_phys =3D 0;
> +	kvm->arch.pgd_levels =3D 0;
>  	write_unlock(&kvm->mmu_lock);
> =20
> -	if (flush)
> -		kvm_flush_remote_tlbs(kvm);
> -
> -	if (pgd)
> -		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
> +	/* Quiesce hardware users before freeing the detached page tables. */
> +	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);

[Severity: Critical]
Does this code allow vCPUs to continue executing with a detached page table?

By setting kvm->arch.pgd to NULL and dropping the mmu_lock before
kvm_make_all_cpus_request() successfully kicks all vCPUs out of guest mode,
there is a window where vCPUs can still access memory.

If the host MM triggers an MMU notifier during this window,
kvm_unmap_gfn_range() could fail to initialize because kvm->arch.pgd is NUL=
L,
silently returning without unmapping. This could lead to a host use-after-f=
ree
if the host MM frees the page while the guest is still executing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920140831.7509=
7-1-qican5708@163.com?part=3D1

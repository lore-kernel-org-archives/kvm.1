Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829423FC41
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058538; cv=none; b=fWq4536gtjb7KroIAXOAw0zjQf6Xhm8o0hhGIsGzxv4RwMoTKhFLV3uCjSJRx/SO8IHYlcmi5jMCpeMjLojM6tULaK7UBW1+flYGux/eAf0X8sTHpAgHTA4k4PTXyXBghJUY2BZ/Xa94U03zoO64zmYK+Y7CwWU2hF1DjF/M7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058538; c=relaxed/simple;
	bh=mV3OTzN3HJXw/aNuxo0K1YEuZsjzoi9TBbS/eal1EWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z3UtIHIUX05KqkNXH5QwT0vWoc+ZfBg9L1I3roBMOfTCE9TeT13hpOUADyvtgI7PfYNsvtO7eqjscE3lnwGwg/j2JPxac/A2G4Srpj3cLOvIHQZ3a1wmvD11yCyPMPKgLEGR4h2P42GKJCzexq+4Z0GXiVFuW5fLuUWIrRsOKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLldgmOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLldgmOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAC01F000FF;
	Thu, 10 Sep 2026 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058534;
	bh=Srcworya6rNmqCPTEsmEYuNm1v2o3dZ1i1FAt55MsVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLldgmOAzvW9LVOOjB4VOcOi/7QZpUn2/kHB/16l3s0jbv7zEgxHWpzr+bJKYDej4
	 olASIAc/zyhF7eNf9BHIjnRC65BixViE6KJ9NLey1ZSXNbQix49ebL90x5VrmUWUae
	 jvV704JbhAG/xscdEQE2NSaDxDDYVphvz0oyh85YOrJfcblaCD9zOKQqeGvs6ozcqS
	 5qA4oXWIBkyRnN+KInmI2AjV8PJxqqH4ejIPrF/4kz9umqQnFx5Pbsxb7JxhJYoq6u
	 0wOR9B9y049MbxbIw4Cmhb/VsRiSen8swUwcKiPJs05oivp6gc91pHXcVYaywitrFt
	 30QPeaDOfTDmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/10] KVM: guest_memfd: Avoid conditional mmu_lock
 acquisition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Elver" <elver@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910162343.4092060-4-elver@google.com>
References: <20260910162343.4092060-1-elver@google.com>
 <20260910162343.4092060-4-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:42:13 +0000
Message-Id: <20260910164214.1BAC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent memslot unbind in `!file` case bypasses `filemap_invali=
date_lock`, causing UAF and unbalanced MMU invalidate.
--

commit 48bb5bc5161f90dfbe496e0e21d2ca910bf0e571
Author: Marco Elver <elver@google.com>

KVM: guest_memfd: Avoid conditional mmu_lock acquisition

This refactors __kvm_gmem_invalidate_start() to check for present bindings
upfront via xa_find(). It eliminates conditional locking inside the loop to
simplify control flow.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b596486d184ca..1983c1e2dba17 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -124,10 +124,16 @@ static void __kvm_gmem_invalidate_start(struct gmem=
_file *f, pgoff_t start,
>  					pgoff_t end,
>  					enum kvm_gfn_range_filter attr_filter)
>  {
[ ... ]
> -	unsigned long index;
> +	pgoff_t index =3D start;
> +
> +	if (!xa_find(&f->bindings, &index, end - 1, XA_PRESENT))
> +		return;
> +
> +	KVM_MMU_LOCK(kvm);
> +	kvm_mmu_invalidate_start(kvm);

[Severity: High]
This is a pre-existing issue, but does this upfront check introduce a
time-of-check to time-of-use (TOCTOU) window when interacting with a
concurrent memslot unbind?

Looking at kvm_gmem_unbind() in virt/kvm/guest_memfd.c, if a guest_memfd
file is closing (refcount drops to 0), it skips acquiring
filemap_invalidate_lock:

virt/kvm/guest_memfd.c:kvm_gmem_unbind() {
    ...
    if (!file) {
        __kvm_gmem_unbind(slot, slot->gmem.file->private_data);
        return;
    }
    ...
}

This allows __kvm_gmem_unbind() to call xa_store_range(..., NULL)
concurrently without holding the lock. If the binding is removed
immediately after the new xa_find() check above, the loop in
__kvm_gmem_invalidate_start() won't execute, but the invalidate counter
is already incremented.

Subsequently, in __kvm_gmem_invalidate_end(), if the lockless unbind
causes its xa_find() to return false:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_end() {
    if (xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
        KVM_MMU_LOCK(kvm);
        kvm_mmu_invalidate_end(kvm);
        KVM_MMU_UNLOCK(kvm);
    }
}

Could this skip kvm_mmu_invalidate_end() and permanently leak the
mmu_invalidate_in_progress counter, potentially causing all vCPUs to hang
by infinitely retrying in mmu_invalidate_retry()?

>  	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
>  		pgoff_t pgoff =3D slot->gmem.pgoff;
[ ... ]
>  		flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);

[Severity: High]
This is also a pre-existing issue, but does yielding here open a race
window that could lead to a use-after-free?

If __kvm_gmem_invalidate_start() is called via a memory failure path
(e.g., kvm_gmem_error_folio() acquiring filemap_invalidate_lock_shared()),
and kvm_gmem_unbind() concurrently skips the lock, the slot could be
removed from f->bindings and freed by kvm_free_memslot().

Since kvm_mmu_unmap_gfn_range() can drop mmu_lock to yield, could the
iterator access a freed slot when it resumes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910162343.4092=
060-1-elver@google.com?part=3D3

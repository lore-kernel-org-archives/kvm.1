Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637AF3A1A3F
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120632; cv=none; b=OP3uIaeo3QunXEJiLGW/5jffaC//zPh7heQxiMiy6rhnoxrbXNdOmxwvkEfO6OPNS05kqeq35zIYYJEZZglKTmtVSdQmdegb8hCYXGK5hE/MiYWgF3p2detYHOx9kNUshY32jC2sVCxGmMWyH1kHtQMSrhODZpotR3dtcmBOaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120632; c=relaxed/simple;
	bh=ZuuCXjsHaBodXWqWv5s5nFSCp2sf2WRvBSWLRRdGs1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MD0xbRqkL59nKAhUjj3Qi9GDJNk6drEBzh9ES1LyocR5AtQghCgb2t1xzjvHaTsSO2r4uW4WwNsloGrY8BWCHQNzY8wLV/Fe3PV9SU5LTLMd/m/1FnCXJYbSHtFrequul3ihBwFCgGi4ysFshzS9bRq1hL5hq7lI8KqINlKFnnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frZKkQmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frZKkQmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF41F000E9;
	Mon, 27 Jul 2026 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785120629;
	bh=cTvuHVmKdGJzpRiRS6DLA6ZukYdmDnOZwgPQCswm+ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frZKkQmzTgpnbYeHncrioYpuL/USo2nUOJmIitxx0Dm9apq0XsvloxU0Gh4a2Lvbw
	 SXCmre/paJct81eHvtyyd/+chG+aCjuyLQ/N7QFqhtIeeJQ76htK9GYKq0Qo+DC8bK
	 o23t4VzaMJSJQXpE9nu5/gzvbdWg8VEvxVdojVlueGN4v6XIoY/bKhWa2mkhsKqYWw
	 MizjxRnjUJctfnIIlLkli3A69UbbfYfyhFgpXOeAFpVArRPu/LjiAdaeu5mk+hmPKo
	 gTvlqS90N/7S4puoWL4xKZlSR+qST/E8q+qIlOm09jJXr0wHuxBwtKWVmqyCxah5Vj
	 8cA442yha94DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: guest_memfd: Avoid deadlock in
 error_remove_folio()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <ambEdSPjerZIVN0b@192.168.1.215>
References: <ambEdSPjerZIVN0b@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 02:50:28 +0000
Message-Id: <20260727025029.6ACF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous memslot unbinding can leak kvm->mmu_invalidate_in_pro=
gress when racing with kvm_gmem_error_folio(), causing a permanent KVM page=
 fault hang.
--

--- Patch [1]: [PATCH v3] KVM: guest_memfd: Avoid deadlock in error_remove_=
folio() ---
commit db14f829c7993aef911f52935c9113e37c1a49ea
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: guest_memfd: Avoid deadlock in error_remove_folio()

memory_failure() invokes ->error_remove_folio() while holding the
poisoned folio lock. KVM's guest_memfd callback then takes
mapping->invalidate_lock for read before invalidating guest mappings.
This can deadlock with paths that hold mapping->invalidate_lock for write.

Link: https://lore.kernel.org/all/tencent_7DA064CAC9B463EB9B651801011E2CE42=
30A@qq.com/

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab60..6476ab4a2be79 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -500,7 +500,17 @@ static int kvm_gmem_error_folio(struct address_space=
 *mapping, struct folio *fol
>  {
>  	pgoff_t start, end;
> =20
> -	filemap_invalidate_lock_shared(mapping);
> +	/*
> +	 * memory_failure() invokes ->error_remove_folio() while holding the
> +	 * poisoned folio lock.  Do not block on mapping->invalidate_lock, as
> +	 * a writer that already holds the invalidate lock can be waiting for
> +	 * the same folio, e.g. truncation from MADV_REMOVE/FALLOC_FL_PUNCH_HOL=
E.
> +	 *
> +	 * If the invalidate lock is contended, fail the recovery instead of
> +	 * risking a deadlock in the memory-failure path.
> +	 */
> +	if (!filemap_invalidate_trylock_shared(mapping))
> +		return -EBUSY;
> =20
>  	start =3D folio->index;
>  	end =3D start + folio_nr_pages(folio);

[Severity: High]
This is a pre-existing issue, but can this function race with memslot
unbinding and permanently leak kvm->mmu_invalidate_in_progress, causing a
KVM page fault hang?

If userspace closes the guest_memfd file descriptor, dropping its refcount
to 0, and concurrently deletes the memslot, kvm_gmem_unbind() gets called.
Because the file refcount is 0, it takes the lockless path and modifies
f->bindings without holding mapping->invalidate_lock:

virt/kvm/guest_memfd.c:kvm_gmem_unbind() {
    ...
	if (!file) {
		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
		return;
	}
    ...
}

Concurrently, if a hardware memory failure triggers kvm_gmem_error_folio(),
it acquires the invalidate_lock via filemap_invalidate_trylock_shared().
It then calls kvm_gmem_invalidate_start(), which finds the memslot and
increments the invalidation counter:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_start() {
    ...
		if (!found_memslot) {
			found_memslot =3D true;

			KVM_MMU_LOCK(kvm);
			kvm_mmu_invalidate_start(kvm);
		}
    ...
}

But because __kvm_gmem_unbind() concurrently removes the binding from
f->bindings without synchronization against invalidate_lock readers,
__kvm_gmem_invalidate_end() then fails to find the binding and skips the
decrement:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_end() {
    ...
	if (xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
		KVM_MMU_LOCK(kvm);
		kvm_mmu_invalidate_end(kvm);
		KVM_MMU_UNLOCK(kvm);
	}
    ...
}

Could this permanent leak cause the KVM page fault retry protocol to
unconditionally return true, throwing the vCPU into an infinite page fault
loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ambEdSPjerZIVN0b@19=
2.168.1.215?part=3D1

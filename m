Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683D356779
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763965; cv=none; b=QXB5HJATpUAM+r14CESjUhUVH080RdnJKQQ95tTz/Y0/f/u77B8y3WrLYUTJhQRdF5O5/VqMbJ4iOQNY9/fbnqur3zMgACSTDJNLn6mxYaRjX75qEy4MwcqDtmw+G8Yx+Lfz15Wy4AMN51jS1hUlSLyXxRU8gNeud9jAHQPvJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763965; c=relaxed/simple;
	bh=451IMm0BbLRMgjir/Jf5bALUT5bTDtK8PLmPB5Sv7X4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dzl/6KFwSb066PLHlVxFBiC/XPPM2RopIKjxBBEmW1neNcmF7neMtvITj2gRbz4g2Hh7w1NKbQ5NxL4IyO+18b5/32SajEFF+iNVs2q3J4IpT+uJFc32LzFxeX5XpYTW640KlAM4r0rV4ipXyrA662o/VshaSTeCZ+amU//+XT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a14+AshQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a14+AshQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF801F000E9;
	Wed, 26 Aug 2026 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787763952;
	bh=RKysK4sD0IA4VFHSu9Qspaplh308ntc1kCXTV+NUIGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a14+AshQ4mrDtorr5DaqflD0V8EaNPHcg1giq69VCqUVFBBguOqR7LdliW+JSUe4b
	 wEi+PvdBEoGyphHvAFK+ke+F4Hj8q2mdDcMmn87O3L+58P+L07A3jLGwErV42siYrD
	 uMPYrKSnMer2oc9vHQWixfjdpQwCo+7T+hay2MY4KfTtiGWJcB9hTDeQqxPJjoRtTc
	 CPmgJFzA8hzZ45djgHX+An6sgdXqEmEwxm9HwVqqtrJslr5iGGvPcpMvyEdG+4dOXo
	 Av/JHx42xhmoCbbBD+SswkFFcgjXUuY0Sr3tzV8k9ZwOgiNrIEfM+NRRisqOg+xRX3
	 3C03SHqbEbeoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826165154.766699-3-seanjc@google.com>
References: <20260826165154.766699-1-seanjc@google.com>
 <20260826165154.766699-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:05:51 +0000
Message-Id: <20260826170551.BEF801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent guest_memfd hole punch triggers NULL-pointer dereferenc=
e via uninitialized memslot.
--

commit 2a171d16c640a591ee0f3fb012de05495cd1214e
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot

Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
during initial binding, as the memslot must be inactive and unreachable.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1ef9e29164237..1d2de9a1bc3f0 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -653,7 +653,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_=
slot *slot,
>  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
>  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
>  	 */

[Severity: High]
This is a pre-existing issue, but is the new memslot actually completely
invisible here?

In virt/kvm/kvm_main.c:kvm_set_memory_region(), the new memslot is bound and
published to guest_memfd before its architecture metadata is prepared:

	r =3D kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);

When virt/kvm/guest_memfd.c:kvm_gmem_bind() executes, it inserts the partia=
lly
initialized memslot into the bindings xarray and drops the lock:

	xar =3D xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);

If userspace concurrently issues a FALLOC_FL_PUNCH_HOLE on the guest_memfd =
with
an offset greater than the memslot's offset, it can acquire the lock, itera=
te
over f->bindings, and find this uninitialized memslot. This triggers an MMU
invalidation over the uninitialized memslot:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_start() {
    ...
	flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
    ...
}

On x86 with rmaps, gfn_to_rmap() will perform pointer arithmetic on the
unallocated slot->arch.rmap (which is NULL), yielding an invalid non-NULL
pointer. This bypasses the NULL check in slot_rmap_walk_okay() and causes
a kernel panic in kvm_zap_rmap().

Does this race condition allow a concurrent hole punch to dereference an in=
valid
pointer?

> -	WRITE_ONCE(slot->gmem.file, file);
> +	slot->gmem.file =3D file;
>  	slot->gmem.pgoff =3D start;
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |=3D KVM_MEMSLOT_GMEM_ONLY;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826165154.7666=
99-1-seanjc@google.com?part=3D2

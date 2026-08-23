Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E42931CD
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787493033; cv=none; b=jfq+rGEdLbESm9z1UI9SNhO90QxmyBpIq3WKBz2B2LVtrfbunlt46Jh5DHpTZhmIBXFfERBZZBtBkSOLMd0rguy2YdjkptEfmH2J2ndIiySBtvn+H/6QfrCGOlcciF9YaxuzM1D6jifelDUofxofvYjnBaIkFVObuJEL3KD7IOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787493033; c=relaxed/simple;
	bh=5ogkpRmxbF9TBbi1Z92FTU3Bd2Xy7CxB3U3RxKJX7fQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ASx1zoBX/xdoaUhVcLx3hu+ejLoGmZtaDWSdGjVO8Oan1JeliTwlo+LUC00F6FrDfzHQrrq9D77rtnNiFqJFGSClfsMyp+KBPVfgsfiU133UUp6oP8DxtlLNPzAEE6+B8sWFwdmpHYcaJi8g4ZxMJtkvO110Kv6DiDy6BFkK1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT9xt3sm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT9xt3sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6DC1F000E9;
	Sun, 23 Aug 2026 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787493031;
	bh=rlc7d/YyXYwVOMsojS2VgCc7NcaJ6b8y+ISL/AoK+jY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iT9xt3smWm4dAf4AwKikAKYnQWCK616Qt1KCuh2b3ZBQaKpIFM0ic70up1Ld6fXd5
	 VOMya4BigrUV9EdJLHaCIXY+utQMU7dQcWuvlcPIWSjpw1ye4KITnrrerL4tkn0uD2
	 mWyD8Dh001tFfSl5HWe0yd43tkd4NQ8OB+WYj83VlkFEkqk7bf0pqakFQaMOukPGXs
	 jZ67xJWxKQNwO4D7DihdwWahgcbAUNuhiIJj9mNKg27UnFI0I1mFgG6gN02F5gvVfC
	 dH5qeJcN6vGslc8f4aWG7SKvQa1zuBHAemPA/sdgfnuwLecb/3A3OOReQRK7Tajyvy
	 iOY9nndQHPu0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-1-512a29fb8e86@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
 <20260823-shivank-gmem-fix-split-v1-1-512a29fb8e86@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 13:50:30 +0000
Message-Id: <20260823135031.4F6DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ignoring the return value of xa_store_range() in guest_memfd bindi=
ng paths leads to a critical Use-After-Free vulnerability.
--

--- Patch [1]: [PATCH 1/5] KVM: guest_memfd: take the invalidate lock when =
unbinding a dying file ---
commit d844dab82ec050e986f6764e412dddfb4f90c309
Author: Shivank Garg <shivankg@amd.com>

KVM: guest_memfd: take the invalidate lock when unbinding a dying file

kvm_gmem_unbind() skips mapping->invalidate_lock when the guest_memfd
file is already dying. All other paths that modify f->bindings hold
that lock. Take the invalidate lock in the dying-file path too to prevent
unbind from removing a binding and leaking mmu_invalidate_in_progress.

Closes: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel=
.org

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f0e5da4908660..f848120af84be 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -721,6 +721,8 @@ static void __kvm_gmem_unbind(struct kvm_memory_slot =
*slot, struct gmem_file *f)

[Severity: High]
This isn't a bug introduced by this patch, but does ignoring the return val=
ue
of xa_store_range() here and in kvm_gmem_bind() lead to a use-after-free?

Looking at kvm_gmem_bind() in virt/kvm/guest_memfd.c, xa_store_range() is
called with GFP_KERNEL:

virt/kvm/guest_memfd.c:kvm_gmem_bind() {
	...
	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
	filemap_invalidate_unlock(inode->i_mapping);

	/*
	 * Drop the reference to the file, even on success.  The file pins KVM,
	 * not the other way 'round.  Active bindings are invalidated if the
	 * file is closed before memslots are destroyed.
	 */
	r =3D 0;
	...
}

If memory allocation fails during this operation, xa_store_range() returns =
an
error pointer, but the return value is ignored. This masks ENOMEM errors and
leads to an inconsistent state where the slot points to the file but the fi=
le
doesn't track the slot.

Because the slot is missing from the file's XArray, when the file is later
closed, kvm_gmem_release() iterates over f->bindings but fails to find this
slot, leaving slot->gmem.file as a dangling pointer.

When the VM destroys the memslot, kvm_gmem_unbind() accesses this dangling
pointer and calls get_file_active() on it. Can this cause a use-after-free =
on
the freed struct file, or improperly increment the refcount of an unrelated,
reused memory object?

Similarly, in __kvm_gmem_unbind():

virt/kvm/guest_memfd.c:__kvm_gmem_unbind() {
	...
	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
	...
}

The return value is ignored here as well, masking errors when removing from
the XArray. Should the return value of xa_store_range() be checked and
handled to prevent these vulnerabilities?

> =20
>  void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>  {
> +	struct file *gmem_file;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-shivank-gm=
em-fix-split-v1-0-512a29fb8e86@amd.com?part=3D1

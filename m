Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378F33DEF2
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155311; cv=none; b=Oy5Wt4y+9De8A2k8qBXyBHv33e3e6WjRVvuo1Po5P/YP5ecDUVUG6Ncc02s2cu8l0Eq6aBVC46ySl2Hy6hPE72UOAFIROR1wwo6HADhgQQRAbpdEMrni/I3R7A3SR+/MtYw25sTBQjrowVe/jYN46d6G/CfgehnD6/o38tdN7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155311; c=relaxed/simple;
	bh=Dt55FXC5j1tYUpyfltnffnmyZcZOeQK9oe8Q4jAhSs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cpM8QEuKwrtWUUMJebPb9E+2F1YsFVk3pYDHQ0RqmVHiikLhvok7UZTbSUK4kxufIp4TYaJ7K/hPyKva2ittErhJYRGtpqj/yKnEGwtBBwdy4BvZVxmqq4CSMHyVGONb3mjcif4aKIPwK3k/JTMZm+YETt5ZPkGl8AR++Nw+pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkuxatPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkuxatPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B1F1F000E9;
	Mon, 22 Jun 2026 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782155309;
	bh=mNvdXdClmftMUFCxTIN/5jVkbOUuWDaO51jVGlKI/3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkuxatPbhEF2becwKav7E9gKazt9665wkA39udVsFLa/cZ6JAdiuWUvWjgJ7dzx77
	 a3ImDEgYbSocEKuwW1FiztZfqh/Ph/U5t3JUy3C7XL9p44t6oJ8FKLTUqmM2fklnUF
	 wV9LeT3wM4eIMP1fLhcgL8XNzqVNRgXlTD131Vzcbpa5JmGb8nsEs4pzXdW3zHH01W
	 OyvnunlSBGifOsz52qnGjr5WxbxcRSiLety2A2YtklFD0oLES74XKX1JK6NrPPA5sk
	 1Vw8o9crqehUbTozP7HvzmVlddz56NgZjoOAKXXyxCuyUGgcGKIdRkiP+63tbOMowT
	 i4TjwWC7M4raA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] kvm: guest_memfd_luo: add support for
 guest_memfd preservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622184851.2309827-7-tarunsahu@google.com>
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-7-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:08:28 +0000
Message-Id: <20260622190829.86B1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Missing `kvm_get_kvm()` in `kvm_gmem_luo_retrieve` causes a Us=
e-After-Free of the KVM instance.
- [Critical] Restoring guest_memfd with flags not supported by the current =
architecture or KVM configuration.
- [High] Missing validation of `ser->size` and `folios_ser[i].index` during=
 guest_memfd retrieval.
- [Low] The patch calls non-existent LUO functions and accesses a non-exist=
ent field in `struct liveupdate_file_op_args`, preventing compilation.
--

commit 9f1f13985c0cce15e0b3564ac25bf7a759e9dd5e
Author: Tarun Sahu <tarunsahu@google.com>

kvm: guest_memfd_luo: add support for guest_memfd preservation

This patch sets up the basic infrastructure to preserve the guest_memfd acr=
oss
kexec reboots using LUO. It walks through the folios, serializes them, and
freezes the guest_memfd inode to avoid changes. During retrieval, the folios
are restored into the page cache.

> diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
> new file mode 100644
> index 0000000000000..c242b1d14c0ac
> --- /dev/null
> +++ b/virt/kvm/guest_memfd_luo.c
[ ... ]
> +static int kvm_gmem_luo_freeze(struct liveupdate_file_op_args *args)
> +{
[ ... ]
> +	/*
> +	 * Obtain a strong reference to kvm->vm_file to prevent the SLAB_TYPESA=
FE_BY_RCU
> +	 * file memory from being reallocated while it is being processed.
> +	 */
> +	kvm_file =3D get_file_active(&kvm->vm_file);
> +	if (!kvm_file)
> +		return -ENOENT;
> +
> +	err =3D liveupdate_get_token_outgoing(args->session, kvm_file, &vm_toke=
n);

[Severity: Low]
Is args->session defined in struct liveupdate_file_op_args?

Looking at the definition in include/linux/liveupdate.h, there is no session
field, and the function liveupdate_get_token_outgoing appears to be
undefined in the kernel tree.

Will this cause a compilation failure?

[ ... ]
> +static int kvm_gmem_luo_retrieve(struct liveupdate_file_op_args *args)
> +{
[ ... ]
> +	if (ser->flags & GUEST_MEMFD_LUO_FLAG_MMAP)
> +		gmem_flags |=3D GUEST_MEMFD_FLAG_MMAP;
> +	if (ser->flags & GUEST_MEMFD_LUO_FLAG_INIT_SHARED)
> +		gmem_flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED;
> +
> +	err =3D liveupdate_get_file_incoming(args->session, ser->vm_token, &vm_=
file);

[Severity: Low]
Similar to the freeze path, is args->session defined, and is
liveupdate_get_file_incoming available in the current tree?

[ ... ]
> +	if (!kvm) {
> +		err =3D -EINVAL;
> +		goto err_free_ser;
> +	}
> +
> +	file =3D __kvm_gmem_create_file(kvm, ser->size, gmem_flags);

[Severity: Critical]
Does this miss a kvm_get_kvm() call?

In kvm_gmem_luo_retrieve(), __kvm_gmem_create_file() associates the new
guest_memfd file with the kvm instance. However, without calling
kvm_get_kvm(), the lifecycle linkage is broken.

If the userspace process closes the VM file descriptor before closing the
retrieved guest_memfd, could the KVM instance be freed prematurely, leading
to a use-after-free when the guest_memfd is eventually released?

[Severity: Critical]
Are gmem_flags validated against the current architecture's supported flags?

Unlike kvm_gmem_create(), the retrieval path passes the deserialized flags
directly to __kvm_gmem_create_file() without checking
kvm_gmem_get_supported_flags().

Could an outdated or manipulated KHO image force the creation of a
guest_memfd with mmap enabled on architectures or confidential
configurations that explicitly forbid it?

[Severity: High]
Is ser->size validated before creating the file?

The standard creation path enforces that the size is greater than 0 and page
aligned.

Without these checks, could an invalid size cause issues in the guest_memfd?

> +	if (IS_ERR(file)) {
> +		err =3D PTR_ERR(file);
> +		goto err_free_ser;
> +	}
> +
> +	inode =3D file_inode(file);
> +
> +	if (ser->nr_folios) {
> +		folios_ser =3D kho_restore_vmalloc(&ser->folios);
> +		if (!folios_ser) {
> +			err =3D -EINVAL;
> +			goto err_destroy_file;
> +		}
> +
> +		for (i =3D 0; i < ser->nr_folios; i++) {
> +			struct folio *folio;
> +			phys_addr_t phys;
[ ... ]
> +			err =3D filemap_add_folio(inode->i_mapping, folio, folios_ser[i].inde=
x,
> +						GFP_KERNEL);

[Severity: High]
Are bounds checks needed for folios_ser[i].index?

The deserialized index is trusted implicitly.

If a manipulated KHO image provides out-of-bounds indices greater than or
equal to the file size divided by the page size, could this insert
inaccessible folios into the page cache that consume memory until the file
is closed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.2309=
827-1-tarunsahu@google.com?part=3D6

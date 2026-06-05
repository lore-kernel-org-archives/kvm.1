Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB8134751F
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680359; cv=none; b=cx3UNhQ8mIwoWncNOxbpHrQtQ0t+lNmkgemoC1U68lZgEh6rkzwQbYSW83UhEAAnhvAqFrLMxrWVG0sh406TI77L1LzEyqyDC1EmJnCn0McKnFFRNuOfSdgtBOuJgvEKHPlpvHjAS8ZPkp/Re5rjLsWNyk0Wk+FlZQUVsw1Xzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680359; c=relaxed/simple;
	bh=i+ttCMnFwDqg/lUb7XqdXKbzDoAnJCoMJ9m5EJHak10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nTBokhSi2mFnQfabu67r7KZm3LU9Bt63JE1WXiNBO8VfQEp/xZOuEIWYRA1lQFeF6CPu+jGRF+iqXyrCX06wivLaKz3CMgmJYYTVFpoRU/EtCCkoS/Wp0+OcRrdqfYmJTV9ysTF2IxIWblfJTmvONJx5JPCid5pFhVO5UI3JJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOewKbz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOewKbz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6A71F00898;
	Fri,  5 Jun 2026 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680358;
	bh=hCXUJ3+QXvcQCKbLR7wDB7+ZEQ4wju5eaF6L+CZjUQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOewKbz7kdxH6LKZWkt4uiuUSNEgwcfduAjJxRrYCkyLCnUWOXqDS633hacaxuyvT
	 TJ6e54Jg7LKvtuXlYNJxclWkQhn9elPftfpHNQW3x2ygvr9vT2JpH4MgBkNMncFkgg
	 KOwNVZUsiWwlJ+BtsBoi/PPNECr1/R5rNGquXyehkDsgnfzUnoHzz4D2jzlQGH6aFp
	 mDBNnte4Xkpcu6u9ptORTMIEMBe5CIqSGGgpI7BA8OH9hIXjxdbY+uilSjbLQ/7jXN
	 O+K69mKTxQpPsasCGEpo29lyu2jR3R8BL5DKcrbJ8ZoWtWC9LVOUVGProw6k85OCQR
	 +9gQq4Y95Aq+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/10] kvm: guest_memfd_luo: add support for
 guest_memfd preservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <4b2216f5c459fe699a3f62464cbc765624e20ae6.1780676742.git.tarunsahu@google.com>
References: <4b2216f5c459fe699a3f62464cbc765624e20ae6.1780676742.git.tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:25:57 +0000
Message-Id: <20260605172557.DC6A71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Dereferencing `file->private_data` before validating the file =
type causes a NULL pointer dereference.
- [High] Logic inversion in `kvm_gmem_luo_finish()` causes a double-free of=
 preservation structures and active guest memory folios on successful retri=
eval.
- [High] Missing `kho_is_enabled()` gate before invoking KHO serialization =
APIs causes potential NULL pointer dereference.
--

commit d0ebe234914d6981be774d511af45334f3db4977
Author: Tarun Sahu <tarunsahu@google.com>
Subject: kvm: guest_memfd_luo: add support for guest_memfd preservation

This patch sets up the basic infrastructure to preserve the guest_memfd.
It registers a new LUO file handler for guest_memfd files to serialize
and deserialize guest memory.

> diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
> new file mode 100644
> index 0000000000000..d466f889c9aa1
> --- /dev/null
> +++ b/virt/kvm/guest_memfd_luo.c
> @@ -0,0 +1,485 @@
[ ... ]
> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *ha=
ndler, struct file *file)
> +{
> +	struct inode *inode =3D file_inode(file);
> +	struct gmem_file *gmem_file =3D file->private_data;
> +	struct kvm *kvm =3D gmem_file->kvm;

[Severity: Critical]
Does this code dereference file->private_data before confirming the file
is actually a guest_memfd?

The LUO framework might pass unrelated file descriptors where
private_data is NULL. By extracting gmem_file->kvm before checking
inode->i_sb->s_magic, could this cause a NULL pointer dereference
when evaluating unrelated files?

> +
> +	if (inode->i_sb->s_magic !=3D GUEST_MEMFD_MAGIC)
> +		return 0;
> +
[ ... ]
> +static int kvm_gmem_luo_preserve(struct liveupdate_file_op_args *args)
> +{
[ ... ]
> +	end_index =3D size >> PAGE_SHIFT;
> +
> +	ser =3D kho_alloc_preserve(sizeof(*ser));

[Severity: High]
Could this call trigger a NULL pointer dereference if the KHO subsystem
is disabled?

According to the KHO subsystem guidelines, all callers must explicitly
gate KHO usage on kho_is_enabled(). It looks like kvm_gmem_luo_init()
registers the file handler unconditionally, and this path invokes
kho_alloc_preserve() and other KHO serialization APIs without checking.

Should this function (or the initialization) verify kho_is_enabled()
before interacting with the KHO subsystem?

> +	if (IS_ERR(ser)) {
> +		err =3D PTR_ERR(ser);
> +		goto err_unfreeze_inode;
> +	}
[ ... ]
> +static int kvm_gmem_luo_retrieve(struct liveupdate_file_op_args *args)
> +{
[ ... ]
> +	args->file =3D file;
> +	kho_restore_free(ser);
> +	return 0;
> +
> +err_put_remaining_folios:
[ ... ]
> +static void kvm_gmem_luo_finish(struct liveupdate_file_op_args *args)
> +{
> +	struct guest_memfd_luo_ser *ser;
> +	struct guest_memfd_luo_folio_ser *folios_ser;
> +
> +	/* Nothing to be done here, if retrieve_status was successful or errore=
d,
> +	 * Cleanup is taken care of in retrieval call.
> +	 */
> +	if (args->retrieve_status)
> +		return;

[Severity: High]
Does this logic inversion cause a double-free on successful retrieval?

In kvm_gmem_luo_retrieve(), a successful retrieval frees the ser struct
but leaves args->serialized_data intact:

kvm_gmem_luo_retrieve()
    kho_restore_free(ser);
    return 0;

Because standard Linux error handling uses 0 for success,
if (args->retrieve_status) evaluates to false on success, causing this
function to fall through instead of returning.

Could this lead to accessing the freed ser struct, erroneously putting
active folios, and calling kho_restore_free() a second time?

> +
> +	if (!args->serialized_data)
> +		return;
> +
> +	ser =3D phys_to_virt(args->serialized_data);
> +	if (!ser)
> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.gi=
t.tarunsahu@google.com?part=3D7

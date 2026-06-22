Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2C1C2324
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155169; cv=none; b=VTJT6Or6HKYCo+8whgXLdwAAq51AwlcAw6rtzu9euQ9MWr3TBD2744HYjL4DQI7ZwkQbw3hXvGwkSkCO7UZMKzqkfTjDi6DzQECa8FK93p1R63rZUhrQkOKCIjWYCbHCmH7rZoUEIL53Cf+baJFwJRAdgd8498cKjoX00t9XsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155169; c=relaxed/simple;
	bh=og1gixDwSQELb2w/jaezSUzgpOpY8Fd8J8E5TOKB05c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fv75OORKjPu/vezjcKRX0gzGtbQm5kjlsp0EMPgLzA7QHfV9876aobZtwxa+mZx6xkL3hJri4tr1U5dIqXbKFA4Gu8Bv1l1Oy1Db78gmHr7sz3KPNCor8u/Zi0AbzXbZPx4CkC6nxB5VxtuzYvjylgnftuzSPdWoz+JBWlPeCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0b79P54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0b79P54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D301F000E9;
	Mon, 22 Jun 2026 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782155168;
	bh=sCjl+RxxFWmyVAYIit8p0eo1QH5zzb3AdgGmvW+WS0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0b79P54WZSBkwzlQkC8ULdu2mpw7w/gswRBH+D2XnaombuaZcKzdYaLVzVsSbaqg
	 uxFI4Zb347wgkzd/3jZdmXYQFVi12VJ8rPGWIfMugVIgEBqK1ZXDf+sz1WbG7CtYGQ
	 G9aFRrF6qIc0df+k6YkdQED6uv64As7PAcSF2GeuKhIL7mjjI69Uu74wYVyL/cFsW/
	 XiPftjKBuYJKNZPFrrceuAs9GVUgqPv/QeqVTT54eWrx/PQ4BBDs774m38oUrKTIjS
	 wcqYuQRb6uJOkQKz08Yod6Yl6cFkVAgdAM7njSP77UOcPwUU37B0YT52fFHD2EvbS6
	 3xWXK1C8d/IXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] kvm: kvm_luo: Allow kvm preservation with LUO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622184851.2309827-4-tarunsahu@google.com>
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-4-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:06:07 +0000
Message-Id: <20260622190608.50D301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The macro `KHOSER_COPY_TYPEUNSAFE` is undefined in the kernel tree,=
 causing a build failure.
- [Low] `KHOSER_LOAD_PTR` is incorrectly invoked with a `u64` argument inst=
ead of a union, causing a build failure.
--

commit c233e1cbb1e57dbd4789fe720442add1dfd010f1
Author: Tarun Sahu <tarunsahu@google.com>

kvm: kvm_luo: Allow kvm preservation with LUO

This commit introduces KVM VM preservation support for the Live Update
Orchestrator (LUO). It registers a file handler to serialize and deserialize
VM state across live updates, primarily focusing on preserving the VM type.

> diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
> new file mode 100644
> index 0000000000000..6728877f16daf
> --- /dev/null
> +++ b/virt/kvm/kvm_luo.c
> @@ -0,0 +1,195 @@

[ ... ]

> +static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
> +{
> +	DECLARE_KHOSER_PTR(sd, struct kvm_luo_ser *);
> +	struct kvm *kvm =3D args->file->private_data;
> +	struct kvm_luo_ser *ser;

[ ... ]

> +	KHOSER_STORE_PTR(sd, ser);
> +	KHOSER_COPY_TYPEUNSAFE(args->serialized_data, sd);

[Severity: Low]
Is this macro defined somewhere else in the tree?  It looks like
KHOSER_COPY_TYPEUNSAFE is missing from <linux/kho/abi/kexec_handover.h>
and other headers, which causes a build failure here.

> +
> +	return 0;
> +}
> +
> +static atomic_t restored_vm_id =3D ATOMIC_INIT(0);
> +
> +static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
> +{
> +	char fdname[ITOA_MAX_LEN + 1];
> +	struct kvm_luo_ser *ser;
> +	struct file *file;
> +	struct kvm *kvm;
> +	int err =3D 0;
> +
> +	ser =3D KHOSER_LOAD_PTR(args->serialized_data);

[Severity: Low]
Does this code compile? KHOSER_LOAD_PTR() expects its argument to be a union
declared with DECLARE_KHOSER_PTR(), which provides the expected .ptr and
.phys fields.

Since args->serialized_data is a plain u64, this causes a compilation error
because it tries to access struct/union members on a primitive type.

> +	if (!ser)
> +		return -EINVAL;
> +
> +	snprintf(fdname, sizeof(fdname), "%d",
> +		 atomic_inc_return(&restored_vm_id));
> +
> +	file =3D kvm_create_vm_file(ser->type, fdname);

[ ... ]

> +static void kvm_luo_unpreserve(struct liveupdate_file_op_args *args)
> +{
> +	struct kvm_luo_ser *ser;
> +
> +	/*
> +	 * in case preservation failed, args->serialized_data will
> +	 * be NULL and kvm_luo_preserve takes care of cleaning up.
> +	 * If preserve succeeds, this condition fails and unpreserve
> +	 * function takes care of cleaning up.
> +	 */
> +	ser =3D KHOSER_LOAD_PTR(args->serialized_data);

[Severity: Low]
Similar to the issue in kvm_luo_retrieve(), args->serialized_data is a plain
u64 rather than the union KHOSER_LOAD_PTR() expects. Will this cause a build
failure?

> +	if (WARN_ON_ONCE(!ser))
> +		return;
> +
> +	kho_unpreserve_free(ser);
> +}
> +
> +static void kvm_luo_finish(struct liveupdate_file_op_args *args)
> +{
> +	struct kvm_luo_ser *ser;
> +
> +	/*
> +	 * If retrieve_status is true or set to error, nothing to do here.
> +	 * Already cleaned up in kvm_luo_retrieve().
> +	 */
> +	if (args->retrieve_status)
> +		return;
> +
> +	ser =3D KHOSER_LOAD_PTR(args->serialized_data);

[Severity: Low]
Is there a type mismatch here as well? args->serialized_data is being passed
to KHOSER_LOAD_PTR() as a plain u64.

> +	if (!ser)
> +		return;
> +
> +	kho_restore_free(ser);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.2309=
827-1-tarunsahu@google.com?part=3D3

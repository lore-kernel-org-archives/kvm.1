Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586427;
	b=MbrrrBmgE33OmFKOrnZ7xNYZF3TsKuXDJCMyguUotf0VaV9FdzH/Or5wI1/1tzJxWH2D
	 q3orlEHGWN95pouhItPhuZE0R98DQIRAZRL7ACEWsxBak/0L4pJ3F1KPBdw1mHDO93wBw
	 iodTVehojDsdEXvcKlgTPKHHf9zDpZr9kAmk3SYzWlKoNvNOgft5YI6cRHbL4l0RKyPGe
	 SiZ7mBHuNBntqwpZRZvGtDut9C5ZKevi8lMToBP61nW8m+5vRMvm4WuUvdaOHO3Td5mff
	 30LgWqwlQ3Da8XIcxPW9BgtpnZjmteAoht1/oXU9JQtPqpWOKixsZIKa3eOSPi1Ys+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xTNBorsXiZfVJrukh3gUSIg1CCgHIDEmGcUefVjPncE=;
	b=N1p5UByN3Zw9hVrUM2Js80W0jzyqFunLF7sL2iBW45oLc0tfc4ovZmxlXLZTkjyUb45z
	 Op5Z5CgfDCzrpvktyGxAkMhr4TCVKNp+Gp3uOj5cxYdI0CaSIlknqq8Pz7Jhk2kFFcMRb
	 opkC73ELjKaNHpT221BKOkrwvqN1TnzdX8Wb01MYXzKfldy4JMVO9gOzJDfaQlooSx7xW
	 K4lDcd8hjvBOHvAfUWu4CyQ7VVU2r1zIe2Jmye0mRCZzvqyRaGeaJ3oERb1SLLR5j4git
	 NqFerJzgkDFpjPYWHNp/iVr4RDLbra7jIqFAtjGG/TBUxTW10wEFhxntYTG6/YnlpPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLE0lqwh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C825606A33B
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLE0lqwh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174071F000C4;
	Fri, 13 Nov 2026 16:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586427;
	bh=xTNBorsXiZfVJrukh3gUSIg1CCgHIDEmGcUefVjPncE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLE0lqwhiG9D9tAVzGMinxwcfF/DMSP9oZIJjkGJqHIlg2gHE9aSvcPEEDj1hCY5X
	 Aj1aGoSAKIRrGr3Dz7S8lla1XC/MIm48Bi7jAkh/zDA2Q45KYShrne5QqRB++OMXoq
	 SbLt8ZZczkpvvkkp3qcX2h8yW8LeVs43Xzj0FTaJCqqVOjNDtQ/GyHKHzEEShR767b
	 pGEjXa9B/7moA4LuaeNfrT+ZsMJ5d9ecmcugKOJ/rVpyQ0k/Ee0ZcFlUgWQTYagP3G
	 zcNfBT5ADwkDH+ilkvOhlD8TINywC0q/Ll87WTErxshOIho7ls5v7DpqUhrqNYn1rX
	 NqtOS7Gl0LThA==
Message-ID: <sashiko-outbox-213175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/15] ctlv: Prepare VA blob handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-10-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-10-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:13:46 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ctlv: pages allocated before RLIMIT_MEMLOCK check in
  ctlv_blob_va_acquire()
- [Medium] ctlv: inconsistent record_offset on bad blob in
  ctlv_blob_resolve()
--

commit 58ccd80be391ba28c6e0a0c8cd4d357c3b9b3b37
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Prepare VA blob handling

This commit adds task-bound VA blob resolution and CPU read/write access
helpers for CTLV families.

> diff --git a/lib/ctlv/blob.c b/lib/ctlv/blob.c
> new file mode 100644
> index 0000000000000..14cbbc4bcab1c
> --- /dev/null
> +++ b/lib/ctlv/blob.c
[ ... ]
> +static int ctlv_blob_va_range(u64 address, u64 len, unsigned long *first=
_page,
> +			      unsigned long *pages_count)
> +{
> +	unsigned long first, last, span, count;
> +	size_t bytes;
> +	u64 end;
> +
> +	if (!len)
> +		return -EINVAL;
> +	if (check_add_overflow(address, len, &end))
> +		return -EOVERFLOW;
> +	if (end > TASK_SIZE)
> +		return -EFAULT;
> +
> +	/* Bounded by an unsigned long above, so nothing below loses a bit. */
> +	first =3D (unsigned long)address & PAGE_MASK;
> +	last =3D ((unsigned long)end - 1) & PAGE_MASK;
> +	if (check_sub_overflow(last, first, &span) ||
> +	    check_add_overflow(span >> PAGE_SHIFT, 1UL, &count) ||
> +	    check_mul_overflow(count, sizeof(struct page *), &bytes))
> +		return -EOVERFLOW;
> +
> +	*first_page =3D first;
> +	*pages_count =3D count;
> +	return 0;
> +}
> +
> +static int ctlv_blob_va_acquire(struct ctlv_blob *blob, u64 address)
> +{
> +	unsigned long pinned =3D 0, first, pages_count;
> +	unsigned int gup_flags =3D 0;
> +	struct page **pages;
> +	int ret;
> +
> +	/* Before charging or allocating, both of which this sizes. */
> +	ret =3D ctlv_blob_va_range(address, blob->len, &first, &pages_count);
> +	if (ret)
> +		return ret;
> +
> +	pages =3D kvmalloc_array(pages_count, sizeof(*pages), GFP_KERNEL_ACCOUN=
T);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	if (ctlv_blob_writable(blob))
> +		gup_flags |=3D FOLL_WRITE;
> +	ret =3D ctlv_blob_pin_charge(current->mm, pages_count);
> +	if (ret)
> +		goto err_free_pages;

[Severity: Medium]
Should ctlv_blob_pin_charge() run before kvmalloc_array()?

An unprivileged caller with a small RLIMIT_MEMLOCK can pass a large blob
length to force a multi-megabyte vmalloc allocation that is immediately
freed when ctlv_blob_pin_charge() rejects the page count.  In addition,
check_mul_overflow() only bounds bytes to SIZE_MAX, so if a schema allows
a blob whose page array exceeds INT_MAX bytes, kvmalloc_array() without
__GFP_NOWARN will trigger the size warning in __kvmalloc_node_noprof().

[ ... ]

> +/*
> + * Which of an op's blobs was the unusable one, in the shape validation =
would
> + * have used. The errno the family returns says what went wrong.
> + */
> +static void ctlv_blob_context_fail(struct ctlv_op_ctx *ctx, u32 tlv_offs=
et, u32 record_offset,
> +				   u64 required_length)
> +{
> +	if (ctx->error.reason)
> +		return;
> +	ctx->error.reason =3D CTLV_VALIDATION_REASON_BAD_BLOB_DESCRIPTOR;
> +	ctx->error.bad_tlv_offset =3D tlv_offset;
> +	ctx->error.record_offset =3D record_offset;
> +	ctx->error.required_length =3D required_length;
> +}
[ ... ]
> +struct ctlv_blob *ctlv_blob_resolve(struct ctlv_op_ctx *ctx, const struc=
t ctlv_cursor *blob)
> +{
> +	const struct ctlv_hdr *bad =3D NULL;
> +	const struct ctlv_node_schema *node;
> +	u32 tlv_offset, record_offset;
> +	struct ctlv_blob_desc desc;
> +	struct ctlv_blob *acquired;
> +
> +	/* An absent blob, or a cursor from some other execution entirely. */
> +	if (WARN_ON_ONCE(blob->msg !=3D &ctx->request || !ctlv_cursor_ok(blob)))
> +		return ERR_PTR(-EINVAL);
> +	node =3D &blob->tree->node_schemas[blob->node];
> +	if (WARN_ON_ONCE(node->kind !=3D CTLV_SCHEMA_BLOB))
> +		return ERR_PTR(-EINVAL);
> +	if (WARN_ON_ONCE(!ctx->blobs_live || !ctx->submitter || ctx->submitter =
!=3D current))
> +		return ERR_PTR(-EINVAL);
> +	/* Validated before the callback, so anything wrong with it is a bug. */
> +	if (WARN_ON_ONCE(ctlv_blob_desc_read(blob->hdr, &desc, &bad) ||
> +			 ctlv_blob_desc_check(&desc, node)))
> +		return ERR_PTR(-EINVAL);
> +
> +	tlv_offset =3D ctlv_message_offset(blob->msg, blob->hdr);
> +	record_offset =3D ctlv_message_offset(blob->msg, blob->parent);
> +	acquired =3D ctlv_blob_acquire(&desc, node->blob.direction);
> +	if (IS_ERR(acquired)) {
> +		ctlv_blob_context_fail(ctx, tlv_offset, record_offset, 0);
> +		return acquired;
> +	}

[Severity: Medium]
Does record_offset here match what schema validation reports for
CTLV_VALIDATION_REASON_BAD_BLOB_DESCRIPTOR?

ctlv_blob_resolve() sets record_offset to blob->parent, the record
containing the blob descriptor.  However, when ctlv_blob_desc_check()
fails during validation, ctlv_schema_check_blob() passes the blob TLV
itself as the record argument to ctlv_schema_bad():

lib/ctlv/schema.c:ctlv_schema_check_blob() {
    ...
	err =3D ctlv_blob_desc_check(&desc, node);
	if (err)
		ctlv_schema_bad(v, CTLV_VALIDATION_REASON_BAD_BLOB_DESCRIPTOR, blob, NULL=
);
	return err;
}

Because hdr is NULL there, ctlv_schema_bad() sets both bad_tlv_offset and
record_offset to the offset of blob, so userspace sees a different
record_offset depending on whether the blob failed validation or
resolution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D9

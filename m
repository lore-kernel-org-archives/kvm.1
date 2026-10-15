Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893643CAA59
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078453; cv=none; b=fVo7ghDjLQVddFEGQgtDqVnCqdPJa1ev4zBxd6PXpIkj0Kx4ze9uKid3/xNMYEiOoLzNmGsfwpqpZ+kc8wlzs2WdmNEMuywwwAbVyHUEd30U4XppurNquOFXqmtv/1pWQ1EK1IqVuu8moniCyPpkvqc2jKNZCuWCpEzxexl1/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078453; c=relaxed/simple;
	bh=WJUa2Sh3eEp3wDWxzOMptRHACQRq9JnHncIYiWIIkrc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NAE0h8WUEDbIcZff8EWnMCvbx/5hwwrBzp7EhcjJlaTHhdNHKWYLTapzsVpNx+Iok2TjCBp0O6zWek2IiDkPZjrLckFCxxRFWuSBqEOFvmu7uU5SjvWwu1Qi0DqOI4wp0tMcTS0KBo81zhbffnD0G+r5Q4je9eYxjLR1sH3W6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRZSc89h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRZSc89h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1F1F000D4;
	Thu, 15 Oct 2026 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078434;
	bh=QLBCoJTkzRdHvR69cxIZQD4nQF46s+dLtsHTsbdwW6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRZSc89hANSB+Ur4b4q68lQq6nDGornWHpjQSUxUrv8+9ItU3ZfZJxXxuKabDoaXU
	 6PrG3HFhT6c2wMECEyJ+BddQLkiyFmi0cgTAQ/ct5m9gYBm0ozUJBQMQjdUudPMMa7
	 8R5VWO+wx4rqIdEOnIh0gRnFi1iJ/TFFF0hDwi0kRuT4ulpfrvaM4VkZ+IAy4L8Yhu
	 +3Z9lymw+2KZm0JiMDCfbq6OtNqMkRpuAbDjqHY4fqwI34M0SxaGQgp7QH9l9K6XE1
	 e/48AgMhY4r1IwH0m4oYDZ2tcalR0IEMMbuP3Bu5MXA0CZp+cGZnXJ8TwL8r/L7Sq+
	 einthWdXjorNA==
Message-ID: <sashiko-outbox-173078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/20] attestation: Add CTLV operation handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-18-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-18-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:33:54 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] core: stack buffer overflow in ctlv_attestation_mr_log_get_que=
ry()
- [Medium] core: ctlv_blob memory leak in attestation_evidence_decode_objec=
ts()
- [Medium] attestation: missing loop in ctlv_attestation_mr_log_get_query r=
estricts pagination to one entry
--

commit e751f49f55526c0e053324e8d2f25a2d22385dc9
Author: Jiri Pirko <jiri@resnulli.us>

attestation: Add CTLV operation handling

Translate CTLV evidence, MR and journal operations to the provider core and
wire the attestation family into the kernel build.

> diff --git a/drivers/attestation/core/ctlv.c b/drivers/attestation/core/c=
tlv.c
> new file mode 100644
> index 0000000000000..ff19400843c2c
> --- /dev/null
> +++ b/drivers/attestation/core/ctlv.c
[ ... ]
> +static int
> +attestation_evidence_decode_objects(struct attestation *att, struct ctlv=
_op_ctx *ctx,
> +				    const struct ctlv_cursor *request,
> +				    struct attestation_evidence_request *decoded,
> +				    struct attestation_evidence_object_request **objects_out)
> +{
[ ... ]
> +	ctlv_attestation_evidence_get_evidence_object_for_each(&object, request)
> +	{
> +		const struct attestation_evidence_supported_object *supported;
> +		const char *format;
> +		size_t total =3D 0;
> +
> +		format =3D ctlv_attestation_evidence_get_object_evidence_format_get(&o=
bject);
> +		supported =3D attestation_evidence_object_find(caps, format);
> +		if (!supported) {
> +			kfree(objects);
> +			return -EOPNOTSUPP;
> +		}

[Severity: Medium]
Will this return leak any successfully resolved blobs from earlier iteratio=
ns?
On iterations where the index is greater than 0, previous objects have their
output resolved via
ctlv_attestation_evidence_get_object_evidence_data_resolve(). Because this
error path only calls kfree(objects), those earlier ctlv_blob references
seem to be leaked.

> +		for (previous =3D 0; previous < index; previous++)
> +			if (objects[previous].supported_object =3D=3D supported) {
> +				kfree(objects);
> +				return -EINVAL;
> +			}

[Severity: Medium]
Does this face the same memory leak? If a duplicate format is found after s=
ome
blobs have already been resolved, it appears the accumulated references in
objects[0] to objects[index - 1] are not freed before returning here.

[ ... ]
> +int ctlv_attestation_mr_log_get_query(void *priv, struct ctlv_op_ctx *ct=
x,
> +				      const struct ctlv_cursor *request, struct ctlv_cursor *reply)
> +{
> +	struct attestation *att =3D priv;
> +	struct attestation_mr_log_entry *entry;
> +	struct ctlv_cursor item, nested;
> +	unsigned int ids[256];
> +	size_t ids_count =3D 0, index;
> +	unsigned int start, end;
> +	unsigned long xa_index;
> +	u64 boundary;
> +	u64 cursor =3D ctlv_op_query_cursor(ctx);
> +	int ret;
> +
> +	ctlv_attestation_mr_log_get_mr_selection_for_each(&item, request)
> +	{
> +		u64 id =3D ctlv_attestation_mr_log_get_selection_mr_id_get(&item);
> +
> +		if (id > UINT_MAX)
> +			return -ERANGE;
> +		for (index =3D 0; index < ids_count; index++)
> +			if (ids[index] =3D=3D id)
> +				return -EINVAL;
> +		ids[ids_count++] =3D id;
> +	}

[Severity: Critical]
Can this loop overflow the fixed-size ids[] stack array?
If a request contains more than 256 selections, it looks like ids_count
could exceed the size of ids[256] since there isn't a bounds check prior to
appending the id. Would it be possible to add a check to stop writing once
the array is full or return an error?

[ ... ]
> +	if (!cursor)
> +		return ctlv_op_query_more(ctx, boundary, entry->mr_generation);
> +	if (!ctlv_attestation_log_entry_start(reply, &nested))
> +		return -EMSGSIZE;
> +	ret =3D attestation_mr_log_entry_encode(&nested, entry);
> +	ctlv_nest_end(&nested);
> +	if (ret)
> +		return ret;
> +	entry =3D xa_find_after(&att->log->entries, &xa_index, end, XA_PRESENT);
> +	while (entry && !attestation_log_selected(ids, ids_count, entry->mr_id))
> +		entry =3D xa_find_after(&att->log->entries, &xa_index, end, XA_PRESENT=
);
> +	if (entry)
> +		return ctlv_op_query_more(ctx, boundary, entry->mr_generation);
> +	return ctlv_op_query_done(ctx, boundary);
> +}

[Severity: Medium]
Is it intentional that this function only encodes one entry per query?
Unlike ctlv_attestation_mr_dump_query() which has a loop over its entries,
this lacks a while (entry) loop wrapping the encode block. It serializes
exactly one entry and then returns ctlv_op_query_more() if more exist,
artificially restricting pagination to a single entry and causing multiple
requests to read the log. Should this iterate until the buffer fills up
(-EMSGSIZE)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D17

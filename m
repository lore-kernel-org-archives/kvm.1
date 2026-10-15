Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F443E9F5
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077737; cv=none; b=Mq9Ec9qsJb7TWj1Kiy0RxNuTClrdxiMfYOyrROf+6WTlXTa8kZGW8M3IO5rZC5xA0h2sqj5q8Vg+Q0GMgCvrZULJ9DHj/Las6aNLrTmSIiyjTxStpDH1YoHG8moB565Zv3JjO4Kq0zmbwFbSnwgml2dnmeCIloSK9UVY0FgIjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077737; c=relaxed/simple;
	bh=xBiFswB4PS6wPz1epIS31hwTsAxbPgndayiFdni3Pb4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sCSquO8JYwjuW/HQf3dilIN3XZQVUmYulxJYgNNpw0ciuBO3CQoxB7E+HEJss8P+4yFoZUYMi+41px8cVwQL9LYLQfk2yj2UTNTd0mBnBo10ZL7pCRLX19fQo1VMD8FCJu5hFveLEHrfkMKw1NAusTMeElrcZhPQ9YHxudKKH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrC1BQJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrC1BQJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1DB1F000C4;
	Thu, 15 Oct 2026 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077732;
	bh=9JCIrBjHStMJNHGRIYsrxIKZMsYDV/IKNHOcOEySyhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VrC1BQJUPMIiZpYOR9hOtfktq4s19muheg+xX+9Y4IbO3kMkw4QK/QQZGokg0dq/y
	 7SzTPEY6bQxRMSXkb4Vl6j9XQ0poUIkNd5ho74roQJE6LxzvZHecJj7J2vH3pSp+ty
	 6wW2+cg8dy/esVfPqYDKYX2CEWTOQVCNg53FCWubMiGntKYt2SmOnAATtjRoE3VxYW
	 hlEiSDBkx4uznXHNaghzykdeqb24oAkyQrD2memEDglfDbxykGDL5sqyCOhCU9MLaj
	 ws7Hz51TIODFf7kBpduZH9EHERdq5G726fDNU1fBoSRz61IQfN1T8K4e62scD0etrD
	 JNG9gawS1B2Mw==
Message-ID: <sashiko-outbox-173058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/20] ctlv: Prepare event queue support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-11-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-11-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:22:11 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] race: TOCTOU in ctlv_event_file_read causes lost terminal events
- [High] mm: Out-of-bounds write when finalizing reserved event records wit=
h unaligned sizes
- [Medium] race: Queue misordering appends overflow event after terminal re=
moved event
- [Low] cleanup: Mixing goto-based error cleanup with scope-based guards
--

commit 77cd7b72d04e886f1416198fdf738e02c8632520
Author: Jiri Pirko <jiri@resnulli.us>
Subject: ctlv: Prepare event queue support

Add per-open subscriptions, bounded event queues and event creation for
CTLV families. Add the generated root family kernel bindings now that their
message and event helpers are available.

> diff --git a/drivers/ctlv/event.c b/drivers/ctlv/event.c
> new file mode 100644
> index 0000000000000..0f68d33e031c8
> --- /dev/null
> +++ b/drivers/ctlv/event.c
> @@ -0,0 +1,713 @@
[ ... ]
> +static void ctlv_event_record_done(struct ctlv_op_ctx *ctx, struct ctlv_=
event_record *rec)
> +{
> +	u32 root_len =3D ctx->output.root->len;
> +
> +	rec->len =3D sizeof(rec->hdr) + CTLV_ALIGN(root_len);
> +	rec->hdr.length =3D rec->len;
> +	memset(rec->root + root_len, 0, rec->len - sizeof(rec->hdr) - root_len);
> +}
> +
> +static struct ctlv_event_record *ctlv_event_record_reserve(struct ctlv_d=
evice *ctlvdev,
> +							   const struct ctlv_op_entry *op)
> +{
> +	struct ctlv_event_record *rec;
> +
> +	rec =3D ctlv_event_record_alloc(ctlv_event_len(op), GFP_KERNEL_ACCOUNT);

[Severity: High]
Does this sequence cause an out-of-bounds write when finalizing reserved
event records with unaligned sizes?

In ctlv_event_record_reserve(), the record is allocated with a capacity of
ctlv_event_len(op). If the maximum record length from the schema is not a
multiple of 8, this length will be unaligned.

When root_len approaches this unaligned maximum in ctlv_event_record_done(),
CTLV_ALIGN(root_len) rounds up past the allocated size. The subsequent
memset() then writes padding zeros up to the aligned boundary, which can
cause an out-of-bounds write on the kernel heap.

[ ... ]
> +struct ctlv_op_ctx *ctlv_event_create(struct ctlv_device *ctlvdev, u64 o=
p_id,
> +				      struct ctlv_cursor **reply, gfp_t gfp)
> +{
[ ... ]
> +	scoped_guard(spinlock, &ctlvdev->events_lock) {
> +		const struct ctlv_family *family;
> +
> +		if (!ctlvdev->events_live) {
> +			ret =3D -ENODEV;
> +			goto err_free_ctx;

[Severity: Low]
Is it safe to mix goto-based error cleanup with scope-based guards here?

The cleanup subsystem guide mandates that functions must never mix
goto-based error handling and guard()/scoped_guard() declarations.
Using goto to jump out of a scoped_guard creates confusing ownership
semantics.

[ ... ]
> +int ctlv_event_emit(struct ctlv_op_ctx *ctx)
> +{
[ ... ]
> +	scoped_guard(spinlock, &ctlvdev->events_lock) {
> +		if (ctlvdev->dead_announced)
> +			goto out_free;

[Severity: Low]
Does this goto also violate the cleanup guidelines?

Similar to ctlv_event_create(), jumping out of a scoped_guard to a cleanup
label is discouraged and violates the cleanup rules.

[ ... ]
> +static void ctlv_event_queue_consumed(struct ctlv_file *cfile, struct ct=
lv_event_record *rec)
> +{
> +	if (rec =3D=3D cfile->overflow) {
> +		guard(spinlock)
> +			(&cfile->ctlvdev->events_lock);
> +		cfile->reading_overflow =3D false;
> +		if (cfile->overflowing)
> +			ctlv_event_queue_add(cfile, rec);

[Severity: Medium]
Can this queue misordering append the overflow event after the removed even=
t?

If a reader is consuming the overflow marker while the queue receives anoth=
er
dropped event, cfile->overflowing becomes true again. If
ctlv_event_device_dead() is then called, it enqueues the removed terminal
event.=20

When the reader finishes and calls ctlv_event_queue_consumed(), it sees
overflowing =3D=3D true and re-enqueues the overflow marker. Because
ctlv_event_queue_add() appends to the tail, the overflow marker is
incorrectly queued after the removed event, breaking monotonicity and the
terminal property of the removal event.

[ ... ]
> +ssize_t ctlv_event_file_read(struct ctlv_file *cfile, char __user *buf, =
size_t len, bool blocking)
> +{
[ ... ]
> +	while (!(rec =3D ctlv_event_queue_take(cfile))) {
> +		/* Drained, and the device is gone. */
> +		if (READ_ONCE(ctlvdev->dead_announced)) {
> +			ret =3D -ENODEV;
> +			goto out_unlock;
> +		}

[Severity: High]
Is there a race condition between the queue check and checking dead_announc=
ed?

The queue is checked locklessly (via ctlv_event_queue_take() returning NULL
and dropping the lock) before checking READ_ONCE(ctlvdev->dead_announced).

If ctlv_event_device_dead() runs exactly between these two checks, it will
queue the removed event and set dead_announced =3D true. The reader will th=
en
see dead_announced as true and return -ENODEV immediately, completely
missing the freshly queued terminal removed event. This race prevents
userspace from observing the final state of the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D10

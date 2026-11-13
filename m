Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587335;
	b=12TMupJx8+AUmzHvrlOjXoK2j+HRjuWkcu42Zn/sjKZDrhKJ2zEjEAFwBPH2oj7BkjgT
	 g7DIoNJY5ZJSJW8+jR+VU3lmRK1WrthCd6VBjzt4yismnWQvy9EnoL4rEfj0M0wyA5gWy
	 +BaRlj8cWr2j5T5lDQ2KKTdQulAtLRrg/BugQ1uHF67YGRDtr2iAi2Njuu3Llkf8cgMiR
	 b00C6C48ch5DbM48lGd4wuoL0y//7ClJ2go2x8Uqyxc9Qu+NfgxYNZ3XaOGWveYbDIz0o
	 UrUpG4tWc1nNOecEyOsa82KMTm02NG+NC01Wf7Z2KnrAJW4UuQvAZCUn1kzLugWl9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bqLPYEgtC/OaOWVQN5VtB/ybeQbbLIeU9NIU5AKPVwk=;
	b=SbSapHlFMqXX6Z0rs6GNsX25Z4K01JSQWQtmKIEhv7R7zwcPZhk4k1K0xPPv/3th8skQ
	 VwJLmPq9wekAdrDax/LiGcbh+A9GQfOXRqQkZ8uXYjZ13Mb4rYoGpnXHVdHL6JHn2gBOn
	 ZDgGzNj4JTkNi5RikQZRnlwLxqA0LB1Als1xLnJeQr6srfOL8KI8kbkwXdFrt2R8Brbfd
	 wLyfqgfgTx5G/hOlqq5gwgRG62Z63RFUw4iejhzxtMVjsOzexk89Ab4xBkyQrTkDYF1EX
	 Eku/gZeq91TcGAkW3SsOCN+RkYonEPota0s8xTGHROGk5FvbiXH4NmudmOKLqlp6cwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoVWeW93;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72519606A327
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoVWeW93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039FA1F000C4;
	Fri, 13 Nov 2026 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587335;
	bh=bqLPYEgtC/OaOWVQN5VtB/ybeQbbLIeU9NIU5AKPVwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoVWeW93JeeqhOpJEN8AYiJzIIvUjkzzXiA5vF5m/y6vAkOVUEkPbGCqkxpIp4tfP
	 LW8y/gPF5aDBSjKCzEejigwoDSA7HEHojX2WsPmCBba6zJRVxbyV3RvbnuOpXPEdfu
	 acTCJMNg/B72ftgfQOCG1RC+d+7+ORUsCnHFyLUosNnABXg94SXyIWqCFbUeTIuFy7
	 sknd2KjBsvwHgkN0MLu9WK4kL0QwogXeSJg5O7+r8mEKUwJZbJmH+Gib5Hnv2Il2z6
	 ZKeTF7rek5/Txn3U5Gt2CcktA54sbTnED8vecdpT5cAVfBDDVHq5uTjCWP8e5zvnOi
	 4YXGewuDgld0Q==
Message-ID: <sashiko-outbox-213194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 14/15] tools/ctlv: Add the userspace library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-15-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-15-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:28:54 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Medium] tools/ctlv: missing ctlv_hdr_is_record() check in record
  walkers and getters
- [Low] tools/ctlv: ctlv_put_str() bypasses sticky msg->err on length
  overflow
- [Low] tools/ctlv: memory leak in ctlv_msg_new_max() when
  ctlv_record_start() fails
- [Low] tools/ctlv: unpopulated ctlv_error in ctlv_spec_check() and
  ctlv_query_sized()
- [Low] tools/ctlv: stale bound and truncation of reason in
  ctlv_error_parse()
- [Low] tools/ctlv: missing progress check on final fragment in
  ctlv_query_guard_next()
- [Low] tools/ctlv: missing -ESTALE retry loop in ctlv_ops_get()
--

commit 128e9e8121ea589172c7fc1358fcc6d31f685bab
Author: Jiri Pirko <jiri@resnulli.us>

tools/ctlv: Add the userspace library

This commit adds the libctlv userspace library for transport, message
building and parsing, device discovery, and schema checking, along with
the userspace code generator in ctlvgen.

> diff --git a/tools/ctlv/libctlv/introspection.c b/tools/ctlv/libctlv/intr=
ospection.c
> new file mode 100644
> index 0000000000000..1bd2662e58317
> --- /dev/null
> +++ b/tools/ctlv/libctlv/introspection.c
[ ... ]
> +int ctlv_ops_get(struct ctlv_dev *dev, struct ctlv_ops **opsp,
> +		 struct ctlv_error *error)
> +{
> +	struct ctlv_reply *reply =3D NULL;
> +	int ret;
> +
> +	/* Sized, or the dump kept for op lengths would ask for itself. */
> +	ret =3D ctlv_query_sized(dev, CTLV_OP_OP_GET, NULL, 0, &reply, error);
> +	if (ret)
> +		return ret;

[Severity: Low]
Should ctlv_ops_get() retry up to QUERY_RESTARTS times on -ESTALE like
ctlv_query() does?

Because ctlv_ops_get() calls ctlv_query_sized() directly to avoid
recursing into ctlv_dev_sizes(), a dynamic op state change between
fragments of an op-get dump causes ctlv_ops_get(), ctlv_dev_sizes(), and
ctlv_spec_check() to fail with -ESTALE instead of restarting the dump.

[ ... ]

> diff --git a/tools/ctlv/libctlv/message.c b/tools/ctlv/libctlv/message.c
> new file mode 100644
> index 0000000000000..ab4464fb8af2d
> --- /dev/null
> +++ b/tools/ctlv/libctlv/message.c
[ ... ]
> +int ctlv_msg_new_max(__u32 capacity, __u32 max, struct ctlv_msg **msgp)
> +{
> +	struct ctlv_msg *msg;
> +
> +	if (!capacity || capacity > max)
> +		return -EINVAL;
> +	msg =3D calloc(1, sizeof(*msg));
> +	if (!msg)
> +		return -ENOMEM;
> +	/* Separate from the handle, so growing the buffer does not move it. */
> +	msg->buf =3D malloc(capacity);
> +	if (!msg->buf) {
> +		free(msg);
> +		return -ENOMEM;
> +	}
> +	msg->capacity =3D capacity;
> +	msg->max =3D max;
> +	*msgp =3D msg;
> +	return ctlv_record_start(msg, CTLV_TYPE_ROOT);
> +}

[Severity: Low]
Does ctlv_msg_new_max() leak msg and msg->buf if ctlv_record_start()
fails?

When capacity is smaller than sizeof(struct ctlv_hdr) (16 bytes),
ctlv_record_start() has to grow msg->buf; if max < 16 or realloc() fails,
ctlv_msg_new_max() returns a negative errno with *msgp pointing to the
allocated struct, which callers such as reply_new() do not free on error.

[ ... ]

> +/* The terminator is part of the payload, and a declared length excludes=
 it. */
> +int ctlv_put_str(struct ctlv_msg *msg, __u64 type, const char *value)
> +{
> +	size_t len =3D strlen(value) + 1;
> +
> +	if (len > UINT32_MAX)
> +		return -EMSGSIZE;
> +	return ctlv_msg_put(msg, type, 0, value, len);
> +}

[Severity: Low]
Does the length overflow path in ctlv_put_str() bypass msg->err?

If len > UINT32_MAX, returning -EMSGSIZE directly neither preserves an
earlier msg->err nor records -EMSGSIZE in msg->err, so a caller checking
ctlv_msg_err() or ctlv_msg_done() at the end will miss the failure and
send an incomplete message.

[ ... ]

> +const struct ctlv_hdr *ctlv_hdr_first(const struct ctlv_hdr *record)
> +{
> +	if (record->len <=3D sizeof(*record))
> +		return NULL;
> +	/* A record too short to hold the header it announces holds no child. */
> +	if (record->len - sizeof(*record) < sizeof(*record))
> +		return NULL;
> +	return record + 1;
> +}
> +
> +/*
> + * The next child is a step of this one's aligned length. Both the step =
and the
> + * header it lands on have to stay inside the record.
> + */
> +const struct ctlv_hdr *ctlv_hdr_next(const struct ctlv_hdr *record,
> +				     const struct ctlv_hdr *child)
> +{
> +	const char *end =3D (const char *)record + record->len;
> +	const char *next =3D (const char *)child;
> +	__u32 step;
> +
> +	if (aligned(child->len, &step))
> +		return NULL;
> +	next +=3D step;
> +	if (next < (const char *)child || next > end)
> +		return NULL;
> +	if ((size_t)(end - next) < sizeof(*child))
> +		return NULL;
> +	return (const struct ctlv_hdr *)next;
> +}

[Severity: Medium]
Should ctlv_hdr_first(), ctlv_hdr_next(), and the generated record
getters verify ctlv_hdr_is_record()?

check_record() only validates nested TLV headers when CTLV_HDR_F_RECORD is
set, and the scalar getters reject records via ctlv_hdr_is_record(hdr),
but ctlv_hdr_first() and ctlv_hdr_next() walk any TLV whose len is at
least 32 bytes.  Generated record getters in
tools/ctlv/ctlvgen/lib/gen_user.py:_getter() also return ctlv_hdr_find()
without checking ctlv_hdr_is_record().

If a non-record TLV is passed to ctlv_hdr_first() or returned by a record
getter, its unvalidated payload bytes are interpreted as struct ctlv_hdr,
which can spin forever in ctlv_for_each() when the first 4 payload bytes
are zero (step =3D=3D 0) or read out of bounds when a child's len is smaller
than sizeof(struct ctlv_hdr).

[ ... ]

> diff --git a/tools/ctlv/libctlv/spec.c b/tools/ctlv/libctlv/spec.c
> new file mode 100644
> index 0000000000000..194966e29e2d8
> --- /dev/null
> +++ b/tools/ctlv/libctlv/spec.c
[ ... ]
> +int ctlv_spec_check(struct ctlv_dev *dev, const struct ctlv_family_spec =
*spec,
> +		    char *diff, size_t len, struct ctlv_error *error)
> +{
> +	struct ctlv_ops *ops;
> +	unsigned int i;
> +	int ret;
> +
> +	if (diff && len)
> +		*diff =3D '\0';
> +	ret =3D chain_check(dev, spec, diff, len);
> +	if (ret)
> +		return ret;
> +	ret =3D ctlv_ops_get(dev, &ops, error);
> +	if (ret)
> +		return ret;

[Severity: Low]
Does ctlv_spec_check() leave *error uninitialized or cleared with
error->err =3D=3D 0 on failure?

If chain_check() fails, *error is never initialized, and if a later check
fails with -ENOMSG (such as an unknown op, info_check(),
ctlv_schema_equal() in schema_check(), or required_ops_check()), error->err
remains 0 from ctlv_ops_get().  Similarly, in
tools/ctlv/libctlv/transport.c:ctlv_query_sized(), if reply_new() fails it
jumps to out_free_buf instead of out_set_err, leaving error->err as 0.

> diff --git a/tools/ctlv/libctlv/transport.c b/tools/ctlv/libctlv/transpor=
t.c
> new file mode 100644
> index 0000000000000..647bab085c9e1
> --- /dev/null
> +++ b/tools/ctlv/libctlv/transport.c
[ ... ]
> +	hdr =3D ctlv_hdr_find(root, CTLV_T_ERROR_INFO_REASON);
> +	if (hdr && !ctlv_get_enum(hdr, 1,
> +				  CTLV_VALIDATION_REASON_STALE_GENERATION,
> +				  &value, NULL)) {
> +		error->reason =3D value;
> +		error->present |=3D CTLV_ERROR_HAS_REASON;
> +	}

[Severity: Low]
Does ctlv_error_parse() ignore the enum bounds and truncate value into
error->reason?

ctlv_get_enum() only checks min and max when the known pointer is
non-NULL, so passing NULL accepts any 64-bit value (including 0 or values
above UINT32_MAX) and truncates it into the 32-bit error->reason field.
In addition, the upper bound passed here is
CTLV_VALIDATION_REASON_STALE_GENERATION (11) rather than
CTLV_VALIDATION_REASON_NONCONTIGUOUS_TYPE (12).

[ ... ]

> +int ctlv_query_guard_next(struct ctlv_query_guard *guard, __u64 cursor,
> +			  bool progress)
> +{
> +	unsigned int slot;
> +	int ret;
> +
> +	if (!cursor)
> +		return 0;
> +	if (!progress)
> +		return -EPROTO;

[Severity: Low]
Does returning early on !cursor skip the progress check for the final
fragment of a multi-fragment query?

When guard->cursors_count > 0 and the final continuation fragment ends
with cursor =3D=3D 0 without adding any complete TLV (progress =3D=3D false=
),
ctlv_query_guard_next() returns 0 instead of rejecting it with -EPROTO.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D14

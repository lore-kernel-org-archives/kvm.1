Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079053FD58
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078107; cv=none; b=g4H4+AhCiTrSO0A6qRWtbXRNmM710ArFW/0kqYgDEkVHgwR/m+dphSMgx4Hvq2X1RvVe9dp+ihg/m22Vv7XxnUzgXc7dYm1kjgdUl5UHamljnT/taZP1NZZigjHiOXju5AfZVC3LAl7FJZYq4nyfeTdHyi2smvM6imAWi2bZJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078107; c=relaxed/simple;
	bh=KS6Pwk7KoRhi0CQdEmKqlBKnBWncuZXGnmY1KMcRFkU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YOCrjqruqj4Gky9LC6xaJ8QPpkvn9vdzS9YkKPBHtYSaFnVLlIfT+r71CCpCqp5etO/SR8QmV5B5K3AQCbDk/caZPTOyKVwy7uOuUypWF+tOI4qvLu2xelq6XM/wNjFedGLZNWDmuc3qfJHBwJ2rPaSo3uePO+AOk39H6FHU6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIr5m3Cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIr5m3Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5771F000C5;
	Thu, 15 Oct 2026 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078100;
	bh=ykaU9E04r1F4eRk8jtqfFBn9Si2ARqxlauyVHGqqeYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIr5m3CwrLYUx4dje9v6nPt2aOSh0rF3lnbz4C9D9z3lDLw8NHuxx7SV7vhTspvTM
	 fW9JjTkS7HzCHhRyzqhlRJ0tOvsYjQ8Y8P6YqNCNRA+CKOf7TSRLJM+mEQsFgU316Z
	 POxFsRTRVc43fxFYMdhMZrw2fh/LVtgEkUwz+F+Fy5IAaLYkPWGyo0bTNVbckj1Iy/
	 LpEg2F3aPqvYxFeCVGvIheddGvA5VkJHl9ATet/40cHg/kkLGuSYD6ej0W1vqJIOyu
	 RRC1d2KHr8Z26dSXuppsCKHEy6NooM1MGQIq58L2bo+hfp/aeGvJgaaFUsbJrxibvS
	 IRmm0GY8xKPxQ==
Message-ID: <sashiko-outbox-173071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/20] ctlv: Add device and operation dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-13-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-13-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:28:20 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] ctlv: mixing goto-based error handling with scope-based cleanup (__=
free)
--

commit d40367eef6344eb381abe711a6b81ec26de22d13
Author: Jiri Pirko <jiri@nvidia.com>

    ctlv: Add device and operation dispatch
   =20
Register CTLV devices, resolve family chains and dispatch operations
through validated messages. Wire CONFIG_CTLV and the generated root family
after all module objects are present.

> diff --git a/drivers/ctlv/core.c b/drivers/ctlv/core.c
> new file mode 100644
> index 0000000000000..aeab29fe2fdd4
> --- /dev/null
> +++ b/drivers/ctlv/core.c

[ ... ]

> +static int ctlv_op_exec(struct ctlv_file *cfile, struct file *filp, stru=
ct ctlv_op_exec *exec,
> +			void **reply, u32 *reply_len)
> +{
> +	struct ctlv_device *ctlvdev =3D cfile->ctlvdev;
> +	const struct ctlv_op_entry *op;
> +	struct ctlv_op_ctx ctx =3D {};
> +	u32 capacity;
> +	int ret;

[ ... ]

> +	void *snapshot __free(kvfree) =3D NULL;
> +	void *out __free(kvfree) =3D NULL;
> +
> +	if (exec->request_len < sizeof(struct ctlv_attr) ||
> +	    exec->request_len > CTLV_MAX_INLINE_MESSAGE_LEN)
> +		return -EINVAL;
> +	/* Everything after this reads the snapshot, never userspace. */
> +	snapshot =3D kvmalloc(exec->request_len, GFP_KERNEL_ACCOUNT);
> +	if (!snapshot)
> +		return -ENOMEM;
> +	if (copy_from_user(snapshot, u64_to_user_ptr(exec->request), exec->requ=
est_len))
> +		return -EFAULT;
> +	/* Before any hook, so that no family code sees an unchecked attr. */
> +	ret =3D ctlv_request_validate(&ctx, exec, snapshot);
> +	if (ret)
> +		goto out_error_info;

[ ... ]

> +	/* Where the caller carries on from, zero for anything but a query. */
> +	exec->generation =3D ctx.frag.reported;
> +	exec->cursor =3D ctx.frag.next_cursor;
> +	*reply_len =3D ctx.output.root ? ctx.output.root->len : 0;
> +	*reply =3D no_free_ptr(out);
> +	ret =3D 0;
> +	goto out_request;
> +
> +out_error_info:
> +	ctlv_error_info(&ctx, exec->reply_len, reply, reply_len);
> +out_request:
> +	ctlv_message_index_free(&ctx.request);
> +	return ret;
> +}

[Severity: Low]
Does this mix scope-based cleanup (__free) with goto-based error handling?

The cleanup guidelines (include/linux/cleanup.h) state that functions
should either convert all resources to scope-based cleanup or convert none
of them, but never mix the two in the same function.

[ ... ]

> +struct ctlv_device *ctlv_create(struct device *parent_dev, const struct =
ctlv_family *family,
> +				const void *init_info)
> +{
> +	struct ctlv_device *ctlvdev;
> +	int devnum, ret;

[ ... ]

> +	ctlv_event_contexts_start(ctlvdev);
> +	ret =3D ctlv_family_privs_post_init(ctlvdev);
> +	if (ret)
> +		goto err_fini;
> +	scoped_guard(rwsem_write, &ctlvdev->registration_lock) {
> +		ret =3D ctlv_device_add(ctlvdev);
> +		if (!ret)
> +			ctlvdev->registered =3D true;
> +	}
> +	if (ret)
> +		goto err_fini;
> +	return ctlvdev;
> +
> +err_fini:
> +	ctlv_device_fini(ctlvdev);
> +err_put:
> +	put_device(&ctlvdev->dev);
> +	return ERR_PTR(ret);
> +err_free:
> +	bitmap_free(ctlvdev->disabled);
> +	ctlv_family_privs_free(ctlvdev);
> +	kfree(ctlvdev->ops);
> +	kfree(ctlvdev);
> +	return ERR_PTR(ret);
> +}

[Severity: Low]
Does this mix scoped_guard with goto-based error handling?

The kernel guidelines expect functions to avoid mixing goto error labels and
scope-based cleanup macros like scoped_guard.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D12

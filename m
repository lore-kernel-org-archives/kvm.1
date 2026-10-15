Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A653C3D0
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078817; cv=none; b=hPxI4RVT0BYv1E/rjhyQfwjW79iqGesKzbdzKmziMDbHjQup4I7keORdZOVA0ID4bZbWTalg7jmD1nowuv5kVuQnvmuyT6HgBu4QhTYrQteDvT38jlYs3dJiS+3+8C3OhybW55wn2hj0le3+x9MxaXnvSbE9b8dtKzpnV+Qm0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078817; c=relaxed/simple;
	bh=U0x5qGComEqoxJPg1lJBWhyztCQl4aHHh23VlssHXJ0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BDy3zl8ug/heYguzBNK3OheiQnqqlFoT6KkK7s6Hi+hUjs86K3aAUg5jfeXH/GyWXocTBwsNLzoZE19JjV8hDLZiS8DNaCZM9go4VeZGOJ4MDn9orzvHd7tMBq5hhkuJGMXCAO4O81TQxIfJM+FJb0/IjznFZYWc5kAduQfFZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUdho/+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUdho/+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB89A1F000C4;
	Thu, 15 Oct 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078805;
	bh=LjB3rBwvpsDJT5eagzhlywNPAJh2k3u6zKz/tAOQGXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUdho/+UnI+l4YBlSC0InaLJVCmw0J92OX1BeEG1/PaX+Pzb4zXVupyAEoLLGiu7h
	 H7I93N8F9/EcYOe8cnPAAIWIPPmQzsSbqPGfTx0VOg0oSBnLTD8jgnTLU29MERxErS
	 4+AKTx/ii7Q+/20ra09lnrdeHXNc5ZbK2Ig0FQVu8cVDoYz2ql5dW1OhMppijQVqib
	 L9iCfhFrdhctXS8keNvYPCnVZV2ifZ1iVCARxwzc/c0FPvBlq/flB85/EXGeMGZ/pd
	 F8UrLpa4v4eciglWiCideE6+9zLwRv5PzyldLLu1BxU6f3pkXqVvOEgIC1RhAVHpuB
	 I4SWY2aOh17Ow==
Message-ID: <sashiko-outbox-173083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 18/20] tdx-guest: Expose the native attestation
 service API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-19-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-19-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:40:05 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] tdx: client attach failure aborts core driver initialization
- [Low] tdx: memory bloat per TSM report due to missing right-sizing
- [Low] Unreachable return statements after scoped_cond_guard
--

commit b1dd6a27af0398a52344b35c7786c4b3fbbf85c3
Author: Jiri Pirko <jiri@resnulli.us>

tdx-guest: Expose the native attestation service API

This patch shares TDREPORT, Quote and measurement-register operations with =
one
in-kernel client while preserving the existing misc, TSM report and TSM
MR interfaces. It ties clients to service initialization and removal.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index d0303e31e8161..0d53170602463 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c

[ ... ]

> +static int tdx_do_report(sockptr_t data, sockptr_t tdreport)
> +{
> +	scoped_cond_guard(mutex_intr, return -EINTR, &mr_lock)
> +		return __tdx_do_report(data, tdreport);
>  	return 0;
>  }

[Severity: Low]
Is the trailing return 0 unreachable? When scoped_cond_guard is used with a
single return statement as its body, both the success and failure branches
return immediately. The loop's internal break is never reached, preventing
execution from falling through to the statements following the macro.

[ ... ]

> +static int tdx_guest_quote_get(struct device *dev, const u8 *reportdata,
> +			       size_t length, void *out, size_t capacity,
> +			       size_t *out_length)
> +{
> +	if (!tdx_guest_device_valid(dev))
> +		return -ENODEV;
> +	scoped_cond_guard(mutex_intr, return -EINTR, &quote_lock)
> +		return __tdx_guest_quote_get(reportdata, length, out,
> +					     capacity, out_length);
> +	return 0;
> +}

[Severity: Low]
Is this trailing return 0 also unreachable for the same reason as in
tdx_do_report()?

[ ... ]

> +static int tdx_report_new_locked(struct tsm_report *report, void *data)
> +{
> +	struct tsm_report_desc *desc =3D &report->desc;
> +	size_t length;
> +	void *buf;
> +	int ret;
> +
> +	buf =3D kvmalloc(TDX_QUOTE_MAX_LEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	ret =3D __tdx_guest_quote_get(desc->inblob, desc->inblob_len,
> +				    buf, TDX_QUOTE_MAX_LEN, &length);
> +	if (ret) {
> +		kvfree(buf);
> +		return ret;
> +	}
> +	report->outblob =3D buf;
> +	report->outblob_len =3D length;
> +	return 0;
> +}

[Severity: Low]
Does this code introduce persistent memory bloat for each TSM report?

The buffer is allocated at the maximum possible size of 128KB but is never
shrunk to the actual quote length returned in the length variable.

The previous implementation used kvmemdup() to size the buffer exactly to
the output length, which is typically much smaller than the 128KB maximum.
By leaving it at 128KB, could this increase the memory footprint for
concurrent reports?

[ ... ]

>  static int __init tdx_guest_init(void)
>  {
>  	int ret;

[ ... ]

>  	ret =3D tsm_report_register(&tdx_tsm_ops, NULL);
>  	if (ret)
>  		goto free_quote;
> +	scoped_guard(mutex, &client_lock) {
> +		tdx_service_ready =3D true;
> +		ret =3D tdx_guest_client_attach();
> +		if (ret)
> +			tdx_service_ready =3D false;
> +	}
> +	if (ret)
> +		goto unregister_tsm;
> =20
>  	return 0;
> =20
> +unregister_tsm:
> +	tsm_report_unregister(&tdx_tsm_ops);

[Severity: High]
Does a failure to attach a client here abort the entire core driver
initialization?

If a built-in client registers before tdx_guest_init() runs, a failure in
the client's add() callback will cause tdx_guest_client_attach() to fail.
This error is returned, causing a jump to unregister_tsm, which aborts the
initialization of the TDX guest driver and breaks other frontends like the
misc ioctl and configfs.

If the client is loaded after the driver, its failure does not affect the
core driver. Should the core provider ignore an optional downstream client's
failure and continue its initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D18

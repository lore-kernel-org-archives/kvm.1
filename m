Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E3381EA8
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077644; cv=none; b=T53m4JbuaSbLW9XH/Kb+vWZZE7W7DFhNGcKIhOT+yi9fVt5NYf2vStFfs7l6bNIvIBbz64Ad6dWX//DBQ/1rqSI7dgsZNCmUlTXn09ft0WOWXMuVxlpBavl6YCrONbS0PLxDcmZws73V0AKoWC3JU8LNgyiuEJ443u+zUdHWsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077644; c=relaxed/simple;
	bh=BaoK5Lw7c8dnJEei27SzI9DwgxbjtWxmtvzR6HqTG9s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s4QBnTAP8sPFU1yJHkuYBOjBvhEeCLp+gNk4WSt4tV5epEXzBzMQtxi5sqBE6pgm3azg/zXh7+cGGNEai5goZh4x40GVBWlKDLg0Hf1uOJBuzYq4gpQnTR02vs64cZXgGMChcVvey5YEqRej8IlG/hUZzzKmZ/F3libc48Wrp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3rn/i5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3rn/i5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F91E1F000C6;
	Thu, 15 Oct 2026 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077634;
	bh=MI/gzJqc0mQEGBsxHoiTXp5dn2VPptJQx/jujECyadY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3rn/i5lX8ecu9u90Shx7udrL998xbN11m6hJeaF80mTXeF2qMw6LJefwmLk0+PYd
	 /nU9mtDCia++nBiA+5GCHDga8l3H6Em2wnHNQ4+RNsSTLHDKrhFB3ns9Jvxo5vgZjT
	 zC1U8oWYNSHrejH5nQSdIBgS5Y74edf1uzNnG9B2qJaKkWNH2Q1LlMPmf3pDPJZtTO
	 9KLvIXToWUQuhpPvkF2atffkOUlY4wE44PNebZDiw15l69A6zXAXDIMTm5VvKBabPw
	 HWBGmpHChuEJnQt1rd7h5TC0Vdm+efo9awGtlm8C/DqXdnYZzfBHXpshValTUcB6Z5
	 +YqNrrlTV5NIw==
Message-ID: <sashiko-outbox-173053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/20] Documentation: ctlv: Describe how to write a
 family
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-14-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-14-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:20:32 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] docs: Incorrect function ctlv_op_emit() in ctlv.rst example
- [Low] docs: Incorrect generated family descriptor name in ctlv.rst example
--

commit 44307a0d2c96bec6fed10bf4f0610aa2e3baf41c
Author: Jiri Pirko <jiri@resnulli.us>

Documentation: ctlv: Describe how to write a family

Describe the YAML language, generated family descriptors, lifecycle,
operations, events, blobs, inheritance and compatible extension rules.

> diff --git a/Documentation/driver-api/ctlv.rst b/Documentation/driver-api=
/ctlv.rst
> new file mode 100644
> index 0000000000000..461e2977a4839
> --- /dev/null
> +++ b/Documentation/driver-api/ctlv.rst

[ ... ]

> +    struct ctlv_example_vendor_init_info info =3D {
> +            .dev =3D dev,
> +    };
> +    struct ctlv_device *ctlvdev;
> +
> +    ctlvdev =3D ctlv_create(dev, &ctlv_example_vendor_ctlv_family, &info=
);

[Severity: Low]
Does this code use the correct generated family descriptor name? Based on t=
he
YAML family name ctlv-example-vendor, the expected generated C struct name
would be ctlv_example_vendor_family. It seems the _ctlv part is improperly
inserted here.

> +    if (IS_ERR(ctlvdev))

[ ... ]

> +    if (IS_ERR(ctx)) {
> +            if (PTR_ERR(ctx) =3D=3D -ENOMEM)
> +                    ctlv_event_lost(ctlvdev,
> +                                    CTLV_EXAMPLE_OP_THING_HAPPENED);
> +            return;
> +    }
> +    ctlv_example_generation_put(event, priv->generation);
> +    ctlv_op_emit(ctx);

[Severity: Low]
Is ctlv_op_emit() the correct API call here? Earlier in the documentation,
event emission is shown using ctlv_event_emit(). Using an incorrect API
name here could lead to compile-time errors for driver authors attempting to
follow the guide.

> +
> +ctlv_event_lost() allocates nothing and does not sleep. For each subscri=
bed
> +file description it advances the event sequence and aggregates the loss =
into
> +the preallocated EVENT_OVERFLOW record. The caller keeps the device alive
> +and serializes the report with normal emission of that event. Like event
> +emission, it is not called from interrupt context. It is only for an eve=
nt that
> +actually occurred but could not be constructed: do not call it for an ab=
orted
> +event or for copy-allocation and full-queue drops already accounted for =
by
> +ctlv_op_emit(). Reports after event shutdown or the terminal

[Severity: Low]
Should this text reference ctlv_event_emit() instead of the non-existent
ctlv_op_emit() function?

> +DEVICE_REMOVED record are ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D13

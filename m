Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D402C0261
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183291; cv=none; b=hTfWe/H3DY3xkxemaRbisfvmxL+k8aEe1vgiDCIT7ZxkDP0N+We9F8I8n/J9fr3jMoX3MrE97AUewG9c28MGlgsrzMXmhBt9H5dlEZ2dXiMGKlTAGuYvLc6TolOFUp7NXHhMqeBR2kqrUSyL8KZtQxuZ6QtaFV1bfDsSTbjQih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183291; c=relaxed/simple;
	bh=75JXIHVrT2h7SWxJjSVXRLU3O+7LSxzATUOTi1Z9Tew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=byP4PxB5SF5Ue/SGpQFsVCMrj8Ek8nRZwkB0LytYNMku36iXUe1FJzLtMD6vsLIy2n4FsFhSXFuWNndP4RYxbTFzea87L/0pM02CdfBcCrYEJG2gcXFXaY/vIBQnOJoRSlhk5i3cMm+ur1KM4/IgrXP/H4W6dJDnDS412cNWPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3pX70Y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3pX70Y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B371F00A3A;
	Sat,  8 Aug 2026 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786183289;
	bh=Q23ycuIdImCRICb9R+JA4BNEgUg6Tw0B+T8/A/nQwM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X3pX70Y8mUNfhPLiwfcLm8bg9i9mdbz1u0LoeIRroz44vCwj10us8baY9DksbtZck
	 0CqNi526TYvu304JqMnl/OaY2k+nsbLxZNhCl7SPjG16PVCm2jqS32okEK+jXOU9zx
	 2wNXAjgEDDPmRKfFbJw0SC/eI2wcZmwsUr6nmh/Wm7b9u1JKKz93O0l3z9sQRN6TvW
	 h6IAq3SJAs3ghiblNxhhPlBnDBwagUrSA86tHpvRIOEfnS1qI9nXjVo3Ng3Bz1/LoQ
	 LZUwbSPZCtzGQe+hEYjKTe9BqgSrMT0guwn5UxIOBg7REdudz2lbpONY8CnGBZ2JNG
	 NEAN3xNeoVj5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vhost-vdpa: protect config_ctx from being freed
 under the config callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <yuz08559@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807100025.19750-3-yuz08559@gmail.com>
References: <20260807100025.19750-1-yuz08559@gmail.com>
 <20260807100025.19750-3-yuz08559@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 10:01:28 +0000
Message-Id: <20260808100129.52B371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An identical Use-After-Free pattern to the one fixed for `v->c=
onfig_ctx` exists unpatched for `vq->call_ctx.ctx` in the virtqueue interru=
pt path.
--

--- Patch [2]: [PATCH 2/2] vhost-vdpa: protect config_ctx from being freed =
under the config callback ---
commit 8e0bc317868b822a05e8a68785677223512b3be4
Author: Yu Zhang <yuz08559@gmail.com>

vhost-vdpa: protect config_ctx from being freed under the config callback

This commit fixes a use-after-free by adding a spinlock to serialize access=
es
to config_ctx in the config callback against its replacement in the
VHOST_VDPA_SET_CONFIG_CALL ioctl.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ae137d5be99c9..cae8089ab3ddf 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -194,10 +196,12 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void *pr=
ivate)

[Severity: Critical]
This is a pre-existing issue, but does an identical use-after-free pattern
exist for vq->call_ctx.ctx in the virtqueue interrupt path?

It appears vhost_vdpa_virtqueue_cb() reads and signals vq->call_ctx.ctx
locklessly:

drivers/vhost/vdpa.c:vhost_vdpa_virtqueue_cb() {
    struct eventfd_ctx *call_ctx =3D vq->call_ctx.ctx;
   =20
    if (call_ctx)
        eventfd_signal(call_ctx);
}

Could this race with VHOST_SET_VRING_CALL in vhost_vring_ioctl(), which
swaps out vq->call_ctx.ctx and immediately frees the old context?

drivers/vhost/vhost.c:vhost_vring_ioctl() {
    swap(ctx, vq->call_ctx.ctx);
    ...
    if (!IS_ERR_OR_NULL(ctx))
        eventfd_ctx_put(ctx);
}

If a userspace process with access to /dev/vduse concurrently invokes
VDUSE_VQ_INJECT_IRQ while VHOST_SET_VRING_CALL is executing, could
vduse_vq_signal_irqfd() end up calling eventfd_signal() on freed memory
since it uses the cached vq->cb.trigger?

drivers/vdpa/vdpa_user/vduse_dev.c:vduse_vq_signal_irqfd() {
    if (vq->ready && vq->cb.trigger) {
        eventfd_signal(vq->cb.trigger);
        signal =3D true;
    }
}

>  static irqreturn_t vhost_vdpa_config_cb(void *private)
>  {
>  	struct vhost_vdpa *v =3D private;
> -	struct eventfd_ctx *config_ctx =3D v->config_ctx;
> +	unsigned long flags;
> =20
> -	if (config_ctx)
> -		eventfd_signal(config_ctx);
> +	spin_lock_irqsave(&v->config_lock, flags);
> +	if (v->config_ctx)
> +		eventfd_signal(v->config_ctx);
> +	spin_unlock_irqrestore(&v->config_lock, flags);
> =20
>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807100025.1975=
0-1-yuz08559@gmail.com?part=3D2

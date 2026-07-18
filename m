Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305AC2080C1
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338199; cv=none; b=qts0aXN65jjW8UGiGLQVbwcBlcw69PXtdyT6DDwYhHomgvrYHQgfR42Juf2xV+v65v5kqKInWi0laGuaSMQ6GSj2nyOsvza6llJSm1PpFk2T5UU42ANtwxf8YH5Lvd1idJp0VShlKU/bz7NVc1knzH2jYeimNXQIi5x6BJbzzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338199; c=relaxed/simple;
	bh=xTcBrCQ0VcXsHWsTm7qhV7ayhNLIIQejrXLK4KlWY5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kZH+QXkGYuOACCUa1BLAnCSeYUONWhZGIX/iK/0X1BLECZJUnqMFUp6pCYR/zVwXFIeocLF6/ragrarGXOtEwjE/xTQkK6+ADJ35Xql5RCbzn7P4MDsQ5BEdL4Q+s5a0SMh7XPM1GlSCXU8VNfqvByvPXtU1TpgI+mtjx4QwZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmSmMpAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmSmMpAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A184E1F000E9;
	Sat, 18 Jul 2026 01:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338197;
	bh=MX9/q0LLTHBGr51iGlIAf263oExGzxdBxWm4IZBCGoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FmSmMpAPRbCW8Kmi8HkZPuB47fsMzAZjblD10+SJ0izskjvQ8DPfxzkdbBW64Lb6Z
	 E6BvcRpv7KfN6hO3VYQUYL2Pzns22bzHh7kfsjoZhGgxmzlbVjhT4l5X9OazJxINgI
	 Y0+H6DgxbNVHuaR7xEGVuGUbCOl/qgVUDdUheBLpU587dHambM9sPoH8HQpU1kdG+J
	 T4sI0xwKHAFdzTF3fcg5FBGmG9BRRXj3rO6odCwdfz7Sh/g7kPBilzRT0LfmzxMsDP
	 XPlIwN8SBs/OLFVWMjHSstMN4U3kFtToqelTtk29mRDkR+aAlKHbK2J5xhFpwVKg4v
	 fUVlAOrexJZfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost: reject zero-size IOTLB INVALIDATE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260717012921.oyTkqBgRqNTWiMgAtjVgcCUBT2oIiZ3D44ekHl_MujM@z>
References: <20260716030236.124322-1-xiongwm2026@163.com>
 <20260717012921.oyTkqBgRqNTWiMgAtjVgcCUBT2oIiZ3D44ekHl_MujM@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 01:29:57 +0000
Message-Id: <20260718012957.A184E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing integer overflow check in VHOST_IOTLB_INVALIDATE cause=
s failed unmaps and stale DMA mappings.
- [High] Unconditional access to `dev->vqs[0]` can cause a NULL pointer der=
eference / page fault if a device has 0 virtqueues.
--

--- Patch [1]: [PATCH v2] vhost: reject zero-size IOTLB INVALIDATE ---
commit d375f3ebf8dae4831fa1035718b913506e8ff8fd
Author: xiongweimin <xiongweimin@kylinos.cn>
Subject: vhost: reject zero-size IOTLB INVALIDATE

This patch modifies vhost_chr_write_iter to reject VHOST_IOTLB_INVALIDATE
messages with a size of 0. This prevents the end address calculation
from underflowing and incorrectly deleting the entire IOTLB.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1692,8 +1692,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		offset =3D offsetof(struct vhost_msg, iotlb) - sizeof(int);
>  		break;
>  	case VHOST_IOTLB_MSG_V2:
>  		if (vhost_backend_has_feature(dev->vqs[0],

[Severity: High]
This is a pre-existing issue, but can this code crash if the device was
created with 0 virtqueues?

If a vDPA or VDUSE device is registered with 0 virtqueues, dev->vqs is
allocated using kmalloc_objs, returning a zero size pointer. When userspace
writes a VHOST_IOTLB_MSG_V2 message, this code unconditionally accesses
dev->vqs[0] to check backend features.

Dereferencing this pointer causes a kernel panic. Is it possible we need to
check if dev->nvqs > 0 before accessing dev->vqs[0] here?

>  					      VHOST_BACKEND_F_IOTLB_ASID)) {
>  			ret =3D copy_from_iter(&asid, sizeof(asid), from);

[ ... ]

> @@ -1716,7 +1716,8 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		goto done;
>  	}
> =20
> -	if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
> +	if ((msg.type =3D=3D VHOST_IOTLB_UPDATE ||
> +	     msg.type =3D=3D VHOST_IOTLB_INVALIDATE) && !msg.size) {

[Severity: Critical]
This is a pre-existing issue, but does this size validation fully protect
against integer overflow in the invalidate path?

If userspace sends a VHOST_IOTLB_INVALIDATE message with msg.iova =3D 2 and=
 a
msg.size large enough to wrap around the 64-bit integer limit,=20
msg.iova + msg.size - 1 will overflow to 0 in vhost_process_iotlb_msg().

This inverted range is then passed to vhost_iotlb_del_range():

drivers/vhost/iotlb.c:vhost_iotlb_del_range() {
        ...
        while ((map =3D vhost_iotlb_itree_iter_first(&iotlb->root,
                                                   start, last)))
}

Since start (2) > last (0), the interval tree search silently fails to
delete the mappings, leaving stale DMA mappings in the vhost IOTLB intact.

Should we also check if msg.size + msg.iova overflows?

>  		ret =3D -EINVAL;
>  		goto done;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717012921.oyTk=
qBgRqNTWiMgAtjVgcCUBT2oIiZ3D44ekHl_MujM@z?part=3D1

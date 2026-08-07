Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ACE3A75A3
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115052; cv=none; b=ON5z1cEaVVNzP+MGLue2B8+WdSzNLJU5xZnHxznBzb14NgqTm+9BCGCCIc/G6JFlsxqZd9XAmAMQPueyg+E7HEHkOsjMHyce6ttL7uE2Zm0V9ulXbC698sU+mC2AHD6S+sLZ0p+200/q3sPqLOpV9Ma3clhiJFK3V6CZMtveyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115052; c=relaxed/simple;
	bh=XORUXVrXy2IWv6womdKf0WdZYBybmhCIfOg+fCfV+cM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJhmAOKW6SbgU7ypRASvWm1+roKiAaa6TW2XxUS9yAksx/eUA4unGGgpkr5oeA73dVjyXVY1kefaIXftrGLwQl6OY8gRcuP3QqT9pvx8WvqCb/VUlzFo+NjVshKO7gYA9R523yhtsrL1O7ROwOBsHAa13CEct4yodmGDf4zKzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNmom2UG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNmom2UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F5B1F00A3E;
	Fri,  7 Aug 2026 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115045;
	bh=glDgBPYMChSxewJU93EZoOkXwBmHrKi5a7W5J2d81Uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DNmom2UGEdUQLheByGfJ+FFbzQ4qqSz0/xeWSy/YJWLx5tARNBDehAzgQD0NLUh+b
	 Rp00V3mzwGcnb6cC6IvVOlnPCh4++RQFNuD5maM2T9+0C44lQ5wYJA2wjDxilLLne3
	 d8NKsgV/X5jYC/B0+nJoJJhrmvDZXX2X6xYFJYoraGfC4EEhZxdva/WQh+VdnVrERI
	 jAHHKfWkRff+/n6DyCPkStb3IInVlvyq/4GwtAA7b2DIxR9lT1ZUmoP3BylGeXPU6e
	 nSWVzdrOZW3QAX03NtPTelz6ZQWOtipqLB03O7bXQJ36kWUsIkXkv507GSP22j+Ijt
	 6gjiT5JpPKjlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-vdpa: drop the parent's vq callback before the
 call fd is released
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <yuz08559@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806150323.2154-1-yuz08559@gmail.com>
References: <20260806150323.2154-1-yuz08559@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:04:04 +0000
Message-Id: <20260807150405.53F5B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Torn read causing NULL pointer dereference and incomplete UAF =
fix for hardware VDPA drivers.
--

--- Patch [1]: [PATCH] vhost-vdpa: drop the parent's vq callback before the=
 call fd is released ---
commit 59fc02f21fdc99bd2ce2389a383eab4badff2c47
Author: Yu Zhang <yuz08559@gmail.com>

vhost-vdpa: drop the parent's vq callback before the call fd is released

This commit clears the vdpa callback pointers before vhost_vring_ioctl()
releases the eventfd to prevent a use-after-free regression with VDUSE. It
aims to ensure the parent driver drops references to the callback context
before it is destroyed.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index c3d913bd7cac7..63ffa94bb4793 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -721,13 +721,34 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdp=
a *v, unsigned int cmd,
>  			if (ops->get_status(vdpa) &
>  			    VIRTIO_CONFIG_S_DRIVER_OK)
>  				vhost_vdpa_unsetup_vq_irq(v, idx);
> +			/*
> +			 * The parent caches call_ctx.ctx in cb.trigger without
> +			 * holding a reference, so it has to stop using it
> +			 * before vhost_vring_ioctl() drops the last one.
> +			 */
> +			cb.callback =3D NULL;
> +			cb.private =3D NULL;
> +			cb.trigger =3D NULL;
> +			ops->set_vq_cb(vdpa, idx, &cb);

[Severity: Critical]
Can this non-atomic update cause a NULL pointer dereference for hardware
drivers?

For hardware drivers like vp_vdpa, the interrupt handler reads the callback
struct without locks. If a concurrent interrupt occurs during ops->set_vq_c=
b(),
could it read a torn state where it sees the old valid cb.callback but the
new NULL cb.private?

drivers/vdpa/virtio_pci/vp_vdpa.c:vp_vdpa_vq_handler() {
    ...
	if (vring->cb.callback)
		return vring->cb.callback(vring->cb.private);
    ...
}

If this happens, it would call vhost_vdpa_virtqueue_cb() with a NULL pointe=
r,
causing a panic when attempting to dereference it.

Additionally, since there is no synchronize_irq() here, could an
already-executing hardware interrupt handler still race with the subsequent
vhost_vring_ioctl() freeing the eventfd, leaving the original use-after-free
unfixed for hardware drivers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806150323.2154=
-1-yuz08559@gmail.com?part=3D1

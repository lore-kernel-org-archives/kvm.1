Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C723BD25E
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786271676; cv=none; b=hcuCy7qtnJo+9sIwTB9iFr1gLteKtxnK+2lQoAKUjl6X9Y8wow39FD+aCXpNY5uHMXXi8UiNtmFHLAAL26Inc719YBMRlW+YeYjPq07RSOxgCKeKDGefcAvHTcBS7WjxqAp3bzzgCkr4rkAn02yM77sykj1ko5vz4pck6yzZFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786271676; c=relaxed/simple;
	bh=pcvtC5HOdSOFsn76cOoN1rm+vZ4O726YttQBHUHOC1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tkLpLmc2HxIAOKto2nbuBvZLDCOcTNVNVserEMrMYDELeigzrcn+Ti0Gj/E5/89sk7Ydx4SIL7GA5aG8SXRQ4EhcGI3bETfrzUcEiiWn2kRTrMreYq4UMAP7t7/D2d7ANpUG+Rh4nWoeGabOubCOjUelaFTEF/zwIW4Q21VQtrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZsh+UHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZsh+UHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470FC1F000E9;
	Sun,  9 Aug 2026 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786271674;
	bh=f0lF+x7MqaOqGc8t4MhwOar1YhzJFvA9pbbC7O22h2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZsh+UHkhxC1REDawF4j73vyieh5wcN6RFZ1Wq6kTewM5E9dN+o60RpikoQ9yyH8t
	 y5A9cXQtyfOZUdU3cGQ8erZ5CKGETX2nv13JUyt6ta/44lHo2qV9VdnmNIXa84sgXG
	 YqXfJvToihHWvdZKxyMEfkyY/tXhSMNHrv510Oq4DTriKtWzqzJ6Pk/jkuao/CqRT8
	 pxqykWh/DO7tkvKaZU2GVHxqcpYZ84gjdnPLiccWEG6UjdL7JHN8H4xDdtFKC3smPR
	 8mQwDQmMxSU6w9cKr9/IvU5A+1ktbB0cqhCCMNP4D7LphRjE2+Sb/lV6UCLy5f6gwW
	 oui2ZjMaxwrBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260808103415.101261-1-physicalmtea@gmail.com>
References: <20260808103415.101261-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 10:34:33 +0000
Message-Id: <20260809103434.470FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added validation for VHOST_SET_VRING_NUM introduces a Ti=
me-of-Check to Time-of-Use (TOCTOU) vulnerability due to a double fetch fro=
m user memory, which completely bypasses the security fix.

Pre-existing issues:
- [High] The virtqueue index (`idx`) is fetched from userspace twice, allow=
ing concurrent modification to desynchronize the vhost core and vDPA backen=
d states.
--

--- Patch [1]: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max =
---
commit a17536b4ee293947d6ce500193f7ea4d0e4cae10
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vdpa: reject VRING_NUM larger than device max

vhost_vring_set_num() only requires a non-zero power-of-two that fits
in 16 bits. This patch adds a check in vhost_vdpa_vring_ioctl() to
reject requested queue sizes larger than get_vq_num_max() before calling
vhost_vring_ioctl().

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -723,6 +723,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa=
 *v, unsigned int cmd,
>  				vhost_vdpa_unsetup_vq_irq(v, idx);
>  		}
>  		break;
> +	case VHOST_SET_VRING_NUM:
> +		/* Reject sizes above the max reported by the device. */
> +		if (copy_from_user(&s, argp, sizeof(s)))
> +			return -EFAULT;
> +		if (s.num > ops->get_vq_num_max(vdpa))
> +			return -EINVAL;
> +		break;

[Severity: High]
Does this validation introduce a time-of-check to time-of-use vulnerability?

The requested size is fetched and validated here in vhost_vdpa_vring_ioctl(=
),
but the subsequent call to vhost_vring_ioctl() ultimately delegates to
vhost_vring_set_num(), which fetches the same struct from userspace a second
time:

drivers/vhost/vhost.c:vhost_vring_set_num() {
    ...
    if (copy_from_user(&s, argp, sizeof s))
    ...
    vq->num =3D s.num;
}

Since a concurrent thread could modify the userspace memory between the two
fetches, could this second fetch overwrite the validated size with an
excessively large value? If so, this unvalidated value would then be passed
to ops->set_vq_num() and completely bypass the security fix.

>  	}
> =20
>  	r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);

[Severity: High]
This is a pre-existing issue, but I noticed a potential state mismatch betw=
een
the vhost core and the vDPA backend.

The virtqueue index is initially fetched at the top of vhost_vdpa_vring_ioc=
tl():

drivers/vhost/vdpa.c:vhost_vdpa_vring_ioctl() {
    ...
    r =3D get_user(idx, (u32 __user *)argp);
    ...
    vq =3D &v->vqs[idx];
    ...
}

However, the call to vhost_vring_ioctl() performs a second fetch for the in=
dex:

drivers/vhost/vhost.c:vhost_vring_ioctl() {
    ...
    r =3D vhost_get_vq_from_user(d, argp, &vq, &idx);
    ...
}

If a concurrent thread modifies the index in userspace between these two
fetches, could the vhost core end up updating a different queue than the one
vhost_vdpa_vring_ioctl() originally resolved? This might cause the vDPA
backend configuration (applied later in this function using the original
unverified vq and idx) to become desynchronized from the vhost core state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808103415.1012=
61-1-physicalmtea@gmail.com?part=3D1

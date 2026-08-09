Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75FF347FCD
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786274720; cv=none; b=uUjndq+Zg0g2pehoAo6bgi8gv+Wwvjoj3harOslSDwH4WQwHEKq3+LomL4dhBoBQqwFYRcd3NzXNQbVxfLs+lyQoVNrI3KOwl2KL0Y0Fo8F9IylbWAI45Fs2bahIk2vA3Cq+UtjP9DQSN8dUxsyHmv2AouDbXrp47wLDzOypSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786274720; c=relaxed/simple;
	bh=7vna+EMnPrZifh51+jB07m2GAHVqI+DCUtOoQJ08+cU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piOpCGSr+9YZvTpOkd1K+AwFbUJ7du6z72LK7pVDlOPAD5Q09I7hXvjy5VcMccnDbv2QebhgpobUOB4gnqAYJXjLxpr56hn0csAylUIJ7LQzx77jaI/NUJADE5kbnolGsD83q5S0INaM23LbwY7hQjhlREysYIgzZiyqUtiK47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmmBu1zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmmBu1zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C351F000E9;
	Sun,  9 Aug 2026 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786274719;
	bh=xzFqb/HQJ3ddOuwzzgFoI3D4N/lt1ozHujNG0z8s4tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kmmBu1zmQLpiLbiELxQO121LZdSZexupvjPkCLCGNXF4O7ArvM2nCOQqV/jLdaRlt
	 5TNlrnhsoA4/C5vga/+vHXYApMAEfwEJSIqoxeQti8iO4QH/QIJy9byyT4eR6t4zk6
	 5lkJqkgY02RYaGsoo7EQlWC1ER5MuxF147LBVbD6FjSVTQOxxbTXcbXQbFyhLM03ev
	 n9YNR5yOg67wJN9aIjWvzC4dpU1xy63+kQRNbzw2GjXC1XPNBPQHzT1AMo3IFZ4lVA
	 tI9pEnRLC+n7FqIDss+OAdQqpH1v2ujCn+5hh6zLbyvy1jPco031yfslDVTQB/iPK7
	 MQeak18co8ccA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost/vdpa: reject VRING_NUM larger than device max
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260808112458.101616-1-physicalmtea@gmail.com>
References: <20260808112458.101616-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 11:25:18 +0000
Message-Id: <20260809112519.49C351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added validation for VHOST_SET_VRING_NUM suffers from a =
double-fetch Time-of-Check to Time-of-Use (TOCTOU) vulnerability, which com=
pletely bypasses the intended security fix.
--

--- Patch [1]: [PATCH v2] vhost/vdpa: reject VRING_NUM larger than device m=
ax ---
commit 321003a29055f06433bde7512f4893c5f9acf2a6
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vdpa: reject VRING_NUM larger than device max

This commit adds a bounds check on the requested virtual queue size in
vhost_vdpa_vring_ioctl() to prevent an out-of-bounds read in the backend.
It returns -EINVAL if the requested size is larger than the device's
maximum reported value.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index c3d913bd7cac7..36fc049a4eaf6 100644
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
Does this introduce a double-fetch time-of-check to time-of-use vulnerabili=
ty?

The size is checked here using copy_from_user(), but the same user space
pointer (argp) is fetched a second time later in the call chain.

After this check, vhost_vdpa_vring_ioctl() calls vhost_vring_ioctl() which
passes the same pointer down:

vhost_vring_ioctl() {
        ...
        if (ioctl =3D=3D VHOST_SET_VRING_NUM ||
            ioctl =3D=3D VHOST_SET_VRING_ADDR) {
                return vhost_vring_set_num_addr(d, vq, ioctl, argp);
        }
        ...
}

This calls into vhost_vring_set_num() and performs a second fetch from argp:

vhost_vring_set_num() {
        if (copy_from_user(&s, argp, sizeof s))
                return -EFAULT;

        if (!s.num || s.num > 0xffff || (s.num & (s.num - 1)))
                return -EINVAL;
        vq->num =3D s.num;
}

If a malicious user space thread modifies the memory at argp between the fi=
rst
and second fetches, it can bypass the get_vq_num_max() check.=20

The inflated vq->num is then pushed to the backend via ops->set_vq_num(),
which appears to trigger the exact out-of-bounds read this patch aims to fi=
x.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808112458.1016=
16-1-physicalmtea@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C9314B8C
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536794; cv=none; b=ccqqQaEO3k6U6OGcV16v96wWaLXmUNnC+Oj+qQohwDK2Aa/uOhp6XKuSLiopPN2FM9oiofvus9n/MJCnKtBlFBDegGyqBp+UUtiJdv5XJVBgciyC+35y83YJ4+zgmijEIXSt/LgpZ6G4CZeODd7O3o7b0GqmfakwdGinzKzFrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536794; c=relaxed/simple;
	bh=UN1xhyxEFzlOGbSiJFwIjbJOa/4+vvmh8cYOC1us/cY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2qgOWoy+XyrTS/TIsTLPJt+KwBAf/ssGExh3f/hqV+P+Zsue3WtX3fSPCiJGEhzpe0lukTPNNyIrkymmJSF9X8udRpFAaImXDPbI7SGx03XtqSJPRVg3PaKqZ+hgx1cKhgTPz3j+XSoY0TJADFgkFTGYF0fbaQiZRQwmbxroro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvKkxteA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvKkxteA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DE01F00AC4;
	Fri, 31 Jul 2026 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536793;
	bh=TYkd98ICkDzHBf1/Tnd7upsGMwj06r3rJxk41xRdafY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvKkxteAXQ4k79oCfMLpmfnIf9/SHt1ZhyVXDap2A8xl1s0vj0wATk5aFl0HD0uQX
	 RVD55b/SReG/sD//SzzGL6pgkafWrQPpTjhW5lCIjm3Th6Af1Q1dfeLl1PJ5BiAQ9n
	 MYb4r3QAX3KYhKEYLTsLjYf40oeb408gjzjVbnEOpHX1SVObPdvwOql8tn4KBP3dTj
	 Wmzw+IAOGbGvZ8ZWhy8XS/V3lOSx+heyQx94ZBQr+pEIAh8gH1dJKPxp7vmVTuTYLr
	 X7uug3Ak4JI/Rj5F4HjGJs4zPTtvwIjdcKy9svg691DFiUESm48JOTSGmHq8AW1yJf
	 fE1CeXEGXQgzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongli Zhang" <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731221116.236791-3-dongli.zhang@oracle.com>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:26:32 +0000
Message-Id: <20260731222633.15DE01F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing READ_ONCE() on module parameter allows compiler remateri=
alization, leading to TOCTOU array out-of-bounds access.
--

--- Patch [2]: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module par=
ameter ---
commit 93f3d55f364233d31773cdb70b64bd78dafbf480
Author: Dongli Zhang <dongli.zhang@oracle.com>

vhost-scsi: reject invalid max_io_vqs module parameter

This commit shifts the validation of the max_io_vqs module parameter from
device open time to when the parameter is written. It removes the
bounds-checking code from vhost_scsi_open() and uses a module parameter
callback to reject invalid sysfs writes instead.

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 0c0634eea1443..c138c29ce3dd4 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
[ ... ]
> @@ -2273,22 +2286,14 @@ static int vhost_scsi_open(struct inode *inode, s=
truct file *f)
>  	struct vhost_scsi_virtqueue *svq;
>  	struct vhost_scsi *vs;
>  	struct vhost_virtqueue **vqs;
> -	int r =3D -ENOMEM, i, nvqs =3D vhost_scsi_max_io_vqs;
> +	int r =3D -ENOMEM, i, nvqs;
> =20
>  	vs =3D kvzalloc_obj(*vs);
>  	if (!vs)
>  		goto err_vs;
>  	vs->inline_sg_cnt =3D vhost_scsi_inline_sg_cnt;
> =20
> -	if (nvqs > VHOST_SCSI_MAX_IO_VQ) {
> -		pr_err("Invalid max_io_vqs of %d. Using %d.\n", nvqs,
> -		       VHOST_SCSI_MAX_IO_VQ);
> -		nvqs =3D VHOST_SCSI_MAX_IO_VQ;
> -	} else if (nvqs =3D=3D 0) {
> -		pr_err("Invalid max_io_vqs of %d. Using 1.\n", nvqs);
> -		nvqs =3D 1;
> -	}
> -	nvqs +=3D VHOST_SCSI_VQ_IO;
> +	nvqs =3D vhost_scsi_max_io_vqs + VHOST_SCSI_VQ_IO;

[Severity: Medium]
Since vhost_scsi_max_io_vqs is modifiable via sysfs (0644 permissions), cou=
ld
the compiler rematerialize nvqs by reloading the global variable from memory
multiple times in this function?

Without a READ_ONCE(), the compiler is permitted to reload
vhost_scsi_max_io_vqs instead of spilling nvqs to the stack across the
subsequent kmalloc_objs() and kvzalloc_objs() calls. If a concurrent sysfs
write occurs, the reloaded values can differ.

Could this cause the array allocation sizes to be smaller than the nvqs
value used in the subsequent initialization loop, resulting in an
out-of-bounds access?

For example, if the compiler decides to reload the variable:

vs->old_inflight =3D kmalloc_objs(*vs->old_inflight, nvqs, ...);
// ...
vs->vqs =3D kvzalloc_objs(*vs->vqs, nvqs);
// ...
for (i =3D VHOST_SCSI_VQ_IO; i < nvqs; i++) {
        svq =3D &vs->vqs[i];

Previously, the complex bounds-checking block likely prevented the compiler
from reloading the variable, but with the check removed, the value is read
directly. Should READ_ONCE(vhost_scsi_max_io_vqs) be used here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731221116.2367=
91-1-dongli.zhang@oracle.com?part=3D2

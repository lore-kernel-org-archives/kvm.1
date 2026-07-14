Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3F8CA45
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043053; cv=none; b=spykyO6HOg19Gsy2uQZZgoSrw6aY9g6QVP52WQjn/O91+OLGuNbzLIZv7vrR38M2naZc2vFDt8MUlk4iW4PvV24gR+MsL/nHbpqakmttQNUtHbUfhPpVcDYlFgUgPiOo2wrwS9QGiU8AYuWGbOGnNJY+Ufm3gVEWSkygkdt9GrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043053; c=relaxed/simple;
	bh=RA2oTiFd8UzYFNCISO0LTqQ4BvNt6d1c4o4kOlhvUDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dc7AKJxRZ8sHnfJy1ufYRytTHoPvhxav3dCA8RWOUPNmz/RuyzZRU+bRcwrXBUr8jboZ8dp+3sdDeJOU0OPJbqnsOsshogE4RfwctXzwIXM0OEwZchwhJCep4ZraToIWam6DWMaLOYeHzD70Fm3L3pa025eTLwtAqm+TZ/UpJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHZqCCuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHZqCCuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBCD1F00A3A;
	Tue, 14 Jul 2026 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043052;
	bh=jukwJ9U6TcO84Cgr8qJTfFx6AcXAF9CgJoqWGPrHTbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHZqCCuhBA+tQ24dNNr31G6MlftI8naAiw6H3WmBIsy8xzRTHS1Z7BImMh4sOclZX
	 mquehPqg2k6jQZTrU70oYYK76GyWwApV62oogYhFq+nTEJsh31HP6I+UjTFLwrftaf
	 2VZNkg546b6nDv6x4r0CiXttxsT8sJhKkQ9100D27COwo7TYOa5RyVxmSneMiXK/Ry
	 KxJtL51/8eTRMaSAYuno5jDDRXaobBS+bjbmc6fEIRDc/4TZO1EVyS20drUbfwouUE
	 7cWUFwhXCBKhxBzKTt0HlKPZeR+QXogME61xlMMr7769sAo64lTkLr+vYpgJ2YryBE
	 +1yhDaiO7dk2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/20] vfio: Export various helpers from VFIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-3-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-3-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:30:51 +0000
Message-Id: <20260714153051.DDBCD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing EXPORT_SYMBOL_GPL for vfio_pci_ops, violating the stated in=
tent to export the variable for other modules.
--

--- Patch [2]: [PATCH v5 02/20] vfio: Export various helpers from VFIO ---
commit fcee4889ab47813a22592eb00c453edea425e0f0
Author: Vipin Sharma <vipinsh@google.com>

vfio: Export various helpers from VFIO

This commit makes several vfio helpers and the vfio_pci_ops variable global=
ly
visible by removing their static declarations and adding them to headers. T=
he
stated intent is to export these symbols for use by other modules, such as
the upcoming live update feature.

> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b84..1fb4b276afe7c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *c=
ore_vdev)
>  	return 0;
>  }
> =20
> -static const struct vfio_device_ops vfio_pci_ops =3D {
> +const struct vfio_device_ops vfio_pci_ops =3D {
>  	.name		=3D "vfio-pci",

[Severity: Low]
The commit message states the intent is to "Export these functions and
variable for other modules to use them", but is there a missing
EXPORT_SYMBOL_GPL(vfio_pci_ops) here?

The other helpers modified in this patch received an EXPORT_SYMBOL_GPL() ta=
g,
but vfio_pci_ops did not. Without it, external modules attempting to refere=
nce
vfio_pci_ops will fail with unresolved symbol errors during the build.

>  	.init		=3D vfio_pci_core_init_dev,
>  	.release	=3D vfio_pci_core_release_dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87C4C4F66
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847909; cv=none; b=b4/smU3+nTs6fo5LBtRpSad8mOBBsAXzsvrxVQVBBPzJ0BP8H0j/e6Hk/9wcj5t6hkHYmOurLMfsJgNzIOn7YOq2nLA2hUZAhce+lRpCEMPu+NS9rfLDvsj3e1WYC6sNhBjG0i4fTpD2PxZ4/Ug+jBZ9zN96JETjFQOdJ+3NEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847909; c=relaxed/simple;
	bh=y+Nrt5siqlsrdAw9F5eJDeY2nzrjaSMm0R5/AAo9KTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tibOra2FpjcOMyoOFY6NuRWcw/IksAFKdYZ3sXJTa3VvXmigqjPeWfqcOvRrn4vlwaGz/YMtE3DjTtRAnKj6cePkMshTDsoWInUmPtVBdT6TPGQXeuE9iAAL2wnd8Z3vu4+wJxODHKsp4sj3+gPWOHTRny+D/o2Q+BZdoaDulDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7hTd3JJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7hTd3JJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BAF1F000FF;
	Thu,  1 Oct 2026 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847907;
	bh=83xWObvpsjGlf5gFaA/C8N2wbi8J3uUkatO3edRAiAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7hTd3JJSAkl5wHUcTlvlwF6Wd9vQUvuW7rrpRHeeHd3+t82y9Z2C+km947ODo4KT
	 FejW+0JYhc9F6iteOc8Hmt3W9oxXwkGYcyBDX/1ZmO0SHR3j4gUrRxWXEVshvVxu28
	 Lyvhg6sgzH//2v5rVbVbgrv5sIpvFQdxYe9xnc4WNgOieTwXyEHgIDnpd3o3l0oJ9q
	 TWA+hh4pL6HKKmxgShhtrf7aZx7gZ3/Nf+nARNuryt1RsFeHXHn0yFpoX2w3P8xevo
	 DTeltPKPuqk9b7pRBhqmWeiohctzloVf4YsHffKeY9+Dzue9FLNAWxhX4PlnE3DzzJ
	 SpqJyAClBZNQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio: cdev: Reject duplicate bind before updating KVM
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001093152.1698474-1-aneesh.kumar@kernel.org>
References: <20261001093152.1698474-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:45:07 +0000
Message-Id: <20261001094507.B2BAF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio: UAPI breakage returning -EINVAL instead of -EBUSY on duplica=
te bind
--

commit c22368f571a5e2ac9cc22bf312688fe247d99cd9
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

vfio: cdev: Reject duplicate bind before updating KVM file

This commit prevents a second file descriptor for the same device from
overwriting the KVM reference. It does this by checking device->open_count
earlier during the bind operation.

> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index 30362936c7b59..0f23ccb780e05 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -124,8 +124,8 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_fi=
le *df,
>  		return ret;
> =20
>  	mutex_lock(&device->dev_set->lock);
> -	/* one device cannot be bound twice */
> -	if (df->access_granted) {
> +	/* The cdev path only supports one bound/open device fd. */
> +	if (df->access_granted || device->open_count) {
>  		ret =3D -EINVAL;
>  		goto out_unlock;
>  	}

[Severity: High]
Does this change unintentionally alter the UAPI by returning -EINVAL instead
of -EBUSY when device->open_count is non-zero?

Further down in drivers/vfio/device_cdev.c:vfio_df_ioctl_bind_iommufd(),
there is an explicit check intended to handle transient opens:

	if (device->open_count) {
		ret =3D -EBUSY;
		goto out_unlock;
	}

By checking device->open_count in the first conditional block and returning
-EINVAL, the second block returning -EBUSY becomes dead code. Will this
cause applications relying on -EBUSY to trigger a retry to fail unexpectedl=
y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001093152.1698=
474-1-aneesh.kumar@kernel.org?part=3D1

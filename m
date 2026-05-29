Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19A29430
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073348; cv=none; b=QS6eq249W6ibEdjrm2P3A055enO3H/qN2Yu8XrpEjdqjG6eEmM/Afs88xIZQBc2+rIqLe5OgUF4f8o81txEY+78EsYxmusK33aYWkUFadRRSt4P2orxv1faIbosTv09SaWJtRI8vMQqk7tQ8iTH4yOc+G32AROitgRxh778kqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073348; c=relaxed/simple;
	bh=+bIJ+/rEO9U60bcxSsx3G27wsT9POSoVwsVOI+/jnRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c57yPvXZA5Ho4WTXUvoXxb8qmiNb57cUMzNpbaydmpXgevBI4cuajAd6qO/O2Fj9gQKSnKcI3jI+r1XyHbXUiXoorQADAWoaxRfE/0B9h9ge4VpmXhYUZq0mq6FljG30Iywt3/JUWtEtnc8F5ybWwQu9SBKIpjnVXZDrQ0zNgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCkrcBR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCkrcBR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ACF1F00893;
	Fri, 29 May 2026 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073346;
	bh=62bKI3b+EhrHtQndI8BORpaxaYHABoyhq+J1p1kin6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCkrcBR0jyi3TJWi33BzApuLoclgkyIDVcl+OCCe4OZtHYwo2SzI0YXRlxTj0KeNK
	 GgKtW4hGFTpjFOsuGJtbdyk1rxHpiKWeDJfB2JnqKcflnixoDw+zGG5T6OK1W/dley
	 inHpKMxfeF/wSPHj74M9hWGBbQ6vIRZKM1vif5TJyuHbFg0+ToV8oz1+eXZ1HGb+wt
	 b/gmM+zFzAEhPs1ToAFv145K1IJevFELwwyYZQiOi5luUDmkTBiq5UWFYN3BXnQkCP
	 idubyLXzW0zxyXM17Hg0HP+40LpIPNB4Xy0SAcRGWo+7VudjwdLWD7JwEy2mV+5368
	 jdHG8m0IZpDkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/27] VFIO: take reference to the KVM module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-2-seiden@linux.ibm.com>
References: <20260529155050.2902245-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:49:05 +0000
Message-Id: <20260529164906.73ACF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional KVM reference overwrite and subsequent premature rel=
ease in the VFIO cdev bind error path.
--

commit 0e9c12cfda2c8eedbfdfe11e2a9a3b8ef09209f4
Author: Paolo Bonzini <pbonzini@redhat.com>

VFIO: take reference to the KVM module

VFIO implicitly took a reference to the KVM module via symbol_get and
symbol_put. In preparation for removing these, this patch stores a pointer
to the KVM module and uses module_get()/module_put() to keep KVM alive.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 6222376ab6ab5..78b9cad348b19 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
[ ... ]
> @@ -490,6 +496,8 @@ void vfio_device_put_kvm(struct vfio_device *device)
> =20
>  clear:
>  	device->kvm =3D NULL;
> +	module_put(device->kvm_module);
> +	device->kvm_module =3D NULL;
>  }
>  #endif

[Severity: High]
This isn't a bug introduced by this patch, but does this change exacerbate
a bug in the cdev bind error path by adding a module_put() underflow?

In vfio_df_ioctl_bind_iommufd(), if a second bind attempt is made on an
already-open device via a new file descriptor, the code unconditionally
calls vfio_df_get_kvm_safe() before checking device->open_count:

	vfio_df_get_kvm_safe(df);

	ret =3D vfio_df_open(df);
	if (ret)
		goto out_put_kvm;

If the new descriptor's kvm is populated, vfio_device_get_kvm_safe() blindly
overwrites device->kvm and device->kvm_module, leaking the prior references
held by the first valid bind.

If the new descriptor's kvm is NULL, vfio_device_get_kvm_safe() returns ear=
ly,
leaving device->kvm still pointing to the first descriptor's KVM.

Then vfio_df_open() predictably fails with -EINVAL because
device->open_count !=3D 0, and the error path jumps to out_put_kvm:

out_put_kvm:
	vfio_device_put_kvm(device);

This drops the KVM references and clears device->kvm to NULL. This destroys
the KVM association for the initially bound, actively running process, and
could lead to a use-after-free of KVM structures.

By adding module_put(device->kvm_module) to vfio_device_put_kvm(), does this
also cause a module reference underflow for the actively running process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D1

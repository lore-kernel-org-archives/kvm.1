Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B7371897
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065999; cv=none; b=fk790TciR52F77ooF2zOoXvj9A39nsfxQYU2oMXFNZRDbL8YoK5Hu6sKzpaVnEAOIkeGZNm6jp4+GVPzm6UQbMdyPmM4eexxX1eWcAZ3X7IR4c3t5abEVcXyvaRURZBxPrtu60c80BD8uCtVYZl4EtKDRsb9Y7SChH5HOUwBFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065999; c=relaxed/simple;
	bh=XBvTgYkHQGQikmkCFq+yFieQdafJKe/R7LgycZNfw6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/JY30jhORwPPzVqQM49PS0/to2NqCM4qQmLkx/EHL6nZLTlehHYzmW4mxNN0taochCC44LPo+duZXIGceLaH+JLNx+CvZqdOUaJNQKlMKkeGg29kWJ4z39XD2phPniJoBhuOBYi43lgfFA5LOX0/TgjLnEoX4iSGRbyxAT9MI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvgqLkWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvgqLkWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13621F00A3A;
	Fri,  3 Jul 2026 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065998;
	bh=/2eHOip+MvrkTMtjAMA7r3qJ6i14UFKq7P+pkACDROA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvgqLkWEnfTSy8zzZcIkvn87mRGLGOVAgiLhmXKl0YEAMrszhZPhkC+k0fhUNdYV/
	 s9BmmuWxcZvxidJdZBNtAaBwYqMrvJfLot5Z37Smlj7OjrixOg/C1mX1VUxfFX/f5u
	 Il9xLyaEvGFaK2AtQC5wacUyfekhT0AeeZw7HJeLQZWPCDxuFbEcYx6yN1EE1h9q0G
	 sb4nfQNuGoyy6JnwHb6hTx/7JgKmZpZxLN05eqpMtp3AljeWsSImpHEFor3Om3qf01
	 Pji9HlA0LanFALJw481VPfhY9PLKhRuJV1l9GeoBaRxJ8HI+ujtnjHY48wKzjdabTB
	 Df3Tv/W1kQQlA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/6] selftests/vfio: allow selecting IOMMU backend
 from environment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703032806.40946-2-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:06:37 +0000
Message-Id: <20260703080637.E13621F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] A syntax error is introduced at the end of the file due to stray du=
plicated code.
- [Low] The macro `MODE_VFIO_SPAPR_TCE_V2_IOMMU` is referenced but never de=
fined, breaking the build on PowerPC.
--

commit 711defe4ecc8034b88efefbbf07a52494153b474
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

selftests/vfio: allow selecting IOMMU backend from environment
   =20
This commit adds support for selecting the IOMMU mode through the
VFIO_SELFTESTS_IOMMU_MODE environment variable. It validates the environment
variable against a list of supported modes, including sPAPR TCE v2 on Power=
PC.

> diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/s=
elftests/vfio/lib/libvfio.c
> index 3a3d1ed635c1d..617c8dc7288ca 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.c
> +++ b/tools/testing/selftests/vfio/lib/libvfio.c

[ ... ]

> @@ -101,3 +101,42 @@ void *mmap_reserve(size_t size, size_t align, size_t=
 offset)
> =20
>  	return map_align;
>  }
> +
> +static const char *get_iommu_mode_env(void)
> +{
> +	const char *mode;
> +	static const char * const valid_modes[] =3D {
> +		MODE_VFIO_TYPE1_IOMMU,
> +		MODE_VFIO_TYPE1V2_IOMMU,
> +		MODE_IOMMUFD_COMPAT_TYPE1,
> +		MODE_IOMMUFD_COMPAT_TYPE1V2,
> +		MODE_IOMMUFD,
> +#ifdef __powerpc__
> +		MODE_VFIO_SPAPR_TCE_V2_IOMMU,

[Severity: Low]
Does this break the build on PowerPC because MODE_VFIO_SPAPR_TCE_V2_IOMMU is
referenced but never defined?

I notice this is fixed in a later commit
8dfc3e7df9b7153c07746fbc4679447d70174937 ("selftests/vfio: add sPAPR TCE v2
IOMMU mode"), but introducing an undefined identifier here will cause git
bisect failures for PowerPC builds.

> +#endif
> +	};

[ ... ]

> +const char *vfio_selftests_get_iommu_mode(void)
> +{
> +	return get_iommu_mode_env();
> +}
> +
> +	return map_align;
> +}

[Severity: Low]
Is this stray return statement and closing brace a copy-paste error?

It causes a syntax error at the file scope. I see this is removed in a later
commit 2deeaa397a1d09614f068ff5ae82a0732c573cd4 ("selftests/vfio: add sPAPR
TCE v2 DMA window helpers"), but having it in this patch breaks the build
and git bisect.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703032806.4094=
6-1-nnmlinux@linux.ibm.com?part=3D1

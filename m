Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741743;
	b=g5kF4FJxmDUtnVImiaXlIjtD0Fh2Jc+HYSKH/hloV2lHto32w+lguliWvVR7XZI7iZen
	 rBa7vqDsF/4U7j3iF5SJhokYJ3CDdOoagSdX5kE2CNKDCQrGB4dxdF4nX8T+J56aPVeLt
	 gSGRf5+zoUPduEraue9Ajv2WdpDZuYljSsHsLwcnZQg0b9aEVtU98JD016DkGwLVsTgkh
	 G8ftIODOad8kUoDjUpPp9ClH8wEippSwIKAHRfoVa1MPGSoUqb3CSoPgMhucujrvPvB+l
	 zWp+QCkDzWHWAiC+VL1LthXi5BA7WRCNW6m3RLND73yEvle4tsBLlNutmCJXnlrvsxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MkUZ4vqORvB7eJJfz766hR4tJ14+qTxynK70uLJ97fM=;
	b=AQIoOoZPT5n9epr2OqFChoz3T8PdG3xC49ORpKXXKpK6gyTEwHbivYYy857UCT/yfXGq
	 6vgTFgMgSBKDxb5w6spOuylYWvoMcVrub+lD74wWzNu0TLweoZT0k0m5K9PqLzz1JNi+2
	 wmsFJxxlE2Vb/hKczQVij1HoE5igXCyE1v3n6x4iaYBE83oQemhCU5a4iff9hZpA4cUOq
	 btXn1EwLTJ+mE3US8pbbQSUUF9BwW+xX1QOlogBHqj4SRc2bMI2XMIpOnZtnuVE++1Wg8
	 YJg51rVfqJk746CiLYXKuiW7ixY8LsoeWvWP4upXuWWxD0ui4zAWATscJgKrXbObRsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYbUzfgg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19C60A2606
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYbUzfgg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C771F01828;
	Fri, 23 Oct 2026 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741742;
	bh=MkUZ4vqORvB7eJJfz766hR4tJ14+qTxynK70uLJ97fM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYbUzfggYC4S4xEdxRCSLjGw6nQCh9MiyuxTA9Uv7rmcfdgNnZqKXGIVI5IBZSykO
	 Fgl6hhr4gZDiVxY55lFAAZfWApkQ/UnCqUw+ylGYDastLaeONhP+8DR7oGlvVj4tpD
	 x4221XEEoGwGAwtrpCzMV1zYQpamJXVptms6Y4p7DVjYPLPkptZCaJg1aRg4253IOg
	 sPCwc1gdvWzGMSf2u/XBsHoiMtedPo/i+gD967fwHEeEwSX6LXTDBLmCYycU3scE1n
	 Yvrru1LkinYXiZFTfVmLpgh2UZw2a3BSKN4E4jJU93n2HERvT/ToX6/g7m2+b0eH96
	 a9bae7HE4rJNA==
Message-ID: <sashiko-outbox-182440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] powerpc/pseries/eeh: Add RTAS error injection
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261023073642.59657-3-nnmlinux@linux.ibm.com>
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:49:02 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] powerpc/pseries/eeh: static RTAS helpers defined without callers
--

commit 8b171281b038661dc89a614c1b95db68271706f4
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

powerpc/pseries/eeh: Add RTAS error injection helpers

This patch adds static RTAS error injection helper functions,
pseries_eeh_type_to_rtas() and validate_addr_mask_in_pe(), to prepare
the pSeries EEH backend for RTAS-based error injection.

Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@int=
el.com/

> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/=
platforms/pseries/eeh_pseries.c
> index b12ef382fec70..28b1fd19e8bcd 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c

[ ... ]

> @@ -786,6 +789,137 @@ static int pseries_notify_resume(struct eeh_dev *ed=
ev)
>  }
>  #endif
> =20
> +/*
> + * RTAS firmware error-type encodings (PAPR).  These are pseries-private;
> + * user-space sees only the generic EEH_ERR_TYPE_* values from eeh.h.
> + * Only IOA bus-error types are supported; other PAPR encodings are not
> + * reachable through the generic EEH_ERR_TYPE_* UAPI.
> + */
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR		0x07
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64		0x0f
> +
> +/* Size of the ibm,errinjct work buffer as defined by PAPR */
> +#define RTAS_ERRINJCT_BUF_SIZE			SZ_1K
> +
> +/**
> + * pseries_eeh_type_to_rtas - Map generic EEH error type to RTAS encoding
> + * @type: generic EEH error type (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64)
> + *
> + * Translates the generic VFIO/EEH error type passed from userspace into
> + * the RTAS-specific ibm,errinjct error type encoding defined by PAPR.
> + *
> + * Return: RTAS error type on success, -EINVAL for unknown types.
> + */
> +static int pseries_eeh_type_to_rtas(int type)
> +{
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR;
> +	case EEH_ERR_TYPE_64:
> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * validate_addr_mask_in_pe - Validate addr against PCI bus BAR addresse=
s in PE
> + * @pe:   EEH PE containing one or more PCI devices
> + * @addr: PCI bus address to validate
> + * @mask: address mask (passed to firmware unchanged)
> + *
> + * RTAS IOA bus-error injection uses PCI bus addresses.  Linux PCI resou=
rces
> + * are CPU/resource addresses and may differ on pseries due to PHB window
> + * translation.  Convert each BAR resource to PCI bus address space befo=
re
> + * validating @addr.
> + *
> + * Zero addr and mask are accepted without BAR lookup (no-address inject=
ion).
> + *
> + * Return: 0 if valid, -EINVAL on invalid input.
> + */
> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long add=
r,
> +				    unsigned long mask)

[Severity: Low]
Does defining pseries_eeh_type_to_rtas() and validate_addr_mask_in_pe() in
arch/powerpc/platforms/pseries/eeh_pseries.c without callers or
__maybe_unused cause a -Werror=3Dunused-function build failure at this comm=
it?

The commit message notes that validate_errinjct_args() and
prepare_errinjct_buffer() were deferred to the next patch ("powerpc/pseries=
/eeh:
Implement RTAS-based EEH error injection") and that pseries_eeh_err_inject()
retains its existing MMIO body here so each intermediate commit builds
cleanly with CONFIG_WERROR:

arch/powerpc/platforms/pseries/eeh_pseries.c:pseries_eeh_err_inject() {
	struct	eeh_dev	*pdev;

	/* Check on PCI error type */
	if (type !=3D EEH_ERR_TYPE_32 && type !=3D EEH_ERR_TYPE_64)
		return -EINVAL;
    ...
}

However, those deferred functions and the updated pseries_eeh_err_inject() =
are
the only callers of pseries_eeh_type_to_rtas() and validate_addr_mask_in_pe=
().
When building with CONFIG_PPC_PSERIES=3Dy and CONFIG_PPC_WERROR=3Dy (in
arch/powerpc/Kbuild) or CONFIG_WERROR=3Dy (in scripts/Makefile.warn), won't
this commit fail to compile with -Werror=3Dunused-function until the follow=
-up
patch adds their callers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023073642.5965=
7-1-nnmlinux@linux.ibm.com?part=3D2

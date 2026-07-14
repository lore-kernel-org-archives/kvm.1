Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999549550D
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042939; cv=none; b=A3Siim6sQl21TZoBR50TW0nlv0Dkp9sNGGYrn7CCsxU+n4FbzY1XMCprOKh4Gcn1CP2uNMzcvG0yZja3J1scs9tXg+OFlybzd/WFwc87jkd+fEx4irCdFcInnBLWpuIZScvCDpGBFSgEnHihCxnsqsnqH7THryB8fZZqI0pWfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042939; c=relaxed/simple;
	bh=xq0rdaiucULbOkYKU3MdRSQtYxyexZsuaftUnRhx0ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rrMpW457aB7jsw6+tpKvi0u29W1ZDyVox1MDAjo1rVtLZPo/20poP9q1k70AivAaRD9WERznb7GY0DTOCMVgGbEHNG1HA+8/ft1w4xuU/qMNngKdkxV27RGbhNfXw7I+YG7aslQEZncrWK9uVrEAsG3nDFzG4mV97S7MKwcA6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYzhQDXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYzhQDXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F239E1F000E9;
	Tue, 14 Jul 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042937;
	bh=phfNF8gOeOzrtim/4hJv9zmv6CkRx3MEZtuf9d/xaoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYzhQDXu1r6i/yajRia61J7TQQwIbNjCv/zAnNApdooK6o7FMRVLdCN0/pNONEneL
	 n773Czi9hee+wFeY3SWTRGHzGHEGRfvWDZ42ur1kAmvdWB1T+M4LmLwrmezAZ1kjyM
	 CFAVOkkz3V4ukx0/w2dFMC9v0/xKwJWWH8I+qRybx3JGCeZS7qkHyzx4Nz+FUrEYz9
	 20idUvc/gRvGdSUHtl9aDu4hw4JytiRS4LMlmNDfmd5CYDJMwdULyU5pKRUY8X14E+
	 8E//bgp9kIaAdb6sQD0NUFrCh9KbnqroY/eD6tT70UjT52SnrUV/LL8rIWgH2LbAQd
	 WpqB2pXsM64vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/20] vfio/pci: Register a file handler with Live
 Update Orchestrator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-6-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-6-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:28:56 +0000
Message-Id: <20260714152856.F239E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The Kconfig option VFIO_PCI_LIVEUPDATE depends on a non-existent c=
onfiguration symbol PCI_LIVEUPDATE.
- [High] Calls to undeclared and undefined functions pci_liveupdate_registe=
r_flb() and pci_liveupdate_unregister_flb().
- [High] Masking -EOPNOTSUPP on FLB registration failure leads to a double =
unregistration of the file handler and potential kernel panic.
--

--- Patch [5]: [PATCH v5 05/20] vfio/pci: Register a file handler with Live=
 Update Orchestrator ---
commit a3c1a8c69f4b2c27d2e063cca84eb003906e3bbf
Author: Vipin Sharma <vipinsh@google.com>

vfio/pci: Register a file handler with Live Update Orchestrator

This commit adds a live update file handler for vfio-pci device files
with stub implementations. It registers the handler with the live update
framework and PCI subsystem, gated behind a new VFIO_PCI_LIVEUPDATE option.

> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 296bf01e185ec..c12d614fc6c4a 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
[ ... ]
> @@ -42,6 +42,18 @@ config VFIO_PCI_IGD
>  	  and LPC bridge config space.
> =20
>  	  To enable Intel IGD assignment through vfio-pci, say Y.
> +
> +config VFIO_PCI_LIVEUPDATE
> +	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> +	depends on PCI_LIVEUPDATE

[Severity: High]
Does the PCI_LIVEUPDATE configuration symbol exist anywhere in the kernel
tree? It appears this dependency cannot be met, preventing the new
VFIO_PCI_LIVEUPDATE option from being selected.

> +	help
> +	  Support for preserving devices bound to vfio-pci across a Live
[ ... ]
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vf=
io_pci_liveupdate.c
> new file mode 100644
> index 0000000000000..803528c9f1b27
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
[ ... ]
> +int __init vfio_pci_liveupdate_init(void)
> +{
> +	int ret;
> +
> +	ret =3D liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		goto err_return;
> +
> +	ret =3D pci_liveupdate_register_flb(&vfio_pci_liveupdate_fh);

[Severity: High]
Are pci_liveupdate_register_flb() and pci_liveupdate_unregister_flb()
declared in any header or defined in any source file? Building with
this configuration enabled might result in implicit declaration compiler
errors and fatal linker errors.

> +	if (ret)
> +		goto err_unregister;
> +
> +	return 0;
> +
> +err_unregister:
> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +err_return:
> +	return (ret =3D=3D -EOPNOTSUPP) ? 0 : ret;

[Severity: High]
If pci_liveupdate_register_flb() returns -EOPNOTSUPP, this error path
unregisters the file handler but returns 0. Could this lead to a double
unregistration when the module is unloaded and vfio_pci_liveupdate_cleanup()
is called?

Calling liveupdate_unregister_file_handler() a second time on the already
removed list node might cause list corruption and a kernel panic.

> +}
> +
> +void vfio_pci_liveupdate_cleanup(void)
> +{
> +	pci_liveupdate_unregister_flb(&vfio_pci_liveupdate_fh);
> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D5

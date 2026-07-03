Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BD36F411
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066193; cv=none; b=Rv3nP5q5Q2F7QYnzTWo1F48t+RoVhD7dHmJjzPyNOosvRWGHvDsO7G4PtwK0WOX6yvewEiAv5LiUxO+s9upDQmDO3dSVzuc4gpmiHSjQx4QMBnVbNmUujpEo/hZa4+rF2vgpTx/uuS4sWAmYmIMcIglceDfyG6JrVqYZyK1CGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066193; c=relaxed/simple;
	bh=hoEA+Nv+aBCIeIv7bkLs5Vuhh4dQdOB70C6gSj/CLzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qQVkNx7RRa3XPhzys4DdgtZahyepLHuYnBLQ9dkyRLhbeL962oz3FWwLaDCLHqXKLTeyvVy+u5wnncdauRG21aHvBrIK2cVPEpSK6spu5dYWs31/eC6rU2Y4E1H0CVN/PsPykTEzpEvHldVSVsPreuodtmKG/wLUGGlI7kkrnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBHREWnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBHREWnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2721F000E9;
	Fri,  3 Jul 2026 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066191;
	bh=2iiA3+q/WweSn6caPjSGiZIKmvo5hIuYT0zOxtA025Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MBHREWnUipNWPNMMDuoSFaAxcUaNYS5z9Bra2sp47HBU49GRzUYw8sHh8uelWeLLb
	 XSIYHB5xm7QZJVLtA3kMcExOvXq8BXrExIbpbyHVmzVDXBknrTVQDqp7nzJg7qjWBj
	 B1K0mN2vDaoRIe9eJotWdGJM0b5Y4icU9eq9+hnQofYjZ8cvj0hTU+gIG8MoO7Z56z
	 ATVi1YSd7rhLlyt54X7MgJR0UYDDQCYt+fqvwK+7T4/7kyVepcsajXV4YZ/cxV4MNU
	 NfM98x4OuDmjl6c6DHoefI43Z7bL0H/c7MBC5OsyI2tgbm1ZNHiQ4yIowZGanWvr2+
	 EPhxKg6zGgogQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] selftests/vfio: add sPAPR TCE v2 IOMMU mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703032806.40946-3-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:09:51 +0000
Message-Id: <20260703080951.7F2721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fallback default IOMMU mode remains hardcoded to MODE_IOMMUF=
D, causing test suites to crash out-of-the-box on PowerPC where IOMMUFD is =
not supported for VFIO.
--

commit 8dfc3e7df9b7153c07746fbc4679447d70174937
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

selftests/vfio: add sPAPR TCE v2 IOMMU mode

Add a PowerPC-specific VFIO selftest IOMMU mode for sPAPR TCE v2.
The new mode uses the legacy VFIO container interface with
VFIO_SPAPR_TCE_v2_IOMMU.

[ ... ]

> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/sel=
ftests/vfio/lib/iommu.c
> index 035dac069d601..e86457a715bf7 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -47,6 +47,13 @@ static const struct iommu_mode iommu_modes[] =3D {
>  	{
>  		.name =3D MODE_IOMMUFD,
>  	},
> +#ifdef __powerpc__
> +	{
> +		.name =3D MODE_VFIO_SPAPR_TCE_V2_IOMMU,
> +		.container_path =3D "/dev/vfio/vfio",
> +		.iommu_type =3D VFIO_SPAPR_TCE_v2_IOMMU,
> +	},
> +#endif
>  };

[Severity: Medium]
Since default_iommu_mode remains hardcoded to MODE_IOMMUFD earlier in this
file, does this cause test suites like vfio_pci_driver_test to crash
out-of-the-box on PowerPC systems?

For instance, device_has_selftests_driver() uses this default mode directly
before checking platform-specific fixtures:

tools/testing/selftests/vfio/vfio_pci_driver_test.c:device_has_selftests_dr=
iver() {
    ...
    iommu =3D iommu_init(default_iommu_mode);
    ...
}

If /dev/iommu cannot be opened or device bindings fail on PowerPC because
IOMMUFD isn't supported, does this trigger a failed assertion
(VFIO_ASSERT_GT(iommu->iommufd, 0)) and abort execution rather than
skipping gracefully?

Should default_iommu_mode be conditionally defined for PowerPC to use
MODE_VFIO_SPAPR_TCE_V2_IOMMU as the default fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703032806.4094=
6-1-nnmlinux@linux.ibm.com?part=3D2

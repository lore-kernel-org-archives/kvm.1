Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E9381AF
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941112; cv=none; b=o0diST8jL+DqjzM7VdI/6f9UXZJLvDWJua1XEgMw22pOXPzPaXlrCcK3+uz48wLmvX+gnpaiCps4AIAbXGUiaPd8D9gBzkLhpvxzh8abphNgHRIZ1/L0PS3tSAZ/l3WZzp38pg8yDOOFCBzviMlznXW29xlUTREibB7DZRoK7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941112; c=relaxed/simple;
	bh=sbLxWBw8+NJy8ThT8pVY1RpSA1jbU7+cftm8PGFDQMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ty2J//D/+NWDWurdnSVnDi5o8ijX7C2h/hnLi5tK/NRN1m/wux2AsB/3zlx5iOLHryV+py8RMyli9UGmUSqgkLgWvRMCGmGI7kdBqLRbmQ+LDlcL6FJzo/RFu1xXIPv63ophkTH1O+We4VrxboiS8nMkkgq0uk3FuRP77Y059wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRHteafY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRHteafY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA891F00893;
	Mon,  8 Jun 2026 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941111;
	bh=ZfaqK2q3lw8/ITxdpYSO9a5GVFpL7l9p5aquwIWKakU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRHteafYxtUhn91AfkmvrT4RwFIA5EEyYZTVF1b4Jxb3OGH4sNLpMswJ0AcPpGKA9
	 NIirfG1isPeKSouKEx0XXnlj5TMK7S3m/oGAZLFK7WgJEMgL6sFwCnOPxN5pKZOZ5n
	 4HB1AVSAoO/J8M33bhL1r01ORMoUakytctkan7hpdRWTHOpcCO+apJgKRSREIut61N
	 7bgHm4qfmQyiv5uNJVNg9QTnVMrxQ+PDuon1vgaDd5QRlBoI3bt0TNRpGqhIxaSxMk
	 eyl76XLJ+Kf0tTg2CI9uukdb2b4zr09dmGHlrN6PYJtOTNEOXBrcskhcUikYZMeD2c
	 g7EC9ahxaIMDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] s390/pci: Preserve FMB state in device
 re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608171850.62829-3-oelghoul@linux.ibm.com>
References: <20260608171850.62829-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:51:50 +0000
Message-Id: <20260608175151.6AA891F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The reused hardware Function Measurement Block (`zdev->fmb`) is =
not zeroed before re-enablement, exposing stale performance counters.
--

commit 9bd944cc7f231486ddb6f89d0d8243e0febeb494
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Preserve FMB state in device re-enablement

This commit introduces zpci_fmb_reenable_device() to reuse the function
measurement block (FMB) buffer across device re-enablements. It also
separates the clearing of software counters so they can be reset when
re-enabling, allowing users to see counters start from zero.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +	int rc;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return zpci_fmb_enable_device(zdev);
> +
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measurement=
 */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc =3D=3D 3 is not a valid stat=
e here
> +	 * because we are re-enabling function measurement for the same function
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zpci_fmb_clear_iommu_ctrs(zdev);
> +
> +	rc =3D zpci_fmb_do_enable(zdev);

[Severity: Medium]
The commit message mentions that "a program resetting an FMB sees all
counters start from zero as expected".=20

While zpci_fmb_clear_iommu_ctrs() successfully clears the software
counters, does the reused hardware buffer (zdev->fmb) also need to be
cleared before calling zpci_fmb_do_enable()?

Since the original buffer in zpci_fmb_enable_device() was allocated with
kmem_cache_zalloc(), reusing it without explicitly zeroing might leave stale
hardware counter values in place. Could this result in userspace observing
non-zero hardware counters from before the re-enablement until the hardware
performs its first asynchronous DMA update?

> +	if (rc) {
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(zpci_fmb_reenable_device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608171850.6282=
9-1-oelghoul@linux.ibm.com?part=3D2

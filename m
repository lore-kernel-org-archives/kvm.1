Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1222566D3
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940587; cv=none; b=PilSooPXTMqU4I5wbiRiOScXXmR59aw4askVM5RlHPo35YA1pkZIeqKxrfhOUu1a5DkWJDGVmeS3bsFuKvTWtNkE6WcmVcD8SAbYyQuBkYtv0OqvUsSGM8BDQGxMUVMB3tdPnN4mmTWEQq5aiwjU0TKc4bN7MWHExU/KFSvDwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940587; c=relaxed/simple;
	bh=cXxVHJuuil27U8ZSDWzditmubwLXOJLyTyyFN7UWhFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JM4gnev4hM2x9asxgk09362lCr3g8ZzXvI76Qogw7YDqmVmhwob7W2zDuc4f8PODmzDgJJ2eRUK5V4lUbD82xhVg6glZwkGdvxmvr+OtNfosMoW27mAYsKU0QkvuAH29PMEry5DKsnLJFfWBCwH9FT885b7bqmvQUV/WpCtZoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nck7xha+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nck7xha+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4031F00893;
	Mon,  8 Jun 2026 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940586;
	bh=PvmGgIrApylAIACuJ+0HgPrmGlEaGkLvp0xzaXJKKyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nck7xha+UMEFMJEGu9p11BcMyyJbVxTsmBNhce5MrRn2efZzsofWMp7UvPH02KH8g
	 B6pKOw0Fjlry0YJxSmsk5+/nJgdnRx/+f23Sd42b6vDXHRXIcfYzJ04xPYMgsNGl/9
	 5V0wOj7EMxecoI9ZorHZ5JsKkjWDed60LO2et4RHSsb1N21/qw0CGnmT8/26xDpUx/
	 AAlQoByYjFbxzO9s0mVPnuMfcgejkYvZwBhwnTXysbjFcILuKdPjZj0Optjvnl1cJn
	 YN/q4qfvem/466BFQA/y2UP/5GlD8XgbuRgrulRacYec3b6ZDDYtAnB1/3Zm6TsCfM
	 yrk8i3JKGcG9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608171850.62829-2-oelghoul@linux.ibm.com>
References: <20260608171850.62829-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:43:05 +0000
Message-Id: <20260608174305.DB4031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing error cleanup in `pcibios_enable_device()` leads to pe=
rmanent FMB memory leak, debugfs dentry leak, and a Critical Use-After-Free=
 triggerable by unprivileged users.
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition in `pcibios_d=
isable_device()` allows userspace to bypass device teardown and re-enable t=
he PCI function measurement block (FMB) via debugfs, causing a memory leak.
--

commit d7370d8f05ef57aa4f6b63eb11d38c3b31147056
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Hold fmb_lock when enabling or disabling PCI devices

This commit ensures that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(). It also asserts that the lock is held inside
those functions to prevent future race conditions.

Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
Cc: stable@vger.kernel.org

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 39bd2adfc240f..2910d4038d39c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
[ ... ]
> @@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
ask)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_enable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
> =20
>  	return pci_enable_resources(pdev, mask);

[Severity: Critical]
This is a pre-existing issue, but does this code leak resources and expose
a use-after-free regression if pci_enable_resources() fails?

If pci_enable_resources() returns an error, the function returns without
cleaning up the allocated zdev->fmb or the debugfs files created by
zpci_debug_init_device(). Since the PCI core considers the device enablement
to have failed, pcibios_disable_device() will never be called.

When the device is eventually hot-removed, zpci_release_device() frees zdev.
Because the debugfs files were never removed, they remain active with the
freed zdev as their private_data. An unprivileged userspace process can then
read the dangling 'statistics' file, invoking pci_perf_show() which
dereferences the freed zdev->fmb_lock, leading to a use-after-free.

>  }
> @@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_disable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);

[Severity: High]
This is a pre-existing issue, but does dropping the lock before destroying =
the
debugfs interface expose a time-of-check to time-of-use race?

If userspace writes '1' to the debugfs 'statistics' file right after the lo=
ck
is dropped:

CPU1                                     CPU2
pcibios_disable_device()                 pci_perf_seq_write()
  mutex_unlock(&zdev->fmb_lock);
                                           mutex_lock(&zdev->fmb_lock);
                                           zpci_fmb_enable_device();
                                           mutex_unlock(&zdev->fmb_lock);
  zpci_debug_exit_device();

This allows the hardware function measurement block (FMB) to be re-enabled =
and
new memory allocated. When zpci_debug_exit_device() finishes, it silently
succeeds, leaving the newly allocated zdev->fmb and hardware state active.

When the device is later released, zpci_release_device() frees zdev but does
not free zdev->fmb, causing a permanent memory leak and leaving the hardware
FMB continuously performing DMA to the leaked slab memory.

>  	zpci_debug_exit_device(zdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608171850.6282=
9-1-oelghoul@linux.ibm.com?part=3D1

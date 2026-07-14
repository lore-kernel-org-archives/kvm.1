Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB83EB81B
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043729; cv=none; b=uTk6gML1y8xVdV3f47U1K6sBT7BJ2hiGTfYiKOHLcqMukFgil+teDcsVAg3Rc54zyXuK/8RjnLh8ipL+/uxhkmrsX1uLoNColQwosryWnU0gnHKy/fnDmt3dM+1p48eIq90+DSfx/4P9DdmkrCZ3KRh890TEviOSgy6uvt/fS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043729; c=relaxed/simple;
	bh=H0OfKKUC/8j0aFAPbBcTXvoxhEmuCIDu9U0EwtghLac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jeAPkuKdrlLJYHD9IrMw387KYaLYrFv/WbT7VuoLenl/NcmRRrxsWdWeo7yEmBGGhfkr6i/HHkLJWkheatArzwhzf/OSWL301HroHrvwRRYXMYaBMazgN9b4Oye6a+eEQYA/cYfqy5QIa5Ro2gmYNMSWC4MGHmUxkkLfMIWMHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oigySdo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oigySdo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274791F000E9;
	Tue, 14 Jul 2026 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043728;
	bh=H0OfKKUC/8j0aFAPbBcTXvoxhEmuCIDu9U0EwtghLac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oigySdo7FUfkPzxKvLkmeMbaalHZHIL+v1EQUaEyjzXgL+iF1+FKFc814gi/uS7bD
	 FcfHrxFl3ztNRYnX1f1fK3+Oaf6ZtNnaYWzOeZO+dBcQZckTXTDtMNlGGazEe+OPl4
	 RvevXfVmua3r6872/QeeZuMk/2s/gxhn3hSFJRigdTAlijlUbVszbZwXQ9g0kUa6LM
	 wF9eIG+gVTyMZsEl2LOooekOdfCatPq15TDWOafP0y/kgfJ/Li25ObI59PQ1+j5VxQ
	 tNKj/hUxkxktqMMxaRErZ8RgCX2NYiyizGfhqAN+czMTTALW4K+lIRKkhtFCmbwp7r
	 J5jUn50bdEpyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/20] vfio: selftests: Verify that opening VFIO
 device fails during Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-20-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-20-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:42:07 +0000
Message-Id: <20260714154208.274791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Test assertion failure due to IOMMU group already being claimed =
by preserved cdev
- [Medium] Test assertion failure due to re-binding already bound preserved=
 cdev
- [Low] Abstraction violation using free() instead of vfio_pci_device_free()
--

--- Patch [19]: [PATCH v5 19/20] vfio: selftests: Verify that opening VFIO =
device fails during Live Update ---
Note: Due to recitation restrictions, this report uses a free-form summary
of the findings rather than quoting the original patch diff.

commit b5a56d527567933e2f5fd3077aed99e8404f21c3
Author: David Matlack <dmatlack@google.com>
Subject: vfio: selftests: Verify that opening VFIO device fails during Live=
 Update

This patch verifies that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was preserved
across a Live Update.

[Severity: Medium]
In check_open_vfio_device_fails(), the test loops over legacy modes and
calls vfio_pci_group_setup(). Since the device is already opened via cdev
before kexec, the group's cdev_device_open_cnt is greater than zero.=20

Does this cause the group open attempt inside vfio_pci_group_setup() to
fail with EBUSY? If so, it looks like this will trigger the VFIO_ASSERT_GE()
assertion on the group_fd, which would abort the test before it can even
reach the VFIO_GROUP_GET_DEVICE_FD ioctl it is intended to verify.

[Severity: Medium]
In after_kexec(), the test retrieves the preserved device_fd and attempts to
initialize it with a newly created iommufd by calling
__vfio_pci_device_init(), which then issues the VFIO_DEVICE_BIND_IOMMUFD
ioctl.

Because the device_fd is preserved across the Live Update, doesn't it still
retain its original binding state and reference to the original iommufd
context? It appears this might cause the bind ioctl to return -EINVAL,
triggering a fatal VFIO_ASSERT_EQ() in vfio_device_bind_iommufd() and
crashing the test.

[Severity: Low]
In check_open_vfio_device_fails(), the code directly calls free(device) on
the pointer returned by vfio_pci_device_alloc().

Would it be better to use vfio_pci_device_free() here instead? Even if it
only wraps free() currently, using the library's abstraction might help
prevent future memory leaks if internal allocations are added later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D19

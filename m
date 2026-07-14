Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA235E1AC
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043844; cv=none; b=Deu9fAPXVOGGXg515ugf070vPGh1SCFo7cNuVRipMXR2lt9MXg5oxdImk4mOyiuPJQK7OaF9GuPtEy3MCImgY5Q/Shcfi6mZlqEHwdk1i/kuolsfHXdu8hmyqnthBQ7n4lLq288II7w9POSTBd7NV4VAjpLbGmdCjQ9eIemPGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043844; c=relaxed/simple;
	bh=9rCAczrxVQrfLgX8Its9n7O6T8Ys7B5hT2wCY007org=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlsPj4DZAxtJZeOnOAg8okaIy7bSN0HYKpY6qfiwQeH+d+o2SIZcoBgoaCV0MuMscBU8eToAxucmAqzmtfEd1EnhblljTuxi3CjVgnHV+ElBuJUPtn3USJkUOVAj2jlVqRt3nUHoHmnxB4wEabfDqCNExweG4leJreh+SYScyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6I7BW7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6I7BW7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C651F000E9;
	Tue, 14 Jul 2026 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043843;
	bh=rle90iLh/ZsT86XSI2aKmyAlOcmbGcZAt3UyDE+RkZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6I7BW7HMiyseGpdbwK07zwI70ipXa/0J4XFXdSBBST80XtOiQExQDyw3VMEH4OE3
	 9mSMsOqFCs36aJF6EQFexmbxCbMgrFHSgyR+ZggpNCZiyhuGG93gF8TA/H7+qVk3Ch
	 bvP/VajKuVqmt7Zp2EgjbhYsHhBvy5S3y4wHILdgn/JXPs+DlD81EexMVyotueEIvp
	 8xcYFECS1GgM8bJXVehLOGr4UKhZ30HX/R/3f8TORa0DOg5nc9gACEXFYQ8Rlfe/jf
	 Tn9PLgBVp4aGyGU3FAIGgAcu0NHbrCrHaoHmLVW3VAly8DxGWW3/LgNaVNncr1sTW1
	 xUzzrvVJKn10g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/20] vfio: selftests: Add
 vfio_pci_liveupdate_uapi_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-15-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-15-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:44:02 +0000
Message-Id: <20260714154402.D3C651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The selftest `vfio_pci_liveupdate_uapi_test.c` fails to compile and=
 link due to missing headers, libraries, and undefined functions.
--

--- Patch [14]: [PATCH v5 14/20] vfio: selftests: Add vfio_pci_liveupdate_u=
api_test ---
commit 4ef2d85343eb23f4f743330b67aabe0e09e08f3d
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Add vfio_pci_liveupdate_uapi_test

This commit adds a selftest to exercise preserving various VFIO files
through /dev/liveupdate. It verifies that VFIO cdev device files can be
preserved while group-based device files, group files, and container files
fail.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c=
 b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
> new file mode 100644
> index 0000000000000..f81c8ab21db3f
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <libliveupdate.h>

[Severity: Low]
Does this header file exist in the tree? The build fails because
<libliveupdate.h> cannot be found.=20

Additionally, is the Makefile missing an include for
../liveupdate/lib/libliveupdate.mk to ensure the dependencies are properly
pulled in for the build?

> +#include <libvfio.h>
> +#include <kselftest_harness.h>

[ ... ]

> +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> +{
> +	int ret;
> +
> +	ret =3D luo_session_preserve_fd(self->session_fd, self->device->fd, 0);

[Severity: Low]
Is this calling a kernel-space function from a user-space selftest?

Looking at the code, luo_session_preserve_fd() appears to be defined in
kernel/liveupdate/luo_session.c. Since this is a user-space selftest,
calling it here results in an undefined reference during compilation.=20

Should this be invoking an ioctl directly, or is there a user-space library
wrapper intended to be used instead?

> +
> +	/* Preservation should only be supported for VFIO cdev files. */
> +	ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D14

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706B364953
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043328; cv=none; b=ONoRS79BoM7qly5xbTszCM+YDkNiJoNrbmjX+V2Apz/PFmjlu+bN2P32xLz5J/9c3CUREOhlaDxxZXLq8cY2CTQZUem9OEj1IEjaFk/ZYNi7TlJlPimm5gkO0PFl9MiQEL8qUwJTN1OKmSW1PtWhj7i1y4uNV3uyDKuVpIk+QXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043328; c=relaxed/simple;
	bh=me7+C5WhGONWmyYsIWiinQ9mgn7dC7fHI2NYAqKIzSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BPZd0BdH720Ijq/Y8T4xsJ9Y5xcJZrJvt9jY0KQL22xfK/kZQG2gKkx92Ow87e8qa3r+rakMIDN7x21XbFI0LFk4tvfD1RSHw2A5iQLJdl/uUf2XTqrg8XxUozEB5uDFiWBrESABowAgCFE4Wqg7tj1loMQSMmKTLLJ3C/b+40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSYK7aEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSYK7aEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8311F000E9;
	Tue, 14 Jul 2026 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043327;
	bh=tuNG6QP2rbqFk5y5VaOvV0+ntsUMpwRSQcjiAEscwKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jSYK7aEcu390X/sJSX/W6u0nAyNgKRRJZfvbUcAblMWmVSxTa5rZBFPTRS0aVohKE
	 Zl/xCR0cEqHBwpoxbRblSIJmA6vTlK03PLFCCwFwxfDq+yeac+ue7MDIGZr/iG8tU4
	 Xin58p+D8oGzy7oT4Lb/Tq6c3J+vjY7ac0sExZCitbYix+PuGdPLM0avYLIYnSQRK6
	 /HgfQT45BfRReGXhC/jDgSuCcGFf164FVQtY5cET9Hwm6KQxPDX1p4Dw2cGCg4nz52
	 JJ7tcn1wDxKCv2Bv+I0u/alQq9zz9mhgp7kN7MzHMrg8HqOs0nlG3hBp+DMu8fHFg9
	 T+ZNQUL1DyVuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-18-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:35:26 +0000
Message-Id: <20260714153527.2F8311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing header and Makefile dependencies for liveupdate library.
--

--- Patch [17]: [PATCH v5 17/20] vfio: selftests: Add vfio_pci_liveupdate_k=
exec_test ---
commit 5f1d9fcb84decd9a67e94d71a492e75ba0113c1b
Author: Vipin Sharma <vipinsh@google.com>

vfio: selftests: Add vfio_pci_liveupdate_kexec_test

This commit adds a new selftest to exercise preserving a vfio-pci device
across a Live Update. The test verifies that the device file can be
preserved before kexec and retrieved afterward.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.=
c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> new file mode 100644
> index 0000000000000..15b3e3af91d1e
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <libliveupdate.h>

[Severity: Low]
Does this header file exist in the tree? It looks like this could cause a
build failure because libliveupdate.h cannot be found. The other liveupdate
selftests appear to rely on luo_test_utils.h or direct ioctl calls instead
of a libliveupdate library.

[ ... ]

> +static void before_kexec(int luo_fd)
> +{
> +	struct vfio_pci_device *device;

[ ... ]

> +	printf("Preserving device in session\n");
> +	ret =3D luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);

[Severity: Low]
Will this result in a linker error? It seems luo_session_preserve_fd is
undefined without the accompanying library implementation. Should this test
use direct ioctls or are there missing Makefile dependencies for a library?

[ ... ]

> +static void after_kexec(int luo_fd, int state_session_fd)
> +{
> +	struct vfio_pci_device *device;

[ ... ]

> +	printf("Retrieving the device FD from LUO\n");
> +	device_fd =3D luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);

[Severity: Low]
Similarly here in after_kexec(), is luo_session_retrieve_fd implemented
elsewhere in the test suite? It looks like this will also fail to link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D17

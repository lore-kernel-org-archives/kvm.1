Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01148094D
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042433; cv=none; b=HG772Oam8dqO3WVaXwWLT5HWEZ6bSYJpWvwO4xI7aqVqv2YBJrioFXbrjpuOdYQ8amnlGCkBornMfhYDyEDoIwzYp0S1pcJ/GEp82DW4T2CrJstxdt4UxU4bWyrmsoP9NKz0zV+MGF5ygX1nbQc70DVIPUkqC8KeTtgtDm7QxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042433; c=relaxed/simple;
	bh=/QJMS6s9WtRCVlGNqcAyIPX4FQBPoiP9qsER/8ge91c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rMazR+ckAheK/2aKqksXqVB6WcKF6LDMQMAfC8cRLNlatp7Uli9Z3USSzEYhWJWhkSakIrPvdvwhenBF088KS2Yk/6J/PQ+12uZ7igXgDgiBS8lccUzkDTPB80AnDod1Odu/AUYVSdj/r1o0cwh34xEHRKFGJfg0xXvElifFAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVHhGyFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVHhGyFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1DF1F000E9;
	Tue, 14 Jul 2026 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784042432;
	bh=O7Bwvu1PhcttMDPeQVVGm3c27UUGdnk0k42OaX0Z6Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YVHhGyFMLM9zZxBupH4F6vgOIAjuDnDI7U0aDPVXTUOMLMaHudXs+EtLT0DA53NYJ
	 4k66FdWjQSKnOuv0veU0kAzOrXzzi11tkR1KY7Nq6d/DOhiQWOOM3O981z+X6C5a/C
	 36zX0KfpiLtIj9ktPFv0Gpov7MCda+MiLqogOw8Rb2YKGknD10StvdfAibdv690sm7
	 qO2fcliAh/7jVWuiou0hL0gAVFD0DwYd+KDtbcy+dwfYiJEGuSn/VVUVBG0X6i33Pd
	 u8Cq3H1HbWHqtOZScLQcjx4Q8v6gpw8e540Lpe4sLb0e8ZLDF02tlak6yf31eC/1wu
	 0HES4VjiFI5NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/20] vfio: selftests: Build liveupdate library in
 VFIO selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-14-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-14-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:20:31 +0000
Message-Id: <20260714152031.CB1DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The VFIO selftests Makefile includes a non-existent file `../liveup=
date/lib/libliveupdate.mk`, which breaks the build.
--

--- Patch [13]: [PATCH v5 13/20] vfio: selftests: Build liveupdate library =
in VFIO selftests ---
commit 8a41a1e6305bdbe73648566ef65764a964e68dbb
Author: Vipin Sharma <vipinsh@google.com>

vfio: selftests: Build liveupdate library in VFIO selftests

This commit imports and builds the liveupdate selftest library within the
VFIO selftests to allow using liveupdate ioctls.

> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selfte=
sts/vfio/Makefile
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -21,6 +21,7 @@ TEST_FILES +=3D scripts/setup.sh
> =20
>  include ../lib.mk
>  include lib/libvfio.mk
> +include ../liveupdate/lib/libliveupdate.mk

[Severity: Low]
Does this file exist in the tree? Including this missing file causes a fatal
build error when running make in the vfio selftests directory because
../liveupdate/lib/libliveupdate.mk cannot be found. Was the liveupdate
library intended to be added in a prerequisite patch that was missed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D13

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D08228CB8
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053396; cv=none; b=JebYN82kbFWunrRziajXmIXOI1eviqEy561FNY3/Rdh1LeAlZpena78pQk3/fUkFeatvBmKJIxRN15ntX//90dt7kMMlxSm1dpavRwJYldHTY4XxmuEg0N/nwmfS84ek+czLW6cicezNSBsOSWbr4QB9rTC+H6dDYD6aKVftVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053396; c=relaxed/simple;
	bh=x9hVVQdrhXAgaPd5B/lPE3thMKH6jIKKySchsRDSQtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtdD9Sc7mMmJBGD6TW5aDROq20n9RC+4ZZFEmOi7Uzh1fyVVPO4JvQhXAT0UqVI0DgrhVHL1isOB1umnM0VyABtC4OgsJuyGVS8/lLQmpE4MUuyNSLxkQ0aNiGEzaiTdKs+GuZqXQB597oL+imGzgncR1QlXwa8NNFj417twgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO25pRN7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO25pRN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8861F00893;
	Wed, 10 Jun 2026 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053395;
	bh=Y8JF4ToHHTqjBAAcxuCws9BQShwomuTL9bzmU7N34Ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BO25pRN7I2gYgfujEC3Am59wDaOprk1/DbSwLMONy3AZ/DnduCTTDYEDsHPIX6uI/
	 9VLHh9kYq/3bFWM9q25trEfDpO+9IB6Px975GmqVG7hlEMZnZnTEOJ4dgMMYnnR39e
	 A28fZV4cFsBxkPnqcMBfAjDjJBkCgxT2Y62F6h+jS/mc/0UdJ3B9iTRHG9lMKQzKsX
	 IHQXbpGZ6zqhRw3njS+xPiMYY91tCwM/r3Q6k3q4XN5LAbdS3dHMt+ThL9SBPXljOp
	 W6LOmSMJUgzsVF9LZ00HvYywWQRVQkbz6XUDz82ZWpE61qclGMSrLY6XIgb6d56zQa
	 +FvXZ/UmGj5vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/18] KVM: selftests: Build and link
 selftests/vfio/lib into KVM selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610005338.2967132-2-seanjc@google.com>
References: <20260610005338.2967132-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:03:14 +0000
Message-Id: <20260610010314.DB8861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Including `libvfio.mk` breaks the `make clean all` sequence for KVM=
 selftests because `libvfio.mk` eagerly creates output directories during M=
akefile parsing and deletes them during `clean`.
- [Low] The commit message incorrectly states the output directory for VFIO=
 object files.
--

commit 603b6019849c316e7022070d57840b9b75c1791c
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Build and link selftests/vfio/lib into KVM selftests

This patch includes libvfio.mk into the KVM selftests Makefile and links it
into all KVM selftests.

> Note that KVM selftests build their own copy of selftests/vfio/lib and
> the resulting object files are placed in $(OUTPUT)/lib. This allows the
> KVM and VFIO selftests to apply different CFLAGS when building without
> conflicting with each other.

[Severity: Low]
This isn't a bug, but the commit message states the output directory is
$(OUTPUT)/lib. Looking at tools/testing/selftests/vfio/lib/libvfio.mk,
LIBVFIO_OUTPUT is actually set to $(OUTPUT)/libvfio. Could the commit
message be updated to match the code?

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index e0ddd3ff9472d..14316358fd9fb 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -257,6 +257,7 @@ OVERRIDE_TARGETS =3D 1
>  # which causes the environment variable to override the makefile).
>  include ../lib.mk
>  include ../cgroup/lib/libcgroup.mk
> +include ../vfio/lib/libvfio.mk

[Severity: Low]
Does including libvfio.mk here break the "make clean all" sequence for KVM=
=20
selftests?

In tools/testing/selftests/vfio/lib/libvfio.mk, the output directory is
eagerly created at parse time:

LIBVFIO_O_DIRS :=3D $(shell dirname $(LIBVFIO_O) | uniq)
$(shell mkdir -p $(LIBVFIO_O_DIRS))

The directory is also added to EXTRA_CLEAN.=20

If a developer runs "make clean all", Make will parse the included libvfio.=
mk=20
and run the shell mkdir command at parse time. Then it executes the clean=20
target, which deletes the newly created libvfio directory. Finally, it=20
executes the all target, but the compilation fails with a "No such file or=
=20
directory" error because the output directory was deleted and isn't recreat=
ed
in the build recipe.

> =20
>  INSTALL_HDR_PATH =3D $(top_srcdir)/usr

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610005338.2967=
132-1-seanjc@google.com?part=3D1

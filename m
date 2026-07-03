Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1736AB61
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066490; cv=none; b=BI92xeSEKIB2t8POzX2hft1oGRkaVEzo81Amfnp561LNo7Fmv0bNwJCeY59IpblwkJEF1HLVp4phGITL+7FjgJ8ASYHWYcmALl9sp57hkjAeR+an3OhK5LsPLWHCTYfZiIJ4kxx7Lrq68WjmKK17A+ylNitB8JJfNtjoiLAf/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066490; c=relaxed/simple;
	bh=CrKZKzAfk3EpY0G2qCGuohrJiT8hFYPPdD7Dnqiyj9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5Mze5cFMGYunlWYFV6JK7cLg7S/X+jH4XkIA47XItlKZdkqZ5R2J+VaJwk4p9d0q0XxFGq/0jWr5mwr5uQ6iwHYPkmuaVRkWXvXgzv41+7NXHzEJ1RDF2l26lOcdN3Ak+XXG8EFHmDssvqRbPrWQRVS0mqADQTrDmwoXjnoRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoLBeGgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoLBeGgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074691F000E9;
	Fri,  3 Jul 2026 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066489;
	bh=4A6J8V0ZQu/EzkN+TOh4qaeInbJvQL1w8RZ23GWAs88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KoLBeGgxbA55AmMVwQRfqfOjpcE4yqlxRUbKshP+tfSbtpEPNJF0R4kRX+EX5xSc6
	 KyKIETaelfMjvt/diwOpYFDlPGL/dWB7Nnr2CQC/roE1/t0ttFib7PxMKgR5kZa+xG
	 HVQrfqSVQ+xaeqAFu6MJTd4EWkL7Go6B3B5gd85j/qPO+Ek02Ntg16AEq0FDv8s4gl
	 p1Hf9+gWlAyNmXVMRNNPnABmwRhgZAc9KiTJq3Q/wmQuMNC0euTwYKLacJQnmEU5ON
	 YZSBr2V2H2J5kDUnSWHu+0ez/aDJN98M1hj8zYXBWeqaEtxR63YFftY7x1s4s8nlCD
	 PDaeQjjfQ0o/Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] selftests/vfio: Enable VFIO selftests on ppc64
 and ppc64le
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703032806.40946-7-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-7-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:14:48 +0000
Message-Id: <20260703081449.074691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The VFIO selftests will still be silently skipped on PowerPC whe=
n building from the top-level kernel directory (e.g., via `make kselftest`).
--

commit e8d7fbeb96b4d48f400e3fc2cba19a75370e70e6
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

selftests/vfio: Enable VFIO selftests on ppc64 and ppc64le

This commit modifies the VFIO selftests Makefile to enable building on
PowerPC architectures. It allows PowerPC systems to run DMA mapping
tests against the legacy VFIO container backend.

> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selfte=
sts/vfio/Makefile
> index e6e8cb52ab030..dc686a38ab0a9 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,6 +1,6 @@
>  ARCH ?=3D $(shell uname -m)
> =20
> -ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64))
> +ifeq (,$(filter $(ARCH),aarch64 arm64 x86 x86_64 ppc64 ppc64le))

[Severity: Medium]
Will this filter correctly match the architecture when building via the
top-level make kselftest?

The top-level kernel build system evaluates SUBARCH using
scripts/subarch.include, which maps both ppc64 and ppc64le to the canonical
name powerpc, exporting ARCH=3Dpowerpc to sub-makes.

Because powerpc is not included in this filter list, the tests will still
be silently skipped during automated testing when invoked from the
top-level kernel directory.

>  # Do nothing on unsupported architectures
>  include ../lib.mk
>  else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703032806.4094=
6-1-nnmlinux@linux.ibm.com?part=3D6

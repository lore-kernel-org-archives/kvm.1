Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7334C9AD
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089759; cv=none; b=DtwpsO6sELh6TLGUZczrfI5BZ1rJWOTqF94tNEcEzk7inlFAlvQi74GTNbeBNDiUkiQOC3KgZkcX/gckdgIuDhoJDjzm/EFZZ6oc//oGq9hZ/xzLgga+XtnYmu/CqDzpV2+hQzf3/PrdCDes0rDhU0NXCm5arvZWLF4+bTXCUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089759; c=relaxed/simple;
	bh=vcCjxgCd0NkfqhzoiXqRzrHrMbpycN6tcVqWs+DbQ9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWob1zcwedsHJzhAMTua/aql28JUPp4awbnL6kDU2Nenfy6akb+05IVOlwPFkG+mS2fQM2gPDPS6uxVPKEd/Hk1zaymOulwuKshIvri+AEBB60MzH0CpuguAvJw2tAvgf2bp1ZXdObS/T408CK+x4o8wPaegyYxE+xCkXuBod1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QApBBgX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QApBBgX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239221F000E9;
	Fri,  3 Jul 2026 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783089757;
	bh=vcCjxgCd0NkfqhzoiXqRzrHrMbpycN6tcVqWs+DbQ9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QApBBgX4x89zfiNpWjvtsfWkTSH4BwULUHInMU16Hxrew0bnOgZ0wBaFqRBR7pOSj
	 kWxoYVN28zWAiSLLP6UQYklUiSjJgJMxs40GlORctRvmM1b9WfdMzqr4IAk03+duvH
	 y/BCE5Skt0fZ5pCsON6ckLkJxLCPClH9dDCn5llyyH2Vmm8SAJ/Cv5Jt+pnpjmLkwo
	 ZD7pa0jmmsUBw4NsTXadc8Fec/lzMVtoic4lqNITcPdO8Jj8hxc85G2IWQPTYGgkcn
	 0FO9s2iudASjrf3aTmXvonntPRgTC0/DXqiVGoPN7jr5/3d+awi8X4eJBbsn72ajG9
	 4fmhdaZiaoLhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/15] Documentation/userfaultfd: document RWP
 working set tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-16-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-16-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:42:36 +0000
Message-Id: <20260703144237.239221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Documentation incorrectly claims UFFDIO_API returns the supporte=
d features bitmask on EINVAL
--

commit b47603d883cc00fed0a038162bec7702caba77c6
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

Documentation/userfaultfd: document RWP working set tracking

This commit adds documentation for the new UFFDIO_REGISTER_MODE_RWP feature,
covering sync and async fault models, UFFDIO_RWPROTECT semantics,
UFFD_FEATURE_RWP_ASYNC, and UFFDIO_SET_MODE runtime mode flips.

> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation=
/admin-guide/mm/userfaultfd.rst
> index 1e533639fd509..69836e39aa0b6 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
[ ... ]
> @@ -307,6 +307,253 @@ transparent to the guest, we want that same address=
 range to act as if it was
[ ... ]
> +**Feature availability:**
> +
> +RWP is built on top of two kernel primitives: a spare PTE bit owned by
> +userfaultfd (``CONFIG_HAVE_ARCH_USERFAULTFD_WP``) and architecture suppo=
rt
> +for present-but-inaccessible PTEs (``CONFIG_ARCH_HAS_PTE_PROTNONE``). Wh=
en both
> +are available on a 64-bit kernel, the build selects
> +``CONFIG_USERFAULTFD_RWP=3Dy`` and the ``VM_UFFD_RWP`` VMA flag becomes
> +available.
> +
> +``UFFD_FEATURE_RWP`` and ``UFFD_FEATURE_RWP_ASYNC`` are unavailable when
> +the running kernel or architecture does not support them =E2=80=94 for e=
xample
> +32-bit kernels (where ``VM_UFFD_RWP`` is unavailable), kernels built
> +without ``CONFIG_USERFAULTFD_RWP``, and architectures whose ptes cannot
> +carry the uffd bit at runtime (e.g. riscv without the ``SVRSW60T59B``
> +extension). Requesting an unsupported feature in
> +``uffdio_api.features`` makes ``UFFDIO_API`` fail with ``EINVAL`` and
> +leaves the userfaultfd context uninitialized; the bitmask returned in
> +``uffdio_api.features`` then advertises the features the kernel does
> +support. The recommended probe sequence is therefore to open a

[Severity: Medium]
Does UFFDIO_API actually return the supported features bitmask on EINVAL?

Userspace programs written according to the Feature availability section
will expect the uffdio_api.features out-parameter to contain the supported
feature mask after a failure (EINVAL). Because the kernel actually returns
0, such programs will incorrectly conclude that the kernel supports no
features at all if they rely on the error path to discover capabilities.

> +throwaway userfaultfd, call ``UFFDIO_API`` once with ``features =3D 0``,
> +inspect the returned bitmask, close that fd, then open the real one
> +and call ``UFFDIO_API`` again with only the supported features set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D15

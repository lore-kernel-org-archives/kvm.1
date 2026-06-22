Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47A346E74
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154468; cv=none; b=R/YmWS0VvQw6i1Jbxi0IZ1IIydZ6+TfFZvGaurEIZIyamFENv2YLHm/27n2P9yyQt+FaSIzGk7/Lt2NaS7ktBj0jILOunMVU96gEq6jq9ypP9A74uN2UKHQKELpKW7RN9VZw27kfSXLZ21Td0x3cfw3zaS3TK9ZFcM5tuFm3bL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154468; c=relaxed/simple;
	bh=oxI82DHN5xeiIY+WOKZpA1FTn3dT3Cm30qhtpPIlQn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OyMm3EyUq/dI38uWiFtcwdzDYOEUbf8QKeJK0pBg92xVB3/RogpnCCB95CAlS0GE4m2+y+/ZfWywuRf3Unko5R52M9ANrhvjPcXjVlAEnqptV4iM3VJ8Nh64lEI7hhkVn2W0PaBzRyaaz/QVHOJAgOGxiq8NtxquAt4R1X1nNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj3sYpgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj3sYpgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2365D1F000E9;
	Mon, 22 Jun 2026 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782154467;
	bh=+jjC+pyHut0x83HuPHbsziGjiF0368diRjnVBJNGBaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bj3sYpgz2Ap9IJvyX2EFVt5GC/OYES80Ukg1M3Pp0lmued9cjMIsQDYJ0a8sr1lxV
	 fq1E/M4CcwU/yhdXozWTX3eImCe9G9mEGBQPwQ3Vvta8TZei8CJozW8uqcL86LErBC
	 dxCfKYJohxcSlgRZPcOHN+wOVn+MGEj8e8T1O9nhjQWF+Wtq0u2big1nxfO34nqoZ0
	 jD06iq0lf6sr1fSbfOG3U8rHwVUTZtSC2P7aIRP4VhyF1DOjiF3ZI4GtGwh8jSphvo
	 v6X+GRcus2ZEXN+obKkgJIhksxSMIJ9N7vuVk3CL3a6rE4226DNMHp2VL3KGMJ8B+4
	 QNC+Dq8BGq77A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] docs: add documentation for guest_memfd
 preservation via LUO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622184851.2309827-8-tarunsahu@google.com>
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-8-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 18:54:26 +0000
Message-Id: <20260622185427.2365D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch includes an undocumented logic bug fix in C code while=
 being labeled as a pure documentation change.
- [Low] Typos and grammatical errors in the new documentation.
--

commit eb552713cd5f980d69c6b422467b4dfbb265bad1
Author: Tarun Sahu <tarunsahu@google.com>

docs: add documentation for guest_memfd preservation via LUO

This commit adds documentation under the "Preserving file descriptors" sect=
ion
of LUO's documentation. It describes the requirements and limitations for
guest_memfd preservation.

> diff --git a/Documentation/liveupdate/vmm.rst b/Documentation/liveupdate/=
vmm.rst
> new file mode 100644
> index 0000000000000..8353e236471d2
> --- /dev/null
> +++ b/Documentation/liveupdate/vmm.rst

[ ... ]

> +Scope and Limitations
> +---------------------
> +
> +At this stage, the scope of guest_memfd preservation is restricted to:
> +
> +1. **Fully Shared guest_memfd**:
> +   This time only fully shared guest_memfd supported. Any system that
> +   supports coco vm (which uses private guest_memfd), will not support
> +   the preservation.

[Severity: Low]
This isn't a bug, but there are some grammatical issues here. "This time on=
ly
fully shared guest_memfd supported" seems like it should be "At this time, =
only
fully shared guest_memfd is supported". Also, "coco vm" should probably be
capitalized as "CoCo VM".

[ ... ]

> +Retrieval Order
> +~~~~~~~~~~~~~~~
> +
> +Similarly, there is no strict ordering required for retrieving the VM
> +and guest_memfd files. Any file can be retrieved at any order.
> +
> +If guest_memfd file is retrieved and VM file is not retrieved, and
> +luo_finish is called, then vm_file will be lost and guest_memfd file
> +will be hanging around.
> +
> +NOTE: Before Initiating the preservation/retirval, it is necessary to ma=
ke

[Severity: Low]
This isn't a bug, but there is a typo here: "retirval" should be "retrieval=
".

> +sure that the kvm module is loaded (/dev/kvm must be available).
> +
> +

[ ... ]

> diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
> index c242b1d14c0ac..8411fe86dc2a1 100644
> --- a/virt/kvm/guest_memfd_luo.c
> +++ b/virt/kvm/guest_memfd_luo.c
> @@ -119,11 +119,11 @@ static bool kvm_gmem_luo_can_preserve(struct liveup=
date_file_handler *handler, s
>  	/*
>  	 * Only Fully-shared guest_memfd preservation is supported
>  	 */
> -	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>  		return 0;

[Severity: Medium]
Should this functional logic fix in kvm_gmem_luo_can_preserve() be split in=
to
its own patch?=20

The commit message explicitly states this is a documentation change, but th=
is
modifies the condition for GUEST_MEMFD_FLAG_INIT_SHARED in C code, which
violates the rule of one logical change per commit and makes tracking bug
fixes difficult.

> =20
>  	/*
> -	 * It makes sure that no memory can converted to private
> +	 * It makes sure that no memory can be converted to private
>  	 * even if it was initially fully shared (in-place conversions are
>  	 * prevented).
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.2309=
827-1-tarunsahu@google.com?part=3D7

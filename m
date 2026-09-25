Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962D4EE848;
	Fri, 25 Sep 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369469; cv=none; b=LpVJvPX7koCzi15oC7d0xfnXoSRPZxMPFr1oJlRBDW4MhnRYMH/6RHO8n2d4pKWLmZEggGDkErjaV7uY2ITRsv35CGyf2tXgYjca0gdlMjMOZfiDNFQuS4TLG8lL7XwjH4ZOavWhFD/ScBN2/M+gvJDpyo+JFzx7+AShfm6R4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369469; c=relaxed/simple;
	bh=tH9+plF8T7MkBensdvY1uM6dp+bKDVGFLBQVFP/xjK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6yen/hQ/z5bilLupiWuN5EAEKan85bHcgJwl7wOElIXcIKH4pUwgHV8I7cCJhiQlFGYnOy3rbL6wGdC7m5sbCjCHdiLz8973o9wcFkWOaHXJ6i4rwO7IwdCTBNLxmV6D8O2gJSPRPiUGHtJj60PsTR0EkRn4Z1784kywRbuIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hOcT4KSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=baYjwdbN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="hOcT4KSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="baYjwdbN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CB8814000B3;
	Fri, 25 Sep 2026 16:51:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 16:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790369466;
	 x=1790455866; bh=3Zv6VXZ4SCLzKxgAL3D+C9uwDRb9JSK+3nmkEecD85M=; b=
	hOcT4KSvFkEuwSCI+NrlGvEGI/pSbi1RPaCnw3J4RxeRQDjezmd0fFBUv5Ji0FQ7
	6Z5waF+hByBCBhyl21KC+WEVKtXYnyJBZ/mcTyQ2DIUMw8U2IECzIwjF+q3/tDF/
	3XdQmQ3XoRue5FZSbrF0tptp9jgIqTDoNhAVugu3wrGFBHxGu7pJGZaOXP8f0Nkw
	oUei2n/XM+Hirs4T4desTomJHt4bLTHMOl22XojVxx83FC1R9G9CR8iE5XogYDcs
	bxSWzJwLrMGeHxhFtKTeGaEpxWGuRL2ac4DH5j1D7AKMMOE7JSW7Z1cIWC6KIFEr
	bxAYhplJux++2wiMsQE47Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790369466; x=
	1790455866; bh=3Zv6VXZ4SCLzKxgAL3D+C9uwDRb9JSK+3nmkEecD85M=; b=b
	aYjwdbNw3JQYRUkDHN2sRoEW/9+/t/B595AiEywFzQZN3xm47t93KQHyviOkT8Ek
	R6H4j4JSddbHLxuGmdAAF4r84cxJcqQbvWa+mUFYMaFx/AjKLTIWmHxIMoKCPtMK
	v6sl7WJfoAnsHYdLoKDNNcuN+rw9Khnbq6jCAnNPhh7P+f/O7Zxi44Vg4WogF01/
	ql6vLZX7gvd6sD4kydO2mqAT6mvelLpSynrKMGdTauWKN7n/CYCI09X847Ne3RpH
	EaCx2DAXIsOi2sR/DI7UW2gxEbNrG9Ie/j1rLdYXO+du7twbSK3gEHzwyDMCY5ua
	vrzp9emvcMYl4IhdZs1rw==
X-ME-Sender: <xms:ud62avOpB2BxuL14-eRm-nJgZYUncIgm9pdT16TGynlBg8vr-qmpmA>
    <xme:ud62aj_M4KBnaezepGjEco20RD37RJ8tuJ6d2h76XDAp2VB5KmyzQOfwPgQZXFtfC
    TM3uuvm-jBQihd1b0ziwJA-FHUTOP-kVM5hrwmrGdjhOQzDiiaMVw>
X-ME-Received: <xmr:ud62ak4fiouOcWWuBU54p5Cx2arCXl5HMHCZJ93rf1iZ8KOXUvYJK4MRfjG6_g>
X-ME-Proxy-Cause: dmFkZTFxNyHjzZcvccXjerJtDVhNgMC1PMKaOTlwnVsrcwrd/RswhU/mbs8qoZjwSlekpK
    KLt300oD7EBxm4/KbQX/4+2A0DEyegPEGQsuN8fK77N+phTYVWCzeN5cnax1notd1JRpyC
    uOVisgnC2C+f8Ko3xxuvNlBLAZmNZh0nb5tWaqQShOvNgncL6n2e6uOX87effDpj52wNT1
    TjXCLy3Jn2I6i4eXCH29Gq2d+DbQR1HReV7kifHAy5ZAMhcxQWLYXAjTl6bb9zDzdIMu/r
    Tbw7zrN5VsN+ab4LuXTPBllpGVWAcnXTK1/3kXaZa5mHwfhIpZOenCpUuoIzrEMFySU1fT
    SIQ6i41LBl7fYn6Nfh+LLcl9+CBBo4VQe7Gn4J4RgJgEv9K4OE6WxafaBuj8lp3UhaXnGg
    hYfAU2mHOxplpkmAGwWMDD79nPWDOrNy6NNPmPHtD4XMjq8s7xyvO0dFMf47yys2WgE+sg
    7d1BFy5GMjYG4M3s/3sXccaoojFgZqeJRoU0t9SlwDi3i7x0owWoM6vbMkRcPbcBo2/SKk
    GZWtQPKQExfhNxW2PPZUQZYXgeUigC90I4uSJS1/pSv0gFhBmm/OZ9tJ2AU7FoYzj70yOM
    fw75Vp1St2bNyhsG2o7w4hiFxaU4rn6qjFBCCJLHv9YuKFsxNJqcmnOm8lxw
X-ME-Proxy: <xmx:ud62ah5mj-I-XG0SfB4R1wGE4vM9u5vbersMuz4K3gbnL_MMe4y_Ww>
    <xmx:ud62alq_OPdzrknA5oVx01n_ZSWKImEJj_k2qu-9E4rBDNL_N6sdyQ>
    <xmx:ud62aqM1wOQ-cbj_4RrhA6IPr99Bkbq_QryUoblS_slZmqbCzYP1Bw>
    <xmx:ud62al0daWkThamjQdqCjur5OaycTVC21F7fhja3VtBSShz92-Junw>
    <xmx:ut62aprIgRwNZUKguaUgUyuFEt4icjs2T-7CoiDZwgROtdrRDiw0LCPw>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 16:51:05 -0400 (EDT)
Date: Fri, 25 Sep 2026 14:49:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, David Matlack
 <dmatlack@google.com>
Subject: Re: [PATCH v2 0/4] vfio: Fix cdev second-open and harden selftests
Message-ID: <20260925144928.55a668d4@shazbot.org>
In-Reply-To: <20260911170429.1642480-1-alex.williamson@nvidia.com>
References: <20260911170429.1642480-1-alex.williamson@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 11:04:23 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

> v2:
>  - Re-try on -EBUSY reworked to harness issue and posted separately[1],
>    dropped here.
>  - vfio selftests subjects updated for consistency, Reviewed-bys
>    incorporated, Assisted-bys updated to current standards.
>  - Added the selftest suggested by David, but split it into two tests,
>    one that validates vf_token is not clobbered regardless of the 2nd
>    bind errno, and another that enforces the -EBUSY expected errno.
>    This allows us to observe that an old kernel fails both and avoids
>    conflating the uAPI expectation vs the underlying data clobber.
> 
> [1]https://lore.kernel.org/all/20260910230254.1198094-1-alex.williamson@nvidia.com/
> 
> v1:
> 
> In porting some testing infrastructure to a different system I found
> the igb selftest failing in mix_and_match and generating a cascade
> failure through the remaining tests.  The difference in the new system
> is the firmware error handling.  When the igb device gets wedged due
> to bad DMA in mix_and_match, we need to FLR the device.  The igb holds
> transaction pending asserted for the full duration of
> pci_wait_for_pending().  Meanwhile, firmware based error handling is
> triggering SMIs and stealing time, such that the 700ms total delay
> in pci_wait_for_pending() turns into several seconds.  With 10 cases
> in mix_and_match generating bad DMAs, the transaction pending delays
> alone push us close to the 30s per-test timeout.  The worst case I
> observed for the total test was ~45s.  Increasing the mix_and_match
> timeout to 90s provides plenty of headroom to get a passing test and
> avoid the cascade failure.
> 
> When the process is killed via timeout, the release occurs through a
> scheduled fput(), which is also delayed by the SMI storm.  Each
> subsequent test then sees a non-zero open_count (for the group open
> in legacy mode or on the iommufd bind in the cdev mode), resulting in
> the cascade failure.  Group mode already uses -EBUSY when the group
> fd open count is elevated, which allows selftests to interpret the
> failure as potentially transient and implement a bounded retry.  The
> cdev path instead returns -EINVAL for this case.  -EBUSY seems
> justified here and allows userspace to have compatible retry flows
> for group open and cdev bind operations.
> 
> A local sashiko review then found two existing issues.  First, in
> analyzing the exit flow from the iommufd bind, we can see that the
> vf_token and kvm pointers are clobbered by the second process before
> the open count test.  The open_count test in vfio_df_open() is only
> for the cdev path (!df->group) and is called under the dev_set lock,
> so we really only need to relocate the test to
> vfio_df_ioctl_bind_iommufd() prior to vf_token/kvm manipulation.
> 
> The second existing issue is that when executed via the kselftest
> runner, all tests have a 45s timeout, which is the cumulative time
> across each sub-test of the execution.  The pci_driver test already
> fails this with ioatdma, nv_falcon, and obviously with physical igb.
> Running in parallel across both ports of an igb on the system prone
> to SMI overhead, the worst case I saw was 450s.  Therefore, we not
> only need to extend the mix_and_match timeout to 90s to handle the
> extra transaction pending delay, we need to extend the default
> timeout to allow the full pci-driver test to complete when executed
> via the runner.  600s is picked here as a "sufficient" margin.
> 
> Please review and comment.  Thanks,
> 
> Alex
> 
> Alex Williamson (4):
>   vfio: Reject a second cdev open before mutating shared device state
>   vfio: selftests: Verify a failed second open preserves the vf_token
>   vfio: selftests: Extend mix_and_match timeout to 90s
>   vfio: selftests: Extend timeout for runner executions
> 
>  drivers/vfio/device_cdev.c                    | 12 ++++
>  drivers/vfio/vfio_main.c                      |  7 ---
>  tools/testing/selftests/vfio/.gitignore       |  1 +
>  tools/testing/selftests/vfio/settings         |  5 ++
>  .../selftests/vfio/vfio_pci_driver_test.c     |  2 +-
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 57 +++++++++++++++++++
>  6 files changed, 76 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/settings
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Applied 1,3-4 to vfio next branch for v7.4.  A respin of the selftest
is forthcoming.  Thanks,

Alex

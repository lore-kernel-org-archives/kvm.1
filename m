Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672186;
	b=DpzYynbCHNn5uhdPqyGbkmmgX383jyGA6B9j5fEnbOvJ7fK4W1ipYKbgjn10wl6gIJqD
	 LA6uVTHpaoYUlbhQ/VfEYdKFsLvIpJwWCqG/jRwzc7wOcqUp6BJPN9QSWuezxiL4YBgQL
	 JBcOXi8H7/2ahEuOmCd4ZR7P2w2xJymiUVlSLyfVZe8/xAGtX5fceLGaqz9vFG5GAo/RN
	 bKpzZYQVysaeub8/DKZ1s4RURNsMIISJ1l1Ktb1QHhS71SdQWXCHgwseZ2fg+Xkq04gA3
	 S2j+4thOi3Gwfovudfti0WoxvQkADn9YvQKkhn0/+NwT1KWwFSbnAYDQw9PbMmOp3hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672186;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ROsfRLpdEJgXSR8nSSa5tcU45iEtZe8T715ZMBCogsQ=;
	b=n+eGq4RF75TgEztmtQ8SaSIP973/hG1tfMd/TIIOCSNjscu8d4jJ9DXFO8+mxAiZ5qxW
	 BT8QN30hgasZVdbhDvN/tHL8RG9+KyQl6aBCBs09yNfe3Ih59R44MguBsoeCBwotfewf1
	 qR2Lj8M82XTqxEKKtHQ9f8m4CbcFudMxUDjqW5ep30xixewS37HOyxJiLb4YmOLVSqEK+
	 zEws4rAgZLqbQY5OidzSwQTv/AfWkEjWK8XyKLHG1iTzf2mOEOkzFJFDTF5OhaL7lQolB
	 ry7Q1o/XPFMJL65dmcfD4c2zGbP1FqEu7bY7fHDfuE40pK4r4F5r+2fDtQtIqwQA6OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=wFjS9Vfh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uYqncx3b;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B2606A31E
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E38B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=wFjS9Vfh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uYqncx3b
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CF7A7A059A
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:49:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Nov 2026 00:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795672184;
	 x=1795758584; bh=ROsfRLpdEJgXSR8nSSa5tcU45iEtZe8T715ZMBCogsQ=; b=
	wFjS9Vfhyz2LnAU9s/qbug4NnzRRg6qf6//8GTh5sHJScOjMSv4NXQstsaeWCalJ
	CcWz/LSw8JF7xFncDedh51kDesHUbXMuoklJmzkl1BUXjbA3ASlEhNsvxNUkYP4u
	YURngAP+8cvVPcDuFqNAORys/GCJHC/5+hi3kpUDRKpSt0azf100Mjd22CAcepvH
	qvO8kUIErIMQV54FbfboDNyUDX50U17DXhuUXREKOOXtHcirpYZFzDOTKBIL3Nys
	hau+hnHV/h8xzEOZvSf14LrDUn4vKsQXuUY5EMUadL2eAzJ9pnbLvCoDQ7wUqfg2
	4OtH/L/rxR1Q6r5r8UFruA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795672184; x=
	1795758584; bh=ROsfRLpdEJgXSR8nSSa5tcU45iEtZe8T715ZMBCogsQ=; b=u
	Yqncx3bQ7ThsV8IneyXeZpob6+ar9DSoN/TRWl9ZDplneKzpjYBwlGA/XoFOoicN
	GGGFnvnNScGnrkiHAcXVNCDeWdUVt7MpNEaHwQsB6cgcPl8Dp4Y7A3Nifo3iB8iJ
	0pR/jbmglSwsS0ba2+jNEWo/d1rbpWYZZUMaCeCVimQdUUOnmUkObFsvITbfQBKH
	yp8tLQVWtUmyjdHjPfatrhuEzYuSACLJRvJj1S7mIR1t8QI5fq+Q2zgN4iCxXzbI
	2MLNaUu5Ka9VIncnQ6I9oRE2ujJkZFpp1rhwnqGEjpLo/6RnTF5c+wb4bNzYBu8A
	M+6VfPOtjQ3IqhzwtMKBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795672184; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F0YSmTFBgO13wE6k4d2D8ONMAYv+TX75vot5lXMES09pcSj
	dajRfOxcZOIkNYnLwyK2YAbdKbDN7u3qN6xJG5BkxMJ3z78iypJD4Mhuz4L+N/Dz
	at2njnfskIrMkA7c+Jm8dzltmbAG2YF8m+CE1ap0abeMg1YyFQhOJTmoY+QAq0x2
	MLdCNhFeoqFYypXWhY4+xVM5ebkXdBivkDY00SflvaZrt/zDuyIcjoHBwAAClJKn
	94/S4qiBUug6UdUY+ltKvAK7XWBwrLKB/S4GWiyc2pTe9DYkuaYt7jHxN0oIZKaI
	/mB5Ijvn0utN7+7yXJvDVzQnF0WZv7NsphwSlaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Bl9nqCp27kWf/5oaah6vaGsU/urBWQkRux33v27ERGk=:bvVZ2VjFXPUSSpGG+gCRa91836uS+Xfd/3DHxC4aQlw=;
X-ME-Sender: <xms:d8gHa_sRilcYTwsFIkuv2J-SykIrWrX4E6egxtqo_ZBFu_h8s01mUw>
    <xme:d8gHa8cnDXBPj5F6YM_YHzs9u7AS0c_wKXkLsRJkOcE_giKn_8h3XDS2TeXD-bMyT
    8zOW7GiPRZ1VMpg10MwVScaPKxy3dXIepoZKih6zQtR33mBYyQCSns>
X-ME-Received: <xmr:d8gHa08KjkeDgVxqR7hY_twPOU77FREP7ebsB_yczAZCSVS3ZO8NvQx7ULsbfw>
X-ME-Proxy-Cause: dmFkZTFi0nTlvohmCVAJNLLMlX3lgAxsFQmaXQmm/aZNO42lYjHHtYS5y5q2gwSfmkfhBb
    oIyNARm77oErHFmFqZ4Yz47HvtuqHhKSsbUqS/pDkY4Rsw8BX2FfO6eDvxfiiYtCuzEpOe
    gNuSf8o5Qw+8ZOVhYYQgxBm4/AWzvPbNUjxeW0/oGTRGIfM4ffqyF85FBiZ6LxVnOXjvKG
    Elf5rDwSIUpBTYbvVCsxmp3U54ArzdHCSjGnolJsAHps+x5kfkWGjSgMGo/bOKCJ0l3bbL
    8obBIseBxXitWtsLTCBdAJOGeSKPwQnI/8GdWpF0wMjV6kxmlRmzmmaBh5uRnVSL+UrNJF
    kDITyIS1wCXkGRZF/g7safZvf5xIXxt72zbyQH6ql4X5q1I9Qc1vLg5TcRZ7e2ZEx4j7LX
    QQdvdwjjPLhiaut1E/JHfWHGfVHnz1zQgZv0uAOyQsJ9ER3EvGWPmceJUV9O52MlwL2uDy
    1oS5Q9SIKScBTGlehAoGxU+JUNJK8Cece3bvlHvgLcVNiwM30lzfYUafMghDgGeOXehopP
    ppXlrj+t6MDGQpsnPoSJHJp6oCjL9Bf5HnF99Yuv102lUfRhNGsIBDuWG10S+kd7b6eGYG
    d8lvx4JcOBEDg8QHMB3kDpwzDRvhsV0lGzg9rcI4L6eArmGF4YzslJzn9fEQ
X-ME-Proxy: <xmx:d8gHa_Q9RUr4yEOyHJYr0DyuUBhIXfV-SAhCYXIXnr0hN7_Nnm8NoQ>
    <xmx:d8gHa9ptMhGbF7cnWNFSlsCYmAcOAz2Pu5aA8Ng0YMRr2vk5H-po3Q>
    <xmx:d8gHa0lXr_-fer-AdI354tQ3y64yi9n1XfK0p6OCxvQq4YUVdoNcLw>
    <xmx:d8gHa-fv36xc0Io0NqWZyKDI7Q4rV86x9u7J1JoBHmVoDimpvuKztg>
    <xmx:eMgHa2W5CDuHlQnB1PVJia4XJaX1dA9H5hJws0cBOwMo-JsoX1l1H0jC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 00:49:42 -0500 (EST)
Date: Wed, 25 Nov 2026 22:48:58 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v3 0/5] vfio: selftests: Automatically detect the IOMMU
 mode
Message-ID: <20261125224858.0aaf4f1b@shazbot.org>
In-Reply-To: <20261109210833.1250548-1-dmatlack@google.com>
References: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 21:08:28 +0000
David Matlack <dmatlack@google.com> wrote:

> This series makes the VFIO selftests library automatically detect which
> IOMMU mode to use, rather than hardcoding iommufd as the default, and
> makes tests skip, rather than fail, when the IOMMU mode they need is not
> available. This was suggested by Sean while reviewing the KVM selftest
> irq_test [1].
> 
> iommufd is an optional feature, and VFIO's iommufd support additionally
> requires CONFIG_VFIO_DEVICE_CDEV. On otherwise functional kernels that
> only support the legacy VFIO container, the VFIO selftests currently
> fail with an unhelpful assert:
> 
>   tools/testing/selftests/vfio/lib/iommu.c:448: Assertion Failure
> 
>   Expression: iommu->iommufd > 0
>   Observed: 0xffffffffffffffff > 0
>   [errno: 2 - No such file or directory]
> 
> irq_test avoids this by probing for the IOMMU mode itself, but its probe
> picks iommufd whenever /dev/iommu exists, even if VFIO device cdevs are
> not available.
> 
> Patch 1 makes iommu_init(NULL) pick the most preferred IOMMU mode that
> is available on the current system, and drops the global
> default_iommu_mode.
> 
> Patch 2 adds iommu_mode_is_available(), iommu_mode_unavailable_msg(),
> and SKIP_IF_IOMMU_MODE_UNAVAILABLE(), and uses them to skip tests when
> the IOMMU mode they need is not available.
> 
> Patch 3 makes the VFIO selftests library print the names of all known
> IOMMU modes when passed an unrecognized mode, and the names of the
> available modes when a test skips because the mode it requested is not
> available. It also adds iommu_mode_names_all() and
> iommu_mode_names_available() so that tests can print both lists.
> 
> Patch 4 converts irq_test to use the VFIO selftests library to pick the
> IOMMU mode, and drops its probe_iommu_type().
> 
> Patch 5 lists the known and available IOMMU modes in irq_test's help
> output.
> 
> This series is based on vfio/next (vfio-v7.4-rc1).
> 
> Testing
> -------
> 
> Tested in a QEMU VM with an emulated igb device behind an emulated Intel
> IOMMU, bound to vfio-pci, on a kernel with CONFIG_IOMMUFD=y,
> CONFIG_VFIO_DEVICE_CDEV=y, and CONFIG_VFIO_CONTAINER=y. To simulate
> kernels with fewer IOMMU modes available, /dev/iommu and /dev/vfio/vfio
> were deleted in the VM:
> 
>  - All IOMMU modes available: All VFIO selftests pass. irq_test -d
>    passes using iommufd. irq_test -h lists all five IOMMU modes as
>    available, and irq_test -d -t bogus fails and lists the known modes.
> 
>  - Only the legacy VFIO container available (/dev/iommu deleted): All
>    VFIO selftests pass. The iommufd and iommufd_compat variants and
>    vfio_iommufd_setup_test skip instead of failing. irq_test -d passes
>    using vfio_type1v2_iommu. irq_test -d -t iommufd skips and lists the
>    available modes, as does irq_test -h.
> 
>  - No IOMMU mode available (/dev/iommu and /dev/vfio/vfio deleted): All
>    VFIO selftests and irq_test -d skip with a message explaining why,
>    and with well-formed TAP output. irq_test -h lists no available
>    modes.
> 
> Also tested with CONFIG_VFIO_GROUP=n (cdev-only VFIO):
> 
>  - All VFIO selftests pass, with the iommufd variants running and the
>    vfio_type1* and iommufd_compat variants skipped. Without the VFIO
>    group check added in v3, the iommufd_compat variants fail instead.
>    irq_test -d passes using iommufd, and irq_test -h lists only iommufd
>    as available.
> 
> Changelog
> ---------
> 
> v3:

Applied to vfio next branch for v7.5.  Thanks,

Alex


>  - Require VFIO group support (CONFIG_VFIO_GROUP) for container modes,
>    including the iommufd_compat modes (patch 1) [Sashiko [2]]
>  - List the available IOMMU modes in irq_test's help output, alongside
>    all known modes, and when the requested mode is not available
>    (patches 3 and 5) [Sean]
>  - Simplify the -t help text in irq_test (patch 5) [Sean]
>  - Make the unrecognized IOMMU mode error easier to read (patch 3)
>    [Sean]
>  - Rename iommu_type to iommu_mode in irq_test (patches 4 and 5) [Sean]
>  - Skip vfio_iommufd_setup_test when iommufd is not available (patch 2)
> 
> v2: https://lore.kernel.org/kvm/20261103002205.3348519-1-dmatlack@google.com/
> v1: https://lore.kernel.org/kvm/20261029221710.1871112-1-dmatlack@google.com/
> 
> [1] https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/
> [2] https://lore.kernel.org/kvm/sashiko-outbox-194380@kernel.org/
> 
> David Matlack (5):
>   vfio: selftests: Automatically detect the IOMMU mode in iommu_init()
>   vfio: selftests: Skip tests when the IOMMU mode is not available
>   vfio: selftests: Print the IOMMU modes when a requested mode can't be
>     used
>   KVM: selftests: Use VFIO selftests library to pick IOMMU mode in
>     irq_test
>   KVM: selftests: List the IOMMU modes in irq_test's help output
> 
>  tools/testing/selftests/kvm/irq_test.c        |  32 ++--
>  .../vfio/lib/include/libvfio/iommu.h          |  43 +++++-
>  tools/testing/selftests/vfio/lib/iommu.c      | 139 ++++++++++++++++--
>  .../vfio/vfio_dma_mapping_mmio_test.c         |   2 +
>  .../selftests/vfio/vfio_dma_mapping_test.c    |   4 +
>  .../selftests/vfio/vfio_iommufd_setup_test.c  |   2 +
>  .../vfio/vfio_pci_device_init_perf_test.c     |   2 +
>  .../selftests/vfio/vfio_pci_device_test.c     |   8 +-
>  .../selftests/vfio/vfio_pci_driver_test.c     |   9 +-
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c |   4 +
>  10 files changed, 205 insertions(+), 40 deletions(-)
> 
> 
> base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b


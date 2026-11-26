Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672190;
	b=SPh2JMyr+cGFaP6KPC5e1rfYMYS13jKRABh3oSi3QNywf/E7fjG73Gi7VD83AeGxddZn
	 MPpcjifCXnCJm6NyFnPmhPaPC0+dMnn6KC1ei7oIvbavUtm212XdTnp7+YnEw201+gGV1
	 p3SJUgUxfZ8OfSyTVVGey03NyMMK1bbO+hV4fYIO9p0rtxCuPpdx+U8TyzLD0jFk9TSZk
	 bzbciyH5DEOTb6Sx2WysGozX429KYCFf+vdw3SgawZyUBBIlPW1nIhwb/JVI/4XYukxCF
	 NDcC2LW1lF0s/O7b+lTAb8ioCE0VQbI1V3q8L6pKCvQlA9HZftn1kDtFMm8boe+6TlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672190;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0uVTpFNR/9P+vhvxOP2N+gzyg3S+abaI3QgS2GRYEPY=;
	b=Q/aae5r7F2/aAZVVlw3tnuAEAJxmWVJz2QzbOm73GyHLnttq1hC+CZGzfXfcZFBr3EHV
	 FmhWqIZu6+ON04xvwIx4+///1heMv/hoNbj4rAJQa87qlgqBZjQn+oRxJi9mkFJ+znR/w
	 22pYoBMUCpydtk68EvCdhXC7BryCIZ96/8NktfCxrdUPFI5J/V6ntPWtHDnH32Jh46kSr
	 nMy3l4SymFZ6R+edI9rNJodESYD1gML45cfpZQZZncBao67mIiG7dop47HNyMdV+iWZ4i
	 3W7wnHWI0yISulbX3YfSVMrVORAKP7Ewk0K4L/IoVlfYizpanCV+3zfC4iHl7W+niDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=rm2avG75;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uFTvMshW;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38400606A321
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38400606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=rm2avG75;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uFTvMshW
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5053F1D00592
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:49:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 00:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795672189;
	 x=1795758589; bh=0uVTpFNR/9P+vhvxOP2N+gzyg3S+abaI3QgS2GRYEPY=; b=
	rm2avG75zZTHD1eLVFy3LhyzPCVqIpwzVjWE1juh0/ph72oH+VARZEqL99xVvKj1
	+ZYc0qzsl5irInQVXDkii+B5T5pBOLVRZjPn973yMNeGoZi2i9nWsMibpICqw3TF
	f/IkKSD0DvTlKN8XtxRxjFh3Bcf1rQ9sTVEBMEOOWJWNUW922D6DPOPVHzaE704Y
	NUOVdfeYb13CEQf9icboAUkjlj0aQCMyzLk6Iidnuz2HyEZBK0zk81n4T0gbX/2F
	xJ+OnA8Gj+XqAFDwceDsoL39PN17MZbD9tlrnnMnfqT00PUcf134su4Ldzf7IunD
	iPypeaQVf+kOBFz7xw0Xaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795672189; x=
	1795758589; bh=0uVTpFNR/9P+vhvxOP2N+gzyg3S+abaI3QgS2GRYEPY=; b=u
	FTvMshWrC0Da9I6+ZgxkdHiJk6HEzDIelmmzZpA8ut2n6pQHXQca0AhhhQkkcc4G
	fLd7spW5BlxeKoCrceY+3yTPb8GZga+wVqcQRrSBtkufhzkJRbzpZOylEvuN+XZz
	L0VctQAtAhccHb6nnisI2+ofbTj+Qf+Emm0zSE3F+p2VaWtLLc1NSu9fgav5J3Oc
	TUHd/L2NA435BWVGef+K12m3v5p6sRQKcs1B/tk0nVXBStC4wJ7HdXruJy0/MEiR
	+gfqJ67UPqD8p9Qxj97hDjWYSuMkNq4rzlcFjVeRBolwK+DxhAtfjeNMJOVddjJL
	s5xOOElirIWmrlYTscHfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795672189; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:a8lcjiKhqoYM+0zC41oomOguhD4WExdsPGW/bB1zC/7mUH7
	gnT0r9x57rD2TGgDBp4f+IMc9kdL5HlHdPRCYofnZDhVbEagIEO5NWVc6Ki2HSOA
	1Wb3QJxEnDbRkighuXoK6i0SvLz6yl7rlra54NH08c/Eiv/KEHgF4B8+7S4cbo1T
	lkzOWw9y69ANyVp/ntcTdif7DC7MsPBoMxVLAT1Tz5+ghbh4eP7IyVb5g1oIm1qu
	BC5aEK/csts92Uix4tXo4a0N8zd3FOo1A1cqhmZzmAWvekvO8XFGg5OykoC+l3/7
	0oia/P0tejPpXSLhlniJermk3em0w9SzGcAZyLw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mAEq1nfZfejPKkYPcHP9yu5hV2juPevAmo143RT0geU=:h7qyzkaVfI7r88LpF2NTyqyEiitTyCNZwWLx4X3m18c=;
X-ME-Sender: <xms:fMgHaw1CW6Tvuv7DOR3QYhgL9zEB6Qhwkq-XkFYRwhTNQ_hAbbEMUA>
    <xme:fMgHazTeoORJaZl9HUlRd4sWxruUdnROdfbljy7wpvDhllBwDED1RtXR3lgsjteSq
    C8vR9YwTOraB5Ik4qy1q9fDwsYb69PepvMc9VWf5mffvyep_t4tkQ8>
X-ME-Received: <xmr:fMgHa0cWjFnNqAu_TaKTx4dVT-VrXJS-O-wkkX4uL6W2xREDDikxQFZ4gPHs-g>
X-ME-Proxy-Cause: dmFkZTEV71Ww8gm3BDcW3FtVwkUBdrFKWw7uNacMF9dPRsbcD7gqvRhoponF3jTow3SUnS
    X9/UECgqok4WkryBiQEIaFV8IpmrM7f3U+7wzKn6uqn/eqv63Myt0N9xXsiMJyCdAw9p8F
    RNRJBTG0/BVmL9QHHUsuoJatq0QixT1LLoMPNoay0F+ky1zodTjV5UtEny1E9Ppjtp3gT7
    C0LJsPgZAGy9s4xL9a4ojQh7cS2b1eYcvpChLlw85hlfUsjNM7oYZPJc19EXhnwDBCvjNK
    qGaJHpm1WcIQyH9JWEWbWiKNzqxycQipn1uZGUkIV1pwjz3OZYTOHI5CatzAC6EWt2ATj5
    EL4cWjz2xhmSb0GJDOLnnZPZOYE6li0wtp+UWbs3KVgwgHF2VP8G8djin2R4h4K8w8HoVM
    k/QNO+gbuijXTj78G220MPZvsyHBIlLPuJPYGPfIJY6oUPEebXRy/QbzNTE2PA5cnqaRQa
    W2Do4V1+sCmNESHxVJQ4sihvSuGsNEIAAM4kKPPRnhmnsutCIBRu3DquEnKLdOy8sps7iS
    ppOWl79wTLILIWlmRm1kgmZ0viRCoqNN3gbNEFeY0ifuRxB1i8qYtLyVIlQI5W8QuOYq9u
    AytkKCTdoKMGHjANPebuP97qPAGMgBkTp1ijiz0byQBX+azKif3dwift4+Rg
X-ME-Proxy: <xmx:fMgHa0fMlXqzJaUv5ior_uNzUAP9YqyHDWaQZGue6M3Jpnow2zoXRw>
    <xmx:fMgHa-0HEqKzbK1NQxEaDftjPZdQ8Y_fy8J-ofRfidy3nLxir7IDBA>
    <xmx:fMgHa88gLQD8kTKF-GPxCsoYHaxW2BGMK9dzos70PLaDLwnpUoTPrg>
    <xmx:fMgHaz4NUC86Ng7M1ZeSvV2iS-z01aJ7MQYsJZAo61mT2pLTnYjWhg>
    <xmx:fcgHa1twdv6sxoDOb8Fz6obLt80cCS1nYFz8LOr4NRtcDAF675Oj-6qk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 00:49:48 -0500 (EST)
Date: Wed, 25 Nov 2026 22:48:50 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, Abhishek Sahu
 <abhsahu@nvidia.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah
 Khan <shuah@kernel.org>, Vipin Sharma <vipinsh@google.com>,
 alex@shazbot.org
Subject: Re: [PATCH v2 0/8] vfio/pci: Fix power state race with SR-IOV
 enablement
Message-ID: <20261125224850.3bdc290a@shazbot.org>
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
References: <20261119000151.442543-1-dmatlack@google.com>
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

On Thu, 19 Nov 2026 00:01:42 +0000
David Matlack <dmatlack@google.com> wrote:

> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/vfio/set_power_state/v2
> 
> This series fixes a race between closing a vfio-pci device and enabling
> SR-IOV on it, both of which can transition the device from D3hot to D0
> without being serialized. On devices with NoSoftRst-, this can restore
> the PF's BARs after VFs have been enabled (triggering a WARN in
> pci_iov_update_resource()), or double-free vdev->pm_save.
> 
> This series also adds a selftest that exercises VFIO's handling of
> power state transitions requested by userspace through the PM
> capability, including a test case that reproduces the race.
> 
> This series applies on top of vfio/next (vfio-v7.4-rc1).
> 
> Series Overview
> ---------------
> 
> This series implements the following:
> 
>   1. Hold memory_lock for all calls to vfio_pci_set_power_state() and
>      assert that it is held, which fixes the race (patch 1).
> 
>   2. Annotate the intentional lockless accesses to vdev->sriov_active
>      with READ_ONCE() and WRITE_ONCE() (patch 2).
> 
>   3. Skip vfio_pci_sriov_uapi_test instead of failing when SR-IOV
>      cannot be configured on the PF, e.g. because vfio-pci's
>      enable_sriov module parameter is not set (patches 3-4).
> 
>   4. Add library helpers to find a PCI capability, read
>      /sys/kernel/warn_count, and print kernel warnings from /dev/kmsg
>      (patches 5-7).
> 
>   5. Add vfio_pci_power_state_test, which covers closing a device in
>      D3hot and reopening it, enabling SR-IOV while the PF is in D3hot,
>      and racing a close in D3hot against enabling SR-IOV. The test fails
>      if /sys/kernel/warn_count changes during a test case, and prints
>      the warnings logged to /dev/kmsg to help debug the failure
>      (patch 8).
> 
> Testing
> -------
> 
> All patches were build-tested individually. The series was tested on
> x86_64 in a QEMU VM with an emulated Intel 82576 NIC (igb), which has
> NoSoftRst- and supports SR-IOV, bound to vfio-pci:
> 
>   - Without patch 1 (KASAN kernel), close_in_d3hot_races_sriov_enable
>     fails, hitting the pci_iov_update_resource() WARN on 9 or 10 of the
>     test's 10 iterations.
> 
>   - With the full series (KASAN and lockdep kernels), all VFIO
>     selftests pass with no warnings, KASAN reports, or lockdep splats.
> 
> To run the new test (the SR-IOV test cases are skipped unless
> vfio_pci.enable_sriov=1):
> 
>   # tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0
>   # tools/testing/selftests/vfio/scripts/run.sh \
>       tools/testing/selftests/vfio/vfio_pci_power_state_test
> 
> Changelog
> ---------
> 
> v2:

Updated to use iommu_init(NULL) in 8/8 to account for automatic IOMMU
detection and applied to vfio next branch for v7.5.  Thanks,

Alex


>  - Rename close_in_d3hot to reopen_after_close_in_d3hot and clarify that
>    it does not verify the D0 transition during close, since that is not
>    reliably observable from userspace (Alex)
>  - Print the kernel warnings logged to /dev/kmsg when the warn_count
>    check fails, so the failure can be debugged from the test log (Alex)
>  - Drop the claim that memory_lock protects the sriov_active check from
>    the comment in vfio_pci_set_power_state(), since it is cleared
>    without memory_lock
>  - Skip the SR-IOV tests, including the existing
>    vfio_pci_sriov_uapi_test, when SR-IOV cannot be configured on the PF
>    (e.g. vfio_pci.enable_sriov=N) instead of failing
>  - Use kernel-doc for the new library helpers
>  - Clean up commit messages, comments, and the cover letter
> 
> v1: https://lore.kernel.org/kvm/20261029203324.1637772-1-dmatlack@google.com/
> 
> David Matlack (8):
>   vfio/pci: Hold memory_lock for all calls to vfio_pci_set_power_state()
>   vfio/pci: Annotate lockless accesses to vdev->sriov_active
>   vfio: selftests: Add __sysfs_sriov_numvfs_set()
>   vfio: selftests: Skip vfio_pci_sriov_uapi_test if SR-IOV can't be
>     enabled
>   vfio: selftests: Add vfio_pci_find_capability()
>   vfio: selftests: Add sysfs_kernel_warn_count_get()
>   vfio: selftests: Add helpers to print kernel warnings from /dev/kmsg
>   vfio: selftests: Add test for device power state transitions
> 
>  drivers/vfio/pci/vfio_pci_core.c              |  16 +-
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../selftests/vfio/lib/include/libvfio.h      |   1 +
>  .../selftests/vfio/lib/include/libvfio/kmsg.h |   8 +
>  .../vfio/lib/include/libvfio/sysfs.h          |   2 +
>  .../lib/include/libvfio/vfio_pci_device.h     |   2 +
>  tools/testing/selftests/vfio/lib/kmsg.c       | 134 +++++++++
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
>  tools/testing/selftests/vfio/lib/sysfs.c      |  66 ++++-
>  .../selftests/vfio/lib/vfio_pci_device.c      |  36 +++
>  .../vfio/vfio_pci_power_state_test.c          | 256 ++++++++++++++++++
>  .../selftests/vfio/vfio_pci_sriov_uapi_test.c |   8 +-
>  12 files changed, 512 insertions(+), 19 deletions(-)
>  create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/kmsg.h
>  create mode 100644 tools/testing/selftests/vfio/lib/kmsg.c
>  create mode 100644 tools/testing/selftests/vfio/vfio_pci_power_state_test.c
> 
> 
> base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b


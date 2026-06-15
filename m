Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6D3A784A;
	Mon, 15 Jun 2026 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563136; cv=none; b=QzJWE5JF3aLG9oa184vWJeehdOmWuSju8vfIcVXQF6SIsRP2+IBXhcqflluDOSdmbJfhBwcjacMD/NdvDCDInIS0tF97IAhOpPXp4nDHey+mHEDPKAfKiGIxSvVrLQ/H3Iu8X+iNcac3knx5vUNTWZR9Qi5VUN35o2dM6Gql/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563136; c=relaxed/simple;
	bh=0FGm6EPk35Nhw+fxHhVJS14EBAS2uM9knFTOzoraCFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PMOhvwXzuSSYwno1a4ufSZi9lxt3GZ+YCEG7Pe0N73hehZ13mXTS08tfc9o/CBPKZqAQGFY3IEXfI53CZVO0YyG2ye1OOWMDXSU+4NJJ+BGWzSw2nqUvfx24/awK54+Hje1L+lAhC+qa+aXiFlk4JnghWu5zBOgGovUbt13/Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=acKrZ//g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYuZ7KdU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="acKrZ//g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYuZ7KdU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CD317A0169;
	Mon, 15 Jun 2026 18:38:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 18:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1781563133; x=1781649533; bh=Mz
	VSeL5EQ6Hj70/AvudpQh94sKeVo/GsIxK7gsJDmB8=; b=acKrZ//g0n8gYcHkcb
	+dp/VewdFpHyhM19kHIlf0nDZcKYR0VS7FRBZhIrJ9qp6Chu+dt0hlMTwn7j+Aex
	4KfZ2QKZ7FHj/6rBvtOChk2n2KMywx7MCk/ISoib8VKGznVSYU8Ierz6yba9O1Wk
	HrKTLCe/+xYrFWB3y65jAAydVZzb6KtXSM6mn06azzlCw9s+m3vjcyuMC5td7RnU
	Va14NtnPlIl++kNlbZd66CwJ4tXd2v7WizoDzc4BS5tPayCgtSfiy7/q6EOUY3Qs
	PphQZuj2pZzMg1RO15Jgcckvw+yMav+N2W0JRhCB0zm0mzAMrmuudzLoP7YuR6eW
	TvlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781563133; x=1781649533; bh=MzVSeL5EQ6Hj70/AvudpQh94sKeV
	o/GsIxK7gsJDmB8=; b=EYuZ7KdULdq5tuAzgnBqGuNrBOfoHRHXhLDpq/z6GDzU
	PXIOQLgLSxuH6qrxuE9KqfZXovmHCJcv/xK4ATkC3jHnoc8REPQakR/e+1uwPR4x
	HazGDItWkffdKKHwO4CCZhaM+yh5cqvb41MPR+XCs/lnyRBC94ZN6wfEt3idc9os
	oym+oahxcjljw9cK5PvOK9hMCYdJfTUC/dX2lDXgfSQVFAuu8xgWsy+wQTNkV9+5
	4xaCFSOZHgR32pPyuu7vfQ7nfyqirkTrPQRiOGr7ieuTXQYzzvxgbK8reiCNE0OZ
	afYh8PKv6hG5tU1XnD9e2hMtabqyk9SuJQSsWQXQ/w==
X-ME-Sender: <xms:_H4wamdfddPlNnH9RgG8gXpv06BqOkV6-kR20qbrzMPnNRFG8_Wwlw>
    <xme:_H4wauA2xJqzsvfwz0Ls8w9R9J91986wyEKANJpfNf6oPyI-OSDfjLxQXe-uL1KLr
    qxzug22T8qlCUGYgHzfhadxojIe5sXq7LH-ND86uzjL1NzQdrzg5w>
X-ME-Received: <xmr:_H4wah_TmbJDAI1vPHU64QmF0gtctmKM7rJfujxVjjPFFP711gm68YLoQog>
X-ME-Proxy-Cause: dmFkZTGY0wRvQhwCHI+db/Hm34bctQfk6RAmDsq4ya8eneEueSHpQ5v/RFhejkcgWdXIsv
    hUeio4D+61PSKTLi7/nPp0uMGfgpE9XV2a4a44UBtLNDHUQZJaZF6Bu78ps/FPN3SPt+dt
    lU0z3/C4XX1ptRTA3wzICKR6O+JeYKf2LdOVYd1hl3YT+BkaV3cN9ymKfScW476qqeUurE
    vcps5Y8gqzs1HvVFOKYmaMyKgrXIkC+EzYM8rFkTyx2Yt+4ohkQKHKQFvoWZLiq2dUn03q
    MX8HbHOs+wPELxr2MSxDujFWhUeU3bSFBfenMNeDDwDQUzwfklb+FuulJ3Hulj43ZA2sB7
    oj0Id0sBTAOXzKFXZK8X0zxtmNcHPAKmHBCR69gtmwLNlT8k0quIRNQ9ZD04sKLdis0oZT
    feQFe+dHWNqTzOofX6Ws+Uo5vMnu1OqsgAwP5KCX9UGjggeYcABy74/qyrJ96bb9eUUEjb
    NI5TepkiZ28rdsqTj5fxwR3sX3zbOhQgr8FfLvN5+NimDwO8DUjgIHbr8VI69UruDW9spC
    BXYK/GXULYQuyg7xmLFdrbaTHq0oazs6mF12c67RD4KwABX9SpEsL222bbj9fcfhxg1QjI
    v7jBqKfhrVF2aozQMPjpXyh3HAv9z2X6iN09Lwt/Gl4atFRNP7hEYN2PaDFw
X-ME-Proxy: <xmx:_H4wahIMVxAGr4rNlwfKNtsqEorctCns3gAKDi73WImbHYJx9Koc6w>
    <xmx:_H4waihja24arRqO39SovieHCslj3LjWxEWFQKYKjObEUIE9aHv2ag>
    <xmx:_H4wap4O3LK8SfmzZ3Aa2vBA8fJsWMNSdzLodw2vM2Xlouiv9GVvbQ>
    <xmx:_H4waibAjv3XNnxwCXN1H7Z4hcvVWp3RGlJvZxRyvAQHtpdw6_uByQ>
    <xmx:_X4wan7coMjnmlBYJwpMreghae9VfOFOGJ0x2ue3lPJ6_YbzhV2O_wx3>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 18:38:51 -0400 (EDT)
Date: Mon, 15 Jun 2026 16:38:49 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v7.2-rc1
Message-ID: <20260615163849.5b6ac84c@shazbot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.2-rc1

for you to fetch changes up to 785562e31dbcd85ca583cf58c446e63aa8a5af08:

  vfio: selftests: Ensure libvfio output dirs are always created (2026-06-12 10:25:44 -0600)

----------------------------------------------------------------
VFIO updates for v7.2-rc1

 - Fix out-of-tree vfio selftest builds with make O=. (Jason Gunthorpe)

 - Allow vfio selftests to build when ARCH=x86 is used for 64-bit x86
   builds. (David Matlack)

 - Tighten vfio selftest infrastructure with stricter builds, safer
   path handling, sysfs helpers, and reusable device/VF-token setup.
   Build on that to add the SR-IOV UAPI selftest across supported
   IOMMU modes. (Raghavendra Rao Ananta)

 - Conclude earlier vfio PCI BAR work already taken as v7.1 fixes by
   replacing vfio_pci_core_setup_barmap() and direct barmap[] access
   with vfio_pci_core_get_iomap().  Fix resulting sparse warnings.
   (Matt Evans)

 - Simplify hisi_acc vfio-pci variant driver device-info reads by
   using the mailbox's new direct command-based read helper.
   (Weili Qian)

 - Avoid duplicate reset handling in the Xe vfio-pci variant driver
   reset-done path. (GuoHan Zhao)

 - Resolve a lockdep circular dependency splat by tracking active
   VFs with a private sriov_active flag rather than calling
   pci_num_vf() under memory_lock. (Raghavendra Rao Ananta)

 - Add CXL DVSEC-based readiness polling for Blackwell-Next in the
   nvgrace-gpu vfio-pci variant driver, including interruptible,
   lockless waits to support worst case spec defined timeouts.
   (Ankit Agrawal)

 - Prevent vfio_mig_get_next_state() from spinning forever on blocked
   migration state transition. (Junrui Luo)

 - Fix a qat vfio variant driver migration resume race by taking the
   migration file lock before boundary checks. (Giovanni Cabiddu)

 - Add explicit dependencies between vfio selftest output object files
   and output directories to ensure directories are always created.
   (David Matlack)

----------------------------------------------------------------
Ankit Agrawal (1):
      vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness check via CXL DVSEC

David Matlack (2):
      vfio: selftests: Allow builds when ARCH=x86
      vfio: selftests: Ensure libvfio output dirs are always created

Giovanni Cabiddu (1):
      vfio/qat: fix f_pos race in qat_vf_resume_write()

GuoHan Zhao (1):
      vfio/xe: avoid duplicate reset in xe_vfio_pci_reset_done

Jason Gunthorpe (1):
      vfio: selftests: Fix out-of-tree build with make O=

Junrui Luo (1):
      vfio: prevent infinite loop in vfio_mig_get_next_state() on blocked arc

Matt Evans (2):
      vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
      vfio/pci: Fix sparse warning in vfio_pci_core_get_iomap()

Raghavendra Rao Ananta (9):
      vfio: selftests: Add -Wall and -Werror to the Makefile
      vfio: selftests: Introduce snprintf_assert()
      vfio: selftests: Introduce a sysfs lib
      vfio: selftests: Extend container/iommufd setup for passing vf_token
      vfio: selftests: Expose more vfio_pci_device functions
      vfio: selftests: Add helper to set/override a vf_token
      vfio: selftests: Add helpers to alloc/free vfio_pci_device
      vfio: selftests: Add tests to validate SR-IOV UAPI
      vfio/pci: Use a private flag to prevent power state change with VFs

Weili Qian (1):
      hisi_acc_vfio_pci: simplify the command for reading device information

 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c     |  39 +---
 drivers/vfio/pci/nvgrace-gpu/main.c                | 180 +++++++++++++++--
 drivers/vfio/pci/qat/main.c                        |  16 +-
 drivers/vfio/pci/vfio_pci_core.c                   |  28 ++-
 drivers/vfio/pci/vfio_pci_dmabuf.c                 |   2 +-
 drivers/vfio/pci/vfio_pci_rdwr.c                   |  30 +--
 drivers/vfio/pci/virtio/legacy_io.c                |  13 +-
 drivers/vfio/pci/xe/main.c                         |   2 -
 drivers/vfio/vfio_main.c                           |   3 +-
 include/linux/vfio_pci_core.h                      |  21 +-
 include/uapi/linux/pci_regs.h                      |   1 +
 tools/testing/selftests/vfio/Makefile              |  11 +-
 tools/testing/selftests/vfio/lib/include/libvfio.h |   1 +
 .../selftests/vfio/lib/include/libvfio/assert.h    |   5 +
 .../selftests/vfio/lib/include/libvfio/sysfs.h     |  12 ++
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  11 ++
 tools/testing/selftests/vfio/lib/libvfio.mk        |   7 +-
 tools/testing/selftests/vfio/lib/sysfs.c           | 150 ++++++++++++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 157 +++++++++++----
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |   6 +-
 .../testing/selftests/vfio/vfio_pci_device_test.c  |  21 +-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c      | 217 +++++++++++++++++++++
 22 files changed, 775 insertions(+), 158 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
 create mode 100644 tools/testing/selftests/vfio/lib/sysfs.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c

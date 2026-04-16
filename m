Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB81A14E2F2;
	Thu, 16 Apr 2026 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311362; cv=none; b=oX5qJ8R49KOfRylfEg4fGe0Ujs02Zz3udLtE8JtT48YqAQyfvTYYPrm17kiEqPt80I6oVdEuqOMsxdVPkFnV9aHpUBQ+VAuBD32T3ECFKrWi+O4QC7UeR74PlSybpMjepcnGYpFr5WgafXr9zcmXzPbklXkEwSy3mWujuTpXPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311362; c=relaxed/simple;
	bh=3k/LO9a5z+Oujg1QgZ8Dv2EIgUkgDpdYRBHNCPZ28mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PXzMuYUu1/J9g7NtVN2uMlFW4JgJTUYFwHDBZfZxftbeMIMpKbReDDvA7szQ3UYSPUeyDbxhKOnni/IMLqz2fiwH3ofu+merLMAlrwYYDz2Mrl64VhiPjVFga+by5l+QZcCkd3awJtRFe1Q2pUn8qL/+GKXlfrXzM59fYto3vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Z17nvZLV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8QOHnIV; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Z17nvZLV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8QOHnIV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AC1571D002A1;
	Wed, 15 Apr 2026 23:49:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 23:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1776311358; x=1776397758; bh=7b
	3YGAE7uVJpVBwPjEHhVWOhP6uLEAUDGKWxRqelczQ=; b=Z17nvZLVnVPGRmH3g7
	nK8inNw6Tmdy4udtyA8xD69BF5zJjq5SJhpnLHr8ZE9+5sV4zFQ516jWYyFyrKTV
	fVN9+aGbxk3uc/ot6hI3j1DhYi3Gw0HqMykcDSLxMC7MtbLt6QsFN9+apD5IeMbq
	Ad5E3iCgGf5iqNEQ32rAWX+0fxf9C9YIkTHJDMBNislG488m6LzD5AHXr+9SwzKV
	7vlNjX7a+5JEFcv67h1UM7OKUy4n6y+GjbDAPJkvEOpkn0pfqweSFchwMPc8NP+A
	uC2RcCw+yp9xahEhRB3I36mRYnsCgk9vV8H8AguZOykOUrLrxGFkpuuRtDHAv30O
	oISA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776311358; x=1776397758; bh=7b3YGAE7uVJpVBwPjEHhVWOhP6uL
	EAUDGKWxRqelczQ=; b=B8QOHnIVNa9as6P9HJYBoBNF7Ukhh8GJrbnxGBqjGzr6
	djJCjGBna9h3zFiq7/EAGviIO4RNacLhorYxKOJhAbUcSZq3Wrck5KpUNyAXIqYX
	b4F/zHDq7+9mYKisFxD01RKwF2nbMH9OmP41HS06WmTdZHBzABhRzg3C9+La1bQV
	9jcVdgXvkh9ABsrVDXBMuw33X/YxZ0t/6AOPsoXTpK88rQV4z20uR3cAvY9wtF8W
	kVKHeTyoCGDImIUqeOVD2kAJc6Ii5At+hlCs6bf8YiZentfEjPo9QIDfRiymNz62
	eplGPJXOyDczb9ExoKxGcES5PikzPamnrpDLWGNwmQ==
X-ME-Sender: <xms:PVzgaQsq4Sq4Xglxq7zFPNkLi7954m_u2NtCDSOLoDuXYWcpe1LLgQ>
    <xme:PVzgabTW6LI2LzUbVWHkIWTVVdWujHfJm9eeyXG-tG74qY7ZzG06PzfWxPAr_lvBV
    v_MBEk2g2sJiVMfcgpJ8f_1iI82oz_b1M35VT8ebWhKon4txwuDQQ>
X-ME-Received: <xmr:PVzgaWNYOhExrc5-9_yED2dsz0ewmPeqJwLiMr9iPLZEzKvLGbeKVJn8lzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukffogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucghihhl
    lhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrthhtvg
    hrnheptefhhfekvdehhfetleelfeefffetledtudevgfeuhfduueeludekgeelgeejkeff
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigse
    hshhgriigsohhtrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:PVzgaQbiGmX8PdFgRGwQirMqSxs8jmLMdgE3ue2FhiZWstY_SPetgQ>
    <xmx:PVzgaQy09kxjtzdGL5uTwLj-S80V4Dr70UiFi2enuEBCId0l7-5Msw>
    <xmx:PVzgabJXCumaQSX-a0y_2uw9R8yDHzKIG-LznJ9ou1S-M9LeF6Km-A>
    <xmx:PVzgaarVW1ueFfYLCco3vIr7_bAcr65RIM_jY4fW04f7HxHw603tSQ>
    <xmx:PlzgaXIr3FGcS5I3oP2GXMUEQ4sWNG4m5VkpRDF9VXeE_V79WYnnPXaq>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 23:49:17 -0400 (EDT)
Date: Wed, 15 Apr 2026 21:49:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v7.1-rc1
Message-ID: <20260415214915.35831be1@shazbot.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc1

for you to fetch changes up to 493c7eff3c2ffa94ce3c5e62172948a1e38b491e:

  vfio/xe: Add a missing vfio_pci_core_release_dev() (2026-04-13 15:05:37 -=
0600)

----------------------------------------------------------------
VFIO updates for v7.1-rc1

 - Update QAT vfio-pci variant driver for Gen 5, 420xx devices.
   (Vijay Sundar Selvamani, Suman Kumar Chakraborty, Giovanni Cabiddu)

 - Fix vfio selftest MMIO DMA mapping selftest. (Alex Mastro)

 - Conversions to const struct class in support of class_create()
   deprecation. (Jori Koolstra)

 - Improve selftest compiler compatibility by avoiding initializer
   on variable-length array. (Manish Honap)

 - Define new uAPI for drivers supporting migration to advise user-
   space of new initial data for reducing target startup latency.
   Implemented for mlx5 vfio-pci variant driver. (Yishai Hadas)

 - Enable vfio selftests on aarch64, not just cross-compiles reporting
   arm64. (Ted Logan)

 - Update vfio selftest driver support to include additional DSA
   devices. (Yi Lai)

 - Unconditionally include debugfs root pointer in vfio device struct,
   avoiding a build failure seen in hisi_acc variant driver without
   debugfs otherwise. (Arnd Bergmann)

 - Add support for the s390 ISM (Internal Shared Memory) device via
   a new variant driver.  The device is unique in the size of its BAR
   space (256TiB) and lack of mmap support. (Julian Ruess)

 - Enforce that vfio-pci drivers implement a name in their ops
   structure for use in sequestering SR-IOV VFs. (Alex Williamson)

 - Prune leftover group notifier code. (Paolo Bonzini)

 - Fix Xe vfio-pci variant driver to avoid migration support as a
   dependency in the reset path and missing release call.
   (Micha=C5=82 Winiarski)

----------------------------------------------------------------
Alex Mastro (1):
      vfio: selftests: fix crash in vfio_dma_mapping_mmio_test

Alex Williamson (1):
      vfio/pci: Require vfio_device_ops.name

Arnd Bergmann (1):
      vfio: unhide vdev->debug_root

Giovanni Cabiddu (1):
      vfio/qat: add support for Intel QAT 420xx VFs

Jori Koolstra (2):
      vfio: replace vfio->class with a const struct class
      vfio: mdev: replace mtty_dev->vd_class with a const struct class

Joseph Salisbury (1):
      vfio: uapi: fix comment typo

Julian Ruess (3):
      vfio/pci: Rename vfio_config_do_rw() to vfio_pci_config_rw_single() a=
nd export it
      vfio/ism: Implement vfio_pci driver for ISM devices
      MAINTAINERS: add VFIO ISM PCI DRIVER section

Manish Honap (1):
      vfio: selftests: Fix VLA initialisation in vfio_pci_irq_set()

Micha=C5=82 Winiarski (2):
      vfio/xe: Reorganize the init to decouple migration from reset
      vfio/xe: Add a missing vfio_pci_core_release_dev()

Paolo Bonzini (1):
      vfio: remove dead notifier code

Ted Logan (1):
      vfio: selftests: Build tests on aarch64

Vijay Sundar Selvamani (1):
      vfio/qat: extend Kconfig dependencies for 420xx and 6xxx devices

Yi Lai (1):
      vfio: selftests: Support DMR and GNR-D DSA devices

Yishai Hadas (6):
      vfio: Define uAPI for re-init initial bytes during the PRE_COPY phase
      vfio: Add support for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2
      vfio: Adapt drivers to use the core helper vfio_check_precopy_ioctl
      net/mlx5: Add IFC bits for migration state
      vfio/mlx5: consider inflight SAVE during PRE_COPY
      vfio/mlx5: Add REINIT support to VFIO_MIG_GET_PRECOPY_INFO

 Documentation/arch/s390/vfio-ap.rst                |  20 +-
 MAINTAINERS                                        |   6 +
 drivers/vfio/group.c                               |  26 +-
 drivers/vfio/pci/Kconfig                           |   2 +
 drivers/vfio/pci/Makefile                          |   2 +
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c     |  17 +-
 drivers/vfio/pci/ism/Kconfig                       |  10 +
 drivers/vfio/pci/ism/Makefile                      |   3 +
 drivers/vfio/pci/ism/main.c                        | 408 +++++++++++++++++=
++++
 drivers/vfio/pci/mlx5/cmd.c                        |  25 +-
 drivers/vfio/pci/mlx5/cmd.h                        |   6 +-
 drivers/vfio/pci/mlx5/main.c                       | 118 +++---
 drivers/vfio/pci/qat/Kconfig                       |   2 +-
 drivers/vfio/pci/qat/main.c                        |  19 +-
 drivers/vfio/pci/vfio_pci_config.c                 |   8 +-
 drivers/vfio/pci/vfio_pci_core.c                   |   4 +
 drivers/vfio/pci/vfio_pci_priv.h                   |   4 +
 drivers/vfio/pci/virtio/migrate.c                  |  17 +-
 drivers/vfio/pci/xe/main.c                         |  44 ++-
 drivers/vfio/vfio.h                                |   1 -
 drivers/vfio/vfio_iommu_type1.c                    |   1 -
 drivers/vfio/vfio_main.c                           |  21 ++
 include/linux/mlx5/mlx5_ifc.h                      |  16 +-
 include/linux/vfio.h                               |  42 ++-
 include/uapi/linux/vfio.h                          |  26 +-
 samples/vfio-mdev/mtty.c                           |  33 +-
 tools/testing/selftests/vfio/Makefile              |   2 +-
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c |  15 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |   4 +-
 .../selftests/vfio/vfio_dma_mapping_mmio_test.c    |   1 -
 30 files changed, 738 insertions(+), 165 deletions(-)
 create mode 100644 drivers/vfio/pci/ism/Kconfig
 create mode 100644 drivers/vfio/pci/ism/Makefile
 create mode 100644 drivers/vfio/pci/ism/main.c

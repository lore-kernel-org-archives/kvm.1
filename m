Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03923D295;
	Tue, 18 Aug 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093013; cv=none; b=M9dcUhKwnYhCIY3Bq+cEb0uESOzXa1zYPfBBQEoY6bBIaXjiWi3CqDVqXMi5SQluYrzGC53khlRwUNk4HHOnRK4M6FOJFjZvGplIeObhog/VVBUXOcm0kXoiQN/Tk9xOJodz8ShYoHjyv3yomhxdhTV9BXSJKFJUsnNNxHtc+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093013; c=relaxed/simple;
	bh=zmSoAq4hTTUHWmmDpw/9valJva+N9bG3foilR5gFNDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PGJ42nQDJdGRMyiYpm2rfvj9MV1mNKYWm4jXWzS+rzrFFgFoptuS1CqqXU88/2aGVizn3oblLcWZKA4CDwKGieRnHWgQU4MV8qg1ulBD27pqpcM3DTpZ69FRBMLQ1FmAVFogO+rD6OUN+dblq3CrooA35NA9MMg6ShCvwAzMbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Sf1WBT4G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKd5ojA4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Sf1WBT4G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKd5ojA4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DA5C31D000C8;
	Tue, 18 Aug 2026 18:43:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 18 Aug 2026 18:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1787093008; x=1787179408; bh=ah
	D4ce1I4Z5MZsdXqxgG5JkEK6O7NC7IbLiKFnP/ohI=; b=Sf1WBT4GeMWvi4TyYT
	bD7A8MwrEq/5W8KgoMGpzbvUVroh9LrLkkMbUmpLbCJLWweTC7KZZyoS+mbGTZso
	LrtSzH3OsAVmFtdNsf2LI06TSGyUn3nG75GK7cltqz95z+pZPPpduDc4M1ymdzim
	4kixxL249pPkW0EZEUm7wEy+bAl9j0UzXRL+aFks3RR+Bbr+QjpTYG3lvjleJOm0
	e/s847N2w7PHf51W2wY8sFUshScv0AMQymqy3TpI6b96YnZUvEbGqV10jY8g6hDh
	K+IfdyJRELYOml3JUBR7VHvnem1bQDNq5Kfo4zjfX/neUlF/UiGRWDABsHvtjjjx
	WLlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787093008; x=1787179408; bh=ahD4ce1I4Z5MZsdXqxgG5JkEK6O7
	NC7IbLiKFnP/ohI=; b=dKd5ojA4FI+/kd/gue3cAuUxkyFCgcWvYIgVnX6mbhkK
	tLZkqEBepyoi8JwNybMlRrI+cZz41IVFsi7J2sVRiCIaKUTslROkVhOXsdCkqtsT
	MD/Yh3A96Kw2AcFpExm9Afy7fqoRI8ZexMOk2ECbagmoRAybRz2nfiEmpYt4Nz8Y
	xkUBIQQ9cjs76es13c0OIIbpKOJTyf7Tvv0SK4Dmh2jVahaxEsyp2oTVdHJsuMZR
	aySQ3OzhB29M9GbkLmqV3v2rU6pdH6CzaGIdwgOkwSgH9NUGXiVR92IS+9rKLGiO
	6r9Qq1Q/jCjTUZ06c+C1nhSaycJQ1Pst69FW6yIMDg==
X-ME-Sender: <xms:EOCEaq5U6LAhVrPni_xhR-D8rUwN8ZEGRGseyJ09EyfnV83RxMn-qw>
    <xme:EOCEahtwiNzg6-4nj012C4FuQl3HJuxrzUZyNUx7CBmwuIeq5EePAmsPBqnB5VCFb
    ZsU6kXN3sRvjqUvLLWGszB_hJeuw0Guwn4MPZjFBNag52zlS8oI>
X-ME-Received: <xmr:EOCEaj4z9epZCSeorTh6v9ZLaAIJ9jhNu9qJLaMSWHNsy-jqZrthFIo3peM2xA>
X-ME-Proxy-Cause: dmFkZTGTKkbU2csMLSYCuN6YwRXwFxeA/WFP6NUbuq/87a8mDCQw75EGaNMIrgzF+diVd4
    DtbLjl//THMj6/4vh8OMvluBgIdgAng87nToyAF7dk/DwBEjClAuwIG4QcQI8y2QgMtVQg
    4QlrWkI5gS9snSzJU711Htj8CU0OsMWd0x1yhhn8GjqY/GwmerjQtq2xONBrBQtZhjyIXq
    GqnqVJ/5T/7m1J9lSW5RFKNt2IqiBNApuxDxdWappl/9uWZqyLH72ir1ZbgPuWWEjAr6Y+
    b0tGbKHO0rrCqLzeGJ+h19PSeBADo26YgB8CGf0bDYopndBcuXwvwRBoMUf9IYd0p/ULRH
    KOFTChF8iiPMSxbZQj7B3qbBhskjwS5yPcxbzrtG/OHLJbYPqWHQJ8OFcs/oYI+ZLj8SJd
    B39PWhkE4oPtjcKr5kh4Oi02l5HbDNQZeKJ9ko6KpGntXO9ECxyNBxP0wq/fnhRRrCw/1q
    8ImJPj91tdLbmVlkROAOQvVjzc9z+rEGA6P6GIfPwOmPQ97ILhwG0sFk9Um1qM2Zr69+m5
    zD4KAhRtOnw6Nh7EEaevNwletkG5YSFqR6Bs2t1KMUh4UlduliDVa75V2kSuTIpj+zdzNQ
    QoqMYir+Rb+C4BmdH1Ml/5vZZkqeijiU9nkYg5B06wTqb/sn646s1p8Lw40A
X-ME-Proxy: <xmx:EOCEakXTLqbLRAbYMsIBOHls0vqNmvlpIytTyfmK5qpytu9hWZOXrw>
    <xmx:EOCEat8FR_UbIYXLfv9zAyFx5hG0W1nz3R2dW00KzWM5C2T_qCCbRA>
    <xmx:EOCEaonARCWN8GP0qkYfujJ0igNDsoM4_tXR29u2NiRK6AKU8EQIcA>
    <xmx:EOCEajWjn5KuQtBfFwxkD_B124sP16xUdaJdrcuG0l3z2s2lcKXdQQ>
    <xmx:EOCEahQzaOxxjMNul5WpDvuxt9ik09VavAMYdYD5PORqu_GdjsheQ-Zc>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 18:43:28 -0400 (EDT)
Date: Tue, 18 Aug 2026 16:43:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v7.3-rc1
Message-ID: <20260818164326.387bb27b@shazbot.org>
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

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.3-rc1

for you to fetch changes up to 4e3c1fc8abcb8eff062150b4340fa4569696d645:

  vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX (2026-08-13 11:37:30 -0600)

----------------------------------------------------------------
VFIO updates for v7.3-rc1

 - Add nv_falcon vfio selftest driver.  The Falcon is a general-purpose
   microcontroller embedded within NVIDIA GPUs, presenting a relatively
   simple DMA programming interface.  This adds another selftest target
   for vfio-pci with real DMA transfers. (Rubin Du, Alex Williamson)

 - Add allocation assertion helpers to vfio selftests and use them to
   avoid variable length arrays and the compiler errors they generate.
   (Alex Mastro)

 - Fix use-after-free hazard where an init path error in MSI support
   leaves a stray pointer that can later be reused or double-freed.
   (Xiang Mei)

 - Fix previous refactor of PCI BAR mappings to honor non_mappable_bars
   flag, which otherwise generates a warning when trying to pci_iomap()
   a 256TiB BAR on ISM devices on s390. (Farhan Ali)

 - Add igb vfio selftest driver.  Like nv_falcon, this provides another
   target for DMA testing with vfio selftests, but importantly this
   driver supports both physical 82576 NICs and the emulation model in
   QEMU.  This therefore enables a vfio selftest vector with no physical
   hardware requirements. (Josh Hilke, Alex Williamson)

 - Mark selftest fixture objects __maybe_unused to accommodate builds
   with clang -Wunused-but-set-global. (David Matlack)

 - Add error recovery for vfio-pci devices on s390x.  This expands
   devices which expose the existing error eventfd and introduces a
   device feature for reporting firmware defined error state
   information to the user, allowing recovery through hypervisor
   channels. (Farhan Ali)

----------------------------------------------------------------
Alex Mastro (2):
      vfio: selftests: Add allocation assert helpers
      vfio: selftests: Avoid VLAs

Alex Williamson (2):
      vfio: selftests: Add helpers to re-enable interrupts
      Merge branch 'slot' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci into v7.3/vfio/s390x-pci-error-recovery

David Matlack (1):
      selftests: harness: Mark test fixture objects __maybe_unused

Farhan Ali (9):
      vfio/pci: Avoid mapping BARs for devices with non-mappable BARs
      PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
      PCI: Allow per function PCI slots to fix slot reset on s390
      PCI: Avoid saving config space state if inaccessible
      PCI: Fail FLR when config space is inaccessible
      PCI/MSI: Enable memory decoding before restoring MSI-X messages
      s390/pci: Store PCI error information for passthrough devices
      vfio-pci/zdev: Add a device feature for error information
      vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

Josh Hilke (2):
      vfio: selftests: igb: Add driver for Intel 82576 device
      vfio: selftests: Retry on EAGAIN during device reset

Rubin Du (4):
      vfio: selftests: Add memcpy chunking to vfio_pci_driver_memcpy()
      vfio: selftests: Add generic PCI command register helpers
      vfio: selftests: Allow drivers without send_msi() support
      vfio: selftests: Add NVIDIA Falcon driver for DMA testing

Xiang Mei (1):
      vfio/pci: clear vdev->msi_perm after freeing it on init failure

 arch/s390/include/asm/pci.h                        |  32 +
 arch/s390/pci/pci.c                                |   1 +
 arch/s390/pci/pci_event.c                          | 137 ++--
 drivers/pci/hotplug/pnv_php.c                      |   2 +-
 drivers/pci/hotplug/rpaphp_slot.c                  |   2 +-
 drivers/pci/msi/msi.c                              |  10 +
 drivers/pci/pci.c                                  |  33 +-
 drivers/pci/slot.c                                 |  50 +-
 drivers/vfio/pci/vfio_pci_config.c                 |   1 +
 drivers/vfio/pci/vfio_pci_core.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_intrs.c                  |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h                   |   9 +
 drivers/vfio/pci/vfio_pci_zdev.c                   |  62 +-
 include/linux/pci.h                                |   8 +-
 include/uapi/linux/vfio.h                          |  21 +
 include/uapi/linux/vfio_zdev.h                     |   2 +
 tools/testing/selftests/kselftest_harness.h        |   2 +-
 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 585 +++++++++++++++
 .../selftests/vfio/lib/drivers/nv_falcon/hw.h      | 352 +++++++++
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c         | 783 +++++++++++++++++++++
 .../selftests/vfio/lib/include/libvfio/assert.h    |  18 +
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |  29 +
 tools/testing/selftests/vfio/lib/iommu.c           |  12 +-
 tools/testing/selftests/vfio/lib/iova_allocator.c  |   4 +-
 tools/testing/selftests/vfio/lib/libvfio.mk        |   3 +
 tools/testing/selftests/vfio/lib/sysfs.c           |   3 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c |  74 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |  22 +-
 .../vfio/vfio_pci_device_init_perf_test.c          |   4 +-
 .../testing/selftests/vfio/vfio_pci_driver_test.c  |  57 +-
 33 files changed, 2196 insertions(+), 141 deletions(-)
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/igb/e1000_82575.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/igb/e1000_defines.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/igb/e1000_regs.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/igb.c
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

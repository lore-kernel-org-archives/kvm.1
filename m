Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619644;
	b=OvI2HZ3avhVfdrHeUcdWljy3PFVPTjMV77PybKyJGhhcZVmd0VquelIo2Wtk6YGJvEPW
	 Ob7lj2lDpzMH4TIPmXDCwdYws4XdHj1Q58sgCOod1vErIUn1BGQCe4AkuYgbIpkaB3uAW
	 4jQTJW2u1Zu+1DdRF0pwldCz1e1Siy1aweK8TxBQg4bXl9H0+LpMpIVGJgak2Ws9seiWV
	 AqVlb00Z9AyrY7aj1shI917Sq5sIOM3PljRt1VklfH6kJ67ZjCUk9f605LE00U2cHERgW
	 E1e1kL2vRv8skNRT6Bulzj/+Jft+ViJ1bDHsnNYaS2CgeBupVAJuxNYi8ukwJlihwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619644;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bGnf7IpqYD/0ZUcDQjAGShI74EbjTS0C+XDIaOAqBlw=;
	b=FLTyoILgt5bPUuAY3CLWFZWA0HgkmFZ3oupkzxdUr6j1xzfx0CBi3TZiVFolu6u6jNGD
	 hhcxi1I/63DBOlskcQ74zCwMh//jbGuWN1oe6DRe/6S5xB3wgCcUxSdnjsxgowXYb9DQg
	 ss5YoEqc15jFBx4GrusLfhzL2BOOFfadXo0F3CZsOZwSuBGNMedbcDXwmiDjLjHsdGIn1
	 8HjhAeiqt9WVAEfcv5wTY1WQrMP01vc1m/zsSlpjOjkBgrTrwnUkE+viPzNCJrJIhFxiZ
	 WKBWpZS1qZQUZBUzf637l5f6AXYvshpUPcZP2nfF39gstPS4rlV9q14z1WrTIc/jtVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jpEaHt4X;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8CF606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB8CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jpEaHt4X
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E242F;
	Wed, 25 Nov 2026 07:14:00 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F40613F86F;
	Wed, 25 Nov 2026 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795619643; bh=cw++yBZS8jlRB00548KczTX1DkOn+4sdOCjlk32jvuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jpEaHt4XRasO5Owe1M4sHNyr1grHVrZy8T1oERHdOcgTPSDcPALWH7LxyZREBs2bn
	 8CEHOkNX4ciCKhNhfUea5NFJD9UrFaLenWrEumFt1Wth6H9MTsPxihycOAqDwBrkGC
	 4qvvf34OtsSnI3SIzMaMvzOaE4HuRKSMpOHyV3Ak=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v6 00/23] arm64: Support GICv5-based guests
Date: Wed, 25 Nov 2026 15:13:33 +0000
Message-Id: <20261125151356.2875108-1-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for GICv5-based VMs to kvmtool. These are
exposed as --irqchip=gicv5 and --irqchip=gicv5-its, where the former
creates a vGICv5 device and the latter adds a GICv5 ITS. The GICv5
specification can be found at [1].

The GICv5 support in KVM needed by --irqchip=gicv5 is available as of
Linux v7.4-rc1. The GICv5 ITS support is described in [2]; using
--irqchip=gicv5-its requires a KVM build with those changes.

The series teaches kvmtool to create the GICv5 irqchip and ITS KVM
devices. It describes the GICv5 CPU interface, IRS and ITS in the
guest DT, updates the timer and PMU interrupt descriptions, and
generates GICv5 interrupt specifiers for platform devices and PCI. It
also maps PCI MSI requester IDs to the ITS. The IRS support is built
and exposed before the ITS support, so the GICv5 irqchip support can
be merged separately from the ITS changes.

Compared with v5 [3]:

* Dropped the SETLPI frame from the IRS DT description because KVM
  reserves but does not emulate it. Updated patch 15's commit message
  accordingly.

* Added Vladimir's Reviewed-by trailers to patches 9 and 15.

The v7.4-rc1 header sync includes GICv5 IRS UAPI, but not GICv5 ITS
UAPI. Patch 19 mirrors the ITS definitions from [2]. Once that UAPI
lands upstream, the headers should be resynced against the latest
Linux headers before merging the ITS support.

Thanks,
Sascha

[1] https://developer.arm.com/documentation/aes0070/latest
[2] https://lore.kernel.org/all/20261102194454.4086911-1-sascha.bischoff@arm.com/
[3] https://lore.kernel.org/all/20261118175755.1946977-1-sascha.bischoff@arm.com/

Sascha Bischoff (23):
  arm64: Propagate IRQ routing initialisation errors
  arm64: Close the ITS descriptor when setup fails
  arm64: Split GIC device setup
  Sync kernel UAPI headers with v7.4-rc1
  arm64: Add GICv5 irqchip device support
  arm64: Configure GIC interrupt bases
  irq: Allow the initial interrupt line number to be set
  arm64: Start GICv5 SPI line allocation at zero
  arm64: Configure the GICv5 IRS
  arm64: Define GICv5 interrupt types
  arm64: Describe the PMU interrupt for GICv5
  arm64: Describe timer PPIs for GICv5
  arm64: Assign CPU DT phandles
  arm64: Describe the GICv5 CPU interface in the DT
  arm64: Describe the GICv5 IRS in the DT
  arm64: Generate GICv5 SPI specifiers for platform devices
  arm64: Generate GICv5 PCI INTx specifiers
  arm64: Expose the GICv5 irqchip option
  arm64: Add proposed GICv5 ITS UAPI definitions
  arm64: Add GICv5 ITS device support
  arm64: Describe the GICv5 ITS in the DT
  arm64: Map PCI MSI requester IDs to the GICv5 ITS
  arm64: Expose the GICv5 ITS irqchip option

 arm64/fdt.c                         |  13 +-
 arm64/gic.c                         | 359 ++++++++++++++++++++++++----
 arm64/include/asm/kvm.h             |  18 ++
 arm64/include/kvm/fdt-arch.h        |   1 +
 arm64/include/kvm/gic.h             |  15 ++
 arm64/include/kvm/kvm-arch.h        |  16 ++
 arm64/include/kvm/kvm-config-arch.h |   2 +-
 arm64/pci.c                         |  24 +-
 arm64/pmu.c                         |  13 +-
 arm64/timer.c                       |   8 +-
 include/kvm/irq.h                   |   1 +
 include/linux/kvm.h                 |  23 ++
 include/linux/virtio_console.h      |   2 +-
 include/linux/virtio_ids.h          |   1 +
 irq.c                               |  15 +-
 powerpc/include/asm/kvm.h           |  18 ++
 riscv/include/asm/kvm.h             |  17 ++
 x86/include/asm/kvm.h               |   4 +-
 18 files changed, 481 insertions(+), 69 deletions(-)

-- 
2.34.1


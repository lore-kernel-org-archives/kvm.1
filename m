Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92F274B4A;
	Thu,  9 Apr 2026 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704082; cv=none; b=B8fugCVdIK8FBmIBM9Ms+JtVABgJ/Xz3sJPkfhApwkyIkno+GGwExcCdcdGoXAMW95K5NccFZvj1r9k6AFFy3l3ed8UrqNULoNe5/zKLAL9JSbM7vNIKVry6lm9lRu/HzufdogNBfrz3/OmAq9carnhWJafVTvQQxMdpZPcoQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704082; c=relaxed/simple;
	bh=Zp5b12rAzeslmXLiqnv/e86cCeLAs+TpLzU8zqznKig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWcujudYjIyFaPIsxy2PJBucU/Qjeli4zTGfSVSTK4azrz9Bblc12j3Bpca9lGm3NX+X7kWKC9IiU1Bk/arFgSBKlSBNGpD8alOFOGw+qXPHUZA1u/IA+Mmib6RzQ3StyjpioB0ugN6NkNqHo15a/mOGrWHoIM1E8GS+FIf5Rxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8AxScILGNdpc2ojAA--.33796S3;
	Thu, 09 Apr 2026 11:07:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJBxSeAIGNdpHB5pAA--.3831S2;
	Thu, 09 Apr 2026 11:07:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn
Subject: [PATCH v10 0/2] LoongArch: KVM: Add DMSINTC support irqchip in kernel
Date: Thu,  9 Apr 2026 10:42:13 +0800
Message-Id: <20260409024215.136932-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeAIGNdpHB5pAA--.3831S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Hi,

This series  implements the DMSINTC in-kernel irqchip device,
enables irqfd to deliver MSI to DMSINTC, and supports injecting MSI interrupts
to the target vCPU.
applied this series.  use netperf test.
VM with one CPU and start netserver, host run netperf.
disable dmsintc
taskset 0x2f  netperf -H 192.168.122.204 -t UDP_RR  -l 36000
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

212992 212992 1        1       36000.00   27107.36

enable dmsintc
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

212992 212992 1        1       36000.00   28831.14  (+6.3%)

v10:
  *Changed from v8;
  *Rebase.

v9:
 *Correct the incorrect parameter type and remove the function prefix;
 *Fix a boundary value check.

v8:
  *Move dmsintc_inject_irq(),dmsintc_deliver_msi_to_vcpu()and
dmsintc_set_msi_irq to dmsintc.c.
  *Rebase.

v7:
  *Rebase;
  *Fix a typo error;
  *Drop an extra space;
  *Move some code from patch2 to patch1.
  *Rename loongarch_dmsintc_inject_irq() to dmsintc_inject_irq() and move
it to interrupt.c;
  *Rename kvm_loongarch_deliver_msi_to_vcpu() to
dmsintc_deliver_msi_to_vcpu() and move it to irqfd.c;
  *Drop loongarch_set_msi() and dispatch the dmsintc/eiointc
paths in pch_msi_set_irq().

v6:
  Fix kvm_device leak in kvm_dmsintc_destroy().

v5:
  Combine patch2 and patch3
  Add check msgint feature when register DMSINT device.

V4: Rebase and R-b;
   replace DINTC to DMSINTC.

V3: Fix kvm_arch_set_irq_inatomic() missing dmsintc set msi.(patch3)

V2:
https://patchew.org/linux/20251128091125.2720148-1-gaosong@loongson.cn/

Thanks.
Song Gao


Song Gao (2):
  LoongArch: KVM: Add DMSINTC device support
  LoongArch: KVM: Add dmsintc inject msi to the dest vcpu

 arch/loongarch/include/asm/kvm_dmsintc.h |  26 ++++
 arch/loongarch/include/asm/kvm_host.h    |   3 +
 arch/loongarch/include/asm/kvm_pch_pic.h |   4 +-
 arch/loongarch/include/uapi/asm/kvm.h    |   4 +
 arch/loongarch/kvm/Makefile              |   1 +
 arch/loongarch/kvm/intc/dmsintc.c        | 190 +++++++++++++++++++++++
 arch/loongarch/kvm/intc/pch_pic.c        |  15 +-
 arch/loongarch/kvm/interrupt.c           |   2 +
 arch/loongarch/kvm/irqfd.c               |  11 +-
 arch/loongarch/kvm/main.c                |   6 +
 include/uapi/linux/kvm.h                 |   2 +
 11 files changed, 255 insertions(+), 9 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c

-- 
2.39.3


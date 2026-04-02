Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB62FDC5E;
	Thu,  2 Apr 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135306; cv=none; b=jUcu1WusIDHzQgij9ny1tKs/krj46ppOas2kzyjHGTMPQ+wCtyNoE6bMXdPdHweUozdEkP3/QgpjjuetYqrrp78+LcHD9h952KrvsURmXNlhg+msLLa4eR8LyQ9ysCLJROIOuaB/mNBECnCygQ70CvSmcbyFc4BGpdjgCIfEHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135306; c=relaxed/simple;
	bh=tiWbVrbiY0ISKu10NDbsSUqU58X8aNKdIyCaYnEYwKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNyvAIOt8trfXehriwVMXGL6Hnr7gXEUamY9y45g5cnnlnTxfM7aHmcB2ygRlhYaHYmjouik0cB/6xY+lmjMVM5FOLc6jVfrEbOUHR5MRbAqu20a2UMeyud/Jcn2F/kB6g2khO5fh+izryN6XK0EW2GhrWgbQwmcWN/bbT39Srk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Dx_8M9as5pQzchAA--.28682S3;
	Thu, 02 Apr 2026 21:08:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCx+8E6as5p6oJjAA--.58940S2;
	Thu, 02 Apr 2026 21:08:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn
Subject: [PATCH v9 0/2] LoongArch: KVM: Add DMSINTC support irqchip in kernel
Date: Thu,  2 Apr 2026 20:42:35 +0800
Message-Id: <20260402124237.4174550-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8E6as5p6oJjAA--.58940S2
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

 arch/loongarch/include/asm/kvm_dmsintc.h |  23 +++++
 arch/loongarch/include/asm/kvm_host.h    |   3 +
 arch/loongarch/include/asm/kvm_pch_pic.h |   4 +-
 arch/loongarch/include/uapi/asm/kvm.h    |   4 +
 arch/loongarch/kvm/Makefile              |   1 +
 arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
 arch/loongarch/kvm/intc/pch_pic.c        |  15 ++-
 arch/loongarch/kvm/interrupt.c           |  37 +++++++
 arch/loongarch/kvm/irqfd.c               |  48 ++++++++--
 arch/loongarch/kvm/main.c                |   6 ++
 include/uapi/linux/kvm.h                 |   2 +
 11 files changed, 251 insertions(+), 9 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c

-- 
2.39.3


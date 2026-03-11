Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699FC3CAE72;
	Wed, 11 Mar 2026 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220600; cv=none; b=hG62cGiwz05oiHLcMGyGXmtEr8g3teJwSwQXEjKc0N/ZdgwduLsDhjd+Ei1rnFwpCmEdxAnZf/IULsF7pqgXhaUDsillfgwE1wn8M9WCQUxtARJrXnYEaBXag9jPodmP6MqR+cYTU34rwDm1kYXMMWg0olmFQXjdx82jmmR26hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220600; c=relaxed/simple;
	bh=+3HoUlF53YWozhSJOgm4H1RKeXRHlcjoO3kx6dOgamI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D4+F0fFqO75z2B9mCNlv2sOsDUZhgIQ9iEmIMQKIYixIfTFptYsZNBUfRt+qgt3m+gD4WqfprKb3tNd1tEuilJvE3B6dH8VnlU+khusyFcv5TATeki3/nxhsFOpzFib/vRzd1V6T4ZZh2HRY6STDXv5VChQyyFYYxlv1s8l0R4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8CxJMHmMrFpa98ZAA--.28850S3;
	Wed, 11 Mar 2026 17:16:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCxHOHiMrFpUORSAA--.27263S2;
	Wed, 11 Mar 2026 17:16:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	lixianglai@loongson.cn
Cc: loongarch@lists.linux.dev,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] LoongArch: KVM: Add DMSINTC support irqchip in kernel
Date: Wed, 11 Mar 2026 16:50:57 +0800
Message-Id: <20260311085059.1040263-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOHiMrFpUORSAA--.27263S2
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
 arch/loongarch/kvm/intc/pch_pic.c        |  16 +++-
 arch/loongarch/kvm/interrupt.c           |  37 +++++++
 arch/loongarch/kvm/irqfd.c               |  48 ++++++++--
 arch/loongarch/kvm/main.c                |   6 ++
 include/uapi/linux/kvm.h                 |   2 +
 11 files changed, 252 insertions(+), 9 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c

-- 
2.39.3


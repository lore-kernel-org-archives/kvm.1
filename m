Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18003EEAEB;
	Thu,  9 Jul 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585716; cv=none; b=A5LuIpjF5GLy1/xs2PtMhLS1vYz52l0brIQMCjbcnmK29zrANotfFURBvhQMHMzuVFNsV+Ah6vJkGC50qIkXv0Z6NmJjo/DtyIBt9Hl86zjWp25xBGkCuwjnBuBCdUNKnlchY1E46bAk6zGkSCH8ARXz2EsHIfxzB/g9ZdzupgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585716; c=relaxed/simple;
	bh=x3dA87p9m1F7Kqr7HZ5lh44BEly4Z5S9sFstBxptAE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PUnEzbsntKhLAwk1NMnoFxHdK8uOZ+esX3rYcTVDcdTpnf+9cP2kjsU2LIcrt++bNTkIqPUrlfqDYGPeBkj7S48qtXaxtGz/HuFOOILOPReDf41UGFM2763tvNXrZXlW78FNBekg46NPlOm4HYOXBMwczleodsFsqJQs225MDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxGOuuW09q4MYBAA--.7628S3;
	Thu, 09 Jul 2026 16:28:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxnMapW09q3qIGAA--.32266S2;
	Thu, 09 Jul 2026 16:28:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] LoongArch: KVM: Harden interrupt injection
Date: Thu,  9 Jul 2026 16:21:05 +0800
Message-Id: <20260709082109.1361767-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxnMapW09q3qIGAA--.32266S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

API kvm_vcpu_ioctl_interrupt() is mainly to used to deliver interrupt
from user mode, and internal APIs kvm_queue_irq() and kvm_dequeue_irq()
are used in kernel mode, also moves IPI interrupt handling within lock
protection.

Also this patch replaces kvm_err() with WARN_ONCE() to avoid noise
kernel log.

---
v3 ... v4:
  1. From AI assist, replace kvm_err() with kvm_pr_unimpl() rather than
     WARN_ONCE(), since host may crash with WARN_ONCE() when kernel
     parameter panic_on_warn=1 is set.
  2. Add one new patch 3 which returns directly when IPI address is not
     aligned, rather than only print WARN_ON_ONCE() and continue to run.

v2 ... v3:
  1. Split the patches into three smaller ones, the first patch removes
     old default case and kvm_err() since it is impossible to happen.
     And the second patch replaces kvm_err() with WARN_ONCE().

v1 ... v2:
  1. Add border check with ipnum in eiointc_set_sw_coreisr() and
     eiointc_update_irq(), so that injected interrupt vector is valid.

  2. Move IPI inject and ack within lock to avoid contention in
     ipi_set() and ipi_clear().

  3. Add kvm_arch_irqchip_in_kernel() check in user mode irq injection
    in function kvm_vcpu_ioctl_interrupt(), contention of user mode irq
    injection is assured from user mode VMM.
---
Bibo Mao (4):
  LoongArch: KVM: Set default MAILBOX access size with 8
  LoongArch: KVM: Replace kvm_err() with kvm_pr_unimpl()
  LoongArch: KVM: Return directly when IPI address is not aligned
  LoongArch: KVM: Use internal API to deliver interrupt in kernel mode

 arch/loongarch/kvm/exit.c         | 16 +++----
 arch/loongarch/kvm/intc/dmsintc.c | 15 ++++---
 arch/loongarch/kvm/intc/eiointc.c | 32 +++++++------
 arch/loongarch/kvm/intc/ipi.c     | 75 +++++++++++++------------------
 arch/loongarch/kvm/intc/pch_pic.c | 12 ++---
 arch/loongarch/kvm/vcpu.c         |  5 ++-
 6 files changed, 76 insertions(+), 79 deletions(-)


base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.39.3


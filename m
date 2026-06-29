Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED31C860A;
	Mon, 29 Jun 2026 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700347; cv=none; b=Q2JJ3RrhJu2dQgchI431l5PqAbS7VV5EhnLVzAwwaXwt4Ck+FOXPi5CQJ4tojUK5RmLghf9aca36y4Ww0j8VXjSidJJECc22GbgTLIRwFFR0y58YsBp12/Hm+iiYd/vKXiz5knVr1UoArcSXNK+k4AqCgZ8PbW7PpjeXZ9MVVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700347; c=relaxed/simple;
	bh=Ia4uFu870Tkqg+wOPPRMERtqsoo6SXiBX89shvj+DVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uzw+HvBnnNbD0E0XRXXI1IWuMNpm13q9PEYnz5ScYyq1JMTFVD96Oo1UFq7ISCywcbm70Hz+m4jvg36grgjYbX9d69EsBNLXnit1G8OUFI4Wc4tYRKExXkCcaJT5SDaBvW+/Q6JYleiBAoqECWaoOIyGSrYLVSMauJ71e11+Iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxRXg32UFqTf8YAA--.39496S3;
	Mon, 29 Jun 2026 10:32:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeAu2UFqbBe3AA--.19539S2;
	Mon, 29 Jun 2026 10:32:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] LoongArch: KVM: Harden interrupt injection
Date: Mon, 29 Jun 2026 10:32:10 +0800
Message-Id: <20260629023213.597030-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAu2UFqbBe3AA--.19539S2
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
Bibo Mao (3):
  LoongArch: KVM: Set default MAILBOX access size with 8
  LoongArch: KVM: Replace kvm_err() with WARN_ONCE()
  LoongArch: KVM: Use internal API to deliver interrupt in kernel mode

 arch/loongarch/kvm/exit.c         | 15 ++++-----
 arch/loongarch/kvm/intc/dmsintc.c | 15 +++++----
 arch/loongarch/kvm/intc/eiointc.c | 32 ++++++++++--------
 arch/loongarch/kvm/intc/ipi.c     | 55 ++++++++++++++-----------------
 arch/loongarch/kvm/intc/pch_pic.c | 12 +++----
 arch/loongarch/kvm/vcpu.c         |  5 ++-
 6 files changed, 67 insertions(+), 67 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.39.3


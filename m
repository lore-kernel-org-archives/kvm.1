Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AA63F0AA6;
	Tue, 14 Jul 2026 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014362; cv=none; b=O8GbaoWTIATpft4CaFNmDDIidU22FOdkeu8+GNYIPbqA+m17/3hfbsyG6GY383IDmoPrNVMZbMZbRjTg8CnIiehVnKkQIQDGVj6gFwbU/UoXY7xM+Tb+egQwT2Oktb3S/Pq6Qah10aZVYI5eROP6vGQ78JFDPYyoGNHEf+XEGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014362; c=relaxed/simple;
	bh=qAffaHm6/TpGJjNLk9UlccagJgs9s2OcvC5BAnws2v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fWImEYNUCH8w3b+J9NoxOC3ExCbh1fdZti9mkFKLrS+zIPiz9Xp73bIO+IHjf84ok1xBdeHftkLHUw+c1GR/B7Vdb06Np9oqSYJ7nGnvTBF5ETJlqc20wvegRUi30RjgbZlVSBVCbj69h36Vj2Kev+acj3y9iwp2/LTYsr9Xwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx7+sT5lVqolMDAA--.13390S3;
	Tue, 14 Jul 2026 15:32:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxIuQT5lVqzZEMAA--.38917S2;
	Tue, 14 Jul 2026 15:32:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Song Gao <gaosong@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] LoongArch: KVM: Harden interrupt injection
Date: Tue, 14 Jul 2026 15:25:15 +0800
Message-Id: <20260714072520.2745942-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuQT5lVqzZEMAA--.38917S2
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
v4 ... v5:
  1. Add one new patch and fix uninitialized stack variable issue with
     dmsintc.
  2. In patch 2, set return value with 0 to prevent information leak
     where return directly with non-aligned address in IPI irqchip.

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
Bibo Mao (5):
  LoongArch: KVM: Fix uninitialized stack variable issue with dmsintc
  LoongArch: KVM: Return directly when IPI address is not aligned
  LoongArch: KVM: Set default MAILBOX access size with 8
  LoongArch: KVM: Replace kvm_err() with kvm_pr_unimpl()
  LoongArch: KVM: Use internal API to deliver interrupt in kernel mode

 arch/loongarch/kvm/exit.c         | 16 +++----
 arch/loongarch/kvm/intc/dmsintc.c | 17 ++++---
 arch/loongarch/kvm/intc/eiointc.c | 32 ++++++++------
 arch/loongarch/kvm/intc/ipi.c     | 73 ++++++++++++++-----------------
 arch/loongarch/kvm/intc/pch_pic.c | 12 ++---
 arch/loongarch/kvm/vcpu.c         |  5 ++-
 6 files changed, 80 insertions(+), 75 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.39.3


Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0441B85F8;
	Fri,  8 May 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778203821; cv=none; b=rrLVNFBStIEduGMZMBZ0iObdx60UJGodNEClNpZNCLyf7IJJ/3MZJ7T4+2I0ac9Z8VFOAAdJNWuPtiVfQOezOvaRSzwraGOd5sHHGZFMGx4RtUnL+TZp5MoOhQUzzG+ewvsLPfbXxbmrFxeWjQJbn9VOTjKtdFb42r3Ib6zeTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778203821; c=relaxed/simple;
	bh=rosrgjCoS4Pt78WRamvOnY/gD6U1/ThqnUnsKICg+KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ojx3nRC0ihzLdrqw21E79C6mycEkFxSHPDqd6F+AMpLe4K/8PUXNkprSwI5m+J49GW/lR5pCifK8CuyrJqFrXxLBmnPWIFHEOF8jt1mbHVh+JONk7PVRKu1n/8E7kS7xR+Tp5rGptzaUWKGzOGmP7pv+zWHs5LjeuMC7Tl5J5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx13ipPP1pwr0HAA--.206S3;
	Fri, 08 May 2026 09:30:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeClPP1pIp58AA--.40861S2;
	Fri, 08 May 2026 09:30:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] LoongArch: KVM: Move some variable declaration to file paravirt.h
Date: Fri,  8 May 2026 09:30:01 +0800
Message-Id: <20260508013001.4107737-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeClPP1pIp58AA--.40861S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Some variables relative with paravirt feature are declared in header file
asm/qspinlock.h, however this file can be included only when option
CONFIG_SMP is on. There is compiling warning if CONFIG_SMP is off since
it is not declared.

Move these variable declaration to header file asm/paravirt.h to avoid
compiling warning.

Fixes: c43dce6f13fb ("LoongArch: KVM: Make vcpu_is_preempted() as a macro rather than function")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605061313.O8Hswm2b-lkp@intel.com/
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/paravirt.h  | 4 ++++
 arch/loongarch/include/asm/qspinlock.h | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
index 0111f0ad5f73..dbc64908017f 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -3,6 +3,10 @@
 #define _ASM_LOONGARCH_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
+#include <linux/jump_label.h>
+DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
 
 int __init pv_ipi_init(void);
 int __init pv_time_init(void);
diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
index 0ee15b3b3937..fbfc6be82f26 100644
--- a/arch/loongarch/include/asm/qspinlock.h
+++ b/arch/loongarch/include/asm/qspinlock.h
@@ -3,12 +3,9 @@
 #define _ASM_LOONGARCH_QSPINLOCK_H
 
 #include <asm/kvm_para.h>
-#include <linux/jump_label.h>
+#include <asm/paravirt.h>
 
 #ifdef CONFIG_PARAVIRT
-DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
-DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
-DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
 
 #define virt_spin_lock virt_spin_lock
 

base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
-- 
2.39.3


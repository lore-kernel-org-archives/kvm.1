Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93D363088;
	Tue, 17 Mar 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739766; cv=none; b=LLbHHSbf8iDrHMkFfSW2jvljBgovkfXDWHJXvwVHn5bZ3K4lEIqbcFpHdOEGk/ar7hvz3Btwp66rSZUP82/ZUzntC1kmvbhmLAbvvcRh4lEow7bW2KDfM38s2s1iDY5J8OhZQnTh92NxtXjGTAjT9agqbK1nnj7sZ/D8+59bX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739766; c=relaxed/simple;
	bh=W9/CppDDE8uS3FzshUKFhphbwsJQer6EAjKZ/ReuUWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVVldFT6+LwsBI0XFa5fVcgpSdXaYyRvmKmpFrsbXveEPBCXI7alz3ftKM1uT8wmfaWh5LXDf9QOL2t/G131fZquax91owcvPK2gRuxMrlKU8/Gz4GFC2Wvm1zvS1W1BvdLZdzqBGLUrck6tg1ovbeXO39i14fDvBDx4sAbp1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxUcDsHrlpTeQbAA--.21718S3;
	Tue, 17 Mar 2026 17:29:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxHOHpHrlp3PlWAA--.35253S5;
	Tue, 17 Mar 2026 17:29:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 3/3] LoongArch: KVM: Set vcpu_is_preempted() macro rather than function
Date: Tue, 17 Mar 2026 17:29:11 +0800
Message-Id: <20260317092911.1400248-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260317092911.1400248-1-maobibo@loongson.cn>
References: <20260317092911.1400248-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOHpHrlp3PlWAA--.35253S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

vcpu_is_preempted() is performance sensitive called in function
osq_lock(), here set it as macro. So that parameter is not parsed
at most time, it can avoid cache line thrashing across numa node.

Here is part of unixbench result on 3C5000 DualWay machine with 32
Cores and 2 Numa node.
          origin    with patch    CONFIG_PARAVIRT disabled
execl     6871.9    7134.2        7190.8
fstime    425.5     959.9         956.1

From the test result, with macro method it is almost the same with
CONFIG_PARAVIRT disabled, and there is some improvment compared with
function method.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/qspinlock.h | 27 +++++++++++++++++++++-----
 arch/loongarch/kernel/paravirt.c       | 15 ++------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
index 66244801db67..b5d7a038faf1 100644
--- a/arch/loongarch/include/asm/qspinlock.h
+++ b/arch/loongarch/include/asm/qspinlock.h
@@ -5,8 +5,10 @@
 #include <linux/jump_label.h>
 
 #ifdef CONFIG_PARAVIRT
-
+#include <asm/kvm_para.h>
 DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(virt_preempt_key);
+DECLARE_PER_CPU(struct kvm_steal_time, steal_time);
 
 #define virt_spin_lock virt_spin_lock
 
@@ -34,10 +36,25 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 	return true;
 }
 
-#define vcpu_is_preempted vcpu_is_preempted
-
-bool vcpu_is_preempted(int cpu);
-
+/*
+ * Macro is better than inline function here
+ * With inline function, parameter cpu is parsed even though it is not used.
+ * This may cause cache line thrashing across NUMA node.
+ * With macro method, parameter cpu is parsed only when it is used.
+ */
+#define vcpu_is_preempted(cpu)							\
+({										\
+	bool __val;								\
+										\
+	if (!static_branch_unlikely(&virt_preempt_key))				\
+		__val = false;							\
+	else {									\
+		struct kvm_steal_time *src;					\
+		src = &per_cpu(steal_time, cpu);				\
+		__val = !!(READ_ONCE(src->preempted) & KVM_VCPU_PREEMPTED);	\
+	}									\
+	__val;									\
+})
 #endif /* CONFIG_PARAVIRT */
 
 #include <asm-generic/qspinlock.h>
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index b74fe6db49ab..2d1206e486e2 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -10,8 +10,8 @@
 #include <asm/paravirt.h>
 
 static int has_steal_clock;
-static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
-static DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
+DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
+DEFINE_STATIC_KEY_FALSE(virt_preempt_key);
 DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 static bool steal_acc = true;
@@ -261,17 +261,6 @@ static int pv_time_cpu_down_prepare(unsigned int cpu)
 	return 0;
 }
 
-bool vcpu_is_preempted(int cpu)
-{
-	struct kvm_steal_time *src;
-
-	if (!static_branch_unlikely(&virt_preempt_key))
-		return false;
-
-	src = &per_cpu(steal_time, cpu);
-	return !!(src->preempted & KVM_VCPU_PREEMPTED);
-}
-EXPORT_SYMBOL(vcpu_is_preempted);
 #endif
 
 static void pv_cpu_reboot(void *unused)
-- 
2.39.3


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47071484899;
	Mon, 21 Sep 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993664; cv=none; b=iu42sJligrpuPuKq3Nn2axqv+9ibHnXhMy0CDKs4N48mPYziEdxVubAYTrf+/oUdWKyFyb7mQhROMQtNxPLb87IH2dkRDrHdXh4g+Adt7IzXRYK65z/Nx6u/tUatOpnljy60ztTZ1P5lUwurpRqo+d+WHb0ue7wvkFQCXj5J/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993664; c=relaxed/simple;
	bh=MEga3P4bu82C6YjKMFvOexMcXVFvOgvC/JMkLxQ5GGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZWeUWRIqgv3SdRerL0eGVwF4vgOpXkF4BTgV8EkQkCHsGjq8zyCGmLmegxAFEWQy7KtF7CnKto0NPeoPtVvdffu/MDD+aBWYBzkSV2rYw/CQh4mM6Yxris4c4CFBZ0oZQrF7qAG6lX0mJMiMCzVmXlbumNQFf7NM1a/KRrku6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdhQCyIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdhQCyIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE36A1F00898;
	Mon, 21 Sep 2026 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993662;
	bh=QVGKnIWRxvPTWA2suCoWlo2Ot1kTECvUDXRzzxTCpoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KdhQCyIlB9toTwTgP1fKUeF0D9GY67k/HlhBgQCthL9+Bpv51wUpCNkXxQVPmnGdN
	 Hr9YRZp2g9/na6SQKQQSQwpNDakxuzC6PvKUzI/yjkt90TBSRiae5h1hXQrLn1Sua5
	 UYjsQ8MLe73HFumUIWh+RPqqaL6cGzwRtneNo5/6AF2qwJMN4SOuJA9yFikStz4eFP
	 ELYlhNbO9H+Di7qfwuRgYA05o2tCm+GSxzWqcwvoYoRxcRj70c6Mt9JAFy3AioJ7Mf
	 0MykNXAR/pDFVH2l+LQNtWgUouIC/bW4MAVtmKxnupn3grr2nRE7IR9n/xidfBqFuw
	 VbQ1rDWaHluVA==
From: "GUO Ren (XuanTie)" <guoren@kernel.org>
Date: Mon, 21 Sep 2026 12:27:04 +0000
Subject: [PATCH RFC v4 4/4] RISC-V: paravirt: Support nopvspin to disable
 PARAVIRT_SPINLOCKS
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pvqspinlock-v4-4-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
In-Reply-To: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
 CHEN Jiankang <yubin.cjk@alibaba-inc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "GUO Ren (XuanTie)" <guoren@kernel.org>
X-Mailer: b4 0.16.0

VM guests should fall back to a Test-and-Set spinlock when
PARAVIRT_SPINLOCKS is disabled, because fair locks suffer from severe
lock-holder preemption issues. The virt_spin_lock_key shortcuts
queued_spin_lock_slowpath(), allowing virt_spin_lock() to hijack it.
See commit 43b3f02899f7 ("locking/qspinlock/x86: Fix performance
regression under unaccelerated VMs").

Add a static key controlling whether virt_spin_lock() is called, and
add nopvspin support mirroring x86.

Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/riscv/include/asm/qspinlock.h              | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/qspinlock_paravirt.c          |  8 ++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..d32bb7db9f91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4632,7 +4632,7 @@ Kernel parameters
 			as generic guest with no PV drivers. Currently support
 			XEN HVM, KVM, HYPER_V and VMWARE guest.
 
-	nopvspin	[X86,XEN,KVM,EARLY]
+	nopvspin	[X86,RISCV,XEN,KVM,EARLY]
 			Disables the qspinlock slow path using PV optimizations
 			which allow the hypervisor to 'idle' the guest on lock
 			contention.
diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/qspinlock.h
index 330b714edc44..9c7108baa40a 100644
--- a/arch/riscv/include/asm/qspinlock.h
+++ b/arch/riscv/include/asm/qspinlock.h
@@ -12,6 +12,8 @@
 /* How long a lock should spin before we consider blocking */
 #define SPIN_THRESHOLD		(1 << 15)
 
+extern bool nopvspin;
+
 void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 void __pv_init_lock_hash(void);
 void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
@@ -29,5 +31,27 @@ static inline void queued_spin_unlock(struct qspinlock *lock)
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
 #include <asm-generic/qspinlock.h>
+#include <asm/jump_label.h>
+
+/*
+ * KVM guests fall back to a Test-and-Set spinlock because fair locks suffer
+ * from severe lock-holder-preemption issues. When virt_spin_lock_key is
+ * enabled, virt_spin_lock() shortcuts queued_spin_lock_slowpath() and hijacks
+ * the lock acquisition.
+ */
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+
+#define virt_spin_lock rv_virt_spin_lock
+static inline bool rv_virt_spin_lock(struct qspinlock *lock)
+{
+	if (!static_branch_likely(&virt_spin_lock_key))
+		return false;
+
+	do {
+		smp_cond_load_relaxed((s32 *)&lock->val, VAL == 0);
+	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+
+	return true;
+}
 
 #endif /* _ASM_RISCV_QSPINLOCK_H */
diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
index 04b13994e971..28c6c78d7e84 100644
--- a/arch/riscv/kernel/qspinlock_paravirt.c
+++ b/arch/riscv/kernel/qspinlock_paravirt.c
@@ -50,6 +50,8 @@ EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
 DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
 EXPORT_STATIC_CALL(pv_queued_spin_unlock);
 
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
+
 bool __init pv_qspinlock_init(void)
 {
 	if (num_possible_cpus() == 1)
@@ -58,6 +60,12 @@ bool __init pv_qspinlock_init(void)
 	if (!sbi_probe_extension(SBI_EXT_PVLOCK))
 		return false;
 
+	if (nopvspin) {
+		static_branch_enable(&virt_spin_lock_key);
+		pr_info("virt_spin_lock enabled by nopvspin\n");
+		return true;
+	}
+
 	pr_info("PV qspinlocks enabled\n");
 	__pv_init_lock_hash();
 

-- 
2.43.0


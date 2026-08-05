Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B43DE448
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912729; cv=none; b=J7bxb6kOvA/yFd1RACU/kWF2dhiRXZMazhUIxe8f3A+VcO8sEd8j/UmJzCPFAGipwL05PMGmd6RIGju5b9iAExrMPV/us/uwMZRDIXpqidY5f1ChvJHnp5LbhYyudBSzyb2PL2FREfzR/r9L+i4XijVi8Ga+E6XnmCjxO129JHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912729; c=relaxed/simple;
	bh=AvJ9MagU8duZjSz4tI5oi9cEuxlSaWddwjqe48vSyj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FvNLCkp7qtjlQyyYjp/O88gRT2satZkQNkSLOfXZ/8RLprGey10OeTfsesa9On39fWj8tJrqKTDMY9J+3xJOgumDb0cGSqnUgvJXjFbzXaENJN+R0sesSYGGnUw6y9HHyzIOBf5iCDxmgJkLUM9sazl0xySlrKLLJjVo/i7/x+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMcDVRSA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMcDVRSA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso556910a91.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785912723; x=1786517523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZveE5TKFRvmEM6ufGP9KCDDa09D/zv/1Va+H0O6po0=;
        b=PMcDVRSAXAa/Ux/9o3cXvCpo4g4wm27qH0JbgOlpBPYIqA3PTQ8Rnb31brmgFmt9KY
         Qo9ciuNW4XH7Hzy4W2hqCIHJPgZnirE8a8hzMp9QDF/mOiuLvi/E0JN1mFF9ni+6zvU6
         BO2bULnSGxwFx5XsbdZsj1ucnzc/8PSLpLP8TdMK4LOcjrPN1a2IZ2l2rZb6XNzH4q8u
         pBQrAlONlZHAdMZ7378aARvd7QMQT7stWLQxA7c1xGcJ/eAo8N+53URZ+4vAKt7P4qIS
         EsB/kOFYrhanie5Erei3lkHz6O2RL6rOivIv4/a7A9yKW/HJtsgwz6i4yhTtSHCTEKzs
         XLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785912723; x=1786517523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZveE5TKFRvmEM6ufGP9KCDDa09D/zv/1Va+H0O6po0=;
        b=DIx2OWG+UC5nNqN+vGQk1Rabs4HAarHqTDk8WRg/+medVL3ATZOnrhiIHYDu0DbCf6
         jjBGVLtQArEqxzNK038HpT81n2o/E4WQJfZDKO84+3m7671FxLu/0R32YsRg4u8A2E/5
         n/QPPGNPDRiBeBWwLBQN7jvVv0+ro5O8huyL+drTnPoWfiKHbceIMOYyhZlc6rVpqvQO
         ye0Eh4BiYdh21dXAR9BmkrkwcCasRi0dda1a7xdBSiLvmiSeTNnAxHrhjW94UnlmZtxJ
         sh2xqZRLafHuC9QBSHHUkuSJEwWEFBmxXvvmXth9ZjG9IvBJ8VQnLUp8IDU8fXzYp5QB
         fAog==
X-Forwarded-Encrypted: i=1; AHgh+RoEczPgbgZ9n6u+KmKv610VFMcTAVkg722DqEhmUt3DI3AcwJtWdHsHgiRBshx4Hkkeln8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEm2BkCH2y5z8fjOuBFNCYeY8cjDBnZGZa8lf6/B0w0Lisb5g
	SQW/TuDsB1OXG1qJQ25tAYmj4lDg0DD+EKxHNnk2qck2NI2Y4wJ6QUG2
X-Gm-Gg: AR+sD13EaowadCoKb03EfOED7ZXQslcplunQZKoIkP061tIVrfoQ+ksOUrcA25BXF5w
	RAx54E7/l3jdfD57e9g6PGSkCZd2dK1mxwsseFKWPrMKyObHuM84zSSB5hGa87xtox2ikexKan+
	OweLsz74ioCptFGsyP3kOrnqLQwGaCUUWqmMDO1XZDAfH11SeqF1l635l4OatdmoSLz/d69kpRk
	GKZTrjyT3nIHkDJ/HCdDsHITb6JhpsLjshTQQ8VodT1UTNChaNnVa9+n+CQFj0zKFyflmoLVRqK
	Q4GkqUxvwLGB5tGriEJQAwowvdGXuVYGuSek1iCqCq0vRi6GGw9LeIFKEzDgSkthLNZE3pB7Ffe
	3ycgygvmYDmVBX+Gng5DjIXvwuZEbPByYuOfYuaHHN3gFqtVU4KmQJdC2iIsyCzYM4zIsSCcz1V
	Jd4kjuHyQEOWg9gr9pnYr9JUwaZwsWZ+dSzpS+M2CGjYqqAWfa7/vIzo9HvaAjkAty/0oh910Dm
	Hcs5WmnKTduQWEgIg==
X-Received: by 2002:a17:90b:1c8e:b0:38f:1a80:d1e7 with SMTP id 98e67ed59e1d1-3903c596de7mr3372058a91.13.1785912722454;
        Tue, 04 Aug 2026 23:52:02 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392b2b7fsm2113080a91.14.2026.08.04.23.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:52:02 -0700 (PDT)
From: "Yuhang.Chen" <yhchen312@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	kernel test robot <lkp@intel.com>,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH v3] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control VS-mode WFI trapping
Date: Wed,  5 Aug 2026 14:51:32 +0800
Message-Id: <20260805065132.3210346-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel command-line option, kvm-riscv.wfi_trap_policy=trap|auto,
that controls whether a WFI executed by a VS-mode guest traps into KVM
(HS-mode) or executes natively.

HSTATUS.VTW governs VS-mode WFI: when set, the WFI traps into KVM, which
blocks the vCPU through kvm_vcpu_halt() and releases the CPU to other
runnable tasks; when clear, the guest runs WFI natively. Because RISC-V
WFI is only a hint (it may be a no-op on some implementations), the
policy is re-evaluated before each guest entry rather than fixed once
at reset.

  trap  : always trap VS-mode WFI into KVM (HSTATUS.VTW=1). This is the
          default and preserves the previous unconditional behavior.

  auto  : clear HSTATUS.VTW so the guest runs WFI natively only when the
          vCPU is the sole runnable task on the current CPU; otherwise
          keep trapping. When the vCPU is alone, skipping the
          virtual-instruction exit cannot starve another task, and on
          hardware that honors WFI the hart blocks until a VS-mode
          interrupt. The policy is re-evaluated before every guest entry,
          so when another task becomes runnable the next entry traps
          again and KVM blocks the vCPU through kvm_vcpu_halt(), yielding
          the CPU. The vCPU therefore never monopolizes the CPU the way
          an unconditional native WFI would: it either blocks through
          kvm_vcpu_halt(), or runs WFI natively only when no other task
          needs the CPU.

Measured on QEMU TCG (-smp 1, -cpu max): wfi_exit_stat delta and guest
wake count over a 3 s window. "busy" adds a CPU-bound competitor that
shares the vCPU's CPU so that single_task_running() reports false:

  policy  busy  exits  wakes   cpu%  note
  ------  ----  -----  -----   ----  ------------------------
  trap    off    286    285    6.5   default; no regression
  trap    on     291    290  101.0   trap is unconditional
  auto    off      4    287    5.0   sole task: native WFI
  auto    on     285    284  101.5   competitor -> traps

With "auto", WFI exits drop to ~0 when the vCPU is the only runnable
task, and rise back to the trap level as soon as a competitor appears,
which is the desired dynamic behavior. Host CPU stays low in the
sole-task case; the ~101% in the busy cases is the forked competitor,
not the vCPU.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.Chen <yhchen312@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608051354.KYOXP5po-lkp@intel.com/

---
Changes in v3:

- Guard the early_param() parser with #ifndef MODULE. RISC-V KVM is
  tristate and may be built as a module (CONFIG_KVM=m), but
  early_param() is only defined for built-in code, so v2 failed to
  compile as a module. With CONFIG_KVM=m the policy now keeps its
  default (trap) value, which is safe and regression-free; the rest of
  the policy logic is unaffected. The kernel-parameters.txt entry now
  documents that the option is only honored when KVM is built in.

- Re-evaluate the WFI trap policy before each guest entry instead of
  only in kvm_arch_vcpu_load(). In v2 the policy was checked once when
  the vCPU was loaded, so between two kvm_arch_vcpu_load() calls
  HSTATUS.VTW could go stale: if a task of lower or equal priority woke
  on the vCPU's CPU while the guest was running, the run loop would
  re-enter the guest without re-checking and without preempting, and a
  native WFI could then halt the hart and delay the woken task until the
  next timer tick. Checking before every entry closes this window,
  because a wakeup arrives through a host interrupt that forces a VM
  exit, and the next entry re-evaluates and traps.

Changes in v2:

- Drop the "notrap" mode, which cleared HSTATUS.VTW unconditionally and
  so never trapped: the vCPU never reached kvm_vcpu_halt() and could
  stay busy even while idle.
- Add the "auto" mode, which clears HSTATUS.VTW only when the vCPU is
  the sole runnable task (single_task_running()) and otherwise traps.
  The policy is applied dynamically from kvm_arch_vcpu_load() instead of
  once at reset, so a vCPU that stops being the sole runnable task
  switches back to trapping.
- Update the kernel-parameters.txt entry for trap/auto.

v1: https://lore.kernel.org/all/20260709115610.287420-1-yhchen312@gmail.com/
v2: https://lore.kernel.org/all/20260804024707.2400404-1-yhchen312@gmail.com/
---
 .../admin-guide/kernel-parameters.txt         | 20 ++++++
 arch/riscv/kvm/vcpu.c                         | 72 +++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..2ab9eb335e60 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3254,6 +3254,26 @@ Kernel parameters
 
 			notrap: clear WFI instruction trap
 
+	kvm-riscv.wfi_trap_policy=
+			[KVM,RISCV] Control when to set the WFI instruction
+			trap (HSTATUS.VTW) for KVM VMs. The policy is
+			re-evaluated before each guest entry, not only at
+			reset, since RISC-V WFI is only a hint.
+
+			trap: always trap VS-mode WFI into KVM (HSTATUS.VTW=1)
+
+			auto: trap unless the vCPU is the only runnable task on
+				the current CPU, in which case clear the trap
+				(HSTATUS.VTW=0) and let the guest execute WFI
+				natively
+
+			Defaults to trap, preserving the previous unconditional
+			behavior.
+
+			Only honored when KVM is built into the kernel
+			(CONFIG_KVM=y); as a module (CONFIG_KVM=m) the policy
+			stays at its default (trap).
+
 	kvm_cma_resv_ratio=n [PPC,EARLY]
 			Reserves given percentage from system memory area for
 			contiguous memory allocation for KVM hash pagetable
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index cf6e231e76e2..8efeb74699cc 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -12,8 +12,10 @@
 #include <linux/kdebug.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/stat.h>
 #include <linux/fs.h>
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
@@ -26,6 +28,67 @@
 
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
 
+/*
+ * WFI trap policy for VS-mode guests, controllable through the
+ * kvm-riscv.wfi_trap_policy= kernel command-line option.
+ */
+enum kvm_riscv_wfi_trap_policy {
+	KVM_RISCV_WFI_TRAP,	/* Always trap VS-mode WFI into KVM */
+	KVM_RISCV_WFI_AUTO,	/* Trap unless the vCPU is the only runnable task */
+};
+
+static enum kvm_riscv_wfi_trap_policy kvm_riscv_wfi_trap_policy __read_mostly =
+	KVM_RISCV_WFI_TRAP;
+
+/*
+ * RISC-V KVM is tristate and may be built as a module, but early_param() is
+ * only defined for built-in code (see <linux/init.h>). Guard the command-line
+ * parser accordingly: when CONFIG_KVM=m the policy simply keeps its default
+ * (trap) value, which is the safe, regression-free behavior.
+ */
+#ifndef MODULE
+static int __init early_kvm_riscv_wfi_trap_policy_cfg(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "trap") == 0) {
+		kvm_riscv_wfi_trap_policy = KVM_RISCV_WFI_TRAP;
+		return 0;
+	}
+
+	if (strcmp(arg, "auto") == 0) {
+		kvm_riscv_wfi_trap_policy = KVM_RISCV_WFI_AUTO;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+early_param("kvm-riscv.wfi_trap_policy", early_kvm_riscv_wfi_trap_policy_cfg);
+#endif
+
+static bool kvm_riscv_vcpu_wfi_should_trap(struct kvm_vcpu *vcpu)
+{
+	switch (kvm_riscv_wfi_trap_policy) {
+	case KVM_RISCV_WFI_AUTO:
+		/* Native WFI only when the vCPU is the sole runnable task. */
+		return !single_task_running();
+	case KVM_RISCV_WFI_TRAP:
+	default:
+		return true;
+	}
+}
+
+static void kvm_riscv_vcpu_update_wfi_trap(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
+
+	if (kvm_riscv_vcpu_wfi_should_trap(vcpu))
+		cntx->hstatus |= HSTATUS_VTW;
+	else
+		cntx->hstatus &= ~HSTATUS_VTW;
+}
+
 const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
@@ -73,6 +136,7 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcpu *vcpu,
 	/* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
 	cntx->sstatus = SR_SPP | SR_SPIE;
 
+	/* Trap VS-mode WFI by default; the run loop reapplies the policy before each entry. */
 	cntx->hstatus |= HSTATUS_VTW;
 	cntx->hstatus |= HSTATUS_SPVP;
 	cntx->hstatus |= HSTATUS_SPV;
@@ -936,6 +1000,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 */
 		kvm_riscv_local_tlb_sanitize(vcpu);
 
+		/*
+		 * Re-evaluate the WFI trap policy for this entry so that
+		 * HSTATUS.VTW tracks the current runnable-task count and
+		 * cannot go stale across guest entries (which would let a
+		 * native WFI halt the CPU while another task is runnable).
+		 */
+		kvm_riscv_vcpu_update_wfi_trap(vcpu);
+
 		trace_kvm_entry(vcpu);
 
 		guest_timing_enter_irqoff();
-- 
2.34.1


Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077717C220;
	Tue, 26 May 2026 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765351; cv=none; b=o6Dj1Z7taTJqKAg67S07aoCrz2Ngrn0UXrKSy6lI7MPj0F9+sj0mQ/GlZs4jYlZyitwWV3TgYzHo4ePvO9ULLfcNjDNMIWIhxNLTQHgehMLI3TE7WlgdGN1RWA7f69RX1ZjQHz6RN+wKDIuQ+EXL5ibuWN7alai+6EmoXn7UTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765351; c=relaxed/simple;
	bh=g4NvqahIRfrXtpjswB/Z/Zs6eXFPz88fFr5ZheFLVZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8D+WPM4RYuW56vU5XFfRLmP/JOl+tV6+cmMOmqR7l5mjkc6LY+vJxI0gPsJDpV9n+CpOABNZB/a1ZkqZQPh+fP1qthl/xjywaNVv2RNxWD5ZxqbirwLUjPjHiOFeytO0eYPwSQUe2LjwKA3IdN4UkWMLv3yoEskJaEOEoHfd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnSeBJEBVq0pxjEg--.16714S2;
	Tue, 26 May 2026 11:15:21 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Nutty Liu <liujingqi@lanxincomputing.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH] RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC functions
Date: Tue, 26 May 2026 03:15:17 +0000
Message-Id: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSeBJEBVq0pxjEg--.16714S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyUZrWrAw1ktw4xWr1rZwb_yoWxAF4xpr
	Z8Wr48Cr40yw47X3y2vry5Jr4kJr1UC3W7GryxKwn8XF1UKw18Zrn7Xry7GFyDGry8ZFy7
	tr1Dtay09r1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAYSCWoUK52DawABsw

Fuzzer reported a NULL pointer dereference in 
kvm_riscv_vcpu_aia_imsic_put() when a VCPU's imsic_state was NULL while 
kvm_riscv_aia_initialized() returned true.

The global initialized flag is set per-VM in aia_init(), but imsic_state 
is allocated per-VCPU in kvm_riscv_vcpu_aia_imsic_init(). If a VCPU is 
created after aia_init() has already run, its imsic_state remains NULL 
while the global flag is true. When this VCPU is preempted, kvm_sched_out()
calls kvm_arch_vcpu_put() -> kvm_riscv_vcpu_aia_put() ->
kvm_riscv_vcpu_aia_imsic_put() which dereferences NULL.

Add NULL pointer guards to kvm_riscv_vcpu_aia_imsic_put(), consistent with 
the NULL checks already present in all other functions in the same file.

Also add a NULL guard to kvm_riscv_vcpu_aia_imsic_release() and 
kvm_riscv_vcpu_aia_imsic_has_interrupt() for the same reason.

Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization")
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Assisted-by: YuanSheng:DeepSeek-V3.2
---
 arch/riscv/kvm/aia_imsic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 8786f52cf65a2..d38f5de0834c5 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -683,6 +683,9 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 	unsigned long flags;
 	bool ret = false;
 
+	if (!imsic)
+		return false;
+
 	/*
 	 * The IMSIC SW-file directly injects interrupt via hvip so
 	 * only check for interrupt when IMSIC VS-file is being used.
@@ -722,6 +725,9 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vcpu)
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
 	unsigned long flags;
 
+	if (!imsic)
+		return;
+
 	if (!kvm_vcpu_is_blocking(vcpu))
 		return;
 
@@ -738,6 +744,9 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 	int old_vsfile_hgei, old_vsfile_cpu;
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
 
+	if (!imsic)
+		return;
+
 	/* Read and clear IMSIC VS-file details */
 	write_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
-- 
2.34.1

Found by fuzzing. Here is the report:

Unable to handle kernel paging request at virtual address dfffffff00000006
Modules linked in:
CPU: 1 UID: 0 PID: 26225 Comm: syz.9.1131 Tainted: G        W           7.1.0-rc1-gb69bcb13ed70 #2 PREEMPT 
Tainted: [W]=WARN
Hardware name: riscv-virtio,qemu (DT)
epc : kasan_byte_accessible+0x12/0x20 mm/kasan/generic.c:210
 ra : __kasan_check_byte+0x16/0x46 mm/kasan/common.c:573
epc : ffffffff80beb626 ra : ffffffff80be9622 sp : ff200000016276a0
 gp : ffffffff8a395320 tp : ff6000008f6f5040 t0 : ffffffff86a7e880
 t1 : ffffffff8a4a4a00 t2 : 0000000000000000 s0 : ff200000016276b0
 s1 : 0000000000000030 a0 : dfffffff00000006 a1 : ffffffff867223e4
 a2 : 0000000000000000 a3 : 0000000000000007 a4 : 0000000000000003
 a5 : dfffffff00000000 a6 : ffffffff8010e72c a7 : 0000000000000004
 s2 : 0000000000000030 s3 : ffffffff867223e4 s4 : 0000000000000000
 s5 : 0000000000000000 s6 : 0000000000000000 s7 : ffffffff8010e72c
 s8 : ffffffff867223e4 s9 : ffffffff8a3da080 s10: 0000085c7b3d0060
 s11: ff6000008f6f5040 t3 : ffffffff8a4a4a00 t4 : ffffffff8a4a5a80
 t5 : 1ffffffff22ed7d1 t6 : ff600000ffa4d710 ssp : 0000000000000000
status: 0000000200000100 badaddr: dfffffff00000006 cause: 000000000000000d
[<ffffffff80beb626>] kasan_mem_to_shadow include/linux/kasan.h:66 [inline]
[<ffffffff80beb626>] kasan_byte_accessible+0x12/0x20 mm/kasan/generic.c:210
[<ffffffff80be9622>] __kasan_check_byte+0x16/0x46 mm/kasan/common.c:573
[<ffffffff802fe7ba>] kasan_check_byte include/linux/kasan.h:402 [inline]
[<ffffffff802fe7ba>] lock_acquire kernel/locking/lockdep.c:5842 [inline]
[<ffffffff802fe7ba>] lock_acquire+0x198/0x50e kernel/locking/lockdep.c:5825
[<ffffffff867223e4>] __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:174 [inline]
[<ffffffff867223e4>] _raw_read_lock_irqsave+0x76/0x82 kernel/locking/spinlock.c:240
[<ffffffff8010e72c>] kvm_riscv_vcpu_aia_imsic_put+0x72/0x17c arch/riscv/kvm/aia_imsic.c:728
[<ffffffff80101bda>] kvm_riscv_vcpu_aia_put+0x288/0x324 arch/riscv/kvm/aia.c:155
[<ffffffff8011f210>] kvm_arch_vcpu_put+0x44/0x612 arch/riscv/kvm/vcpu.c:621
[<ffffffff800d50aa>] kvm_sched_out+0xdc/0x296 virt/kvm/kvm_main.c:6405
[<ffffffff86705faa>] __fire_sched_out_preempt_notifiers kernel/sched/core.c:4923 [inline]
[<ffffffff86705faa>] fire_sched_out_preempt_notifiers kernel/sched/core.c:4931 [inline]
[<ffffffff86705faa>] prepare_task_switch kernel/sched/core.c:5176 [inline]
[<ffffffff86705faa>] context_switch kernel/sched/core.c:5332 [inline]
[<ffffffff86705faa>] __schedule+0x10c8/0x513c kernel/sched/core.c:7188
[<ffffffff8670a0e2>] __schedule_loop kernel/sched/core.c:7267 [inline]
[<ffffffff8670a0e2>] schedule+0xc4/0x35e kernel/sched/core.c:7282
[<ffffffff80121cc2>] kvm_riscv_check_vcpu_requests arch/riscv/kvm/vcpu.c:670 [inline]
[<ffffffff80121cc2>] kvm_arch_vcpu_ioctl_run+0x1d16/0x3214 arch/riscv/kvm/vcpu.c:885
[<ffffffff800da8ee>] kvm_vcpu_ioctl+0x532/0x13ce virt/kvm/kvm_main.c:4469
[<ffffffff80d45c90>] vfs_ioctl fs/ioctl.c:51 [inline]
[<ffffffff80d45c90>] __do_sys_ioctl fs/ioctl.c:597 [inline]
[<ffffffff80d45c90>] __se_sys_ioctl fs/ioctl.c:583 [inline]
[<ffffffff80d45c90>] __riscv_sys_ioctl+0x180/0x1e4 fs/ioctl.c:583
[<ffffffff80078fb2>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff866fa94a>] do_trap_ecall_u+0x43e/0x5de arch/riscv/kernel/traps.c:342
[<ffffffff86726756>] handle_exception+0x15e/0x16a arch/riscv/kernel/entry.S:232
Code: 8082 07b7 e000 1141 17fd e422 810d 0800 1782 953e (4503) 0005 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8082                	ret
   2:	e00007b7          	lui	a5,0xe0000
   6:	1141                	addi	sp,sp,-16
   8:	17fd                	addi	a5,a5,-1 # 0xffffffffdfffffff
   a:	e422                	fsw	fs0,8(sp)
   c:	810d                	srli	a0,a0,0x3
   e:	0800                	addi	s0,sp,16
  10:	1782                	slli	a5,a5,0x20
  12:	953e                	add	a0,a0,a5
* 14:	00054503          	lbu	a0,0(a0) <-- trapping instruction

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665175;
	b=nQNof1pVLG/Hu4iouRUGwZeYAWMhLid0hXeRWkABe/iL6k9gHTBzTo+KE6VZAhUmURlc
	 Q/LPnRqevYLaALQOnHfRrE+cvzscOeVKLTicHOZEIZTF4TMTdU6KEqmVBHtytPjWiipSK
	 FNGOt2OEcMHQpuRdsen0qC8LpO/gjzswU4u0RypgEvsFlPt3wtTbDiJmQH8YyC/ucDa4W
	 TLisn3HCeLmRemDGu/vCLIBbEHBA4NIozoaACRbJ5Dkv9qQNJzgsc3ZFBZWFhPmppSOSI
	 qAQu7xpx/+Ra8xuPl87py+KU1auFoBnHjFjlkJmaZJo7XyixURm3fj9NCqELzHRlydA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X9Wq8XF3OPdtzbvwHB0Z+luie/2UkRIF5LJ7BhOQmfs=;
	b=sAdCP6QMvzjE7DTv2VPmWyo3cNGtSLgJG6uIzNTITloc0PacOJOx2kHTLD3t3Plwj51l
	 Yjw/gzrt9+CyLA7uNVBU+mg9Zcp1eqjvd0zZ+85cFmuKvN4CJRFxDev4w5DngLuOA7tdi
	 wvfQaN/9YxPJ344zQxT2fCm37fKB9+HuXx0p2hwuLwu3KCbc2WPaYgni4Chyl3A5AuDNy
	 UhMBG1YK8+Sh9UZQQPs50sZlVKYlf8FC9bpMOlGsra0uiBGG+IBpP0g+PAedwVMC99q79
	 x5VFawsGy7O2MWyZeuJCNnI73Lm5TrkN5Mi0452QAbQrjR2gueLPklvjsU7iKiVR41Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q2/gdkBn";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD9606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 03:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q2/gdkBn
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f01f296937so50490215ad.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795665174; x=1796269974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X9Wq8XF3OPdtzbvwHB0Z+luie/2UkRIF5LJ7BhOQmfs=;
        b=q2/gdkBnhnE15lJsB6LI0qGb8yFcqm2T3LZCqy6VjTliwlhwAT8x0YERe7oAeIn3kD
         2rK9ZcCtSc0RGHmbcoQNcZEyKZJGKrJUksOufXiJWxTcA0fBGg8sRMjpj7SYjxUKlBGO
         SNkVi8SrmNqdGoeQhSTC5USB4Wiuy59ZiMBwWrGrVJchtcnh8cbAWku2X9idjmlvUpuY
         i2EPLdo7xdf6KW0TNyueOc6tsYenYZmcbm++J8wE8ttaA7fx7I9cJGC2WdV0E/SHpFcF
         3k4OPGkMmSc8FC5uItR1GCBoZ//WMIC+YpJ8gCexfGwyssxWRh8Q0W8+dcyxFzCD05hQ
         d/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665174; x=1796269974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9Wq8XF3OPdtzbvwHB0Z+luie/2UkRIF5LJ7BhOQmfs=;
        b=DBzXMgxOt7558u7nyVjDyL8AtlRdSyiHTnzjMcIh6nd0FG2dxpEHT9s43qLEVa09OQ
         iHriVc0YFOR1fzOdmVLnWA3poMOo99Vb3qBOvYx8ZWPcX1/9SfayAJxOUqNwVm84Jl0o
         sVVYZbqZdJ+OgGbAllC5p00r4BPEQNmwQDkLgluAmeIBKWuY2v127Mk4y3rGj7Ntn+3Y
         ZCmZ/LptB2fAcw2p1Vd1opCAk0OUKstmg3zKoaWIuoEdcmc0HbKpAbgHE5pGCllVrH+8
         Hh41b3ro6MLteZ5xa1jus72Cao94cNg5+4v50J938i0C3WanYeWMx0xS8pcsyZT9mXdu
         k/gg==
X-Gm-Message-State: APuU4Z/KUW1zLDu4Bc95pPMUs6EdovyJt3oRBKoCqu+NcXY2bVB2w+En
	DqRS9bL059O+1RiAU/Gaw6H4GgSlmhLZUtFuDtltUtOlQBJ4cTtRb7ieJCto9u5g
X-Gm-Gg: AZFdTZebJvaiLpP6lxvFxdRzTvAIi0L7+GLMgAzJLW2aJVtYV2Fv5H1ZsQUHONojj3M
	dy8ktKJjJf/U5zGre1ZeG/DeQON7upg3/qQIsy2dmlfpTt74MFMG66LuIDJFhwMsmwx/hzerv2Z
	j9oRmNdapcdkU6TQVal7XfgRlzRLvyVlMKHRcZIpTEafZvOgb8jG6/TzG90rDm8uKACj594oUGf
	vs0bYhG8+ammhEMKOfQLd0Z0+iDOU2FHlAel9X3ZAp/EQcnDGqbdffxOE76fBCyEkTnHvCnqYWy
	WYdPn2siuhb4Ava8q6W4ayRR9wUqjUcPQ4FoOT9phdpzc0uEEjwtYO5hxrMvuR8WmbS2H9qytny
	sTsdDL1jOxnenx38A684Fgm8mENmP2qxH5yVaXzchz4PkzOHvvtvqVewKbqx7svECxCiJRb9LWc
	NviVefkY370ShrMt0DBnuw6yv71UvhUC9rqExRgpKmIk9ZfKwoduJbJ8p+n8eWer2Kaur/+ptqh
	j9QHLk6MMD2bQ65WRSk7aO47VLSC8aXfne3Wpvi2pS9LAPp88eHj03YPQpnwohbbyd2FzXZT891
	uTD3rBJUNXwA5ALXx6KbaiWWKQugcnywZuh976Tv1XIPp4YJe6nR/MID32vUhduACSifz1CB
X-Received: by 2002:a17:902:d58e:b0:2e4:b112:14d with SMTP id d9443c01a7336-2f03f27d72emr191908095ad.54.1795665173837;
        Wed, 25 Nov 2026 19:52:53 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42a6sm97011765ad.23.2026.11.25.19.52.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 19:52:53 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: selftests: Test that an NMI-window single-step preserves the guest's RF
Date: Thu, 26 Nov 2026 11:52:49 +0800
Message-ID: <20261126035249.92593-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the guest-handled part of debug_regs with the case where KVM
single-steps the IRET of an NMI handler to find out when NMIs are
unblocked (SVM without vNMI), and that IRET returns to an instruction
breakpoint with RF set in the popped RFLAGS.

The guest arms an instruction breakpoint, sends itself an NMI that is
delivered at the breakpoint address, and from the NMI handler sends a
second NMI, which stays pending, and sets RF in the interrupt frame.
The second NMI is delivered once the first handler's IRET completes,
and when it returns the breakpoint must not fire.

Without the preceding fix this fails on AMD with kvm_amd.vnmi=0, as the
guest takes a #DB at the breakpoint.  It passes with vNMI, and on Intel,
where KVM doesn't single-step to open the NMI window.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 tools/testing/selftests/kvm/x86/debug_regs.c | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index 2a2ef3e179ff..bc75f83e9aed 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -11,6 +11,8 @@
 #include "apic.h"
 
 #define DR6_BD		(1 << 13)
+#define DR7_L0		(1 << 0)
+#define DR7_GE		(1 << 9)
 #define DR7_GD		(1 << 13)
 
 #define IRQ_VECTOR 0xAA
@@ -22,8 +24,12 @@ u32 guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
 extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
+extern unsigned char nmi_bp;
 
 static int irqs_received;
+static int nmis_received;
+static int nmi_bp_dbs;
+static bool in_nmi_bp_test;
 
 static void guest_db_handler(struct ex_regs *regs)
 {
@@ -33,6 +39,12 @@ static void guest_db_handler(struct ex_regs *regs)
 		CAST_TO_RIP(fep_sti_end),
 	};
 
+	if (in_nmi_bp_test) {
+		nmi_bp_dbs++;
+		regs->rflags |= X86_EFLAGS_RF;
+		return;
+	}
+
 	__GUEST_ASSERT(regs->rip == target_rips[count],
 	               "STI[%u]: unexpected rip 0x%lx (should be 0x%lx)",
 		       count, regs->rip, target_rips[count]);
@@ -61,8 +73,34 @@ static void guest_irq_handler(struct ex_regs *regs)
 	x2apic_write_reg(APIC_EOI, 0);
 }
 
+static u64 self_nmi_icr(void)
+{
+	return ((u64)x2apic_read_reg(APIC_ID) << 32) | APIC_DEST_PHYSICAL |
+	       APIC_DM_NMI;
+}
+
+static void guest_nmi_handler(struct ex_regs *regs)
+{
+	if (nmis_received++)
+		return;
+
+	__GUEST_ASSERT(regs->rip == CAST_TO_RIP(nmi_bp),
+		       "NMI: unexpected rip 0x%lx (should be 0x%llx)",
+		       regs->rip, CAST_TO_RIP(nmi_bp));
+
+	/*
+	 * NMIs are blocked, so this one stays pending until the IRET below
+	 * completes.  Return to nmi_bp with RF set, as if resuming after the
+	 * instruction breakpoint was handled.
+	 */
+	x2apic_write_reg(APIC_ICR, self_nmi_icr());
+	regs->rflags |= X86_EFLAGS_RF;
+}
+
 static void guest_code(void)
 {
+	u64 icr;
+
 	/* Create a pending interrupt on current vCPU */
 	x2apic_enable();
 	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
@@ -129,6 +167,28 @@ static void guest_code(void)
 			     "cli\n\t");
 		GUEST_ASSERT(irqs_received == 1);
 	}
+
+	/*
+	 * An NMI handler that returns to an instruction breakpoint with RF set
+	 * must not see the breakpoint fire, including when KVM single-steps
+	 * the IRET to find out when NMIs are unblocked (SVM without vNMI).
+	 * The handler sends a second NMI so that KVM has to do that.  The
+	 * first NMI is sent with a bare WRMSR so that it is delivered with RIP
+	 * pointing at nmi_bp, before the breakpoint is checked.
+	 */
+	in_nmi_bp_test = true;
+	asm volatile("mov %0, %%dr0" : : "r"(CAST_TO_RIP(nmi_bp)));
+	asm volatile("mov %0, %%dr7" : : "r"((u64)(0x400 | DR7_GE | DR7_L0)));
+	icr = self_nmi_icr();
+	asm volatile("wrmsr\n\t"
+		     "nmi_bp: nop"
+		     : : "c"(APIC_BASE_MSR + (APIC_ICR >> 4)),
+			 "a"((u32)icr), "d"((u32)(icr >> 32)) : "memory");
+	asm volatile("mov %0, %%dr7" : : "r"((u64)0x400));
+	in_nmi_bp_test = false;
+	GUEST_ASSERT_EQ(READ_ONCE(nmis_received), 2);
+	GUEST_ASSERT_EQ(READ_ONCE(nmi_bp_dbs), 0);
+
 	GUEST_DONE();
 }
 
@@ -287,6 +347,7 @@ int main(void)
 
 	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
 	vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
-- 
2.43.7


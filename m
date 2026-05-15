Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A73F5BF5
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884019; cv=none; b=sXFSaoBRRWS5C0TI/syxLY5x4KN8kcPabJ2e2pgfiPN78LzjL4UTUuTICM7pEgPemFSy9dRLv2u7i9rI4NHwJhPNSX0LcMaO+bErjTBOHIVzUZa2g2n17paLXnclkgDlA4OqOkvjQ4slp1K54wxzx7GSlwbGuMJ50deN/JpJ1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884019; c=relaxed/simple;
	bh=AI8swpZdMNXp8gh4dSHC5ohh2k6RKZGt83XB3iB/gB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MnebZqI5g81QlzmjWLDl5QPjJAqA8eYgi3hHO4AD8MtwL7QlSLPhaYSfAyw5IB7MAipDcmv9fl9qJuSWrcmmr+Ww9sqvMTtfHMKumuy6jomZvpStyexHI/lCJCtmzVa3vUrLGNYve767DD9grJ8pHnVWiT7SMT7FaJDJ+pnr4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XRZo10eS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRZo10eS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c81086bf930so896477a12.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884011; x=1779488811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9ovQNC12U2XStCFtUMejGJVXuhxl5J+P8g7DP3pcchg=;
        b=XRZo10eSO5Fkx+/HlMTvqQbgelQiuVMUYZnnO3tlC5thmHjunlBS7qEdtnu662C67h
         6XPE5E0NY7y+co7R7vA571j74q8IwXG29a4olvmyS7UMrGQFrSwgFCekMzcwpYQq1cVz
         GKugU1Iq5ptFZiPLAYbLyuMUAgfeQScSgpog9/cHXQCV0esZTZrxoLB0pLdUIVgDTtb7
         r4eS604fgFeGicDtEtEL5QLR8j9NZqJGZTmUeGHObNss+xhCg7t5FdyoXdagnGWXIwLb
         V5pG3AHayscTXDnQNFDe4VZ7yqbbW6muUtnKmpHrlryRi58BlHTqcAOON+eypiR2ElGe
         lqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884011; x=1779488811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ovQNC12U2XStCFtUMejGJVXuhxl5J+P8g7DP3pcchg=;
        b=QU1zyQvb5KJm5e4PrX3AW3jWAZDlMkLeG3/35/KJMa/qz5VNA395zfu0COMGt7qneG
         2ZuM+AkJaIQhIOoYhJGrmApEKX7PI0yZrm4qpEtOJhb7AMcARUUOG7m63dlFRESLo1QR
         ru/xqzlnsBhbQ6F66aw/An6vaSIhDVZkoMIdreQWADd+YgksQt4biUIOFVuZY9PYkrxD
         EmsPAbh+uMXSQ72UYU//0Eg/ytSsI6mnyuy/osDiQIYLIbi3U6L9R9i+4g2M3El4UwSk
         8AF3z+M/QdG6re5vW2Brf4Nb4aGBsI07qYSLTCH2cDLBdkymDUxo0pRmc09tuzbWE/z9
         nSkA==
X-Gm-Message-State: AOJu0YyHHO6+sjbtqEh13h0L3632doaieMaMCT6ZpGIVJWHsIDxtF6kc
	aYvJ/k5B637ISuakFVk/lXBSi+z06Oi7gaUU7RdMMhZnto4ArjSAJ7OilQqIEQjX2BnvbP/bD5i
	9zbClSg==
X-Received: from pgjm5.prod.google.com ([2002:a63:fd45:0:b0:c80:22ee:7357])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998e:b0:39c:212c:9088
 with SMTP id adf61e73a8af0-3b0c009dea0mr9777030637.20.1778884011349; Fri, 15
 May 2026 15:26:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:38 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-11-seanjc@google.com>
Subject: [PATCH v3 10/10] KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS
 Consistency Check
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

In x86's debug_regs test, add a test case to cover the scenario where a
single-step #DB occurs in an STI-shadow, in which case KVM needs to stuff
vmcs.GUEST_PENDING_DBG_EXCEPTIONS.BS in order to satisfy a flawed VM-Entry
Consistency Check.

Wire up an IRQ handler to gain a bit of bonus coverage, as the subsequent
IRET from the #DB sets RFLAGS.IF, but *without* STI-blocking, and so the
pending IRQ is expected on the instruction immediately following STI.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
[sean: expect the IRQ on the CLI, and explain why]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/debug_regs.c | 64 ++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index ee9d0f3a5807..6299e921dc27 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -15,11 +15,46 @@
 
 #define IRQ_VECTOR 0xAA
 
+#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
+
 /* For testing data access debug BP */
 u32 guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
-extern unsigned char fep_bd_start;
+extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
+
+static void guest_db_handler(struct ex_regs *regs)
+{
+	static int count;
+	unsigned long target_rips[2] = {
+		CAST_TO_RIP(fep_sti_start),
+		CAST_TO_RIP(fep_sti_end),
+	};
+
+	__GUEST_ASSERT(regs->rip == target_rips[count],
+	               "STI[%u]: unexpected rip 0x%lx (should be 0x%lx)",
+		       count, regs->rip, target_rips[count]);
+	regs->rflags &= ~X86_EFLAGS_TF;
+	count++;
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	/*
+	 * The pending IRQ should finally be take when KVM_GUESTDBG_BLOCKIRQ is
+	 * cleared and IRQs are enabled.  Note, the IRQ is expected to arrive
+	 * on the instruction immediately after STI, even though its in an STI
+	 * shadow.  Because the next instruction has a coincident #DB, and #DBs
+	 * are not subject to STI-blocking, the #DB will push RFLAGS.IF=1 on
+	 * the stack, and the eventual IRET will unmask IRQs and obliterate the
+	 * STI shadow in the process.
+	 */
+	unsigned long target_rip = CAST_TO_RIP(fep_sti_start);
+
+	__GUEST_ASSERT(regs->rip == target_rip,
+		       "IRQ: unexpected rip 0x%lx (should be 0x%lx)",
+		       regs->rip, target_rip);
+}
 
 static void guest_code(void)
 {
@@ -66,14 +101,32 @@ static void guest_code(void)
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
 
-	if (is_forced_emulation_enabled)
+	/*
+	 * Note, the IRET from the #DB that occurs in the below STI-shadow will
+	 * unmask IRQs, i.e. the pending interrupt will be delivered after #DB
+	 * handling, on the CLI!
+	 */
+	if (is_forced_emulation_enabled) {
 		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
 
+		/* pending debug exceptions for emulation */
+		asm volatile("pushf\n\t"
+			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
+			     "popf\n\t"
+			     "sti\n\t"
+			     "fep_sti_start:"
+			     "cli\n\t"
+			     "pushf\n\t"
+			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
+			     "popf\n\t"
+			     KVM_FEP "sti\n\t"
+			     "fep_sti_end:"
+			     "cli\n\t");
+	}
+
 	GUEST_DONE();
 }
 
-#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
-
 static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
 {
 	struct kvm_regs regs;
@@ -227,6 +280,9 @@ int main(void)
 	memset(&debug, 0, sizeof(debug));
 	vcpu_guest_debug_set(vcpu, &debug);
 
+	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
+	vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);
+
 	vcpu_run(vcpu);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	cmd = get_ucall(vcpu, &uc);
-- 
2.54.0.563.g4f69b47b94-goog


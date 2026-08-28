Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641A448D19
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 19:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787945502; cv=none; b=J2jgfWKJF1F7hix7wfe1bclImUzoPjmyvihRasOoYxFG1nBtEEnbsUF44xmvVHdBKrhD2OT/5LX7didxeE/4yMT1/7v7xz3XNMkiNpMmsSnm0SCMACQFYrdXQPfJD3rRbme2Fcahg9ySX461Ef8yP1tdXlhy5IE7GPdrdwuCBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787945502; c=relaxed/simple;
	bh=6V7hAJstDU6bbLka1Kq3FEBTK+faVhG5psX6u1DkCIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cb//UGVdB3QINnBFRkhgWE8SAHZq/FaoJNjwnug0gQZYGV42ONc2nZfZ2WffnuSra4Zc37yd0ZS0yI3PX2KOj2ofitSkV50i+4rw4El7ejL60dDAbrdJdS01VoBtCbbI63ohoTwFuwWVM70ZQa46zYZBrd5DSTRjrl5iWbM3+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SybwmqyS; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SybwmqyS"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4df360cc9so1913525a34.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787945499; x=1788550299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZNybfeocjnUlluD+1bCk2AVsmpbaSxfyCJmA9PFX44=;
        b=SybwmqySXDaH4CkiyywAaajKA16zX0jK1J21g34uGwyykZffwNAq0IjhWiY/fcZmtT
         lfVM8tc8orf+l1EAl5NKxKJCyE/oxyLisydTSpaF8k0rNr7hntVSpyiucTo9CBUx0ad5
         UI3T60rw5g8iSEH6e2cp833wzBpoDs2vYlygQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787945499; x=1788550299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZNybfeocjnUlluD+1bCk2AVsmpbaSxfyCJmA9PFX44=;
        b=J+Js8qRuVJJAjBZbIgTT4zHkBqjMz0n7I1JQrzGtJs8ZPUzHFHM4WT0JH3b0oZA57K
         Q061rdDjjp2uzZe1sg7KriNFAon6x2b3zYmsVsyHuaPapsX7DNiNqxRT+taO4a9YYvAs
         4skEypFzPDqDY8KF+JeLCvJpcrvPjQSLfWeGCffvm3Txknykw0PKjyoEN7+qsOR4vnzm
         sCEDQ66lnJABokeKJL0pKihUS8WMgZlj1m2yLkwI4ozFYkCaXuUaT+C3lzGdpsLikuwp
         Ql3IBuFLMtz9dfUkPsMmL3692kP3pVVMy+JJSZif2VCmXW+C5N+FrDwo+0yIFoJDOmvG
         vA6w==
X-Gm-Message-State: AFuF++mz71pWcWH1LwgBGhnaGFzuAokxqc6LDUWn3KMLWWfWeE8NCAyR
	HQ5DSsgA7KpreHQr0V1MRJSIKepRxHCmn8uryZTao1w+TTEgLJyatd1Li05lPsABhNVyya48weh
	s6CWF5Fo=
X-Gm-Gg: AR+sD11DmL5ZQtIrFe+f8yVZb/eSMCYin9LG1v2LwLx5BG7n6AbRlabZ3ZB8rXJNNk2
	fu8+RmSdXjqlDlxXLOT1vZv28NuBCA39i1YRpB8IKdalz+qvq4KoYwKtUgafnNNMfUkeR6N0jke
	Y029a9mhL//uG+cf6NG5znbm1idQ3AsLNPBy23Z7SU5WnYICIbExi0SFiypH8pmhiLjhIWs3bJ4
	tToliLx4VvQOnMaBVfiS8g/3tcCJ/E0svq2Vt4ZGSuBW7/QMOiehwHEKN02JyOSlSOBvrMLeDQx
	9SVqEEBbBTpiXoeAaLMlZWWd2UynxIcwRDl9YXXuoIcc1P7LNMS2kTLuE8vwsZOTC/V+Yp5uWcY
	m8gPK742CwHfH2r4cZgAt6rAM5gmF3ivTPrvBL7MzUKcNBsYfAtnO29TFtWaABO/bzXD6Dy759h
	jOgnF3PKmtvN2YnC/up3O4TXmv6ap8Zhr0NgeC0ckOOsOAsI2um9f7GOnnlsFLmoRBCRE8GbEes
	a5GIJe3wUmlMjbT/xdIkM5fGqlqJSoZtJRglYorSgRqluvYI/0pHV8k5jITA+KieOym5+WhiLc=
X-Received: by 2002:a05:6830:8e:b0:7e9:f6b7:7752 with SMTP id 46e09a7af769-7f4d7b060b9mr10282578a34.12.1787945498722;
        Fri, 28 Aug 2026 12:31:38 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7e92c1sm2011017a34.8.2026.08.28.12.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 12:31:38 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Chris Ayoub <cayoub@openai.com>,
	Kyle Zeng <kylebot@openai.com>,
	Oleg Boiko <oboiko@openai.com>
Subject: [PATCH] KVM: x86: Restrict saved GPA writes to hardware write faults
Date: Fri, 28 Aug 2026 12:30:55 -0700
Message-ID: <20260828193055.59623-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A GPA supplied by a hardware page fault describes the access that
faulted, not an arbitrary instruction decoded afterwards.  A guest can
change an MMIO read into a store before KVM fetches the instruction.  The
saved-GPA shortcut then skips the write-aware guest page-table walk and
can issue a write through a guest-read-only mapping.

Carry final-write fault information into the emulator and retain it
alongside the saved GPA.  Only reuse that GPA for a write when hardware
reported a final data write.  Reads, faults with unknown access direction,
and implicit guest page-table writes do not authorize an emulated write;
fall back to the existing permission-aware translation in those cases.

Keep the authorization across MMIO completion without decoding a new
instruction, and reset it when initializing a fresh emulator context.
This also covers writes reached through the cmpxchg fallback.

Preserve the shortcut for hardware-authorized writes.  In particular,
legacy SEV guests can have encrypted page tables that KVM cannot walk,
so forcing every emulated write through a software walk is not suitable.

Fixes: 0f89b207b04a ("kvm: svm: Use the hardware provided GPA instead of page walk")
Reported-by: Oleg Boiko <oboiko@openai.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 arch/x86/kvm/kvm_emulate.h |  3 ++-
 arch/x86/kvm/mmu/mmu.c     | 10 ++++++++++
 arch/x86/kvm/x86.c         |  9 ++++++++-
 arch/x86/kvm/x86.h         |  4 ++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..aceca9d3a16d 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -354,8 +354,9 @@ struct x86_emulate_ctxt {
 	bool have_exception;
 	struct x86_exception exception;
 
-	/* GPA available */
+	/* GPA and write access supplied by a hardware page fault. */
 	bool gpa_available;
+	bool gpa_write;
 	gpa_t gpa_val;
 
 	/*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..223698cbb9be 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6632,6 +6632,16 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		return r;
 
 emulate:
+	/*
+	 * A write during a guest page walk does not authorize the instruction
+	 * itself to write to the faulting GPA.  Require a final write access
+	 * before allowing the emulator to reuse the GPA for writes.
+	 */
+	if (direct && (error_code & PFERR_WRITE_MASK) &&
+	    (error_code & PFERR_GUEST_FINAL_MASK) &&
+	    !(error_code & PFERR_GUEST_PAGE_MASK))
+		emulation_type |= EMULTYPE_PF_WRITE;
+
 	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
 				       insn_len);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..8c46aa3468c2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5088,8 +5088,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * Note, this cannot be used on string operations since string
 	 * operation using rep will only have the initial GPA from the NPF
 	 * occurred.
+	 *
+	 * The guest may have changed the instruction since the fault.  Reuse
+	 * the GPA for writes only if hardware reported a final write access;
+	 * otherwise, recheck permissions for the decoded access.
 	 */
-	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
+	if (ctxt->gpa_available && (!write || ctxt->gpa_write) &&
+	    emulator_can_use_gpa(ctxt) &&
 	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
 		gpa = ctxt->gpa_val;
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
@@ -5939,6 +5944,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
 
 	ctxt->gpa_available = false;
+	ctxt->gpa_write = false;
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
 
@@ -6455,6 +6461,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
 			ctxt->gpa_available = true;
+			ctxt->gpa_write = emulation_type & EMULTYPE_PF_WRITE;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
 	} else {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..2dd456ad3e2d 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -407,6 +407,9 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
  * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
  *		 the CR2/GPA value pass on the stack is valid.
  *
+ * EMULTYPE_PF_WRITE - Set with EMULTYPE_PF when hardware reports a write to the
+ *		     final GPA, not an implicit guest page-table access.
+ *
  * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
  *				 state and inject single-step #DBs after skipping
  *				 an instruction (after completing userspace I/O).
@@ -445,6 +448,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
 #define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
+#define EMULTYPE_PF_WRITE	    BIT(10)
 
 #define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
 #define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)

base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558

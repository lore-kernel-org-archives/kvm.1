Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C44324B0A
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787961531; cv=none; b=RLBTqBkp2X2GWI7XnXCTKdgKRWaoZodjccqeO+rmLNmhOG9JYwa//Ns8zv3PavJHb4swGgpw4hNMqoQB2/t6d0uHQlPiJfaApbKEkCYqUlZ5V0beGbM+1ejGwi23fHMSYUPj4AwBe3YKuQBEIZ4jdhqXTM6+fzEQRH68vR6xj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787961531; c=relaxed/simple;
	bh=YXk14dFBMq58QWmtFcn+UzAeak5xlQny5Vc9N5piW7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUhWoUGLvfpmkQnC4hhyP+hZjfzZWs6G5Qo+aWo3BQYkcWZIXTiRSEc0a2qW7v5uYffs/0zUtZWVdJieshdvNdGZCDLEp7P1En0TNpHkGIsTkInOVh1odS2/TfIPSI7/LVSqZtKca0UuT4ilwnEXn8ZwhT3vuB3SiqeU3dSDa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GEYjjiPn; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GEYjjiPn"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b1fcd3b1a9so839727b6e.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787961529; x=1788566329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kSrXP1ncWZy8rxgjwSN9JgKty2508VpxVdehwf30O0=;
        b=GEYjjiPnrLSBHR3Ge+SCd1RbongneSP4OHivNcD5A1HWAbXKkrdfV+nYw9BATW3fqD
         IIxc45seCHZY74wyPTZbdE0YjBZwjPaLU+JJ7TfKnhSlge1VssWA5vHZZFjNHqNHFNqE
         G3sUQqFUGGOCFAJgtWtyNzsZoSW8r94qL6jKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787961529; x=1788566329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kSrXP1ncWZy8rxgjwSN9JgKty2508VpxVdehwf30O0=;
        b=EdEKgTentGD73nKPMm8c05VujIje5nf+p4dkJmKpxFehuYWOOLSg1lEeYb2G4DB2Gg
         tmTgUqwdwxcNQzy+ZF8k9Fknx/HFB8mI+HV3fsI3VT2uZ2V+zzV9HBQbYvSs23xMwD9F
         Em/yJIqSI8FihOSvC4zMrhkmSY04kJAjzGsUjCgRkn3wjDY2Dt54t5biTgDVouQ13LMf
         6/ba9f651xpFy3vk1CmlSLIfMEZbVMDT9qnGYAn2kgChZwbtdKVYVk3Gbk4x6ZUMF0qL
         P8A6fhLfxaodcDVRlYh+ikSOFpOleR9QTylinpJi34AlDgiCjOQBcUa2bSHXIwvzIGls
         zSug==
X-Gm-Message-State: AFuF++n4oyLrFeI9N5hICJHrmoYZlvRc2oiuTES2nSxUBQli3j2kz3oW
	BRqlRsWfdIYuAq69BMUEi0TPtXIMl25C0dHYLipRP/HwJcletnqFXaMk8WdAj9aWejPkJGZ9AEF
	vfvlTD/Y=
X-Gm-Gg: AR+sD125VAYB3ilYMkD+QIHSF3KIobZyCGNWi8SYTRARPZUm856IcoF4YW6qyvDpNu+
	XmsZC8oFOTmynCLikOvhgMME+InkII3vOW2bqSO4ASNVMmHNdTzhNCToskWPA7FH3iCb+X4Gw74
	3xYSTx30lww1T4s85d+kKknjn/8IDL3MdN7lxEamrZvI2lda3mPL+T5dNXvKdl5vlQhp1XXgkou
	BArZGzK2k5v0p2nG7xvI1UcPSLkvz7RUjgvCuRLeinYEFE3tUJCmb5As+CXfyYy1h/P7tzhFYrH
	o8LGF1SsL675x+Gzk3bIuh2Udq6S3fTYGbyG5rCtvSVj4o3PMLiWC/OnteU66gVoBxUNcJYxI5N
	TZ7XYab99XXhU5EUOrROdENB5lVS2ojChVN+ml9v5SCANKZ/5HYc6J33A8af6tBcwFJi04+aSWj
	BNzLI83bBHmew8d1ibZAUcSyC4TbWjXht7CP4BQ/CuEK9t1pM1XwfyDdOiWpliWRAG0lzfYTPT2
	H4ecUJhJjzGXlLjq6XkRqUTyyTrqhtVupGDjABEZYPbNovHBKzkAbARoJFBopHb
X-Received: by 2002:a05:6808:19a0:b0:4b3:880a:f08e with SMTP id 5614622812f47-4b39828a6f1mr11769102b6e.13.1787961528700;
        Fri, 28 Aug 2026 16:58:48 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a1995ba1sm2561465b6e.9.2026.08.28.16.58.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 16:58:47 -0700 (PDT)
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
Subject: [PATCH v2] KVM: x86: Restrict saved GPA writes to hardware write faults
Date: Fri, 28 Aug 2026 16:58:40 -0700
Message-ID: <20260828235840.63227-1-kylebot@openai.com>
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

Carry hardware write-fault information into the emulator and retain it
alongside the saved GPA.  Only reuse that GPA for a write when hardware
reported a write access.  Reads and faults with unknown access direction
do not authorize an emulated write; fall back to the existing
permission-aware translation in those cases.

Keep the authorization across MMIO completion without decoding a new
instruction, and reset it when initializing a fresh emulator context.
This also covers writes reached through the cmpxchg fallback.

Preserve the shortcut for hardware-reported writes and for the read side
of read-modify-write emulation after such a fault.  In particular, legacy
SEV guests can have encrypted page tables that KVM cannot walk, so forcing
those accesses through a software walk is not suitable.

Fixes: 0f89b207b04a ("kvm: svm: Use the hardware provided GPA instead of page walk")
Reported-by: Oleg Boiko <oboiko@openai.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v2:
- Track saved-GPA access with an explicit access mask.
- Allow saved-GPA writes for any direct hardware write fault.
- Preserve read access on write faults for RMW emulation.

 arch/x86/kvm/kvm_emulate.h |  4 ++--
 arch/x86/kvm/mmu/mmu.c     |  3 +++
 arch/x86/kvm/x86.c         | 14 +++++++++++---
 arch/x86/kvm/x86.h         |  3 +++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..10886bea82c9 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -354,8 +354,8 @@ struct x86_emulate_ctxt {
 	bool have_exception;
 	struct x86_exception exception;
 
-	/* GPA available */
-	bool gpa_available;
+	/* Saved GPA and permitted emulated accesses. */
+	u64 gpa_access;
 	gpa_t gpa_val;
 
 	/*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..95b9eac9962a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6632,6 +6632,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		return r;
 
 emulate:
+	if (direct && (error_code & PFERR_WRITE_MASK))
+		emulation_type |= EMULTYPE_PF_WRITE;
+
 	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
 				       insn_len);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..aa5deb7c73aa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5088,8 +5088,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * Note, this cannot be used on string operations since string
 	 * operation using rep will only have the initial GPA from the NPF
 	 * occurred.
+	 *
+	 * The guest may have changed the instruction since the fault.  Reuse
+	 * the GPA for writes only if hardware reported a write access;
+	 * otherwise, recheck permissions for the decoded access.
 	 */
-	if (ctxt->gpa_available && emulator_can_use_gpa(ctxt) &&
+	if ((ctxt->gpa_access & (write ? ACC_WRITE_MASK : ACC_READ_MASK)) &&
+	    emulator_can_use_gpa(ctxt) &&
 	    (addr & ~PAGE_MASK) == (ctxt->gpa_val & ~PAGE_MASK)) {
 		gpa = ctxt->gpa_val;
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
@@ -5938,7 +5943,7 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
 
-	ctxt->gpa_available = false;
+	ctxt->gpa_access = 0;
 	ctxt->eflags = kvm_get_rflags(vcpu);
 	ctxt->tf = (ctxt->eflags & X86_EFLAGS_TF) != 0;
 
@@ -6454,7 +6459,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		/* With shadow page tables, cr2 contains a GVA or nGPA. */
 		if (vcpu->arch.mmu->root_role.direct) {
-			ctxt->gpa_available = true;
+			/* A write fault can require a read for RMW emulation. */
+			ctxt->gpa_access = ACC_READ_MASK;
+			if (emulation_type & EMULTYPE_PF_WRITE)
+				ctxt->gpa_access |= ACC_WRITE_MASK;
 			ctxt->gpa_val = cr2_or_gpa;
 		}
 	} else {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..667465680ccd 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -407,6 +407,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
  * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
  *		 the CR2/GPA value pass on the stack is valid.
  *
+ * EMULTYPE_PF_WRITE - Set with EMULTYPE_PF when hardware reports a write access.
+ *
  * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
  *				 state and inject single-step #DBs after skipping
  *				 an instruction (after completing userspace I/O).
@@ -445,6 +447,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
 #define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
+#define EMULTYPE_PF_WRITE	    (1 << 10)
 
 #define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
 #define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)

base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558

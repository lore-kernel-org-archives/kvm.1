Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0440F3A2E12
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793314; cv=none; b=NNL8a6OLYkw6/cNnKBrjI31leuOS7tK/pS4tFElgOaDy9Xul4+pKhLa62wIz8akn65Odwn9Vrk12Gw+jkbV3jvxxQrdMWyGuK29F2O9BRamTJHq/1amDbRqAmpaxAU4OGjKRLP7CjyT6Scu2uTetFfJLxwpzFEd7IBbtEplt0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793314; c=relaxed/simple;
	bh=Cqk9Mqi8SyyjMUX6NCi5/5aM3BrDIj0kiBVaUVsPsgk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rlE8iSxq4foKf0uT8cPHKlC+VkUxwbmCOfyG8p1g8Ok0/mjf7pd1zcSWzsQ+CniQ7sZBuTslr5vuxvQyBmFDpLecJIBZc0EUu4qlY3FxPEV0op0g+BkiT1PXG6ELWV+8F+J+uNLNUdRvdKTd1PTeT+EoqUGflwL5MrbZUJs02Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZGZEiNs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZGZEiNs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baedd2fd43so52984965ad.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778793312; x=1779398112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPQhL3Y1VrK0b49Sie7J6w5VDcYQdoRFS4DdHB9aTbc=;
        b=lZGZEiNsbHpEjL2uUCw+NUUPHzLyPhtMoDZjkbIMdjOhb2OrN7adXXXTMwKtOpuyPr
         ODwn7VGTLl8P54BKCwveZeWjGEQ06g+23ha+FF5yD1tCUx9cE9sLwcyAcXscSYjLlHL7
         suqq19yM2XpDOA3RFlupAwFxz/Oxlfn4mimv/pCbX9OSBeRHc9EC/A0FxqNcd9a+dYv1
         EB0/LtRItEXVjsaREO4eKwU2OSRRR50DaeakPgBPd5zhBB4fxcMr2xAoT9KsQ1CJP3Do
         oQB9u+4tu8fGZfcbE5ulIS+UsY8dGvaGDQS3oc7SHCNH46qH7kvkfrTSbb+t9SRZIpll
         z0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793312; x=1779398112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPQhL3Y1VrK0b49Sie7J6w5VDcYQdoRFS4DdHB9aTbc=;
        b=myu36RK55KiGEh863ef/8YZ2hO4nvgi8ihHgUL8DEz7oaaFjTO67fff4V/IGlun7cb
         4s1otZLcVlzs5Kax4JiLXLkg3YfK6BqndljVcjfLOHfFB56nI5/ycDq+qeW+MTIOTyW9
         6reecOwQsqFVGK3Q+q0GhjAGksjlMobHEX8hbwFfJWw+dcdEvkvZcdJVDTwHuqAr5jzQ
         PK2tZGStEaLB42GisA/e+XVTffbgUUL5NLHb7Ob+Rd2Dmq2qqdSleK/LsxCvA7FzW579
         EbW7PwBo1344qEw0wWjt6NhIcenSjh3SfcjNRAZ7tR7eHbdSavbKhnnjiGuhancq4Gu0
         jnNg==
X-Gm-Message-State: AOJu0YxFyINoocaAwXEcx1GkWl2mRuissNlBPSMLH5aJ57XGlUhPQ0fG
	TBdSkjbeMQAfxxqwJwXzY1ZPLwl9Xw6V6vdXDKA/UWYkKHjIL4lowDi4w/2kXr3RG9VR6E+TbCy
	9QDhOpA==
X-Received: from plov4.prod.google.com ([2002:a17:902:8d84:b0:2bc:f488:9bc9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2752:b0:369:a78:6009
 with SMTP id 98e67ed59e1d1-36951a6724cmr1019468a91.13.1778793312054; Thu, 14
 May 2026 14:15:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:15:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514211510.1630673-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/emulator: Add testcases for ENTER +
 emulated MMIO
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add testcases for stack pushes to emulated MMIO via the ENTER instruction
to validate a pile of KVM changes needed to fix a use-after-free due to
KVM referencing kernel stack data across a userspace exit.  Test that ENTER
is handled correctly if it splits non-MMIO => MMIO, MMIO => non-MMIO, and
MMIO => MMIO pages.

Opportunistically add a comment explaining what the collection of pages
are used for in the emulator test.

Link: https://lore.kernel.org/all/20260225012049.920665-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/emulator.c   | 66 ++++++++++++++++++++++++++++--------------------
 x86/emulator64.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/x86/emulator.c b/x86/emulator.c
index 102e5efc..6d945d8a 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -790,8 +790,7 @@ static void test_mov_pop_ss_code_db(void)
 
 int main(void)
 {
-	void *mem;
-	void *cross_mem;
+	void *base, *mmio, *split;
 
 	if (!is_fep_available)
 		report_skip("Skipping tests that require forced emulation, "
@@ -799,45 +798,56 @@ int main(void)
 
 	setup_vm();
 
-	mem = alloc_vpages(2);
-	install_page((void *)read_cr3(), IORAM_BASE_PHYS, mem);
-	// install the page twice to test cross-page mmio
-	install_page((void *)read_cr3(), IORAM_BASE_PHYS, mem + 4096);
-	cross_mem = vmap(virt_to_phys(alloc_pages(2)), 2 * PAGE_SIZE);
+	/*
+	 * Allocate five pages in the virtual address space, with pages, 0, 3,
+	 * and 4 pointing at normal memory, and pages 1 and 2 pointing at an
+	 * emulated MMIO range.  This combination of pages allows testing basic
+	 * emulated MMIO handling, as well as a variety of multi-page and page-
+	 * split scenarios.
+	 */
+	base = alloc_vpages(5);
+	install_page((void *)read_cr3(), virt_to_phys(alloc_pages(1)), base);
+	install_page((void *)read_cr3(), IORAM_BASE_PHYS, base + PAGE_SIZE);
+	install_page((void *)read_cr3(), IORAM_BASE_PHYS, base + 2 * PAGE_SIZE);
+	install_page((void *)read_cr3(), virt_to_phys(alloc_pages(1)), base + 3 * PAGE_SIZE);
+	install_page((void *)read_cr3(), virt_to_phys(alloc_pages(1)), base + 4 * PAGE_SIZE);
 
-	test_mov(mem);
-	test_simplealu(mem);
-	test_cmps(mem);
-	test_scas(mem);
-	test_smsw(mem);
+	mmio = base + PAGE_SIZE;
+	split = base + 3 * PAGE_SIZE;
+
+	test_mov(mmio);
+	test_simplealu(mmio);
+	test_cmps(mmio);
+	test_scas(mmio);
+	test_smsw(mmio);
 	test_lmsw();
 	test_stringio();
-	test_incdecnotneg(mem);
-	test_btc(mem);
-	test_bsfbsr(mem);
-	test_imul(mem);
-	test_sse(mem);
-	test_sse_exceptions(cross_mem);
-	test_shld_shrd(mem);
-	//test_lgdt_lidt(mem);
-	//test_lldt(mem);
-	test_ltr(mem);
+	test_incdecnotneg(mmio);
+	test_btc(mmio);
+	test_bsfbsr(mmio);
+	test_imul(mmio);
+	test_sse(mmio);
+	test_sse_exceptions(split);
+	test_shld_shrd(mmio);
+	//test_lgdt_lidt(mmio);
+	//test_lldt(mmio);
+	test_ltr(mmio);
 
 	if (is_fep_available) {
-		test_smsw_reg(mem);
-		test_nop(mem);
-		test_mov_dr(mem);
+		test_smsw_reg(mmio);
+		test_nop(mmio);
+		test_mov_dr(mmio);
 		test_illegal_lea();
 	}
 
-	test_crosspage_mmio(mem);
+	test_crosspage_mmio(mmio);
 
-	test_string_io_mmio(mem);
+	test_string_io_mmio(mmio);
 	test_illegal_movbe();
 	test_mov_pop_ss_code_db();
 
 #ifdef __x86_64__
-	test_emulator_64(mem);
+	test_emulator_64(mmio);
 #endif
 	return report_summary();
 }
diff --git a/x86/emulator64.c b/x86/emulator64.c
index 6a85122f..c4df5178 100644
--- a/x86/emulator64.c
+++ b/x86/emulator64.c
@@ -116,6 +116,70 @@ static void test_pop(void *mem)
 	       && rbp == (unsigned long)stack_top - 8
 	       && stack_top[-1] == 0xaa55aa55bb66bb66ULL,
 	       "enter");
+
+	stack_top = mem + 8192 + 4;
+	stack_top[-1] = -1ull;
+	rbp = 0x1122334455667788ULL;
+	rsp = (unsigned long)stack_top;
+	asm volatile("mov %[rsp], %%r8 \n\t"
+		     "mov %[rbp], %%r9 \n\t"
+		     "xchg %%rsp, %%r8 \n\t"
+		     "xchg %%rbp, %%r9 \n\t"
+		     "enter $0x1234, $0 \n\t"
+		     "xchg %%rsp, %%r8 \n\t"
+		     "xchg %%rbp, %%r9 \n\t"
+		     "xchg %%r8, %[rsp] \n\t"
+		     "xchg %%r9, %[rbp]"
+		     : [rsp]"+a"(rsp), [rbp]"+b"(rbp) : : "memory", "r8", "r9");
+
+	report(rsp == (unsigned long)stack_top - 8 - 0x1234 &&
+	       rbp == (unsigned long)stack_top - 8 &&
+	       stack_top[-1] == 0x1122334455667788ULL,
+	       "enter");
+
+	stack_top = mem + 4096 + 4;
+	stack_top[-1] = -1ull;
+	rbp = 0x1122334455667788ULL;
+	rsp = (unsigned long)stack_top;
+	asm volatile("mov %[rsp], %%r8 \n\t"
+		     "mov %[rbp], %%r9 \n\t"
+		     "xchg %%rsp, %%r8 \n\t"
+		     "xchg %%rbp, %%r9 \n\t"
+		     "enter $0x1234, $0 \n\t"
+		     "xchg %%rsp, %%r8 \n\t"
+		     "xchg %%rbp, %%r9 \n\t"
+		     "xchg %%r8, %[rsp] \n\t"
+		     "xchg %%r9, %[rbp]"
+		     : [rsp]"+a"(rsp), [rbp]"+b"(rbp) : : "memory", "r8", "r9");
+
+	report(rsp == (unsigned long)stack_top - 8 - 0x1234,
+	       "ENTER RSP = %lx, wanted %lx", rsp, (unsigned long)stack_top - 8 - 0x1234);
+	report(rbp == (unsigned long)stack_top - 8,
+	       "ENTER RSP = %lx, wanted %lx", rbp, (unsigned long)stack_top - 8);
+	report(stack_top[-1] == 0x1122334455667788ULL,
+	       "ENTER val = %lx, wanted 0x1122334455667788", stack_top[-1]);
+
+	stack_top = mem + 4;
+	stack_top[-1] = -1ull;
+	rbp = 0x8877665544332211ULL;
+	rsp = (unsigned long)stack_top;
+	asm volatile("mov %[rsp], %%r8 \n\t"
+		     "mov %[rbp], %%r9 \n\t"
+		     "xchg %%rsp, %%r8 \n\t"
+		     "xchg %%rbp, %%r9 \n\t"
+		     "enter $0x1234, $0 \n\t"
+		     "xchg %%rsp, %%r8 \n\t"
+		     "xchg %%rbp, %%r9 \n\t"
+		     "xchg %%r8, %[rsp] \n\t"
+		     "xchg %%r9, %[rbp]"
+		     : [rsp]"+a"(rsp), [rbp]"+b"(rbp) : : "memory", "r8", "r9");
+
+	report(rsp == (unsigned long)stack_top - 8 - 0x1234,
+	       "ENTER RSP = %lx, wanted %lx", rsp, (unsigned long)stack_top - 8 - 0x1234);
+	report(rbp == (unsigned long)stack_top - 8,
+	       "ENTER RSP = %lx, wanted %lx", rbp, (unsigned long)stack_top - 8);
+	report(stack_top[-1] == 0x8877665544332211ULL,
+	       "ENTER val = %lx, wanted 0x8877665544332211", stack_top[-1]);
 }
 
 static void test_ljmp(void *mem)

base-commit: 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2ff
-- 
2.54.0.563.g4f69b47b94-goog


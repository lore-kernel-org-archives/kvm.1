Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336273EFFBD
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884015; cv=none; b=QeyL0YGNEiGfEiutQaFmEYO3neymp3Y182AyuQBaPoBXsFwYxRfwPH1dAzVtVHd0dzcOclAn2PLjQwVb2YbSj7e29QSHPp1MFT8kSt5i5JVcmNytutMAx9NGsY92fuFPOGptffndCBHtIvt3lLRAd43kou1j1QvF8SZmhN5CYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884015; c=relaxed/simple;
	bh=ozPMGZO67UVsKM6SPGXeGE/qEN8w826I6bzKhOGXIkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jCF/kTWBv0r3W92f7w/NXHl1NqW26Ue1TbidmN22cETTbl5nOnKhPQsPvw6HDapcBKHFpPVZfigrT04nigq6jYfrZ2Ni2VbWUuu3T+OTK4iyB7yWKtysiSXn9Mk/HFsfyn+ybfCIXxWA4Du0D2kXpXumZFE4skzTfTL4cHsoKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDp7kn/P; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDp7kn/P"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so272360b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884010; x=1779488810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4W/o+Gk1JIoJUBX8jQkrO28lcANwiD+MfgzBj8mdJc0=;
        b=aDp7kn/PmrunoA2iwOWj5GYt6JFdt9Cjt97+Tg7NnmV8nbzrtWz4fKmY8eY8LXsnay
         oacw6NGAPHGLWgbafLG2PROyj+hxzQSkblgvZi8lWromLFLgEq/N7IHLyJbnVf4LHdvv
         NlF8r/fPTZ6Ts5PVL8cTtapvwMOYRh2+s3Y5D4pbuXZBkJIjXXaPEm+yxC1VYW6c4ktz
         s+FQSJwhCGdzaDlPUAt2ZOpE1BRzTigelkm3XHgzeayg7MDHGTeN6etfUHZmIq14uMux
         nAmuIc8T9cT0VdhE2QXWydi2XZFQn6Kda/rEuDkAzsPCwprGP8UKx7MVqrZa3cmRDiRZ
         JOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884010; x=1779488810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4W/o+Gk1JIoJUBX8jQkrO28lcANwiD+MfgzBj8mdJc0=;
        b=SmBHqi4FguMK4RKVFYRw27olfMNxTOSKYrN4YS17OtOUu4CSkrIFJMvVCGvPqvh4b6
         OfnyNRPITPDVgMq8l1QKULBBHObiV92zqLfIQX9774V44ZDOUztpEBY3Y7s+9hrZ06oW
         +mfloZB0AeLaxwiLYuuBwQB05Jy6nZ97SpGOt3iRWugxT/42o57w5a/SI5J0EDgVh0/z
         1fq0wuUOZ3w8Fl1MNSeOxUGPU3+I+0MWh2nhOXvX+2Vqa73MHNDAu45GrM5E6r0ilUnc
         h33PuBjXeAnRHydhWYw4Uzvk3RxIxRc66412fUsyHJT83NyhSHOmybv1jffrbDw9WngD
         hFsQ==
X-Gm-Message-State: AOJu0YzIAXbOnji6ZVCtbQq6zZrBL2ID6S59PrxSrj4v25HJPel/JyS/
	T82HFt8be7HjakJsLoE5scDYLF3jfCY85Pz6VL32I/FsH7KEJtSsL9ZCvcvmOPgBoHRC2QaHKC5
	6mUxJRQ==
X-Received: from pfoo19.prod.google.com ([2002:a05:6a00:1a13:b0:82f:49f6:76e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b0b:b0:82f:316:3206
 with SMTP id d2e1a72fcca58-83f33dcc06cmr6273940b3a.34.1778884010239; Fri, 15
 May 2026 15:26:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:37 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-10-seanjc@google.com>
Subject: [PATCH v3 09/10] KVM: selftests: Verify guest debug DR7.GD checking
 during instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

Similar to the global disable test case in x86's debug_regs test, use
'KVM_FEP' to trigger instruction emulation in order to verify the guest
debug DR7.GD checking during instruction emulation.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/debug_regs.c | 23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/debug_regs.c b/tools/testing/selftests/kvm/x86/debug_regs.c
index 0dfaf03cd0a0..ee9d0f3a5807 100644
--- a/tools/testing/selftests/kvm/x86/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86/debug_regs.c
@@ -19,6 +19,7 @@
 u32 guest_value;
 
 extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
+extern unsigned char fep_bd_start;
 
 static void guest_code(void)
 {
@@ -64,6 +65,10 @@ static void guest_code(void)
 
 	/* DR6.BD test */
 	asm volatile("bd_start: mov %%dr0, %%rax" : : : "rax");
+
+	if (is_forced_emulation_enabled)
+		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
+
 	GUEST_DONE();
 }
 
@@ -185,7 +190,7 @@ int main(void)
 			    target_dr6);
 	}
 
-	/* Finally test global disable */
+	/* test global disable */
 	memset(&debug, 0, sizeof(debug));
 	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW_BP;
 	debug.arch.debugreg[7] = 0x400 | DR7_GD;
@@ -202,6 +207,22 @@ int main(void)
 			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
 			    target_dr6);
 
+	/* test global disable in emulation */
+	if (is_forced_emulation_enabled) {
+		/* Skip the 3-bytes "mov dr0" */
+		vcpu_skip_insn(vcpu, 3);
+		vcpu_run(vcpu);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
+			    run->debug.arch.exception == DB_VECTOR &&
+			    run->debug.arch.pc == CAST_TO_RIP(fep_bd_start) &&
+			    run->debug.arch.dr6 == target_dr6,
+			    "DR7.GD: exit %d exception %d rip 0x%llx "
+			    "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
+			    run->exit_reason, run->debug.arch.exception,
+			    run->debug.arch.pc, target_rip, run->debug.arch.dr6,
+			    target_dr6);
+	}
+
 	/* Disable all debug controls, run to the end */
 	memset(&debug, 0, sizeof(debug));
 	vcpu_guest_debug_set(vcpu, &debug);
-- 
2.54.0.563.g4f69b47b94-goog


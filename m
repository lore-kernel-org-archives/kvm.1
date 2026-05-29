Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DF4779B1
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093398; cv=none; b=HPU4TuwaKpviRXDzJWyOmaqtApAwPDRV4f3xJyqhZBt0Hr8z7I9y1l1h2WWP51Q1Cr0rRkkyyIHSRdbl5TRpbslAwvsuHGR+zvpreZLRI0Y3QBhi4jXNk9Y0q1e3tDA3SDa7O9HaYGlZBJQuxnmrRNZKwquGeSWY6/KfniymsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093398; c=relaxed/simple;
	bh=67zW30Fghsqm2bbgoRDmbDTWcpgL4geOGG0pkoZa+DQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DpOTq+HhvJJGnHXZLvCR3Zo6uymZw0EB/nRwVTD/DZ1keXjeCYmxK31te2zLLkng/WO/xuNUFx+6Pc3wx2WzVGyO+x8VckpUCGp7BJyBP2XtMVR1RSBVmnXScaRb8mhcjyqYZSH2agE5WPZJJjPDPlDaVHG9sFv8Qf8X6vAxTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDRA/qcI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDRA/qcI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8292e18166so7212883a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093396; x=1780698196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4YZDFZBCarOdxlxdCzemgJxyqnyDXT5M/adWibMWDkM=;
        b=UDRA/qcICcOiNfGR0SUbiJJsc437nlYOUgUzjpxZulD9/NkhKgFNeABpfvVvLDvTy7
         JhvWDp/mxgGPnXgQ5BlvOyFnf241skP06E4Je2VZr1hY9bHOtA2i+QCLP5BUWMuOozSK
         1wakd7SKzc50yWuXSm7vByAjfFOeL7Bv5z31KU0H0xfyWVKyHEjtpCrxCDYAwdxTHpX5
         2nIrvqggvoRoDAwL7z/ORr1nmuTglOXjqD3K9Q0WdEskCaOG+RMfaS+t5ygtrzon0EC4
         IZmjy91NZDoc8IJPSVQSczDHuXEY8bmHjBr4MBTC1G7oisvXUH1PiT9N8dTqCDy2oYsO
         q34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093396; x=1780698196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YZDFZBCarOdxlxdCzemgJxyqnyDXT5M/adWibMWDkM=;
        b=Ih14nThHVOX2n4fYoUlMDkq5ruVyfeviHONSiNu5yGeR5hfuqF1UbCTL/E9kdiA2QW
         yKYFXKllzovj7H+XCmLWIpNpMRYcaa+hMnqifdDLvcu8hfGTw4FF74Q6+h02WcXS3XeS
         ZvMGz8TgH3peF2lPYo3Kl91e5nGfqqS4gyIbtzMyhpTSr3OKy4dt6YHzBATJFctSJsKN
         GhgF9SZ5jRI2ThBYkYfUwcZaB2v5KKj0q7YfNqASQOL7jkvovayJjjZfHycYX+B0Tobh
         VurIDTFIBgNVp/3PPsjONgzYM8gEeui3Ve0/UqlbuZtwRxiasPFdV+YHDInFpAizYYPO
         4hwA==
X-Gm-Message-State: AOJu0YyQPIneSRIxTO3/NSJZMDaKzSyCTeOOio/m9v4LDk5b5TQ+4dKt
	fr5Lmiof8JzDSDj/ZfUEIhy0cSNw4zs+/Idsdi8hvWJp3brRtmAf8v5T5YUEBoSkCn9qbLUMDQs
	Ldkm2BA==
X-Received: from pgig5.prod.google.com ([2002:a63:f405:0:b0:c80:2399:151])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:189:b0:39b:89e0:2e37
 with SMTP id adf61e73a8af0-3b427c23375mr1271417637.14.1780093395678; Fri, 29
 May 2026 15:23:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:10 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-28-seanjc@google.com>
Subject: [PATCH v3 27/40] KVM: x86: Move register helper declarations from
 kvm_host.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate declarations of Control/Debug Register, EFLAGS and RIP helpers
from x86's kvm_host.h to regs.h, to continue trimming down kvm_host.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 17 -----------------
 arch/x86/kvm/regs.h             | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 19091d89d3cc..0f4b16b26a27 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2186,8 +2186,6 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
-int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
-
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
@@ -2313,24 +2311,12 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code);
 
-void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0);
-void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4);
-int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
-int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
-int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
-int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
-unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
-unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
-void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
 
 int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
-unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
-void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
@@ -2520,9 +2506,6 @@ u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
 u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier);
 
-unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu);
-bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
-
 void kvm_make_scan_ioapic_request(struct kvm *kvm);
 void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
 				       unsigned long *vcpu_bitmap);
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index c224874bbdde..30ef08d60a74 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -16,6 +16,18 @@
 
 static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 
+void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0);
+void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4);
+int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
+int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
+int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
+unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
+unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
+void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
+int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
+
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
@@ -425,7 +437,12 @@ static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 	return kvm_x86_call(get_segment_base)(vcpu, seg);
 }
 
+unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu);
+bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
+
+unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
 void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
+void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 
 void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
 				   struct kvm_sregs2 *sregs2);
-- 
2.54.0.823.g6e5bcc1fc9-goog


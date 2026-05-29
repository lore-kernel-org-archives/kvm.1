Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3347A47A0A2
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093401; cv=none; b=PQdun4j+XSMWLUq0b4szx2JB1r/wdF0Lau0S1fsXoGy7nZMd8yPK7DlcPUCKQFqRPFtcAXPvXucBXx/uJg1OYRs7FbcsiFwgDix6RcS0OR/6wODqPOIb0J5nKaw85kYmAZTjpeSv2r++cDJL3uT0a/RB7xtrG8WvPQR0neMoD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093401; c=relaxed/simple;
	bh=otrVM3e4Lurh14D9F8StjWN8v6dvvHUUGpICOjvEYWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5Meavw18IqJyx8hPugtzWIZs1eLTvp4HH9zY+sdm/DQaJRAJjZS67Jl4JSYZ+O/pLuoOe2S8djwibYQXOzuvDHn2NMQYMHwrDx5+sE7QxAkmr5xaOGuLt9ovx/jVQi4+8aVtY8pZTOUhEGpHb3kYYeVxUefAhQKboCFm1Ij4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvcAoGIo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvcAoGIo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf0b7425bbso38893295ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093399; x=1780698199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=U06ajxKWCrZV2qZ8Tb0oiDb/K09cySTCLuYRf+Qkq+A=;
        b=EvcAoGIoFlHuJMS3ugwl5wqfpaGIVpaVdmVOFsCorgSTxlv8tLKBE5Ar84UKhmSsTE
         dj7QyPq4jT5TNDz8cOJKND05awSpLxVMWAfC3iJGAdplGfhxRg9MZnwjpO3uhxE14Xy8
         lZT82aS10F212BcnKev/dTDFVw2sUlRbjxGu1CYCerWF7nhvYLaFYRB+sFO2Xzh0xp+N
         i7iHfXg8eAH+PQVSR7xJ1YnK1DmWkgS+tkrD1qAiPnQpzJ9wU3lzXiAJGEjvO9J2ZWoq
         gdbgWVFY9m2GpUw+qj2Db0+Ry/0y5OcXTuvVrNFcUur0fbdLPzEeB+2QHOu1embOCt5K
         1+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093399; x=1780698199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U06ajxKWCrZV2qZ8Tb0oiDb/K09cySTCLuYRf+Qkq+A=;
        b=bDrzyIIpsyjvgcCGd4Eg7JI7+FC2mQk7dzz9Va1/SoOxoKPUAkzRDs4DdcmCSds2k6
         AAx+KRLM/MsEbd8RF79FBjHhulBxX32bPqeIl4pnWJuq0Kj1fY+eKfX0SnBtwmWkMQNe
         4Q6fQLrRf1/SXrRZDq9OF4KprbsJYLsKhNtNPiGiWJ37xFwvIVbLLQXs5dEqkwxkCGfC
         tDl3PhytxtGKrzkCl26DVD5r35OAU9GBuE6TtG5Xj0P/2XXGw9AkY92ysg9gBcpLs8Da
         BSJtsq67aFRRl6jbS/QiSjesvUVQZg3pzxjqABZkSMHe3WTdiKVwAAehfw00HyObqVq0
         G/yQ==
X-Gm-Message-State: AOJu0Yx+hOlypkJX2kOfrogFAbVUvmVchzFJm/NaQmkUNvuXzf+fOyXg
	8MFynDyTJKD5q9USeKV0+mMFhTDAYIIB4DnhJYi/NkuX2mG/QBMHgYZyrQyQj8U8r0oLYJUNBs3
	fA9tq9A==
X-Received: from plav13.prod.google.com ([2002:a17:902:f0cd:b0:2bf:25c4:45ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:138a:b0:2b4:5f69:715d
 with SMTP id d9443c01a7336-2bf36809d00mr21727735ad.25.1780093399437; Fri, 29
 May 2026 15:23:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:13 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-31-seanjc@google.com>
Subject: [PATCH v3 30/40] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
x86's kvm_host.h to msrs, to continue trimming down kvm_host.h.

Deliberately leave the funky read_msr() where it is, as it will hopefully
be removed entirely as part of a broader kernel-API cleanup.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 26 -------------------------
 arch/x86/kvm/msrs.h             | 34 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a861c0d70be0..1143140592df 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2094,7 +2094,6 @@ struct kvm_arch_async_pf {
 	u64 error_code;
 };
 
-extern u32 __read_mostly kvm_nr_uret_msrs;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
 extern bool __read_mostly enable_ipiv;
@@ -2278,18 +2277,6 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
 void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
 void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
 
-void kvm_enable_efer_bits(u64);
-bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
-int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
-int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
-int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
-int __kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
-int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
-int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
-int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
-int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
-int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
-int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
 int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
 int kvm_emulate_invd(struct kvm_vcpu *vcpu);
 int kvm_emulate_mwait(struct kvm_vcpu *vcpu);
@@ -2311,9 +2298,6 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
 
-int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
-int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
-
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
@@ -2488,16 +2472,6 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 		    unsigned long ipi_bitmap_high, u32 min,
 		    unsigned long icr, int op_64_bit);
 
-int kvm_add_user_return_msr(u32 msr);
-int kvm_find_user_return_msr(u32 msr);
-int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
-u64 kvm_get_user_return_msr(unsigned int slot);
-
-static inline bool kvm_is_supported_user_return_msr(u32 msr)
-{
-	return kvm_find_user_return_msr(msr) >= 0;
-}
-
 u64 kvm_scale_tsc(u64 tsc, u64 ratio);
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index c34f0411ced6..5c8362a8fd97 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -11,6 +11,8 @@
 extern bool report_ignored_msrs;
 extern bool ignore_msrs;
 
+extern u32 __read_mostly kvm_nr_uret_msrs;
+
 static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	if (report_ignored_msrs)
@@ -56,13 +58,39 @@ int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 		     struct kvm_reg_list __user *user_list);
 
+void kvm_enable_efer_bits(u64);
+bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
+int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
+int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
+int __kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
+int __kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
+int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
+int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
+int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
+int kvm_emulate_rdmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
+int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
+int kvm_emulate_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
+
+fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu);
+fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
+
+int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
+int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
+
+int kvm_add_user_return_msr(u32 msr);
+int kvm_find_user_return_msr(u32 msr);
+int kvm_set_user_return_msr(unsigned index, u64 val, u64 mask);
+u64 kvm_get_user_return_msr(unsigned int slot);
+
+static inline bool kvm_is_supported_user_return_msr(u32 msr)
+{
+	return kvm_find_user_return_msr(msr) >= 0;
+}
+
 void kvm_user_return_msr_cpu_online(void);
 void drop_user_return_notifiers(void);
 void kvm_destroy_user_return_msrs(void);
 
-fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu);
-fastpath_t handle_fastpath_wrmsr_imm(struct kvm_vcpu *vcpu, u32 msr, int reg);
-
 int kvm_emulator_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 msr_index,
 				     u64 *pdata);
 int kvm_emulator_set_msr_with_filter(struct kvm_vcpu *vcpu, u32 msr_index,
-- 
2.54.0.823.g6e5bcc1fc9-goog


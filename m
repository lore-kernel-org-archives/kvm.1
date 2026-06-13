Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D53260565
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309040; cv=none; b=Sdb60NB+eMlsFPAzF9C0pZo0nl3GYMMCVRQPqiBkB54KXaULbJTWVEWU4/dip5ddCnZBsgnaTorPFoZpclv4roJ33FvenDOCRHU4W/+m45CqBvM1lrP35+pVmQ7EGf90FTR5nhSiqLKaZbU/7pd6v6P16LrQfVPrxXB6BvMniiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309040; c=relaxed/simple;
	bh=uOlXcxGMgR8xijTJZeowKn0OOVmAQ+0fAD0t1wweuIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7FsJfq8XqqabpMSN5cuIc7svlASbCqbz11izc7VIidE0VCr/Y0V+xaVoZulTNS59BB4wobpw7AcbZGjtRrFwPnXh4tyF3R+B+SatxMf2OEQJxQ1Tykoydz8Ms3RirpgnFVJ9feIAuE/hrBPtE7qKO4fh3sM+/DGdjxaxYxFCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqlIqkAJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqlIqkAJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso821200a12.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309037; x=1781913837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv+DSeRGnFutCBu4lPmbVLNvjR0MSEhNfyYGDcZmTbE=;
        b=LqlIqkAJ3+Fo0huBz02ty83tF6gSY3HVFVjTvNXLu0hj+g7GqJIpk4eeRiUYzMuYsd
         YqoFB+2sk6ik52b4/m+PIKBfEpMeOeeTh12oW64WcedG1CRAw2EZ6fAr21qyZBkNH0o+
         3FcLpo72W8F8r0FKrdwALbLmnCkrx9/4OlTfGXUv2Ba8yjJkXhFmIdOV1xWkYUeeyEzN
         whkh6kVleiN6Hg5vrqWTrGgSxS9v+G3OfDHsAYmmAc6v0v/wc+qSSU8Pw2hDNxAP7NUg
         7CV6z6qt7Vgxb2jk2glULoZFFajJb+e2wx3u/10npY2VbLyowKHOAc0Af6oJ0iV4XmMf
         l8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309037; x=1781913837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv+DSeRGnFutCBu4lPmbVLNvjR0MSEhNfyYGDcZmTbE=;
        b=qbXZY9Lq4j51X8X5qH3EFj7OiAH0+ZjVWSki1F5ZmdVm/Qv6w0MQh2CA5pqOkni0Qf
         B9Z3+kQilU6857qpTuYvBgpsEAOrOD35GG9zcldYAR7i7Ydg+g/Y4qCUmBEP7chaQyhP
         2BkDVRLfbnqRULlyAY4rJ/gnbZlP7uMcj6eu4J3NL70MLjNnRduFpVDXPfdTNbj0KEv4
         FLdSv2RCFJlS8S4FjMI9hoyJmAH314QPR82BwarlkY0vUCfwxZlFQKmw7bVxc4xTi4S3
         /nV7ZigF+tx0UNhih7nkON2DOXjWV6+k7XUCDwdTUxlFuyYhf/4LEdAZKx0utM4oUves
         iwuw==
X-Gm-Message-State: AOJu0Yyf74Ie+yUQggv1YaCpVB4e8kdoEAAAjwCAvNKFAloGYCGPWMcT
	37QTFwy4TkhkFPnYpGo1y4ViETXoou4dV0HgL6Y/RxU4rtU/ieafnY9OF3tCnDEfnWjK5VBsggj
	Pm8DQyA==
X-Received: from pgam22.prod.google.com ([2002:a05:6a02:2b56:b0:c82:7761:9941])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d805:b0:3aa:ec27:e5f7
 with SMTP id adf61e73a8af0-3b796423663mr1734564637.42.1781309037132; Fri, 12
 Jun 2026 17:03:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:16 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-18-seanjc@google.com>
Subject: [PATCH v4 17/30] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
kvm_host.h to msrs, to continue trimming down kvm_host.h.

Deliberately leave the funky read_msr() where it is, as it will hopefully
be removed entirely as part of a broader kernel-API cleanup.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 26 -------------------------
 arch/x86/kvm/msrs.h             | 34 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3c3e160b0991..09e437c947a9 100644
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
index 25b75fe39b80..b698983e37fb 100644
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
2.54.0.1136.gdb2ca164c4-goog


Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E423C416B
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218107; cv=none; b=FqNDDrBbc0VRV/4ZopsClKZA8lFA+0pJLg+ApCU4gNk98jTPk4c/hMjtC7Hl7aT0cijMQIOWFHon6po11gEU2P7Gy0FAJYo7Nl9idffaW7Z77aiuowNAGVWk54QfH4ZWSRu0XBpf15ypByGMt8q9ApDsyXTrLAUordAcKK7bmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218107; c=relaxed/simple;
	bh=XXD5JiD6MbZACed2L2oAqZip9Q+NlM5VYmK7EyLsEnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nr8XUPBNCySesMVBc3yKm4Ci3Weec7JWAQ9fUsKJ1HOPt/3XA8UmsB3sCTFFAlNt6qqa5ubwWUMPptvggPxXC6uja8v0c8bpqq0eadzNpuSEdPZLNnTk+46VhkC2kHsmsKMbMLQjyEMACeas22QHZNV0N7YPD+qXiwDX5tkuhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hf0MdhKq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hf0MdhKq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so354105e9.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784218103; x=1784822903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P33ACgM5WRF/Wf41Mm64IYg79T9oy5SYkqINyFAwCd0=;
        b=Hf0MdhKqRcUjzFV9CsuUQAhPnmoc8sL+xKctst+Ohwk1wIW/eZvVAENs5nCLFtFclL
         pxRQuHz5nSpBsJueHDd9Nulg9m5/O/z8tWvIC5PiVBmgqLydsIfmlewJuAjkoGFtpT12
         laWxdnqu3ggaVRytTjyJTZk2sAYWbUwLvRKL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218103; x=1784822903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P33ACgM5WRF/Wf41Mm64IYg79T9oy5SYkqINyFAwCd0=;
        b=XD7FqNGqSs3VTPXAoXd9VjnW0eHuO2t3fkk5CrtKwN6F8vNPocleE/1XNjf1NOweLw
         SCvutjdR9+HwMTrYubEGpMvH8RVc2vxcP9/hlFD0rw94a/pxB7dgWfuPN4zc5LrxYxYK
         zZ5rJ+OWXjwKy/sXFPnYQxUk+lB0lwPCsDmDZC5CPrkVGSTb4PvlzUR1RIbfGFWFU+Al
         IS7zjVVqVPSQxCp/n4QSqdhUqfP3msg7EpfX9Ah3ZIZH5ON8IC1pM3Axo7zYsEOulo/v
         bd4wn69vCi7Dwxfy56Fth6uQPNHvYRKBbhh7HRbJED3AgiDSa07lc5XoOgQCFg9XY65b
         rWZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwVRWuboHUHzpjPsEKOeadlH37NLXdqx/faijmuhvE+R9EV/FJv8l2nx4J/b12cKgye5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyDaCscm9ZAeBDJlJsxLnpEjHvMH6lkbO1MDYX+7WCwbB0rvN
	Ki2waI0MBXsLckJ78LvrFbVbrht6djy2MKkJI4jK5qF/GipKxazJA/TKD0KutJX2yw==
X-Gm-Gg: AfdE7cnxgBey1jHJmwf8zaisaamM5k8J8W65lBH1E/mWQEs7ZZDlW8yYYpKqQVnu/1C
	8fL12UCWZwuQUUx8KPAgh85Xz8A7uiMqA3TGL1Uhh1JdC2rvxVR27QLGddj+k68AArRIU0+om+W
	yYPgeFwVPx2wF353IM/W7o9juDGsr0MMG3+QotS2MkBbqoz991mM534Dys/d+s5Y7a+l/xkC8OU
	ntQzdF0X1OmxquGI6xx+XEJH4dTteCKDgKfnAbQLlIctfgJY7rFbbYGVciqJSAHHuDGGYeRov7J
	fXW3IxDwAdtGRT9U0DAeQfxXtFRMbJ1XX/4jSlRv/gksM6MD6GKQqHP9LecSPmCEcW+3mJbhjv5
	Ra6SPPG+MivfBz+XE+qc8xqrkZTzq3xt98TyJVJu0J9U9XyV08ariIDz1YSPiJxtdjty23i1sQ4
	7zhIp5om/hCd2HuTsPZzkp0J4liD9h8pN9fH4qrrCs53SnnJ9pw9zASBvVUOKyBEo=
X-Received: by 2002:a05:600c:3144:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-4953c145152mr93839855e9.6.1784218102908;
        Thu, 16 Jul 2026 09:08:22 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (206.39.187.35.bc.googleusercontent.com. [35.187.39.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e93295sm65511545e9.10.2026.07.16.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:08:22 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Zeng Guang <guang.zeng@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU creation
Date: Thu, 16 Jul 2026 16:08:01 +0000
Message-ID: <20260716160801.3155582-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
failure path. However, that leaves a side effect: the IPIv pid_table
entry remains configured with this vCPU's pi_desc address. As a result,
when another vCPU sends an IPI to the APIC ID of this failed-to-create
vCPU, it will cause HW to write to this (freed!) pi_desc memory. [*]

An easy fix would be to clear the pid_table entry in vmx_vcpu_free().
However that would be still problematic, for the following reason:
userspace may try to create a vCPU with the same vcpu_id as an existing
one; vmx_vcpu_create() will succeed, and only after that
kvm_vm_ioctl_create_vcpu() will check for the duplicate vcpu_id and
fail with -EEXIST and then free the vCPU in the failure path. So in this
failure path, vmx_vcpu_free() would clear the pid_table entry for that
already existing good vCPU, i.e. effectively disable IPIv for that vCPU.

So instead fix the issue by moving the pid_table entry setup from
.vcpu_create() to the newly introduced .vcpu_postcreate() callback
called at the end of kvm_vm_ioctl_create_vcpu(), when we are sure that
the vCPU creation succeeded.

[*] Although, since this memory is freed into the kvm_vcpu_cache kmem
    cache which is only used for allocating kvm_vcpus, _maybe_ this
    memory will only be reused for pi_desc of another vCPU, not for
    anything else. So _maybe_ this will only result in delivering the
    IPI to a wrong vCPU (possibly of another VM) in the worst case, not
    in a random corruption of kernel memory.

Fixes: d588bb9be1da ("KVM: VMX: enable IPI virtualization")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/vmx/main.c            |  9 +++++++++
 arch/x86/kvm/vmx/vmx.c             | 11 +++++++----
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 |  1 +
 6 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b..aecbe9c54004 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -25,6 +25,7 @@ KVM_X86_OP_OPTIONAL(vm_destroy)
 KVM_X86_OP_OPTIONAL(vm_pre_destroy)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_precreate)
 KVM_X86_OP(vcpu_create)
+KVM_X86_OP_OPTIONAL(vcpu_postcreate)
 KVM_X86_OP(vcpu_free)
 KVM_X86_OP(vcpu_reset)
 KVM_X86_OP(prepare_switch_to_guest)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5f6c1ce9673b..3ed9d8fc3b96 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1803,6 +1803,7 @@ struct kvm_x86_ops {
 	/* Create, but do not attach this VCPU */
 	int (*vcpu_precreate)(struct kvm *kvm);
 	int (*vcpu_create)(struct kvm_vcpu *vcpu);
+	void (*vcpu_postcreate)(struct kvm_vcpu *vcpu);
 	void (*vcpu_free)(struct kvm_vcpu *vcpu);
 	void (*vcpu_reset)(struct kvm_vcpu *vcpu, bool init_event);
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 83d9921277ea..bdf5ba3155f6 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -78,6 +78,14 @@ static int vt_vcpu_create(struct kvm_vcpu *vcpu)
 	return vmx_vcpu_create(vcpu);
 }
 
+static void vt_vcpu_postcreate(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_vcpu_postcreate(vcpu);
+}
+
 static void vt_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu)) {
@@ -898,6 +906,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.vcpu_precreate = vt_op(vcpu_precreate),
 	.vcpu_create = vt_op(vcpu_create),
+	.vcpu_postcreate = vt_op(vcpu_postcreate),
 	.vcpu_free = vt_op(vcpu_free),
 	.vcpu_reset = vt_op(vcpu_reset),
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..ae6cef9c13e0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7752,10 +7752,6 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		vmx->ve_info = page_to_virt(page);
 	}
 
-	if (vmx_can_use_ipiv(vcpu))
-		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id],
-			   __pa(&vmx->vt.pi_desc) | PID_TABLE_ENTRY_VALID);
-
 	return 0;
 
 free_vmcs:
@@ -7767,6 +7763,13 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return err;
 }
 
+void vmx_vcpu_postcreate(struct kvm_vcpu *vcpu)
+{
+	if (vmx_can_use_ipiv(vcpu))
+		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id],
+			   __pa(&to_vmx(vcpu)->vt.pi_desc) | PID_TABLE_ENTRY_VALID);
+}
+
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 409858074246..defc2c3a37c8 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -21,6 +21,7 @@ int vmx_vm_init(struct kvm *kvm);
 void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
 int vmx_vcpu_create(struct kvm_vcpu *vcpu);
+void vmx_vcpu_postcreate(struct kvm_vcpu *vcpu);
 int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu);
 fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void vmx_vcpu_free(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..c9f512a30fec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12873,6 +12873,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		return;
 	vcpu_load(vcpu);
 	kvm_synchronize_tsc(vcpu, NULL);
+	kvm_x86_call(vcpu_postcreate)(vcpu);
 	vcpu_put(vcpu);
 
 	/* poll control enabled by default */
-- 
2.55.0.141.g00534a21ce-goog


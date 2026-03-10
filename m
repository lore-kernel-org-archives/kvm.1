Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1453EAC75
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174266; cv=none; b=mBz7j7NJmOln0k5wQv5PlMzCtjKYidOH3G6j/y/pNppDwoBC5Tel6360UFsLs8w+cQGX5xoN8EwS9srv/3HS/BnsxYvmOpPBf+/KM4hPIOaB7AkiYkUYD6jVtnBVq96OswjRtF8HtJa0oh0cLnh3m4RFCHzLFEM1lE9qoKTnFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174266; c=relaxed/simple;
	bh=JJO5qewKWIqGbxpfcpQoE00DHR/fbyp+xQU2r4R6u5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4cECKHYn+qsf3J/SNhamG5JJwgC9Yd2W8SMZZwN8ih7bcP+fsBU4yMaATdHlDRDK137Lh6EjXaNxNGbdbxEom6BkSF0g+AMGWTTJ54coGEnwB85ruWtEflugZ0JayPmft1TQ2PsoOZzPPUbOBNVMd7CmDDDZBIMkWvpIMy2obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkLPTygH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENN7Aunw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkLPTygH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENN7Aunw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ85Lkzx3nSPKz8vbaVq+hpymVq+1ScaQgtLPpniKs4=;
	b=LkLPTygHV/HP4DVQUeK0YijcwFAJCa3WOmhdCU9mE7xN7yyS7Hh7dD8Q7KRAXB7m3qqh5d
	AhQ3cugOVz4PC5HsvK/9oNvtpO1uJ1sYwQknDRJpq0xvfG/zZVkzqDMoCZvdxM/xvvWP86
	hnP+DmJ8IfgbyoJdDbuGKQZWLh6Moik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-tSAOabruN-qjg43U5lTKYw-1; Tue, 10 Mar 2026 16:24:20 -0400
X-MC-Unique: tSAOabruN-qjg43U5lTKYw-1
X-Mimecast-MFC-AGG-ID: tSAOabruN-qjg43U5lTKYw_1773174259
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439b50320a0so199363f8f.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174259; x=1773779059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ85Lkzx3nSPKz8vbaVq+hpymVq+1ScaQgtLPpniKs4=;
        b=ENN7AunwnuoxQNdjN9tfHrr0HKXiET+Gl7YqtAzhncsOaua049ULloIia0dTfg2/pH
         Vnc6gSGuBaQJ6zb3nYNtPYauC9VO1vlivLVJ3XvDN/RKpWFIokA/TDaiw81jnmgElGGt
         APn4S6+w8+WGLIFyST3Q7Mlg7oqPYFcHfksrab5/mfn+nS24laPkl1e/FrNNvIqyIzeA
         q+iZxg5NoCbp49RZD8ywG1ToovQaASe8xQ/AOSRil/qjQdHzgcMiveHtlcQKU8Dg4JCG
         tP/n6DoMmLEzu5nbGwjh10FQhlP1wXkeXqzrDxTBmmPHcquChGlnGKU7Uk/sBkof8/TV
         QLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174259; x=1773779059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJ85Lkzx3nSPKz8vbaVq+hpymVq+1ScaQgtLPpniKs4=;
        b=OagUte4l3C5E7msOIxt9R3eNQquc3oA6JvaC2oYboF+vBfesz0wTIarnhTquF4bhTY
         xQzbMDLN63e6Sbzt+cCdDuvWeUznv2Z80E3ZTHSA05WKtCAH7CCpVnULMOySRvKMbHCv
         aj7ILYnvD/oRgPSumq0ovHlMj4w0UpXERZUEjUc+psv/TkXSmpcGAvGIMNSspea2nMQ6
         Ip4Vdj4hJiRF64txUP6QM22ztKJ2tRKh2KJeVSQEgAfCYQoNCs/ET+qv10v8TsnC/qcI
         1IvU8TXYqMXmjXThU/K68ciBWZIqT7/ZT9t5u8Y+p3nsvAI7WSEU53elimF+r3V0qkjo
         LRpw==
X-Forwarded-Encrypted: i=1; AJvYcCXuHiX45GlzbDvcBRLICMP0mt34x4ZxzErTn31DKBi9PHNtY6gG6PtKx5Sx3KypGQgarQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ddnaM8HqHPC6eybFlUBPt0JpiwZBg47EV6GJHXAQW2eMSw9x
	2/hoU1Ljss+Iq+d+Yp/bTPXFPBvkL1FLNGKECTczP586lv3tNB1jp5yyHv05yquyJdMCa+9Tr+Y
	hyPgEFA5bvYjycnMRkzchJiP1aPdEt/ylPouFdmoZoMr2U3Z60k8ZQw==
X-Gm-Gg: ATEYQzzufzUE+O0yclceYSW/U4LpV+bIptzD5Q5QyT4Mk+Sja+fv1I4x+TR1563pEC9
	roPAVB4zWD7gJlqdHZfMlDd6cjeeXRmD1pjencWsxqUOWuiu7QXCNpbuI4NUVRjV+TLksYEpVdv
	sQbLnG8z72Dax4c5a82JoIq8uU4L+RInj/aOnHK3KryB/c2aLQaRyzZxZZX1Dz9y7KRglRs6fKl
	gHbJMUNNWLFWyvPWcFmb4Z6P4OtGRFKdR3XEbTe2QPBx1kO9S6X9BIboeDa8WmIb9SwEV6ZtCn4
	A9UFEQY81imAbGPOpUOSCi5KzgIzcxU+jEf0xiAxtCK7hA8ytYLyxu+w+T88FzKmhSa+gcgLMXg
	N3Gb5zJ5oKc54x0R7n6+q4kJOzj+6Fojln9MfLsw9W/W4jZnENBMca1eNcW8yA1vuSjoWVgZVpK
	PjWnuAyywsSr4CCDtZayySwvhHS3s=
X-Received: by 2002:a05:6000:2908:b0:439:b6b3:faa7 with SMTP id ffacd0b85a97d-439f8c10e3dmr43753f8f.28.1773174259341;
        Tue, 10 Mar 2026 13:24:19 -0700 (PDT)
X-Received: by 2002:a05:6000:2908:b0:439:b6b3:faa7 with SMTP id ffacd0b85a97d-439f8c10e3dmr43703f8f.28.1773174258827;
        Tue, 10 Mar 2026 13:24:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3638sm621443f8f.9.2026.03.10.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com,
	stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: VMX: check validity of VMCS controls when returning from SMM
Date: Tue, 10 Mar 2026 21:24:10 +0100
Message-ID: <20260310202414.406078-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310202414.406078-1-pbonzini@redhat.com>
References: <20260310202414.406078-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMCS12 is not available while in SMM.  However, it can be overwritten
if userspace manages to trigger copy_enlightened_to_vmcs12() - for example
via KVM_GET_NESTED_STATE.

Because of this, the VMCS12 has to be checked for validity before it is
used to generate the VMCS02.  Move the check code out of vmx_set_nested_state()
(the other "not a VMLAUNCH/VMRESUME" path that emulates a nested vmentry)
and reuse it in vmx_leave_smm().

Cc: stable@vger.kernel.org
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 39 +++++++++++++++++++++++++++------------
 arch/x86/kvm/vmx/nested.h |  1 +
 arch/x86/kvm/vmx/vmx.c    |  4 ++++
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cb925cc53389..d4bc47079809 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6849,13 +6849,34 @@ void vmx_leave_nested(struct kvm_vcpu *vcpu)
 	free_nested(vcpu);
 }
 
+int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu)
+{
+	enum vm_entry_failure_code ignored;
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
+	    vmcs12->vmcs_link_pointer != INVALID_GPA) {
+		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
+
+		if (shadow_vmcs12->hdr.revision_id != VMCS12_REVISION ||
+		    !shadow_vmcs12->hdr.shadow_vmcs)
+			return -EINVAL;
+	}
+
+	if (nested_vmx_check_controls(vcpu, vmcs12) ||
+	    nested_vmx_check_host_state(vcpu, vmcs12) ||
+	    nested_vmx_check_guest_state(vcpu, vmcs12, &ignored))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				struct kvm_nested_state *kvm_state)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
-	enum vm_entry_failure_code ignored;
 	struct kvm_vmx_nested_state_data __user *user_vmx_nested_state =
 		&user_kvm_nested_state->data.vmx[0];
 	int ret;
@@ -6986,25 +7007,20 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	vmx->nested.mtf_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_MTF_PENDING);
 
-	ret = -EINVAL;
 	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
 	    vmcs12->vmcs_link_pointer != INVALID_GPA) {
 		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
 
+		ret = -EINVAL;
 		if (kvm_state->size <
 		    sizeof(*kvm_state) +
 		    sizeof(user_vmx_nested_state->vmcs12) + sizeof(*shadow_vmcs12))
 			goto error_guest_mode;
 
+		ret = -EFAULT;
 		if (copy_from_user(shadow_vmcs12,
 				   user_vmx_nested_state->shadow_vmcs12,
-				   sizeof(*shadow_vmcs12))) {
-			ret = -EFAULT;
-			goto error_guest_mode;
-		}
-
-		if (shadow_vmcs12->hdr.revision_id != VMCS12_REVISION ||
-		    !shadow_vmcs12->hdr.shadow_vmcs)
+				   sizeof(*shadow_vmcs12)))
 			goto error_guest_mode;
 	}
 
@@ -7015,9 +7031,8 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 			kvm_state->hdr.vmx.preemption_timer_deadline;
 	}
 
-	if (nested_vmx_check_controls(vcpu, vmcs12) ||
-	    nested_vmx_check_host_state(vcpu, vmcs12) ||
-	    nested_vmx_check_guest_state(vcpu, vmcs12, &ignored))
+	ret = nested_vmx_check_restored_vmcs12(vcpu);
+	if (ret < 0)
 		goto error_guest_mode;
 
 	vmx->nested.dirty_vmcs12 = true;
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index b844c5d59025..213a448104af 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -22,6 +22,7 @@ void nested_vmx_setup_ctls_msrs(struct vmcs_config *vmcs_conf, u32 ept_caps);
 void nested_vmx_hardware_unsetup(void);
 __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *));
 void nested_vmx_set_vmcs_shadowing_bitmap(void);
+int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu);
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
 enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 						     bool from_vmentry);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 48f0e426a8a2..e9fa59e92548 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8540,6 +8540,10 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	}
 
 	if (vmx->nested.smm.guest_mode) {
+		/* Triple fault if the state is invalid.  */
+		if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
+			return 1;
+
 		ret = nested_vmx_enter_non_root_mode(vcpu, false);
 		if (ret)
 			return ret;
-- 
2.53.0


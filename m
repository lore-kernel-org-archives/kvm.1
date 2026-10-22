Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697351;
	b=DH6KWyMNrE0WEWXSVbHZPMT5SUvuoKD9jJDIP+uCYazApjSQPX5Mstqc2jMufFsJ4VhC
	 QNKlL9DfUCZLWzDcnNNxfJTSgg81PkwbTUZpMrcg/hfsWdpqM0F7+6lG6L5BPzeH06Hcn
	 xs/80yllAsqTeuWZNWQigNR0xH6u7PpBGPjxTOSKUUHaJrGUzGzGDZo/D0sO2JGav45ox
	 gAVB/mRbq8Y8p1UrNnzbR7EjJHCKBJcaABPBoK9jJEhM+5sLqvvBXWuDp0LOk1kJUSlld
	 7lfLWfYu38rrlcoxx5W7eNd5XReRld6vPWaug13jZTjPXJstfhzRrDRlu4juW4dWXqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Arx6jy0MOgeqv9tTVqXlk/d3btfDuiHwkJcNQqBQPR0=;
	b=KmKu4/96cBaWSQi6Mtbfo6cqUl6JAjl+AhARxN7jSN4r2o4QpbxkvpJC/rwxDrwBgiLj
	 EHQ2SMskVuBdpCCapIr87c8lL0LFSAgyCwkN7n0DTN5/P3p+NZ2Q1N5w7pN/2hBF0k2M4
	 ZmoR+wOTT+ML01v6CVRH+iVxb77HH73Ecb17ap6Zvg8f8BnON/Ubi8fEHVgzdn0OTemYs
	 7vH8ztqtyRNXEv+eTC/CvSRxiOMZPFFAMMfE2FB2YaH9SAv+wsx9CnYlkk2deDmDDVYpX
	 DZCPr6xh//c3+8nt6o8NrDB81UoInFPjOZsDXcJDnur9QRO6iT5BeswMMlPJxAvIM5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=glfJBT7v;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01D606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B01D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=glfJBT7v
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so227162b3a.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792697351; x=1793302151; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Arx6jy0MOgeqv9tTVqXlk/d3btfDuiHwkJcNQqBQPR0=;
        b=glfJBT7v/vB1FELM8qGbuCUF2czjr7b1NMK5MamyEnEJjrgKkL39ExXtm/L3K/IB2r
         aa40Bbhar82iZy8w0SSoGzdIJxOifChE+AN3Y4lYn8TI3l/YhRrvON1zZs7TR/Fr3eZQ
         m+dOpAba07tiuw1d6WuOEKZRPLhQUYTYv7XX9l6CmfnpAF2VabkkXPegP7g/FowdWJUm
         0R8Wxs9QcyBk9z0ZYxMJNlR6z7oYyYlTiCMuq1ONKK19Y4U4+XrotWyjGxTniGXiVD4q
         zbNbkWiU8JY2smC/psRJul+Jgk0XQCyqdNUSYb/4n6cqY5R0F7kpSKpwxgXngpzsGmnM
         hUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697351; x=1793302151;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Arx6jy0MOgeqv9tTVqXlk/d3btfDuiHwkJcNQqBQPR0=;
        b=IHCg2nyJZORzBy5sdX57NHNNa6oNI/07HYXa++m0Fm2FuVW/EVjPjiIQCrdNRH7vqk
         QVq+U3of1LA8e2HfymXcArd4EbVPsR00HlRyCgSZuUUIoc5ms5fpptRM2/y7IoO4RfiO
         NtXELLFOvt9EVKNhQydIBOQOvyMarM1aUGvQfG/Gsl7/bLYV8AmSoUZpq69khGm1eqTv
         5z2Lo1mtEJUxH781IDt3Oyu3xcv8Sg7x611mudbxaA87L1Dzlq4vnXT01anQR/Co/WNU
         fAQLL8y2YLflv+a6AWBVAGWUJ3wG/Orw4eES6bdCSIE17NPQOpMz0FtfxTdtBtkjafkm
         r5rQ==
X-Gm-Message-State: AFq9FYLMzR3k6ZmfpcgAhgtk3BxC8suLGHC5IYuGoMkhnV0kDENAFukt
	utzaA8iI4cM9mIPBnI0hQR+CcSpQd8hCRGI+PcfaOZjoQqV9e4pFgi8xWup5zKiH333cvWEpwWJ
	pcedZuw==
X-Received: from pgmt10.prod.google.com ([2002:a63:224a:0:b0:cd6:b0a6:8d94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d50d:b0:3e1:fcec:c724
 with SMTP id adf61e73a8af0-3e287e6f7bbmr4535725637.31.1792697350460; Thu, 22
 Oct 2026 12:29:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 12:29:08 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022192908.554376-1-seanjc@google.com>
Subject: [PATCH] KVM: nVMX: Clear nested.smm.guest_mode when freeing nested state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karthikeyan Bhargavan <karthik@cryspen.com>, Chris Mason <mason@kernel.org>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

From: Josef Bacik <josef@toxicpanda.com>

If an SMI arrives while L2 is active, vmx_enter_smm() forces a VM-Exit
to L1, and records in nested.smm.guest_mode that RSM has to re-enter L2
and in nested.smm.vmxon that the vCPU was post-VMXON.  free_nested()
clears the latter, but not the former.

Userspace can get KVM to free the nested state while the vCPU is in SMM,
with KVM_SET_NESTED_STATE, e.g. with no VMXON region to say that the
vCPU isn't in VMX operation, or by flipping the SMM flag back and forth
with KVM_SET_VCPU_EVENTS.  When the guest then executes RSM,
vmx_leave_smm() tries to re-enter L2 even though there is no vmcs12 any
more, and nested_vmx_check_restored_vmcs12() dereferences the NULL
nested.cached_vmcs12.

Clear nested.smm.guest_mode along with the state that it refers to.

Fixes: 8fcc4b5923af ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
Reported-by: Karthikeyan Bhargavan <karthik@cryspen.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Cc: Chris Mason <mason@kernel.org>
Co-developed-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..66a7b57c9f16 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -349,6 +349,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
+	vmx->nested.smm.guest_mode = false;
 	vmx->nested.vmxon_ptr = INVALID_GPA;
 	free_vpid(vmx->nested.vpid02);
 	vmx->nested.posted_intr_nv = -1;

base-commit: 164405e8e9a0378c7e1aff2254625a6553a291f1
-- 
2.56.0.257.gf7497c7d27-goog


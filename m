Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99835C68B
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764403; cv=none; b=ouNJApESc3xlMCtbiTHiYgNzKtGy0k+fLv6xXpTi5EsFK7QVFDj97WpRuZo0g70mzxLrBT2kGgLnlU/WCFO+R7gpoitad+Mrq5o94LyhahCVxJBJW2+B4DjJ308S0fG6qBYi8o/9FPfa6NHrO+Fhs6OCqvxO3jeH95dqqNa9sFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764403; c=relaxed/simple;
	bh=DwEigifFf2ZKAThwfxHzBagv4JxbtKhCNkN3G11XtrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ruVY8uF83UVh279wFcYZNrA4PMRFtblJj9wJie4IBrGMYe7XnaWgqhIP5kAO+ExyTP6pdo5iE4UR5QNP0FYthIDGFTPsqp47Ture1jkGXSSDC995urzerAJuE3JkUgraWJwPXDkxnBFY+XIoh1kuAO606611Agp8uZRtLOO3Tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jW298FsG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jW298FsG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d54187d8b0so28866505ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764384; x=1788369184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YPT+STeueGFc+KdPGYWQIMiF2dG2O4FU++jlmfsqf6g=;
        b=jW298FsGQozp7VZmqM3jftCOaMzYz5Yx9uaMD4bWrSLfpoDqm/yFYKDc1Apt2GmtjR
         jpfmcfCUNegzd93xsiTRWJ0V97xxo4uO9+XtO4fryeVQYuMlK+A7kDPcImREToHCx9Eu
         h8m9fOB6t4Y5Mvtmc2JMOzI0yUcR2YL1Ogepg8t+2lRgtQ5AhE1QJLkC4LjzEi8kddxB
         lgrOUr16rm2jz7x9geCrIwyTanM2IQsYYSN1uahfQ+dnCJYZEbgph4SAqwfinhJYR57U
         hC/8H6+29L4dcOnk+AIq6RQbfSi5xomra3LxWOWue3o9FadIhTWihE9kY/LagOtL9J3b
         s+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764384; x=1788369184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YPT+STeueGFc+KdPGYWQIMiF2dG2O4FU++jlmfsqf6g=;
        b=Fq6oRa4nyxynl6PxfDcph6xLBm88adpozxD3CdQDIOWWtm6SsUAOSDuLELuvxIv4VX
         IGVL+Mjp42TIvTbtckKcgLd2l+NG6Jnm2xmmoDykyknB/gWdEIDQqRpIaW2jadsT2nmA
         IWdeGwnwcC697JAfI/ZOh+AihpDi0J7AVdvMf8vOHkgOZns4+jNmzmgcFoenfEE3jzf8
         xxbDCDCB7JqxphjU84T62+L0+I0CWq1gcb3fb0rqbXZ/p1/exAim4UCeTnKMpUqrMFWr
         6OayNGmUnktF3Ea27aO53tUYDV4ab8Ur5omv1PFd14wXEv/qOiHO16kHSLFs8yw9sdAp
         CkAA==
X-Gm-Message-State: AFuF++nbNgumRHRCQxkDz/tQ4UJ4HocIuYWoI8/3lSB14AFNVdeGzkNq
	N0IBXVnFepPZtVqBku08YKDTdXRteraYCtwPkHlVC68KAlkGPotEKCvwNH2uKZea1nyD2MQ6JNh
	x59KguQ==
X-Received: from plxe6.prod.google.com ([2002:a17:902:ef46:b0:2c7:e06e:86f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1106:b0:2d6:f961:994f
 with SMTP id d9443c01a7336-2d707a59e04mr140009865ad.8.1787764384081; Wed, 26
 Aug 2026 10:13:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 10:12:44 -0700
In-Reply-To: <20260826171246.777729-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826171246.777729-7-seanjc@google.com>
Subject: [PATCH v2 6/8] KVM: VMX: Use dummy pseudo-overlay struct for to_vt()
 and vt_to_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define a combined vcpu_vmx_tdx structure to represent the common layout of
vcpu_vmx and vcpu_tdx, instead of having vcpu_tdx piggyback vcpu_vmx.  I.e.
require VMX and TDX to match the common definition, not for TDX to match
VMX.  This will allow moving to_vt() and vt_to_vcpu() to common.h where
they belong.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/main.c | 4 +++-
 arch/x86/kvm/vmx/vmx.h  | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 8ac6ea58b481..0151baa56598 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -13,8 +13,10 @@
 
 #pragma GCC poison to_vmx
 
+static_assert(offsetof(struct vcpu_vmx_tdx, vt) == offsetof(struct vcpu_vmx, vt));
+
 #ifdef CONFIG_KVM_INTEL_TDX
-static_assert(offsetof(struct vcpu_vmx, vt) == offsetof(struct vcpu_tdx, vt));
+static_assert(offsetof(struct vcpu_vmx_tdx, vt) == offsetof(struct vcpu_tdx, vt));
 
 static void vt_disable_virtualization_cpu(void)
 {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..0415d328e1a5 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -304,14 +304,19 @@ struct kvm_vmx {
 	u64 *pid_table;
 };
 
+struct vcpu_vmx_tdx {
+	struct kvm_vcpu vcpu;
+	struct vcpu_vt vt;
+};
+
 static __always_inline struct vcpu_vt *to_vt(struct kvm_vcpu *vcpu)
 {
-	return &(container_of(vcpu, struct vcpu_vmx, vcpu)->vt);
+	return &(container_of(vcpu, struct vcpu_vmx_tdx, vcpu)->vt);
 }
 
 static __always_inline struct kvm_vcpu *vt_to_vcpu(struct vcpu_vt *vt)
 {
-	return &(container_of(vt, struct vcpu_vmx, vt)->vcpu);
+	return &(container_of(vt, struct vcpu_vmx_tdx, vt)->vcpu);
 }
 
 static __always_inline union vmx_exit_reason vmx_get_exit_reason(struct kvm_vcpu *vcpu)
-- 
2.55.0.887.g758fc8c411-goog


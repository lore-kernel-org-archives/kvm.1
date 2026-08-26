Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E9409277
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764399; cv=none; b=sMBeGLs369wn97vHP2R+/AHARlJhLUXN4pEtVI65VULsmPPs8XHCPaj+nVE3awMrggxVrIB7W0nUy3eUv/QPMr3UIMFfi9aQUQP9wzm/2o3O83GMKMhcus+IpoDqN4cp1unosNdNNhDC/1NOowkfWwOIhOEit0sQuBU8XGwhEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764399; c=relaxed/simple;
	bh=ETYszkt+PpDnzyBQpct9QDXpj2i+G42vlOEci4TgHog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uK2R/Eg941sorz9QnxFuSNfUnzzU8fYTSVfWJpHX/zb48EXVu6+j9z51iSjZldYcPTQ29Hz7BCCTSP0eh7sFDgcMPABYIe89SbP3prUQKIif5aZQXTcfkNtXWHAZYJxJQZumZGpMmGH+z49Z6GrGJivPO9vLipvVy4LjOFvfBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiEJrrzj; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiEJrrzj"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so2048710a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764383; x=1788369183; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IvVQPd56KlHv5ygDzHuD2XaX2Xb0ULf5ZrzcKWCrS+0=;
        b=qiEJrrzj7giOEAQHh4YK38G6DixPccjNYBIZ9MjWvskSU8Gd0WdemrxnHS+7m334eL
         x/ZLXxsvFqtkhuhVMwikGdOQ7oa7DlF3NrKolzV7CFBttYQB/kTpRoyFCO+TzwQJ0B62
         bXiohEhsVVl01c6nkVBflPgTWv/+I7ZQk3pf1LlmuVt3zoM9/vICrph6a0QBdTaeO26L
         nqANtPiboJvq8gJgpPrc8IKql/5SyJS1N4wgKCAnCOdbr0i43sGM6qaWbDf7ugqs4r3I
         yP2PbHTpBaJIr5FYJvimrVapUN5o5PBlW+cIWU0NnjKfHF1LqbrzHO1mwDjGnh3JJMmO
         MJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764383; x=1788369183;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IvVQPd56KlHv5ygDzHuD2XaX2Xb0ULf5ZrzcKWCrS+0=;
        b=qWJ3BPG9EM98RMoEyR0ZrhkKxutw9ajU84Pt3K26d4wjnQ+CS/LGFzVlAMubVFXUbo
         nTEdSbKxABZRIqLtl/yg6ZYA4scC4USN7XUFf/uWkG7B1ci5AZXh/+Na9eEk0qLpVWPU
         085upNnRXvTA05nBDZGAz4mRTASIShbUIXOekLnhVgUc0ahS4yVlIVUjWLNefEJQ2bh7
         Fc6KeA9RdLUSAKKlVkK6wbvXcBVjVDtoocMzcgAoMwy/2AECTQraranub5GPx9RGMgh5
         yK5sj8HMxU6sAoSVIlOTQzke812T/IHbMrnC3woe+qFXoo2+heOxiKu87HYSVbgnf3Yq
         WU4w==
X-Gm-Message-State: AFuF++mJv5Hd7rJRfNQkF3ommTUV6wyeVbnHd6LgTn5XJOY9a349b/mj
	wqUaXZ+cQQIjLAApGlJuEVT20TE3hhyT27giblzno4QKXKrroOPhW45G3HjuCRhcaRrEdtUxig7
	khSMrBQ==
X-Received: from pgcp11.prod.google.com ([2002:a63:740b:0:b0:cbe:9dc7:9eec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21d2:b0:851:c1ba:7aa6
 with SMTP id d2e1a72fcca58-85373eb1adcmr14442590b3a.11.1787764382313; Wed, 26
 Aug 2026 10:13:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 10:12:43 -0700
In-Reply-To: <20260826171246.777729-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826171246.777729-6-seanjc@google.com>
Subject: [PATCH v2 5/8] KVM: VMX: Rename EPT violation handler prefix from
 "vmx" to "vt"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename __vmx_handle_ept_violation() to __vt_handle_ept_violation to capture
that it is shared between VMX and TDX.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h | 4 ++--
 arch/x86/kvm/vmx/tdx.c    | 2 +-
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index ff4f6a2b6402..35b54938a5f5 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -86,8 +86,8 @@ static inline bool vt_is_tdx_private_gpa(struct kvm *kvm, gpa_t gpa)
 	return !kvm_is_addr_direct(kvm, gpa);
 }
 
-static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
-					     unsigned long exit_qualification)
+static inline int __vt_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
+					    unsigned long exit_qualification)
 {
 	u64 error_code;
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 36578d4c00ff..a3d6f0fb5951 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1987,7 +1987,7 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 	while (1) {
 		struct kvm_memory_slot *slot;
 
-		ret = __vmx_handle_ept_violation(vcpu, gpa, exit_qual);
+		ret = __vt_handle_ept_violation(vcpu, gpa, exit_qual);
 
 		if (ret != RET_PF_RETRY || !local_retry)
 			break;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 506be74e3e0f..2532a9b8e92e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5991,7 +5991,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	if (unlikely(allow_smaller_maxphyaddr && !kvm_vcpu_is_legal_gpa(vcpu, gpa)))
 		return kvm_emulate_instruction(vcpu, 0);
 
-	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification);
+	return __vt_handle_ept_violation(vcpu, gpa, exit_qualification);
 }
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
-- 
2.55.0.887.g758fc8c411-goog


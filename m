Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EC17A2E8
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727093; cv=none; b=dTWy/1kn2ekOeW9g/c3b2FHyHTikHbKMOc/WPsEP59VI1903jURGnP9++kJ441R5NErpjFUGx03rA6xBoZ43VcKUSy07pyy0/DqZOu0b0kdZ6Ch/7rT4gCQJ98PRw2U5bFLu10lqj2XKFZhIqP87Uri5xlAoBcAIcJ+dcq/4RS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727093; c=relaxed/simple;
	bh=sZFXk0BIchYjOjDaEK0ZoynBeIbw22eT1lGZHMbQVgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRHWutg4P17KVuxco77T1ZuqbENYyviD/Gk2rzA0QI7TYl6LUz9NuVGphDmXstPcNYzGTN5qXFYdFmFyM41ni+Pv3CTOxKZJyrY/ElTQPB2QaGq8IyRLpCQ0/j/pwJm3EuQZoWKq5gB6VMa1ycwDgI/yn8v8I9u9LsX+yLVMbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJNTdZeX; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJNTdZeX"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7443e0f0bso63522555ad.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727090; x=1791331890; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=edNeZC9TNiU8IY0mX2z6Pr9YDXA5iNLVK2rM3T8F938=;
        b=PJNTdZeX+i9h6AmXxMPHRpRUED35hc/kAuusj2lLGX5CJIQ5anIw2gIqJ3h4cJWT89
         hH9kVdo+F/2/HgjWNIZ0/coKiFadbHuVEwG3PHx3G4VtKheslHEqnZRceM/4pThxWQC9
         kIk5xLLxVCMkdoQ7H6rqmhghXiZONu0jMAgD88EEO8MfiHQ8KTnKj8Ey1I3pQQdPWoBr
         Mb2ypXLunyuSXn/tnfpu06oVwFRAhiW4jmNPkxaeJr+WoKDfyR15utNxgp7qZbtcicqw
         gtgVJwWmWFcE8MqVbqbRHG6m0/qupsnhyVgo0NhwJ6zs/zL5OxGPRfbeEVO8aoNDw0Ts
         usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727090; x=1791331890;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=edNeZC9TNiU8IY0mX2z6Pr9YDXA5iNLVK2rM3T8F938=;
        b=pB13SA7Ac0rCugJACdDMv0NYQzx8PyB5nnMg42SsWCO6TnYFDtpzancClyFhio5Tgs
         KDRFR5FRp82rXLu8BupIbPO2ye3VWmgQ3VHIcd5CByjc9M+7RyqGdmUqF9+i9Pphvac7
         FfEB0ScMV002MM4QqKgfphDoZfA37P+DzfhlySG09r/5lAoJ6cvgFbya0UI7Ovwiabt7
         UrAL7xTjL4a+flC7rKDYfJeZQqXw9sau+M3imhuu0+n7r/c0uRNprpDYaUMI5ztCP7gU
         oQ5JD2zCbUyM5PhDY5WFQAbQJ3WN1S56Aps43jI2GUc/Qv8j3X2t7nsVABlDZ9K00jZ3
         uqjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEi+gR/uuwTT3pw0MIp4GaYzK84GKamx7yAJEZUo9Ehkjn7/gXpAbywivV3dHYNAg0MjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD8V1DUic4/7YxNIVNHnCFhnM2ut0+RqjumufNwLUrP36z6e1p
	4h2XCWOzZDnrwWr/NMmMC1Z/W7oIj+b6WDIwGr1TRKu+Q2leNWHzPY4QfGaAYan2BuTzNJJOZQ6
	G8LOqoA==
X-Received: from plme16.prod.google.com ([2002:a17:903:4910:b0:2e2:b29f:52a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d98e:b0:2dd:ad73:c936
 with SMTP id d9443c01a7336-2e2de536e36mr5887855ad.23.1790727090389; Tue, 29
 Sep 2026 17:11:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:11:25 -0700
In-Reply-To: <20260930001127.3170009-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930001127.3170009-2-seanjc@google.com>
Subject: [PATCH v2 1/3] KVM: x86: Add a helper to prepare vcpu->run for a
 SHUTDOWN exit to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add kvm_prepare_shutdown_exit() to dedup the paths that exit to userspace
with KVM_EXIT_SHUTDOWN, all of which happen to be x86 (presumably other
architectures use KVM_EXIT_SYSTEM_EVENT?).

Note, this adds a clearing of mmio_needed for SVM's shutdown_interception().
Not clearing mmio_needed in that case is all but guaranteed to be benign;
KVM should never enter the guest with outstanding emulated MMIO operations
(the equivalent VMX and TDX paths likely copy+pasted the code from
KVM_REQ_TRIPLE_FAULT, which does need to clear mmio_needed as KVM can
synthesize a triple fault shutdown in the middle of instruction emulation).

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c   | 3 +--
 arch/x86/kvm/vmx/tdx.c   | 3 +--
 arch/x86/kvm/vmx/vmx.c   | 3 +--
 arch/x86/kvm/x86.c       | 3 +--
 include/linux/kvm_host.h | 8 ++++++++
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0eb1623052c1..d2feb57d774f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2190,7 +2190,6 @@ static int mc_interception(struct kvm_vcpu *vcpu)
 
 static int shutdown_interception(struct kvm_vcpu *vcpu)
 {
-	struct kvm_run *kvm_run = vcpu->run;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 
@@ -2214,7 +2213,7 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 		kvm_vcpu_reset(vcpu, true);
 	}
 
-	kvm_run->exit_reason = KVM_EXIT_SHUTDOWN;
+	kvm_prepare_shutdown_exit(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ee1d412b0ee6..29d4751f37fb 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2092,8 +2092,7 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 
 	switch (exit_reason.basic) {
 	case EXIT_REASON_TRIPLE_FAULT:
-		vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
-		vcpu->mmio_needed = 0;
+		kvm_prepare_shutdown_exit(vcpu);
 		return 0;
 	case EXIT_REASON_EXCEPTION_NMI:
 		return tdx_handle_exception_nmi(vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index dc635145eeaf..35db7197c586 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5588,8 +5588,7 @@ static __always_inline int handle_external_interrupt(struct kvm_vcpu *vcpu)
 
 static int handle_triple_fault(struct kvm_vcpu *vcpu)
 {
-	vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
-	vcpu->mmio_needed = 0;
+	kvm_prepare_shutdown_exit(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf3fcdfd8ad2..cffd1b6ef789 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8139,8 +8139,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 				kvm_nested_call(triple_fault)(vcpu);
 
 			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
-				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
-				vcpu->mmio_needed = 0;
+				kvm_prepare_shutdown_exit(vcpu);
 				r = 0;
 				goto out;
 			}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a836756baebb..02ca5d5d83b5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2522,6 +2522,14 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
 /* Max number of entries allowed for each kvm dirty ring */
 #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
 
+static inline void kvm_prepare_shutdown_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
+#ifdef CONFIG_HAS_IOMEM
+	vcpu->mmio_needed = 0;
+#endif
+}
+
 static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 						 gpa_t gpa, gpa_t size,
 						 bool is_write, bool is_exec,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


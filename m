Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598737189A
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483848; cv=none; b=EPPEpTygv0GzhmXmIMYUnI6TV2Gk792f99fGftnk0HeD4zrpY7xGxvSW44M/tUMlcdehfP+99ygdsbl2EuxuASkc1Qyd6BkZFMneGAy+wS4PfvQ7RFVHINSLwLguiTpJwcSJEY2/FJSYt/GdQMet3JZqiS0GcRr5L5XW8JlOz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483848; c=relaxed/simple;
	bh=X4SZAAkjG92iz3w2ODpwfXxbWrcWBsnNa21J0Q9GDS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPdCLpcjEYo5x06R2tmNHsMr4oKOmAsUD/vTaNTOA3gc0C2tiPeuXEImcPMCJ8P2CkjyWUsAZiOPQhIF5CAi8SuKwWzGFQn+XutMJJ1+1IqFURO0fZOdFVXcSDf1+TJSH96ifi4Cos+GOl924AyiEDF72JdEmUaJdjR7gX/OVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVY3oL8X; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVY3oL8X"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so8059985ad.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483841; x=1789088641; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FSfv/bBfAxnRVVgmydjnwKVRqc5YLkAKq3RoNE3C6X8=;
        b=DVY3oL8XfxHw6bHIhWfXjDioZ7Q9KHTo0H8tiOG46JkBlXqL9qa4jDU8/oKaKTszmZ
         H2DYxt8P9isX+rYpnjZAg31UzOAWVp1MdW2WxgwCqLpMZAgKSWkc7kdPx5aegPZHa6BK
         Qa5m2UdLu3pcJMldZjQxdTEOeRjyw66ZbjtwypnL+PN9XASFTWvc/QOzeGsFL/WP/3Ez
         3xHJeFG/wKIUysMsHuNKw0cpIi9B8n+zKDhxm7gvwqNjH4AJ10dTE7LqdxROSrX1Nquc
         TXMw+cWFkboF7mHABTJ0CPlFWscGpxSWLnBAcu/HF5bg03RqIWCPbtf6stEd8mTOKDt7
         PN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483841; x=1789088641;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FSfv/bBfAxnRVVgmydjnwKVRqc5YLkAKq3RoNE3C6X8=;
        b=cYhZ7iIfNsvbmndWeY7NFXLyLKFf5HzXlZWmBi6w+vHWkVqeI9PQeJ8oQ5Tt3Aaopn
         BroMuwHCFcxaKcGV6uP9uEZAwUv3y6XpWRAFiXLDrFbIkP4LxWP6PoRpGGa0nOcJIxo9
         fUy1/FfsvC+Mmwu8ou2iOjpx5XGugymogpFQdfw3pfR4dlSF9PS3kICl30VtEHej5sbU
         cZk7heanWq2ZpCs/mYRyTddx1GGBrzz8rYMQvX7g0A8QadFqcK0dtJ5DCcpgMMQipMcG
         CYZp6N+oy3qUrzxUCDNCGx7By8To6gggx+ZxTc/bL7fiePKCPwLrCdZMuNFh57z4Tvbt
         QnRg==
X-Gm-Message-State: AFuF++ksqLW4zdSAdNoK1V4eQyX8brALZMRJ9t3mSDmghRU9eIjjeTrF
	GyhUPNn16YND66s9spxwVKQdELGw3wP8pBis1sVaJL8CqYzl+zT9mKqLJW815DKU5jucdL6uDrN
	8i5tO7A==
X-Received: from plbja8.prod.google.com ([2002:a17:902:efc8:b0:2ca:d0f4:2f91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3247:b0:2d7:2edd:d140
 with SMTP id d9443c01a7336-2db1232e1cemr43854845ad.3.1788483841108; Thu, 03
 Sep 2026 18:04:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:50 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-6-seanjc@google.com>
Subject: [PATCH v3 5/8] KVM: VMX: Rename EPT violation handler prefix from
 "vmx" to "vt"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename __vmx_handle_ept_violation() to __vt_handle_ept_violation to capture
that it is shared between VMX and TDX.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
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
2.55.0.979.g7e5102b832-goog


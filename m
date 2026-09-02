Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2186447819
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390582; cv=none; b=jRM8a4WWAiMEegeJqRGVvoabeispI4vRh7S4h8iagr6yBR/S4ugUapsJ6SOAtNK9J+hkMk/AA0hM62vMRH4YPk5cBXKVN3zZTheJt9QvOsv75AvR03sHpk8c542Fk9jtOay2DD8G61NimmX5DaNxq7vNG7350waasgSYAEH+5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390582; c=relaxed/simple;
	bh=+1VgxsgnJQl02sR9ZTeNUA36gnlTtRp4JJQojJXfI0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+4YDNg1lZpo6Ao5anwaxKKmZHUYXrfZeon/CeEiXHeokT1DzDx4RYM94sm9aY7W3oYckTJTWcjfd21SubTjSP7etCwS4Zk3NBLJWyZwtKnyOIMVKYuMDqwR6mYTGDqZTHUEQIZyFFhB0NAl7W/mZt23lM0J8c9p8BwluR1EBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bsDkvaXI; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsDkvaXI"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso3153736a91.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390577; x=1788995377; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ry8TyeFFo2R/yg40KQakAe6hDAwm94Khs2os2DazZE0=;
        b=bsDkvaXID0M/xWoT88X9CwFb8J4u0GE5aLhdJ6FdfvN+qqRAGdx/5TfwN/XvdYIEk+
         v68T9+mesS2M+opDfhjKOcxGx0NwNz4PWuyqmgDQmGp6ciQALZ4QzDT44wcvAqFA8a6T
         OxgYbqyGrOG5qXDL0UDr0bjwEbnHubjlI/OISHlsYeENjlFjTKuD049jxDGIzXvWOuOs
         ass6zJ6g6ZGbf5tuaLDIh/Ddugd9Xi0KqURrkqcojXVWvOsGLTa6AEptIRctw1MBII7I
         yZOOe4QbFvcxcJ+J2BJGW/vyElVQ3qVHib8RnqyO6ZsmP3o8t1T6zo2SOxUa5efix2Zr
         wy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390577; x=1788995377;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ry8TyeFFo2R/yg40KQakAe6hDAwm94Khs2os2DazZE0=;
        b=Hws7RW87G/4nGuC3sVZlRlFPK4Ii0PGQA5QplllMhH56b526OI4N7+RRYs8KzBj43h
         EoqhtAEZEgJ6w3I4suIa53eUoTHaIU8vgkQrKwHrXENXUN0JJp75Pvq5KXviiTjUQ3tC
         Zi6zWZ+jX96AMEQayiEdi5kXxnimBP6Wgt3gD5MzWeXOhOl/1uqPuNK/m/WPxQS09qnv
         70NtOXwSjB1y8mRoG86TvI/aOBKUrCkIOx8WJE6S1/h1o73V59GPsxT2sbiXNN6/Qo4A
         SD+87SWhOmUpeQZjFjSgvK2U6db1eIDFcPGDckVzepmZVgK9SdojfoXuddq1PCr8/uT3
         gEJQ==
X-Gm-Message-State: AFuF++kazYToO6tkZcuMWVp53U8i0ndvLGvY2TYCqD17nerX2Frg2Z9J
	GvD93NMk9Y9MtrjLtpoXhIFZpelKnZnGP2ruORaKxstpzStWeG6mv4EO8LsDd7BcbkiQux511Nt
	IGr2QNg==
X-Received: from pjzd8.prod.google.com ([2002:a17:90a:e288:b0:398:d8f4:c3f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d85:b0:398:9c00:29f0
 with SMTP id 98e67ed59e1d1-39aee249bd7mr12524431a91.24.1788390577209; Wed, 02
 Sep 2026 16:09:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 16:09:32 -0700
In-Reply-To: <20260902230932.2760127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902230932.2760127-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902230932.2760127-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup
 related code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Fold the GPA => GFN conversion and bitshift logic for identifying the S-bit
given the EPT root level into tdx_set_mirror_root_level() to dedup the math
and drop TDX_SHARED_BIT_PWL_{4,5} in the process.  In addition to deduping
a small amount of code, using the level to compute the S-bit position more
or less eliminates the risk of the mirror_root_level and gfn_direct_bits
getting out of sync.

Opportunistically switch the sanity check in tdx_load_mmu_pgd() to check
the mirror root level, not the S-Bit location, now that it's all but
impossible for the two things to get out of sync.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index e6b7da616817..a0bc9f818f43 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -56,9 +56,6 @@
 bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
 
-#define TDX_SHARED_BIT_PWL_5 gpa_to_gfn(BIT_ULL(51))
-#define TDX_SHARED_BIT_PWL_4 gpa_to_gfn(BIT_ULL(47))
-
 static const struct tdx_sys_info *tdx_sysinfo;
 
 void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err)
@@ -1609,10 +1606,7 @@ static int handle_tdvmcall(struct kvm_vcpu *vcpu)
 
 void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 {
-	u64 shared_bit = (pgd_level == 5) ? TDX_SHARED_BIT_PWL_5 :
-			  TDX_SHARED_BIT_PWL_4;
-
-	if (KVM_BUG_ON(shared_bit != kvm_gfn_direct_bits(vcpu->kvm), vcpu->kvm))
+	if (KVM_BUG_ON(pgd_level != vcpu->kvm->arch.mirror_root_level, vcpu->kvm))
 		return;
 
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
@@ -2765,6 +2759,7 @@ static __always_inline void tdx_set_mirror_root_level(struct kvm *kvm, int level
 	BUILD_BUG_ON(level != 4 && level != 5);
 
 	kvm->arch.mirror_root_level = level;
+	kvm->arch.gfn_direct_bits = gpa_to_gfn(BIT_ULL(level == 4 ? 47 : 51));
 }
 
 static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
@@ -2829,13 +2824,10 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	kvm_tdx->attributes = td_params->attributes;
 	kvm_tdx->xfam = td_params->xfam;
 
-	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW) {
-		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_5;
+	if (td_params->config_flags & TDX_CONFIG_FLAGS_MAX_GPAW)
 		tdx_set_mirror_root_level(kvm, 5);
-	} else {
-		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_4;
+	else
 		tdx_set_mirror_root_level(kvm, 4);
-	}
 
 	kvm_tdx->state = TD_STATE_INITIALIZED;
 out:
-- 
2.55.0.970.g62bdec98f9-goog


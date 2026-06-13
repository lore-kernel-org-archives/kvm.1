Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC9313E2C
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309055; cv=none; b=h/f1ssBzbrjtgW4hNtT7Ean5NblY7wgyzpePVM2WhgK7RdEtXNBTGfyPFcdJV5E15h2YZz+mu1tjR0bSSpjvYPw6u59W86TIVYcNf/5wKOt+KQf987O+gRPNk7phlAvlvjw13Ym7R9b8WICZpjGNHIF2AKbgIRBs1Ol4w1zFXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309055; c=relaxed/simple;
	bh=r/CUvPQw1bDBukeJEPNVu4NfPUdMQlwtchM6bXBdFJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hAvqRZogsAAnexmpV9vCbjAwud8028WHBeOReRQGbbnMPJP4Z62e8KUwsuxS9FmOIe2LvbZ9WiZKcNyl9ZEc30u7dQhtmW+WsHJwXxsc7Q5ilpXf5ynNlmgCd5amPMD5mElkaEkCraMzYnZFS0inVUUL6CYV0irgg8No2xh7kAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPrz0G5a; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPrz0G5a"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85807671b1so713187a12.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309054; x=1781913854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5qk90ZLUAsDV96UxpApZQqGWZybXQHM3SqyJ+FX+ABU=;
        b=TPrz0G5aIfqpflwONIRSRGKJSbNPsGsxtgG3I+VZnkriWE8czsy8zCJh+cWfzBSWF/
         nquDg/qqlXPVJa2zeyBVpYMAJo4/ajLyQo6UHnURjSYxmrWvN/UiWT5+/kgPa0qA/pIN
         ehudbkvNQKcdKANvo8I+ahd+z8vlCrQ0QZLK6uJfRjRS2pZXMrQy/6l+aFBI0jL01/lM
         SyZXSIHxum65UGKYhM0s3+/DkAThQQUXbE6Ifw2Ypp63CvJAIU/rn+Bi7BIJqP9KIm2/
         yRcS/zqlFKg1My5yOEEtuDaHNTno44mPY9UB16HOIKw8L/CfuoWwW4WrLs/ZM9RVn5pK
         22Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309054; x=1781913854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qk90ZLUAsDV96UxpApZQqGWZybXQHM3SqyJ+FX+ABU=;
        b=jJIFDb+ObVL+F9ZKTzGYtoBdIdCEZgFiZsNPykSJAmaGsSAOdkUEC5A6ovcZ9FrveS
         gW8Nv9XzEALMbQUG86jKd2SA8Auro6N6qI6HPqHmwNXLhgCBwdFmmfG2hXZOsuYO2a1W
         N7tmmbvnjbh3KraopGvhL+b0D06YhnaSVevfcg4rzsxhpNWLmSKFTIUy7kvu5BX8Dyiy
         acn5Uf6rfZLai6BrIR81abgAlGppNE5dgw/dMtC5a31snrN0vqzFd4cI8L0QgOgXJdhb
         F8Uhg6CnlJu9j2D7+dPRi8ProToSQ+DTdQ0LZZ+LUZcBs8W7LzOXktAeV/6C0I6PEUnm
         JzFQ==
X-Gm-Message-State: AOJu0YwMeV/phFl2SVYQ8f6KTSuXVYV5abodghDA0idC8kU6IDaRsHxQ
	EHhhRE5XgZ6ZOHsTvvfqlU4rYBivoy8I28jed7IiNVNHiwdyDw7vF9KhJWLZhQ6n3DAOLiMhhLC
	4wQTJrg==
X-Received: from pgbcq8.prod.google.com ([2002:a05:6a02:4088:b0:c80:dc0a:9f7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:618d:b0:398:9b42:69f7
 with SMTP id adf61e73a8af0-3b784033bb3mr6261121637.39.1781309053962; Fri, 12
 Jun 2026 17:04:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:27 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-29-seanjc@google.com>
Subject: [PATCH v4 28/30] KVM: x86/mmu: Move kvm_arch_async_page_ready() below kvm_tdp_page_fault()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the implementation of kvm_arch_async_page_ready() "down" in mmu.c so
that it lives below kvm_tdp_page_fault().  This will allow moving
kvm_mmu_do_page_fault() into mmu.c without needing a forward declaration.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 313106e84a64..bc844ca9e01f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4571,37 +4571,6 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
 				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
 }
 
-void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
-{
-	int r;
-
-	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
-		return;
-
-	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
-	      work->wakeup_all)
-		return;
-
-	r = kvm_mmu_reload(vcpu);
-	if (unlikely(r))
-		return;
-
-	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
-		return;
-
-	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
-				  true, NULL, NULL);
-
-	/*
-	 * Account fixed page faults, otherwise they'll never be counted, but
-	 * ignore stats for all other return times.  Page-ready "faults" aren't
-	 * truly spurious and never trigger emulation
-	 */
-	if (r == RET_PF_FIXED)
-		vcpu->stat.pf_fixed++;
-}
-
 static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 				      struct kvm_page_fault *fault, int r)
 {
@@ -5058,6 +5027,37 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	return min(range->size, end - range->gpa);
 }
 
+void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
+{
+	int r;
+
+	if (WARN_ON_ONCE(work->arch.error_code & PFERR_PRIVATE_ACCESS))
+		return;
+
+	if ((vcpu->arch.mmu->root_role.direct != work->arch.direct_map) ||
+	      work->wakeup_all)
+		return;
+
+	r = kvm_mmu_reload(vcpu);
+	if (unlikely(r))
+		return;
+
+	if (!vcpu->arch.mmu->root_role.direct &&
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
+		return;
+
+	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
+				  true, NULL, NULL);
+
+	/*
+	 * Account fixed page faults, otherwise they'll never be counted, but
+	 * ignore stats for all other return times.  Page-ready "faults" aren't
+	 * truly spurious and never trigger emulation
+	 */
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
+}
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 static void kvm_assert_gmem_invalidate_lock_held(struct kvm_memory_slot *slot)
 {
-- 
2.54.0.1136.gdb2ca164c4-goog


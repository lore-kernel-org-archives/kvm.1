Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC72F6188
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854087; cv=none; b=AQqgGyuD3UiAkdlW/fk84dcPe4BwXKlLkghlB6o6eZ95M1qWL0qUNIsiL4WxqMuM2dXde6tcsuGS6h8NaXa98sCEnLoxnL+rFrTYDH/2GWDzQq5OpORpbnnyCszw3NueSajTr+2cBqTUKs5p91iAzaBe2sPNgpylrIGTjCcNUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854087; c=relaxed/simple;
	bh=KqdXVd09tHO6MxPI+hf6b4RatXWpu869ZuWrzl3QiuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsRDfuAL1TV26ZLmsW/up8V3LOtYuMVS52j6LUOhPVKSvldWt9fQz5Axbf7zSGxMjqxLnaqmg0Ew6nm11KYD5NGFF65mYbYp/U6W+n+sQI0iNsSqultvqVpSMnKwFKWNjJAjAs7KoNZ2xEP035yfCJY/vZ7xTHSoyUxTfVtYJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmhCXFIS; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmhCXFIS"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so2213629a12.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854084; x=1785458884; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Alx5+6ajemwcdZLjQENBxyMOBgE6MWN8o6tlzzoEhF8=;
        b=CmhCXFISOwLqQb+eLKbL4dVrWuacYFUD9c9M08yIarR9xCGt5SBT2tdXdFrr/kbGeo
         0p1JLXOAPLnkquWXuZDckECrXf1SBbxn3L/8b5YXatyMWlpciN0pR2b2nJNErlZf48WQ
         Cn4sZRjrenIWPZsGSa3vcktxV0/+lgocOjTPgomKmjUkWSouhKly4mtU8O4jrJAi1mv3
         cAYKEq38Q/veQAP7KchS7Ay/d+nWBIsvsrksJu89gwgTMsmk49lVNg5LMeN6mr1lgmGm
         VLDpRzgr0YE1uY5cpLR9toYpL708Z2F5GvSkwtXQICafKjLbQiXE/Ru+Q/Z/bG/TLb5/
         66Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854084; x=1785458884;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Alx5+6ajemwcdZLjQENBxyMOBgE6MWN8o6tlzzoEhF8=;
        b=jtd0CywnZ8z7MBdbljiQhCQZmRiwRuQZTmgP8ow4DpJS19k3IjN0ssbhv/CpUU+3z2
         qS7zIP6g+6Pq4iGhOlFOf+abi5TJ66kgqtHm7tYoXz9Jwx8C523nhUNkYMO/hRVjKjjP
         Xq3QJ8JIj9WcE6ZNVdeo+UvhhKtZ2z+7DFei/xg5Kdwj3gpd8YjEjTycdDCEXrfGusbc
         30ftShcyEx8Ti3jWJLwJKRJPYvCmkneUWqwBInsW0N1Y+3/sG6Eo6TOqJcgs3az056OE
         WBNoeYRLeNuJtvqbNDKtkWSt7Z7EX56iYrsCflpxpcBPuX1arE5mNxTG29L1RkIDiAYb
         wQ2w==
X-Forwarded-Encrypted: i=1; AHgh+RoUgsKrVm2yWarU3H2q26NpZOmDaolEfZPcdc0NEKcInKb9Nh5zO1wM+5ZzzQNDbC80TTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXOrxHTCzbcRZ+7KtChcwxrV2uiycwQP7XY/ORRzwsLuVctq/
	19cZEXjMrwVaXcFRpMIH5k1Gi/FWMc3MA66tiOzna1GkSqT3Z9LjI49VeT/dozj4GRlOPabHYKa
	HvhIUTQ==
X-Received: from pgbee3.prod.google.com ([2002:a05:6a02:4583:b0:c99:d21a:f6b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e292:b0:3c3:b226:f165
 with SMTP id adf61e73a8af0-3c44b18d6cbmr6214167637.35.1784854084080; Thu, 23
 Jul 2026 17:48:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:54 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-4-seanjc@google.com>
Subject: [PATCH 3/6] KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Convert the kvm_vcpu_map() usage in the enter/leave SMM flows to the new
CLASS(kvm_vcpu_map_local) implementations, to eliminate the need to
manually do unmap() in error paths, and more importantly to eliminate more
of the open-coded on-stack "struct kvm_host_map" declarations.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bf10483c0e8a..7a417e717fd9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4987,7 +4987,6 @@ static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_host_map map_save;
 
 	if (!is_guest_mode(vcpu))
 		return 0;
@@ -5021,24 +5020,20 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	 * that, see svm_prepare_switch_to_guest()) which must be
 	 * preserved.
 	 */
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save))
+	CLASS(kvm_vcpu_map_local, m_save)(vcpu, gpa_to_gfn(svm->nested.hsave_msr));
+	if (m_save.ret)
 		return 1;
 
 	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
 
-	svm_copy_vmrun_state(map_save.hva + 0x400,
-			     &svm->vmcb01.ptr->save);
-
-	kvm_vcpu_unmap(vcpu, &map_save);
+	svm_copy_vmrun_state(m_save.map.hva + 0x400, &svm->vmcb01.ptr->save);
 	return 0;
 }
 
 static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_host_map map, map_save;
 	struct vmcb *vmcb12;
-	int ret;
 
 	const struct kvm_smram_state_64 *smram64 = &smram->smram64;
 
@@ -5055,22 +5050,23 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (!(smram64->efer & EFER_SVME))
 		return 1;
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa), &map))
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa));
+	if (m.ret)
 		return 1;
 
-	ret = 1;
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.hsave_msr), &map_save))
-		goto unmap_map;
+	CLASS(kvm_vcpu_map_local, m_save)(vcpu, gpa_to_gfn(svm->nested.hsave_msr));
+	if (m_save.ret)
+		return 1;
 
 	if (svm_allocate_nested(svm))
-		goto unmap_save;
+		return 1;
 
 	/*
 	 * Restore L1 host state from L1 HSAVE area as VMCB01 was
 	 * used during SMM (see svm_enter_smm())
 	 */
 
-	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
+	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, m_save.map.hva + 0x400);
 
 	/*
 	 * Enter the nested guest now
@@ -5078,24 +5074,18 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 
 	vmcb_mark_all_dirty(svm->vmcb01.ptr);
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
 	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
-		goto unmap_save;
+		return 1;
 
 	if (enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, false) != 0)
-		goto unmap_save;
+		return 1;
 
-	ret = 0;
 	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
-
-unmap_save:
-	kvm_vcpu_unmap(vcpu, &map_save);
-unmap_map:
-	kvm_vcpu_unmap(vcpu, &map);
-	return ret;
+	return 0;
 }
 
 static void svm_enable_smi_window(struct kvm_vcpu *vcpu)
-- 
2.55.0.229.g6434b31f56-goog


Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C82ECD3A
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854085; cv=none; b=SoQOWZ4jDz2YSQpDtmUvOxlMCdsxxOjouJ4znvHo6AMAuALhky4+LxX8cJV9E7S+a242QY69wICJOGus3AVh43Py9FLPBs1hlKHfDZtZfhJgYDCmhT3dWurCzMrx80S8NDy74fjq1wqx8/FzTeaI0veSLQthTjy+W2gxq/ICD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854085; c=relaxed/simple;
	bh=FUCfYbsz9ZyIbrv4tJzgA6QFVNOzaEU/1cTSyaAlIJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYgwHmifXS8egElO9O69Lh4gGssLLGmj3Sn+pPxJzHnLZ/4zZhL4mFcwzJcjuKzv9R4/+8kmQ/yXGZDhGpb/M7KvrdrVgpjNmrTAsCxvwYqgELKbMDrqgpSBK8eKiHfN2gDfJdjNqDLBo6z4Lmu8i+VrrAwIsFAHJ/SOjj0zK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0w3arNu; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0w3arNu"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2caf4173b1cso24706045ad.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854083; x=1785458883; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5hCTXU5J5OKjCYOs510ZpnLddxhpdmEInNm/3mj3vgs=;
        b=N0w3arNu1g1YWrBJHPqgEwHOMELtvrMZl5B3pLAig3HOwGp5StaGi/q/SQafwEHuQe
         f4xoHnUPsYqbEo3rFZx/N1KP+wFUYWLz+lGNjnW1b23m/DkiZsSoooFr6k22jRBUP9iV
         l7wPz/N3pGMsZ9hDVDjG2SbaiL2GA0q6ZbZ8YBGUXO2vmlTDld+kch1PuU+X3nbXYOHA
         U/KipJCw1PEsDT/SsvVNkLzDUCUzMVa5TWvqioq9OnNbxXnj0IaKwB8wdmUtpUNNGkWu
         tJMLYLLsJrRXc6NYdq0tHdH0kxSjLvjATwRwEEwBJqfseW+9dM8V0kSaeHwkys2ktMCW
         TFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854083; x=1785458883;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hCTXU5J5OKjCYOs510ZpnLddxhpdmEInNm/3mj3vgs=;
        b=gW0zNSvnJm89rYeYjyiQ9mSc8g5bGryhJu5Xx6ZvIo4kc2ovRlAH/qCCg7q+GRLC+f
         e7TCscYAkAEDc23o/+R5Q8vVaIiyiAb5aioov8qc5ZvngSf4tlkhhgNsMoKTUTHVkBJD
         WWryyJ4QRp1ehG0PljzGRvBlB9xQipkYctJe5+fWXfX4xm18VMMj98u3NXmNuR07QSdg
         SqaG0d9Q7aEKPjhsOEomq631CYP070sAtVdfImaaiMStaAPeJ8jJRgG0rFaTlcUwkJdE
         VQUTZLt2cU7Hc0AyXhlBMgqQoZyPA/iKs5/9bXIUsqLzt39AkMXlzUlUTGf5KhEYbGYw
         U21Q==
X-Forwarded-Encrypted: i=1; AHgh+RqT22YVQkgHHAT0n6UmcnqkZJkvFOGhfO4ebuCgk0XMw+90Slq+bniWba14Mwu9FCIsBqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLpocPoYfaqWhkOYTmNfaXujpIOBXG70paoANrKDLHs5uQ+7x
	IzsdDPVn5m8ASp6XQKzI3DU/74RSDfzKZRY+217HXfbe/SCI4a5lVe2dAE8Bvbe07Dw4FeZ+zMq
	GqjrQAg==
X-Received: from pgbct6.prod.google.com ([2002:a05:6a02:2106:b0:cb5:f989:9b3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6494:b0:3b7:aefe:4367
 with SMTP id adf61e73a8af0-3c44b051466mr6208250637.33.1784854082942; Thu, 23
 Jul 2026 17:48:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:53 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-3-seanjc@google.com>
Subject: [PATCH 2/6] KVM: nSVM: Add CLASS()es for automagically handling local
 kvm_vcpu_map() usage
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add CLASS() definitions for locally mapping a PFN using kvm_vcpu_map()
given a vCPU+gfn pair.  In addition to eliminating the need to manually
do unmap(), e.g. in error paths, this will allow hardening KVM against
double-mapping without having to manually ensure every on-stack declaration
is zero-initialized.

Use "map local" as the primary terminology as the basic concept is more or
less the same as kmap_local(): ensure the current context has a kernel
mapping to the underlying memory.

Immediately convert the relatively straightforward nested SVM flows, and
defer converting the more involved SMM flows to a separate change.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 18 +++++++-----------
 arch/x86/kvm/svm/svm.c    |  8 +++-----
 include/linux/kvm_host.h  | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5e3e280cd483..73f37b050d0a 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1086,14 +1086,14 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_host_map map;
 	struct vmcb *vmcb12;
 	int r = 0;
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(vmcb12_gpa));
+	if (m.ret)
 		return -EFAULT;
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
@@ -1107,7 +1107,6 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
 		r = -EINVAL;
 	}
 
-	kvm_vcpu_unmap(vcpu, &map);
 	return r;
 }
 
@@ -1251,15 +1250,13 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
-	struct kvm_host_map map;
 	struct vmcb *vmcb12;
-	int rc;
 
-	rc = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map);
-	if (rc)
-		return rc;
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa));
+	if (m.ret)
+		return m.ret;
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 
 	vmcb12->save.es     = vmcb02->save.es;
 	vmcb12->save.cs     = vmcb02->save.cs;
@@ -1314,7 +1311,6 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 				       vmcb12->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
-	kvm_vcpu_unmap(vcpu, &map);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91286d46d13a..bf10483c0e8a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2216,7 +2216,6 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 	u64 vmcb12_gpa = kvm_rax_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
-	struct kvm_host_map map;
 	int ret;
 
 	if (nested_svm_check_permissions(vcpu))
@@ -2227,10 +2226,11 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		return 1;
 	}
 
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(vmcb12_gpa));
+	if (m.ret)
 		return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
-	vmcb12 = map.hva;
+	vmcb12 = m.map.hva;
 
 	ret = kvm_skip_emulated_instruction(vcpu);
 
@@ -2243,8 +2243,6 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		svm_copy_vmloadsave_state(vmcb12, svm->vmcb01.ptr);
 	}
 
-	kvm_vcpu_unmap(vcpu, &map);
-
 	return ret;
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9db6eb4023c4..c54dbfdbc346 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1420,6 +1420,25 @@ static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
 }
 
+typedef struct {
+	struct kvm_vcpu *vcpu;
+	struct kvm_host_map map;
+	int ret;
+} kvm_vcpu_local_map_t;
+
+#define DEFINE_VCPU_MAP_CLASS(ro)					\
+DEFINE_CLASS(kvm_vcpu_map_local##ro, kvm_vcpu_local_map_t,		\
+	     if (!_T.ret) kvm_vcpu_unmap(_T.vcpu, &_T.map),		\
+	     ({								\
+		kvm_vcpu_local_map_t m = { .vcpu = vcpu };		\
+									\
+		m.ret = kvm_vcpu_map##ro(vcpu, gfn, &m.map);		\
+									\
+		m;							\
+	     }), struct kvm_vcpu *vcpu, gfn_t gfn);
+DEFINE_VCPU_MAP_CLASS();
+DEFINE_VCPU_MAP_CLASS(_readonly);
+
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn);
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable);
 int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data, int offset,
-- 
2.55.0.229.g6434b31f56-goog


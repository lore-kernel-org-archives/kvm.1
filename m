Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8133B945
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858381; cv=none; b=OWXn9xpQEo9QSe33fPSa18pmLX1WcoBFaJSU7acRC5YyTl1S6AOJUE/xKtX+svR1+L2Xtfhbz4g1DWybOIo2eSY0TYCwf3LXSmOwJRnuBz4+q2pE/bolQX6rai5uvL1Mf4+IiVLvSMZD0tdAk5EmB2mvB83lmBrTtImaNwAaA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858381; c=relaxed/simple;
	bh=+5x/gZYgDX9Id5/FW01iE47gRpQ3ZoZYUlfRa6A5Bok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gI3FQkWl8N/I6V6XwO2Kd0/lWpGeOZ8JVrwjCxBviiSGJF1K/BJUXkdcdJ8UhE9TkDoP5hoVQzKaie0u4bqaLaok1JjSn/Kj6c4bOqFfKS1SHma2rN8kwfMyN3t0ocxpYV9QkhVvvL0p52l/IRZ52H76/iu47zW83CR3SxIak+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xji/qy6a; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xji/qy6a"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845df469a26so91297b3a.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858378; x=1783463178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Otm9wLBQIuFX//qUFsPztN/wAvyyH1/6HpJNM8Zumtk=;
        b=Xji/qy6aSRftKgG/V9dbCpC5vY36SNKW8L38LOuwAxCnEI0MvQ2RDTlAKGf20PlUk7
         EdrKgj0D3o9eMYFO4DyohPTh9/hAkjcMgaYJAunQY/VOJ6ifZsk8WogMKOnJ8wksEoFq
         aN71reUqj3WbW3QZg+TUNkOzYe62sgRJ9EuoxHmH4DacPjkWnPXL0+6GQTg5WEP9k1k/
         d1OCjnZAf4KAHLvoS8QvakJLDjH86nAqaufjRghQS53SfclZCUv2bIr4PDA+RdowK4bb
         OrrY0mv5+65R0KPZXlFkYa4JhQ4m8CG0Rs4tIt5CVLxjWEq6vdLOMsNK2xftVpHxk/3d
         M3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858378; x=1783463178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Otm9wLBQIuFX//qUFsPztN/wAvyyH1/6HpJNM8Zumtk=;
        b=SUZhUx6u3B/d19OFPKsHCjhjPqy+TlyW6t6IOxOJZlc2gP8tmqoOEjnUAPJ0auW2lM
         O8y8+ihJFvbSNKAqS/qDk58PTtI8p9IJrmt8Zn3fxGA6riX19b7j6OuVeSdXr5tXq3oN
         pg2irETQOs4/YxgC0SFlIZgWm/E+ZQs+dEXE9XOsnab/lTmN98AFTkWW+LzfoAB1F8nv
         nZrUBtU8QbHtPZbfzz/IkISTz3QS5ioir4mxCicd7nAjb8PXsoYTezOVwX4p9eFeHYN/
         +6ZLujqTVOajwWSOQq3w3eWSmkhNrcHnv/xjxHpwp5H6Fvyv7aR0pTPI9fGddRqDDio6
         Wzkw==
X-Gm-Message-State: AOJu0YzkkWgpXxniXDsd+nRlmPYRiJlCZOx/97msCXUV4+ZSe+my4zRu
	fnOKu9VLjyQzzQKoGHv8eYfZVofuO9CTRQ+Y9GQC/nlrjsP0hNyHfV12tusiuECF61fPH3DE0VM
	qdWeARA==
X-Received: from pfbbv13.prod.google.com ([2002:a05:6a00:414d:b0:847:82b3:aca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94c3:b0:847:77e7:6f64
 with SMTP id d2e1a72fcca58-8479eef4456mr4502380b3a.20.1782858377707; Tue, 30
 Jun 2026 15:26:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:03 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-9-seanjc@google.com>
Subject: [PATCH v3 08/12] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into
 "front" and "back" halves
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Split kvm_mmu_zap_all_fast() into a "front half" and a "back half", where
the front half is everything that runs with mmu_lock held for write, and
the back half is the code that runs outside of mmu_lock.  This will allow
putting more code inside kvm_arch_flush_shadow_memslot()'s critical section
without having to take mmu_lock twice in quick succession.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 223d80b12b9b..a5c2a560a88a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6921,20 +6921,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
 }
 
-/*
- * Fast invalidate all shadow pages and use lock-break technique
- * to zap obsolete pages.
- *
- * It's required when memslot is being deleted or VM is being
- * destroyed, in these cases, we should ensure that KVM MMU does
- * not use any resource of the being-deleted slot or all slots
- * after calling the function.
- */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+static void __kvm_mmu_zap_all_fast_front_half(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	write_lock(&kvm->mmu_lock);
 	trace_kvm_mmu_zap_all_fast(kvm);
 
 	/*
@@ -6971,8 +6962,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
 
 	kvm_zap_obsolete_pages(kvm);
+}
 
-	write_unlock(&kvm->mmu_lock);
+static void __kvm_mmu_zap_all_fast_back_half(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_not_held(&kvm->mmu_lock);
 
 	/*
 	 * Zap the invalidated TDP MMU roots, all SPTEs must be dropped before
@@ -6986,6 +6981,24 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
 }
 
+/*
+ * Fast invalidate all shadow pages and use lock-break technique
+ * to zap obsolete pages.
+ *
+ * It's required when memslot is being deleted or VM is being
+ * destroyed, in these cases, we should ensure that KVM MMU does
+ * not use any resource of the being-deleted slot or all slots
+ * after calling the function.
+ */
+static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+{
+	write_lock(&kvm->mmu_lock);
+	__kvm_mmu_zap_all_fast_front_half(kvm);
+	write_unlock(&kvm->mmu_lock);
+
+	__kvm_mmu_zap_all_fast_back_half(kvm);
+}
+
 int kvm_mmu_init_vm(struct kvm *kvm)
 {
 	int r, i;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


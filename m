Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30737F8C7
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515670; cv=none; b=Sw9K7hhVxHJHK6xdOSzznnt+c7v0fvjC6T12WT6e/884gae9CGp8KyG3v5U3lFOrcntmZQ1ww8+q0iDyJ5s4oumQN+tkGlHqiyNfP8J0GA5bbk1/smZ8KUpHKR6WMynF9CTUVsDM+SAQvpOVL7URHjpho5HmOoio94U/CJgOJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515670; c=relaxed/simple;
	bh=M+ns7hIsjvqgw42ToErJ/i81C5vsomZl7iRsyhMGNzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HwS8evAafBTNBPvBP/7pyWxmoJilGTX8jlb38AJVT218eywnsvpk4dJm+Tk88UsT4ob1VHJ4Ieyyh+jAffEDiohqdCJ/ocvA9MSX8wS3wXCH+8YFmer0IImWA0hPryfT90zUvrMwhIVdl3q30tuCju1QPWxdOjJRw7PhNF3Wkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA6SgSh4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA6SgSh4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37df6354960so1066369a91.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515666; x=1783120466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CckMd+ZBZTPBjpcDx+h5yQ8CEqxWh1RxSUyuEWlO4OY=;
        b=vA6SgSh47OrWmPM487Qw8UnDN8s1+7eRejZamrbWNUmX0nype2flWC87jfu+o+BvSV
         t37CnM//xK8monNfy1SNohDCnlMO59BD16HrMbvVa1nQoGGdEepPAXTdIDt8IndSlLcO
         OJ5urF19LfDlRCgsVqZki6smW9xnUsJNtw8BS2krOTLRMwVfsLG2HHVRyWmQ3EPWO0xO
         TmF+zS4vBg7DkF1g+ne/UndLN2DGPGmtqYHCrDJmpGz+ttjkJqfKDwHMa3+JQS9j6066
         A4QldNeJiUxgaEH6kQiNFWIABrEkigrHH/bPDvZZPYsuMnyI9diX6+74DPMNfmO0LMx/
         s4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515666; x=1783120466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CckMd+ZBZTPBjpcDx+h5yQ8CEqxWh1RxSUyuEWlO4OY=;
        b=jsKjLAeVFPAEOdW1eoVy9pf3Uw5xzNlqrwnhQSvsoaKMz7w/1EwhNVAWTmt/KJ3hWs
         FYuGZoTEbQlMahkxUGsJ/IbYl/l5RjmTvT8P1raPqs2aACJKmuI32fmYyt8NunWQFA4e
         qGfXSdE3WeNc/em1mB3cq/QU+O1h+DSuulhE6mypM9eeXGgnKtolDzIsrrbn9qH4GpXS
         iPZJXzY2hlsMdU7p9xI26dX7+9OE/c4rYhvHC1yvgA84DrLYD5eF+aqb7b3swP21QRNH
         gjuyrpGuICv/TBrAzc63BhlGiP0KT7uTdcRwJV5ioORq2+VHuUN+7tUxB/OVS2QYfWHq
         MA1Q==
X-Gm-Message-State: AOJu0YySRRgW2f7CdBPo4UnCs5K+5iOZUj3C7jEdWEHJnl0AJ8t0Wi2a
	9XxoR58vTAC+2pXRMVGYSYmNKu8qvHeQmPNNVX6Y0i3NV8+elEpMSVOfrspOR/HENvOIG39FmgR
	qP4odWQ==
X-Received: from pjvn5.prod.google.com ([2002:a17:90a:de85:b0:37d:ea95:4421])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5282:b0:368:ed26:15b2
 with SMTP id 98e67ed59e1d1-37dfa1b7ea8mr8569014a91.8.1782515665869; Fri, 26
 Jun 2026 16:14:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:13 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-7-seanjc@google.com>
Subject: [PATCH v2 6/9] KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into
 "front" and "back" halves
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Split kvm_mmu_zap_all_fast() into a "front half" and a "back half", where
the front half is everything that runs with mmu_lock held for write, and
the back half is the code that runs outside of mmu_lock.

Manually invoke the two halves when zapping in response to a memslot being
DELETE or MOVED, and share the mmu_lock critical section between the "fast
zap all" and "zap only the memslot" paths.  This will allow putting more
code inside the critical section without having to take mmu_lock twice in
quick succession.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 48 +++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 223d80b12b9b..5925db37543f 100644
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
@@ -7578,14 +7591,19 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	};
 	bool flush;
 
+	write_lock(&kvm->mmu_lock);
+
 	if (kvm_memslot_flush_zap_all(kvm)) {
-		kvm_mmu_zap_all_fast(kvm);
+		__kvm_mmu_zap_all_fast_front_half(kvm);
 	} else {
-		write_lock(&kvm->mmu_lock);
 		flush = kvm_unmap_gfn_range(kvm, &range);
 		kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-		write_unlock(&kvm->mmu_lock);
 	}
+
+	write_unlock(&kvm->mmu_lock);
+
+	if (kvm_memslot_flush_zap_all(kvm))
+		__kvm_mmu_zap_all_fast_back_half(kvm);
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


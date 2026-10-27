Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139137;
	b=ixU/pgnMfOFT9BlmQl9oluid0vCvN4CvgTDQzIMwerhTgeqLpXtIeFX1Ddtf+V0626bH
	 dpK7Ug6QBWY8Epevu6N7tMraSGa2xMtf73noWuGsqT1EPH3w6na6rUDNMWkDFGJbfoMne
	 wfR4vswyFTTSh4JRvHLp4rc/pXLOaA6ojJj82aZHA/PUdqP65UtWN2N/Wk4OMV4AnmzU0
	 fAADHqrau0LYncJftvKDcNrO5v/gM+N/weIK89EC8+WGbgtJAnobpPyP20SWNV5Qco0q2
	 0k84HSMVYa2Ts/oPsGY0PUZDU3SwMc53yysFude12W+R7NKJl7AwXqMz5BUQSozRkXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=iREv2BM/TPI3Cz0K2O/45W+Zzwpa9oFsTUQAe4Z7CDw=;
	b=gTgcUFXeWhMAj6aKt424AsIFhwswEsvw7i8C1lPWQHRFhha1SvoAgy/Ij/IzmB8Ed1fZ
	 OOtNq03lBFe3TWtqe9bNWbcQNa9GBbdZ0KILfsRUqM6jnU4Fel1Ow0jfI/1W0erb7hVMz
	 Ua5nj74MRfnVH58o6BvLkiakmqcPs9zLsMb7aRsbzeUS8pISRDI7xQW2b3TTVhJDFj6N8
	 Y2WSFOzJ1ogORgCV7yYAaxut9HM5ZnOQ2MMIGuew+aX+4onz8pDE8+j1EUgQJ5FtUJH0K
	 pjlPn7dhZmYXb0SP7qV28On1x9Pe2KfhhFQRMQJFVb884pf6wl4+v7i2Rj0vs+LnnFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z1qDMisF;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA4606A337
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16FA4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z1qDMisF
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd6969473a4so207185a12.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139136; x=1793743936; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iREv2BM/TPI3Cz0K2O/45W+Zzwpa9oFsTUQAe4Z7CDw=;
        b=Z1qDMisFTFzIZ8urBte5TB3QFxLOPumQSIr9La+hazSbkLpVDDksZSGTNpD5uHf5OC
         Y+SGtBqAkwPyciv9geVijXg37k+avVQhxyGWDZRQyVAYF9qMHP8mpymOAQJ5pR6ZTZQn
         xrQIbsgyYHjwsMJvOiiCkJq2mlUI7WqS+4n5LvykwQ4w4pcePmMo7P9O5Ce5TInUR1nm
         w7MYB11Tj4hvIpRvpf0AEBocBCzZ8EN0y5vWy49+OTCFaSxWkl7Oo72xd5XCJWKhsVf2
         /ONGR9nM3bUq0lvSGqtCwgWEvuvJ8DE4dhIANUo3ZIK0KAhxsop0mXIIn6YVJ+uDHVCH
         mvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139136; x=1793743936;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iREv2BM/TPI3Cz0K2O/45W+Zzwpa9oFsTUQAe4Z7CDw=;
        b=bo9mRWNETWiJ0ULqVy3+J2oUCZL4gHlpYhr6ljERsCK+7SgkF6DkJQmxn384FMH3Qb
         ICY9WFyp0y0EtWUCXDYneBLjt594hN26ovw84DCgoKPlxRzV8AbmKkJjRYKn0+9iAkY5
         /IspmMNIO8P+52PW/W6OEQt19KN43kGiK+/GCTirsZwCDes9mWehAeaiXsM21gk6b6KD
         8w11mFXoL3WNGE6McCMNXG/kIT2JjEwzFl56T2VggWcbTNOTxsaZ72sQG6tPTZf01xTF
         TxjNpx+yF94t4MgErRAnN4yIji8YhSpiJl95pJBGz9Gl2Fy+0QFpZ2q0UB+Rio/nw5Kz
         udcw==
X-Forwarded-Encrypted: i=1; AKwUvBwmsw4OZKmWb9ijEHV2I+nmKZ02Uk8faQjvXeVK6phTDk9qKpSrij/Enl0gEEVdQ5sdAh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM6L32wdS6zhmGqLGcjIkIrVmfipNo6CtBbuMS+uXTbhaAuVmi
	CsNXX8pbzCRZUXVoZVEVvc4VZ3mFa7KPxsILn0bwFRsejpcnvKNhXgH3E6+pfJ4A2bOUNEJ7rxy
	ZrHMr/g==
X-Received: from pjnn23.prod.google.com ([2002:a17:90a:917:b0:3ae:45eb:738e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510f:b0:3ac:adce:60b5
 with SMTP id 98e67ed59e1d1-3ae580ae38emr273883a91.14.1793139136193; Tue, 27
 Oct 2026 15:12:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:57 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-5-seanjc@google.com>
Subject: [PATCH v3 04/15] KVM: x86: Unmap VMAs for KVM-internal memslots when
 the memslot is freed
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Unmap KVM-created VMAs for KVM-internal memslots when the associated
memslot is freed instead of unmapping via x86's internal API.  This will
allow deleting/freeing all memslots before kvm_arch_destroy_vm() without
leaking VMAs, and in general is a net positive as it makes it far less
likely that KVM will leak VMAs, e.g. in the unlikely scenario some other
flow deletes KVM-internal memslots without going through
__x86_set_memory_region().

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..0f3fa4571309 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10018,7 +10018,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
  * @size > 0 to install a new slot, while @size == 0 to uninstall a
  * slot.  The return code can be one of the following:
  *
- *   HVA:           on success (uninstall will return a bogus HVA)
+ *   HVA:           on success (uninstall will return a NULL HVA)
  *   -errno:        on error
  *
  * The caller should always use IS_ERR() to check the return value
@@ -10031,10 +10031,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
-	int i, r;
-	unsigned long hva, old_npages;
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 	struct kvm_memory_slot *slot;
+	unsigned long hva;
+	int i, r;
 
 	lockdep_assert_held(&kvm->slots_lock);
 
@@ -10058,8 +10058,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (!slot || !slot->npages)
 			return NULL;
 
-		old_npages = slot->npages;
-		hva = slot->userspace_addr;
+		hva = 0;
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
@@ -10075,9 +10074,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 			return ERR_PTR_USR(r);
 	}
 
-	if (!size)
-		vm_munmap(hva, old_npages * PAGE_SIZE);
-
 	return (void __user *)hva;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
@@ -10106,20 +10102,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
-	if (current->mm == kvm->mm) {
-		/*
-		 * Free memory regions allocated on behalf of userspace,
-		 * unless the memory map has changed due to process exit
-		 * or fd copying.
-		 */
-		mutex_lock(&kvm->slots_lock);
-		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-					0, 0);
-		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
-		mutex_unlock(&kvm->slots_lock);
-	}
 	if (kvm->arch.created_mediated_pmu)
 		perf_release_mediated_pmu();
 	kvm_destroy_vcpus(kvm);
@@ -10159,6 +10141,18 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	}
 
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Unmap VMAs allocated on behalf of userspace for internal memslots,
+	 * unless the memory map has changed due to process exit or fd copying.
+	 * Do the unmap only for the non-SMM slot, as the same VMA is used for
+	 * both non-SMM and SMM memslots.  Leak the mapping on failure, e.g.
+	 * if the task is killed.  Worst case scenario, the page(s) will be
+	 * reclaimed when the process exits.
+	 */
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
+	    !slot->as_id && !WARN_ON_ONCE(!slot->npages))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
-- 
2.56.0.307.g5fe7bd680c-goog


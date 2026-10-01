Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001A49C4AE
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886174; cv=none; b=Bstrn6k5UByaud92IpHmmQvnmJWE8ZsGIb7R1YD+d3YsuE3MfIWI3fWmkazJPEho07S8XxF+kdANMV6TDgrqPUtHVEFm3mnbHU4Z1Xd3dS585BpRtD2S6zZyUQzPH8qQQnVvq91rr+vwebXs5UevE4K8XarkM7MHseyzmaN3kRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886174; c=relaxed/simple;
	bh=WQb40a97ROmFqjiNKo3SgQ6E9gFV/eXSZB9E31DVrDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tNHTLJzxPOds1hMDfifMT+2MbH+q0gR9XjGqRqneq2c+f8H+UbUbNA9TNN8piejJ86LLao+xOcn8vAVAdNWqj1WEPHi9vMPE6T6q0XvRTCtpPALXxLe0PePspMLoabDN1f002Ox0Uq1mqL45iW2q/jtq7tHpqyDX4tPQnWZL1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnm2qkZw; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnm2qkZw"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8886b1d3242so902658b3a.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886165; x=1791490965; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ymfeYEmvW6bR4RRG+DI7t0UxyoSVGW7KhY3QEGj26Qs=;
        b=rnm2qkZwyBUnuFV7gtS7IXRTF7/uISYRwqSkKXhcLoDZ+XOV2elUa84mUc5ZkdOvZ1
         KvUJJCZixg7+PWuAYXrsURqlb6F2gYRkVDHckWi3NCMhnKVFelHnxHkYaMgVpMDCY+hX
         C/5bgNPm8epVKPUBFLnm7wGpU2d/6SfC0lb1WNlNki0TGNpbhnT93fbz38i2KjLJW61I
         zR+VjqVR4dYlGQwOI+YfQ3MunkiJlE3E7xSNN56cs0k8/9ECIa75s+dPfIqvj4jfQ74k
         0cq1hGnvsqmJN2eirshf5dkt+dxEJaAwyW59ANuF765oh2CaLd9cK5Zm33pUBFT2Pfnr
         GBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886165; x=1791490965;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ymfeYEmvW6bR4RRG+DI7t0UxyoSVGW7KhY3QEGj26Qs=;
        b=OYxH2GexVuPhgPT4MapsJk+9AkadeQLZ2i6FwIEqm2DtyrURkS6BC8M08zh/L5rv7+
         PNFwDPKeV7FRSjtWEHJ5C3MFe7ukoat8uNRRFIuB+t71tdlhzjuB6JTICA3RASPLSAJM
         MiuGUMut6G8WO4jh8cPn01MmRe+H/OpwrMc34VhhCghP2UauvuUXLHiZSiA7LnAFWGJ1
         z52sRs09bb0karRGIbeXvpTmlKlUSc5DV5ePiZpOifVpnzqvCu3kuGqkPO6o3AwLvgQk
         8yOYWjAnPv65AOb8aFH8CQu1PHa774yWzhFpKfDaehrczkWXBnfQ/qRyJv+2g6/4T6aZ
         F7aw==
X-Forwarded-Encrypted: i=1; AKwUvBxPERRpdrbxzlctZWFAo+78zvP8wsExMDEceOwlVUUJVYKhcalvuLgiKqD+pRqZAxGQv9E=@vger.kernel.org
X-Gm-Message-State: AFuF++nV7aMvH1e6is6hhHdXhWMwMJqhPezyFZ0hkIXf2H4kJBvBb46e
	qaG1BpFxFApXqsaHDkexhK9hdC/aHYTYy6XLa7vSQ6mmOjOvfxirs4iEswC8wOFthZ4sYco4BvU
	tsA32JA==
X-Received: from pgbfq17.prod.google.com ([2002:a05:6a02:2991:b0:cc7:9b89:2a72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a518:b0:3d3:ae40:51e5
 with SMTP id adf61e73a8af0-3e0bcf27ea4mr485150637.25.1790886165277; Thu, 01
 Oct 2026 13:22:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:27 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-4-seanjc@google.com>
Subject: [PATCH v2 03/10] KVM: x86: Unmap VMAs for KVM-internal memslots when
 the memslot is freed
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Unmap KVM-created VMAs for KVM-internal memslots when the associated
memslot is freed instead of unmapping via x86's internal API.  This will
allow deleting/freeing all memslots before kvm_arch_destroy_vm() without
leaking VMAs, and in general is a net positive as it makes it far less
likely that KVM will leak VMAs, e.g. in the unlikely scenario some other
flow deletes KVM-internal memslots without going through
__x86_set_memory_region().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..e91bd79dd3cc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9925,7 +9925,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
  * @size > 0 to install a new slot, while @size == 0 to uninstall a
  * slot.  The return code can be one of the following:
  *
- *   HVA:           on success (uninstall will return a bogus HVA)
+ *   HVA:           on success (uninstall will return a NULL HVA)
  *   -errno:        on error
  *
  * The caller should always use IS_ERR() to check the return value
@@ -9938,10 +9938,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
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
 
@@ -9965,8 +9965,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 		if (!slot || !slot->npages)
 			return NULL;
 
-		old_npages = slot->npages;
-		hva = slot->userspace_addr;
+		hva = 0;
 	}
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
@@ -9982,9 +9981,6 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 			return ERR_PTR_USR(r);
 	}
 
-	if (!size)
-		vm_munmap(hva, old_npages * PAGE_SIZE);
-
 	return (void __user *)hva;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__x86_set_memory_region);
@@ -10013,20 +10009,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 
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
@@ -10066,6 +10048,16 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	}
 
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Free memory regions allocated on behalf of userspace, unless the
+	 * memory map has changed due to process exit or fd copying.  Leak the
+	 * mapping on failure, e.g. if the task is killed, worst case scenario,
+	 * the page(s) will be reclaimed when the process exits.
+	 */
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
+	    !WARN_ON_ONCE(!slot->npages))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


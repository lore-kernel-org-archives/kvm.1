Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395282;
	b=PoyxF+gUufThPDE5mcTwcMeqi9q1mu0aikEWvWN/2XWVWfo8/ZT7a254FL+cxThREpiZ
	 QeSfusnskJ0sMIHpmuV4qFKnsYAQSnko+UUuVmBhaz7X4X+ARSpe7wteneszRrCUIiPUk
	 5s7xHgvni+buCoFvTX3x/9HbYQI8C+Sbx1HrtejkTBjHFtWY35pGeMEaE9tpK7tPGAXui
	 E6CBH9TqDQOKdm3rAKn06drDfQi/+1T2BbmHDFI0DYwX9+SwRpp+/2+XVUOZMcbzsXF2/
	 V8d7WEBXe+Zh8lKsf+RiZtfrojvXUgzuqTtdN5xBKOjgB9tdNy9CgfEwP9GAuuQBGRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=pl4Fq3eHWvdeXHKYf+p4Vk2TxeQCuXbhcaSxF66rRXw=;
	b=RIOD/FmB/26fWWQm9AxHgz8jkGhA+q3h3zR/avb677VBNojGXxU65IUhROh+AXLHsJBC
	 HJge5qrZ9Jrzu39/Mc03Cb7Fesxp/VhuAJL19ATS7jdBNpoZwSsPbTwS7rH02PUxTnO2R
	 NTnpa+GFDsVD9f6xyAdQJYaJH/dmScGylFTXe8MAME9xnWtKEioZj2FYX733pCWetC5f3
	 m+FiLKIxf/pqXPPTnvlKxSHv8WmHFoDySnmOTboqlLcWiuvPom/JkmCLRtv4VMZ4UED1A
	 2CrK258cGy+FseDKqpzmNaKUoPZeDiF8s+AGEzkK4LLjNNJWRO4nBzOBuXQ/baPzA4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyjFKqHV;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8C60A5BE8
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF8C60A5BE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyjFKqHV
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so1191643a91.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395281; x=1794000081; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pl4Fq3eHWvdeXHKYf+p4Vk2TxeQCuXbhcaSxF66rRXw=;
        b=iyjFKqHVOt2KVYBtQpy3gyJpi8TWA2iLTOJ8t4oP67PanytJ3Qnc9Ytix5sVBrBUnp
         FpxKQ5hWpGRYLvFxorDzyQWh7SfXZCtV4cr20UwaSFFvPTzoXqZSDZNKqqY0HbavQ6zO
         gVmFp/BFqe5peZNuOrnVPilrw/1RL2XkTrbDXtRkS4/zjAhsNGM36QrrCBrd9qYFoDlq
         /PwbQVEh9tpaDxUcRtPoSo3ikW3TfV29/jvvDObZLLJVSEhJlA1ptA1HY3aZc3NNE9+m
         GWnex4AMebrD1b9dn7B/mi9+OIBQHzuCy9MLqmhIWkOcQe+Cs8v3CW/MgdCtRablAy9I
         eRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395281; x=1794000081;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pl4Fq3eHWvdeXHKYf+p4Vk2TxeQCuXbhcaSxF66rRXw=;
        b=n9v3gQg0LnE0YjQmYXFBx5Qx1bCWjrXtZ1JBZQVJvFvvy+PltpDsHz3FvGC3auwc9e
         JN0T61h2eZpP+xtCIe+LmdiPBvmT0+mqgI2xt0Cz0B7fACaUah39xaT9bH4259swdF4u
         TlR1n8Ii7Bc53jyqv17IygYeOIUnTXAOVhtKDvynyE+J3EJ6NaVD5at0pYz1LoVsQGCw
         CyUcbdvEb21bpnjJT6kmnMKK5ghM3biFyV+e1R9Q2BWmFswM7Ye8YqnNAjHUVNfqA/yZ
         9ifgR3tORlBt16r1DSPwH54mom9Ps7tnvZW2+70wCm1uUSql0xxz72Q/i73ZfxxHdL1h
         SVyQ==
X-Forwarded-Encrypted: i=1; AKwUvByUjZE0P4F4GGshCQsRPGod7YwLYEXwCHatFKm+1toNHtUCHSKgVG6NrsKoq3Gi6M8ZCQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2xRctjzeyDnuE8YPEcZJEeRb9fEEzN615euiebDipOK2MDpyw
	79vkM4Q5NLwt37/HUSnETqinCZJYE8rgDMsBM29T8RBEawE4k7+GLC8+apilBiC7zRbc6ZzX+9Q
	bOHSNyQ==
X-Received: from pjzc20.prod.google.com ([2002:a17:90a:e114:b0:3a5:f1d:43a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3142:b0:3ac:403d:6239
 with SMTP id 98e67ed59e1d1-3ae897ee66dmr2448540a91.43.1793395280725; Fri, 30
 Oct 2026 14:21:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:54 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-7-seanjc@google.com>
Subject: [PATCH v4 06/23] KVM: x86: Unmap VMAs for KVM-internal memslots when
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

Free the VMA only when deleting the memslot from the "last" address space,
where "last" is the highest numbered address space.  KVM currently uses a
single VMA for both non-SMM and SMM memslots, and deletes the memslots in
ascending numerical order, i.e. deletes the SMM memslot last, if SMM is
enabled.  Freeing the VMA on the non-SMM memslot would technically regress
inhibiting the APIC access page, which is the only case where KVM deletes
an internal memslot on a live VM, as accessing the SMM memslot after the
VMA is removed would result in KVM_RUN failing with -EFAULT.

Add a TODO to call out that unmapping only the "last" memslot is a hack,
along with a hint/suggestion for how the hack can be removed.

CC: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cb8b60da5b11..489631686ba6 100644
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
 		if (!slot)
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
@@ -10159,6 +10141,19 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	}
 
 	kvm_page_track_free_memslot(slot);
+
+	/*
+	 * Unmap VMAs allocated on behalf of userspace for internal memslots,
+	 * unless the memory map has changed due to process exit or fd copying.
+	 * Leak the mapping on failure, e.g. if the task is killed.  Worst case
+	 * scenario, the page(s) will be reclaimed when the process exits.
+	 *
+	 * TODO: Allocate VMAs for each address space and drop the check on the
+	 *       as_id, which depends on freeing memslots from 0=>N-1.
+	 */
+	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
+	    slot->as_id == (kvm_arch_nr_memslot_as_ids(kvm) - 1))
+		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
 
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages)
-- 
2.56.0.385.gac671c819a-goog


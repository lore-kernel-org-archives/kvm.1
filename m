Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395276;
	b=bk7r/tut5GsUxQZz2GnsMU3Y5jLT5jKHsQRSQ1dqBHqdmpJg9NVZpI818/OVWlfhvIwI
	 Nz8kZcsp9S4K+stIpLYiS70pT+NgMCn5tv8SlLtKuiIhKV2HZdiR+g/ZZ9EjgKzhKxmDe
	 cAnQaVmP3yDy/bPoqImyFddPqZ8gQhUgco28NrDkP4CerKbwE/j/qS2ATclat1cuK3HrH
	 a5XrKIdJQnvNO0LAytJwBPykT9sli+GGlfML4xYqPwDpZFPkIdeBsvgiNi/JPiVxTVFDD
	 W/SXel8CuuNYeZwGCmbnnc9BNk6fRorCVvHqLM2t2QRIjy6eLoc4s1UfNskzEaA6Ydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=pEIWclQ1SBWM1+Z99wz5ixAlhPbNjur+F04EjDXrB30=;
	b=B79iiL7DVeWbYqJB3vYwOoSLfuMFK9qcL+bzzIRUwTjDCM6mXJrwL8n4Rz6m7elTSW0O
	 7SuXjO1xmG/AWMMhsVVyslGjdJAFwLEYoUKqlhrUrlZNWg0/AIdIufSluekZJsk+9KZnI
	 pZPeIH2ulVqcn93AY5l9jor+psT4736UHrSBYf0zp73AX8taL7O2mRf5LoU7saqfbX5d8
	 iUtAX+C2ew42+hfgMFKEp/GwCPazbYDzO90k/ZlwtUCEikVe8/Y8fmDGWVuOox0ywWgip
	 avvcuHHA3pvNGvkMOGDkxSEALIBxAMtMsjhXIHXBu1e5tUBlfrXJDsQ1hAVoF6n/AYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=apEroW3T;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847E606B780
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5847E606B780
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=apEroW3T
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e942b1cc86so12994785ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395275; x=1794000075; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pEIWclQ1SBWM1+Z99wz5ixAlhPbNjur+F04EjDXrB30=;
        b=apEroW3Tuf7Lr3cANdWj+bZxjfUo5jt7RlUvH4ZaSLxkphS+VeIk7L3nTk1m4YjYN5
         iRYhsa7L1G5RkBSyAQcGp0NLmltwQW4FGC/Ybu5AfJfrC/nbW+JIjNlyluDcgZJC6lLK
         2ionylqkfF2WfCokTZZ/mC4HX2Deb25YPDnctwP8IunxNDBe19JpXAHl7r8q7PTUVIZO
         4/g9BZ9xHEoT6kQTJpL+aifrDpQsn865TUCeQ6jEybR65gLdsAHGdKhDwqAss0Eo3h1A
         GkHGaKwLoK8RTeIViG4IG8ExbH01QcyarIaKU4QtP78xMi76Ri/k5BUPmQK2aGy3vjCd
         /Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395275; x=1794000075;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEIWclQ1SBWM1+Z99wz5ixAlhPbNjur+F04EjDXrB30=;
        b=DczO1ivHxe+jeTuwqUEVV2i62p0cIl/APLGB8JW49EJcmtW69uvCK/s8aA1x/Y0uFM
         W7A0MLB+1EbYt88EFT2co7Vo0N68gKe4cZrVuE6ZjJriz6uPWIiWz7fbo0/dkSdy15de
         vDBIPSHzSO0x1YVRjU++cn9I4w56lbd8Zm5CaSOnBp+dsWyQvrLq3uFsM4pcXYt3lA43
         I6wlZ/JGe2h08hxztMrRpTYBXFDBRZGl0o4gx4ViUCcpeEHTA32fRUQOOtVGDe+Rq+5A
         Fwbf8k9hfAEI+zK5gATXhY6uN+ElX86Pg7yRoW0wASNTDLb6DloUApsftQ2D3DG0DBNy
         wuSg==
X-Forwarded-Encrypted: i=1; AKwUvBxJkoGv1dWUphPhwxdvR9RnCKi5mWf1WL3xRcHrxrFw6HHw7hNkLRyE1LGpy0445ru5Ac0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7q+z++bXp/VCquuxqgIhFksTCTRCujRpcELt4LX2nczBafVCO
	bJ2Q+yEUPn3SdbemjhILv6bul0nm8gEvq4RWDy9wbE8iE0JfOcAgVDQi7R7ALX83UmDMy1Bu1bg
	BnOwSVA==
X-Received: from plhu11.prod.google.com ([2002:a17:903:124b:b0:2e9:fe74:4523])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50a:b0:2e2:de8e:7315
 with SMTP id d9443c01a7336-2eb364b6214mr32078575ad.38.1793395274491; Fri, 30
 Oct 2026 14:21:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:49 -0700
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
Message-ID: <20261030212112.2598640-2-seanjc@google.com>
Subject: [PATCH v4 01/23] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reject user accesses to guest memory, which are supposed to be done only
in the context of KVM_RUN or similar operations, if the current address
space is not the VM's (host userspace) address space.  If KVM writes to
guest memory after the owning host process has exited, or if the VM is
being destroyed in the context of a different process, then writing using
the wrong address space will corrupt a different process' memory.

Reject the access but don't WARN() or KVM_BUG_ON() event though attempting
to access guest memory with a mismatched address space is a blatant KVM
bug, because unfortunately KVM is buggy.  On KVM VMX, when a vCPU is
destroyed while L2 is active, KVM synthesizes a nested VM-Exit to force the
vCPU out of L2 in order to free the nested VMX assets, and a side effect of
a nested VM-Exit is that it flushes the cached shadow VMCS12 back to guest
memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

Fix the bug broadly even though the "real" bug is that KVM abuses the
nested VM-Exit flow for non-architectural purposes, as there may be other
such violations lurking.  For now, punt on fixing individual bugs and
hardening the common flows, e.g. with WARNs.

Opportunistically provide wrappers in anticipation of adding more checks
and hardening, i.e. growing the logic beyond checking current->mm.

Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit")
Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@google.com
Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/sgx.c   |  2 +-
 arch/x86/kvm/vmx/vmx.c   |  8 ++++----
 include/linux/kvm_host.h | 25 +++++++++++++++++++++++--
 virt/kvm/kvm_main.c      | 24 ++++++++++++------------
 4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 771c75a58343..52a6d0f8bb9e 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -64,7 +64,7 @@ static void sgx_handle_emulation_failure(struct kvm_vcpu *vcpu, u64 addr,
 static int sgx_read_hva(struct kvm_vcpu *vcpu, unsigned long hva, void *data,
 			unsigned int size)
 {
-	if (__copy_from_user(data, (void __user *)hva, size)) {
+	if (kvm_copy_from_user(vcpu->kvm, data, (void __user *)hva, size)) {
 		sgx_handle_emulation_failure(vcpu, hva, size);
 		return -EFAULT;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..d433cd846ac4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4021,16 +4021,16 @@ static int init_rmode_tss(struct kvm *kvm, void __user *ua)
 	int i;
 
 	for (i = 0; i < 3; i++) {
-		if (__copy_to_user(ua + PAGE_SIZE * i, zero_page, PAGE_SIZE))
+		if (kvm_copy_to_user(kvm, ua + PAGE_SIZE * i, zero_page, PAGE_SIZE))
 			return -EFAULT;
 	}
 
 	data = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
-	if (__copy_to_user(ua + TSS_IOPB_BASE_OFFSET, &data, sizeof(u16)))
+	if (kvm_copy_to_user(kvm, ua + TSS_IOPB_BASE_OFFSET, &data, sizeof(u16)))
 		return -EFAULT;
 
 	data = ~0;
-	if (__copy_to_user(ua + RMODE_TSS_SIZE - 1, &data, sizeof(u8)))
+	if (kvm_copy_to_user(kvm, ua + RMODE_TSS_SIZE - 1, &data, sizeof(u8)))
 		return -EFAULT;
 
 	return 0;
@@ -4065,7 +4065,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	for (i = 0; i < (PAGE_SIZE / sizeof(tmp)); i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
-		if (__copy_to_user(uaddr + i * sizeof(tmp), &tmp, sizeof(tmp))) {
+		if (kvm_copy_to_user(kvm, uaddr + i * sizeof(tmp), &tmp, sizeof(tmp))) {
 			r = -EFAULT;
 			goto out;
 		}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..be27b4e8f12d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1353,13 +1353,34 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 
+static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
+{
+	return current->mm == kvm->mm;
+}
+
+#define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
+static __always_inline __must_check unsigned long kvm_##fn(struct kvm *kvm,		\
+							   void to_user *to,		\
+							   const void from_user *from,	\
+							   unsigned long n)		\
+{											\
+	if (!kvm_can_do_uaccess(kvm))							\
+		return n;								\
+											\
+	return __##fn(to, from, n);							\
+}
+BUILD_KVM_COPY_USER_WRAPPER(copy_from_user, , __user)
+BUILD_KVM_COPY_USER_WRAPPER(copy_from_user_inatomic, , __user)
+BUILD_KVM_COPY_USER_WRAPPER(copy_to_user, __user, )
+BUILD_KVM_COPY_USER_WRAPPER(copy_to_user_inatomic, __user, )
+
 #define __kvm_get_guest(kvm, gfn, offset, v)				\
 ({									\
 	unsigned long __addr = gfn_to_hva(kvm, gfn);			\
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) && kvm_can_do_uaccess(kvm))	\
 		__ret = get_user(v, __uaddr);				\
 	__ret;								\
 })
@@ -1379,7 +1400,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) && kvm_can_do_uaccess(kvm))	\
 		__ret = put_user(v, __uaddr);				\
 	if (!__ret)							\
 		mark_page_dirty(kvm, gfn);				\
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..218456372b11 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3279,8 +3279,8 @@ static int next_segment(unsigned long len, int offset)
 }
 
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
-static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
-				 void *data, int offset, int len)
+static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+				 gfn_t gfn, void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
@@ -3291,7 +3291,7 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-	r = __copy_from_user(data, (void __user *)addr + offset, len);
+	r = kvm_copy_from_user(kvm, data, (void __user *)addr + offset, len);
 	if (r)
 		return -EFAULT;
 	return 0;
@@ -3302,7 +3302,7 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3311,7 +3311,7 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3355,8 +3355,8 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest);
 
-static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
-			           void *data, int offset, unsigned long len)
+static int __kvm_read_guest_atomic(struct kvm *kvm, struct kvm_memory_slot *slot,
+				   gfn_t gfn, void *data, int offset, unsigned long len)
 {
 	int r;
 	unsigned long addr;
@@ -3368,7 +3368,7 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 	pagefault_disable();
-	r = __copy_from_user_inatomic(data, (void __user *)addr + offset, len);
+	r = kvm_copy_from_user_inatomic(kvm, data, (void __user *)addr + offset, len);
 	pagefault_enable();
 	if (r)
 		return -EFAULT;
@@ -3382,7 +3382,7 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
@@ -3400,7 +3400,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-	r = __copy_to_user((void __user *)addr + offset, data, len);
+	r = kvm_copy_to_user(kvm, (void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(kvm, memslot, gfn);
@@ -3538,7 +3538,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (unlikely(!ghc->memslot))
 		return kvm_write_guest(kvm, gpa, data, len);
 
-	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
+	r = kvm_copy_to_user(kvm, (void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
@@ -3576,7 +3576,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (unlikely(!ghc->memslot))
 		return kvm_read_guest(kvm, gpa, data, len);
 
-	r = __copy_from_user(data, (void __user *)ghc->hva + offset, len);
+	r = kvm_copy_from_user(kvm, data, (void __user *)ghc->hva + offset, len);
 	if (r)
 		return -EFAULT;
 
-- 
2.56.0.385.gac671c819a-goog


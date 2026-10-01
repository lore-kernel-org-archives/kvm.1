Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE425531637
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886182; cv=none; b=kcTcEL5BrljoDyoVFIvb6aMQNb7tpuDgrTXEzKNzdBTOP5YmwalAIeLITpAmk8sx47sW3vgSHHpwX1GvhJSoAIt+8byTIvD3ZFATf9uuBH3LerW+v6LZ9Ygz94ILo2dTKSbh5KzXgTOjpoqxxbEpZqbpCJVlrs+hxjeU4lNz1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886182; c=relaxed/simple;
	bh=+VDFAG0x7HAzyXh6Wu1LFR5vBAYK86JEtoNvO5xLXbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kfkf12j5JOhVlF8veeYKDtL90FyjD+NxS1nLwNHYYHrkH3t7dUX4KHRFAojtr7xNGvZuBYlGYqiRjSszhucsUIe9fipEWdQAlMbCADGbunAlPAabJKU+juaqIagn9qYdYhaCN0SjyH3v2DDlqODJRulUEq4fchVnjO8OsFRlfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUf0Pmg6; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUf0Pmg6"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so9714222a91.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886172; x=1791490972; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qvx6sbBHpVfrs0EKvgXvgwYh4GINhQ+EZvF2xOPN8GE=;
        b=IUf0Pmg6RPNb6bTTm77E51yTdpj1flS+jJoVIsehAytzbV9rgFcchJuoGXGcW5y1Yc
         SwgLNJvQYbZH9TIlADFT8wQil4O3js5LBohlq63Toik6pSMan3D8mdJrhE8Lgpc596Tg
         pyqj+JudeOJcuUEi3ylNiRjL/g3heJ2PGqRb8D99YzWmlzeNIBaTHlv9ackjt4uyyr8O
         iuEjQ7HTd1BB+JwZHlWqgGQNeLVQImAbhVlwbiVTebeo13ds0Yn/bSUkBKTAj55fBtCI
         KusPXgk3TL9cKjfnweg87kv0U+tsKH8B9sIMlFBQvfCgzBn3gUfL/5WKz6Fhkgw6Z2oS
         tHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886172; x=1791490972;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qvx6sbBHpVfrs0EKvgXvgwYh4GINhQ+EZvF2xOPN8GE=;
        b=U8sYJqi+7cMGYzOnCdvX/Vr1lF0uU7qup6NpPE4SEtpDAUIVTcDeYAnLAs1Q0AQoz+
         knbjIK+rRUO3RJi9EgUZBfsUUtVf3OJtfgdBsJLyMbZAbhXVSTdFhwWRQx+hmvkVgTBW
         aHX0OWYA9t/OMtL6Koz7qFEcKO1Uw6iPFpH2GLDdRvY2oConTymXDfz4gFSqlZmuXYSa
         SJCdrTfuibarD4L7caW6tB78Am19AuJ3I9hPIS97rCfDMOV232OdIKbwfw9P+HsppXRp
         oXy07NqaLKt7TyM19qmxZAEAjR+NyIweKGemc+/VKhOahlhK9LxQKFPUrsQQRT6WW23A
         s2/g==
X-Forwarded-Encrypted: i=1; AKwUvBwuWBnNYN2HaokTL14hw7ID0HiQfV7hw1xlQcG0n8sqM9TUd7JzS7tLy0VCaJfM020+bNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX3axAbL0noIsFxiwmDaILCbt74z1PUs4S/VT9ATCeaEVmR2eL
	DCUYlfrvnGWS0ExLyXWOU6wsKjIJzwVLJ54irc0PTqZC/qfo+1f57ILRA1xQyLqi4JjGIxL7sQP
	2N/7Ucw==
X-Received: from plct19.prod.google.com ([2002:a17:902:d293:b0:2dd:2d81:c97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2787:b0:3a4:f4e8:e09c
 with SMTP id 98e67ed59e1d1-3a6ceb0557fmr560862a91.33.1790886171697; Thu, 01
 Oct 2026 13:22:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:32 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-9-seanjc@google.com>
Subject: [PATCH v2 08/10] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

Accessing user memory via a memslot during VM destruction is broken, as
there are no guarantees that current->mm == kvm->mm when the VM is dying,
because the last reference to the VM can be put from a different process
than the original creating processes.

And even if the original process does put the final reference, during
process exit, do_exit() calls exit_mm() before closing file descriptors, so
vCPU destruction runs with current->mm == NULL on a borrowed lazy TLB
active_mm.  If the borrowed address space has a writable mapping at the
to-be-written userspace address, KVM will corrupt an unrelated task's
memory since uaccess APIs, including __copy_to_user(), don't sanity check
current->mm (and *can't* sanity perform KVM's current->mm == kvm->mm check
since that is firmly a KVM-only concept).

Hack-a-fix the nVMX flow even though KVM now protects against bad uaccess
reads/writes in the core APIs, as doing so will allow adding even more
sanity checks in KVM's APIs to help detect other buggy code.  Add a TODO to
call out that checking if KVM can do a uaccess for the VM is a hack; nVMX
really needs to stop abusing __nested_vmx_vmexit() when destroying a vCPU.

Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit")
Signed-off-by: Jim Mattson <jmattson@google.com>
[sean: key off __kvm_can_do_uaccess(), add TODO]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 7 ++++++-
 include/linux/kvm_host.h  | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..8e31eba4d9fa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5134,8 +5134,13 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * Otherwise, this flush will dirty guest memory at a
 		 * point it is already assumed by user-space to be
 		 * immutable.
+		 *
+		 * TODO: Drop the explicit check on being able to access guest
+		 *       memory once KVM no longer abuses the nested VM-Exit
+		 *       flow when destroying a vCPU.
 		 */
-		nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
+		if (__kvm_can_do_uaccess(vcpu->kvm))
+			nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
 	} else {
 		/*
 		 * The only expected VM-instruction error is "VM entry with
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0ee81754d730..0c58a4945595 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1350,10 +1350,14 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			      gpa_t gpa, unsigned long len);
 
+static __always_inline __must_check bool __kvm_can_do_uaccess(struct kvm *kvm)
+{
+	return current->mm == kvm->mm && refcount_read(&kvm->users_count);
+}
+
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm ||
-			     !refcount_read(&kvm->users_count));
+	return !WARN_ON_ONCE(!__kvm_can_do_uaccess(kvm));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


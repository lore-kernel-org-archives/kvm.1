Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558B3FAE11
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073497; cv=none; b=FigUVq2gVB8DrdYZy0nrHzjvPn9gvZx+HpnSv0rumMLz7mzXgqLT9jdRowxJA/7JUZxyZjHTN+TWMUVoz4tgzUin4cZbRcaaa+E648ZiKe2xVgFWRIivgWtbs9YsED7hPfTwBzCw/rVTfGDMZd/FRlqFApzyU/9V5BRgLzba/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073497; c=relaxed/simple;
	bh=0lsKgKDWAG6ilUiGyVqdXWwZKr2qSgHhst802vkoXjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3WLeB2h9pDjYCmSRGQg4pOmMSqrWl5huTw/5mtYiDrwP+IKsyrt63291hPKevKu8FYFP81QH+NOMtc3dKOfJw/389mtvwKtvbi/GTWwEPsf86qFmvbrflHvcNsrcLaKLWvce5EaNUbbdFud5JvEO3XwbSBMRkWCLXjiFCBklSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6Mq6zu6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6Mq6zu6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so823597a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073492; x=1780678292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yJlZ0p8w2Zt6JF+kmSoduaX7LUoYSExgSIwQfbW32Qc=;
        b=R6Mq6zu6p5QqeYVkcrUTTo+km9ImVC9ITKBZehmt7a52jmcR2dp3+ZJgPgYoca6uwp
         pPuTS1nKeBb3wZlzUogFBEPow5FjCJuO2QICnSv4aWhXWe+8pQBjpKLc9UlemKjmvrZR
         +R0Th4IHko+qlzkzhPrcoegVll7VFtNTUKEPMDnMCppqFg8Tdx5HqO/Bz6qYIM91I6TK
         w58OWYiKGscm7o3RHECSJqYQNbSt3GqSUET097XItDFTAlx7ronc9tqFXWZgJGnIX2bb
         Aw9ZUpgwQ4xaCzcLZqGEx/eepb1DCHYH+Ag7w4UZRe4aHlcUUwR0ejaw+Xyugjl4kkJd
         A9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073492; x=1780678292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJlZ0p8w2Zt6JF+kmSoduaX7LUoYSExgSIwQfbW32Qc=;
        b=GAlPWx5AMR3BcpWXReBVoRqTzqiQJuQKKdRkQzZd67HMtUWWtisBerUOZPmPGFjG3t
         F9hnhwRxLgISVPVxPzIXcSbafP4HwYvgWa0QgVLQbieMeRAwWtVBezlF3yrMPAoC6IQ1
         Ctzc9CJCcX3DuiUxshOHt/T6Z4L8BEKtyrel+VVm0ZnDWqTvfhQKDbCEpvRbnhImkWyX
         gDVop7rNr3FygSJCoqDnW6A89KkFaybtD00PCJEP2UGWVwnk743Q3fVm81uOoofll3z8
         R3O3gcwxkxOk4mOkpoQpLoGODv1on8z3XM25IjiGO3AZtiygOIAuPMqJrnkLPixW150k
         aZHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+43Wd+j/zCHFt5zeEZIVRKx8Kzin7oYWKXaNYi+wgmvVDZT5clNoUPac3lRDoB1LjQkJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOaSQGpJpOHszom8Uzg3dpUVdwAY/rKm+2f2xO6q6cqU2wkQl
	rAaFfCv7kjcrqR9sKXYL7/blOzTK7TVi9MyRV5SaYnpCguJlkXVoIAWLrWJDfDoI9Ot4zIIBs1x
	nyYNRsg==
X-Received: from pghk24.prod.google.com ([2002:a63:f018:0:b0:c82:3956:ab7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce4a:b0:3aa:f9cb:d438
 with SMTP id adf61e73a8af0-3b427ecf1bcmr72868637.21.1780073491805; Fri, 29
 May 2026 09:51:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:02 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-9-seanjc@google.com>
Subject: [PATCH v2 08/20] KVM: x86/xen: Explicitly tag "shared info" page as
 never being dirty tracked
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly mark the Xen shared info page as never being dirty tracked so
that higher-level gpc APIs can be added to automatically take care of
things like dirty tracking, without reintroducing the bug fixed by commit
55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info not to
mark page dirty").  And because the code _looks_ buggy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c        |  2 +-
 include/linux/kvm_host.h  | 13 ++++++++++---
 include/linux/kvm_types.h |  1 +
 virt/kvm/pfncache.c       |  4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 020ef0ddab01..ab8e95647406 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2334,7 +2334,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	idr_init(&kvm->arch.xen.evtchn_ports);
-	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 27498e990dff..0dc4eb78b6d9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1427,16 +1427,23 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 			 unsigned long len);
 
 /**
- * kvm_gpc_init - initialize gfn_to_pfn_cache.
+ * __kvm_gpc_init - initialize gfn_to_pfn_cache.
  *
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @kvm:	   pointer to kvm instance.
+ * @never_dirty:   %true if the associated gfn should never be marked dirty
  *
  * This sets up a gfn_to_pfn_cache by initializing locks and assigning the
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
  * the caller before init).
  */
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty);
+
+static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+{
+	__kvm_gpc_init(gpc, kvm, false);
+}
 
 /**
  * kvm_gpc_activate - prepare a cached kernel mapping and HPA for a given guest
@@ -1942,7 +1949,7 @@ static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 {
 	lockdep_assert_held(&gpc->lock);
 
-	if (!gpc->memslot)
+	if (!gpc->memslot || gpc->never_dirty)
 		return;
 
 	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..e850adc3f47e 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -94,6 +94,7 @@ struct gfn_to_pfn_cache {
 	kvm_pfn_t pfn;
 	bool active;
 	bool valid;
+	bool never_dirty;
 };
 
 #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 70b102095173..9209f06c46b4 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -382,7 +382,8 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
 
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty)
 {
 	rwlock_init(&gpc->lock);
 	mutex_init(&gpc->refresh_lock);
@@ -392,6 +393,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
 	gpc->active = gpc->valid = false;
+	gpc->never_dirty = never_dirty;
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-- 
2.54.0.823.g6e5bcc1fc9-goog


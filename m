Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063503F65E8
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073502; cv=none; b=haFvU5np1fYuMucdiXrLcdPbcKDblmVyVgGbZMwWMB4vyZdXo9zU0MDfVo9zppeq/CJRTZ+gajVggG+xbG7koSEnrQE3SXjCxFVcT8+xS5WS3tTN2z1vJH8iZEJVTSCSo2JGNJwzZX42W2hM3bCi6+ZwMgjwpDE5QDItETtGxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073502; c=relaxed/simple;
	bh=TbGTG//BRfZyO3EO5/l2ZyduEsQQgNZBpVmpI8VznlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uBGFeN69VWX+wP8MNnyc0ZpZF45PyfVgLd1q+RERomOkjoWSt3VT7xkBaQGysYQ7qXa2528ei8SHljU2JfLbNI0+SjKpa16qxcJi2PWAcLWiHoGsmh8JNj2ThSbNfeG8bqZbGeuJSHmebQRFyb3DZu5ObYlwi9eoHtg+om5yy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smuRiX6C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smuRiX6C"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso27335880a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073495; x=1780678295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9LTJsLO4iBomCJPsSYYSa3MedSO/a0SsIY1gx3EsAfg=;
        b=smuRiX6C97vCywRVBO/MV6SF2lpAXPTVJe0JePBZMIvbrNXsuD8uLKIOVQuhxzaPrq
         KwJjT8maYQ6JLQ1xx1kcxQ6uhenghrN/iVBChjg/NOG01fMkJCkW0h2vcL3fwjNw+Cmw
         TK/r1Z48YQ0MISjOShdvtPOzdXyr6WLTj2B0lhx9eUDzHQUWC8d+GqpDopO7iX7jEBlj
         XbF5cVAcEmIpX7wfO44P/ArFYSz48La9TT8FxNpZ0Jaw+qtRj5XRw7eMAWXimDv7FKwX
         WkaXdu0UmuERtIDgeTc8Z2RpEKWliA3YsPRVf8Z3s+KemnajKdkVfBV169RLvEowEu/p
         7nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073495; x=1780678295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LTJsLO4iBomCJPsSYYSa3MedSO/a0SsIY1gx3EsAfg=;
        b=tE1oHCV2u3QtxnRvwNeSES2br4SxK9o9SnBKpptk8bXFowqEABLHRiQ7G4NQkHmbh7
         CdNzwdB/oR6wCUTrwhxybV1Oaerr+SENtTYUy9HZ2xEjXig7j63lAk0SbuRVy4VwELN9
         qvodN3J0wpn07gBb3WhB5pSd4OMXZ86NUK8RXRL0kIF9grZ5h9ZoWzKhoxhqWGzMB2/T
         3PjKjJMOH5+UYRFPfiER3RqXAWCECxUCvSOkLYlxTag4movBxCbGmAQbZTUnjPFgQxgG
         sK1SQmeqCYLvIOXVT/zU4OLwpPSEg5ruiLZTjD/uUFYjmdF8yK3AKLHBDaAe4OR/Sxbm
         jP8Q==
X-Forwarded-Encrypted: i=1; AFNElJ89ZrH+85mt1rgxVh68ay41lmgGQtuSEdrAxTQgr20D87ixqantDNJpVtyuzuX6ic6xlq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSXXB3xBLgAgkX4uJg2EKr9JMBKklCxzmcME/4DfNVT6J/A6M
	WqYGTBnzx9t1TMvbRDQ7CMJJE5t4lt8wVZiXIk+TqBYO93YtTBL95pTFBkQUe33200pt71eGsBF
	C+tBR6g==
X-Received: from pgbdr2.prod.google.com ([2002:a05:6a02:fc2:b0:c79:599a:d8e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d8b:b0:3aa:c9d8:d795
 with SMTP id adf61e73a8af0-3b427c15601mr88062637.10.1780073495059; Fri, 29
 May 2026 09:51:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:05 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-12-seanjc@google.com>
Subject: [PATCH v2 11/20] KVM: Add CLASS() constructs to automagically handle
 lock+check of gpc
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

Add CLASS() definitions for locally mapping a PFN given a gpc (gfn_to_pfn
cache), to eventually deduplicate a number of users that do:

  lock();
  while (!check()) {
    unlock();

    if (refresh())
	return err;

    lock()
  }

  ...

  mark_dirty();
  unlock();

Implement read-only (for cases where KVM is only reading) and "try" (for
use in atomic code where rwlock might sleep due to PREEMPT_RT) variations.

Use "map local" as the primary terminology as the basic concept is more or
less the same as kmap_local(): ensure the current CPU has a kernel mapping
to the underlying memory.

Convert the pvclock code as the first user, as it is straightforward and
thus easier to audit for correctness.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c       | 17 ++++----------
 include/linux/kvm_host.h | 48 +++++++++++++++++++++++++++++++---------
 virt/kvm/pfncache.c      | 36 ++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 87e99756de0a..ea10ed4ab06f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3268,17 +3268,11 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
-	read_lock(&gpc->lock);
-	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		read_unlock(&gpc->lock);
+	CLASS(gpc_map_local, clock_map)(gpc, offset + sizeof(*guest_hv_clock));
+	if (IS_ERR(clock_map))
+		return;
 
-		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
-			return;
-
-		read_lock(&gpc->lock);
-	}
-
-	guest_hv_clock = (void *)(gpc->khva + offset);
+	guest_hv_clock = *clock_map + offset;
 
 	/*
 	 * This VCPU is paused, but it's legal for a guest to read another
@@ -3299,9 +3293,6 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 	guest_hv_clock->version = ++hv_clock.version;
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock(&gpc->lock);
-
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ffbae1e6e84e..d70fa91cda0c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1535,6 +1535,44 @@ static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
 	return gpc->active && kvm_is_error_gpa(gpc->gpa);
 }
 
+static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
+{
+	lockdep_assert_held(&gpc->lock);
+
+	if (!gpc->memslot || gpc->never_dirty)
+		return;
+
+	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
+}
+
+void **gpc_map_local_lock(struct gfn_to_pfn_cache *gpc, unsigned long len);
+void **gpc_try_map_local_lock(struct gfn_to_pfn_cache *gpc, unsigned long len);
+
+static inline void gpc_map_local_unlock(void **khva)
+{
+	struct gfn_to_pfn_cache *gpc = container_of(khva, struct gfn_to_pfn_cache, khva);
+
+	kvm_gpc_mark_dirty_in_slot(gpc);
+
+	read_unlock(&gpc->lock);
+}
+
+static inline void gpc_map_local_unlock_ro(void **khva)
+{
+	read_unlock(&container_of(khva, struct gfn_to_pfn_cache, khva)->lock);
+}
+
+#define DEFINE_GPC_CLASS(try, ro)						\
+DEFINE_CLASS(gpc##try##_map_local##ro, void **,					\
+	     if (!IS_ERR(_T)) gpc_map_local_unlock##ro(_T),			\
+	     gpc##try##_map_local_lock(gpc, len),				\
+	     struct gfn_to_pfn_cache *gpc, unsigned long len)			\
+
+DEFINE_GPC_CLASS(,);
+DEFINE_GPC_CLASS(_try,);
+DEFINE_GPC_CLASS(, _ro);
+DEFINE_GPC_CLASS(_try, _ro);
+
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
 
@@ -1930,16 +1968,6 @@ static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 	return !kvm_is_error_hva(hva);
 }
 
-static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
-{
-	lockdep_assert_held(&gpc->lock);
-
-	if (!gpc->memslot || gpc->never_dirty)
-		return;
-
-	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
-}
-
 enum kvm_stat_kind {
 	KVM_STAT_VM,
 	KVM_STAT_VCPU,
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 9209f06c46b4..d3e02a2bac38 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -484,3 +484,39 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		gpc_unmap(old_pfn, old_khva);
 	}
 }
+
+void **gpc_try_map_local_lock(struct gfn_to_pfn_cache *gpc, unsigned long len)
+{
+	if (!read_trylock(&gpc->lock))
+		return ERR_PTR(-EWOULDBLOCK);
+
+	if (!kvm_gpc_check(gpc, len)) {
+		read_unlock(&gpc->lock);
+		return ERR_PTR(-EWOULDBLOCK);
+	}
+
+	return &gpc->khva;
+}
+
+void **gpc_map_local_lock(struct gfn_to_pfn_cache *gpc, unsigned long len)
+{
+	/*
+	 * Yes, this is an open-coded loop. But that's just what put_user()
+	 * does anyway. Page it in and retry the instruction. We're just a
+	 * little more honest about it.
+	 */
+	for (;;) {
+		int r;
+
+		read_lock(&gpc->lock);
+
+		if (kvm_gpc_check(gpc, len))
+			return &gpc->khva;
+
+		read_unlock(&gpc->lock);
+
+		r = kvm_gpc_refresh(gpc, len);
+		if (r)
+			return ERR_PTR(r);
+	}
+}
-- 
2.54.0.823.g6e5bcc1fc9-goog


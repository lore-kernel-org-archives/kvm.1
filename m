Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39D52941C
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057452; cv=none; b=syMofy/CpF0G0fJ/7UfCh0ZF4c2f4PKfF5/2H2tOQdP2epXLZ/OxrgVUZD7ac6T0idPRsE3Xm281p74m+FcDze+skc6EmR2lnb3zOlq1A2IJm1lVbEKfRt0kuJLq+at6+ha3RP9Ya7NMiKrFXNMc1nbv401CfKPE6ojy/Zv4oDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057452; c=relaxed/simple;
	bh=AHvgtIL5obyEkQeMJj9TEFvDUyBEEuMsjvgCq4Ntp70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLJdBSryHBVetHP5bBePlTdQwpbqlCxmkYwcYamBOZt6SJeMjejVC561vtk2m1aZOrw5VsDHRNikwVoz9zHEWtqOFZGQX7mYhVKeqWTfgTZDBKkjjijzICCoF5tBnLzr73ih6MDUrT8H/nlLbTGBdzrVZtSqeMWGqSNTH14aajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1fA3ekL; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1fA3ekL"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso70195e9.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057445; x=1789662245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WjqNYFOMqEwxR4wUCekRhwd9RX45J94sJ1enbo8buA=;
        b=Z1fA3ekLfjqyfjhKTE48Je3loqRDWXZcI308y5qa77KWwYaBmgbCxuADX2bqjm4q3r
         gTsuCQwhev5huXwKsNtyPFTTXxz5Ta+I4ZXSSBm6bbrccnyEharkhf8Kst05NmMacIIu
         5Q0dX/WtgQ9WcvNOg+MRawOcXkCDWDCGc7pqRkKw/BBOSV4EJoPttDz+gd5Bp2CWM6mT
         spe6S1/VgOhZirQc8u4lckEX6IuJR0u2YZbnQw2uoZdoUiCyPzcoBpFhipeTnytXEnnK
         lobL9ChhPIIVYwRMi8FqCq8UISzk8ckaGlvZUxVv3CicfFYDiIpBZDaPzBHxsaqZ9BOQ
         d/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057445; x=1789662245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WjqNYFOMqEwxR4wUCekRhwd9RX45J94sJ1enbo8buA=;
        b=I3XV1yNd0vuGSCumvEkEC6qFWB0D/QmZ61najh5vMJpKBYMdyf0Bb1orB7v/gtN69c
         eax3ZUL3GkTCSgSWsAY+dYTIONXYbZkBg4ZhXHZyG0nxoXrwda2jjEx59UNiJj68g9CT
         zg2zQGryUWz3Vp2NBv0M4Kw47KPzJqrT0LAGZS6WjrfyEQUq6e43qxwZQSzO27+0o3l7
         7gOorf5314+C/4Aek9egvZEI31HeLnFmJ9rIEGfyNYYTWT0IA06O9xc4fOUBWh7mdVE3
         ECGKzE8VojphGOaGiZlgKTnBWz0JNF8kK60n6gaY8OXIxRG6/aNrm8xTSRQIlc5DJ1c9
         ySow==
X-Forwarded-Encrypted: i=1; AKwUvBzMvuxiHDF0tetJKtUJkMCROcKbdPV/RbsKiju0eHOQrXjkSVFHxhYCvcf3qRI5rsXCtC4=@vger.kernel.org
X-Gm-Message-State: AFuF++mwlh3oGnomHk58bOp8rF04YjBzGOzMyzehMyBwd801Xg6xvbhE
	SOdivoMF4CeU1/DaPHX4gKbS+RfXIGvZF9hyoxNPlggAkoXJnHxx1xDjgb1ARX5oH3Cd2uyx/35
	qPw==
X-Received: from wmbb26.prod.google.com ([2002:a05:600c:589a:b0:49e:5ffd:edcc])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5493:b0:49b:8f18:714a
 with SMTP id 5b1f17b1804b1-49cf824a6c5mr440314875e9.12.1789057444629; Thu, 10
 Sep 2026 09:24:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:21:41 +0000
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910162343.4092060-9-elver@google.com>
Subject: [PATCH RFC 08/10] KVM: Add guarded_by to members in struct kvm
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add __guarded_by annotations to a subset of members in struct kvm where
the protecting locks reside in the same struct scope. Members protected
by locks across nested or parent struct boundaries are omitted due to C
lexical scoping limitations.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kvm_host.h | 12 ++++++------
 virt/kvm/eventfd.c       |  4 ++--
 virt/kvm/kvm_main.c      |  3 +++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 12f241304228..36edf0a59107 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -771,7 +771,7 @@ struct kvm {
 	/* The two memslot sets - active and inactive (per address space) */
 	struct kvm_memslots __memslots[KVM_MAX_NR_ADDRESS_SPACES][2];
 	/* The current active memslot set for each address space */
-	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES];
+	struct kvm_memslots __rcu *memslots[KVM_MAX_NR_ADDRESS_SPACES] __guarded_by(&srcu, &slots_lock, &slots_arch_lock);
 	struct xarray vcpu_array;
 	DECLARE_BITMAP(vcpu_ids, KVM_MAX_VCPU_IDS);
 	/*
@@ -787,7 +787,7 @@ struct kvm {
 
 	/* For management / invalidation of gfn_to_pfn_caches */
 	spinlock_t gpc_lock;
-	struct list_head gpc_list;
+	struct list_head gpc_list __guarded_by(&gpc_lock);
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
@@ -801,11 +801,11 @@ struct kvm {
 	int last_boosted_vcpu;
 	struct list_head vm_list;
 	struct mutex lock;
-	struct kvm_io_bus __rcu *buses[KVM_NR_BUSES];
+	struct kvm_io_bus __rcu *buses[KVM_NR_BUSES] __guarded_by(&srcu, &slots_lock);
 #ifdef CONFIG_HAVE_KVM_IRQCHIP
 	struct {
 		spinlock_t        lock;
-		struct list_head  items;
+		struct list_head  items __guarded_by(&lock);
 		/* resampler_list update side is protected by resampler_lock. */
 		struct list_head  resampler_list;
 		struct mutex      resampler_lock;
@@ -826,9 +826,9 @@ struct kvm {
 	/*
 	 * Update side is protected by irq_lock.
 	 */
-	struct kvm_irq_routing_table __rcu *irq_routing;
+	struct kvm_irq_routing_table __rcu *irq_routing __guarded_by(&irq_srcu, &irq_lock);
 
-	struct hlist_head irq_ack_notifier_list;
+	struct hlist_head irq_ack_notifier_list __guarded_by(&irq_srcu, &irq_lock);
 #endif
 
 	struct mmu_notifier mmu_notifier;
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 6701390336f6..6051fec5ec90 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -1046,8 +1046,8 @@ void
 kvm_eventfd_init(struct kvm *kvm)
 {
 #ifdef CONFIG_HAVE_KVM_IRQCHIP
-	spin_lock_init(&kvm->irqfds.lock);
-	INIT_LIST_HEAD(&kvm->irqfds.items);
+	scoped_guard(spinlock_init, &kvm->irqfds.lock)
+		INIT_LIST_HEAD(&kvm->irqfds.items);
 	INIT_LIST_HEAD(&kvm->irqfds.resampler_list);
 	mutex_init(&kvm->irqfds.resampler_lock);
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2f22d5439d39..871acc3aebbd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1111,6 +1111,7 @@ void __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
 /* Called only on cleanup and destruction paths when there are no users. */
 static inline struct kvm_io_bus *kvm_get_bus_for_destruction(struct kvm *kvm,
 							     enum kvm_bus idx)
+	__context_unsafe(/* destruction */)
 {
 	return rcu_dereference_protected(kvm->buses[idx],
 					 !refcount_read(&kvm->users_count));
@@ -1120,6 +1121,7 @@ static int kvm_enable_virtualization(void);
 static void kvm_disable_virtualization(void);
 
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
+	__context_unsafe(/* constructor */)
 {
 	struct kvm *kvm = kvm_arch_alloc_vm();
 	struct kvm_memslots *slots;
@@ -1276,6 +1278,7 @@ static void kvm_destroy_devices(struct kvm *kvm)
 }
 
 static void kvm_destroy_vm(struct kvm *kvm)
+	__context_unsafe(/* destructor */)
 {
 	int i;
 	struct mm_struct *mm = kvm->mm;
-- 
2.55.0.1003.g10538fe699-goog


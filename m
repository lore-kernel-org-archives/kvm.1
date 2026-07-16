Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8064446F8
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225719; cv=none; b=OX2UrkNR+a71q4KDn9TYZ8JqkOvHcMz9+AiKoWcw4c9W++1PqP4H8i/KBeS/9UDe6llbmdVx7WOlGjxea9xUNoskM9RoiFZSfMCFSqZB2Um8UZnavhf/8xBBZTXoLyWhiqYTlwdqT2o9zdA5dS17ZVKLqT9y4/tMWOZzSxQcXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225719; c=relaxed/simple;
	bh=FmJzLb+n+bJ8qEVB8q4rI758/WTEOrbdo3jqTnz2IHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7yhxwcxc4UQeq2XSbuOOttFv0HiIaDMW/+qAO7ONmTO2rRvR6IsAKHySDxccJUCl7bPW9Bv4wa85H9nqQHSi+5Mk/0NVMF5872weJ4GPbwtlLYhq3A6LSqrm2WceopA1suqpqX1YpBQsNUGFEYAnduYybQhASSW65E+STF8D1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLQPM473; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLQPM473"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0+M/PykJDVqAjN7ZHI2LjwPbsl16uAh/kMFqVLU5gQ=;
	b=WLQPM473/y7ID18+iV02iI4RPl5ybHr8+YLGBhbKm7cqn3+9H/4JJNS1PQqmIL5PPxod/w
	RsQZRKowMemUX8vRoDHkBpam8bgly9Wfw6q6AJ9sH91ShEYjOqGmStmSe7vW4fzFetXcF6
	01iNnHzkrL8UDB0jVvUxVR9jPGWeMMQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-HyLXb4zROBqgkmG2Z3V9kA-1; Thu,
 16 Jul 2026 14:15:07 -0400
X-MC-Unique: HyLXb4zROBqgkmG2Z3V9kA-1
X-Mimecast-MFC-AGG-ID: HyLXb4zROBqgkmG2Z3V9kA_1784225706
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90755180062C;
	Thu, 16 Jul 2026 18:15:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20C401800480;
	Thu, 16 Jul 2026 18:15:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 13/24] KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
Date: Thu, 16 Jul 2026 14:14:45 -0400
Message-ID: <20260716181456.402786-14-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In many cases, retrieving kvm_memslots is followed by a check on
the generation of the slots.  Introduce a helper function that
either does the check alone, or compounds it with returning the
struct kvm_memslots* to the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c       | 10 ++--------
 include/linux/kvm_host.h | 12 ++++++++++++
 virt/kvm/kvm_main.c      |  8 ++++----
 virt/kvm/pfncache.c      | 10 ++++------
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e2240f817c22..58f544df47e1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2032,7 +2032,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 	u64 steal;
 	u32 version;
@@ -2048,9 +2047,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
 		/* We rely on the fact that it fits in a single page. */
@@ -2601,7 +2598,6 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
 	static const u8 preempted = KVM_VCPU_PREEMPTED;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 
@@ -2628,9 +2624,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 341f2e97f3cb..122af87d6f9a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2559,6 +2559,18 @@ static inline bool kvm_mem_attributes_may_exec(u64 attrs)
 	return !(attrs & KVM_MEMORY_ATTRIBUTE_NX);
 }
 
+static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation, struct kvm_memslots **p_slots)
+{
+	struct kvm_memslots *slots = *p_slots = kvm_memslots(kvm);
+	return slots->generation == slots_generation;
+}
+
+static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation)
+{
+	struct kvm_memslots *slots;
+	return kvm_memslots_check_gen(kvm, slots_generation, &slots);
+}
+
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 #define KVM_MEMORY_ATTRIBUTE_PROT \
 	(KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW | KVM_MEMORY_ATTRIBUTE_NX)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 20113069562e..1afaec56ecb3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3502,14 +3502,14 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				  void *data, unsigned int offset,
 				  unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memslots *slots;
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (slots->generation != ghc->generation) {
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
 		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
@@ -3540,14 +3540,14 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				 void *data, unsigned int offset,
 				 unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memslots *slots;
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (slots->generation != ghc->generation) {
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
 		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..e09703d249bb 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -72,8 +72,6 @@ static bool kvm_gpc_is_valid_len(gpa_t gpa, unsigned long uhva,
 
 bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-
 	if (!gpc->active)
 		return false;
 
@@ -81,7 +79,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	 * If the page was cached from a memslot, make sure the memslots have
 	 * not been re-configured.
 	 */
-	if (!kvm_is_error_gpa(gpc->gpa) && gpc->generation != slots->generation)
+	if (!kvm_is_error_gpa(gpc->gpa) && !kvm_check_gen(gpc->kvm, gpc->generation))
 		return false;
 
 	if (kvm_is_error_hva(gpc->uhva))
@@ -290,12 +288,12 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 		if (gpc->uhva != old_uhva)
 			hva_change = true;
 	} else {
-		struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
+		struct kvm_memslots *slots;
 
 		page_offset = offset_in_page(gpa);
 
-		if (gpc->gpa != gpa || gpc->generation != slots->generation ||
-		    kvm_is_error_hva(gpc->uhva)) {
+		if (!kvm_memslots_check_gen(gpc->kvm, gpc->generation, &slots) ||
+		    gpc->gpa != gpa || kvm_is_error_hva(gpc->uhva)) {
 			gfn_t gfn = gpa_to_gfn(gpa);
 
 			gpc->gpa = gpa;
-- 
2.52.0



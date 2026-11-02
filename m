Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641521;
	b=Bwr/f/DLTN3flRsGQ2GJ1YRlOQcQaRRgAPsgylParhx68LK/n0VLqP4x8s6luR4joT8K
	 lrZpjXU/gWwCA5Wnfss2cofIYB0xJ9hlzX6Ul3gkfOqCUQjcav8r8zfA3ggpQOVKe4dIr
	 4YGsu0im63D3+lSmVE6uUV+/DHhqTN6XrI5uKPgEsksI4DwAqq2tZ2QSejHWY2mZf3wuh
	 Z0fNHtvpsgmnBTsYVbNRpOnUWUMEp6TnSqz5UBCh+fuMpnyRxxDEj2DWAS63VB0NAyHcG
	 iyiZn3ildcNDnGz/wZh9CD1KeOJY7KNpBNTaOYRIXIRl0dTyOw2EN2KT/sPibYrLDRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641521;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ugd711jlpW85iLiSnmswwJrSmWesHiLu+/z00ZV/Mlo=;
	b=DSkdF8WAgZNVyqbE3mzXLo/2y1xC94TcdnWoHet79OW+OC57edxRTIEd9RenBZlTkvyE
	 I8syOz7lzFQuJaxskIh6IxXCrPyoZz0csPUKhpE3bh78fhBatuwo40M16mDo0aL5do5ZG
	 janIn2JISyDUOf8J3JGq2zw6CwSU0NE6P/i2QDePP9VvhpDLZLPhshLayvMEewY/lraR7
	 GRJEiq8A1AybXx/vOFWE/znF0WZjzaJxMkNiyeFmKKWWaEK/9cw51I0nSM2+rdoL6E1I1
	 WMN3svNkv5jlJ8PXpSQTazCbXzZm5Pb0JwkHhyAlYpSbaPdC4OyUtHlGKugb/CdErcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XATZ8Dey;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBF606E03C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0BBF606E03C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XATZ8Dey
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugd711jlpW85iLiSnmswwJrSmWesHiLu+/z00ZV/Mlo=;
	b=XATZ8DeylwtHaHMW+OW6iPhEAHj6e58QumR7OLmqleshvNaVE2RNWFc2TQE+qQXfO8MoLe
	BeFqevZ/ACmxhpSpxDw1iU8Kx9/LqukBaqgXGnfb7XY/6xXes2gPIQM6IUw3K4uggo1mGG
	J5HbSCC1gwbcSNhU52zaQf0LFzvteP4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84--bXr3uIQP0OU60FFSs44Ww-1; Mon,
 02 Nov 2026 12:45:18 -0500
X-MC-Unique: -bXr3uIQP0OU60FFSs44Ww-1
X-Mimecast-MFC-AGG-ID: -bXr3uIQP0OU60FFSs44Ww_1793641517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A265180063B;
	Mon,  2 Nov 2026 17:45:17 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 269391956087;
	Mon,  2 Nov 2026 17:45:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 23/45] KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
Date: Mon,  2 Nov 2026 12:44:50 -0500
Message-ID: <20261102174512.8903-7-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In many cases, retrieving kvm_memslots is followed by a check on
the generation of the slots.  Introduce a helper function that
either does the check alone, or compounds it with returning the
struct kvm_memslots* to the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-21-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/loongarch/kvm/vcpu.c | 12 ++++--------
 arch/x86/kvm/x86.c        | 10 ++--------
 include/linux/kvm_host.h  | 13 +++++++++++++
 virt/kvm/kvm_main.c       |  8 ++++----
 virt/kvm/pfncache.c       | 10 ++++------
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 059a6d605de7..c3e71ef983bc 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -154,7 +154,6 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	u32 version;
 	u64 steal;
 	gpa_t gpa;
-	struct kvm_memslots *slots;
 	struct kvm_steal_time __user *st;
 	struct gfn_to_hva_cache *ghc;
 
@@ -164,9 +163,8 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 		return;
 
 	gpa &= KVM_STEAL_PHYS_MASK;
-	slots = kvm_memslots(vcpu->kvm);
-	if (unlikely(slots->generation != ghc->generation || gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
+		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
 		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
 			ghc->gpa = INVALID_GPA;
 			return;
@@ -1803,7 +1801,6 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vcpu *vcpu)
 {
 	gpa_t gpa;
 	struct gfn_to_hva_cache *ghc;
-	struct kvm_memslots *slots;
 	struct kvm_steal_time __user *st;
 
 	gpa = vcpu->arch.st.guest_addr;
@@ -1820,9 +1817,8 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vcpu *vcpu)
 
 	gpa &= KVM_STEAL_PHYS_MASK;
 	ghc = &vcpu->arch.st.cache;
-	slots = kvm_memslots(vcpu->kvm);
-	if (unlikely(slots->generation != ghc->generation || gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
+		     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
 		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
 			ghc->gpa = INVALID_GPA;
 			return;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ab7a859dda79..8574d75df4dc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2062,7 +2062,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 	u64 steal;
 	u32 version;
@@ -2078,9 +2077,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
 		/* We rely on the fact that it fits in a single page. */
@@ -2630,7 +2627,6 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
 	static const u8 preempted = KVM_VCPU_PREEMPTED;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 
@@ -2657,9 +2653,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
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
index 4a1985fe2737..5cbb50afdb94 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2676,6 +2676,19 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
 	return kvm_mem_attributes_may_write(attrs);
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
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 635730b5930c..da12f4d43c91 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3635,14 +3635,14 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
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
@@ -3673,14 +3673,14 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
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
index 3659686b97c2..ac02f6a065cc 100644
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



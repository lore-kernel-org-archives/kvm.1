Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BB4B8271
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719382; cv=none; b=n6TgGskQd5l3eORG61gaTunMSjf2tH9/p43CIT/7QcJzTfKEAiMQm8kO95s6uzjCb2u+uEaebIfl/CUJ2xkP24NMEQT3IXcDf0epmkgeKaL4rgkrCmOhxDzlRY17XSA+PVK+FahhjjqmqLmj02GBkA40cW0U7n3J37EFZq07350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719382; c=relaxed/simple;
	bh=zYdgoF19yrBAddmiz5U+pMMnjvnHH3FkMGSpyu7iIjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqSiXEf3jXZJ8n32ydnzPMAZ+6I7fc5T2AH7HscJNfch6yzxrjhHdgDSVBHPRSr857vcYPzx9McjHVYY64c6tjtiNXIuvPVBrHEayGHMTt8qQhqszVQIeX4fvc5ZSxarhTNln6++S3ITxg9b1O8+SajleaeGdsWyAIDWUS1L9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ay/ewjzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay/ewjzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c39yRW+h6dkqpPKLdQfPTPGhL/SUy3kZmIEvvwgjLgg=;
	b=ay/ewjzvyaTNciN020zfvgmB9mY7i9QeRzs0i9xYjOU02E/Nl9r58yEIP/+IiWZonXOvdf
	/YYC9syGs3uvN7p4om2GuTQr7nfJdwRqG6OdG4Y2zEQynhvOyHIFxOPa4I8Vg1WRbh63fc
	6PQMkRomFPc+e9zobQ3vFgFw4EDxOP8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-0CefMwXNM0-QHQc_3Ag8KQ-1; Fri,
 18 Sep 2026 04:16:07 -0400
X-MC-Unique: 0CefMwXNM0-QHQc_3Ag8KQ-1
X-Mimecast-MFC-AGG-ID: 0CefMwXNM0-QHQc_3Ag8KQ_1789719366
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66F02195398D;
	Fri, 18 Sep 2026 08:16:06 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCFE030001A2;
	Fri, 18 Sep 2026 08:16:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 25/28] KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
Date: Fri, 18 Sep 2026 04:15:40 -0400
Message-ID: <20260918081543.139871-26-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Note that the zapping of obsolete roots needs to happen after
mmu_lock is dropped, so introduce a separate kvm_arch callback.
The two map neatly to the "front" and "back" halves of
kvm_mmu_zap_all_fast().

Co-developed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 32 ++++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      |  7 +++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 097095f71d60..d658cfe31cd9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8265,6 +8265,7 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 {
 	unsigned long attrs = range->arg.attributes;
 	struct kvm_memory_slot *slot = range->slot;
+	struct kvm_mmu_page *sp;
 	int level;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -8320,9 +8321,40 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 				hugepage_set_mixed(slot, gfn, level);
 		}
 	}
+
+	/*
+	 * There are special considerations when applying an memory protection
+	 * attibute against a GPTE page. If set read-only, access/dirty bits
+	 * within that page shouldn't be updated. If set non-accesible,
+	 * accessing a virtual address that requires traversing that GPTE page
+	 * should fault.
+	 *
+	 * On TDP enabled guests, the CPU faults on the GPTE address upon
+	 * detecting such a situation.
+	 *
+	 * On non-TDP, upon detecting this situation, and based on the fact it
+	 * should be a rare occasion, invalidate all the mmu roots.
+	 */
+	for (gfn_t gfn = range->start; gfn < range->end; gfn++) {
+		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
+			__kvm_mmu_zap_all_fast_front_half(kvm);
+			return false;
+		}
+	}
 	return false;
 }
 
+void kvm_arch_post_set_memory_attributes_unlocked(struct kvm *kvm)
+{
+	/*
+	 * This may also be called if no zap was done in
+	 * kvm_arch_post_set_memory_attributes().  It is not an issue because
+	 * __kvm_mmu_zap_all_fast_back_half() is cheap when it does not do
+	 * anything.
+	 */
+	 __kvm_mmu_zap_all_fast_back_half(kvm);
+}
+
 void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 					    struct kvm_memory_slot *slot)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e9c0932f150e..33f3199a855f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2624,6 +2624,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+void kvm_arch_post_set_memory_attributes_unlocked(struct kvm *kvm);
 bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
 u64 kvm_supported_mem_attributes(struct kvm *kvm);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 24f46dce192e..ccbec4796e4b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2516,7 +2516,7 @@ static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
 	return kvm_range_has_any_memory_attributes(kvm, start, end, mask);
 }
 
-static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
+static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_mmu_notifier_range *range)
 {
 	struct kvm_gfn_range gfn_range;
@@ -2566,6 +2566,8 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 
 	if (found_memslot)
 		KVM_MMU_UNLOCK(kvm);
+
+	return found_memslot;
 }
 
 static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
@@ -2652,7 +2654,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	smp_store_release(&kvm->mem_attrs.generation,
 			  kvm->mem_attrs.generation + 1);
 
-	kvm_handle_gfn_range(kvm, &post_set_range);
+	if (kvm_handle_gfn_range(kvm, &post_set_range))
+		kvm_arch_post_set_memory_attributes_unlocked(kvm);
 
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
-- 
2.52.0



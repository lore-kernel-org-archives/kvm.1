Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F55172C5
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739465; cv=none; b=jDFa9RNQz8Hqn28G3XBwChMOr7n3MLojtogx/3hm2IcLPpPbc6GlvLza5Q3XtsShTAAMgA09Sa7C1hmtHLxLfUs2MmBdm7bo+XlP2oHRPUoaPBJS0ByPS/M3lHPWfKqgU+8sRWVvq/jTsC8z1NO48P9HHBdezWSFP3mNmrxqjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739465; c=relaxed/simple;
	bh=7hzxATIo0MnXoioKYCKCH1IWPYMFIk2oI8DjnUA7vII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn43LVaXoE8GEOCwZhHCFsT2jfsxgKnR0JbeECqbCiP+j52YBdntYm85R+qDBHpvq8yxh1AAp/7IuVUIjKI9ragQY+bzN93nFszVHlVbeyH6aUoTgAY+ghoGFKFcLgpdB0yFwe3KRSlSJnfJHXTsYO5yTjzOs+tmRRZTlPMnSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6aCd7zm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6aCd7zm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoatqU6bVLNtVOd6+yz8UVdwl0AGcwkRaLTPloa4Wtc=;
	b=G6aCd7zmqtu2Gi6Zx5y/uz7uDHcmYq5AucsAAtq+mA+CCQNrDa17uQYea1vyg45DgK+ggr
	K7JrnuUhkOGqYJwpTUkubJ74bjQoiBFBf5mlpjOth8CIwqm6x1yarLJMJFPVrOGOUFi7JH
	73Yn1Xnooj+tx0h/qp6Ab167ixy0qT4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-R8WXARKtOXuKgfyYgu75TA-1; Fri,
 18 Sep 2026 09:50:57 -0400
X-MC-Unique: R8WXARKtOXuKgfyYgu75TA-1
X-Mimecast-MFC-AGG-ID: R8WXARKtOXuKgfyYgu75TA_1789739456
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C416180B5E9;
	Fri, 18 Sep 2026 13:50:56 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F34AE756;
	Fri, 18 Sep 2026 13:50:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 28/31] KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
Date: Fri, 18 Sep 2026 09:50:27 -0400
Message-ID: <20260918135030.171564-29-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Note that the zapping of obsolete roots needs to happen after
mmu_lock is dropped, so introduce a separate kvm_arch callback.
The two map neatly to the "front" and "back" halves of
kvm_mmu_zap_all_fast().

Co-developed-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      |  1 +
 3 files changed, 32 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6bbecbae2f8c..242cbe65859d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8271,6 +8271,7 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 {
 	unsigned long attrs = range->arg.attributes;
 	struct kvm_memory_slot *slot = range->slot;
+	struct kvm_mmu_page *sp;
 	int level;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -8326,9 +8327,38 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 				hugepage_set_mixed(slot, gfn, level);
 		}
 	}
+
+	/*
+	 * There are special considerations when applying an memory protection
+	 * attibute against a page containing guest PTEs, because virtual
+	 * addresses that requires traversing that page need to fault.
+	 *
+	 * When using shadow paging, the PTEs that the CPU actually walks
+	 * do not have any information about attributes (unlike TDP where
+	 * the attributes become part of the TDP permission bits).  Since
+	 * this should be a rare occasion, just invalidate all the mmu roots
+	 * if shadow paging is in use and attributes do cover a guest PTE.
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
index eb4a661cd0f7..653bb85b3cdd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2658,6 +2658,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		KVM_MMU_LOCK(kvm);
 		kvm_mmu_invalidate_end(kvm);
 		KVM_MMU_UNLOCK(kvm);
+		kvm_arch_post_set_memory_attributes_unlocked(kvm);
 	}
 
 out_unlock:
-- 
2.52.0



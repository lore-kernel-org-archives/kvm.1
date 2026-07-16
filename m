Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33E445AD6
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225728; cv=none; b=KMnARu7JHAGW+dEdea39bVd8pg0Mp4u4PgzTgRzeDZjmnou9/zdasmDM0Dgu1ZU9mJpT8S6mtQbIr36sseblH0adEL4XSTwJ4sbjFD/GOUlvop0d6eG1P/VYLTFE0/8qkz/w5wIm8vz92rFKsa7H6ie0wkGpRtH2m3WOqC12jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225728; c=relaxed/simple;
	bh=TamKDFoXwMXvt9o99JKWhsElHOQQJNHR4/PZAeRDtDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mq12wZTCJtSEjTi8pSVgTr45s/Auhe99WS9+2SpuehHClZ1+GEmsFprl0mnRP5itn1jtw40xWNwYwOQZnHhf1Z6169AI8om65nFEcOTq2VwR7OQ87kVRLUx1RZCWep7zGVzFFNdU4yVG0bhmya5E90am+7tLmxabDUNG2x9+MYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHNyhOL9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHNyhOL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoRxtY/U4Rt7RD5JrPiCkn7z8UituYgwYp9NiSV3kS4=;
	b=CHNyhOL9TrfBPRBiwtD7FFlg2CEv1qXDIevfSrtkHBw7CQ6F3zVuaNymmwocLRXh+GdJMR
	rR/uCwEtd1lNGy2GzZzkCJBD2kwfb3nZbqHL3gauq5NKcj6SIIM1X6Eg38cBhuC+npYH8C
	kEcg+WcF93ya71P7mI8It7zYDr7wMxc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-sfaeIMkvMH6THvWiCKuv5Q-1; Thu,
 16 Jul 2026 14:15:13 -0400
X-MC-Unique: sfaeIMkvMH6THvWiCKuv5Q-1
X-Mimecast-MFC-AGG-ID: sfaeIMkvMH6THvWiCKuv5Q_1784225712
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20782180066E;
	Thu, 16 Jul 2026 18:15:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1C0D195604E;
	Thu, 16 Jul 2026 18:15:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 21/24] KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
Date: Thu, 16 Jul 2026 14:14:53 -0400
Message-ID: <20260716181456.402786-22-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

see comments inside - this patch is incomplete.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 47 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8e85f672a08d..676bc6b61f03 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6989,11 +6989,11 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
  * not use any resource of the being-deleted slot or all slots
  * after calling the function.
  */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+static void __kvm_mmu_zap_all_fast(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	write_lock(&kvm->mmu_lock);
 	trace_kvm_mmu_zap_all_fast(kvm);
 
 	/*
@@ -7030,7 +7030,21 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
 
 	kvm_zap_obsolete_pages(kvm);
+}
 
+/*
+ * Fast invalidate all shadow pages and use lock-break technique
+ * to zap obsolete pages.
+ *
+ * It's required when memslot is being deleted or VM is being
+ * destroyed, in these cases, we should ensure that KVM MMU does
+ * not use any resource of the being-deleted slot or all slots
+ * after calling the function.
+ */
+static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+{
+	write_lock(&kvm->mmu_lock);
+	__kvm_mmu_zap_all_fast(kvm);
 	write_unlock(&kvm->mmu_lock);
 
 	/*
@@ -8221,6 +8235,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 {
 	unsigned long attrs = range->arg.attributes;
 	struct kvm_memory_slot *slot = range->slot;
+	bool gen_update = false;
+	struct kvm_mmu_page *sp;
 	int level;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -8281,6 +8297,33 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
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
+			gen_update = true;
+			trace_printk("needs gen update! %llx\n", gfn);
+			goto exit_loop;
+		}
+	}
+exit_loop:
+	if (gen_update)
+		__kvm_mmu_zap_all_fast(kvm);
+
+	// todo: what to do with kvm_tdp_mmu_zap_invalidated_roots()?
+	// add kvm_arch_post_set_memory_attributes_unlocked?
 	return false;
 }
 
-- 
2.52.0



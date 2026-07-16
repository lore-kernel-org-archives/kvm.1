Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61923394B
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225710; cv=none; b=RnQ6dInhFQqxToStViEwEuuKtusLszu20SljxxIeu4/iu/1T9ODveeUtFlbSlsLhu91CBqR/tjlQkeHmuJUvdS+banp20I1kuTCs31YH2Sg2u4oaQ6kb3IRwIsCUxQwT83KTiGEX0Qk3zSQHGGad+w07EaTl2FOPMy9lGQixJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225710; c=relaxed/simple;
	bh=Yn6hB0cTunTTJYa9SwdDquNDODpP5QDIpcgYE69Rs74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI+gaO+M0pZNM5s9xMBOPiQqAFRBBvPP0noiDXQp1ACC2hJLiyFjFKODF3+0vKW4o9XacXMGNxt3KhLKnoFmmM1+NDpOWZve7443MUlOrJJXJic45lS3KFwl8Lh/FHA7YUsjsn3uKcPeHa7vI0EDf91LQD1IygL66i0rRbQ6C2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWXVl0WL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWXVl0WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XG6Tb7rfF0+kImzRSQfE5PFeJcO4058fC8goQhkRW6Q=;
	b=MWXVl0WLXMXO/shJ8tehjETpdYwWBKdKdgVVuIWVr47hyAGecb43RkZnNQ9p9GgZVGtkOH
	5a2LUQXXTuj+YYWEdFDBZ2EbEnnQ44Am4e7OfzvOU+g7y0ra56wbWR0WtPRCCh73LeB1aC
	VEds7ijgQyau9OC/uDG1C0aSGpvXcvo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-gt5qS8mbNFaXx-LPygfNyg-1; Thu,
 16 Jul 2026 14:15:02 -0400
X-MC-Unique: gt5qS8mbNFaXx-LPygfNyg-1
X-Mimecast-MFC-AGG-ID: gt5qS8mbNFaXx-LPygfNyg_1784225701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC3171955EA2;
	Thu, 16 Jul 2026 18:15:01 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B5B4195604E;
	Thu, 16 Jul 2026 18:15:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 06/24] KVM: x86: Avoid warning when installing non-private memory attributes
Date: Thu, 16 Jul 2026 14:14:38 -0400
Message-ID: <20260716181456.402786-7-pbonzini@redhat.com>
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

In preparation to introducing RWX memory attributes. Make sure
user-space is attempting to install a memory attribute with
KVM_MEMORY_ATTRIBUTE_PRIVATE before throwing a warning on systems with
no private memory support.

The WARN is really a duplicate of the kvm_supported_mem_attributes()
test in kvm_vm_ioctl_set_mem_attributes(), but then all of them should
be redundant...  Keep it as a special check for the private-memory
attribute, to avoid that kvm_mmu_page_fault() sets PFERR_PRIVATE_ACCESS;
that bit would send KVM down kvm_mmu_faultin_pfn_gmem(), which is such
a wrong path that it's worth catching it early.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 424f4e113682..055e0b45a8ee 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8078,9 +8078,15 @@ static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range)
 {
+	unsigned long attrs = range->arg.attributes;
 	struct kvm_memory_slot *slot = range->slot;
 	int level;
 
+	if (!kvm_arch_has_private_mem(kvm)) {
+		WARN_ON(attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+		attrs &= ~KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	}
+
 	/*
 	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
 	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
@@ -8092,9 +8098,6 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
 	 * a hugepage can be used for affected ranges.
 	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
-		return false;
-
 	if (WARN_ON_ONCE(range->end <= range->start))
 		return false;
 
@@ -8165,16 +8168,17 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 	lockdep_assert_held_write(&kvm->mmu_lock);
 	lockdep_assert_held(&kvm->slots_lock);
 
+	if (!kvm_arch_has_private_mem(kvm)) {
+		WARN_ON(attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+		attrs &= ~KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	}
+
 	/*
 	 * Calculate which ranges can be mapped with hugepages even if the slot
 	 * can't map memory PRIVATE.  KVM mustn't create a SHARED hugepage over
 	 * a range that has PRIVATE GFNs, and conversely converting a range to
 	 * SHARED may now allow hugepages.
-	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
-		return false;
-
-	/*
+	 *
 	 * The sequence matters here: upper levels consume the result of lower
 	 * level's scanning.
 	 */
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4775038FA
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739446; cv=none; b=YgNPNHDQ7h0VJoU8To7RJeOwrderahr7ZZqR8NCHkBKguSp9XsNguQ0c+9/pZdiyhn8Gn+T/y6LQGwAPlP+n5g6sAyJ36PRzXTejoq0aLsDr2fxB3naOX+X7LsmQB7rwVZUQH2dA1WX4BhnOdp7ugOlnvpR7ewWd6IxzNIXWp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739446; c=relaxed/simple;
	bh=XPMcHgIeRQB+eRAm7FCUaCYMyDw7uk/BDzk27PKxyjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIWejt2muiWiiEAMQPQMYZxP7K4KTa3eKCW5nYAS+Z6mYG79Naey/OmPHmLBBHbnjrQFNXzlCKJvRULLYssdsTJvqDlKNUCFIUqZfSUveeRnqUm38E0MWoxBfRAl0w7Amg+lYrIWzckQ2ysDivpohKeTrw1IDV7HQzuiD/Edz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzPX8bnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzPX8bnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdubStH0LPL3cLRWju/ttbHM7W6/Ya5BMaguJDp2QnM=;
	b=JzPX8bnPaDklVdLW/u/uNSNb4x2tgRSf3GR7wkrMG9ttsr3hEm6PFCnteia3FnhAPMN+SE
	TBMbpphIs1l0GnOMebWU28iI/yQjXI7F8tPhhF72mUQqTOH6UMl88a98I6ikh5B27mqtIY
	iY6drPxLJ+MM4MJxYG2OEO5jo8aDY6A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-yADwCQhLPAOrgYaGq_L3SA-1; Fri,
 18 Sep 2026 09:50:42 -0400
X-MC-Unique: yADwCQhLPAOrgYaGq_L3SA-1
X-Mimecast-MFC-AGG-ID: yADwCQhLPAOrgYaGq_L3SA_1789739440
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D115F1933B54;
	Fri, 18 Sep 2026 13:50:40 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33A6A756;
	Fri, 18 Sep 2026 13:50:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 10/31] KVM: x86/mmu: Init memslot hugepage information for non-private_mem VMs too
Date: Fri, 18 Sep 2026 09:50:09 -0400
Message-ID: <20260918135030.171564-11-pbonzini@redhat.com>
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

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

The list of supported memory attributes is about to grow, and they will
be available on any VM type (as opposed to only ones targeted at
confidential computing). As such, update the check in
kvm_mmu_init_memslot_memory_attributes() to initialize huge page
information if any kind of memory attributes is available for the VM.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 2 +-
 include/linux/kvm_host.h | 5 +++++
 virt/kvm/kvm_main.c      | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b72ccbee0d86..ba462c671f7d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8275,7 +8275,7 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 {
 	int level;
 
-	if (!kvm_arch_has_private_mem(kvm))
+	if (!kvm_supported_mem_attributes(kvm))
 		return;
 
 	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ce5757e85ae3..acffb2f79b3e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2579,12 +2579,17 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+u64 kvm_supported_mem_attributes(struct kvm *kvm);
 
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 #else
+static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+	return 0;
+}
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..3d574e16de45 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2420,7 +2420,7 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-static u64 kvm_supported_mem_attributes(struct kvm *kvm)
+u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E503812C2
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400838; cv=none; b=lY7qoKrfUVcg1vmEukTbvdYSi7K3NlHmBSn9M61w2HQdvWfbCUTxRvFjEkpgECpIJBhUm2fmjJT0Em/PJICVMUYHUk/eV8cbDOA6vw9U9BCS9ow3LygT6Y5npmtZ5A27DPBgjgKatRSQeGRKtlqMyAHSxhQ1GCknxZp5X2XZ8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400838; c=relaxed/simple;
	bh=SVV2F8ebZQUTRNqDDxcrlIi1AM3xo4GXFmJpdF26b/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6DgN2AISVsXVsr+7uG01iXCMFvOHUWfMgh3Ne6oOyQved3T+Xf43CrsQk0TKT8S8wlJ2NHSlW4XBViIh5c5cLlCrwjd7tODONME+ymTZmi29IdGvJdTK6mxkVe3KcSbskQOID55yziGgZ3onLzjgTuc/Atq5rqN+QT0ILkgZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jv+bHdaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv+bHdaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785400836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fK6hpv259oIHFodhfLsiUsD3Tx8s1yqYxRfkG08L2y0=;
	b=Jv+bHdaA20UiIsuBM13oyUZPX/BUFpFjdEJIbe+9UHD8AsySnEq9nMWq4QH1jo91GKZ5dB
	IvE87JmBMdTga9Q7zuyWnn2jHU9KUkIhGr5SS/TID0KfY6pZK/Kt2J6hP2ZKiKE7ERUefA
	yOst/i1JOM5fqpKEnag+xViyM9u95hM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-uWd6tHyzOnyGcv70cZsrFQ-1; Thu,
 30 Jul 2026 04:40:34 -0400
X-MC-Unique: uWd6tHyzOnyGcv70cZsrFQ-1
X-Mimecast-MFC-AGG-ID: uWd6tHyzOnyGcv70cZsrFQ_1785400833
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADE661800378;
	Thu, 30 Jul 2026 08:40:33 +0000 (UTC)
Received: from f44vm (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49BB81800480;
	Thu, 30 Jul 2026 08:40:32 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH v2] KVM: have hva_to_pfn_remapped write-upgrade PTEs
Date: Wed, 29 Jul 2026 05:21:12 +0200
Message-ID: <20260729032112.20629-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
mmap") was merged, a guest write to an unpopulated PTE from a mapping
backed by a DRM GEM BO triggers a VM exit with EFAULT, with
hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.

This happens because that commit implements pfn_mkwrite for
drm_gem_shmem_vm_ops. With that function present, vma_wants_writenotify
returns true in vma_set_page_prot, clearing VM_SHARED and leading to the
entry to be installed as read-only. This is done on purpose so the
fault handler gets nofitied when the entry is going to be written.

In KVM, hva_to_pfn_remapped calls to fixup_user_fault to trigger the
fault handler but, as seen above, this one might install a read-only PTE
even with FAULT_FLAG_WRITE present in fault_flags. The check a the end
of hvf_to_pfn_remapped notices that the entry is not writable despite
this being a write fault and sets p_pfn to KVM_PFN_ERR_RO_FAULT.

To address this issue, have hva_to_pfn_remapped issue a second
fixup_user_fault call when needed for write-upgrading the PTE.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 virt/kvm/kvm_main.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..8d8b4a974ab0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2936,6 +2936,21 @@ static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
 	return true;
 }
 
+static inline int do_fixup_user_fault(unsigned long address, unsigned int fault_flags,
+				      struct follow_pfnmap_args *args)
+{
+	bool unlocked = false;
+	int r;
+
+	r = fixup_user_fault(current->mm, address, fault_flags, &unlocked);
+	if (unlocked)
+		return -EAGAIN;
+	if (r)
+		return r;
+
+	return follow_pfnmap_start(args);
+}
+
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
@@ -2957,27 +2972,28 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
 		 * not call the fault handler, so do it here.
 		 */
-		bool unlocked = false;
-		r = fixup_user_fault(current->mm, kfp->hva,
-				     (write_fault ? FAULT_FLAG_WRITE : 0),
-				     &unlocked);
-		if (unlocked)
-			return -EAGAIN;
-		if (r)
-			return r;
-
-		r = follow_pfnmap_start(&args);
+		r = do_fixup_user_fault(kfp->hva,
+					(write_fault ? FAULT_FLAG_WRITE : 0),
+					&args);
 		if (r)
 			return r;
 	}
 
 	if (write_fault && !args.writable) {
-		*p_pfn = KVM_PFN_ERR_RO_FAULT;
-		goto out;
+		/*
+		 * VM_PFNMAP fault handlers may install read-only PTEs via
+		 * vmf_insert_pfn(), deferring the write upgrade to a second
+		 * fault. Trigger that upgrade now.
+		 */
+		follow_pfnmap_end(&args);
+		r = do_fixup_user_fault(kfp->hva, FAULT_FLAG_WRITE, &args);
+		if (r) {
+			*p_pfn = KVM_PFN_ERR_RO_FAULT;
+			return 0;
+		}
 	}
 
 	*p_pfn = kvm_resolve_pfn(kfp, NULL, &args, args.writable);
-out:
 	follow_pfnmap_end(&args);
 	return r;
 }
-- 
2.55.0


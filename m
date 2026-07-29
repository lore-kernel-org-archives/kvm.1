Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86643634F
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418306; cv=none; b=afXFeDSWWJ+wzfJq6454YQhgvOOlDs7sGyQ0ioDIneF0tSm8um9IylrO2B6dSO3RXg074dyFODO1A6R8TZF2dG90l4UjX8LbZUxI2tfSIZIDd7OWwmaA2adD1xY3SMEoDjMYT/dmo5PilmyUIeGG4SnIcbRfPpm4m5vcKCsfMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418306; c=relaxed/simple;
	bh=yw/CDop3ILPqEjhzyiaV3Klx/faecUZyRdOU/2F7VdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUP6kndR8iNMonWJlf/OVPxnHWhimv1NQ7uemt4ImNQ+FGScPmG3lpGSfX1PWBeh1edpnUzt8U4qOWIeYVODUKtiYawUXhmCNDnz/nBx+JUg3/sqbLFkS5bA+IrTBWAOSBhz0aJ7sSXUq3txEChfa8zwn7QCFxD4+8npn3G6UuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1Yq2Nmd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Yq2Nmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785418304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pGY4cGsjYYOSxPFmpAiRjiLYbtxshAoVfOi5/mNoXbA=;
	b=C1Yq2NmdIJCNanvIJHM/xFGKGOvSpQvtml9MpZn2lNUcoGlsrhGttg+3cTC6W3i3cKcCZo
	Jj3GjsemalbWz19HSwJBRPSicqj4QrN/T8E4huy6sTp8piEY9xEaO3WBX9wiEVee1PTsVo
	T+YCQ2dvsDwYGmYNU/M6t/qggFDrhIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-qpQ4aNKYPSuLGNvz9kufRw-1; Thu,
 30 Jul 2026 09:31:40 -0400
X-MC-Unique: qpQ4aNKYPSuLGNvz9kufRw-1
X-Mimecast-MFC-AGG-ID: qpQ4aNKYPSuLGNvz9kufRw_1785418299
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E00C19560B7;
	Thu, 30 Jul 2026 13:31:39 +0000 (UTC)
Received: from f44vm (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C31730002E9;
	Thu, 30 Jul 2026 13:31:37 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
Date: Wed, 29 Jul 2026 09:20:44 +0200
Message-ID: <20260729072044.25796-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

After 28e39181 ("drm/gem-shmem: Track folio accessed/dirty status in
mmap") was merged, a guest write to an unpopulated PTE from a mapping
backed by a DRM GEM BO triggers a VM exit with EFAULT, with
hva_to_pfn_remapped setting p_pfn to KVM_PFN_ERR_RO_FAULT.

This happens because that commit implements pfn_mkwrite for
drm_gem_shmem_vm_ops. With that function present, vma_wants_writenotify
returns true in vma_set_page_prot, clearing VM_SHARED and leading to the
entry to be installed as read-only. This is done on purpose so the
fault handler gets notified when the entry is going to be written.

In KVM, hva_to_pfn_remapped calls to fixup_user_fault to trigger the
fault handler but, as seen above, this one might install a read-only PTE
even with FAULT_FLAG_WRITE present in fault_flags. The check at the end
of hva_to_pfn_remapped notices that the entry is not writable despite
this being a write fault and sets p_pfn to KVM_PFN_ERR_RO_FAULT.

To address this issue, have hva_to_pfn_remapped issue a second
fixup_user_fault call when needed for write-upgrading the PTE.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 virt/kvm/kvm_main.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..82c5a6b94267 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2941,6 +2941,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 {
 	struct follow_pfnmap_args args = { .vma = vma, .address = kfp->hva };
 	bool write_fault = kfp->flags & FOLL_WRITE;
+	bool unlocked = false;
 	int r;
 
 	/*
@@ -2957,7 +2958,6 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
 		 * not call the fault handler, so do it here.
 		 */
-		bool unlocked = false;
 		r = fixup_user_fault(current->mm, kfp->hva,
 				     (write_fault ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
@@ -2972,8 +2972,27 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
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
+		r = fixup_user_fault(current->mm, kfp->hva, FAULT_FLAG_WRITE,
+				     &unlocked);
+		if (unlocked)
+			return -EAGAIN;
+		if (r)
+			return r;
+
+		r = follow_pfnmap_start(&args);
+		if (r)
+			return r;
+
+		if (!args.writable) {
+			*p_pfn = KVM_PFN_ERR_RO_FAULT;
+			goto out;
+		}
 	}
 
 	*p_pfn = kvm_resolve_pfn(kfp, NULL, &args, args.writable);
-- 
2.55.0


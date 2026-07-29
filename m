Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A745FFAA
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344922; cv=none; b=pAYwcgawe1ml9/gsoeahd40DUTf6qmU1+9E1aVMK7MOQn9SnPjH3mVPGiDejvD7E7refLfbSITI8l0MQbZanKQxJPVhT3GXetQDXC7PAoITGdH/W1T0Kwvp6euV+oPf9Dd/y8iGo2jUzXrJj8DSVHSSYJoj0pD+9miIxGNps+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344922; c=relaxed/simple;
	bh=jdheDfMSBdsBpNuf0vbeX09uh0EO6/hT7iYmJDPNLj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPbgrd1BvvHphXVqoyyXBA/B1uNMVRdZW8PC2tWdfqDNw1yttrk2Bx9FbduUpuz4iOGKhlwQ+28qafdFI2tLba92tuvy2gAFmAT8kd55J6aiDK1LwdktZ/I8IruHvyY/bRZFk7vT5e2ZFYmB6deUSUONyWlOXZSSdUQuUWKXSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVIdsM0T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVIdsM0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785344919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U3uECx5RxC4uoZwseGRqmAnkB9fKdRsZfDGQGKi4ThQ=;
	b=HVIdsM0TqqZEdlEM2AoJFKYmQcIj3dS0JvgE7855zlpeOArKNGKG9wMTm9j+2AVSQ/2eSz
	dma0gDrRCPkCpDSBFruEVQEGexO59HHTpkRizWlu7XyY6s2CPR4ihj7DlICFo53b1v+7tu
	oeOx6Ysf2BByv717vPkOPZS417HcXvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-KAkVHrpKORGF3xTgtrrQ3A-1; Wed,
 29 Jul 2026 13:08:36 -0400
X-MC-Unique: KAkVHrpKORGF3xTgtrrQ3A-1
X-Mimecast-MFC-AGG-ID: KAkVHrpKORGF3xTgtrrQ3A_1785344915
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ADAC195608E;
	Wed, 29 Jul 2026 17:08:35 +0000 (UTC)
Received: from f44vm (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA6A5195608E;
	Wed, 29 Jul 2026 17:08:33 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH] KVM: have hva_to_pfn_remapped write-upgrade PTEs
Date: Wed, 29 Jul 2026 03:42:23 +0200
Message-ID: <20260729014223.17937-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
 virt/kvm/kvm_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..a398f4677854 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2958,6 +2958,8 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 * not call the fault handler, so do it here.
 		 */
 		bool unlocked = false;
+		bool write_upgrade = false;
+do_write_upgrade:
 		r = fixup_user_fault(current->mm, kfp->hva,
 				     (write_fault ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
@@ -2969,6 +2971,17 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		r = follow_pfnmap_start(&args);
 		if (r)
 			return r;
+
+		if (write_fault && !args.writable && !write_upgrade) {
+			/*
+			 * VM_PFNMAP fault handlers may install read-only PTEs
+			 * via vmf_insert_pfn(), deferring the write upgrade to
+			 * a second fault. Trigger that upgrade now.
+			 */
+			write_upgrade = true;
+			follow_pfnmap_end(&args);
+			goto do_write_upgrade;
+		}
 	}
 
 	if (write_fault && !args.writable) {
-- 
2.55.0


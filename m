Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181794;
	b=oQ1H7Fy/LxGXFhsSK212aReZRf8kf1IXq+HiPUDuKzNIo0omBjCAztPnN1TEZXe68nFW
	 1eRnJWZE46/73X0cecO0fE8cHbkLtmUSOKm+iEg1aHaJOx+qYHORw7Oq88qHN9qwaSaw/
	 0+v29NbpOFbx3H53qKMvuRmavV4hoZ9dVi1UvXnHvm/zX4ETNvuRRlqAWv//dyPCsDUbv
	 DM+X9bu0ds1lYgxJraZydR3oOFPZ6WQ8805FLs6wqSKcQeuaO4e3N6I/Y9xuESllo0iOZ
	 +oatN7bMxKpWocMirlfJkypvEckJ/uh0Yt8gniYiuq4esNZmaSKsnHFPywY0nf5ijMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181794;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=JB6yJU/tPLmNVtr5U4XzW0AQKtEoPkXmKtJ0W88w+8Q=;
	b=YCT8o5IhGbPhPi/cZMXenBPaS0100TRajfcunYlb1Dw1gtsR7OMonDPhHgbhbEhRFgQ7
	 +cp55QpPg3Xj5m46mzcCBQngwSgbbAtXr7iuIzGF5zNxrrFQ1o5uK2KKrxdt9MohS+vcZ
	 L2c7NVF4nsV2t3CTqadKyTafOGqb9g3SCE+8NMvtkhLB1y+IhOVCMbBTHlz4Ebrl6oAVZ
	 7ghVln7f0dNcekI5nkn0ahGCqCA4HDI/1KaAgdyxdTkzkV9xajKunsy2k3nRkCSFf/R0S
	 e3asMB9aGrpAp+WQCbQuJ2ybVBuppoZG3+xRVhX+IsbLLfOVtmr0oYG7Q5qWxHLvHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CkwSGSpb;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E1606A320
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 13:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08E1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CkwSGSpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795181791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JB6yJU/tPLmNVtr5U4XzW0AQKtEoPkXmKtJ0W88w+8Q=;
	b=CkwSGSpbJy/awq6y/xE9rh/y0fab5mZoF/k8VJV/2Jz1AbLSGnN1y2NnzIh9P1xcZRcQKJ
	C3EyFMrm74cQNqRMxrudsqjcRwqOeB5uzkFYsW1jZW0qu8EW3+zEyEOsrbcPG+KCD4KgRM
	QE8UFzzt754oSbgoaUkkAnrfJ/IVFic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-lZQ7p09zOwyfL8gkZ1Sa6g-1; Fri,
 20 Nov 2026 13:36:27 +0000
X-MC-Unique: lZQ7p09zOwyfL8gkZ1Sa6g-1
X-Mimecast-MFC-AGG-ID: lZQ7p09zOwyfL8gkZ1Sa6g_1795181786
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66A3919560B4;
	Fri, 20 Nov 2026 13:36:26 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85216195B3CD;
	Fri, 20 Nov 2026 13:36:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	npiggin@gmail.com,
	maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] KVM: PPC: implement .flush_memslot for BookE and Book3S-PR
Date: Fri, 20 Nov 2026 14:36:23 +0100
Message-ID: <20261120133623.479601-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

kvm_arch_flush_shadow_memslot() is called when memslots are deleted and
moved, with no MMU notifier invalidation.  This means that the shadow
pages (HPTEs for PR, TLB entries for e500) retain mappings from host
pfns to the old slot's gfns.

Implement the callback by unmapping the GFNs in the same way that Book3S-HV
does it.  Note that kvmppc_core_flush_memslot_pr() does not need TLB
invalidation, because kvmppc_mmu_pte_pflush() calls invalidate_pte()
on the entries, and that in turn invalidates the entry through either
the tlbie instruction or mmu_hash_ops.hpte_invalidate().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/book3s_pr.c | 8 +++++++-
 arch/powerpc/kvm/booke.c     | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 1894968f2c25..66a9e446ab64 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1893,7 +1893,13 @@ static int kvm_vm_ioctl_get_dirty_log_pr(struct kvm *kvm,
 static void kvmppc_core_flush_memslot_pr(struct kvm *kvm,
 					 struct kvm_memory_slot *memslot)
 {
-	return;
+	struct kvm_gfn_range range = {
+		.slot = memslot,
+		.start = memslot->base_gfn,
+		.end = memslot->base_gfn + memslot->npages,
+	};
+
+	kvm_unmap_gfn_range_pr(kvm, &range);
 }
 
 static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ba762ac1fb56..fffb28fe9a0f 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1844,6 +1844,14 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 
 void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
 {
+	struct kvm_gfn_range range = {
+		.slot = memslot,
+		.start = memslot->base_gfn,
+		.end = memslot->base_gfn + memslot->npages,
+	};
+
+	if (kvm_unmap_gfn_range(kvm, &range))
+		kvm_flush_remote_tlbs(kvm);
 }
 
 void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr)
-- 
2.56.0


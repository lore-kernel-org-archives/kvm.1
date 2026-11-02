Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641303;
	b=TmCRW7y99Sbt63kD6qpIggQF9ZXupkdbYBT3TpFCFLG2WkFL5IFpEw1lsctVkaBxQYgf
	 mM0DYWm30rJKslFYiS8dCfyvlbSqC/W9AjE8oN3JnHczJPeaxXAEzq+OYLDONZC0TJ8af
	 OLa+CvkRz2Xy+wNYbBxMw7MpDAkDKUbazfYmUGR1Wdw96H9Yzi53euFpI3Oxpcz7jgdHZ
	 gE3QKJWpQzZ/VhGblAOTZwWT9RUqUpKl/577G1bdt5xRCwaj4gvp3dAehx+OMLMNyLlWl
	 ZbtVKBFaBFz9NFS7YCaK0YQbvwECI4ov7Xe4GrOFDC5MYrm85aJrstYcB+f2Ym81jDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641303;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=lHnANvxJyXsLw0XejdY5Eq/QOaFEXa11Lq5TyxWMu2s=;
	b=HSKYD7FXDQNagAlVi08Kv+EzkrErqMsoYELypA4tKCNal7G+ciPw/6d8IHzq4U9CFa8O
	 G6tTYsRnFvOBVYt3XbannH5/goSDk1gUetXgeLpu6zx9NrpOylAAFDAAh1JH2zfccXD+p
	 l+63Om2IOFKFjwdCeMkFSP/340x1Fmzy/9hI6SuV4yQ4qErKJol8jnXzA8RQOUd7PjJrJ
	 CrcF1/m2vDym1CtYpA22vTfTATQrMAW+x+s13dl38O6PyiZDsEHnM3LDAKCgV+AZMQU49
	 y876JEasfmz2LHKeaOy5Lbhk+QOQTnaOnpEyVQvKu75zimH3OFTyQ418Tt4m298pd+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0zRQCFc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF66072213
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BADF66072213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0zRQCFc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHnANvxJyXsLw0XejdY5Eq/QOaFEXa11Lq5TyxWMu2s=;
	b=A0zRQCFcu8tq7P6YG1DJKHbEm5KH66jI8dWwec2E3cQeSAXm48ABqs2lDfur/B55DkFlLn
	d+d1d595y2M45raWw/vzdiN3w68WPIHQI1+pxbGmzh7B8mIh71UFjlSAhoBzHdGFbRYZM1
	Eijaa5Si9hOjXJ237hfQbpZpE7HdwaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-xq5ET86oNkukWUBrvqlgKA-1; Mon,
 02 Nov 2026 12:41:39 -0500
X-MC-Unique: xq5ET86oNkukWUBrvqlgKA-1
X-Mimecast-MFC-AGG-ID: xq5ET86oNkukWUBrvqlgKA_1793641298
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA1941800EF7;
	Mon,  2 Nov 2026 17:41:38 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E6AD1800347;
	Mon,  2 Nov 2026 17:41:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 12/45] KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with fault->map_writable
Date: Mon,  2 Nov 2026 12:40:56 -0500
Message-ID: <20261102174130.8779-13-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

fault->map_writable is currently a pure output of __kvm_faultin_pfn(),
which is the only thing that restricts it.  This will no longer hold once
memory protections derived from memory attributes are applied: those
compute their own access permissions that combine with those from
__kvm_faultin_pfn().

Applying them *before* faulting in the pfn lets a fault that violates
the attributes exit to userspace without the cost of gup and/or an
async #PF; but it means that permissions will then be restricted in two
independent steps, first by memory attributes and then by __kvm_faultin_pfn().
Switch fault->map_writable to that model by letting kvm_mmu_faultin_pfn()
only clear bits rather than assign them.

No functional change intended: nothing writes fault->map_writable between
the initializer and __kvm_mmu_faultin_pfn() yet, so the AND is equivalent
to the assignment it replaces.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-9-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a2cc6a17a9b..38a4583d1ec2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4688,7 +4688,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return r;
 	}
 
-	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
+	fault->map_writable &= !(fault->slot->flags & KVM_MEM_READONLY);
 	fault->max_level = kvm_max_level_for_order(max_order);
 
 	return RET_PF_CONTINUE;
@@ -4698,13 +4698,14 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				 struct kvm_page_fault *fault)
 {
 	unsigned int foll = fault->write ? FOLL_WRITE : 0;
+	bool writable;
 
 	if (fault->is_private || kvm_memslot_is_gmem_only(fault->slot))
 		return kvm_mmu_faultin_pfn_gmem(vcpu, fault);
 
 	foll |= FOLL_NOWAIT;
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
-				       &fault->map_writable, &fault->refcounted_page);
+				       &writable, &fault->refcounted_page);
 
 	/*
 	 * If resolving the page failed because I/O is needed to fault-in the
@@ -4713,7 +4714,7 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	 * other failures are terminal, i.e. retrying won't help.
 	 */
 	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
-		return RET_PF_CONTINUE;
+		goto out_pf_continue;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
@@ -4734,8 +4735,10 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	foll |= FOLL_INTERRUPTIBLE;
 	foll &= ~FOLL_NOWAIT;
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn, foll,
-				       &fault->map_writable, &fault->refcounted_page);
+				       &writable, &fault->refcounted_page);
 
+out_pf_continue:
+	fault->map_writable &= writable;
 	return RET_PF_CONTINUE;
 }
 
@@ -5054,6 +5057,7 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
 
 		.pfn = KVM_PFN_ERR_FAULT,
+		.map_writable = true,
 	};
 	int r;
 
-- 
2.52.0



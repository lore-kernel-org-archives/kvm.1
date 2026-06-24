Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C8346AF1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336669; cv=none; b=uikV1mvu7hw4q7OWCTp4IU3uGFRDoJX0F6anj7xuVhU0xixbU19u2YUhPHaooC/g3TON2TuSVbXvIqlxe57G0Hnpw3mRJq5zsTs3nL165Mt//ooLQ+ZcKrBGI/ytymZ+gZmFDqWPSedtaOQaYvcS+4mUsqV6JyyXE6LFbUFC3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336669; c=relaxed/simple;
	bh=n42LjBsDvIFDa5idvUB8ck5e4VnUqKJNczzsm6yIdp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHgKNA/quvd8fqx2WgSz0FN3U9+645t0Kcs49uY+79ubuQvo9+fb1L7OgUL8wPOCYaR9X0MkMcb86gnZJveG32BCDUV710w1omIFw3eExdV6fWDa/0l8KQf4Ldx1ms3W4RBkxFwgUSQrOPTPJUG5jVYFxjao9uotjnWRsLh0JIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxSdn/xR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxSdn/xR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhCwpFn29jL2ni23zoMlEdsYUUI2AA6MKVdjgY1Ntns=;
	b=cxSdn/xRYFdkVU/uAo69INKNQy1uddyn2pFVQNSOKFG+7N+xdIAkkUxwhkbhGp6dE2OKel
	8cBsCFY4ro0fyHuX3Urr5RsycLjbMkdIjh2ypZT28MnHWYHP3Z/iYe3D8XeGzB4QZWB4Nx
	2KPVDKXu1Q03tZj0wVNqe2gdzcPyfvM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-IP3OHO68OtS9htFAIIPu6w-1; Wed,
 24 Jun 2026 17:31:05 -0400
X-MC-Unique: IP3OHO68OtS9htFAIIPu6w-1
X-Mimecast-MFC-AGG-ID: IP3OHO68OtS9htFAIIPu6w_1782336664
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF47E195608F;
	Wed, 24 Jun 2026 21:31:04 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46F471956041;
	Wed, 24 Jun 2026 21:31:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 01/19] KVM: x86/hyperv: remove unnecessary mmu_is_nested() check
Date: Wed, 24 Jun 2026 17:30:44 -0400
Message-ID: <20260624213102.71082-2-pbonzini@redhat.com>
In-Reply-To: <20260624213102.71082-1-pbonzini@redhat.com>
References: <20260624213102.71082-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Just always go through kvm_translate_gpa(), which will either invoke
the vendor check or just return hc->ingpa back.

This is a better way to fix the issue of commit 464af6fc2b1d ("KVM:
x86: check for nEPT/nNPT in slow flush hypercalls", 2026-05-03).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fd4eb1e561f7..0b5050cccab4 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2045,10 +2045,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * flush).  Translate the address here so the memory can be uniformly
 	 * read with kvm_read_guest().
 	 */
-	if (!hc->fast && mmu_is_nested(vcpu)) {
-		hc->ingpa = kvm_x86_ops.nested_ops->translate_nested_gpa(
-					vcpu, hc->ingpa,
-					PFERR_GUEST_FINAL_MASK, NULL, 0);
+	if (!hc->fast) {
+		hc->ingpa = kvm_translate_gpa(vcpu, vcpu->arch.walk_mmu, hc->ingpa,
+					      PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
-- 
2.52.0



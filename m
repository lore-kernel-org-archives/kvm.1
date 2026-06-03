Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B443D4F6
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484306; cv=none; b=HTKXBSBDyroxxFzUoRWpAM8X6BC63IJDQ0UBSlKVFCT1mKEI8NfqgS8x/fBtx99j4WqOgmUnYlMmb0Mc8PVCX97AhiPD1XNJgIb9Mac+PbkdysccLWoaz9o4s3kZC1D9pHOW/sxUI1FfsGHaugYFtspuSo1Vx7F25dAKsRY0Z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484306; c=relaxed/simple;
	bh=bPYfMbvOBKU32p3ra4LQVT35dUe5aIW0jZc2InSi8GE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9M8uZfCrRDuJqauYeZj62mqiO0CtAJDO5bSEBpw6nfclsn+fg75KlwOfMZK44T2/uTLSpdnuG/3cmIlAfiVueiwX8LEv2LZE8SWdpN5vXcb71mpgAmF0LP9rY07poxqxawwdMaM4U6m/OExs18ldL5lOpdOa9HASIl1QLBEU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/kiRiSK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/kiRiSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcXNE2ohVHzsWnkzBLylsxrQ8cOzy7jBak/ymstitHc=;
	b=H/kiRiSKdrmtn3756lyQLEFw5XBDIw6nHQZ6bN1jWEkNui+qGoqFuN4m9jasVrKmIkLrmF
	j13W11JKlSG6tzLVWP5kjH4WQHt++88SUaFIgCjpVG427pxDgEfmDqFaSZim8ecXbcOvYz
	q2KldlKnreSrWOQmC7Epl7cLQNH+Qg0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-LKsWvMulOQOMxhfATAWxhQ-1; Wed,
 03 Jun 2026 06:58:19 -0400
X-MC-Unique: LKsWvMulOQOMxhfATAWxhQ-1
X-Mimecast-MFC-AGG-ID: LKsWvMulOQOMxhfATAWxhQ_1780484299
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6924195606D;
	Wed,  3 Jun 2026 10:58:18 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81F39404;
	Wed,  3 Jun 2026 10:58:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 06/24] KVM: x86/hyperv: remove unnecessary mmu_is_nested() check
Date: Wed,  3 Jun 2026 06:57:56 -0400
Message-ID: <20260603105814.10236-7-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Just always go through kvm_translate_gpa(), which will either invoke
the vendor check or just return hc->ingpa back.

This is a better way to fix the issue of commit 464af6fc2b1d ("KVM:
x86: check for nEPT/nNPT in slow flush hypercalls", 2026-05-03).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 015c6947b462..a374fd64a76a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2040,10 +2040,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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



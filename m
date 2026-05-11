Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1F29D26B
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512017; cv=none; b=ZDYXQvlDgnNm2rTJPA+xuND1PETkf7yqRq6IYx31ws5iCuHPSk/mekLc/Mlb/JndRoYur8pkw0uEIwOBwvV78txmH8TLnIxww/EvsO9SFue6fKyG9Mid5ZkbpaDx2bYz5nJrnlcqcHn0T46132p8VPV0m0fBneVOCDxY8DEEVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512017; c=relaxed/simple;
	bh=bPYfMbvOBKU32p3ra4LQVT35dUe5aIW0jZc2InSi8GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjCE2715iLaFaUrxUR+gshxhbsldR336uyGAEeZYTOH+jSlVQiJVYkATWiNEYKE6978kh4b+kHgCGYs9yw2nAsDkf8Nn7w6V8taf+S+XkDC7Ol+jw9WmDXDr4QxOdXxT024IDPew/RxXL3IdWpb3Qt1VK6dY5u6nMlDuy8YB86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7fi6R2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7fi6R2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcXNE2ohVHzsWnkzBLylsxrQ8cOzy7jBak/ymstitHc=;
	b=A7fi6R2tO/aDzfGgNRvqtpQk2kn6RtlW2vXIN1Anmlr1t0y/NCQ84wJfZGMfrZyHau9FYM
	TuEWikYh01woHA3Erku/GiardxEeLAXx0vnRk4xl/iXov2ZmKs8ro1XLWDt7mZRIS8myxO
	f7J++0b7l2XxpZJEjb7X/t6strQ7S+w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-mSGNH-peNeyFav5HzVHc5A-1; Mon,
 11 May 2026 11:06:53 -0400
X-MC-Unique: mSGNH-peNeyFav5HzVHc5A-1
X-Mimecast-MFC-AGG-ID: mSGNH-peNeyFav5HzVHc5A_1778512013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E83BE195608A;
	Mon, 11 May 2026 15:06:52 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58904180058F;
	Mon, 11 May 2026 15:06:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 04/22] KVM: x86/hyperv: remove unnecessary mmu_is_nested() check
Date: Mon, 11 May 2026 11:06:30 -0400
Message-ID: <20260511150648.685374-5-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-1-pbonzini@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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



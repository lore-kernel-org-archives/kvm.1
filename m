Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB198445AE3
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225719; cv=none; b=Pu5GO2sZqmSH0NGOxFCtlveu8BVfJY9TJjmLt1WxQlZTtXgVEp1mnCNaJU76hTb7R4Hys+juALpVLG5phLc1SVJDLY0wNQzIyLluMUTItERFvdUGtBnenr5MIFDrfLtdXO+NHM3M9V/+Eyhd11/lULd/tYknxIGgFcRZxC0pVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225719; c=relaxed/simple;
	bh=w7MCxn6ioQ4dt8pPbZ0HMRdHRJUHlmZ0rQY/csJg0AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry3Xk5CZtvIYNygXcg+ysbUpl8t0+eWa79Kmhmh7i3lLXT/lHmywoqkLLQ3xDlSH5cbQQGRz4TtDIIzoril6L6v8tMRbzYD6JQf8Uy8qxeBw0PxPXg0RY7s4e0s+qNPnbwtyClxZr9jl88v6yG16PRxlJBsDI6hNsq0nvWZBEUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZuvD1qQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZuvD1qQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgIXjluZig1qTYu6rzzcNeV9+C4wTNcZU/cG7DYvGAA=;
	b=aZuvD1qQNWWBcWeJitDHmCwq6RMzdnuG8jC8SLZ8hLwI30Nhip/9mMmH9OOy1aY+pWo7Kw
	TbgOUskBtwY+Ci2r8e33s3EKniOl2NSaq/bW0vpKhUuKdgE3nMOfit70eY8xQHCVqtOzJ9
	RQBf9rljCSSlsGRKnjvNkaY7cJ6ue/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-uEvr9yjKM7mg2uMsjz18zQ-1; Thu,
 16 Jul 2026 14:15:09 -0400
X-MC-Unique: uEvr9yjKM7mg2uMsjz18zQ-1
X-Mimecast-MFC-AGG-ID: uEvr9yjKM7mg2uMsjz18zQ_1784225708
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F4B31955E87;
	Thu, 16 Jul 2026 18:15:08 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE8B51800480;
	Thu, 16 Jul 2026 18:15:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 16/24] KVM: pfncache: Fail to refresh if it contains memory protections
Date: Thu, 16 Jul 2026 14:14:48 -0400
Message-ID: <20260716181456.402786-17-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Track the memory attributes generation as part of pfncache's data,
invalidate the cached information if the generation changes, and fail to
refresh the cache if restrictive memory attributes are found within the
GPA range.

Similar to how pfncache disallows caching gfns mapped within read-only
memory slots, gfns marked as read-only by memory attributes will also
fail to initialize. Unsurprisingly, the same behaviour applies to gfns
mapped as non-accessible (NR/NW), while non-executable mappings are fine.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/pfncache.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 46ffae69fe77..39935740136d 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -298,7 +298,18 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 		    gpc->gpa != gpa || kvm_is_error_hva(gpc->uhva)) {
 			gfn_t gfn = gpa_to_gfn(gpa);
 
+			/*
+			 * RW memory attributes are incompatible with GPC. The
+			 * RW protection check has to happen after storing the
+			 * generation number.
+			 */
 			gpc->attrs_generation = kvm_mem_attributes_generation(kvm);
+			if (kvm_range_has_rw_memory_protections(kvm, gfn, gfn + 1)) {
+				gpc->uhva = KVM_HVA_ERR_BAD;
+				ret = -EFAULT;
+				goto out;
+			}
+
 			gpc->gpa = gpa;
 			gpc->slots_generation = slots->generation;
 			gpc->memslot = __gfn_to_memslot(slots, gfn);
-- 
2.52.0



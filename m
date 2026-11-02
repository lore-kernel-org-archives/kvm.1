Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641524;
	b=5FaobWnzUlZaSc/h6xP+3tD27ga+6n9LNxzPdBV6cg9XYd/WXCVHYkN4ehdVg1PfN+Iq
	 xAJ5Cdkwze4uitQJCzF+HhzhipmVTVQ2ceYZdx2U3GvD6tswkr26ywgkeHXRY0xKGZMfa
	 cdL/3JK/AKuVDZ82YQRnngExcIqw3f2YqSuB8bcjxSsDwKw8KfHr1wrC1jnhS6nGH4pCO
	 rDqUsW13C7IFj12UVIIW/3Ne+/LREl9+V5XvPeBrcboHmg/g/mNeA/eXi0czUdbyrBteD
	 rT4wR1ngHKGSnaNMnxgOWP/8m8jMFcUhcyt0Yp+5dmjZbVQQ8QS9Q6QPx69cNhN4bRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641524;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=XC9Is9rXqzcPBG5x4tSNSc/H4OLmgshhY/d9C2DzEVk=;
	b=nq1kjWVBe93+yEKmZPOU+8aWugdrWPTQuBN6dfp7fXHO8WkGzBR6SRbl7eZ9AUPvYlQl
	 pU1IEiNDAnfUk7kPXNQtox7QzAPPARIzGHnlmOJGVFACl08aCu2Qy7ZmXRXq44ciezM/x
	 HZ2/51cOO+Ut542xj8vf1EnRRLBQ7HXA8MaM6G/F9zbEMSygZujuNxAp/J+WUFmf1gGKJ
	 iAKC6CBFy99KWqwP5KfopX/Ne3M5+5q0UXdnfxm0wmFd/5BFWyIq8a1P2DFqNfKG8kbky
	 uhds43x+xdKI6v1ggrS2fedU+g4D+Bb+qIwIt00P6P7P3QvKFR4hS/INoFL7wrsNyww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AmMnP+8g;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316B60A261A
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6316B60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AmMnP+8g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XC9Is9rXqzcPBG5x4tSNSc/H4OLmgshhY/d9C2DzEVk=;
	b=AmMnP+8gKVm4xEr+PcNrqzXwZmhNJLG1wkcla/e9u0JfythxAIHUuHJ0kcXHPAVeWVNkmu
	Jrg1dyshl5ViAPKmGFTY7JNVBcVZ8vnw9lu0bEkcka1HOyKoV1KS+U0bO7BnlPmT+JFHO2
	vnJElCNwC6Lm3cdnphGaDASnsw9rQVQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-idWzm0NjMemLf-cYkJFKAA-1; Mon,
 02 Nov 2026 12:45:20 -0500
X-MC-Unique: idWzm0NjMemLf-cYkJFKAA-1
X-Mimecast-MFC-AGG-ID: idWzm0NjMemLf-cYkJFKAA_1793641519
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 826D11955F6F;
	Mon,  2 Nov 2026 17:45:19 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B8981956087;
	Mon,  2 Nov 2026 17:45:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 26/45] KVM: pfncache: Fail to refresh if it contains memory protections
Date: Mon,  2 Nov 2026 12:44:53 -0500
Message-ID: <20261102174512.8903-10-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Similar to how pfncache disallows caching gfns mapped within read-only
memory slots, gfns marked as read-only by memory attributes must
fail to initialize. Unsurprisingly, the same behaviour applies to gfns
mapped as non-accessible (NR/NW), while non-executable mappings are fine.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-24-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/pfncache.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index e82247ca4637..ed8884a6d240 100644
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



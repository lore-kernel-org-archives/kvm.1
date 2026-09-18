Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47CA5158BD
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739462; cv=none; b=YMiYE7rHlNjrI/Acg1e5dc5BnH8/VJGaI4RxPsnpEmdGFTCDqicFs9zO4sdRDDCTIqpsAF1tT+6OVFnE2sUagVeAr/o5//b7KYToA0T5iB6C7BBlAweu8RCk40sUiAsojOp/5ael1L82c7OKzUgxKrZ6DSMbXapGSc/WGz7g5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739462; c=relaxed/simple;
	bh=ssbZx19SgT03PitfpW9iwEfiJ7Rq53NzaKL5KpbPZcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3aruD1DJMfWUs1e+U1NZR1YuvV/SUi3BNeMdvDbe1dPPDFp6QI6epaIGSUabd0nKLeM/wffwLWrDU5DqruIf6gfPfqH0AT8OCsddfgpOvX6bexbcd3pmXYIXqHXRW2j9lOnT3pK+3k4JwkTT/mh0gUiSowOD+w43xv9G3fwtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxjOPaXZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxjOPaXZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6y8qshOMUMHy0hJtW9RAYJxeweVqNG/1k4529WtVRE=;
	b=SxjOPaXZnsqz44ROrJHwxnL53HETVq8PpBY4MFwhngo9xlUo9ZHNhDVDJT3brfem5YDuo3
	oOxdrIRSAbugzebfcsg8NV+LSIG6rTDebKEhHrxZcnT/TrLtct/F4SiipsKk1UG3DLc999
	QpkQ+ctcrKlob/HMidg41oQon5KHNUk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-tLi9xtJyNkaXWp4OlkelTw-1; Fri,
 18 Sep 2026 09:50:53 -0400
X-MC-Unique: tLi9xtJyNkaXWp4OlkelTw-1
X-Mimecast-MFC-AGG-ID: tLi9xtJyNkaXWp4OlkelTw_1789739452
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86D2F185BE8B;
	Fri, 18 Sep 2026 13:50:52 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCB6B433;
	Fri, 18 Sep 2026 13:50:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 23/31] KVM: pfncache: Fail to refresh if it contains memory protections
Date: Fri, 18 Sep 2026 09:50:22 -0400
Message-ID: <20260918135030.171564-24-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Similar to how pfncache disallows caching gfns mapped within read-only
memory slots, gfns marked as read-only by memory attributes must
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



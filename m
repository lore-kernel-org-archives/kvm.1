Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62E42DA5A
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719372; cv=none; b=T02p2RT89uITcTSexIwfhxvVJ2sUEPbaScEcQ1+tykQnc6wC7s/WfE+0PqDlN6JxbaSJ/A0QXJrhj5WfeGO4Wi+TemLG6S6lOAMXdRoF1UnngKVbsJ066gBQFvSl0aOhFfoD2ppZ79T7Iop79CGjtZh+TUzitp2VUDrPAeze3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719372; c=relaxed/simple;
	bh=ssbZx19SgT03PitfpW9iwEfiJ7Rq53NzaKL5KpbPZcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsU0S9iM/2BSBIYllUyg6ooSUGkzGoK6IiSU6jqaDCbmgW4XHQgsCkSVQszUh8KfarK1znyd2cImzfHLZ1eIMsPEOv7JEhEx6TR4b6olDS8iNs8uAkMp7MypD9x9CcxrJn/G/IO4fBpV34vOR76aS8LgRlCcqRJojPCuz/Z8L8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETHRCe8I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETHRCe8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6y8qshOMUMHy0hJtW9RAYJxeweVqNG/1k4529WtVRE=;
	b=ETHRCe8IKpZJ96m/E5c/DnJsiGXs/B+ZLeoQd39T1LZKBHOVLtQQvxQPMHvFzGlsEsyqFo
	1nCp1SfEdJBEyezo0MBAN8DTJEEPbsvOr9GdC7Z3DpjTGB2NaBFqFFbXOYOl9JG0AP5sl/
	8MbpigL6HQkAQ/gWoTiFjZSjDQuNUBU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-fmIjR1VnNFiSxhOW6Af9Tg-1; Fri,
 18 Sep 2026 04:16:03 -0400
X-MC-Unique: fmIjR1VnNFiSxhOW6Af9Tg-1
X-Mimecast-MFC-AGG-ID: fmIjR1VnNFiSxhOW6Af9Tg_1789719362
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43BFD18011E9;
	Fri, 18 Sep 2026 08:16:02 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A77C30001A2;
	Fri, 18 Sep 2026 08:16:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 20/28] KVM: pfncache: Fail to refresh if it contains memory protections
Date: Fri, 18 Sep 2026 04:15:35 -0400
Message-ID: <20260918081543.139871-21-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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



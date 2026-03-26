Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1D37CD2A
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536645; cv=none; b=RfOGkZSTRvHWVXMZP0LCRj+/ONBUlGzvD4CudjTnE0cF/3rZrSfxoA5lXe/FmXbtJdnSbNESq0SGiVkZzRj52yySll3OKEQRYWqT7JhURf7vJSxIA7AMvXldqzGzf69EmqPo+zyQJJAw6fGqat3Kbfrm4xx0ADMTi0JYBYlXsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536645; c=relaxed/simple;
	bh=1lYFz2ontLijF27O37mgYHnDHC44fr5ecZOEVp1Pfrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUYT3JFQjwvenl9rDnrXtL2+EYiw3JUtkAu2R39IiPX4k48g/E8fDBlz180aH3CLJ+5SNb3Uf+RcMof/fD1i8k/1JomnSzjXRvjgOjzwBrB80K8ar1v+aTNbmI9LErAY7dXuK2OKP3qPmTLYoO2k1h9J5ZndVC+FelfTh1OV8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcEr0fcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcEr0fcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XndPimpJMswn2Inm0Ekuc9eUfl6qQ/zhndw2ZL3JQJI=;
	b=bcEr0fcfFOpLBNZOWRLoEWLq4Oq4MYiOM2+FZgmVzlI3iGsv3PcqHdsXvCingiljwzvX45
	8ygt3xMhQ7G7twtcdk7TxF4dQTumMxCMeK5Bwf0ZC+0RsborPusQAGA/l77uC8reC1UQF7
	IjMERrHUF2RAoCmTRQFVP6rqlMiadPc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-pYgB4ErTOm2-at7U8X23vw-1; Thu,
 26 Mar 2026 10:50:39 -0400
X-MC-Unique: pYgB4ErTOm2-at7U8X23vw-1
X-Mimecast-MFC-AGG-ID: pYgB4ErTOm2-at7U8X23vw_1774536638
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE9DE19560AA;
	Thu, 26 Mar 2026 14:50:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46F0A180036E;
	Thu, 26 Mar 2026 14:50:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 1/9] move PFERR_* constants to lib
Date: Thu, 26 Mar 2026 10:50:27 -0400
Message-ID: <20260326145035.119519-2-pbonzini@redhat.com>
In-Reply-To: <20260326145035.119519-1-pbonzini@redhat.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Allow using them from the SVM tests as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 lib/x86/asm/page.h | 7 +++++++
 x86/access.c       | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/x86/asm/page.h b/lib/x86/asm/page.h
index bc0e78c7..84a315f3 100644
--- a/lib/x86/asm/page.h
+++ b/lib/x86/asm/page.h
@@ -19,6 +19,13 @@ typedef unsigned long pgd_t;
 
 #define PAGE_ALIGN(addr)        ALIGN(addr, PAGE_SIZE)
 
+#define PFERR_PRESENT_MASK (1ull << 0)
+#define PFERR_WRITE_MASK (1ull << 1)
+#define PFERR_USER_MASK (1ull << 2)
+#define PFERR_RESERVED_MASK (1ull << 3)
+#define PFERR_FETCH_MASK (1ull << 4)
+#define PFERR_PK_MASK (1ull << 5)
+
 #ifdef __x86_64__
 #define LARGE_PAGE_SIZE	(512 * PAGE_SIZE)
 #else
diff --git a/x86/access.c b/x86/access.c
index d94910bf..142c1d92 100644
--- a/x86/access.c
+++ b/x86/access.c
@@ -17,13 +17,6 @@ static int invalid_mask;
 #define PT_BASE_ADDR_MASK ((pt_element_t)((((pt_element_t)1 << 36) - 1) & PAGE_MASK))
 #define PT_PSE_BASE_ADDR_MASK (PT_BASE_ADDR_MASK & ~(1ull << 21))
 
-#define PFERR_PRESENT_MASK (1U << 0)
-#define PFERR_WRITE_MASK (1U << 1)
-#define PFERR_USER_MASK (1U << 2)
-#define PFERR_RESERVED_MASK (1U << 3)
-#define PFERR_FETCH_MASK (1U << 4)
-#define PFERR_PK_MASK (1U << 5)
-
 #define MSR_EFER 0xc0000080
 #define EFER_NX_MASK            (1ull << 11)
 
-- 
2.52.0



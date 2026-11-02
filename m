Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641526;
	b=aADB9XR1mFVuODBDgPsiImJPI/dfSxsI4npuRlw0InYAgSqyp/AmLqQZ6jeMscbCBVIT
	 e4SGDAIGjRN69N+UuXfhDTdbWZWva0pdixoV4ixl1PIC78usmVq68wBrEZJUi5/4oulTl
	 pgpM0YJDIj9mU4/LE9HnY2FYzmoMz+M/pxZKCdlBTeV6qhsK48/08wwrIY9aibNYP0ARt
	 FLq5Mj5MV2rgj3XLNmGp/s0L/AEB9aUKPc3csj+EyHDsZhXLP2Slft6vXmYqgPsgkccAI
	 e7G6nuGHO/6lQXUevjTdMYrg26SmpUddUl7gHOCksY/DaCDZVjy2CWWqFb0WxPiX8Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641526;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=0QKrHwtkaugZNlDFct/lnhTJpQI2+HcaqN9Z71ZINts=;
	b=h7JnKJF3+tC6uvqQszv1ZQ0LmdGytIDIFi9F8ZSc3x+RAJJcKfmAokuihcI07kfQI2Uu
	 b1iSuk9ZgiDRJjlRxn7Hn1g0Fbi1M3k59K1LT04nnxkRjNyYVa3YJPAIn6XeXor3bxhGj
	 hH6LOT7sagHc4Pw8zHDvJfG+XwD57+YuLWvlO8nZZCv2Hu0PzqVBuaBQb0ejjqkfWY57f
	 bn6ifsAkLwNtuXPWkzxa6X+BANsTE67lM9VoOvoj/EKdUcw4X6itB5gqvnSLQ2mKCQ0EW
	 D3E+myXCJo0LxDKbCWJp8YfFbF+WHs5yBZjoIcX7N0QnWdKSx1/kbEZ4gdWAVIxTGqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbcL3oV3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB160A2636
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCB160A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbcL3oV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0QKrHwtkaugZNlDFct/lnhTJpQI2+HcaqN9Z71ZINts=;
	b=DbcL3oV3jI1Hs0hOtZmBv3dH9dk77gNBWfBNZVZjPgxAUZUs+ob1geyAkRExrMI64Ja/NA
	mwuDMNIJzhBoWAT8SJIkG+S6GRCYwEDu4MWVFVNHzoV1jZbe8g5tDHM7WvrADjYMamEN4f
	ThoaPrL3blV1mW4Ussycu+QQhOL7lRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-4Vkw7PgENKW3BH5CPwnMyQ-1; Mon,
 02 Nov 2026 12:45:21 -0500
X-MC-Unique: 4Vkw7PgENKW3BH5CPwnMyQ-1
X-Mimecast-MFC-AGG-ID: 4Vkw7PgENKW3BH5CPwnMyQ_1793641520
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B3D81800D8B;
	Mon,  2 Nov 2026 17:45:20 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FD23433;
	Mon,  2 Nov 2026 17:45:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 27/45] KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory attributes
Date: Mon,  2 Nov 2026 12:44:54 -0500
Message-ID: <20261102174512.8903-11-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Prefetched SPTEs are always given full access.  Do not prefetch GFNs
that have memory protections applied.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-25-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6348669bf882..f689e4890e42 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3240,6 +3240,11 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 		return false;
 
 	for (i = 0; i < nr_pages; i++, gfn++, sptep++) {
+		if (kvm_get_vm_memory_attributes(vcpu->kvm, gfn)) {
+			kvm_release_page_clean(pages[i]);
+			continue;
+		}
+
 		mmu_set_spte(vcpu, slot, sptep, access, gfn,
 			     page_to_pfn(pages[i]), NULL);
 
-- 
2.52.0



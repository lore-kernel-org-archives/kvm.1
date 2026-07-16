Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC0445AE7
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225720; cv=none; b=BtQzjVaEadtY0py/bGKujKSTze22jHh+Z/+H8pM06hZHdZmx9hAbD5OPTHuI7mQn/3ZFsC9PlqQzR49ajRFp8ZEWoattI6Qw9NbZ13Bk5byeohdCMFoeamSIYSgjPY2zeuSfUMqaePLEBmaavvlACneHV5V0FABngNs59FNGB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225720; c=relaxed/simple;
	bh=6utOy21KcM4jcYjjQ5iL5Jv1gjyFvDWujTytWlx+NcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/hIEErxsUmgQdGqmasKuFSYqFe5eV+F4yUH+PbcmphuJYL0i92fZhWNPwAwZW7OlmYWhVWzbJD94S9exn7IJjxKPjzhBfq6ypQMevKqueb7NFFhCanGpxqUicJnC7oTz65Q41wt3dKllQr/0kzibUlhvu6FTMYbInMx36aSezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLcqjqK4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLcqjqK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26RlGOwVuSPPPr5KjC7HxaW648Zwf/4T1lFh+L2G5ZI=;
	b=KLcqjqK4CNSPAbwkkwEgSaOEitIQ4e4zVh6KLGSRirzVbnXvNIMECQwI2Wy2v9b3/1cbDD
	EAK9qwOtJwW8XhGmM1vUdbMDyVXjcgmebsIdu/Lc1QqDvW/v9jWPz7eyytFq6Sg1a4wics
	xMlHj4gPJFSpat77gQv9A8aIDg/GyCQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-phfHM5JiONWll_ixbyeHhQ-1; Thu,
 16 Jul 2026 14:15:12 -0400
X-MC-Unique: phfHM5JiONWll_ixbyeHhQ-1
X-Mimecast-MFC-AGG-ID: phfHM5JiONWll_ixbyeHhQ_1784225711
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9B11955E90;
	Thu, 16 Jul 2026 18:15:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0063E195604E;
	Thu, 16 Jul 2026 18:15:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 20/24] KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory attributes
Date: Thu, 16 Jul 2026 14:14:52 -0400
Message-ID: <20260716181456.402786-21-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Prefetched SPTEs are always given full access.  Do not prefetch GFNs
that have memory protections applied.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 59c2a04f5648..8e85f672a08d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3156,6 +3156,9 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 		return false;
 
 	for (i = 0; i < nr_pages; i++, gfn++, sptep++) {
+		if (kvm_get_memory_attributes(vcpu->kvm, gfn))
+			continue;
+
 		mmu_set_spte(vcpu, slot, sptep, access, gfn,
 			     page_to_pfn(pages[i]), NULL);
 
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A64B486F
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719376; cv=none; b=S1zD2oiw2bRqu+Mm/VnphH3oHBmSTYz8aZVWa26gVDi4YEPVFZ8puyaUevhPLULeBISgja78hjNi9v1Yzs3Rt5fUMnX2UBbqc/l9ipiUVy9b33Nv5VYVU6Nypdz7DNEliT2/lZaztdK0RI8p2L5no7ILYVZHe6BdKKT/RlgyJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719376; c=relaxed/simple;
	bh=3fY4WlcZJ6wOE2Ax39CGRJ/RSbNMWT2vQvLgD0k4WK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4rPsi4beudnZXXtNdZjES4bsXHRLvIajdIXUothsrBBIHzMjbVWY+OrBkRJBS5cc89iB+G3Tslq6qBFUAAqtkoneWof80uAbl6/jwkzlrguam6krHWlEaWIMA1qj0KR5NM3aN82Fi/TRQSfoi8o33m+HXdfKAZWGJ9qGKRzFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhPlChuP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhPlChuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jol8ennk1TZbPIOM6O5ZAfPzLlJYocGjoT0OUGC9e2Y=;
	b=hhPlChuPPmDLK5UiVp3qLWAXMPsQl3nGI2Ol86TuyqUToTMzxe3zQeu278RN5rUtH3Zoep
	Otpb74QDhG4q7AegTt0unH4j0p7oTMMna7wOC5Az6HmFtkMsGNih0AS7MHvM9tkScSju55
	Dy+j4igvBQY0p639bLwDhchvlGDoKEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-VtmDwBMrPVymEKG1956PdA-1; Fri,
 18 Sep 2026 04:16:05 -0400
X-MC-Unique: VtmDwBMrPVymEKG1956PdA-1
X-Mimecast-MFC-AGG-ID: VtmDwBMrPVymEKG1956PdA_1789719364
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD5DC1944DE2;
	Fri, 18 Sep 2026 08:16:04 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1598B30001A2;
	Fri, 18 Sep 2026 08:16:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 23/28] KVM: x86/mmu: Do not update accessed/dirty if guest PTE is read-only
Date: Fri, 18 Sep 2026 04:15:38 -0400
Message-ID: <20260918081543.139871-24-pbonzini@redhat.com>
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

In this case do not go all the way out to userspace and just stomp out
the write.  This is consistent with the way KVM handles read-only
memory slots during emulation, though admittedly inconsistent with
everything else: NPT for example always wants nested page table entries
for the guest page tables to be writable, and will fault.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index d2836a327bc9..2ff655edd57c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -419,6 +419,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			goto error;
 		}
 
+		if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))
+			walker->pte_writable[walker->level - 1] = false;
+
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
 		if (unlikely(get_user(pte, ptep_user)))
 			goto error;
-- 
2.52.0



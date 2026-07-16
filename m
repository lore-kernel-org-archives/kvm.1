Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73F445AD9
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225721; cv=none; b=LT2MypFnv2k5VPFFIYtY9OznBFSBW9n4QRM9Nnr3WAMqILa+/+DQ1FI+ET8++ZW7VWfUK2Gqtd/kkaXqVayEAV+hqYGsFI8rIxxj9LusX7fyIcOmTtIFKsYKiLe7/yW/Cw1YM2cZnziXeLa5CCz4d6uanwNPx8Z1fbMGEQg6tZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225721; c=relaxed/simple;
	bh=3GJ14NznGThun6XqlqpKmqJR+Xni8XyTM17YQYecO3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZdv7LyZo0FtFksjNjPyDtVp/sRAiTl4IB5RmQhjZH3tbxAFxTAomgnAwKoLmsgBJjhwm7WLUi16l3ivrkXtDbOVkOZUfIQ0jny9177vqHjRAAvr+cl+ghfZGscA5DDQAWRCornrwCkQVKgmzhD8rUYOrjybjts2mThKgGS8aO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h113xtS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h113xtS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YDPV/jgMTVU5QltBcVl6pkFbi8mbShuNaZfaELV+ck=;
	b=h113xtS4ASIorLnJki/IGRmDQDmnJnSJdvAOj9jDJIl9W+yiKhFB9CHcrYW4VnLv5wxri8
	l1/JJB+BNwOuMfXXwtcBvZTwsdtBIl3ST6idMJVvbLopvvDg6tewN4ScCs4heO5ONa3wBp
	1OQo7GCKHKPWtYEtq7H6h+fhXArDI8s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-oBwcCW2mOACbpJjPSZ0qUA-1; Thu,
 16 Jul 2026 14:15:11 -0400
X-MC-Unique: oBwcCW2mOACbpJjPSZ0qUA-1
X-Mimecast-MFC-AGG-ID: oBwcCW2mOACbpJjPSZ0qUA_1784225710
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CD861955E8C;
	Thu, 16 Jul 2026 18:15:10 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7FD21800480;
	Thu, 16 Jul 2026 18:15:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 19/24] KVM: x86/mmu: Do not update accessed/dirty if guest PTE is read-only
Date: Thu, 16 Jul 2026 14:14:51 -0400
Message-ID: <20260716181456.402786-20-pbonzini@redhat.com>
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

In this case do not go all the way out to userspace [RFC]

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 23d7a7d9769f..ee5c23d1b77a 100644
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



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E313F23BE
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374600; cv=none; b=iiQDavsk2MrmHmUGlD33OHqNcyS8yoUwVhLXjyokwjPCG/4mgCoW4SL8cW/M/eFnEJM+lZcCXMVb33XGyxRJ0LFn7V7inWphjhQ8w6e6SL8a1Hs7RLIt8XAsx9sd8M7JBWPdAausk64IBF+gHu5gGzbQTW+JrBy4j6O6Wb6jDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374600; c=relaxed/simple;
	bh=BG1kAh7EtMGWmcMC1GlPnoHKnRNOqLKvCGNaN/4yEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdm/ptst+Y9s3efbiXvtuaw4aGIQZ4aGuywSxXA39N9QkS7qj/4VU0JQ5GoHkCgPxijbTFjkl4XowQQmb3L7UgEEXAr7bHfa0R5pRRdAv+e/8R2JZWZGpXLmtlfRJ8/wmJFvNHit1sXFUHvUgQ2Rk9AtNmEfNkaPNN9v4b61E+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB5VPIDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB5VPIDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COO67oamJrUqujxmroIoUz2hjP+GCsrSsINBeLnuCKQ=;
	b=VB5VPIDa+5oCXmVGzV1qpTiP9750H6NZz7wFDg8O3dJN6eb5HsVMGG2LoS8YS4NegS/Gaz
	DRuDy+6Ttsb+dOfIkrHOuzbneekzQnm3cn+8Fzr6RwPFgfr9lj6hS0EJ1e9Rx+MZdD3Iv2
	8cDn7iUMyBksK6Nzp/3pOwfzpGn2e6E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-YGQv8xdhPnuCk936_H7IZw-1; Tue,
 28 Apr 2026 07:09:50 -0400
X-MC-Unique: YGQv8xdhPnuCk936_H7IZw-1
X-Mimecast-MFC-AGG-ID: YGQv8xdhPnuCk936_H7IZw_1777374589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 721681956095;
	Tue, 28 Apr 2026 11:09:49 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D32E03000C22;
	Tue, 28 Apr 2026 11:09:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 02/28] KVM: x86/mmu: remove SPTE_PERM_MASK
Date: Tue, 28 Apr 2026 07:09:20 -0400
Message-ID: <20260428110946.11466-3-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jon Kohler <jon@nutanix.com>

SPTE_PERM_MASK is no longer referenced by anything in the kernel.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-3-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 8c0ffa2cded6..f4dfb8dc74de 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -42,9 +42,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define SPTE_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user_mask \
-			| shadow_x_mask | shadow_nx_mask | shadow_me_mask)
-
 #define ACC_EXEC_MASK    1
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
 #define ACC_USER_MASK    PT_USER_MASK
-- 
2.52.0



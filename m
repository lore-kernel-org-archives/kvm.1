Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C972C21FE
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561682; cv=none; b=jAMHGkyGzeRBDlFx4ZNIn5vym4CjA75fEHUpmBmKIn6ykHMgfdacJIsJ3GVfGTO41iXdMzYUlcgZpNuDfVZu1AHCmvnUfEWj4RCPAm7FNhUhCuuq3AJ8DlR/6hVXHTb3WnSS38XuCcUEYRHGjRlwWjjzPlSLPI8Qx2B70zfeP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561682; c=relaxed/simple;
	bh=SFwAvEejykGMbbJiQ9F6uJQL21XJV9Dx4ZbJgpCL2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLqtTKjxtovt+kH/ul4UQ4wEI43m1c47tjHlHcZMB4oQoUhHmjg5eDY6gyGlbzdXCjV+x+NJ7TLtwI+LS9fu07GJSz9TzJXAy81HTaQiLUHuFbAvngO9f5cm0Y63Nlb80Bqw90eEZfisSBNoUQidDRZ/Dhk4GeaKQoCoKmzvuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5vOrUFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5vOrUFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f02Crf6R+TdJvUvPULZfzFF8yNDEWWCjLIu/znZeFPk=;
	b=T5vOrUFoM+Pdrhpr6CrlvSQ0oOvGVLcyvnPk0PcPq93Xg5SvJju33ydNpnbpFQAEZxR+vV
	jj28u9vhgj9QeG6yXPTmO27RFm3j5Zdqo7dL7yZX3QAXRnTKGhrAMC7ZCObU2pbIABlh4x
	0rewHmPjAtNJuQ3uakWfaAW4TDZlyVQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-Yao7u9fdNQSBfZeKHZ6ayw-1; Thu,
 30 Apr 2026 11:07:54 -0400
X-MC-Unique: Yao7u9fdNQSBfZeKHZ6ayw-1
X-Mimecast-MFC-AGG-ID: Yao7u9fdNQSBfZeKHZ6ayw_1777561673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F9E8195608F;
	Thu, 30 Apr 2026 15:07:53 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19ACC1800577;
	Thu, 30 Apr 2026 15:07:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 05/28] KVM: x86/mmu: remove SPTE_EPT_*
Date: Thu, 30 Apr 2026 11:07:24 -0400
Message-ID: <20260430150747.76749-6-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

spte.h is already including vmx.h, use the constants it defines.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 317b9cd1537c..bc02a2e89a31 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -57,10 +57,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define ACC_USER_MASK    PT_USER_MASK
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
 
-/* The mask for the R/X bits in EPT PTEs */
-#define SPTE_EPT_READABLE_MASK			0x1ull
-#define SPTE_EPT_EXECUTABLE_MASK		0x4ull
-
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
 #define SPTE_INDEX(address, level)	__PT_INDEX(address, level, SPTE_LEVEL_BITS)
@@ -73,8 +69,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  * restored only when a write is attempted to the page.  This mask obviously
  * must not overlap the A/D type mask.
  */
-#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
-					  SPTE_EPT_EXECUTABLE_MASK)
+#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
+					  VMX_EPT_EXECUTABLE_MASK)
 #define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
-- 
2.52.0



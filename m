Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320772D7DCF
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561679; cv=none; b=hGn8VtdYoZ5TdjICDFxOLUDU6nXqt69U/buDHv3u55zBNpF54chY66Yv5Jvs1aoFVs7yagLw7UORlvKlMV6loIz6d5e4eg7ymjgzayb1Cb2W2KPsRbpDqt6tD8Y6qzpTXdeAUjudGz25N5ZE/JEY4b3nWeORVaqBqfSRMAOUrBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561679; c=relaxed/simple;
	bh=O5n71Bz8uoSCSBkrgkRDI29Njuo0IhYKHEcXNw41XFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikceMSbpgrZFaeB8zIGwD3hOSIkb0OjSDC4G8qemcrimNZgVv2u8Se1vOMlvDuBAigjubaVdC6rC8+rluySmHubPdynqvPNdbeJTJLb8DW9KIkS+zAWvPKVvvMQV/kEKKbobQRt+NiMsNX+gF7SHQHWZe6cm/mGl8PEvGVO78fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sdalrniw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sdalrniw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVOkHVzh1v/WWfM+UAvEnyZaqIJvUCbqkVDpCLFz8Ew=;
	b=SdalrniwBCJ6dTJFOZC4B7CPcv8eALUfwhMGsD0/yh75DTi4HqeEJ3snKJyEXltdssI3Bs
	LrGvQeHz9c6JrngJ9Oj+2D8ncSFSrTvTHlke5jmszuYrwmFO1GObthiDsCrdLfuC532ume
	3VJ8XDEzmHPrIQmUvco7kCFGZSa+VcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-q8vQ8q6WP9-HGm5JRq7yTQ-1; Thu,
 30 Apr 2026 11:07:54 -0400
X-MC-Unique: q8vQ8q6WP9-HGm5JRq7yTQ-1
X-Mimecast-MFC-AGG-ID: q8vQ8q6WP9-HGm5JRq7yTQ_1777561673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E717E1956052;
	Thu, 30 Apr 2026 15:07:52 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 342E01800577;
	Thu, 30 Apr 2026 15:07:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 04/28] KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
Date: Thu, 30 Apr 2026 11:07:23 -0400
Message-ID: <20260430150747.76749-5-pbonzini@redhat.com>
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

Access tracking will need to save bit 10 when MBEC is enabled.
Right now it is simply shifting the R and X bits into bits 54 and 56,
but bit 10 would not fit with the same scheme.  Reorganize the
high bits so that access tracking will use bits 52, 54 and 62.
As a side effect, the free bits are compacted slightly, with
56-59 still unused.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 4283cea3e66c..317b9cd1537c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -17,10 +17,20 @@
  */
 #define SPTE_MMU_PRESENT_MASK		BIT_ULL(11)
 
+/*
+ * The ignored high bits are allocated as follows:
+ * - bits 52, 54: saved X-R bits for access tracking when EPT does not have A/D
+ * - bits 53 (EPT only): host writable
+ * - bits 55 (EPT only): MMU-writable
+ * - bits 56-59: unused
+ * - bits 60-61: type of A/D tracking
+ * - bits 62: unused
+ */
+
 /*
  * TDP SPTES (more specifically, EPT SPTEs) may not have A/D bits, and may also
  * be restricted to using write-protection (for L2 when CPU dirty logging, i.e.
- * PML, is enabled).  Use bits 52 and 53 to hold the type of A/D tracking that
+ * PML, is enabled).  Use bits 60 and 61 to hold the type of A/D tracking that
  * is must be employed for a given TDP SPTE.
  *
  * Note, the "enabled" mask must be '0', as bits 62:52 are _reserved_ for PAE
@@ -29,7 +39,7 @@
  * TDP with CPU dirty logging (PML).  If NPT ever gains PML-like support, it
  * must be restricted to 64-bit KVM.
  */
-#define SPTE_TDP_AD_SHIFT		52
+#define SPTE_TDP_AD_SHIFT		60
 #define SPTE_TDP_AD_MASK		(3ULL << SPTE_TDP_AD_SHIFT)
 #define SPTE_TDP_AD_ENABLED		(0ULL << SPTE_TDP_AD_SHIFT)
 #define SPTE_TDP_AD_DISABLED		(1ULL << SPTE_TDP_AD_SHIFT)
@@ -65,7 +75,7 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  */
 #define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
 					  SPTE_EPT_EXECUTABLE_MASK)
-#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 54
+#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
 static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
@@ -84,8 +94,8 @@ static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
  * to not overlap the A/D type mask or the saved access bits of access-tracked
  * SPTEs when A/D bits are disabled.
  */
-#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(57)
-#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(58)
+#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(53)
+#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(55)
 
 static_assert(!(EPT_SPTE_HOST_WRITABLE & SPTE_TDP_AD_MASK));
 static_assert(!(EPT_SPTE_MMU_WRITABLE & SPTE_TDP_AD_MASK));
-- 
2.52.0



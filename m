Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764F3D8106
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662953; cv=none; b=B74KHo6aRPSOKIMDnmO80ZmTm1H2zKUU1l++ZFaJm0T6pgo18rVAoC2qOTmabmvGsWIGIXePIm55pkSbBl+QW3wQhoCuRwug1WmEV2CoZtGEe/vmFWAtwrwAcUE5sE7sIWtUXtrGRaOKtfSROCu0Hf0qRNX/VrcMUN3/u2BY9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662953; c=relaxed/simple;
	bh=lcSCQhvgV13mrQnwNDpyMIm8Qtw3Tg7NXo9VIB4oKEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGxXpwT4h9bRNMToL5cf8U3xdaGXeLdbeDJM0hfSKihDJ6lNGsJZbtqqdWejqVG9HSI8ghBc5u2fEsnCtpjTOQnED9T47m+zu7Rgm19zANvBBe+p1b+Ed8d19stJK/FGnuZ/M39Ur7WWPUulESxwDIduM3J/uxmY8K6Fs2/MVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBqz548k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBqz548k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggsR5mD/t7F3g58B8WA467weQ2q8K4Vnkyfxm48B1Nc=;
	b=cBqz548kQetS95PWFvXWz/Xhzpes/HrMAngSKNQlp8mU3Z73Ef+pfVJX1CnXBeXxGeIHnT
	htV5Ka3v1QK4nfWcS2aFq+NnUkr8IHcWarllw6PRx0CqVS3iahTwyJ3Xrc7aw+JyV0RLDZ
	SFAXmAibT97mtIhIfi1IRyT8TAq9EQ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-Ue7Hg-A_ONeDM9LL52CRjw-1; Wed,
 08 Apr 2026 11:42:24 -0400
X-MC-Unique: Ue7Hg-A_ONeDM9LL52CRjw-1
X-Mimecast-MFC-AGG-ID: Ue7Hg-A_ONeDM9LL52CRjw_1775662943
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB7791956053;
	Wed,  8 Apr 2026 15:42:22 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FE61180036E;
	Wed,  8 Apr 2026 15:42:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 04/27] KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
Date: Wed,  8 Apr 2026 11:41:54 -0400
Message-ID: <20260408154217.458420-5-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
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



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675583ACF07
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374597; cv=none; b=NDdxfTA0y3Zy/4v6X9sWQMN2uw/S/yiBGvniVheNBRFzByOBLLiBL6FhTRFXBosN5a5d5wIEbD/R81AnyowO7+IxBoB5q6Tf/7pdo7Bdzg+8ebSZ+3eHzAsRPslGj9XvYl7wO0TrB20XiFsFlu493IVMx8tLe2KzlPS/MVPpDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374597; c=relaxed/simple;
	bh=QAKg6QudMZTaAddgpjvoDFJ4zbQ1b9xWfxKfa0meuFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7tH85X7GUwr60r+c/02ofA1BnfSZXjR8RQGLZGBHxcphmowja3OSZxZVObYk0lUzLpyJlObk6+BaX56KG+XRfQB1b/9x0aX5lniA5xNke2NG4n8dl2rM6nmwCYnB39eVHsT1WJ/zi7Ij+UakK8k/M7Sv1H+KQ80UspcPQJzehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6knRV6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6knRV6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=in6s9CvkfcYt5FUUicAvCzh+OuHOuujlss5A3mb2EV4=;
	b=C6knRV6Pgm1nskdnQEy5x47NIYudb6sorfGjk1BX6P5QFYFWZxjIIIco8SLFfEIvVYh09+
	DJgIq2JUgbNRue5TJWxphBudzMpiWj1iI87CR/FMr0jeuz/RZGrZmY8efnhMhr5MdMo6pE
	XvAlB1sCzWsP/K9rKPeMAAjXn0XgKv8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-3BZpTUS7ObGUpECR8gtyqw-1; Tue,
 28 Apr 2026 07:09:53 -0400
X-MC-Unique: 3BZpTUS7ObGUpECR8gtyqw-1
X-Mimecast-MFC-AGG-ID: 3BZpTUS7ObGUpECR8gtyqw_1777374592
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0E491956054;
	Tue, 28 Apr 2026 11:09:51 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20FA530078C0;
	Tue, 28 Apr 2026 11:09:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 05/28] KVM: x86/mmu: remove SPTE_EPT_*
Date: Tue, 28 Apr 2026 07:09:23 -0400
Message-ID: <20260428110946.11466-6-pbonzini@redhat.com>
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

spte.h is already including vmx.h, use the constants it defines.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7913672c0f6f..ac957bd7dab0 100644
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



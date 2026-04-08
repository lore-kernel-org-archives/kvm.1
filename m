Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CD3D75AD
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662951; cv=none; b=BWvdtTrjMIi6TUDL79Ic6x/QdflJPZPexxzWrDyUbtVDdsuw2qGtKUFuL01136C0tFoInRx3+NTb1QMVju+hO7bkQXgZi09+nijUvZrsdoW7aFvDA3O2rqr7nfg8a+Cfus63MTHgnn6iZ2SS9XjWL6uWSxGqIWghJo1iY31zrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662951; c=relaxed/simple;
	bh=fqHT1pnDK6DwfEr0ptaleAeSYZJjpkW+GH1PZpbZuGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuA7QG+M2nbP/Gi3dGih1rf361Q4YCrjXE545o7q/OSPXmENtChQICyRFqE513wsDKdL/ohOaOJrfy0OevopBmEayAoyZxAVZF8GRwxsTD0qKTxjW6zNtFSDDds6ffD/Bf/iPrOSK3hbRfQzBZWFkjXrmmRyOkfweCDfoex4c7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TV+N44z6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV+N44z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFUzE5NcTOnpssdGYeZVSDjozPCtHCC7XohYQ1HLmGA=;
	b=TV+N44z6jrLCNnTbQx4IcMvcTmCoRM6V5wUex3EvzPeqGsbMIQjGjxJNsG6QcBocOiHysU
	ZC2Cx2THIwI7To8Ae8Wyc2Vqoj/1kqGc7Fg7774qfzJV5xqL8zhE6XWonc29Sfr+6hC3cO
	ZttCWiAOLmND7rEA9sv7NsVP1sh7mFc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-Luvj13zoPcuv1-3JW2O0zA-1; Wed,
 08 Apr 2026 11:42:25 -0400
X-MC-Unique: Luvj13zoPcuv1-3JW2O0zA-1
X-Mimecast-MFC-AGG-ID: Luvj13zoPcuv1-3JW2O0zA_1775662944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9A70180028B;
	Wed,  8 Apr 2026 15:42:23 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F170180036E;
	Wed,  8 Apr 2026 15:42:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 05/27] KVM: x86/mmu: remove SPTE_EPT_*
Date: Wed,  8 Apr 2026 11:41:55 -0400
Message-ID: <20260408154217.458420-6-pbonzini@redhat.com>
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

spte.h is already including vmx.h, use the constants it defines.

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



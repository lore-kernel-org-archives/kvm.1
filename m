Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF293D75DD
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662952; cv=none; b=dz+HegYKra64r0umHy6bzXGDb/6yJMGVXyeHpYqCCmKDnSawea4dqY/HJKnYslnrcIWjq1aXR+OC5xTPmR3RfUqkCkLFRhF3ZFNIQJJuhlXrXcsKXvnau3+i9hQT2s57upzp+wQuprm0MR/lBBSqt1GWQ504zIgs8GhKbICfgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662952; c=relaxed/simple;
	bh=S3iQPXqoQDIe9OxHjVNJIMjqmhKDoBtB2TbMtubeBTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmBuIv5xUX3RNMK5tDDoLH88A2kTtDCY7hHM6FHqyL7MxKL6RNtxWEGgFJMRCun3cy8IasOK5l1NFf1qvX/r++PIxnzdFcS3p7qY5zIeWFd3P07/EOrJzQgfHG5lE9d5sibOwOB8g3Bv1rnLUSb/wi2apEBjixW5wLqZLn5Nt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPZurQYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPZurQYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/iezNRC4ybfGq5UaIZ4cXDIi/YuE1XIEGu/2CdlosI=;
	b=DPZurQYqRW3vJTyRqEkNZIbjWiPGiWFss87yJp398sXci5V6ilSbYFF1hzPHrJswjYAEvz
	sv5VXHwj+df+4APJuPvV2DCUKWkvydbx+siWAcG9xVBxbzcybQfAOoFUCddQ0oZZqARGow
	C+d5PRKdNYe+rfNO/0h5H5Id8+Mh1/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-CUP3YElbPyWws1TVDj59Mw-1; Wed,
 08 Apr 2026 11:42:26 -0400
X-MC-Unique: CUP3YElbPyWws1TVDj59Mw-1
X-Mimecast-MFC-AGG-ID: CUP3YElbPyWws1TVDj59Mw_1775662945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2E0B1956051;
	Wed,  8 Apr 2026 15:42:24 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E4A5180036E;
	Wed,  8 Apr 2026 15:42:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 06/27] KVM: x86/mmu: merge make_spte_{non,}executable
Date: Wed,  8 Apr 2026 11:41:56 -0400
Message-ID: <20260408154217.458420-7-pbonzini@redhat.com>
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

As the logic will become more complicated with the introduction
of MBEC, at least write it only once.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 85a0473809b0..e9dc0ae44274 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -317,14 +317,16 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
 	return spte;
 }
 
-static u64 make_spte_executable(u64 spte)
+static u64 make_spte_executable(u64 spte, u8 access)
 {
-	return modify_spte_protections(spte, shadow_x_mask, shadow_nx_mask);
-}
+	u64 set, clear;
 
-static u64 make_spte_nonexecutable(u64 spte)
-{
-	return modify_spte_protections(spte, shadow_nx_mask, shadow_x_mask);
+	if (access & ACC_EXEC_MASK)
+		set = shadow_x_mask;
+	else
+		set = shadow_nx_mask;
+	clear = set ^ (shadow_nx_mask | shadow_x_mask);
+	return modify_spte_protections(spte, set, clear);
 }
 
 /*
@@ -356,8 +358,8 @@ u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
 		 * the page executable as the NX hugepage mitigation no longer
 		 * applies.
 		 */
-		if ((role.access & ACC_EXEC_MASK) && is_nx_huge_page_enabled(kvm))
-			child_spte = make_spte_executable(child_spte);
+		if (is_nx_huge_page_enabled(kvm))
+			child_spte = make_spte_executable(child_spte, role.access);
 	}
 
 	return child_spte;
@@ -379,7 +381,7 @@ u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level)
 	huge_spte &= KVM_HPAGE_MASK(level) | ~PAGE_MASK;
 
 	if (is_nx_huge_page_enabled(kvm))
-		huge_spte = make_spte_nonexecutable(huge_spte);
+		huge_spte = make_spte_executable(huge_spte, 0);
 
 	return huge_spte;
 }
-- 
2.52.0



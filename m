Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DAF3EBF19
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374598; cv=none; b=FSyxEVrZkGR7vvQq/awFabczE5b2U74khrLiZzN/TaB7Xa3n0X1X5dbaf9HgzjHRjZWA1iKWcQ1HC7HwCchVEN39OGQ6aBC873gMemQJIDlJx6H46zYf1NadaG0ooiPHTYpHIRsiETEzQqB6+s6MzdXe5xb0QPX0HROMOu5+bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374598; c=relaxed/simple;
	bh=vQvPgt0Mq2Gsbr1Skf087n28m4o4mK3xVgjfrnI90KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y88lH3iZY/ST7HxUzhU8YDFIpO8WKMOFAEhR48LGrfUQmuUqbi9qCSAYennrFqjg2UKNpLeafh/duBvG0EGe1e1KjY2S42e5pxDJbuzC2zgczmGu+B8iugEGPY/MONc2JLzQRBO5qg9EWARJirQtV2zA8hrQxFqMwQOhgT65N+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxsSHuMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxsSHuMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMPlsOACadmgUCBsX+kfM3jcuhxlgiVMWFCf2O3a/w0=;
	b=cxsSHuMltpNx4BB5XpDWhKlIdl8sph3j1sa8FO21GakP8Zs5W6dTi9av5gVEwZCxY5qRNq
	yX9IR2l1U+jpzkoc2F2/ql8AABjDccHobpRr/bNVXgW8VD2HJLK9oylFEcqT3R9OXoL7kO
	28c8yx0j36X2qOANWKVFD8N549NpGt0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-naYV9K8HNC-iR2a4scXNhw-1; Tue,
 28 Apr 2026 07:09:54 -0400
X-MC-Unique: naYV9K8HNC-iR2a4scXNhw-1
X-Mimecast-MFC-AGG-ID: naYV9K8HNC-iR2a4scXNhw_1777374592
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C32DD18002C0;
	Tue, 28 Apr 2026 11:09:52 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11F1D3000C22;
	Tue, 28 Apr 2026 11:09:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 06/28] KVM: x86/mmu: merge make_spte_{non,}executable
Date: Tue, 28 Apr 2026 07:09:24 -0400
Message-ID: <20260428110946.11466-7-pbonzini@redhat.com>
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

As the logic will become more complicated with the introduction
of MBEC, at least write it only once.

Tested-by: David Riley <d.riley@proxmox.com>
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



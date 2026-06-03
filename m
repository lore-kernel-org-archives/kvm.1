Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE8478E36
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484314; cv=none; b=VoPJmiI55SvifnRT6e2C04b2jfFUq/WFeXfvqZ3btpYsaYNuIIeTipQ6T/w4t0ZNbSmPYWrERH6vKGSXfQUeOM2rHsU50Zi7H9uTtPCJiv2+8rMFNTghswmARdMe/TlEASyBhayWAzmxfVNmtVljJu7Ua0WXVtjH0LbIpUZWnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484314; c=relaxed/simple;
	bh=xH2nNrhMUHhsXmnI+ANftM8SoHXriFpHyMO2OnFmc14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM3k5EjDMrZdxT+fUYoiIS1UsKm3OEDy/ewQBPIPkaV13ByGCWDu+95h02Qr7hVwg9NSn+1uoIRwqma8xrnqLJcyO5pyO6nJuK3yRNYlEIXbgNlx/Jmph9RHllzl8wiA6wWZE6BeCZ6Gi89IxHkdjUAoDRXBaOe75riofgCKdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvtragjM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvtragjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3ORianq9bhRIrNfSAPaZPqyjkRgJzW7hnwbQDPyMqc=;
	b=CvtragjMKpcMJLwSj8rq4EKEWO4Dytaxh47w7otPRTcpdLCyPz8C/yHRnAvIiZZc5aYctS
	bTtd1IbtK/iFGeieimfMXikk5ZTyRoRaUcRUVrc3u4ynm+FM0axWPmnpc159ReEn2vhCs+
	VP2piq1/sNZJftyHSXqlTXlm3Aj9Vrg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-Y0mLsgGVN9Kip6cVhi7jzg-1; Wed,
 03 Jun 2026 06:58:29 -0400
X-MC-Unique: Y0mLsgGVN9Kip6cVhi7jzg-1
X-Mimecast-MFC-AGG-ID: Y0mLsgGVN9Kip6cVhi7jzg_1780484309
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 084DB19560AB;
	Wed,  3 Jun 2026 10:58:29 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A18D5195E486;
	Wed,  3 Jun 2026 10:58:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 23/24] KVM: x86/mmu: parameterize update_permission_bitmask()
Date: Wed,  3 Jun 2026 06:58:13 -0400
Message-ID: <20260603105814.10236-24-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make it possible to apply the computation loop to both guest
and shadow PTEs formats; the latter do not have an extended role, so
pass the four parameters to the function one by one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 29755afe5b46..386e7e05d205 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5569,18 +5569,15 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ept)
+static void __update_permission_bitmask(struct kvm_page_format *fmt, bool tdp,
+					bool ept, bool cr4_smep, bool cr4_smap,
+					bool cr0_wp, bool efer_nx)
 {
 	unsigned index;
 
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
-	bool cr4_smep = is_cr4_smep(pw);
-	bool cr4_smap = is_cr4_smap(pw);
-	bool cr0_wp = is_cr0_wp(pw);
-	bool efer_nx = is_efer_nx(pw);
-
 	/*
 	 * In hardware, page fault error codes are generated (as the name
 	 * suggests) on any kind of page fault.  permission_fault() and
@@ -5593,7 +5590,7 @@ static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ep
 	 * permission_fault() to indicate accesses that are *not* subject to
 	 * SMAP restrictions.
 	 */
-	for (index = 0; index < ARRAY_SIZE(pw->fmt.permissions); ++index) {
+	for (index = 0; index < ARRAY_SIZE(fmt->permissions); ++index) {
 		unsigned pfec = index << 1;
 
 		/*
@@ -5667,10 +5664,17 @@ static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ep
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		pw->fmt.permissions[index] = ff | uf | wf | rf | smapf;
+		fmt->permissions[index] = ff | uf | wf | rf | smapf;
 	}
 }
 
+static void update_permission_bitmask(struct kvm_pagewalk *w, bool tdp, bool ept)
+{
+	__update_permission_bitmask(&w->fmt, tdp, ept,
+				    is_cr4_smep(w), is_cr4_smap(w),
+				    is_cr0_wp(w), is_efer_nx(w));
+}
+
 /*
 * PKU is an additional mechanism by which the paging controls access to
 * user-mode addresses based on the value in the PKRU register.  Protection
-- 
2.52.0



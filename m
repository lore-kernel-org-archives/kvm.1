Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B73E958F
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337363; cv=none; b=UBctnra0XiKBb9QxH0oxuMEYQvkgQ2oDjn140oZDMVhs/m5gJJywEigrV0nvph6tTeFi3v0qgpMILrBUWEgDXJmWbXhhq4ZK6Uz8tRFTTsg8uz2GCo5a0qKb8IzxLVPDki21MHit1hbDM6y17y6rOOfzo5ecX5vCrwxRsbO6yek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337363; c=relaxed/simple;
	bh=UV6NHqbVUENbbVmBecR+ezQHXF95eaeSSCtDJlU+880=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHpsddOVPnwPow6DU9U13i3+EiuveS5WkaxkLJsg09Umdpq7nV7TCoaQ4O6OnUAygUi9J/7HdD99ggK4m79ZFOl+Bihxq+c/7b1iu8d+DQo6hyv5X2S/hw31ZYhvFSdKH40Y4ffFPkCkSsjqbQvVek/zbiFvLMuQtEcQGoqe9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahRLoSau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahRLoSau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2I1v71uRWzuvrXEGsmZ7wX8/md6Iahph/MnJg4wBHs=;
	b=ahRLoSauGmNJnkVzVirEwUlKgQljTYERXbwulRioWIlUH3ZCjyi+jjlz2EW8EMjqdDDduk
	TwuOycZkWIWcy5A+LyThOS/pHO4o2qL8AOeOuzBvMHVtzZkbqfWaJEjtL7lX5BC6ilesCm
	VNggv/1JGmZa44pJ+OqEgYzFF92//Lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-h7V1zznNOwq9spDi83W9Rg-1; Wed,
 24 Jun 2026 17:42:31 -0400
X-MC-Unique: h7V1zznNOwq9spDi83W9Rg-1
X-Mimecast-MFC-AGG-ID: h7V1zznNOwq9spDi83W9Rg_1782337350
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D05301801BE0;
	Wed, 24 Jun 2026 21:42:30 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A2091956094;
	Wed, 24 Jun 2026 21:42:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 18/19] KVM: x86/mmu: parameterize update_permission_bitmask()
Date: Wed, 24 Jun 2026 17:42:17 -0400
Message-ID: <20260624214218.73796-19-pbonzini@redhat.com>
In-Reply-To: <20260624214218.73796-1-pbonzini@redhat.com>
References: <20260624214218.73796-1-pbonzini@redhat.com>
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
index 9227dc183032..e28b4e4e9290 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5590,18 +5590,15 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
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
@@ -5614,7 +5611,7 @@ static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ep
 	 * permission_fault() to indicate accesses that are *not* subject to
 	 * SMAP restrictions.
 	 */
-	for (index = 0; index < ARRAY_SIZE(pw->fmt.permissions); ++index) {
+	for (index = 0; index < ARRAY_SIZE(fmt->permissions); ++index) {
 		unsigned pfec = index << 1;
 
 		/*
@@ -5688,10 +5685,17 @@ static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ep
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



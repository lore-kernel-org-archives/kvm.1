Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD783D8119
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662953; cv=none; b=mMn52GaLKGq5O6GFAlyOGQwMgIciqv5589DQrW0NYzRCDq0lVeVDPZL7d+XI4C3ErrGJBVEgGO058mMz4Ga8KKCquAKmPNBW/btYSBGNrVrYObVT8DbWjp/xrnXUf/pfAxxeykw4/B3l8nxTQPbPLWqm8EB3rQDXo24NmXnNHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662953; c=relaxed/simple;
	bh=8LTLy6DT42dvHRcsH/96CGZY5DRMWaGV/APUyPrYTqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4QaSGXELTOvGEpSAOPbzxYpv/FNfKOpjPDiHi/xXNsoSz4BfyjT9LgyHQcPrzR/q174MA6zbway9znuBG6DoKQASBS8zPE2XCAk6PuE/9x/1c3qQBqM3AkYg4EzmRp5EqijY25MuTGGd2eR++bWOM14WFDbzIv92fQs/EYIrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUWGAKAr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUWGAKAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiimktwqNsIGErSNPDPMCTHd/htbVzYQ3m8IYarxywE=;
	b=BUWGAKArhORs9kkzhpW9bYR3e62mZHtrxeloHSwUQnYaOjaao66q8/7ZEWtXRVhN8rPdXj
	JiLmttcAd4LzIZxzaxseW4TL0JTLeaOb45M8WBcrigBero08WMly9E2/PZgjgmwl6fYNrE
	M0903ARuchTZhsoeiPBMcLRkg84/CDE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-d3SVXM9IOgmDcsn3HFzwTQ-1; Wed,
 08 Apr 2026 11:42:29 -0400
X-MC-Unique: d3SVXM9IOgmDcsn3HFzwTQ-1
X-Mimecast-MFC-AGG-ID: d3SVXM9IOgmDcsn3HFzwTQ_1775662948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0307C18002E3;
	Wed,  8 Apr 2026 15:42:28 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C8941800765;
	Wed,  8 Apr 2026 15:42:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 09/27] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
Date: Wed,  8 Apr 2026 11:41:59 -0400
Message-ID: <20260408154217.458420-10-pbonzini@redhat.com>
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

Now that EPT is not abusing anymore ACC_USER_MASK, move its
handling entirely in the !ept branch.  Merge smepf and ff
into a single variable because EPT's "SMEP" (actually
MBEC) is defined differently.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 72c0e2c806c3..a26514124fe5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5556,7 +5556,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
-	const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
@@ -5589,21 +5588,24 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		/* Faults from writes to non-writable pages */
 		u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u16 uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
-		/* Faults from fetches of non-executable pages*/
-		u16 ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
-		/* Faults from kernel mode fetches of user pages */
-		u16 smepf = 0;
+		u16 uf = 0;
+		/* Faults from fetches of non-executable pages */
+		u16 ff = 0;
 		/* Faults from kernel mode accesses of user pages */
 		u16 smapf = 0;
 
-		if (!ept) {
+		if (ept) {
+			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
+		} else {
+			const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
+
 			/* Faults from kernel mode accesses to user pages */
 			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			/* Not really needed: !nx will cause pte.nx to fault */
-			if (!efer_nx)
-				ff = 0;
+			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
+
+			if (efer_nx)
+				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 
 			/* Allow supervisor writes if !cr0.wp */
 			if (!cr0_wp)
@@ -5611,7 +5613,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 			/* Disallow supervisor fetches of user code if cr4.smep */
 			if (cr4_smep)
-				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
+				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
 
 			/*
 			 * SMAP:kernel-mode data accesses from user-mode
@@ -5632,7 +5634,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | rf | smepf | smapf;
+		mmu->permissions[byte] = ff | uf | wf | rf | smapf;
 	}
 }
 
-- 
2.52.0



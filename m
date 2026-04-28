Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76543F7A8B
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374603; cv=none; b=VuUloyIMmFugbov8BIc8fzRsU3Pbl/wDeWN+Oewsv9BmBSmd/0Mte1W2okttNm0tg88/H/awujRfB9ne3m+2M770sQsFrEkHjHO++DRWnS+PMhpCCLP8e4Nuq+Zb2cPnZJsmfFjPYOXMdo4MBBc7qb5gShb1hlqYSz94fxly6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374603; c=relaxed/simple;
	bh=oAxHGH9SBIUZdnUc5NX6qtSfH3XRMOtG16yftL7zZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uldrUtpcaE87nvn0q0Y2yu18UcZYE2jJp4SBNN771+u8CWL7EUBt1jOVmCIlZqOFkEM+uAR9S/VnnY3TaI9UAjqHnKR4oilWs4unb8Xl0VAwZPxep+cVbRAsBipDHJpHOmQkYMXQlh4xFZSFRaxMIIfga3DokP6y9Du+QcgealM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+vbJmx1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+vbJmx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZatRJJDY6bnjDKKoO77YMzv1PQpxJ9aBLIL+NZ9diQ=;
	b=B+vbJmx1fdagc76lOp/xKNI2ah7Nn5AlcIns6fvqiEx4QM7Rzp0gc4JOSu4IBQ4RoOK8b/
	vEtuDly+fe5QlZ6QTPKwLA9d2vJ2tIhlVyIJjzymG2dfKr5+4dYnein9a/c2/1KIZPD8Dj
	JsCNkTG5GogMihpv8yb4VHpiP1b4I/Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-cNqvpuaxO_OCsqqQtXBptQ-1; Tue,
 28 Apr 2026 07:09:56 -0400
X-MC-Unique: cNqvpuaxO_OCsqqQtXBptQ-1
X-Mimecast-MFC-AGG-ID: cNqvpuaxO_OCsqqQtXBptQ_1777374595
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E629E19560BB;
	Tue, 28 Apr 2026 11:09:54 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DE4C3000C22;
	Tue, 28 Apr 2026 11:09:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 09/28] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
Date: Tue, 28 Apr 2026 07:09:27 -0400
Message-ID: <20260428110946.11466-10-pbonzini@redhat.com>
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

Now that EPT is not abusing anymore ACC_USER_MASK, move its
handling entirely in the !ept branch.  Merge smepf and ff
into a single variable because EPT's "SMEP" (actually
MBEC) is defined differently.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cd1f8a51867d..fc1b17e22ea2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5565,7 +5565,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
-	const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
@@ -5598,21 +5597,24 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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
@@ -5620,7 +5622,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 			/* Disallow supervisor fetches of user code if cr4.smep */
 			if (cr4_smep)
-				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
+				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
 
 			/*
 			 * SMAP:kernel-mode data accesses from user-mode
@@ -5641,7 +5643,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | rf | smepf | smapf;
+		mmu->permissions[byte] = ff | uf | wf | rf | smapf;
 	}
 }
 
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AE2C11F9
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561685; cv=none; b=oYU4sBbOzoD8hbI+lV444h86C7nW8Oo5vwIwx33xgRXbFU9V1uMwJLJkn1+KZtkwgCyOoLmLIdmeZqo0PEMMnILFfIwducE5C8e1vJLSUh/q/UT1ZOFWgH+y1yPuhHN8GpKPZ4aa5Y7MQCglF3JvDPGyon+kXrO/mxEHW5o7EMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561685; c=relaxed/simple;
	bh=yBqFMsLCGznmhPZ1vRAb0i1RZX9nxHjWBWVouZ/55D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isP8gbIzA9pHIwlSQX4phlifDVbjxuIcGUFo09+4r/EFdgh9msuGymHwWaIMdRuxfFj1tJHojSxCQD1VJmCc5fT7QcnTVfLPTnNA51pgA+sStALADUm6+yxPAZrpnUef3ews712p+zTXRja0g5kAiniiuTJQmZVrQ3BOtqJ3gO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGdoH/f2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGdoH/f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRsefiZnpFr+R4AGPBx9bGqTQT8DYDaseYAVtgOfyBI=;
	b=MGdoH/f2Cpu6RYvjwoB5mZynuoNX/YY51AIuT+8zvbSWtSr2mZsXMAvLXzfjWh2NCHTQnR
	7hhf/LBCRbi7Zn4wgYUgdG7JrCwLAEBzU7m7aTf0ABGUjduiCSaAL1A7cNp2HFuq1N9pah
	5CExn6GU6cCDrHJHmUNYVrkclHA+Nb8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-1PXFkvQ7PzalK3jBrwgqjg-1; Thu,
 30 Apr 2026 11:07:57 -0400
X-MC-Unique: 1PXFkvQ7PzalK3jBrwgqjg-1
X-Mimecast-MFC-AGG-ID: 1PXFkvQ7PzalK3jBrwgqjg_1777561676
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE1DE180059B;
	Thu, 30 Apr 2026 15:07:55 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 578801800347;
	Thu, 30 Apr 2026 15:07:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 08/28] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
Date: Thu, 30 Apr 2026 11:07:27 -0400
Message-ID: <20260430150747.76749-9-pbonzini@redhat.com>
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

Move more of EPT handling entirely in the existing "if (!ept)"
conditional.  Use a new "rf" variable instead of uf for read permissions
for clarity.

Merge smepf and ff into a single variable because EPT's "SMEP" (actually
MBEC) is defined differently and does not need smepf.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 70fd6868a555..8bbda4684338 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5584,24 +5584,28 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		 * that causes a fault with the given PFEC.
 		 */
 
+		/* Faults from reads to non-readable pages */
+		u8 rf = 0;
 		/* Faults from writes to non-writable pages */
 		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
-		/* Faults from fetches of non-executable pages*/
-		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
-		/* Faults from kernel mode fetches of user pages */
-		u8 smepf = 0;
+		u8 uf = 0;
+		/* Faults from fetches of non-executable pages */
+		u8 ff = 0;
 		/* Faults from kernel mode accesses of user pages */
 		u8 smapf = 0;
 
-		if (!ept) {
+		if (ept) {
+			rf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
+			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
+		} else {
 			/* Faults from kernel mode accesses to user pages */
 			u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			/* Not really needed: !nx will cause pte.nx to fault */
-			if (!efer_nx)
-				ff = 0;
+			uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
+
+			if (efer_nx)
+				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 
 			/* Allow supervisor writes if !cr0.wp */
 			if (!cr0_wp)
@@ -5609,7 +5613,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 
 			/* Disallow supervisor fetches of user code if cr4.smep */
 			if (cr4_smep)
-				smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
+				ff |= (pfec & PFERR_FETCH_MASK) ? kf : 0;
 
 			/*
 			 * SMAP:kernel-mode data accesses from user-mode
@@ -5630,7 +5634,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | smepf | smapf;
+		mmu->permissions[byte] = ff | uf | wf | rf | smapf;
 	}
 }
 
-- 
2.52.0



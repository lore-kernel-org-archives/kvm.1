Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4263043CE
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561688; cv=none; b=OwiRz8im+d3it76o8E//Ux3MONsQbsF+83uTbmkSPGEvIObDqy1HYVaAMj9+mkB1SqB7TgAP4TWjwxv09MjYmSAe9E28y4KjmzQTw8bGgaPM5MAz+2Q01CtfPAjw7ZAquamF8axZeGoVoo43qAiTqL4oaOo6eDZB2goxWsZ8NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561688; c=relaxed/simple;
	bh=wXjuhSz6nVLjdUFmzOE30XGcCV0H2i3wuwB7AhkrVDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxJ5RrUUS3dv2hyfkPX6trWzbfeFuPDoOit+Jr/i5KpecMYMOPShBblLJae6qIuZHodtBRjUgF4vm+lqa4ubzs+R+Lp4+djpMCbQDKKOeszmEWA3X7QIX9D0okb+D3DLT62V5rige9Yk58KbtGGOmyT/hRUeFzQh0Du5dZzn86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMZMR7FQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMZMR7FQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwmBYA9ksrwWQcFcUn5nZOkE9O0tPmBRjesg8bFOvsg=;
	b=SMZMR7FQasrrTT8EhcQ7/sEF4IW8fJanPPqtuFPP0bKhUqNKIe6FzhBL4tUww1H0h79YCe
	zaElBZgDtfgb5kXNjvH9Grm1q66Yufy6TrCvFHx5FCG/R0aVfi0TzGC0n8xLk7iSHToADV
	+w/cE24UatqaYGWLz3xYHhGSXERG9hE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-87RMD59TMoG7cU3n0zoTEg-1; Thu,
 30 Apr 2026 11:08:01 -0400
X-MC-Unique: 87RMD59TMoG7cU3n0zoTEg-1
X-Mimecast-MFC-AGG-ID: 87RMD59TMoG7cU3n0zoTEg_1777561678
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6C55195608F;
	Thu, 30 Apr 2026 15:07:57 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B90F1955D84;
	Thu, 30 Apr 2026 15:07:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 10/28] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
Date: Thu, 30 Apr 2026 11:07:29 -0400
Message-ID: <20260430150747.76749-11-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The XS/XU bit for EPT are only applied to final accesses, and use the
U bit from the page walk itself.  While strictly speaking not necessary
(any value of PFERR_USER_MASK would be the same for page table accesses,
because they're reads and writes only), it is clearer and less hackish
to only apply MBEC to PFERR_GUEST_FINAL_MASK.  Allow kvm-intel.ko to
distinguish the two cases.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c          | 3 ++-
 arch/x86/kvm/mmu/mmu.c         | 3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h | 7 +++++--
 arch/x86/kvm/x86.c             | 3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9b140bbdc1d8..cf9dd565b894 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2041,7 +2041,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
-		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa,
+					PFERR_GUEST_FINAL_MASK, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fc1b17e22ea2..0fc362508a19 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4348,7 +4348,8 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	if (exception)
 		exception->error_code = 0;
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
+	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
+				 exception);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index fb1b5d8b23e5..567f8b77ffe0 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -376,7 +376,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
-					     nested_access, &walker->fault);
+					     nested_access | PFERR_GUEST_PAGE_MASK,
+					     &walker->fault);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -444,7 +445,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
+	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
+				     access | PFERR_GUEST_FINAL_MASK,
+				     &walker->fault);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..ef1e3ae13887 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1072,7 +1072,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * to an L1 GPA.
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
-				     PFERR_USER_MASK | PFERR_WRITE_MASK, NULL);
+				     PFERR_USER_MASK | PFERR_WRITE_MASK |
+				     PFERR_GUEST_PAGE_MASK, NULL);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
-- 
2.52.0



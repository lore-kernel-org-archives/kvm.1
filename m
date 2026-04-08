Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FD3D9DDB
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662956; cv=none; b=QtyvXECl/KxSxgi14nGQ0V7hHleHcjYDnFTDFTOWNzKNrC606JmrNZSVnSp3X8OFdwAq+BkIxj1tmVCnaooCUcqCAK2u6MPTVB3C34wVG0/WghvKIQgPgtwRn9cUwoEDT9VM72/bqX6ZjmOJRiZViVeVyLqzCngwvl0PUs/0ugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662956; c=relaxed/simple;
	bh=NAuDkuAAn6io9oRaMeoPjSzScOQbFqvRr3rpmrc7qGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrhLcM0ZH2jU92Ewd+OzzNXsH4C4pvn7tYYW+6Gil+4PbNbl+bk8fa455b5enmBTBRHxHMH327knNFV6e+WBQCcM0AEsauKkz5FEDTR9Uh8sgmzfrTUgLeFcr8J8kC061a71CoKUAOkZ1RDGKxu5eb41OepZG5NhJLNFkh23S+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i85QAJ52; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i85QAJ52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUssvVav5wds3GZewe4BtC/nqJ4wE7HKSL0kQHrTWMA=;
	b=i85QAJ52PHArqfgN4kAs4BlxcT1ucOy60or4U59yfXVpNiJ63BH2CDEAJVu12c7gys+Hoj
	6KiQ3u3S/xk8u3sH2RPDEUDSQwhMGN+367tdXk2pbvOwiMfYypX2Wj79Z7TBI6kJlUI/Jk
	4e5u1t/we+SOpp0NakKsvIV+JNfXPQk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-SD5hsPFeP3aXOAY5Ld9H9w-1; Wed,
 08 Apr 2026 11:42:31 -0400
X-MC-Unique: SD5hsPFeP3aXOAY5Ld9H9w-1
X-Mimecast-MFC-AGG-ID: SD5hsPFeP3aXOAY5Ld9H9w_1775662949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89A471955F04;
	Wed,  8 Apr 2026 15:42:29 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B48EF1955F2B;
	Wed,  8 Apr 2026 15:42:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 10/27] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
Date: Wed,  8 Apr 2026 11:42:00 -0400
Message-ID: <20260408154217.458420-11-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The XS/XU bit for EPT are only applied to final accesses, and use the
U bit from the page walk itself.  While strictly speaking not necessary
(any value of PFERR_USER_MASK would be the same for page table accesses,
because they're reads and writes only), it is clearer and less hackish
to only apply MBEC to PFERR_GUEST_FINAL_MASK.  Allow kvm-intel.ko to
distinguish the two cases.

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
index a26514124fe5..a459177c0480 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4339,7 +4339,8 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
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
index fd1c4a36b593..bbafd10fd72c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1070,7 +1070,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
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



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3164B4890
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719378; cv=none; b=oikA5dQTME4H1CpGK7zsD8qP/W7YqmzUn8A5AMl/f+12uN6pBvElQRAgUNx8Y9WwMJ8Ft833LMCYPxUpsnKYl7Rq7gvhCv/Tsi24NhDj0oDljh6FoWjaLxECBO3wsEGwxMA+tSbOXFI0EdJ88HUy1QbIjcnMoHWCpcIqc5xlGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719378; c=relaxed/simple;
	bh=0/G/zhm/TYcWJVnrrz3Po70HAzX5NNAVsCqtzhX+LHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0m/J+qHGhZwKjwpLVYzSTFBO0Vs3THi7grQsHl1p8iZzx8u0/owZq1xmEYRJ/9iaNFPWV1WZBFdRMefzae1SH+yUzl5bt9r14JBWR8qT8XUCHZYm0MjxwZXg3BmpDmjlp/yRQuE44ud8pI3zvB8bi9MMgwuUptPYxbxG9bTbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpDMRa63; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpDMRa63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqXmK6gYxDQBh7MLxdL5kQ5+nKTLwxAUz7gyTtAit3A=;
	b=LpDMRa63mci3bYc7/ssWLAfDCiJTjvSW03be/tgjxNJVu91jfhu9oHJI71AXwDSzUGtUCa
	8eWwIgw1fWEZcHzJ0ZzelHI21FjQ7vyPKF3OhVm7Ynqy7tP2QVac/8CpSkiNeNqe7soC0L
	0/qaVMDbit61CM9kdsquCgN9NYd0LMU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-YDBJXWm-N_KlII8Unk4XLw-1; Fri,
 18 Sep 2026 04:16:05 -0400
X-MC-Unique: YDBJXWm-N_KlII8Unk4XLw-1
X-Mimecast-MFC-AGG-ID: YDBJXWm-N_KlII8Unk4XLw_1789719364
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2AEF1955D55;
	Fri, 18 Sep 2026 08:16:03 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A2AF300022B;
	Fri, 18 Sep 2026 08:16:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 22/28] KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute
Date: Fri, 18 Sep 2026 04:15:37 -0400
Message-ID: <20260918081543.139871-23-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

During execution, page table entries are subject to memory protection
simply because their GPA is obtained with an EPT walk.  During emulation,
the checks need to be done by hand and result in an -EFAULT userspace
exit.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index b031123fcb36..d2836a327bc9 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -89,6 +89,7 @@ struct guest_walker {
 	unsigned int pt_access[PT_MAX_FULL_LEVELS];
 	unsigned int pte_access;
 	gfn_t gfn;
+	bool memory_attributes_fault;
 	struct x86_exception fault;
 };
 
@@ -342,6 +343,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
+	walker->memory_attributes_fault = false;
 	walker->level = w->cpu_role.base.level;
 	pte           = kvm_mmu_get_guest_pgd(vcpu, w);
 	have_ad       = PT_HAVE_ACCESSED_DIRTY(w);
@@ -411,6 +413,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(kvm_is_error_hva(host_addr)))
 			goto error;
 
+		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(real_gpa))) {
+			walker->memory_attributes_fault = true;
+			walker->gfn = gpa_to_gfn(real_gpa);
+			goto error;
+		}
+
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
 		if (unlikely(get_user(pte, ptep_user)))
 			goto error;
@@ -820,6 +828,12 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * The page is not mapped by the guest.  Let the guest handle it.
 	 */
 	if (!r) {
+		if (walker.memory_attributes_fault) {
+			fault->gfn = walker.gfn;
+			kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+			return -EFAULT;
+		}
+
 		if (!fault->prefetch)
 			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
 
-- 
2.52.0



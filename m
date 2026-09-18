Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751A51598C
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739464; cv=none; b=VUvzhnbrD4+WB05Qt/dlcm3BKsBRGblXq+cYmOFUZR3GDaIXdeWUxEemBDQc5Przdr+FjMJHwGcvprkQ75Pia1Kd3ZKaJpBSpj67srcww6ml7WwcKq8tDaq368oe8AAzJW9s+kHpxZRpLosf5jVWXgGoCR+rZCTosT5zA1G6MtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739464; c=relaxed/simple;
	bh=Q2aRdzMU8+9X0wBkCuNX2/dXfOyvTDPvL84gvOpA44k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9uqFdzXBlMBVthJF+dZwjR+d3Jshhmx3wl442Xiy2e4M/rKAykFjSK+lHp7KHuIf5pDcIY4wi+ct/+RrvxOpI21cavxzGfqR6bc1RK3YQJ8RcDNSXkyeZ5oJk57XPuQxtuMKBOE7NBP7aSvlu2vnCKGjkv7frepsu0t90RrGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvrQa/ve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvrQa/ve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vL4yhml+ArqqxY7DYkJlnDKva66+68iuYvy0OyC1VdM=;
	b=CvrQa/veIl+wNJBARCLf3b4Vh/vyf+DTkYF4l0Vhdgc6WpmnX6sioWNIEO7SWGNAn5fQqU
	EAYu3pjcoMX4HLrqHrtL/6UtLUOUQ7SSPSIHm5ikw27tHhRIyd2Pw+T6gLM57By6wePSzL
	D6ghdoBx47oHeVSdiXe2AaYXXWLzVlk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-wKIkIR7QPzSnj5lChFAwmg-1; Fri,
 18 Sep 2026 09:50:56 -0400
X-MC-Unique: wKIkIR7QPzSnj5lChFAwmg-1
X-Mimecast-MFC-AGG-ID: wKIkIR7QPzSnj5lChFAwmg_1789739455
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E2D5180256C;
	Fri, 18 Sep 2026 13:50:55 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C95A433;
	Fri, 18 Sep 2026 13:50:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 26/31] KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute
Date: Fri, 18 Sep 2026 09:50:25 -0400
Message-ID: <20260918135030.171564-27-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

During execution, page table entries are subject to memory protection
simply because their GPA is obtained with an EPT walk.  During emulation,
the checks need to be done by hand and result in an -EFAULT userspace
exit.

However, if a guest PTE is read-only, do not go all the way out to
userspace and just stomp out the write.  This is consistent with the way
KVM handles read-only memory slots during emulation, though admittedly
inconsistent with everything else: NPT for example always wants nested
page table entries for the guest page tables to be writable, and will
fault.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index b031123fcb36..cd055bfb1eb6 100644
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
@@ -411,6 +413,15 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(kvm_is_error_hva(host_addr)))
 			goto error;
 
+		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(real_gpa))) {
+			walker->memory_attributes_fault = true;
+			walker->gfn = gpa_to_gfn(real_gpa);
+			goto error;
+		}
+
+		if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))
+			walker->pte_writable[walker->level - 1] = false;
+
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
 		if (unlikely(get_user(pte, ptep_user)))
 			goto error;
@@ -820,6 +831,12 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * The page is not mapped by the guest.  Let the guest handle it.
 	 */
 	if (!r) {
+		if (walker.memory_attributes_fault) {
+			kvm_prepare_memory_fault_exit(vcpu, walker.gfn << PAGE_SHIFT,
+						      PAGE_SIZE, false, false, false);
+			return -EFAULT;
+		}
+
 		if (!fault->prefetch)
 			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
 
-- 
2.52.0



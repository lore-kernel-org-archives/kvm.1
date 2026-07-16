Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1B445AE5
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225722; cv=none; b=T0R5mu7arBQF/KB50U+fkppJ5fGb7bCfj3T9/RaoNuXGvhZMa1W83EBVJ8N+4ptmbuXHBrz3oMzD7UmXeeydCYthqjh7qxVJtgy36Bj+VKV9FDc+Z5TgQORmAtyQMY1RsYTd//i6DMJ4Puq+fsDZE0kS9UG4jhvjMeCUCrAO7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225722; c=relaxed/simple;
	bh=7LsMRzOtY0JTrNv8gK7CEE2+mee4K8ZPe2OjPuTcAWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtHOxxTEkjFHq3j4dvY9bGyeaQPxEMiTKURrgGgo9Ih9NR58OXmZjItf+6+be8952slbp0oWltW3efjryO4N+hP+VDv+opAYVqwpFudvfKZc8nl7vWdnJTZMeNY+FQC6dsupU6Dwuwj7P/peM5Av+wmvxPFyE5hGFAqT8BQBlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5gstPTb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5gstPTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37r7DMJnDYdCZNxuuPu+eWT3OhHL3Y8s3njCFCoQsG0=;
	b=Z5gstPTb74vbhQwpeKeEw3um/I2dQzct/HVcRQ6U50+MnxA6mFflAN2lkdHO61cD6O2Jbf
	1VQV0SUXkeAux6IRORxBBHa3PuZtsTf3t4SHt17IoYU0oRt8dwgQDS/5H71Vi6Xgkj42rE
	HdiaNz5fXNoQBye+VkfN1aAaIu+kMLw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350--FllGWkTP8S1PZZoi-pEww-1; Thu,
 16 Jul 2026 14:15:10 -0400
X-MC-Unique: -FllGWkTP8S1PZZoi-pEww-1
X-Mimecast-MFC-AGG-ID: -FllGWkTP8S1PZZoi-pEww_1784225709
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1C151956044;
	Thu, 16 Jul 2026 18:15:09 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31CE71800480;
	Thu, 16 Jul 2026 18:15:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 18/24] KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute
Date: Thu, 16 Jul 2026 14:14:50 -0400
Message-ID: <20260716181456.402786-19-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index cdf05cd76d63..23d7a7d9769f 100644
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



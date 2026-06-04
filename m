Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2B4279FD
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589264; cv=none; b=L2yyq7maB56Hz34JsbcgV+/5cm4FDBI3mI61dlmvgon92dLH1yLsOb/ZaMP9X4ASnhENlJ7ATSf63ZaSJlMUUydHqIO2WJOUTQrLuDQb8DNIZI1KRHUNfVQSRolA+kU98qEwSUnnJL8kGA3oi6qYLRZKbVBvOh7pKQmi/H3s76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589264; c=relaxed/simple;
	bh=U2yHoATeiKZnxRFrses8J6+z7btzUDLG+HIwys/A+IA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJmVVK+Ex7HKsoYuegZB6VuBFe3PqrVoI601eVd73F4yWLSSamQyHmQe+fiTsY6pfLUmTjtYhp2O0wUrVWIBBt8l/KFWQLVLcsJpwok50j8MvubNRa0Ofm+sknUjqiSCaAVWWoZdRuZlL/DzGVvxdamdOwOkNEC1zVZ6p/YKSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM8Oc41N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM8Oc41N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780589260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xyNm/5J5inCwa00MX+JhdhYcLAbTmBPAp1XoCNYfG0=;
	b=CM8Oc41Nt4UdWDuXZpWLTAclKkHRBgurU/AnVxEo4Uh6b4eGjKaOs3we3OR3aYriy11CHy
	wai/QQ9tFhriJ/2oLE9E4GXWj11UrLn/mlnZ6GrvhlPIoLArNPsSSjlJ5INx2juUXZ383M
	XtrqeQA8kGmAvf78TCoM17kCGvbYaXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-DO7h4FocM8uLeqZSnXuWfA-1; Thu,
 04 Jun 2026 12:07:37 -0400
X-MC-Unique: DO7h4FocM8uLeqZSnXuWfA-1
X-Mimecast-MFC-AGG-ID: DO7h4FocM8uLeqZSnXuWfA_1780589256
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33FC8195608E;
	Thu,  4 Jun 2026 16:07:36 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD1FD180049F;
	Thu,  4 Jun 2026 16:07:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 3/3] KVM: nVMX: remove unnecessary unload on processor-detected VMFail
Date: Thu,  4 Jun 2026 12:07:33 -0400
Message-ID: <20260604160733.12555-4-pbonzini@redhat.com>
In-Reply-To: <20260604160733.12555-1-pbonzini@redhat.com>
References: <20260604160733.12555-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

nested_vmx_restore_host_state() is following a similar scheme to
load_vmcs12_host_state() which does not need a kvm_mmu_unload().
So, does nested_vmx_restore_host_state() need it?

The answer is no.  In the shadow case, kvm_init_mmu()
in nested_vmx_load_cr3() is enough to set a root_role
with guest_mode==0.  kvm_mmu_new_pgd() then is now
able to reuse an old root.  In the EPT case, root_mmu
still holds L1's valid root because L2 used guest_mmu.

Removing kvm_mmu_unload() thus is marginally more
efficient and it makes the two host state restore paths
identical.

The other thing that kvm_mmu_unload() does is clearing
the MMIO GVA cache.  This was ensured previously by
calling vcpu_clear_mmio_info() from kvm_mmu_load()
rather than just kvm_mmu_new_pgd().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d612a5d071fc..8b20a5eac1c9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4992,7 +4992,6 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 * happen for VMFail, but we get here if the check was caught by
 	 * the processor and therefore the guest CR3 was loaded prematurely.
 	 */
-	kvm_mmu_unload(vcpu);
 	if (nested_vmx_load_cr3(vcpu, vmcs_readl(GUEST_CR3), false, !enable_ept, &ignored))
 		nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);
 	if (enable_ept && is_pae_paging(vcpu))
-- 
2.52.0


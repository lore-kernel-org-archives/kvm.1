Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FA3FE660
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374615; cv=none; b=Fb6B6PCKN4HNJqpsaqHt0slpGhazkc/H2g3NnHujdn1bWtair7SQ7u9O4pmLrk5XpFYpRGKGCAAsrzzOE19GUM7l5bNiplhKSsxMxTMPyqH/C/rWZGB27n2u50DSofCPlpJI0BKcg0kLKKa9jtaCx5bNRABmGINnwSbFWb04NPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374615; c=relaxed/simple;
	bh=+u1fMN6nd8KUKMbyFT62MQ4AptYZ2XnnW9NGV9ACRcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9PVIhlaINJ8InvdP9DqRxP8m926II7tlnwq1ReWSiB845CZsqZ6wMwbmWKQCdL0aLrme0KMXaW7QCY/LYBp6NRiIlm45XM7QSfi8BHRGeY/8p8QwCLHAoVJm+55W6nF1hoGOhCe8NDXqqEcpqE+Zctt79hiRsMMfOl+CxoevwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj2oFQfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj2oFQfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LpoYunsVnYZDVJp7EOWJeICXFOg6+wbjkFfeG7udrI=;
	b=Oj2oFQfIvgyKfAecti8a69I27C4gJkGpaqZO0bybCSk8idxpjxM0SjSXIdyRfI/RH7Ee7n
	55Y9eSwN/wDjJ/UlOUFM+5AVG1emCu7r5vKAtSflSNe9HysfxE48z5fumcgXrAxT1+ZZ5i
	DdcLKVfPxK2PxuoLIRKjABKOt2uge68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-nqghDRKJPCyBbrBknjSguw-1; Tue,
 28 Apr 2026 07:10:04 -0400
X-MC-Unique: nqghDRKJPCyBbrBknjSguw-1
X-Mimecast-MFC-AGG-ID: nqghDRKJPCyBbrBknjSguw_1777374601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28390195609E;
	Tue, 28 Apr 2026 11:10:01 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95C0D180047F;
	Tue, 28 Apr 2026 11:10:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 17/28] KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
Date: Tue, 28 Apr 2026 07:09:35 -0400
Message-ID: <20260428110946.11466-18-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

For EPT, PFERR_USER_MASK refers not to the CPL of the guest,
but to the AND of the U bits encountered while walking guest
page tables; this is consistent with how MBEC differentiates
between XS and XU.  This is available through the
"advanced vmexit information for EPT violations" feature.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/common.h |  6 +++++-
 arch/x86/kvm/vmx/vmx.c    | 10 ++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 40fa72f31fc7..48520fa1c8e8 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -100,9 +100,13 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 		error_code |= (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
 			      ? PFERR_PRESENT_MASK : 0;
 
-	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
+	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
+		if ((exit_qualification & (EPT_VIOLATION_GVA_TRANSLATED|EPT_VIOLATION_GVA_USER))
+		    == (EPT_VIOLATION_GVA_TRANSLATED|EPT_VIOLATION_GVA_USER))
+			error_code |= PFERR_USER_MASK;
+	}
 
 	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa))
 		error_code |= PFERR_PRIVATE_ACCESS;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 72a75fa33c93..5e4aa519423c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2790,6 +2790,16 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		vmx_cap->vpid = 0;
 	}
 
+	/*
+	 * Virtualizing MBEC requires advanced vmexit information in order to
+	 * distinguish supervisor and user accesses.  For simplicity and clarity
+	 * disable MBEC entirely if advanced vmexit information is not available,
+	 * this way mbec=1 in the kvm_intel module parameters implies availability
+	 * to nested guests as well.
+	 */
+	if (!(vmx_cap->ept & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT))
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+
 	if (!cpu_has_sgx())
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
 
-- 
2.52.0



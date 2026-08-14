Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A9486B85
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724558; cv=none; b=JDJ0KYdEDYx/8XdXCRaEjAO1OW+/JensWq+26MJM/br7Zuy7aC6wRq45OXJHD2g5+nN5BWES9Meci/CKF+nPFuowo7tccNJHL6SHU44ISX3iNxAabILUN+DUwDXRCsBtxdFx+KcSskOYuYBN5LZbe6ibuqEaK7fw+r/rg+mm1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724558; c=relaxed/simple;
	bh=40pQPNfaf546yG/yNFv0wnGFuPKLwd5/zubhhplX+YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6RPqeXfc7LamxtqK35VYHiU6W1oNhkUq111lQNhW+Pc+Ud4SpswGOQ5vRy+0aQRPSV5zJ3BJzQy/Pew1xEUjNgg7tYlMCCDIUQ+NhStC8bUytlVnEu1/Y9JqFYJjMNOjwbmX72OU6QYT5rfZVSTC5UElopFSV/uob/ag7pO300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPv9+y1B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPv9+y1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786724555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkvCI5v2xTBFYBwpYSNpPfRznyVSNzaRiOF1l/gIpY0=;
	b=ZPv9+y1Be33QUGGMuqlcpiMV6Pte2j+dcZ3E/t+1Ers939m5VVmIxh4zVzZkAOhXBRVOuI
	3433t3of1ikH1U5wRjjD+8KgsL/xLflQKrmAhGHulLcP/QCJwSl7JmDUaJD0rzTPEbK/Ll
	NEwzXRqsefLWY+XlPv3gyHZrFZ0L4jk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-I_5rLwHhN5qvUNM_u-YyYA-1; Fri,
 14 Aug 2026 12:22:30 -0400
X-MC-Unique: I_5rLwHhN5qvUNM_u-YyYA-1
X-Mimecast-MFC-AGG-ID: I_5rLwHhN5qvUNM_u-YyYA_1786724549
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 525D81800365;
	Fri, 14 Aug 2026 16:22:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.234])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89261423;
	Fri, 14 Aug 2026 16:22:27 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
Date: Fri, 14 Aug 2026 18:22:19 +0200
Message-ID: <20260814162221.2144473-3-vkuznets@redhat.com>
In-Reply-To: <20260814162221.2144473-1-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

VMPTRST with active eVMCS is currently forbidden, however, returning 1
without skipping the instruction will likely result in L1 getting
stuck. While TLFS does not specify the expected behavior, genuine Hyper-V
seems to be returning eVMCS GPA. Implement the same behavior in KVM.

Reported-by: f734222792@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221841
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 216f54a0b8ae..0f5e4b47ecb1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5946,7 +5946,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
+	gpa_t current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
 	int r;
@@ -5954,8 +5954,14 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
-		return 1;
+	/*
+	 * Hyper-V TLFS does not specify the behavior of VMPTRST when eVMCS is used
+	 * but genuine Hyper-V seems to be returning eVMCS GPA.
+	 */
+	if (nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))
+		current_vmptr = to_vmx(vcpu)->nested.hv_evmcs_vmptr;
+	else
+		current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 
 	if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
 				true, sizeof(gpa_t), &gva))
-- 
2.55.0


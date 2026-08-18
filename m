Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5647FB0D
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071993; cv=none; b=aGKp5Sln5tKiQHtOpU04f9QkB3df/o2rnanDHi/zyuLZP19WvDxpSKZKgD5OevdoLVyHX1x+2+xxfheXDZLmMcfFXryon5Nlwlku6+59UpJapKkqveaPkKJRpu/h1C8DM0s2WccOa0YH+RsLM+92TJVDv4rwwde3RLA1Wc1Sd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071993; c=relaxed/simple;
	bh=7jVQRx/QUuEBZ2NRuBVvYhfdAtjKfhXsOqENgke1SQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhehSr9FRTwRPlMmETRVMt+/9WTtK44gNp+2jr0aqI5IiOHumLRp/kqp7vuJPGZZRda80yKK/2cRe+scWjxiklBRUw9EnJ9r9T+esj0R09bQPkqrh0tdYZsYDkhaP/jMsklZpEHOibHmgLXUMZkdG/KK/Lf78fN3kZS0gbxJ9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgC8CrBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgC8CrBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787071989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFtO2RxvYwwbNi/TJdZpyT1ucNq7pbvZhlbyUHeqMho=;
	b=QgC8CrBnUy9RdgGZueaiHRM6ufCmnBVuC72NNoNKjljO7hWDQETD1lgmH4oDxklj4jIezp
	3U4E5tgBewceCJjuC0fdusGFxPTEBBhg2ZLRoA5yz3mNnftABG3Gtba5iWVLuKWk/nZamT
	+OmAYxcXse015Lo2sg0gm1he5eczMNo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-HVMXvxf_Oti0hXuKgg376A-1; Tue,
 18 Aug 2026 12:53:07 -0400
X-MC-Unique: HVMXvxf_Oti0hXuKgg376A-1
X-Mimecast-MFC-AGG-ID: HVMXvxf_Oti0hXuKgg376A_1787071986
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD5BF195608F;
	Tue, 18 Aug 2026 16:53:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1144F3000239;
	Tue, 18 Aug 2026 16:53:03 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
Date: Tue, 18 Aug 2026 18:52:56 +0200
Message-ID: <20260818165258.2613603-3-vkuznets@redhat.com>
In-Reply-To: <20260818165258.2613603-1-vkuznets@redhat.com>
References: <20260818165258.2613603-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

VMPTRST with active eVMCS is currently forbidden, however, returning 1
without skipping the instruction will likely result in L1 getting
stuck. While TLFS does not specify the expected behavior, genuine Hyper-V
seems to be returning eVMCS GPA. Implement the same behavior in KVM.

Reported-by: f734222792@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221841
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 216f54a0b8ae..4b56df4c57f1 100644
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
@@ -5954,8 +5954,16 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
-		return 1;
+	/*
+	 * Hyper-V TLFS does not specify the behavior of VMPTRST when eVMCS is used
+	 * but genuine Hyper-V seems to be returning eVMCS GPA.
+	 */
+#ifdef CONFIG_KVM_HYPERV
+	if (nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))
+		current_vmptr = to_vmx(vcpu)->nested.hv_evmcs_vmptr;
+	else
+#endif
+		current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 
 	if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
 				true, sizeof(gpa_t), &gva))
-- 
2.55.0


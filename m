Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3947FAE5
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072010; cv=none; b=iqoI7S5i3FNVNrRSsiSBRe8fst6bSTOIUYMSlBFEnGJo/sWw5QOxheIQ/8tmZRnHp8byKI/+jbTaICRUPvb1D5HD6mxpgi6ABzo1SZet4YjmoEvXJOZ58APewcr/GOaGZWfM2kZet0jCQdgdPnj9PLviqD7lPBEs9u47d8O2nfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072010; c=relaxed/simple;
	bh=Vm9xUDcAS267yA06KGs7MhS8cKAPJEvEmCcnUx5RbRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmYepMPjSvnm17ivvdBWfePnf0tNdXEU1LMuc5XOJF9noon8jVHkShTTCfHXTfJNtRIUlj3VKGzIg6PulDlL8Xjfui7p94QAaiOs0VKJW5GzchllJR7VhCUC4L0y/axTDLzRWPPjWqiz78u9XM5mBzo2UAcLHx1UAJqudg25idY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QE5ocAiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE5ocAiM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787071998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyc4YAR9TNpBO2M57zNok/MGHeJZrHvF82zUYZWDP9o=;
	b=QE5ocAiMAzFAZ2pOqKRR0hI/vuvMOhK3KZetWGNzgMLEW3f20J+hVDBMLM7/B/X5bLXtFz
	2CZnKtBTAMswMokr0BLNHkE6Okco9VfA+SowJoJWV6KZJAptY+M4mr8E0UOn7Wb3+ZKwee
	2qPuK3PgyKILyQ0JLWu007/kFSDB2KM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-dIZR2-1qMYCFi9CqqonKOQ-1; Tue,
 18 Aug 2026 12:53:09 -0400
X-MC-Unique: dIZR2-1qMYCFi9CqqonKOQ-1
X-Mimecast-MFC-AGG-ID: dIZR2-1qMYCFi9CqqonKOQ_1787071988
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30502195608F;
	Tue, 18 Aug 2026 16:53:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CDCF30002E9;
	Tue, 18 Aug 2026 16:53:06 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is used
Date: Tue, 18 Aug 2026 18:52:57 +0200
Message-ID: <20260818165258.2613603-4-vkuznets@redhat.com>
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

Previously, VMPTRST was forbidden with eVMCS and selftests were mocking the
correct behavior in vmptrst() by returning enlightened vmptr directly.
Since KVM's behavior has changed to match genuine Hyper-V, adjust evmcs
test accordingly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86/evmcs.h | 8 --------
 tools/testing/selftests/kvm/include/x86/vmx.h   | 3 ---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c  | 5 ++---
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/testing/selftests/kvm/include/x86/evmcs.h
index be79bda024bf..8b14a5dfa04b 100644
--- a/tools/testing/selftests/kvm/include/x86/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
@@ -265,14 +265,6 @@ static inline bool load_evmcs(struct hyperv_test_pages *hv)
 	return true;
 }
 
-static inline int evmcs_vmptrst(u64 *value)
-{
-	*value = current_vp_assist->current_nested_vmcs &
-		~HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
-
-	return 0;
-}
-
 static inline int evmcs_vmread(u64 encoding, u64 *value)
 {
 	switch (encoding) {
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 90fffaf91595..047d02aa9688 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -341,9 +341,6 @@ static inline int vmptrst(u64 *value)
 	u64 tmp;
 	u8 ret;
 
-	if (enable_evmcs)
-		return evmcs_vmptrst(value);
-
 	__asm__ __volatile__("vmptrst %[value]; setna %[ret]"
 		: [value]"=m"(tmp), [ret]"=rm"(ret)
 		: : "cc", "memory");
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index c7fa114aee20..88262ddf7fcb 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -95,16 +95,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_SYNC(3);
 	GUEST_ASSERT(load_evmcs(hv_pages));
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
+	/* VMPTRST returns -1 until VMLAUNCH with eVMCS ptr set */
+	GUEST_ASSERT(vmptrstz() == -1);
 
 	GUEST_SYNC(4);
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
 	prepare_vmcs(vmx_pages, l2_guest_code,
 		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
 	GUEST_SYNC(5);
-	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 	current_evmcs->revision_id = -1u;
 	GUEST_ASSERT(vmlaunch());
 	current_evmcs->revision_id = EVMCS_VERSION;
-- 
2.55.0


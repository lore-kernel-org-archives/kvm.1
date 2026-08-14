Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35514746B6
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724556; cv=none; b=CizijtjluzdeufDPqT6SNYcKKD02dSSxb8mlzWubYd6rrqvSyRPDycEkxjbMTpo4Q3YgJGje94OgnOo/uQQng+hDVGuEZvU4z8s3P1+a0R4zyd2u17lxxRrDCaawk089lh4eh2TxejMEwMsbOnG+MhhjIcQS4L0VdLqR+0WzsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724556; c=relaxed/simple;
	bh=Bu0jWuOdVSWXqO8E3D+c2oT9tCFIc6TCk2kM+B9wfh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu07SXih0qy2Z44Bjg9Wc2ksb9MNiDKLv8dCkk2JORZEZeYJW+kMCCjrKxqybwp2He3AoXeJlTC1gnwoOl9nX53UhmaU4eq06wt+0B6JQrLgUdSitXhHaPFqoyTi56dIEoyLS5aml6Efl5wBsWdXAXOHB8NXXisyB8Zx9q6QSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L52F0guV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L52F0guV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786724553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlrUYML2KUzX5oZG9HuRkuYPajINJivUH33duwgHhK8=;
	b=L52F0guVbe2/tEN45cbCmh8iCvd6baHx/8McK+MUw+Frps2BPrm6OHmgHNbUYUUZunLcpJ
	kBiJ6s5wC0bxbr6h3XIOlwV0uDkWkpzsgRDK6LtTMhkCmYPVbRzrMrM8pqunEcIWAji7OO
	zAPymuu3gR3pNYON1zqaaLSNEeoue9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-CAAZdqx7OOa7x77kiV86Lg-1; Fri,
 14 Aug 2026 12:22:32 -0400
X-MC-Unique: CAAZdqx7OOa7x77kiV86Lg-1
X-Mimecast-MFC-AGG-ID: CAAZdqx7OOa7x77kiV86Lg_1786724551
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BED7180064B;
	Fri, 14 Aug 2026 16:22:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.234])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C116E422;
	Fri, 14 Aug 2026 16:22:29 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is used
Date: Fri, 14 Aug 2026 18:22:20 +0200
Message-ID: <20260814162221.2144473-4-vkuznets@redhat.com>
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

Previously, VMPTRST was forbidden with eVMCS and selftests were mocking the
correct behavior in vmptrst() by returning enlightened vmptr directly.
Since KVM's behavior has changed to match genuine Hyper-V, adjust evmcs
test accordingly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h  | 3 ---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c | 5 ++---
 2 files changed, 2 insertions(+), 6 deletions(-)

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


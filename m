Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641301;
	b=e8L7x0+L/P0aNzhMRiiDbYzXcuBswrwE2YVRO+R/Fc7Ap1qM9+G1Jm+7nu5mOi+Nc4s0
	 /6JZIs1LSVXmPk/DKVPJDu9GT8iZLB87SipXnXIBQ2CtIKr7fBOY5gPzAdO4VTakpqn21
	 lytC/pijJvudu/XpXYwSoVw1wu6LHGgyIkr1TMCtSqHkuhrAqJjlur5MOlHMVSXDXQnx4
	 yxmm78TgXs7BVdB5wQg7iKzmdDaGJK3RuHP8oKOaIZq808IuK292QsiIGJ+765dHwBx1u
	 Vt6Hj1qVsfuB4c/M6KL2sUmpyfmxvwYMTpXx1SERwHAAqT5BwDZCVrC2i9kotSzHKVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641301;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=o0OuXSAiD3UWF/7uVNEf9b9uyxZQtkAYntjW2si8HX0=;
	b=0ZJUoWy6xd+mbZ+cpbKyB6SrTIUqp5UhxUoDyuZUO+rh/TCbXKRMnP69s537mEXII1s6
	 N3xSRvtA6MhmEhkFqb3AgPBoITWZI8d2LQvAiF5pdVeLqPIk3K8jOMtJpWHEh2EaXlODb
	 m7xLfTlnNF/uhWVK8qfsxNFot+F0QMQ5XIOTB0kCDBO59/MsRFNo/6FziCIpHQC+GEEML
	 sSIAQSCV3DBJSpVsHbaag5NJdRVVhmuvcMPsv00z0aOe2rupXuC99X4JGZeIBuWjq4inf
	 fCWH6ZOmxeutebe3gPgzH/Zo50gCGzQNqBb/b7BaGUpPExeoJD8FOChSiLA3al5nBGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZ2E+im7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A760716F5
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D4A760716F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZ2E+im7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0OuXSAiD3UWF/7uVNEf9b9uyxZQtkAYntjW2si8HX0=;
	b=fZ2E+im7o5izbv7/oh/raZalCAaoJ40/iOlfeBDLGNEyGiHgY02e9Skueg6toeLyov6cV2
	JFfInb/YEMOMflo/JIWsQDLlEy+xrk6wHxkcUYSKDaxIOXSUqjhRaC/+MU0HWVpTtH1SSG
	PBquDFVibtjen+AE3mx7K6BJyEVBucY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-y0RJKcgvOkyDibugROjzEQ-1; Mon,
 02 Nov 2026 12:41:36 -0500
X-MC-Unique: y0RJKcgvOkyDibugROjzEQ-1
X-Mimecast-MFC-AGG-ID: y0RJKcgvOkyDibugROjzEQ_1793641295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 402EB19560BB;
	Mon,  2 Nov 2026 17:41:35 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C083430000E3;
	Mon,  2 Nov 2026 17:41:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 07/45] KVM: selftests: Take into account mixed memory fault flags
Date: Mon,  2 Nov 2026 12:40:51 -0500
Message-ID: <20261102174130.8779-8-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Update x86_64/private_mem_kvm_exits_test to take into account memory
fault flags might contain multiple bits set while remaining valid---for
example KVM might return KVM_MEMORY_EXIT_FLAG_READ in addition to
KVM_MEMORY_EXIT_FLAG_PRIVATE.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-3-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index f7228e0f1ac6..ed8edde9b718 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -91,6 +91,8 @@ static void test_private_access_memslot_deleted(void)
 	} else {
 		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
 		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+		TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
+			    "Memory fault didn't occur on a private memory access");
 		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
 		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
 	}
@@ -127,7 +129,8 @@ static void test_private_access_memslot_not_private(void)
 	exit_reason = run_vcpu_get_exit_reason(vcpu);
 
 	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
+		    "Memory fault didn't occur on a private memory access");
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
 
-- 
2.52.0



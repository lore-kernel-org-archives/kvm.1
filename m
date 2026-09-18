Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35545495ACE
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739440; cv=none; b=ZCYXCJxXnMUdw5mFgXgC74YWW6rGhVf/hzA4VqfCekvOpOiQ1m9goLCrKUkQiNwYjKrFOz/UeBDYN2Nv/+UlKCMEebgERDe/y6AVz4c/tqvcnVIRhJOLY2d6Lkh2F7fj6Ao6I+Qn7oI5rJdPiyMpP790f3bw/cZBq3lj76bb/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739440; c=relaxed/simple;
	bh=LecEQKu/SDwbIJ98w082y35hYPM4bZ2YqckHZDStxmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W33RfzZcezjlFyPfTdO1+rLytk/vFQrrg3cY+joXpQ+vF0PHPWMra8+IsTFYCPTvywRtTNYjuoUgb/fVXtb0bFPVK3qYhgPWABDueuZDeV7P4R2+iZO9BEPiuvqN6lybS90w+PcHnqOqqmlAIkNm8g+HRVxAegkxd29rhzGxnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ez5bg0rj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez5bg0rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+RBgkHWDBWjcz9ZqG24LQx/Q7KFkaJuhhsDYniJ5qc=;
	b=ez5bg0rjt/TETEX1fNiBI6lkGo4sES4t4rIWpSGi0h13G425LcFQ9FozHSmKH3XCN/d477
	pB/GZ/Nu+gTsitnHatWCXAFEld4HMLRrW/74g7AhGm/NdGLnTaDGXszaCH5cGAx+5U+mUj
	Ia9qDSu7Z9iHbMUilh/xLq/rhFZQTUA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-Enm4X3rPNE62PsWIseykpA-1; Fri,
 18 Sep 2026 09:50:34 -0400
X-MC-Unique: Enm4X3rPNE62PsWIseykpA-1
X-Mimecast-MFC-AGG-ID: Enm4X3rPNE62PsWIseykpA_1789739433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFD2E1800DA1;
	Fri, 18 Sep 2026 13:50:33 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F16A1956042;
	Fri, 18 Sep 2026 13:50:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 02/31] KVM: selftests: Take into account mixed memory fault flags
Date: Fri, 18 Sep 2026 09:50:01 -0400
Message-ID: <20260918135030.171564-3-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Update x86_64/private_mem_kvm_exits_test to take into account memory
fault flags might contain multiple bits set while remaining valid---for
example KVM might return KVM_MEMORY_EXIT_FLAG_READ in addition to
KVM_MEMORY_EXIT_FLAG_PRIVATE.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../testing/selftests/kvm/x86/private_mem_kvm_exits_test.c  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index e6d16e9d6120..33fd73465432 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -74,7 +74,8 @@ static void test_private_access_memslot_deleted(void)
 	exit_reason = (u32)(u64)thread_return;
 
 	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
+		    "Memory fault didn't occur on a private memory access");
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
 
@@ -103,7 +104,8 @@ static void test_private_access_memslot_not_private(void)
 	exit_reason = run_vcpu_get_exit_reason(vcpu);
 
 	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
+		    "Memory fault didn't occur on a private memory access");
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
 
-- 
2.52.0



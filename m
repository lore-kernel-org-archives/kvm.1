Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E73C3442
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719354; cv=none; b=kFk5lrNf/OW6Fl5/pzlZdmRq1ht8SaLkeIN/IXetBiDJG+QZyhuVgIPXDdTPOs0i2djE+z+w3RfTUEG2TEEivzLq5sNXbL+LRvciQast7oqs2mMVnP2OAPFjLS1URE7Uxgythw+FDTKRZWWnIdeSgFd+/hUdJ06pdfygPwLojBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719354; c=relaxed/simple;
	bh=LecEQKu/SDwbIJ98w082y35hYPM4bZ2YqckHZDStxmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nf/oa1B9uDYNzbmHXkB5eY8JSIxwtwsGHWky+5wTJJzh53JKRYU9BCa1BZ/M+qMOtNnFABJIB/vZS6Z1fUQfdLkRNPQdPy/4G0no+v1oK6EOMko1s1cT6+XIV1CJX8D5q0dY6ytAuMjZEDJB0ucm5h0B5WhWSMfB1hAnvLGQG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkp7rGHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkp7rGHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+RBgkHWDBWjcz9ZqG24LQx/Q7KFkaJuhhsDYniJ5qc=;
	b=fkp7rGHf9s/dxvG5DcDVQL35OCYMfDAeJZIe5uTv+u8X1LB6PEqUOvjuPMnSoHpkYvUAMi
	7fkUOFRDsEce9AcxW2RWQzVLNua0mT54EWO4HrJsYzE/e8JqUoQRv+mqQwoOUM67gwR09x
	rGr3sRljIoebzWhM+XHtt8SoS0HSnY8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-3aSHCHnJPLag7WyhqsRq-A-1; Fri,
 18 Sep 2026 04:15:46 -0400
X-MC-Unique: 3aSHCHnJPLag7WyhqsRq-A-1
X-Mimecast-MFC-AGG-ID: 3aSHCHnJPLag7WyhqsRq-A_1789719345
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FD3A194511A;
	Fri, 18 Sep 2026 08:15:45 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A607F1800348;
	Fri, 18 Sep 2026 08:15:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 01/28] KVM: selftests: Take into account mixed memory fault flags
Date: Fri, 18 Sep 2026 04:15:16 -0400
Message-ID: <20260918081543.139871-2-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
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



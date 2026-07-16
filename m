Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0043E079
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225708; cv=none; b=TRzyEkHcIR0ktxHgOlyy1fW3SQxyjw+xVL3HkgJxHMZnz3s5qgvYE71187KTvJPFGQrl5Y9FC/vIVGl5+GL6EZ3G4Z8JJAz3HqQeUT8t2f3Fz4Sat1TYLrFCSTy+QOjdbZGXzKYeaffO7MvYn6ML20dAJmrAA69ZqadVucQ/rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225708; c=relaxed/simple;
	bh=Gmk3fsCPJ9/fpzOw/uDpZP5Yi/5iPCaqU5WO1EXGx4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3IZ0CeZZNSnmccVikKRzOKxioWLGXhr6ZSpjtpN7sA9/G+WanDdZTDe1J2FsfUatPrXUD0MhzztSv02Aa3r5pJVeJ68XyaCegnr/wAdtEeiiZHQvOd5tZcob66S+FJrG50sDXd2nNtUUvn/Hlb9NSqBeJzO/tA6RJIEEWpIiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPNEucXW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPNEucXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0nQvlR4hNkHzkahJsScWQc9QTREYmqYVvHYGclEvv0=;
	b=KPNEucXWOe4HgUvStPS2uC+kT1x/o+PXDhqKrh7Dewu5N29cLln4h7/h7obvptQdmk1LnB
	5PDYE49B0sFVFlxFRkZ6As9r5k3YEvGmsmeSXa6W87JGN10XoIQgao3b3yhsLhD9V7bp9B
	eA4ppGaPzKLKLvAlthPDuo6RecFzDGg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-2m4bTt_wOu2MyZ7F5nBSSg-1; Thu,
 16 Jul 2026 14:14:59 -0400
X-MC-Unique: 2m4bTt_wOu2MyZ7F5nBSSg-1
X-Mimecast-MFC-AGG-ID: 2m4bTt_wOu2MyZ7F5nBSSg_1784225698
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 816751955F04;
	Thu, 16 Jul 2026 18:14:58 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10737195604E;
	Thu, 16 Jul 2026 18:14:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 01/24] KVM: selftests: Take into account mixed memory fault flags
Date: Thu, 16 Jul 2026 14:14:33 -0400
Message-ID: <20260716181456.402786-2-pbonzini@redhat.com>
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
index 10db9fe6d906..70ed3d591ab6 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -75,7 +75,8 @@ static void test_private_access_memslot_deleted(void)
 	exit_reason = (u32)(u64)thread_return;
 
 	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
+		    "Memory fault didn't occur on a private memory access");
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
 
@@ -104,7 +105,8 @@ static void test_private_access_memslot_not_private(void)
 	exit_reason = run_vcpu_get_exit_reason(vcpu);
 
 	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+	TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
+		    "Memory fault didn't occur on a private memory access");
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
 
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86254FD271
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739442; cv=none; b=nh4OyixpMzlpS7ytY1ce9S/TMaFIvYywLW9TB0f4aVFlDxh0RW8230b3g/t0ZBsWQukX4eEVq864ESb4XCr4VhNsfD7QYccbm0gViV9OSEonQuz2pENtYioiozmX4KtyX7IQWTrVcPsiRO0StavadeTCoI/Qb3fVxpZZPmI6m4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739442; c=relaxed/simple;
	bh=zzEHyCrP6YSfLJgk6zrPkxbRErf6W7r56cYPcCj1LHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBNH1CdfhETDAPIIvS+s0ZAdwledJFhbCQfbWxfOCfndfhrf71lSwCkfCEA7CWhU15X9cd+oqa7BaAwc7wi6+2UfF+ATA6D/UrYNG3AD8/zBcymzqaPmLSzWR5mGWRFBUKRIA2a8LwkZRFnhFq5pmtg/7YUTj72IrP1x39ZmyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0WhP4bH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0WhP4bH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w60wt/dkt6/s0NeTy3kqOW1+30h7wm/BdjoJ3Ym0CcI=;
	b=F0WhP4bHX7sCwUJQtkorCkkwhY4ofhs0XKsKvulHq+sztTkhPw4R8rc4bPir7d7nibDzDn
	YxGbGHocRzlnuIx3Mahbd0aKaNjA3Y9AAC2xZFTVCevxmuiiozPIFShMtDInAPYMGq22Sw
	l++7n48awA/RA/Nq6ccDUwUWXzPuMw0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-5FKcczEXNDCOh2TQGr8fsA-1; Fri,
 18 Sep 2026 09:50:36 -0400
X-MC-Unique: 5FKcczEXNDCOh2TQGr8fsA-1
X-Mimecast-MFC-AGG-ID: 5FKcczEXNDCOh2TQGr8fsA_1789739435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D41731955EB9;
	Fri, 18 Sep 2026 13:50:34 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0285A1956042;
	Fri, 18 Sep 2026 13:50:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com,
	Anish Moorthy <amoorthy@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 03/31] KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to userspace
Date: Fri, 18 Sep 2026 09:50:02 -0400
Message-ID: <20260918135030.171564-4-pbonzini@redhat.com>
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

From: Anish Moorthy <amoorthy@google.com>

kvm_prepare_memory_fault_exit() already takes parameters describing the
RWX-ness of the relevant access but doesn't actually do anything with
them. Define and use the flags necessary to pass this information on to
userspace.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/ZR4N8cwzTMDanPUY@google.com/
Signed-off-by: Anish Moorthy <amoorthy@google.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 include/linux/kvm_host.h       | 9 ++++++++-
 include/uapi/linux/kvm.h       | 3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 4eb7e75a7473..37028ce019e3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7279,6 +7279,9 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
 
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
+  #define KVM_MEMORY_EXIT_FLAG_READ     (1ULL << 0)
+  #define KVM_MEMORY_EXIT_FLAG_WRITE    (1ULL << 1)
+  #define KVM_MEMORY_EXIT_FLAG_EXEC     (1ULL << 2)
   #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 			__u64 flags;
 			__u64 gpa;
@@ -7290,6 +7293,8 @@ could not be resolved by KVM.  The 'gpa' and 'size' (in bytes) describe the
 guest physical address range [gpa, gpa + size) of the fault.  The 'flags' field
 describes properties of the faulting access that are likely pertinent:
 
+ - KVM_MEMORY_EXIT_FLAG_READ/WRITE/EXEC - When set, indicates that the memory
+   fault occurred on a read/write/exec access respectively.
  - KVM_MEMORY_EXIT_FLAG_PRIVATE - When set, indicates the memory fault occurred
    on a private memory access.  When clear, indicates the fault occurred on a
    shared access.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..ce5757e85ae3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2546,8 +2546,15 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 	vcpu->run->memory_fault.gpa = gpa;
 	vcpu->run->memory_fault.size = size;
 
-	/* RWX flags are not (yet) defined or communicated to userspace. */
 	vcpu->run->memory_fault.flags = 0;
+
+	if (is_write)
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_WRITE;
+	else if (is_exec)
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_EXEC;
+	else
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_READ;
+
 	if (is_private)
 		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
 }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ac2d77d14963..15a3090f067e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -457,6 +457,9 @@ struct kvm_run {
 		} notify;
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
+#define KVM_MEMORY_EXIT_FLAG_READ       (1ULL << 0)
+#define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
+#define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 			__u64 flags;
 			__u64 gpa;
-- 
2.52.0



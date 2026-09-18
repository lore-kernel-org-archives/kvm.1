Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09712FABFB
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719353; cv=none; b=prgH9GjM4uspZjn6o+UXzrBd6CjFFWJJKn5uxpGwztdcR6ND9PExLJ/mYxetY5n5IJ+Eq4noIK16lyhR8ZnQ2SB7kISDYyspRAQHGPuzc12EKW/BwPOP2cF9vBHHqaNTpVwlB3IeNk4/s59DNUxrEqH8OReejQpADl+LOCfh7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719353; c=relaxed/simple;
	bh=zzEHyCrP6YSfLJgk6zrPkxbRErf6W7r56cYPcCj1LHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaYinUnxJnNQR/jjl39+4wyb9LQhZjOGfccNQnF8uFTB4aDzaZ7RpkvfXL4xpRvJlrr0zbk/TwjzwurI3LhmRTYYb6uvI6PX+cCNTNmcKOGbJqe1EzZtIVkJ5wh6VyAb+LcrixhRhfc98VO1H17NHxqzhFtFs8j3Ex+GLdiXQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPBr66v+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPBr66v+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w60wt/dkt6/s0NeTy3kqOW1+30h7wm/BdjoJ3Ym0CcI=;
	b=iPBr66v+1FxjDU92vWaqNURGRJmPvFhQfAxy3nPeb0rMiDNaj80xwA9vVkii44F6M2OE36
	yxCBy8t1ne6brt9F0qnPxXLicfeePi8Ej1Kx2oeIUWWmrhx9eB+RzJUqVzY1R86o4rn1ow
	iopNBJKfnQDtXQUycV6N/KxK4j9QFBM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-U2b55Cj7NYyeaLgOS0wqhA-1; Fri,
 18 Sep 2026 04:15:47 -0400
X-MC-Unique: U2b55Cj7NYyeaLgOS0wqhA-1
X-Mimecast-MFC-AGG-ID: U2b55Cj7NYyeaLgOS0wqhA_1789719346
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49567180AECA;
	Fri, 18 Sep 2026 08:15:46 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 771B11800348;
	Fri, 18 Sep 2026 08:15:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com,
	Anish Moorthy <amoorthy@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 02/28] KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to userspace
Date: Fri, 18 Sep 2026 04:15:17 -0400
Message-ID: <20260918081543.139871-3-pbonzini@redhat.com>
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



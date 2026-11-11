Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387291;
	b=pgmLAb+NIPWub510iDuh6CO4oFok22KJIvXZ9A14xHejRLanbHNYP1Iz3nWQyvIJna/F
	 QpcRrGP/3BzV2O8ttaP9Avhyp5ZCn2DmjUMJNR0wi9H1yH6zPTI0sMgfrV1YrCR58JYtH
	 RSaz31EV/aVDIjVa6Oh7WVeM6e3sw8CecpB3GAggnyjq2bT9TG/lh+mV9aRbJ7h7qQboq
	 PPE3XIbFR5GW2vA6gxv3bjpsVxwc77jQEt0fsPsh6hdlvJwYQxDBeYTcAwfL/op5CAEW2
	 WptpCwZAjIcBcECUxfvfIbRjlBV+WJ/+JiAU67g1aH0JoFOMsMbZrhggZlu+NQWoWKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387291;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xep7SBbbNDO5bMEHEU9WWCJxZIaQH/GFG20RUGACPvc=;
	b=MINBcFCxHWqs40uGaIdGwm3v6vVP+lumbDyP2dxyo1xAzOQBEpOKTsa8suzKk4PZJs6N
	 hw3ljdhvJCGpT3iS7YlLvN77l76TfYNUbkU5sM3jqKRvJq/HtRSZbDv7BbaBKpbvuAx/G
	 6kNNIqlLV7jMEpjKe1VFv6swRkXsWIRe7HgQtT57f5Yd6070YIgnQJ+RbM90ndzjt9LMe
	 bnbrDHo0DwI0CHz9pLzkFelg97L6js66UPXss9daKWPncOKJw8yDW2krFz1/wlgTHp6v+
	 TLhjA67+L7ylUTmSmbBrJuhtUwQDwFRkoQ7NntCdDV/C51WKBLbJrHtslyGIWsrZhRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QC9KmbNq;
	arc=none smtp.remote-ip=91.218.175.28
Received: from mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4D606A32A
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A4D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QC9KmbNq
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NENmiS2g+Y1HlHuwMownwP4RTuyExhGZrangX/wccZU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794387289; v=1; x=1794992089;
 b=QC9KmbNqMylSkMQ+J8EMF5eX+pJzPm61NDVJU7T59gqn3k+faeEJgJc6zn0L5ei94LRFaT5g
 JdlcCllSInDfsA1QNQEkDuekZGv+0LYKjwJJC1nnv11zukCF/oF4FOuVf6+vM5M7SnQGzpoR2KD
 cGXfqiRl9faASGg0ZWO4qF6I=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ebd9db9384436d83;
	Wed, 11 Nov 2026 08:54:49 +0000
X-Mizu-Trace-ID: ebd9db9384436d83
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mips@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH 1/7] Documentation: KVM: Fix references to non-existent identifiers
Date: Wed, 11 Nov 2026 08:54:42 +0000
Message-ID: <20261111085448.1130701-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111085448.1130701-1-fuad.tabba@linux.dev>
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KVM API documentation and the review checklist refer to
non-existent ioctls, capabilities, structures, fields and constants.
Use the names from the uAPI headers.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/api.rst              | 40 ++++++++++-----------
 Documentation/virt/kvm/review-checklist.rst |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d9..ccdc210575e25 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -897,7 +897,7 @@ x86 allows the operating system to program the interrupt polarity
 (active-low/active-high) for level-triggered interrupts, and KVM used
 to consider the polarity.  However, due to bitrot in the handling of
 active-low interrupts, the above convention is now valid on x86 too.
-This is signaled by KVM_CAP_X86_IOAPIC_POLARITY_IGNORED.  Userspace
+This is signaled by KVM_CAP_IOAPIC_POLARITY_IGNORED.  Userspace
 should not present interrupts to the guest as active-low unless this
 capability is present (or unless it is not using the in-kernel irqchip,
 of course).
@@ -941,7 +941,7 @@ be used for a userspace interrupt controller.
   struct kvm_irq_level {
 	union {
 		__u32 irq;     /* GSI */
-		__s32 status;  /* not used for KVM_IRQ_LEVEL */
+		__s32 status;  /* not used for KVM_IRQ_LINE */
 	};
 	__u32 level;           /* 0 or 1 */
   };
@@ -3219,7 +3219,7 @@ With KVM_CAP_IRQFD_RESAMPLE, KVM_IRQFD supports a de-assert and notify
 mechanism allowing emulation of level-triggered, irqfd-based
 interrupts.  When KVM_IRQFD_FLAG_RESAMPLE is set the user must pass an
 additional eventfd in the kvm_irqfd.resamplefd field.  When operating
-in resample mode, posting of an interrupt through kvm_irq.fd asserts
+in resample mode, posting of an interrupt through kvm_irqfd.fd asserts
 the specified gsi in the irqchip.  When the irqchip is resampled, such
 as from an EOI, the gsi is de-asserted and the user is notified via
 kvm_irqfd.resamplefd.  It is the user's responsibility to re-queue
@@ -4982,8 +4982,8 @@ Errors:
   #define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
   #define KVM_STATE_NESTED_SVM_VMCB_SIZE	0x1000
 
-  #define KVM_STATE_NESTED_VMX_SMM_GUEST_MODE	0x00000001
-  #define KVM_STATE_NESTED_VMX_SMM_VMXON	0x00000002
+  #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
+  #define KVM_STATE_NESTED_SMM_VMXON		0x00000002
 
   #define KVM_STATE_NESTED_GIF_SET		0x00000100
 
@@ -5448,14 +5448,14 @@ KVM_PV_DISABLE
   KVM_PV_ASYNC_CLEANUP_PERFORM, it will be torn down in this call
   together with the current protected VM.
 
-KVM_PV_VM_SET_SEC_PARMS
+KVM_PV_SET_SEC_PARMS
   Pass the image header from VM memory to the Ultravisor in
   preparation of image unpacking and verification.
 
-KVM_PV_VM_UNPACK
+KVM_PV_UNPACK
   Unpack (protect and decrypt) a page of the encrypted boot image.
 
-KVM_PV_VM_VERIFY
+KVM_PV_VERIFY
   Verify the integrity of the unpacked image. Only if this succeeds,
   KVM is allowed to start protected VCPUs.
 
@@ -5951,7 +5951,7 @@ This ioctl (when supported) replaces the KVM_SET_SREGS.
 4.133 KVM_GET_STATS_FD
 ----------------------
 
-:Capability: KVM_CAP_STATS_BINARY_FD
+:Capability: KVM_CAP_BINARY_STATS_FD
 :Architectures: all
 :Type: vm ioctl, vcpu ioctl
 :Parameters: none
@@ -6087,10 +6087,10 @@ Bits 0-3 of ``flags`` encode the type:
   * ``KVM_STATS_TYPE_LINEAR_HIST``
     The statistic is reported as a linear histogram. The number of
     buckets is specified by the ``size`` field. The size of buckets is specified
-    by the ``hist_param`` field. The range of the Nth bucket (1 <= N < ``size``)
-    is [``hist_param``*(N-1), ``hist_param``*N), while the range of the last
-    bucket is [``hist_param``*(``size``-1), +INF). (+INF means positive infinity
-    value.)
+    by the ``bucket_size`` field. The range of the Nth bucket
+    (1 <= N < ``size``) is [``bucket_size``*(N-1), ``bucket_size``*N), while
+    the range of the last bucket is [``bucket_size``*(``size``-1), +INF).
+    (+INF means positive infinity value.)
   * ``KVM_STATS_TYPE_LOG_HIST``
     The statistic is reported as a logarithmic histogram. The number of
     buckets is specified by the ``size`` field. The range of the first bucket is
@@ -6962,8 +6962,8 @@ to the byte array.
 
 .. note::
 
-      For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR, KVM_EXIT_XEN,
-      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_TDX,
+      For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR_HCALL,
+      KVM_EXIT_XEN, KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_TDX,
       KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR the corresponding
       operations are complete (and guest state is consistent) only after userspace
       has re-entered the kernel with KVM_RUN.  The kernel side will first finish
@@ -8607,7 +8607,7 @@ See Documentation/arch/x86/sgx.rst for more details.
 :Parameters: args[0] whether the feature should be enabled or not
 
 When this capability is enabled, an emulation failure will result in an exit
-to userspace with KVM_INTERNAL_ERROR (except when the emulator was invoked
+to userspace with KVM_EXIT_INTERNAL_ERROR (except when the emulator was invoked
 to handle a VMware backdoor instruction). Furthermore, KVM will now provide up
 to 15 instruction bytes for any exit to userspace resulting from an emulation
 failure.  When these exits to userspace occur use the emulation_failure struct
@@ -9232,7 +9232,7 @@ utilises it.
 If KVM_CHECK_EXTENSION on a kvm VM handle indicates that this capability is
 available, it means that the VM is using full hardware assisted virtualization
 capabilities of the hardware. This is useful to check after creating a VM with
-KVM_VM_MIPS_DEFAULT.
+KVM_VM_MIPS_AUTO.
 
 The value returned by KVM_CHECK_EXTENSION should be compared against known
 values (see below). All other values are reserved. This is to allow for the
@@ -9541,8 +9541,8 @@ related to event channel delivery, timers, and the XENVER_version
 interception.
 
 The KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG flag indicates that KVM supports
-the KVM_XEN_ATTR_TYPE_RUNSTATE_UPDATE_FLAG attribute in the KVM_XEN_SET_ATTR
-and KVM_XEN_GET_ATTR ioctls. This controls whether KVM will set the
+the KVM_XEN_ATTR_TYPE_RUNSTATE_UPDATE_FLAG attribute in the KVM_XEN_HVM_SET_ATTR
+and KVM_XEN_HVM_GET_ATTR ioctls. This controls whether KVM will set the
 XEN_RUNSTATE_UPDATE flag in guest memory mapped vcpu_runstate_info during
 updates of the runstate information. Note that versions of KVM which support
 the RUNSTATE feature above, but not the RUNSTATE_UPDATE_FLAG feature, will
@@ -9750,7 +9750,7 @@ Local APIC features
 
 CPU[EAX=1]:ECX[21] (X2APIC) is reported by ``KVM_GET_SUPPORTED_CPUID``,
 but it can only be enabled if ``KVM_CREATE_IRQCHIP`` or
-``KVM_ENABLE_CAP(KVM_CAP_IRQCHIP_SPLIT)`` are used to enable in-kernel emulation of
+``KVM_ENABLE_CAP(KVM_CAP_SPLIT_IRQCHIP)`` are used to enable in-kernel emulation of
 the local APIC.
 
 The same is true for the ``KVM_FEATURE_PV_UNHALT`` paravirtualized feature.
diff --git a/Documentation/virt/kvm/review-checklist.rst b/Documentation/virt/kvm/review-checklist.rst
index 053f00c50d669..5f8398be52472 100644
--- a/Documentation/virt/kvm/review-checklist.rst
+++ b/Documentation/virt/kvm/review-checklist.rst
@@ -18,7 +18,7 @@ Review checklist for kvm patches
 5.  New features must default to off (userspace should explicitly request them).
     Performance improvements can and should default to on.
 
-6.  New cpu features should be exposed via KVM_GET_SUPPORTED_CPUID2,
+6.  New cpu features should be exposed via KVM_GET_SUPPORTED_CPUID,
     or its equivalent for non-x86 architectures
 
 7.  The feature should be testable (see below).
-- 
2.47.3


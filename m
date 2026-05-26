Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608F20CCDC
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799947; cv=none; b=itbvzryUR7+vt14VVIxidHtyw6BqoziA/aIjRxm6GJjFattXAV9LfMghIyt2loxku/XuZZntU/vq/TMT4m2Wsu0yzSvcVCsqIFF33+yP4E59knGeB4oJtV4bAFyy5KLKt/Z9e6OMEfxfyf9kQi4YL9Gc55NpOGQda/yULFPPMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799947; c=relaxed/simple;
	bh=rYhRrs88RHIj62zfJFDmz8xFMOnci/idnOZtNoUfAg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GT5IaTiK4KNwpoRkyMc3azW+p5+34k806qxZ+4MH3knm/jMV6Yj7fDgIRUp77o/EDHF4k3Vnh+KreKZ/Sk8WjWm70jJ0khEANvXpPGRqU0uLUJC6iyVUPQe7uJRnqLxnDCKRxOtcAp/Jc3wdSiZcAfmqrWz0IouHAWfwqdUy9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD0iogQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD0iogQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5891F000E9;
	Tue, 26 May 2026 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779799946;
	bh=JBDZhejIHol507Eo3B9PyEYufW4FjCNOz11telz2+Ew=;
	h=From:To:Cc:Subject:Date;
	b=MD0iogQcvgwEmu6WTLbDSpzTGjuWPNl7E5yDTfIChT33rqAYCIPtbSONfp17WveNL
	 6W1R7kWS1nRlp4aNsfdY+82wv8D2+LoZj7lZep3HwLSD5ac9YpinfQgH1pLzcWB8Lm
	 IG1NWF77RXcEpaGla1bEoGspTZIJ/5th8oTn6aGCxnzQzszh84yBmq4pfM152+ZBDJ
	 +fdlo7ycrimGmnOUeHDO+tBSR5sGnkPCxyxq/STEvlZ2yWCsw00n3kA64KUvI6Zii8
	 v/bqjOoXOXs3ovdgvdSJRCfN+uS+Z1D01azzMr3U3BCDzajjesOahR5Rp3N4MpVuVz
	 x7HJ2Ql3YcNvA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	kvm@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] kvm: rework memory prefault
Date: Tue, 26 May 2026 14:52:19 +0200
Message-Id: <20260526125220.1560451-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When both s390 and arm64 KVM modules are enabled on s390,
the latter fails to link against the s390 version of
kvm_arch_vcpu_pre_fault_memory():

ERROR: modpost: "kvm_arch_vcpu_pre_fault_memory" [arch/s390/kvm/arm64/kvm-arm64.ko] undefined!

Change the logic to reference this based on a target
specific macro rather than a global Kconfig symbol.

Fixes: f67bba50ef56 ("KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild")
Fixes: 927ce4dee94f ("KVM: s390: Implement KVM_PRE_FAULT_MEMORY")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is not yet an actual problem, but will be when both
the experimental 'sae' branch and the 7.2 contents from
current linux-next are merged.

Not sure who should carry this patch in the meantime, but
it would be possible to add it to kvm-next already in
preparation for the upcoming sae support.
---
 arch/s390/include/asm/kvm_host_s390.h | 4 ++++
 arch/s390/kvm/s390/Kconfig            | 1 -
 arch/x86/include/asm/kvm_host.h       | 4 ++++
 arch/x86/kvm/Kconfig                  | 1 -
 include/linux/kvm_host.h              | 5 -----
 virt/kvm/Kconfig                      | 3 ---
 virt/kvm/kvm_main.c                   | 4 ++--
 7 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index d4bf6d0df49f..9532dc680c5a 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -742,6 +742,10 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 #define __KVM_HAVE_ARCH_VM_FREE
 void kvm_arch_free_vm(struct kvm *kvm);
 
+#define __KVM_HAVE_ARCH_PRE_FAULT_MEMORY
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range);
+
 struct zpci_kvm_hook {
 	int (*kvm_register)(void *opaque, struct kvm *kvm);
 	void (*kvm_unregister)(void *opaque);
diff --git a/arch/s390/kvm/s390/Kconfig b/arch/s390/kvm/s390/Kconfig
index 5777663e44b9..263ff29b9c9c 100644
--- a/arch/s390/kvm/s390/Kconfig
+++ b/arch/s390/kvm/s390/Kconfig
@@ -18,7 +18,6 @@ config KVM_S390
 	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_MMU_LOCKLESS_AGING
-	select KVM_GENERIC_PRE_FAULT_MEMORY
 	help
 	  Support hosting paravirtualized s390 guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 809b285161d9..dfb8d7e67db9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2077,6 +2077,10 @@ extern struct kvm_x86_ops kvm_x86_ops;
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
 void kvm_x86_vendor_exit(void);
 
+#define __KVM_HAVE_ARCH_PRE_FAULT_MEMORY
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range);
+
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index a6824b6fbf10..1856dc502b07 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -45,7 +45,6 @@ config KVM_X86
 	select KVM_VFIO
 	select HAVE_KVM_PM_NOTIFIER if PM
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select KVM_WERROR if WERROR
 	select KVM_GUEST_MEMFD if X86_64
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 690e34587414..70a1174df996 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2605,9 +2605,4 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 #endif
 
-#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
-long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
-				    struct kvm_pre_fault_memory *range);
-#endif
-
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index c4a983e41765..fefdf5d44646 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -65,9 +65,6 @@ config HAVE_KVM_INVALID_WAKEUPS
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
 
-config KVM_GENERIC_PRE_FAULT_MEMORY
-       bool
-
 config KVM_COMPAT
        def_bool y
        depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0d36e4d264f5..10f0748ad077 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4309,7 +4309,7 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 	return fd;
 }
 
-#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+#ifdef __KVM_HAVE_ARCH_PRE_FAULT_MEMORY
 static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				     struct kvm_pre_fault_memory *range)
 {
@@ -4608,7 +4608,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_get_stats_fd(vcpu);
 		break;
 	}
-#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+#ifdef __KVM_HAVE_ARCH_PRE_FAULT_MEMORY
 	case KVM_PRE_FAULT_MEMORY: {
 		struct kvm_pre_fault_memory range;
 
-- 
2.39.5


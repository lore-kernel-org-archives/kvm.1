Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8346C828;
	Wed,  5 Aug 2026 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927857; cv=none; b=MiiKXeNO/yzcxbVgbyLWPeNDIJLHC+UqNJbZNySWhiZmDRwVywzLPoVseq+hjXKfIBdQsK/t75LPwNA0QhRfV4pqjhBvjeOGZ/q2snizzXbBnnVWRh6ZB8J/GBzMuP2XJyziatCt7JJ/ejWxsg2AU5fZiHZ9i4FOV9mULxfjuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927857; c=relaxed/simple;
	bh=HjrorX9aEMR3A/jZmW1M5gilRKHOo4eaxQ8e71+nlrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFe9FSmKDZ9Pe+fGOKmblc5z+VfsxlCXnOobvVmkt7lKjffx8ctU1l+qK/ztbfUrq7Hsug1i8wlqXse3mcSxYkQjZ8OXnLvsg1SEh9IbXWCXwbw6TsYeRQrDmoOcEg/B5Ys0P/ACihuBtkdjOd/0J5SoQKp3iRcdbz93HfP4hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cDWVByI+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cDWVByI+"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE50D20B7169;
	Wed,  5 Aug 2026 04:03:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE50D20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927834;
	bh=plw5PYs+q/L8H//hTTFQmxHz/itglm5JTOg6RfG0a0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDWVByI+Vstdqh/a+LKd41emN7NWXSn66sG6pK+5PQ42d6BimAIQhTavJj52cTjeI
	 pKtv64YpK2tEwfw20hVCI/DTSadE3SUKFm4jKRcKwssdonqXj7d5BKf1ADCJXhbrKY
	 WBb31Ult3tI12gUpKr85l1lW+6ZysKVePusTQTwI=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 39/42] kvm: arch: finalize plane hooks and kvm_arch_vcpu_create signature
Date: Wed,  5 Aug 2026 04:03:21 -0700
Message-ID: <20260805110324.25067-40-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the vm-planes-merged tree on non-x86 architectures: revert
kvm_arch_vcpu_create() to its plane-less prototype (planes attach the
vCPU to plane 0 in generic code) and add the kvm_arch_init_plane/
kvm_arch_free_plane/kvm_arch_sync_events stubs without the stray
conflict markers that the integration branch left committed.
---
 arch/arm64/include/asm/kvm_host.h   | 7 +++++++
 arch/arm64/kvm/arm.c                | 2 +-
 arch/mips/include/asm/kvm_host.h    | 6 ++++++
 arch/powerpc/include/asm/kvm_host.h | 6 ++++++
 arch/riscv/kvm/vcpu.c               | 2 +-
 arch/s390/include/asm/kvm_host.h    | 6 ++++++
 6 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d3807b6535cc..75b4e52c4bac 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -237,6 +237,9 @@ struct kvm_s2_mmu {
 struct kvm_arch_memory_slot {
 };
 
+struct kvm_arch_plane {
+};
+
 /**
  * struct kvm_smccc_features: Descriptor of the hypercall services exposed to the guests
  *
@@ -1441,6 +1444,10 @@ static inline bool kvm_system_needs_idmapped_vectors(void)
 	return cpus_have_final_cap(ARM64_SPECTRE_V3A);
 }
 
+static inline void kvm_arch_init_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_free_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
+
 void kvm_init_host_debug_data(void);
 void kvm_debug_init_vhe(void);
 void kvm_vcpu_load_debug(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d55be436bf16..c02e19fe2b48 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -538,7 +538,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
-int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu, struct kvm_plane *plane)
+int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int err;
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c48bca79207b..8dc465dd9ea8 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -147,6 +147,9 @@ struct kvm_vcpu_stat {
 struct kvm_arch_memory_slot {
 };
 
+struct kvm_arch_plane {
+};
+
 #ifdef CONFIG_CPU_LOONGSON64
 struct ipi_state {
 	uint32_t status;
@@ -903,6 +906,9 @@ extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
 extern int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 			     struct kvm_mips_interrupt *irq);
 
+static inline void kvm_arch_init_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_free_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 					 struct kvm_memory_slot *slot) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 47d9900c4f85..5d7036888933 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -256,6 +256,9 @@ struct kvm_arch_memory_slot {
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 };
 
+struct kvm_arch_plane {
+};
+
 struct kvm_hpt_info {
 	/* Host virtual (linear mapping) address of guest HPT */
 	unsigned long virt;
@@ -919,6 +922,9 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
 
+static inline void kvm_arch_init_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_free_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index f618cd83d19a..4d7ee4059758 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -129,7 +129,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
-int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu, struct kvm_plane *plane)
+int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 15c831304b51..423185a09de6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -476,6 +476,9 @@ struct kvm_vm_stat {
 struct kvm_arch_memory_slot {
 };
 
+struct kvm_arch_plane {
+};
+
 struct s390_map_info {
 	struct list_head list;
 	__u64 guest_addr;
@@ -773,6 +776,9 @@ extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
 
 bool kvm_s390_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa);
 
+static inline void kvm_arch_init_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_free_plane(struct kvm_plane *plane) {}
+static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 					 struct kvm_memory_slot *slot) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
-- 
2.55.0


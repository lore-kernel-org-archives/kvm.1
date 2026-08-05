Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AFD449EAB;
	Wed,  5 Aug 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927846; cv=none; b=VR7bOKQ3+cHQW6bKMkljPWSrEdD8OisR+lwtNXSgNGY/MHd6psqFnOu2TUGUVn+0fumAdCtVIF5nRDJIcpNV46v5FTqnmYViD+Idwmu21CS8+s9aSmyE7A62eODihFn3x++NVnwxYsJag9HWHrFPy3aINUGccsXqtCqxOoyLRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927846; c=relaxed/simple;
	bh=QNE1jXe9wLUbPbFsj3SZsanKd2JF8BapyQA3tvBij80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kks9fDCpA7TUyIrGGO5bPB4AZJEVllmFAM0ernBAROlHbEKX54OojYCXglawDHZkfSD3hnZvnJu53Trhj/mQ175GPwEb/UbxtGufjr17zPUy6yQZSCBTA2ZxjKVj/wSqT+t4YmqDcPCwvnyM4eDK2g44Yiw6Njed/g80IpQczn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=izn8bY4p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="izn8bY4p"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A1C920B716D;
	Wed,  5 Aug 2026 04:03:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A1C920B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927823;
	bh=CkiEMfyYTCwYRnWSxWlgCszilANo9OcAYdfL66ziJaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izn8bY4pZkTYwnfxHPAk8bon9vJEPLOMtvb9be+6RTtOhKiv6RmX0YSRjG0tB9MLi
	 k0We94/1064cA9q4akZTC6zPU/DWLCqgCWiiwBzzHaCkmsMdyYT9f8wH8p4+iQ/BEV
	 bSptqC/u1rTadOP2SO4zqnHbvfi5b/hiMkXvnZ+g=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 24/42] KVM: planes: expose memory-attribute setting to in-kernel callers
Date: Wed,  5 Aug 2026 04:03:06 -0700
Message-ID: <20260805110324.25067-25-snambakam@linux.microsoft.com>
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

A higher-privilege plane needs to restrict a lower plane's access to
guest memory by setting NO_WRITE / NO_EXEC EPT attributes (e.g. HEKI
sealing plane-0 text/rodata). The enforcement already lives in
kvm_plane_filter_pte_access(); wire up the set side:

 - advertise KVM_MEMORY_ATTRIBUTE_NO_WRITE / NO_EXEC from
   kvm_supported_mem_attributes() when CONFIG_VM_PLANES is enabled, so
   userspace and in-kernel callers know the attributes are available.

 - make kvm_vm_set_mem_attributes() non-static and declare it in
   kvm_host.h so an in-kernel secure-plane caller can apply attributes
   without going through the ioctl path.

No functional change for non-plane builds.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e989b293a34a..82e557e66152 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2703,6 +2703,8 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs);
+int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+			      unsigned long attributes);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f703545a7e80..9623ab8ebd9e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2603,10 +2603,23 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+	u64 attrs = 0;
+
 	if (!kvm || kvm_arch_has_private_mem(kvm))
-		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+		attrs |= KVM_MEMORY_ATTRIBUTE_PRIVATE;
 
-	return 0;
+#ifdef CONFIG_VM_PLANES
+	/*
+	 * Cross-plane EPT protection: a higher-privilege plane may restrict
+	 * a lower plane's access via NO_WRITE / NO_EXEC (e.g. HEKI sealing
+	 * plane-0 kernel text and rodata).  The enforcement path lives in
+	 * kvm_plane_filter_pte_access(); advertise the attributes here so
+	 * KVM_SET_MEMORY_ATTRIBUTES accepts them.
+	 */
+	attrs |= KVM_MEMORY_ATTRIBUTE_NO_WRITE | KVM_MEMORY_ATTRIBUTE_NO_EXEC;
+#endif
+
+	return attrs;
 }
 
 /*
@@ -2716,8 +2729,8 @@ static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
 }
 
 /* Set @attributes for the gfn range [@start, @end). */
-static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attributes)
+int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+			      unsigned long attributes)
 {
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
-- 
2.55.0


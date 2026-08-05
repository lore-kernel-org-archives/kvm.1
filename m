Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82205433053
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927877; cv=none; b=ac+u0jfT0V8Bt+/ve6swokK5QiwuPB+i2G7ut/tPiRtuTH6EkyXikcBRgWRj6Gk1eaASAJ5D67Edu2TGHbR2SmCsh/mG9fUvS/BHJo1fDS2rKY3skokwFt9CKNBWoi5c5sn2On3G3vK5SGJL/Her2bkdjn0rqD88uIV4ZHZFdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927877; c=relaxed/simple;
	bh=Wkpeq9p8nZsdiLKxoPBUptWG/S8OKxjU9VWklo97CxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSelgXvtyAcawUe2emefbZQg0jnjEXo8X6yIs6vK+kASTwze/BGG/2RNqtuj5QtmF4npL1xNlIzJMPwOTy3c0gKDqEmTQ/pRZmdLGXP4ZZeZ+jzmCViiH8hIGtQNE83uF06vLXvH38x0uY4jJgfJBFStbgqSrn621rh0z4meReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cf09I0XR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cf09I0XR"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8876620B716B;
	Wed,  5 Aug 2026 04:04:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8876620B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927855;
	bh=04q3RI9A0fv9Xv+CMnIW2+ug2+E5td90cLNjC3O338o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf09I0XR8R2W07hl3fGLpXOq8j1M18pEWCZofQxc9vmvmSLxgtUn+ohS7Ly05r0k5
	 +7J6dgvhRxSV9AglW/1olZyReiSLgZXYcNMVByExMl164o5vbtXAF2ZsCBiqmHGEIQ
	 lAj+OnfnXZ9OHS2TG1RcsFqokEsXpA7J62eI3n2o=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 2/5] vm_planes: Add VBS VTL call handling and plane memory sealing
Date: Wed,  5 Aug 2026 04:04:29 -0700
Message-ID: <20260805110432.25167-3-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110432.25167-1-snambakam@linux.microsoft.com>
References: <20260805110432.25167-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the VBS inter-plane communication and memory protection
infrastructure on the QEMU side.

Memory sealing (plane activate path):
  After plane-1 boots and its vCPU threads are running, seal
  plane-1's memory from plane-0 access:
  1. Issue KVM_SET_PLANE_MEMORY_ATTRIBUTES to set NO_WRITE|NO_EXEC
     on plane-0's EPT for the GPA range occupied by plane-1.
  2. Clear ps->host_addr so QEMU userspace can no longer access
     the region.

VBS VTL hypercall handler:
  Handle KVM_HC_VBS_VTL_CALL (hypercall 15) exits from the guest.
  The plane-0 VBS subsystem passes the GPA of a shared calling-area
  (CAA) page; QEMU reads the call_id from the page, logs it, and
  returns -ENOSYS for now (plane-1 responder not yet implemented).
  Enable the hypercall in kvm_enable_hypercall() alongside the
  existing VM planes hypercalls.

Header sync:
  - linux-headers/linux/kvm.h: Add KVM_MEMORY_ATTRIBUTE_NO_WRITE,
    KVM_MEMORY_ATTRIBUTE_NO_EXEC, struct kvm_plane_memory_attributes,
    and KVM_SET_PLANE_MEMORY_ATTRIBUTES ioctl definition.
  - include/standard-headers/linux/kvm_para.h: Add KVM_HC_VBS_VTL_CALL.

(cherry picked from commit 414016c40ec8226b0f5d4cbd5eed0589b7c1689e)
---
 linux-headers/linux/kvm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index d66ce6d272..9dbd3824e9 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1653,6 +1653,19 @@ struct kvm_memory_attributes {
 };
 
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+#define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
+#define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
+
+/* Set memory attributes on a specific plane's address space. */
+struct kvm_plane_memory_attributes {
+	__u32 plane;
+	__u32 flags;
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+};
+
+#define KVM_SET_PLANE_MEMORY_ATTRIBUTES	_IOW(KVMIO, 0xd6, struct kvm_plane_memory_attributes)
 
 #define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
 #define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
-- 
2.55.0


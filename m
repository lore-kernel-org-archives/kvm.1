Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83FA3CD8D7;
	Mon, 30 Mar 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873605; cv=none; b=UByQ/M/2D1hd7z/irJZ6wKoJbXR9+CCUpL1IAtO3eNtLRCBWyQtNXzeuF3cPetYhTZ/2aoRAUAxIzfEk1hMsYTycPy8mbzVXjRZ8sFIzeatG9C0yy9CeY5R8YChtDEM66d0mdgSz6z8eSzEsCjryWJR7wN3HGNfctjuXRnDKZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873605; c=relaxed/simple;
	bh=t+nBbtYRRgP5iBScihFqmbDfpM8X25wYYMjt+qeUvm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iV6ID3GE38bLNeFjCujc0arlznsl61D+OV1qmv3dXViX/6cWvoog4k57gSgpn0SLC80oGALeouqLVpejRisLzoIxJeYrvPtQBVxGSCebscFvuXxqKd/TVD8SKSGe4nLjhF2iKALlzShSVdMyiyfafhhsadKD1+PiNjI0PQaLkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gAgl0YHo; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gAgl0YHo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774873595; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hFPV9OZsT6eJowdta/xFZt6DIyl+vW5qGVBuswXMeAQ=;
	b=gAgl0YHoRXUI4fqRUUraqNR7gl5evH2jb92yTK3Zo72XiGqGp3L7jU5oUdX1wrauvmb75qSXROgnS5d9vsElxXNMTfFFjxBF/AOg2SXRYas1CBYQ0JDwNllD1Kmfu6oOBc/kaHqLNuWdLqLd8Nz2Y4btnAIYFUwvgKiUZ0RCiSE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.zfcJd_1774873592;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X.zfcJd_1774873592 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 20:26:33 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	skhan@linuxfoundation.org
Cc: guoren@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v6 4/4] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE
Date: Mon, 30 Mar 2026 20:26:01 +0800
Message-Id: <20260330122601.22140-5-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com>
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Add a VM capability that allows userspace to select the G-stage page table
format by setting HGATP.MODE on a per-VM basis.

Userspace enables the capability via KVM_ENABLE_CAP, passing the requested
HGATP.MODE in args[0]. The request is rejected with -EINVAL if the mode is
not supported by the host, and with -EBUSY if the VM has already been
committed (e.g. vCPUs have been created or any memslot is populated).

KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE) returns a bitmask of the
HGATP.MODE formats supported by the host.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 Documentation/virt/kvm/api.rst | 27 +++++++++++++++++++++++++++
 arch/riscv/kvm/vm.c            | 18 ++++++++++++++++--
 include/uapi/linux/kvm.h       |  1 +
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 032516783e96..9d7f6958fa81 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8902,6 +8902,33 @@ helpful if user space wants to emulate instructions which are not
 This capability can be enabled dynamically even if VCPUs were already
 created and are running.
 
+7.47 KVM_CAP_RISCV_SET_HGATP_MODE
+---------------------------------
+
+:Architectures: riscv
+:Type: VM
+:Parameters: args[0] contains the requested HGATP mode
+:Returns:
+  - 0 on success.
+  - -EINVAL if args[0] is outside the range of HGATP modes supported by the
+    hardware.
+  - -EBUSY if vCPUs have already been created for the VM, if the VM has any
+    non-empty memslots.
+
+This capability allows userspace to explicitly select the HGATP mode for
+the VM. The selected mode must be supported by both KVM and hardware. This
+capability must be enabled before creating any vCPUs or memslots.
+
+If this capability is not enabled, KVM will select the default HGATP mode
+automatically. The default is the highest HGATP.MODE value supported by
+hardware.
+
+``KVM_CHECK_EXTENSION(KVM_CAP_RISCV_SET_HGATP_MODE)`` returns a bitmask of
+HGATP.MODE values supported by the host. A return value of 0 indicates that
+the capability is not supported. Supported-mode bitmask use HGATP.MODE
+encodings as defined by the RISC-V privileged specification, such as Sv39x4
+corresponds to HGATP.MODE=8, so userspace should test bitmask & BIT(8).
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 4d82a886102c..5e82a3ad3ad0 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -201,6 +201,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_GPA_BITS:
 		r = kvm_riscv_gstage_gpa_bits(kvm->arch.pgd_levels);
 		break;
+	case KVM_CAP_RISCV_SET_HGATP_MODE:
+		r = kvm_riscv_get_hgatp_mode_mask();
+		break;
 	default:
 		r = 0;
 		break;
@@ -211,12 +214,23 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 {
+	if (cap->flags)
+		return -EINVAL;
+
 	switch (cap->cap) {
 	case KVM_CAP_RISCV_MP_STATE_RESET:
-		if (cap->flags)
-			return -EINVAL;
 		kvm->arch.mp_state_reset = true;
 		return 0;
+	case KVM_CAP_RISCV_SET_HGATP_MODE:
+		if (!kvm_riscv_hgatp_mode_is_valid(cap->args[0]))
+			return -EINVAL;
+
+		if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm))
+			return -EBUSY;
+#ifdef CONFIG_64BIT
+		kvm->arch.pgd_levels = 3 + cap->args[0] - HGATP_MODE_SV39X4;
+#endif
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 80364d4dbebb..a74a80fd4046 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -989,6 +989,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
+#define KVM_CAP_RISCV_SET_HGATP_MODE 248
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1


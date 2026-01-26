Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65038DF9;
	Mon, 26 Jan 2026 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769390767; cv=none; b=TwXkZpg3cc0po5IIyLcWTDCo9eMFhuSxe82kuAwYOOGkdd9H3qw9eRSBbYA+WzJa2+V98OAChYEiusJupet+45/4Yt0+diiLbwOgy5fG0hLUt3c/X59q+nO6rTbNNzZJfH2dAVLB7WbN0ACIAVqWPSeLxx2J7Xj+aulsQBipN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769390767; c=relaxed/simple;
	bh=Yb+JP07ijQn7cCb91p7u5ScNQqG1qvqytVfflQQb5SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td8TYE9olcPBM+cEA+J2keS9aYJjmS6sh8EbHCV2CknslQVN+scI17xT8u6FyQOyfqJEPl4sspTbOcBA5NeZDAtCK1huYpvb/UN3X60kFliZrqmPvKPB7rbG/SwA6BevjfEH6dh1+xMmhRQOlJhrnuzWQOIikZa7+Px5d+gTMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mT9+RuJ+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mT9+RuJ+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769390756; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=gCARNgGUNLhCd1rBcVoXKGTchR8utjxKY5PDBVlWowc=;
	b=mT9+RuJ+dE2lBCVbMGH1jgRMsyN8jLeg5/XdxzWjfqp6V3dy8SV6E9im1q9/XX5+pHqMJg3uTaD6m6Z6s46iC7zn28DoCJ1r5mqPj7Rti1gY9vjsX33+yNgX/UxBEp7ni++/jHb2dsbZrRafg6xHj0USifklf19p0we2CIJsY84=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WxmmVCv_1769390752 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Jan 2026 09:25:54 +0800
From: fangyu.yu@linux.alibaba.com
To: fangyu.yu@linux.alibaba.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	corbet@lwn.net,
	guoren@kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pbonzini@redhat.com,
	pjw@kernel.org,
	radim.krcmar@oss.qualcomm.com
Subject: Re: [PATCH v3 2/2] RISC-V: KVM: add KVM_CAP_RISCV_SET_HGATP_MODE 
Date: Mon, 26 Jan 2026 09:25:50 +0800
Message-Id: <20260126012550.38206-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260125150450.27068-3-fangyu.yu@linux.alibaba.com>
References: <20260125150450.27068-3-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

>From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
>This capability allows userspace to explicitly select the HGATP mode
>for the VM. The selected mode must be less than or equal to the max
>HGATP mode supported by the hardware. This capability must be enabled
>before creating any vCPUs, and can only be set once per VM.
>
>Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>---
> Documentation/virt/kvm/api.rst | 18 ++++++++++++++++++
> arch/riscv/kvm/vm.c            | 26 ++++++++++++++++++++++++--
> include/uapi/linux/kvm.h       |  1 +
> 3 files changed, 43 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>index 01a3abef8abb..9d0794b174c7 100644
>--- a/Documentation/virt/kvm/api.rst
>+++ b/Documentation/virt/kvm/api.rst
>@@ -8765,6 +8765,24 @@ helpful if user space wants to emulate instructions which are not
> This capability can be enabled dynamically even if VCPUs were already
> created and are running.
> 
>+7.47 KVM_CAP_RISCV_SET_HGATP_MODE
>+---------------------------------
>+
>+:Architectures: riscv
>+:Type: VM
>+:Parameters: args[0] contains the requested HGATP mode
>+:Returns:
>+  - 0 on success.
>+  - -EINVAL if args[0] is outside the range of HGATP modes supported by the
>+    hardware.
>+  - -EBUSY if vCPUs have already been created for the VM, if the VM has any
>+    non-empty memslots, or if the capability has already been set for the VM.
>+
>+This capability allows userspace to explicitly select the HGATP mode for
>+the VM. The selected mode must be less than or equal to the maximum HGATP
>+mode supported by the hardware. This capability must be enabled before
>+creating any vCPUs, and can only be set once per VM.
>+
Hi Andrew:

In v3，no changes were made here, as KVM_CAP_RISCV_SET_HGATP_MODE might be
appropriate, just like the no5lvl and no4lvl in the kernel.
If you think it's needed, I'm happy to discuss this further.

Thanks,
Fangyu
> 8. Other capabilities.
> ======================
> 
>diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
>index 4b2156df40fc..7bc9b193dcaa 100644
>--- a/arch/riscv/kvm/vm.c
>+++ b/arch/riscv/kvm/vm.c
>@@ -202,6 +202,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> 	case KVM_CAP_VM_GPA_BITS:
> 		r = kvm_riscv_gstage_gpa_bits(&kvm->arch);
> 		break;
>+	case KVM_CAP_RISCV_SET_HGATP_MODE:
>+		r = IS_ENABLED(CONFIG_64BIT) ? 1 : 0;
>+		break;
> 	default:
> 		r = 0;
> 		break;
>@@ -212,12 +215,31 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> 
> int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
> {
>+	if (cap->flags)
>+		return -EINVAL;
>+
> 	switch (cap->cap) {
> 	case KVM_CAP_RISCV_MP_STATE_RESET:
>-		if (cap->flags)
>-			return -EINVAL;
> 		kvm->arch.mp_state_reset = true;
> 		return 0;
>+	case KVM_CAP_RISCV_SET_HGATP_MODE:
>+#ifdef CONFIG_64BIT
>+		if (cap->args[0] < HGATP_MODE_SV39X4 ||
>+		    cap->args[0] > kvm_riscv_gstage_mode(kvm_riscv_gstage_max_pgd_levels))
>+			return -EINVAL;
>+
>+		if (kvm->arch.gstage_mode_user_initialized || kvm->created_vcpus ||
>+		    !kvm_are_all_memslots_empty(kvm))
>+			return -EBUSY;
>+
>+		kvm->arch.gstage_mode_user_initialized = true;
>+		kvm->arch.kvm_riscv_gstage_pgd_levels =
>+				3 + cap->args[0] - HGATP_MODE_SV39X4;
>+		kvm_debug("VM (vmid:%lu) using SV%lluX4 G-stage page table format\n",
>+			  kvm->arch.vmid.vmid,
>+			  39 + (cap->args[0] - HGATP_MODE_SV39X4) * 9);
>+#endif
>+		return 0;
> 	default:
> 		return -EINVAL;
> 	}
>diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>index dddb781b0507..00c02a880518 100644
>--- a/include/uapi/linux/kvm.h
>+++ b/include/uapi/linux/kvm.h
>@@ -974,6 +974,7 @@ struct kvm_enable_cap {
> #define KVM_CAP_GUEST_MEMFD_FLAGS 244
> #define KVM_CAP_ARM_SEA_TO_USER 245
> #define KVM_CAP_S390_USER_OPEREXEC 246
>+#define KVM_CAP_RISCV_SET_HGATP_MODE 247
> 
> struct kvm_irq_routing_irqchip {
> 	__u32 irqchip;
>-- 
>2.50.1

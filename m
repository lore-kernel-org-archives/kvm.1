Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B337082D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786074683; cv=none; b=KkIUSQJ8MtjyQ/dw3mtg/uKkt9nIsUEOt17VxPyhsnKypfDuNzJwrlcLOzqn9hdvxpH1E8XdojSD3ksCCywVZ71gJdcatpV70/mWBIuclscUbXRcZ/LtXZQDSuCLFTbVprgpmrt3fMZvQeCx87MtTWIJlJ+lS9QZF9X4piEE5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786074683; c=relaxed/simple;
	bh=H76/QGVHjgoBCmbEg8m4levfeDQTMHbDutu6CiCCVkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cq71dQyd2sDY4XcqxdWMHX9uYW+Z2eSTv89WUYb5DoJSrhJeAUbY/3s6/hg7HvxaAdLWozSXMGw8kCsHfjNkSaXH1rtXvnfMVKE1gzXpXEcihOwDyoIU95G9cnxz/TRllyvglbRnR62T7EMM2qOKlr19VS+/jo4DK3BuMzyHZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oh+8ldbV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh+8ldbV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84874b52eabso3984385b3a.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786074681; x=1786679481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/3ISunVfIRnbCDBwOOCuYiYx2dMKx7N5JMFDQezhpM=;
        b=oh+8ldbV083d7AEX3zfOhsYngBBZU7j/RJWGwggfOo8CsDjDdp+p2qvj70zZ4scQDw
         EHe4R+XCphRhbfq/3u25ucFW0noHnG1z4QkJBtMOeakrCzOSx0Wf5OoiExbeKke1fEYZ
         9P41BprmVku1xFX0viJUaj8KIaBdFJBCFgn+2SZ9E0CaOX5aix8DNN3yxOM8pqFyPz7p
         69XdZrHOeOXsKBEMm8jOJeSon6bVAkqvpUuQiBkuUGrdV4YPHgGw5affQZ9X/CuFnfi9
         KyIodE4EW0vN9iaY46uIofYb+Mofu3gcs5xoOoqQFOeWBrLnN8qn4kJyvQmOnqJ9vJJG
         w4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786074681; x=1786679481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/3ISunVfIRnbCDBwOOCuYiYx2dMKx7N5JMFDQezhpM=;
        b=kwux3tzhBs9fqCE7amCyR0HilEa5++oLFgOpxSCf2OGR1hUJ6te35JsadzhZrtTR8Y
         BpRTaOdDbJk5S7Xsc2VyH16qVy7c73CfKyitkC2bAT0v37ZzDmm79yPmQbAKXYBYs4Tf
         KThK7n1yCBVnHteJOw9nO0OKHuG7ph0cHkg1Q/zeXCEd94aZGzZ32ulz697TPvZAvVI/
         sesFJZi76AHV95B/BhQ/JiFEohk4l0kf4qQEEW3Ong3FK7bwxV/+kt0i6z5CynCt48Bm
         tRoa43MW7VphmT2/+fhR1yUR7Gg6du8+eLBmLrLTNc6DibLs2buCy7lTxhDH0/BI4Zyj
         GbSw==
X-Forwarded-Encrypted: i=1; AHgh+Rpqc6By3VL5PYSf/BVZatb+01Mn9DZ7UoJ48zrttyaJhxJkcES7ZwIUHezOogatU0IrG6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CeJBE6Jr/yiLyXVu6cWR8XfjXb0tADGGw99xyqkAh67yqGmD
	DC0iZgWB0+BnWHdITRj+TyWRut2281Iy5yT/+M4C7nk5tan55C22aNrq
X-Gm-Gg: AR+sD11OblymHt/ykhDgXo66A84H/vfs+i3C66ZoYF+r5XUQs3v61bA1CdeHVHcEa6h
	llu6SWDUzr3J+qFLxJhkj1JjNOJCsrOfUXMG6FTcet1f2N8xpIsjxsIAEzIZc45u5KfUH6xyGDG
	qiIriDO2e45Tp18XCFMQpAFWvHqIBnQ0tNhV9Zj0DcUaZE3mdkMXec7XlNwlNTviidHgYwj2Q3N
	OKn43tYY7HUOvxkgptU8r8ommrUXAIc7seX78YmVvl7azlkNjBpK+CgkvyOQplhGx98Tqrnrphy
	7G/eYb+fx4A0FW+PtJA7+Qz49YTcFHXola5ko/cvDudggYIY44VGC2yXG/UzB3zOw39b+Jkn3WL
	+lMoa1rEO5MEsNQ8faG8fBJ3rxJMntdNt82Mjnb6Gln7u5f9nPZAPLsrNeFfAjSnx1tBmMevWhU
	8++BY4KI5mg3HHnPjQ0FhPOC/wPK+HSEkbu1Vmj6jAxH0pU/4fNj7AN1fBHxwskecflBIQkacRl
	UMNNiQ=
X-Received: by 2002:a05:6a00:170b:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-84f5df8e917mr782211b3a.13.1786074681506;
        Thu, 06 Aug 2026 20:51:21 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3d0d96sm287586b3a.18.2026.08.06.20.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:51:21 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouquan@iscas.ac.cn,
	"Yuhang.chen" <yhchen312@gmail.com>
Subject: [PATCH 1/2] RISC-V: KVM: Add PMU event filter support
Date: Fri,  7 Aug 2026 11:50:38 +0800
Message-Id: <20260807035039.294998-2-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807035039.294998-1-yhchen312@gmail.com>
References: <20260807035039.294998-1-yhchen312@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to restrict which SBI PMU events a guest is permitted
to program via the new VM ioctl KVM_SET_PMU_EVENT_FILTER.  It takes a
struct kvm_pmu_event_filter whose events[] array holds SBI PMU event
indices encoded as (type << 16) | code.  The action field selects ALLOW
(only listed events may be programmed) or DENY (listed events are
rejected); nevents == 0 clears any active filter.

The filter is enforced in kvm_riscv_vcpu_pmu_ctr_cfg_match(), where a
disallowed event fails configuration with SBI_ERR_NOT_SUPPORTED.  It
governs new counter configuration only and is not retroactive.  The
filter lives in struct kvm_arch, read via SRCU on the vCPU run path and
replaced under kvm->lock with synchronize_srcu_expedited().

Advertise the feature with KVM_CAP_PMU_EVENT_FILTER.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 arch/riscv/include/asm/kvm_host.h |  3 ++
 arch/riscv/include/uapi/asm/kvm.h | 20 ++++++++++
 arch/riscv/kvm/vcpu_pmu.c         | 28 +++++++++++++
 arch/riscv/kvm/vm.c               | 66 ++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d2..1cd3d6a11057 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -95,6 +95,9 @@ struct kvm_arch {
 
 	/* KVM_CAP_RISCV_MP_STATE_RESET */
 	bool mp_state_reset;
+
+	/* KVM_SET_PMU_EVENT_FILTER */
+	struct kvm_pmu_event_filter __rcu *pmu_event_filter;
 };
 
 struct kvm_cpu_trap {
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 504e73305343..da4f639fa89f 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <asm/bitsperlong.h>
 #include <asm/ptrace.h>
 
@@ -396,6 +397,25 @@ struct kvm_riscv_sbi_fwft {
 /* One single KVM irqchip, ie. the AIA */
 #define KVM_NR_IRQCHIPS			1
 
+/* for KVM_CAP_PMU_EVENT_FILTER */
+#define KVM_PMU_EVENT_ALLOW	0
+#define KVM_PMU_EVENT_DENY	1
+
+/*
+ * For KVM_SET_PMU_EVENT_FILTER: restrict which SBI PMU events a guest may
+ * configure.  Each @events entry is a SBI PMU event index (type in bits
+ * 19:16, code in bits 15:0).  %KVM_PMU_EVENT_ALLOW permits only listed
+ * events; %KVM_PMU_EVENT_DENY rejects them.  Enforced at counter
+ * configuration (SBI PMU COUNTER_CFG_MATCH), not retroactively.
+ */
+struct kvm_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 flags;
+	__u32 pad;
+	__DECLARE_FLEX_ARRAY(__u64, events);
+};
+
 #endif
 
 #endif /* __LINUX_KVM_RISCV_H */
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb24d..bc7d297a63ce 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -733,6 +733,29 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 	return 0;
 }
 
+static bool kvm_riscv_pmu_event_allowed(struct kvm *kvm, unsigned long eidx)
+{
+	struct kvm_pmu_event_filter *filter;
+	bool in_list = false;
+	unsigned int i;
+
+	filter = srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
+	if (!filter)
+		return true;
+
+	for (i = 0; i < filter->nevents; i++) {
+		if ((unsigned long)filter->events[i] == eidx) {
+			in_list = true;
+			break;
+		}
+	}
+
+	/* ALLOW: permit only listed events; DENY: reject them. */
+	if (filter->action == KVM_PMU_EVENT_ALLOW)
+		return in_list;
+	return !in_list;
+}
+
 int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				     unsigned long ctr_mask, unsigned long flags,
 				     unsigned long eidx, u64 evtdata,
@@ -773,6 +796,11 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 		goto out;
 	}
 
+	if (!kvm_riscv_pmu_event_allowed(vcpu->kvm, eidx)) {
+		sbiret = SBI_ERR_NOT_SUPPORTED;
+		goto out;
+	}
+
 	/*
 	 * SKIP_MATCH flag indicates the caller is aware of the assigned counter
 	 * for this event. Just do a sanity check if it already marked used.
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb76..6f822c43f156 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -53,6 +53,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_destroy_vcpus(kvm);
 
+	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
+
 	kvm_riscv_aia_destroy_vm(kvm);
 }
 
@@ -187,6 +189,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_SET_GUEST_DEBUG:
+	case KVM_CAP_PMU_EVENT_FILTER:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -265,7 +268,68 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 	}
 }
 
+#define KVM_PMU_EVENT_FILTER_MAX_EVENTS	256
+
+static int kvm_riscv_vm_ioctl_set_pmu_event_filter(struct kvm *kvm,
+						   void __user *argp)
+{
+	struct kvm_pmu_event_filter __user *user_filter = argp;
+	struct kvm_pmu_event_filter *filter, tmp;
+	size_t size;
+	int r = 0;
+
+	if (copy_from_user(&tmp, user_filter, sizeof(tmp)))
+		return -EFAULT;
+
+	if (tmp.action != KVM_PMU_EVENT_ALLOW &&
+	    tmp.action != KVM_PMU_EVENT_DENY)
+		return -EINVAL;
+
+	if (tmp.flags)
+		return -EINVAL;
+
+	if (tmp.nevents > KVM_PMU_EVENT_FILTER_MAX_EVENTS)
+		return -E2BIG;
+
+	size = struct_size(filter, events, tmp.nevents);
+	filter = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!filter)
+		return -ENOMEM;
+
+	filter->action = tmp.action;
+	filter->nevents = tmp.nevents;
+	filter->flags = tmp.flags;
+
+	if (copy_from_user(filter->events, user_filter->events,
+			   flex_array_size(filter, events, filter->nevents))) {
+		r = -EFAULT;
+		goto cleanup;
+	}
+
+	mutex_lock(&kvm->lock);
+	filter = rcu_replace_pointer(kvm->arch.pmu_event_filter, filter,
+				     mutex_is_locked(&kvm->lock));
+	mutex_unlock(&kvm->lock);
+	synchronize_srcu_expedited(&kvm->srcu);
+
+cleanup:
+	kfree(filter);
+	return r;
+}
+
 int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
-	return -EINVAL;
+	struct kvm *kvm = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	int r;
+
+	switch (ioctl) {
+	case KVM_SET_PMU_EVENT_FILTER:
+		r = kvm_riscv_vm_ioctl_set_pmu_event_filter(kvm, argp);
+		break;
+	default:
+		r = -EINVAL;
+	}
+
+	return r;
 }
-- 
2.34.1


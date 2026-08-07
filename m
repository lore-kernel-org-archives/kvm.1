Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3542CB12
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080776; cv=none; b=B2VffrtIAWHOJ8cesNVGnOx/WBOr656Vg6yATeSJogS4ZEXTR3Enh2rIJIyKJ/VZ/VbMwFOHx28OrX0gGbnpAQxTxwswCwNdisOCz+7qHyt3vKWY/DmWjitng53tQat8Q4MCO/MytIz0lZj+w0pKVm7ydcXA+dGBtbFRfkCQ6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080776; c=relaxed/simple;
	bh=WTgtCBbzxa7tjxkXGh9oWCGFMnuvuWmw8cQGqIT0GMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+dmTva+bgk0wkGfUg+5NMJgmg/XgOKd1UI3+oUCPUXQTPh6FmmSFoGPvHprnIDD7hHBLFVWdo5CO/S3N8Az6SJ6/kcmfzX1kj+hspqEcrtz5X2G7k+9699VQnvN+oxUxLkcc3WS7UGT/70oNEFz06Y6qIazRKTcP1XxBUdp1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkyiP8qg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkyiP8qg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a2dcede83so4234396b3a.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786080771; x=1786685571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4URKGYUdKxYgKTjeOoH/uROuHrVlAZjzUU1uImLcd0=;
        b=BkyiP8qgzX2hZ1bdcP8/rBBKbsm/d1g06XJ9YtwYa8OQI2eQYhdKf9/OvpGFjwAnrs
         DSMsrQx0eV5SX5OarlaMZrPmk6lojknU4Ffz5w9lIa1cC3XxDOZBIbs0nwPNZkblHjUX
         +3SeCATsHpJgePDnDvCb3Mg25Z/Re6nCw26usCccoXzmwsQSD8zrmkOQzWPJXk1ld7jm
         ROhUkzMI06Wo3q02LEd/DFLN0e1AZvKxfjJSHeWEIACET3hJGkb/8HFdwnBpFXPQirGz
         aLir5jO5id7EdbuJMyK8b4F8AlVuyEEklHV+yVLHEMdMYojJnFeSiE+FB1Gx7v1AbWMk
         VN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080771; x=1786685571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4URKGYUdKxYgKTjeOoH/uROuHrVlAZjzUU1uImLcd0=;
        b=qkfvuIwol/5rnbYCp6rrlvoe4dm7lLWWqbOWPw+PES00U4mwNtN4HA+lXcTVurDjDi
         Sglgx2mjdlJjkxv+TdeyqpQKF8AaK0Tsk82Xll/RVEZlz8N4UiTcCay3G7ixQcdbNinS
         4vREzQ6GnVXPc8D17NTMbDk8UleusIayf3ljmwHfn5Zn1+ZNYzYVnxDzZOY5FN3Cf3Sp
         s1Ufj2FlDfRKsm4PLgK9RO4/PzwIaACrFQkvtLzDt29H1naErBddXShsW3YPmma/lywJ
         g4k8Q6A2e5My/6LHqzF4l66aa+1sisHtT7Gq2MXbW6SoQrarXNadN8DGW0ba6QrNUS60
         4TlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMsexnhgWiEwCx/8L4dA+qX8I0cZ/HI2Mu8XuQUxcD/OXYT2+vecwZqcuf5ihEj/yTiRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yQ0cC8KeXbhOPUGwk/YWyULLBYTLCpld5pNCixSdPfa4LwU3
	1ax1OoJZ/CpQjFepM3xUzMytXYRwW2s03ynWEKm0t8OmodL7zQmIQjLb
X-Gm-Gg: AR+sD12fUAwrOq0u1mvCxXK8uYy3rp7fd1mz5duFf5cMZtzkiOjUcXJYR+E8t1y9+cF
	L0f3siyolHcle3mqvIJ14p1ktuP2Pn1ttRPk0zZeIkSXo3xM4Hjyaaz08Mmo9VW+n2BEvL3M3MY
	cqWcJAj3rK4XbfiRv1glJ7Eyef6GLLMZKhibKZy5UM5OfF6RZ7SojaXOF2Q8Krf4JHFnp0uAqFB
	Ia5GX3kUcBMDKTLF5ngsuZSJRW9Hv8xKwg17iiBTFWHGs6TzKlDmbyiLMCefpTTEUQ11wJnNGCG
	G32ZbBQoWJgJSfJBP5E8JnX0WZ4jvyOkj2CQB07nE863nubsiGsmuyKb51dwThC0+mFTNKhW8Ic
	PJCFX9RSuGxHo44Ta6/oxWaBd/9PYrBWwmtMZG9m60ot3CFnvmwCTVdPOzA7zq9+VvP/LYJ9y9I
	jariQ1qw2eL2YYm66xopMzBwWIY+wdwHQHiBKkw6lbGGeEeRaXGfNqWOOs0e15IXT1XGRz0bqeh
	kOMugY=
X-Received: by 2002:a05:6a00:3021:b0:848:8715:c2d9 with SMTP id d2e1a72fcca58-84f5df36a04mr1309064b3a.2.1786080771542;
        Thu, 06 Aug 2026 22:32:51 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f19634dsm108940a12.7.2026.08.06.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 22:32:51 -0700 (PDT)
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
Subject: [PATCH v2 1/2] RISC-V: KVM: Add PMU event filter support
Date: Fri,  7 Aug 2026 13:32:26 +0800
Message-Id: <20260807053227.341700-2-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807053227.341700-1-yhchen312@gmail.com>
References: <20260807053227.341700-1-yhchen312@gmail.com>
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
replaced under kvm->lock with synchronize_srcu_expedited().  Event
indices are masked to their valid bits before comparison, so reserved
high bits cannot bypass a DENY filter.

Advertise the feature with KVM_CAP_PMU_EVENT_FILTER.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 arch/riscv/include/asm/kvm_host.h |  3 ++
 arch/riscv/include/uapi/asm/kvm.h | 20 +++++++++
 arch/riscv/kvm/vcpu_pmu.c         | 31 ++++++++++++++
 arch/riscv/kvm/vm.c               | 69 ++++++++++++++++++++++++++++++-
 4 files changed, 122 insertions(+), 1 deletion(-)

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
index bb46dcbfb24d..756040913468 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -733,6 +733,32 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 	return 0;
 }
 
+static bool kvm_riscv_pmu_event_allowed(struct kvm *kvm, unsigned long eidx)
+{
+	struct kvm_pmu_event_filter *filter;
+	bool in_list = false;
+	unsigned int i;
+
+	/* Reserved high bits must not bypass the filter. */
+	eidx &= SBI_PMU_EVENT_IDX_MASK;
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
@@ -773,6 +799,11 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
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
index a9f083feeb76..a5a3a2182d1e 100644
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
@@ -265,7 +268,71 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
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
+	if (tmp.pad)
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


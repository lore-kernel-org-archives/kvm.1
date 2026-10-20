Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486497;
	b=cjiiVoJLu3GEHHkbSLYkIcQVhwc8i3KXUgws52DHHSm857ulWzzaLp7RAuEOoywAZAFd
	 Yis+KwO7G4oq9xZ61xd4nbBtaLKTjZWOwVZuSWvTuNIqUILBPbElnYqnUDMS1quWjrKDe
	 a/GkPIgtnHgfBR29BL9ppKbGFIuyLA7Aa8K0H568TltHh+BjB0Tkgq/PcBPjcynk8KFdL
	 9Ak99SD476XdYByJPg++QQD4bPtXRh+5Ij200cuvsB/lpL8yVDKe1CUF0D6oiQwIr8cG5
	 WusIqr2JqE/fUUNQCXMW4YsX2DzaDKLFXl3KkC6s2BA1WUgLgMdNgizbt4SktTB/SIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ah055MuUD0C6B1dAYun3nbxELChx3aUY//F37qF2gZg=;
	b=Zp9WYaRP1KpPCH/Mazxi95QlNX9uLarSGZnPlsIJZBNmztN3anxupw7NwzEQQ1qphH+c
	 y5J9w43vhm8xqzeRGwP/uiv38hfVGFApSWzJh9VEJwsYsvTDQcvxrrxmO9yS0FQipQnzh
	 dTI+KK2dDVTSFXXQsHmdsRlMS1nzz2e78t8KL7hQz6+MMDWbQ5eNmJBp/NJ48fvhLhPDW
	 Xcl/Ix3owCXz768MLTiYqjXfhJoVGlo53PNlcSkcwWCJi6DNfPL9I2GQxBPNxF7ETPVex
	 NOuFd+Ylq/esWjE0ofJhBrgtaQr0/r3FH+7lUVUhkAEAhfO0GNDMYMeDOXbJVPYE99g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TEO7fG0G;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D41606A31B
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 08:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D41606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TEO7fG0G
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1631a57d2so617422a12.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792486496; x=1793091296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ah055MuUD0C6B1dAYun3nbxELChx3aUY//F37qF2gZg=;
        b=TEO7fG0G50Io5kgU/X0rvSixXyEC+pcbToqG5fnNyHELaBJOtK4A0yxYmWfBsrsJ2w
         Dd39t5PNPAY37JgNOhLjqzqphQsE1JRT7LAHJ6PBt3yQ6TSTJ2a6ikTGaj4VzqV09Zd/
         kvL0Ni7Kq5pdlHfiUY1/OFnhdlE7HrBRqTnS7wV/v/+NXiu9xgwphxpOczLZMxhvs92v
         F41ipYiltv9JbjSQb+JAtpnHfhzxp0y53l4J4CUgz4mXaK2jU1Rlj0zqcb7X8oQTV7u5
         4iWHwlH4F4iHg2UI6UdhXSOiWqYGl6rq8C01GHHJ8nSBf5Dl0NEBNAz39DiJVWrMa5Wo
         4fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792486496; x=1793091296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ah055MuUD0C6B1dAYun3nbxELChx3aUY//F37qF2gZg=;
        b=roHxWHKapHINhJ2u6kentd538LpDCUnEvtxcgOBfOWIobCJiWAWYTeWNaSLTmGbBy4
         4WjPtR5L9VIvqExlFxfLiXSVjgCXUqsiIeTMvk0z4CE/nIcugm/0pLoGOrauCz+Cozsp
         U1RY1b2ve1T4mWUm7mqsI5zPpRLDN6M4fXdIfCeDgRBncWaF9pQqVpJ8OpkPP4jBcJc2
         VfxUgGOFoE/eC83epRIOtHTWR1XtGLr4qqmUvs4ahQUSln/u5X5sMH5sf875O0NZ1RnV
         msurPeOacPIZfBE99UXyYVPWi10r5z02c6q1TVj5WCNeWFnPOkzySBBIT9vxjCTpyoe/
         FoFw==
X-Forwarded-Encrypted: i=1; AKwUvBysbENGeYHJ2hRN+grq8l5Idf4+Xg0Po/gOPMVcEhf+TFssw0q81MG0YrXgyF4qRL402NM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrU4UhR/SSu0wZtCHeMt2Lx+Vrrn/oAxGWMfKTHpeUgY6o6G77
	OyOL2uJhfyxV0dLtsVVnD64SaOF8ocreDi8gY/0mddiAlSDpW5Yls4r7
X-Gm-Gg: AYBFou1Utq+D/7SlYfqp1lnIZeuh9O+v2xeqaraSFE6/1ivCbVynz69sGs+eGFPYPg8
	twyE3lwhp1OjHEnQmWJU0XZOuRJfkpI07sZNkjvKMd03336NurWjSopNfonSLTR11818sO848+z
	2xGNma2E+tUNKbCejWpcZHYwbkPm9CQ81ec8ii0Zq5hJc6LQQFnM89QMe0XdU2l+S/wPWSTitLP
	Yu3tGnpHxxCGnbF7CSfuQmLBD0S5Ql0EOBybTKSSg4JiDKKKQDftzfVdIOFs3xXfH4eo1gR18dD
	x5NsLlvJXbvRFj50vCoFsM6IqA123eNPsMcYrbzzZV+7D46w59CZt3yW0Oq1JaXM2O4hU/QZ+lk
	tpRLw/Dhmibc+bhKSqOwy5iN2Vp3oG9jf8OgDhLXm7D6oIUYU8Im5NDXBvwm2gri0relv3GgRZL
	qXGePIvV6e+P8++/9SFocZrU4yH8vEo/aqcPVdU35TF2LRkJPANt744WEGQhEG+MbTWuBhkFHo9
	fCHGDVRL2XCVY2OAiguVFyaNLc65mfWi/pXouqJhnEKA/xBug==
X-Received: by 2002:a05:6a00:929e:b0:880:a842:bb0a with SMTP id d2e1a72fcca58-8a04bf63014mr7973628b3a.9.1792486496166;
        Tue, 20 Oct 2026 01:54:56 -0700 (PDT)
Received: from HXDQXTDYHN.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f580173efsm4540237b3a.50.2026.10.20.01.54.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 01:54:55 -0700 (PDT)
From: Jinmeng Zhou <jinmengzhou22@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Wu <feng.wu@intel.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmeng Zhou <zhoujinmeng@bytedance.com>,
	stable@vger.kernel.org,
	Guixiong Wei <weiguixiong@bytedance.com>
Subject: [PATCH v2 2/2] KVM: x86: Wake blocked vCPUs before offlining a CPU
Date: Tue, 20 Oct 2026 16:54:01 +0800
Message-Id: <20261020085401.80296-3-jinmengzhou22@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261020085401.80296-1-jinmengzhou22@gmail.com>
References: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
 <20261020085401.80296-1-jinmengzhou22@gmail.com>
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

From: Jinmeng Zhou <zhoujinmeng@bytedance.com>

Posted-interrupt wakeup state is tied to the physical CPU on which a vCPU
blocks.  When a CPU is offlined, sched_cpu_deactivate() removes it from the
active mask, but a blocked vCPU stays on that CPU's wakeup list and its
posted-interrupt descriptor still targets that CPU's APIC.

If a device posts an interrupt after the old CPU goes offline, the wakeup
notification cannot make the blocked vCPU runnable.  The vCPU cannot fix
the stale notification destination, because that happens only after the
vCPU is scheduled back in.

Add an optional x86 vendor cpu_offline() callback and call it from the
CPUHP_AP_X86_KVM_ONLINE teardown.  That teardown runs after CPUHP_AP_ACTIVE
has deactivated the CPU.  Have VMX wake every vCPU on the dying CPU's
posted-interrupt wakeup list, so that the scheduler places the vCPU on an
active CPU and vmx_vcpu_pi_load() rebuilds its wakeup list and
posted-interrupt destination state.

A single pass over the list is sufficient.  Once the CPU is inactive, the
scheduler won't select it for a wakeup, and balance_push() moves any task
that is switched in on it to an active CPU before the task can run.  Thus
no vCPU can block on the CPU and add itself to the list after the walk.

Use __kvm_vcpu_wake_up() rather than KVM_REQ_UNBLOCK.  A vCPU with no
pending event goes back to the block loop after its posted-interrupt state
has been migrated, and no spurious wakeup is reported to the guest.

Initialize the per-CPU posted-interrupt wakeup lists in vmx_init() before
calling kvm_x86_vendor_init().  Once the CPU hotplug state is registered,
a concurrent CPU offline can invoke the VMX callback, which must not walk
an uninitialized list.

Fixes: bf9f6ac8d749 ("KVM: Update Posted-Interrupts Descriptor when vCPU is blocked")
Cc: stable@vger.kernel.org
Co-developed-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/vmx/main.c            |  1 +
 arch/x86/kvm/vmx/posted_intr.c     | 18 ++++++++++++++++++
 arch/x86/kvm/vmx/posted_intr.h     |  1 +
 arch/x86/kvm/vmx/vmx.c             | 16 ++++++++++------
 arch/x86/kvm/x86.c                 |  3 ++-
 7 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e213c9ae3e301..f2a805783f045 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -17,6 +17,7 @@
 KVM_X86_OP(check_processor_compatibility)
 KVM_X86_OP(enable_virtualization_cpu)
 KVM_X86_OP(disable_virtualization_cpu)
+KVM_X86_OP_OPTIONAL(cpu_offline)
 KVM_X86_OP(hardware_unsetup)
 KVM_X86_OP(has_emulated_msr)
 KVM_X86_OP(vcpu_after_set_cpuid)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a94..d47863ce2c5ae 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1509,6 +1509,7 @@ struct kvm_x86_ops {
 
 	int (*enable_virtualization_cpu)(void);
 	void (*disable_virtualization_cpu)(void);
+	void (*cpu_offline)(unsigned int cpu);
 	cpu_emergency_virt_cb *emergency_disable_virtualization_cpu;
 
 	void (*hardware_unsetup)(void);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4c52ab8d07869..5a3f77f42d20d 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -894,6 +894,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.enable_virtualization_cpu = vmx_enable_virtualization_cpu,
 	.disable_virtualization_cpu = vt_op(disable_virtualization_cpu),
+	.cpu_offline = pi_cpu_offline,
 	.emergency_disable_virtualization_cpu = vmx_emergency_disable_virtualization_cpu,
 
 	.has_emulated_msr = vt_op(has_emulated_msr),
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4a6d9a17da238..1905472b336d3 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -266,6 +266,24 @@ void pi_wakeup_handler(void)
 	raw_spin_unlock(spinlock);
 }
 
+void pi_cpu_offline(unsigned int cpu)
+{
+	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
+	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
+	struct vcpu_vt *vt;
+	unsigned long flags;
+
+	/*
+	 * CPUHP_AP_ACTIVE has already deactivated the CPU.  Wake blocked vCPUs
+	 * so that they are scheduled on another CPU and rebuild their posted
+	 * interrupt wakeup state in vmx_vcpu_pi_load().
+	 */
+	raw_spin_lock_irqsave(spinlock, flags);
+	list_for_each_entry(vt, wakeup_list, pi_wakeup_list)
+		__kvm_vcpu_wake_up(vt_to_vcpu(vt));
+	raw_spin_unlock_irqrestore(spinlock, flags);
+}
+
 void __init pi_init_cpu(int cpu)
 {
 	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index a4af39948cf04..530f1347f8b0d 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -11,6 +11,7 @@
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
+void pi_cpu_offline(unsigned int cpu);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100f..ff1a6ccbd043b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8889,6 +8889,16 @@ int __init vmx_init(void)
 	if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
 		return -EIO;
 
+	/*
+	 * Initialize the per-CPU lists before common x86 init, which registers
+	 * the CPU hotplug callbacks that walk the posted-interrupt wakeup lists.
+	 */
+	for_each_possible_cpu(cpu) {
+		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+
+		pi_init_cpu(cpu);
+	}
+
 	r = kvm_x86_vendor_init(&vt_init_ops);
 	if (r)
 		return r;
@@ -8898,12 +8908,6 @@ int __init vmx_init(void)
 	if (r)
 		goto err_l1d_flush;
 
-	for_each_possible_cpu(cpu) {
-		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-
-		pi_init_cpu(cpu);
-	}
-
 	vmx_check_vmcs12_offsets();
 
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a08ae25f373fb..38bffe6ec9b4b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6823,8 +6823,9 @@ static int kvm_x86_cpu_online(unsigned int cpu)
 static int kvm_x86_cpu_offline(unsigned int cpu)
 {
 	if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
-		return kvmclock_cpu_down_prep(cpu);
+		kvmclock_cpu_down_prep(cpu);
 
+	kvm_x86_call(cpu_offline)(cpu);
 	return 0;
 }
 
-- 
2.39.5


Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63133507D
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860191; cv=none; b=OxBb/bw9836LtscRRdd1Evl/pT6p6FZCi7Jh+ZcjtIOv8tZU82C+kYlDmP2koKl8ly0WTZx97aCPsj/sNQtOj8x95ogxg8RFlbHKzuY8pprq+V5LRvbiJxgEaKkfczdsFngM6F/VG20gY432d7KnGP36r567lkXL/gN0ZHM6T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860191; c=relaxed/simple;
	bh=19HamWErGuzY/dmMUReqsnmc/G3lTBtYGUzYEWD4h+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArehP1MqfB2mgX/HrjX98gbrZjd/doS8ymYBfRyNPVDM0bg0NqtCKbrE1dTFrsvdydHh1CasEeIZ9JtvVID+zv/2+xsIAHMaqzW4BL4XhAmdmml6+xed/g49zDEBEkSzbpaikU1LA8o4CV4oyInXsHrkI+aTnLM+OkPHXBsdMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsvPCz7S; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsvPCz7S"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c889d1eebafso6031606a12.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860184; x=1783464984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E+NrWKLgbSA4gk7TP40/gWjlirTH76NrzKe9i61E2sg=;
        b=fsvPCz7Swu+B94Rqx76BJATFiKWAcPIrX+AzFZbKfJBRy31YIFSHXFGmGTj1iz0g9Y
         nkHdodnbeibO/OgGIl41Dr4AnmnQKzGgO+qVNugamWVP1BuHm2zpWf/oc3kmUKtW+QMN
         GvkyK+p4Q1N9iEYu+dkLyw5Mg7iOrEjl6I9d7AnEl3X7R47sMePRrZy2aqvLYyPc/LwL
         feeliNi9ypnps3tBTLpuKBdid+GRXb1587wh8Hck44F1fwZMYq25pWAWAAzs9H5KGfGr
         QNXwSQtmmMAa93nvVgAYTGMG5kpUAq6V53+UftoO6ZSRhSSrrevUrtmiH6NyNa3KsO7k
         2MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860184; x=1783464984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+NrWKLgbSA4gk7TP40/gWjlirTH76NrzKe9i61E2sg=;
        b=bUBh1ZCSArLWajtrq+0CRoCLl07DjfWv2jmUVJ1gRfTgDwZZbXXVyDXkSh3QHwupEv
         j1meVKt4VUf/4OSSbXg0AhLkZthCsrAtgNyjbvq3Luw0P0gcjY0/fLO+vvP0b9Rc81iP
         iFP7Na3AxD5bJANU8oFJCbN/V/7QxVOsY7e/L4n1UOlsQ1OQeO3Q0Q0r2UeZ0YD1kA/M
         0Dglvw4fPFn/w79HDR5L9Uss5YDiwbXUWFYVOz1Ozt1ZABDzysksEa1ihthBK8qlIznR
         3iTlbSeq6fPYm0mU1rQqZVolQLGrQxLO6nwbXCc5/RV3iAxB5cmTdQrlGe37C9/y3xd/
         /8pw==
X-Gm-Message-State: AOJu0YzsRPMH44quEJDGKMC65KKhVwseAVeWE1CSv42GQfINQqDIQcD0
	4JVzmWUNLGVOxrr+wXOQIs0/DtNPqT2laZ/kJxOI+KllLKR0EoNkdUDMfdZexvXOo+ocU7dCqWo
	nz4j1vQ==
X-Received: from pfnd10.prod.google.com ([2002:aa7:814a:0:b0:846:7503:7352])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:893:b0:845:d284:9e14
 with SMTP id d2e1a72fcca58-8479f2d0032mr4730265b3a.59.1782860184024; Tue, 30
 Jun 2026 15:56:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:10 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-4-seanjc@google.com>
Subject: [PATCH v4 03/11] KVM: x86/hyperv: Ensure vCPU's Hyper-V object is
 initialized on cross-vCPU accesses
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

When initializing a vCPU's Hyper-V object, ensure the object is fully
initialized prior to exposing it through the vCPU, and ensure accesses from
other tasks (e.g. other vCPUs) see the fully initialized object if
vcpu->arch.hyperv is non-NULL.

Lack of ordering manifests as a lockdep splat due to attempting to lock a
TLB flush FIFO before the spinlock is initialized.

  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  turning off the locking correctness validator.
  CPU: 1 PID: 5005 Comm: syz-executor189 Not tainted 6.6.120-smp-DEV #1
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
  Call Trace:
   <TASK>
    [<ffffffff810dd10c>] dump_stack_lvl+0xcc/0x130 lib/dump_stack.c:106
    [<ffffffff8192bddd>] assign_lock_key+0x1fd/0x230 kernel/locking/lockdep.c:977
    [<ffffffff8191cb97>] register_lock_class+0x187/0x7a0 kernel/locking/lockdep.c:1291
    [<ffffffff8191e7a9>] __lock_acquire+0x179/0x7650 kernel/locking/lockdep.c:5016
    [<ffffffff8191e28f>] lock_acquire+0x13f/0x3d0 kernel/locking/lockdep.c:5756
    [<ffffffff8101a65b>] __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
    [<ffffffff8101a65b>] _raw_spin_lock+0x2b/0x40 kernel/locking/spinlock.c:154
    [<ffffffff81319d44>] spin_lock include/linux/spinlock.h:351 [inline]
    [<ffffffff81319d44>] hv_tlb_flush_enqueue+0xb4/0x270 arch/x86/kvm/hyperv.c:1946
    [<ffffffff813160c6>] kvm_hv_flush_tlb+0xa96/0x1dc0 arch/x86/kvm/hyperv.c:2145
    [<ffffffff8131438b>] kvm_hv_hypercall+0x103b/0x1fe0 arch/x86/kvm/hyperv.c:-1
    [<ffffffff8133bff3>] __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6624 [inline]
    [<ffffffff8133bff3>] vmx_handle_exit+0x12e3/0x21f0 arch/x86/kvm/vmx/vmx.c:6641
    [<ffffffff81215d11>] vcpu_enter_guest arch/x86/kvm/x86.c:11649 [inline]
    [<ffffffff81215d11>] vcpu_run+0x4d01/0x79c0 arch/x86/kvm/x86.c:11832
    [<ffffffff8120fe39>] kvm_arch_vcpu_ioctl_run+0xb49/0x1c80 arch/x86/kvm/x86.c:12179
    [<ffffffff8119cd60>] kvm_vcpu_ioctl+0xc80/0xff0 virt/kvm/kvm_main.c:6029
    [<ffffffff8226fefd>] vfs_ioctl fs/ioctl.c:52 [inline]
    [<ffffffff8226fefd>] __do_sys_ioctl fs/ioctl.c:872 [inline]
    [<ffffffff8226fefd>] __se_sys_ioctl+0xfd/0x170 fs/ioctl.c:858
    [<ffffffff85ac97d9>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff85ac97d9>] do_syscall_64+0x69/0xb0 arch/x86/entry/common.c:93
   [<ffffffff85c000d0>] entry_SYSCALL_64_after_hwframe+0x68/0xd2
   </TASK>

Use the "safe" variant in all paths that are known to access the Hyper-V
object, as detected by an upcoming lockdep assertion, with an assist or two
from Sashiko.

Link: https://lore.kernel.org/all/20260612232258.0D9131F000E9@smtp.kernel.org
Fixes: 0823570f0198 ("KVM: x86: hyper-v: Introduce TLB flush fifo")
Fixes: fc08b628d7c9 ("KVM: x86: hyper-v: Allocate Hyper-V context lazily")
Reported-by: syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Reported-by: syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a396a66.52ae72c2.136ac7.0002.GAE@google.com
Tested-by: syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 23 ++++++++++++++++++-----
 arch/x86/kvm/hyperv.h | 18 +++++++++++++++---
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 49b1154366ce..888526ce4dab 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -206,13 +206,19 @@ static struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm, u32 vpidx)
 
 static struct kvm_vcpu_hv_synic *synic_get(struct kvm *kvm, u32 vpidx)
 {
-	struct kvm_vcpu *vcpu;
 	struct kvm_vcpu_hv_synic *synic;
+	struct kvm_vcpu_hv *hv_vcpu;
+	struct kvm_vcpu *vcpu;
 
 	vcpu = get_vcpu_by_vpidx(kvm, vpidx);
-	if (!vcpu || !to_hv_vcpu(vcpu))
+	if (!vcpu)
 		return NULL;
-	synic = to_hv_synic(vcpu);
+
+	hv_vcpu = to_hv_vcpu_safe(vcpu);
+	if (!hv_vcpu)
+		return NULL;
+
+	synic = &hv_vcpu->synic;
 	return (synic->active) ? synic : NULL;
 }
 
@@ -972,7 +978,6 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 	if (!hv_vcpu)
 		return -ENOMEM;
 
-	vcpu->arch.hyperv = hv_vcpu;
 	hv_vcpu->vcpu = vcpu;
 
 	synic_init(&hv_vcpu->synic);
@@ -988,6 +993,14 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 		spin_lock_init(&hv_vcpu->tlb_flush_fifo[i].write_lock);
 	}
 
+	/*
+	 * Ensure the structure is fully initialized before it's visible to
+	 * other tasks, as much of the state can be legally accessed without
+	 * holding vcpu->mutex.
+	 *
+	 * Pairs with the smp_load_acquire() in to_hv_vcpu_safe().
+	 */
+	smp_store_release(&vcpu->arch.hyperv, hv_vcpu);
 	return 0;
 }
 
@@ -2165,7 +2178,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 
 		kvm_for_each_vcpu(i, v, kvm) {
-			hv_v = to_hv_vcpu(v);
+			hv_v = to_hv_vcpu_safe(v);
 
 			/*
 			 * The following check races with nested vCPUs entering/exiting
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 2da11b967c41..ea9c81d76dd3 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -62,6 +62,18 @@ static inline struct kvm_hv *to_kvm_hv(struct kvm *kvm)
 	return &kvm->arch.hyperv;
 }
 
+static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Ensure the HyperV structure is fully initialized when accessing it
+	 * without holding vcpu->mutex (or some other guarantee that KVM can't
+	 * concurrently instantiate the structure).
+	 *
+	 * Pairs with the smp_store_release() in kvm_hv_vcpu_init().
+	 */
+	return smp_load_acquire(&vcpu->arch.hyperv);
+}
+
 static inline struct kvm_vcpu_hv *to_hv_vcpu(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.hyperv;
@@ -88,7 +100,7 @@ static inline struct kvm_hv_syndbg *to_hv_syndbg(struct kvm_vcpu *vcpu)
 
 static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu_safe(vcpu);
 
 	return hv_vcpu ? hv_vcpu->vp_index : vcpu->vcpu_idx;
 }
@@ -142,7 +154,7 @@ static inline struct kvm_vcpu *hv_stimer_to_vcpu(struct kvm_vcpu_hv_stimer *stim
 
 static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu_safe(vcpu);
 
 	if (!hv_vcpu)
 		return false;
@@ -198,7 +210,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struct kvm_vcpu *vcpu,
 									   bool is_guest_mode)
 {
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu_safe(vcpu);
 	int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
 				HV_L1_TLB_FLUSH_FIFO;
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


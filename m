Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618483C8C62
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402507; cv=none; b=DQ0JG4H9FacxwPt2FtSlkFljGcZntUbR2ORwY7fjriMvGs+umXNyWNrSZ43xoHrIsZXCv53//hocZIufAZbYLTce3WERt72E1iYTKEBvR9iz4lfZmDqZaVkxiSiRbb9YU+vNVG6mgHtMyJUXys4qLURSYC/msrV49/2eP1VWbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402507; c=relaxed/simple;
	bh=wLB7YDC5xsF+keI4em1HTCfj9TDcTp0KwwCz+Y/kJyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fxco0gEGWMVo9RFeToz/oWnFyaup3gINo0x92Lf24iPwoT1oR0IcnPPU+ABSj3behHlzVGoW749l8bIVjCpo3dV/aigLd/g7v82h5UPbQP4kngxvaA7W2VpFWFtEgdmNoGRqXpn6UXe0hGGP6r15ROVq1o442ShVRDFJeapZMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BU2j8ejd; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BU2j8ejd"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8488ac68185so6524605b3a.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402506; x=1787007306; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PzTkXY1O2YiLgBEN/U4cIdeKl7IFFDOnRDsOKpsivdg=;
        b=BU2j8ejd7MEl5tVX9B7vi3Uyj2CVmQRF8gd0vsaGJBny2MeF7ClGC9pSSCGwzqBD2H
         7Q20TdsuPbs0QJu0xyhA3gVvks+32IVYxm6ErzNGJEmXlaHkN0YDXR6HWs8HhfrfEm/Z
         YGo5jQ27/axBhaZmG5WUDbiy1FSNkuY/rdFZ2SHiPi7MVgGoPRatu4bqDCx6AalduoOr
         JEDTTfgxfLvAvSlt0j7ZJjsPcd+YnqBA/mMlxzM8cxo3v8maMOalKrUZIIDwf9Zo3Ff9
         /f2wDI59mC8Zt3dZk30rfk/hoEiZrSsuSmLzPqZOojdXWG9x+pMpVWqHfjS4F57tW3KC
         wEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402506; x=1787007306;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzTkXY1O2YiLgBEN/U4cIdeKl7IFFDOnRDsOKpsivdg=;
        b=PY6y036GriebvI1NfoOcwEpG5Figshcm+JooJSeGp6Z7uiAeeUlv9k7nxwOPn4Tqe8
         anepVjj0T0/zyy28tKqKEeo/aQ5LbWF+BVegxEBFrd1s195OzvHlA0sOmMyqlDz35LuB
         1J3uAqTlHFtfA1AavQhC2tqYCoquBG/PKOrkAu95CSmdGcfmNOOttBJ+DeNi6FtdWmgX
         sQAvWG8Z/MA6UrmEGq5Ns9+Xp692CPpqlcN6eW3aqrtB84QehdPvRuWWoFjr3IFyckmR
         i3Zx7Lk4cvW79hjUndgEfk6qbCsrfAC+aN4nncoFVzp/wdQ5cP0nqKjgpBGkCVeWWRYh
         9aXw==
X-Gm-Message-State: AOJu0Yx+5bizqXygzvI9wwB1boQvQNyVmhicuAem70Lr0UVre9dS81iC
	1vC76ufmda7COJQflGjcc5CXmbR2anewYVp25KK7adNLR+TuvZ1w92X1Hg5cmrgFvJ6RY4SzKWm
	zxLTYqA==
X-Received: from pgww21.prod.google.com ([2002:a05:6a02:2c95:b0:cb2:54cf:afe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2985:b0:842:48ae:1d6c
 with SMTP id d2e1a72fcca58-84f696a146emr27046272b3a.24.1786402505563; Mon, 10
 Aug 2026 15:55:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:40 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-3-seanjc@google.com>
Subject: [PATCH v9 02/21] KVM: x86: Improve accuracy of KVM clock when TSC
 scaling is in force
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

The kvm_guest_time_update() function scales the host TSC frequency to
the guest's using kvm_scale_tsc() and the v->arch.l1_tsc_scaling_ratio
scaling ratio previously calculated for that vCPU. Then calculates the
scaling factors for the KVM clock itself based on that guest TSC
frequency.

However, it uses kHz as the unit when scaling, and then multiplies by
1000 only at the end.

With a host TSC frequency of 3000MHz and a guest set to 2500MHz, the
result of kvm_scale_tsc() will actually come out at 2,499,999kHz. So
the KVM clock advertised to the guest is based on a frequency of
2,499,999,000 Hz.

By using Hz as the unit from the beginning, the KVM clock would be based
on a more accurate frequency of 2,499,999,999 Hz in this example.

Use u64 for the hw_tsc_hz field since an unsigned int would overflow for
TSC frequencies above 4GHz. Use div_u64() for the Xen CPUID leaf to
play nice with 32-bit kernels.

Fixes: 78db6a503796 ("KVM: x86: rewrite handling of scaled TSC for kvmclock")
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/cpuid.c            |  1 +
 arch/x86/kvm/x86.c              | 18 ++++++++++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..6ddc988576d0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -864,7 +864,7 @@ struct kvm_vcpu_arch {
 	gpa_t time;
 	s8  pvclock_tsc_shift;
 	u32 pvclock_tsc_mul;
-	unsigned int hw_tsc_khz;
+	u64 hw_tsc_hz;
 	struct gfn_to_pfn_cache pv_time;
 	/* set guest stopped flag in pvclock flags field */
 	bool pvclock_set_guest_stopped_request;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ddb022cb203a..ca26be88c204 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
 #include <linux/sched/stat.h>
+#include <linux/units.h>
 
 #include <asm/processor.h>
 #include <asm/user.h>
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d3b47e38698c..ce6d155b2ee6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -61,6 +61,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/suspend.h>
 #include <linux/smp.h>
+#include <linux/units.h>
 
 #include <trace/events/ipi.h>
 #include <trace/events/kvm.h>
@@ -1763,7 +1764,8 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
 	struct pvclock_vcpu_time_info hv_clock = {};
-	unsigned long flags, tgt_tsc_khz;
+	unsigned long flags;
+	u64 tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	struct kvm_arch *ka = &v->kvm->arch;
@@ -1789,8 +1791,8 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* Keep irq disabled to prevent changes to the clock */
 	local_irq_save(flags);
-	tgt_tsc_khz = get_cpu_tsc_khz();
-	if (unlikely(tgt_tsc_khz == 0)) {
+	tgt_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
+	if (unlikely(tgt_tsc_hz == 0)) {
 		local_irq_restore(flags);
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
@@ -1831,16 +1833,16 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	/* With all the info we got, fill in the values */
 
 	if (kvm_caps.has_tsc_control) {
-		tgt_tsc_khz = kvm_scale_tsc(tgt_tsc_khz,
+		tgt_tsc_hz = kvm_scale_tsc(tgt_tsc_hz,
 					    v->arch.l1_tsc_scaling_ratio);
-		tgt_tsc_khz = tgt_tsc_khz ? : 1;
+		tgt_tsc_hz = tgt_tsc_hz ? : 1;
 	}
 
-	if (unlikely(vcpu->hw_tsc_khz != tgt_tsc_khz)) {
-		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,
+	if (unlikely(vcpu->hw_tsc_hz != tgt_tsc_hz)) {
+		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_hz,
 				   &vcpu->pvclock_tsc_shift,
 				   &vcpu->pvclock_tsc_mul);
-		vcpu->hw_tsc_khz = tgt_tsc_khz;
+		vcpu->hw_tsc_hz = tgt_tsc_hz;
 	}
 
 	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
-- 
2.55.0.679.g6767b8d81c-goog


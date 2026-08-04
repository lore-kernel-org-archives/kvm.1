Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E723E717F
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886770; cv=none; b=rwsZl41+kFK3QbQjKhJWLOhfluyl7/FpfUkAMrsbzi/ker0aIxOshAfLzcBI5bLopQGBnA7r4+hoNSgpFl5kzL82ZV6ESR8iXPrbEtZapXYboQFZJDw39hphmHiWS7Fna7iyjOpPfA+2ShBf/u8g0eWgjO20fRqrZRtVuKk1fOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886770; c=relaxed/simple;
	bh=VcDFsyXNDS5AHqe/iR4hiX/uBj74+UXKYzqXs5zgolM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mswb6QgymXqgDjiDFGxtoi7J4ZvDipO1PceTj+XFycGurUyxE/CUZhvAVwMD2LyDIhe2fzovpzjLozDLreRYmvkVXi7A6ZmaQ8+38bGKtHeIeBi85UlYxjR/TV83GdbaENacvazZKSpZPx4PHEtFmqP2KjunHzaueMr5IbU9MlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6hlMLUu; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6hlMLUu"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so411366a91.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886769; x=1786491569; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3GRGf0SAx8ZhbJ78r2siXWKgWBaDw4VeY+GDZV2SFCo=;
        b=I6hlMLUuVXe6DHnG+lI293LZZvFJohQ4wpp3q333dVSas0Sh+/UtCVNCgc/OAQHhpg
         PmyRfEgl5msRwo96d/qhbeoOLkD76uv0HHSnT2vKKeBhhvNm1ls9y7gJVYoJKMnxIA4L
         1aUmoHAsxzjHzssm12jIg/WiK/kcYzx3V3WIL4QL3p7WgDdO0OSlB9VdfXZfonPZdRVB
         +eO83wKmUUv6qrkiqv4RrZDhNjiRdQnksNDEREhYpptiEzApMdUypGyLmhi76DLWF1q5
         gUFlvBNjXJrtYws096vE+jalrIR3mTKTH5W6swJkhWG+c1WGVufxk6ssJ+yHO+J6Oo6O
         Mwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886769; x=1786491569;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GRGf0SAx8ZhbJ78r2siXWKgWBaDw4VeY+GDZV2SFCo=;
        b=EflPyEuqi7LSfxYpXkoZBOyr4Xl68M8ebzAFqFHT4LNQpfjcZLrZlbjMjtvnQkmlqE
         Wxl3UO39QZ8cMP/5XALTY4NZBLvvALkV4e9rN2sqB82QPo3BxLmJYhiB8k/dJArJYURg
         cd9ZuLw6F5wWJ6TEOAz4p1TXuqDp8Qo3xX+1jGzo1CSvT1dYPfeBfVpcxYTz1LxWUDR8
         fIT1KhmOWABT4uHAKbDm/41odfmqmX7Mg6iz8hQ83g1aysMLwrXxmk/r6ZHIHEhG7E4V
         9fKZ0wEcBmWvI8+tmNLuItYuy3RNXR8zklS8gXBc6r/oUptjsmIWRUTv0MzE50gp9qEP
         d6Yw==
X-Gm-Message-State: AOJu0YyJIPv0nVM8oHPazi0FyRzo0TYJ2WDuGuoWLVL5Mqd7yugJUnSf
	0vtNT9HxFC/sAvlwnqbRqPuG/yzaPZD+caIYIrJiPhdk22oR+HhQX5zBTTU8NhpM5BThkU2WbiG
	jDLeSTw==
X-Received: from pjhk65.prod.google.com ([2002:a17:90a:4cc7:b0:381:6cb1:3289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e8d:b0:38e:5828:a446
 with SMTP id 98e67ed59e1d1-3903c70ae1bmr1050461a91.19.1785886768582; Tue, 04
 Aug 2026 16:39:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:06 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-3-seanjc@google.com>
Subject: [PATCH v8 02/17] KVM: x86: Improve accuracy of KVM clock when TSC
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
 arch/x86/kvm/cpuid.c            |  3 ++-
 arch/x86/kvm/x86.c              | 18 ++++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

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
index 9e9cf6538a96..7049f5a5597b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -16,6 +16,7 @@
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
 #include <linux/sched/stat.h>
+#include <linux/units.h>
 
 #include <asm/processor.h>
 #include <asm/user.h>
@@ -2146,7 +2147,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 				*ecx = vcpu->arch.pvclock_tsc_mul;
 				*edx = vcpu->arch.pvclock_tsc_shift;
 			} else if (index == 2) {
-				*eax = vcpu->arch.hw_tsc_khz;
+				*eax = div_u64(vcpu->arch.hw_tsc_hz, HZ_PER_KHZ);
 			}
 		}
 	} else {
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
2.55.0.571.g244d577d93-goog


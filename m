Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114342;
	b=Pb16yiMMaNLrF6csqFCLvrXJEJBOWHG6qh7L7++w2uMJKELt/b0mwH0uoKy3yb76klNJ
	 XGcw41Kd7u8S9jwJlMVq4AVW8jf1OH9TpM9NoX/uxCFWsczAaQwDUWOHHsMYBeKrbxocF
	 iWUR8kqAZjYG5SgskY8sE47QOc6OHo0VgA4L9xZ9gMfge5DjADp+kMF/pc9La6jwGiw2I
	 A7LRo0eeGy9XB8N/WliqJ0QBDOBZGJa/LHYA2fpiUIdGeKmXP6AFv8GfZ83RQWnO6uXj+
	 M25pY/7cecQ02hanWZQ9apv3WgHTvriHN7UifweR9/YJiAi3F7pAPqBzclaxl6Cz7WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KP5KnQUPfka8VmyDjZcXxbg47BZ5cMwAz3YLWjZsMZ4=;
	b=SNwtR1dnLsRpwXyZ6giQ41Du2sdO888REdaH7Dx1h3zpg0Dxu/X+l7SZo6MIp7oUu+Kg
	 89PZpO0HmFn/sZ/IPdjmr+QTcF250i7KZiwtxrHt1WAPdg/VZFDf9dNJWbiYFWE726DVm
	 MCE31N4OUnSIuMCgeMWrbQqQi1xuylb5BuEtYGyIxuVOhFlr1fhk0vUkEu7pmM6x8cQy+
	 pgNh/477J9x/v4k6u2Cr48EvKrIQfw9qHd3reNFxXxqR8/wEKzGCdILtuK0OarVLBow85
	 Hi0gc+OJgNcl6tPSM5xKzufDh06OD2XVlv7EDH7vYNbMJjxjbaz96s86TO14yBb786Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="U5ZtHd/v";
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187160A3821
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F187160A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U5ZtHd/v
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-55bf11583d9so12190b6e.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114341; x=1795719141; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KP5KnQUPfka8VmyDjZcXxbg47BZ5cMwAz3YLWjZsMZ4=;
        b=U5ZtHd/vnoU1jG+mrlyNUmMOuA1fPrQz55P0tPMFVB0Evv3bgGQWOnZEgF56vkp/nz
         2ZkXqhSCQg5VxbRrQi4FN63mo5KGv8cRgTgHz9gAhsQQU7sMc6tZd0vjw931efGDbZA4
         QWtH+JXKwMTY7jFYMHPL9jnSDmg94hRE7H/OR8m/IU+XnC0RMcZ2B3RrHaX7wLhoxUT1
         YpygmsJFii75DAdBEJuuQDOMqrf0lvxZvV0I7ZOweIjqFesYsHJBJr6W8qG9nUA6aXHp
         e476XIKYyN1QQKKKsOWiU+g5PE75tzgkPXFQ45GD0vaHkvF2oRJl5feBtbk5AzzfE6+1
         eY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114341; x=1795719141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KP5KnQUPfka8VmyDjZcXxbg47BZ5cMwAz3YLWjZsMZ4=;
        b=WCIoz9JzrDiRcG/5Vel9kqNGvBL6QIUuoJG40Bb2qtYiSSdJe5NF1vANuiX/qGMqPV
         Wiz3HauBpOM8caYKQQgm0HiY+rEe51+3BIeuuCEYmE0TFsIARin9o+If0iUgKo4MBPUf
         D4LxnE55Wb0yCyBIgpuIam8XZRBpKm/rS9S9Xs2v+/NQOopsyGi9AxTh7LY5caz3AN7D
         bnpml7/xsbuPgSwXyx9oA6TjUU3ViNEtEf2GeniCI/kIkW390o7fiaHSMqOc4WQfOQjI
         7pIaGN6k64Wf51zAmGNwphiNvS+EwJ9aU8ogro/CoomnvSm+ZMufC82Vgs0vYQE4w622
         C3BQ==
X-Forwarded-Encrypted: i=1; AL+hErFLbZHrMnLpCM4WrNtXYzNS0Dz23C8M3lB2oUGKmjqDME26RkxpOIjSTWZbX3dFAX3XaCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zNfxJqJbu5eM6/ttpPIJb1xS17LJhhrPZIgMu7rukWwrMleo3
	k1kCj3CNlawQga4F+V5lYsPtnCDEZNkvaoLXvHDDBQPEXEUMiwW5lx08eZJ5MQGu7ue+34+SYWi
	2SZ2Okc/tD3hEUR1Yr9r56aT2Fg==
X-Received: from ilqa4.prod.google.com ([2002:a05:6e02:1204:b0:53d:3ab5:58fa])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a1f:b0:4d6:9133:cfee with SMTP id 5614622812f47-5797e899a03mr1751032b6e.51.1795114340655;
 Thu, 19 Nov 2026 10:52:20 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:47 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-6-coltonlewis@google.com>
Subject: [PATCH v10 05/33] KVM: arm64: Ignore HPMN for userspace PMU register access
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Userspace save and restore (KVM_GET_ONE_REG / KVM_SET_ONE_REG) must
observe and preserve all VM-implemented PMU counters
([0..nr_pmu_counters-1] plus PMCCNTR_EL0), independent of the vCPU's
current exception level or MDCR_EL2.HPMN.

Currently, two UAPI callbacks still depend on guest execution context
when a nested vCPU (KVM_ARM_VCPU_HAS_EL2) is paused below EL2
(!vcpu_is_el2(vcpu)) with MDCR_EL2.HPMN < nr_pmu_counters:

- set_pmreg() and get_pmreg() (backing PMINTEN{SET,CLR}_EL1,
  PMCNTEN{SET,CLR}_EL0, and PMOVS{SET,CLR}_EL0) mask register values
  with kvm_pmu_accessible_counter_mask(), which strips L1 hypervisor
  counter bits [HPMN..N-1]. Saving a vCPU paused in L2 hides those bits,
  and restoring them while paused in L2 permanently clears them.
- get_pmcr() calls kvm_vcpu_read_pmcr(), which substitutes
  MDCR_EL2.HPMN for PMCR_EL0.N below EL2, corrupting the saved
  PMCR_EL0.N value.

Switch set_pmreg() and get_pmreg() back to
kvm_pmu_implemented_counter_mask(), and have get_pmcr() populate
PMCR_EL0.N directly from vcpu->kvm->arch.nr_pmu_counters using
u64_replace_bits(). Keep kvm_vcpu_read_pmcr() and
kvm_pmu_accessible_counter_mask() for guest trap paths.

Fixes: 9a1c58cfefb0 ("KVM: arm64: nv: Adjust range of accessible PMCs according to HPMN")
Fixes: 600f6fa5c90c ("KVM: arm64: Let kvm_vcpu_read_pmcr() return an EL-dependent value for PMCR_EL0.N")
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 6e8bc4618870d..2d9ae781acff0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1081,8 +1081,8 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 		pmcr |= ARMV8_PMU_PMCR_LC;
 
 	/*
-	 * The value of PMCR.N field is included when the
-	 * vCPU register is read via kvm_vcpu_read_pmcr().
+	 * The value of PMCR.N field is included when the vCPU register
+	 * is read via kvm_vcpu_read_pmcr() or get_pmcr().
 	 */
 	__vcpu_assign_sys_reg(vcpu, r->reg, pmcr);
 
@@ -1323,7 +1323,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
-	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+	u64 mask = kvm_pmu_implemented_counter_mask(vcpu);
 
 	__vcpu_assign_sys_reg(vcpu, r->reg, val & mask);
 	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
@@ -1333,7 +1333,7 @@ static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 va
 
 static int get_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 *val)
 {
-	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+	u64 mask = kvm_pmu_implemented_counter_mask(vcpu);
 
 	*val = __vcpu_sys_reg(vcpu, r->reg) & mask;
 	return 0;
@@ -1505,7 +1505,9 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static int get_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 		    u64 *val)
 {
-	*val = kvm_vcpu_read_pmcr(vcpu);
+	*val = u64_replace_bits(__vcpu_sys_reg(vcpu, PMCR_EL0),
+				vcpu->kvm->arch.nr_pmu_counters,
+				ARMV8_PMU_PMCR_N);
 	return 0;
 }
 
-- 
2.56.1.708.g77570a6a1d-goog


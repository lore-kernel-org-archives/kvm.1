Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883919;
	b=fcjrHVGabx2sNTVdFHkoWdKjo5sNxT+AOAmpCWd4Eych5xvza6SXQlFqgDT8lIZ1Cs7G
	 KhDzmHsv+lLRodcJbWuOuLDnRLNjvBqUipFgieRqiZ9boWyXTWhZuC0e6nGT3sJi8Rbx5
	 FF7Mfd9JEtUAGrkmW0CqmHQlYThzm698OXXXlD+K4UkFMa9NRgp5YR+aOQGM5PackFnDD
	 XJ8eI/YN6E4vB0XXy0e5cBbnzPSQ6eWMS3vw0vOfs81idmixMqurSrmbRzNoFDszf6a77
	 FmCH4g/o1k+GgoJO2FmAsH8E+DbfmFJR69XSOrn/vNtpIlQvu76VnIkfw0JbS9sMFjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883919;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IRVAGxzf7VctAi+iC4X+T1YOewE9TNzN2rvTBLetHpY=;
	b=KdE/prNG3pWO2hRoslqpJacYfShSnY0Nk/+9Un3bNYkW+6qYFO8psrWDOVaMAhISEu+R
	 EQPx8baUlp7oMPFk+R/YeF1rI//c1AnygkjJhEP8C+GvUqBca4ligtSRMhEIcvy3YOtmH
	 UcPd/0rzV44BfSHRMnpJ3mbFJVkVII0rryC6MOAP4cCkq3Ph8waRNc1C/I06d9Z6WZJL2
	 1Zi7gLAjSoi90aTW9ogTjlMDzULVeysotu93hIIzj4299MrvamKKw49LsNWKg2Ao8yZbZ
	 m044w7x9eLjRqSxeVicTlQmMuR+QsCmNgXkQPCHoGSOfu4GtBqUVfjV9SZGFjdW1DoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=knDulfV4;
	arc=none smtp.remote-ip=95.215.58.125
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5D606A338
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 13:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB5D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=knDulfV4
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YBP4gg80w+vzJkgsXZlVqQ21n6DzTLTyqFQbTn1UPvA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793883916; v=1; x=1794488716;
 b=knDulfV4sPIrsheqxpZu0IpJupedg2o+ACCT85KcGNu0Z35/Ssal99DjMrjPLvvXkPKcKMry
 596R8uwjze3gLKvK68BzIWJPJNEWHc1mNh95d5A7E8scVLNvW73j+TRZ9gs1Yo7WlG/apQLXGsr
 cD5enXauE6xUTkWXLTY3gkmQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c4fc386bcc5afba2;
	Thu, 05 Nov 2026 13:05:15 +0000
X-Mizu-Trace-ID: c4fc386bcc5afba2
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] KVM: arm64: Allocate a protected vCPU's SVE state at EL2
Date: Thu,  5 Nov 2026 13:04:54 +0000
Message-ID: <20261105130456.1617185-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105130456.1617185-1-fuad.tabba@linux.dev>
References: <20261105130456.1617185-1-fuad.tabba@linux.dev>
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

For a vCPU with SVE, EL2 pins the buffer the host allocated at
KVM_ARM_VCPU_FINALIZE and saves the guest's SVE registers there. The
host can still read and write that buffer, so it can't hold a protected
vCPU's state.

Allocate a protected vCPU's SVE state from the hyp heap instead, and
free it with the vCPU. When EL2 resets a protected vCPU, zero its SVE
state and ZCR_EL1, as KVM does for a non-protected one. The host still
allocates its own buffer, which KVM_{GET,SET}_ONE_REG access before the
first run, but EL2 doesn't use it.

For a protected vCPU, the host's sve_max_vl now sizes an EL2 allocation
and is the guest's maximum vector length on every CPU. Give EL2 a copy
of kvm_sve_max_vl, the largest length all CPUs can give a guest, and
check every vCPU's sve_max_vl against it rather than clamping it to the
host's own maximum. set_sve_vls() already keeps the host's value within
that bound.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/include/asm/kvm_hyp.h   |  1 +
 arch/arm64/kvm/hyp/nvhe/pkvm.c     | 41 ++++++++++++++++++++----------
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |  1 +
 arch/arm64/kvm/reset.c             |  2 ++
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index b0e42be3d9eef..8cf42f87526dd 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -157,6 +157,7 @@ extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern enum mitigation_state kvm_nvhe_sym(spectre_v2_state);
 extern enum mitigation_state kvm_nvhe_sym(spectre_v4_state);
 extern enum mitigation_state kvm_nvhe_sym(spectre_bhb_state);
+extern unsigned int kvm_nvhe_sym(kvm_sve_max_vl);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
 extern unsigned long kvm_nvhe_sym(hyp_nr_cpus);
 extern unsigned int kvm_nvhe_sym(hyp_gicv3_nr_lr);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index fc0475f0877d1..6500acbd84969 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -30,6 +30,7 @@ unsigned long __icache_flags;
 /* Used by kvm_get_vttbr(). */
 unsigned int kvm_arm_vmid_bits;
 
+unsigned int kvm_sve_max_vl;
 unsigned int kvm_host_sve_max_vl;
 
 /*
@@ -476,7 +477,7 @@ static void unpin_host_vcpu(struct kvm_vcpu *host_vcpu)
 		hyp_unpin_shared_mem(host_vcpu, host_vcpu + 1);
 }
 
-static void unpin_host_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
+static void teardown_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
 {
 	void *sve_state;
 
@@ -484,8 +485,10 @@ static void unpin_host_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
 	if (!sve_state)
 		return;
 
-	hyp_unpin_shared_mem(sve_state,
-			     sve_state + vcpu_sve_state_size(&hyp_vcpu->vcpu));
+	if (pkvm_hyp_vcpu_is_protected(hyp_vcpu))
+		hyp_free(sve_state);
+	else
+		hyp_unpin_shared_mem(sve_state, sve_state + vcpu_sve_state_size(&hyp_vcpu->vcpu));
 }
 
 static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
@@ -500,7 +503,7 @@ static void unpin_host_vcpus(struct pkvm_hyp_vcpu *hyp_vcpus[],
 			continue;
 
 		unpin_host_vcpu(hyp_vcpu->host_vcpu);
-		unpin_host_sve_state(hyp_vcpu);
+		teardown_sve_state(hyp_vcpu);
 	}
 }
 
@@ -543,18 +546,25 @@ static int pkvm_vcpu_init_sve(struct pkvm_hyp_vcpu *hyp_vcpu, struct kvm_vcpu *h
 		return 0;
 	}
 
-	/* Limit guest vector length to the maximum supported by the host. */
-	sve_max_vl = min(READ_ONCE(host_vcpu->arch.sve_max_vl), kvm_host_sve_max_vl);
-	sve_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sve_state));
-
-	if (!sve_vl_valid(sve_max_vl) || !sve_state)
+	sve_max_vl = READ_ONCE(host_vcpu->arch.sve_max_vl);
+	if (!sve_vl_valid(sve_max_vl) || sve_max_vl > kvm_sve_max_vl)
 		return -EINVAL;
 
 	sve_state_size = sve_state_size_from_vl(sve_max_vl);
 
-	ret = hyp_pin_shared_mem(sve_state, sve_state + sve_state_size);
-	if (ret)
-		return ret;
+	if (pkvm_hyp_vcpu_is_protected(hyp_vcpu)) {
+		sve_state = hyp_alloc(sve_state_size);
+		if (!sve_state)
+			return hyp_alloc_errno();
+	} else {
+		sve_state = kern_hyp_va(READ_ONCE(host_vcpu->arch.sve_state));
+		if (!sve_state)
+			return -EINVAL;
+
+		ret = hyp_pin_shared_mem(sve_state, sve_state + sve_state_size);
+		if (ret)
+			return ret;
+	}
 
 	vcpu->arch.sve_state = sve_state;
 	vcpu->arch.sve_max_vl = sve_max_vl;
@@ -643,7 +653,7 @@ static int init_pkvm_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu,
 done:
 	if (ret) {
 		unpin_host_vcpu(host_vcpu);
-		unpin_host_sve_state(hyp_vcpu);
+		teardown_sve_state(hyp_vcpu);
 	}
 	return ret;
 }
@@ -1015,7 +1025,7 @@ int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu)
 	ret = register_hyp_vcpu(hyp_vm, hyp_vcpu);
 	if (ret) {
 		unpin_host_vcpu(host_vcpu);
-		unpin_host_sve_state(hyp_vcpu);
+		teardown_sve_state(hyp_vcpu);
 		goto unclaim;
 	}
 	goto unlock;
@@ -1243,6 +1253,9 @@ int pkvm_reset_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 			    PSCI_0_2_AFFINITY_LEVEL_ON) != PSCI_0_2_AFFINITY_LEVEL_ON_PENDING)
 		return -ECANCELED;
 
+	if (vcpu_has_sve(&hyp_vcpu->vcpu))
+		memset(hyp_vcpu->vcpu.arch.sve_state, 0, vcpu_sve_state_size(&hyp_vcpu->vcpu));
+
 	kvm_reset_vcpu_core(&hyp_vcpu->vcpu);
 	kvm_reset_pvm_sys_regs(&hyp_vcpu->vcpu);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 32e82653ebf7e..06ea91415ad8b 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -570,6 +570,7 @@ static const struct sys_reg_desc_reset pvm_sys_reg_reset_vals[] = {
 	RESET_UNKNOWN(MAIR_EL1),
 	RESET_ZERO(AMAIR_EL1),
 	RESET_ZERO(MDSCR_EL1),
+	RESET_ZERO(ZCR_EL1),
 	RESET_ZERO(CNTV_CTL_EL0),
 	RESET_UNKNOWN(TTBR0_EL1),
 	RESET_UNKNOWN(TTBR1_EL1),
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 10eb7249aa9e8..aaaa1b8634ba4 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -52,6 +52,8 @@ int __init kvm_arm_init_sve(void)
 		if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
 			kvm_sve_max_vl = VL_ARCH_MAX;
 
+		kvm_nvhe_sym(kvm_sve_max_vl) = kvm_sve_max_vl;
+
 		/*
 		 * Don't even try to make use of vector lengths that
 		 * aren't available on all CPUs, for now:
-- 
2.47.3


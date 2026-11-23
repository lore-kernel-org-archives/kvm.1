Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446622;
	b=CFEYRmj5nU9m/peKzSPtfuCQqiddeOHEy4wyRgM9lhMAUFEp8ipmC7SdqkoChKotvi/6
	 LbjCc/RHQv+vOTkXyAxC2iCMC3llXR4+4LvLEi5aRuaqIvVHwB2mERhXLIvZZAphfnGVF
	 qfLsnkMkaGgeN+qLULxaiSH0cQkv6HHWoraYSbBLV5gz3uLFxiKf5ltOSBfotoX7FFQ3B
	 U1vLKVAeyr82a8K+qHp7RgSsHLGCT2trGGrysXCNCZndYuzQ7uwuJwGTNRZwF0/vxC5NZ
	 3w7Ny4d+ISPl+QG6ac5SiwClOUGfJPlnQp15hQKWtVrYdoRwORsNYc06qgyTFluX8UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446622;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IQiXWzWKyvjJNCEJcNajLSK7Gsk4vnOC+isyTFIFLsY=;
	b=eXs3PGLaFJlpFXWJGEHExINxYYTS20PKYGMYMAm3kddB7HNxnmGspUtgJ4laBxe+fcF6
	 C9/cDURl+uTXiBBcvOqWjxuqEnk5rdXXczIpRl6fYwIwHzVmLAN2puHyOSXC6kxjM5BMB
	 8CFvfbE/kwy9jHV3sde5BS5Sbl7feup9s47ZnVjEUTM/IaDsbp20AtMVrEXFv/L6DqVFL
	 xYLZ2Y0UCmXFbYY+R7418Ihn6Gtf1iZtxcb7Pj2n0x714fahsxulrmhJrnZbEAx70GKD3
	 uVTR81oZUF2XbFZTMoZJt1WsGkYz+WV+jrAX6et7guGsj40eprzgdw5eqGa7izpY6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mA9ZvOFW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD6606A321;
	Mon, 23 Nov 2026 15:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CD6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mA9ZvOFW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F93019F6;
	Mon, 23 Nov 2026 07:10:18 -0800 (PST)
Received: from entos-yitian-01.Arm.com (unknown [10.168.196.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA2633F632;
	Mon, 23 Nov 2026 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795446621; bh=U9cuwkZdZShqPIkeMhEmNQyq0ckxOTBqrasBSAUj27Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mA9ZvOFWCwrhB53yIHpXKQ+Km7EUzZZD11mk8j1dTe8RTfFJ2FGLJ38ehZNIs1Hub
	 BUc8+Xnyx9VO6eTqR4Ty9kciJ70hSxoGSAdG3luDZJNjwZmeSV+8PJuOO/lQe31VV4
	 7MBic+e/FhUA8yiH+g2Utd503JArUtlAeNKUx3EM=
From: Jia He <justin.he@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH 2/3] KVM: arm64: nv: Don't request or attempt L1 VNCR mapping without vncr_tlb
Date: Mon, 23 Nov 2026 15:09:16 +0000
Message-Id: <20261123150917.2679600-3-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123150917.2679600-1-justin.he@arm.com>
References: <20261123150917.2679600-1-justin.he@arm.com>
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

vcpu->arch.vncr_tlb is only allocated when ID_AA64MMFR4_EL1.NV_frac
advertises FEAT_NV2. When NV_frac is cleared to 0 (or E2H0 is selected),
vncr_tlb is NULL for the lifetime of the vCPU.

Don't set KVM_REQ_MAP_L1_VNCR_EL2 in kvm_vcpu_load_hw_mmu() when
vncr_tlb is NULL. The only other place that sets this request is
kvm_translate_vncr(), which only runs on a FEAT_NV2 VNCR abort. Warn and
return early in kvm_map_l1_vncr() if vt is NULL before disabling
preemption and taking kvm->mmu_lock.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kvm/nested.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 4d83281a7a28..2f52c128f3a7 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -979,7 +979,8 @@ void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu)
 				vcpu->arch.hw_mmu = get_s2_mmu_nested(vcpu);
 		}
 
-		if (__vcpu_sys_reg(vcpu, HCR_EL2) & HCR_EL2_NV)
+		if (vcpu->arch.vncr_tlb &&
+		    (__vcpu_sys_reg(vcpu, HCR_EL2) & HCR_EL2_NV))
 			kvm_make_request(KVM_REQ_MAP_L1_VNCR_EL2, vcpu);
 	}
 }
@@ -1761,6 +1762,9 @@ static void kvm_map_l1_vncr(struct kvm_vcpu *vcpu)
 	struct vncr_tlb *vt = vcpu->arch.vncr_tlb;
 	pgprot_t prot;
 
+	if (WARN_ON_ONCE(!vt))
+		return;
+
 	guard(preempt)();
 	guard(read_lock)(&vcpu->kvm->mmu_lock);
 
-- 
2.34.1


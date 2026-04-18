Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21D34DCD7
	for <kvm@vger.kernel.org>; Sat, 18 Apr 2026 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776500113; cv=none; b=aDPe48cpuHlk7t0Z0mmvO6UQ7ygtMHo0voC0JwhAKzATsuwh0PJ8eyRwiyFIuvYwSCJUGiQNM+pOEjk9xf5+b/cwjSQDvTCFThs2YtijIekvRpX8Q1P4dxUiSi5D2rtp6DdXwvQj2aub8bHmTkwSg7iV7bsqdc1qZg8xc1A+Ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776500113; c=relaxed/simple;
	bh=6pigEJb6MjU5WOzv3cHoV2MRbx3gnmposFMAjl091HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6muXUgdx+YaPx4azizppHX/5+i88VfRDcx0hKD4y9XOUXNSLKeNtrkdeAgDtK4YU9CyVSn+cHj626JueGqkG5pxf6nx7/XlRnVSdlKIrvmUPEGLj1TKob1E8Tah9tYOrof2Fl8oXl7um92/jc12hNxzXpCG1jUryQTa5Vc2lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=JpwUrAuh reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="JpwUrAuh"
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63I8EbAe001871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 18 Apr 2026 17:15:02 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Vpu164nWx4WQH4ej/oGZKppmfZaoPsbjbattGAiYgSg=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1776500102; v=1;
        b=JpwUrAuhhIIjWvHb4Wrz851b8T5JrYXSGoHkvhkQgv9yJiGepJg5wCf4RHNzkEja
         aolXogIXvkhi0RXOXhq9+wvqsOYWH6q96xZ7MkoVhOrO7VLg2cVvdxRXgubIZZoA
         O8NvF/xRKHsa87n8LZw3X7/LhIDDs0jD8wIFrjiwcT7YrcGP1f2HWzk5LPeBxGxS
         Ga4J5SAGL/nTPTWFMfPT+sm6a6xGHaYuTC7VikzXu095Kei8CdOgCV43+G52ZoVC
         anJKg4pPQ5wBj6cA1n7/rzGSJgtAJG5YlaR5iF4A1JVlUVpzZYVVFpXGK/Jh8mrF
         cIk/HujGJDJuvuE8qkH/cA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 18 Apr 2026 17:14:23 +0900
Subject: [PATCH v7 1/4] KVM: arm64: PMU: Add kvm_pmu_enabled_counter_mask()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-hybrid-v7-1-2bf39ad009bf@rsg.ci.i.u-tokyo.ac.jp>
References: <20260418-hybrid-v7-0-2bf39ad009bf@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260418-hybrid-v7-0-2bf39ad009bf@rsg.ci.i.u-tokyo.ac.jp>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c

This function will be useful to enumerate enabled counters.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 arch/arm64/kvm/pmu-emul.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index b03dbda7f1ab..59ec96e09321 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -619,18 +619,24 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 	}
 }
 
-static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc)
+static u64 kvm_pmu_enabled_counter_mask(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
-	unsigned int mdcr = __vcpu_sys_reg(vcpu, MDCR_EL2);
+	u64 mask = 0;
 
-	if (!(__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(pmc->idx)))
-		return false;
+	if (__vcpu_sys_reg(vcpu, MDCR_EL2) & MDCR_EL2_HPME)
+		mask |= kvm_pmu_hyp_counter_mask(vcpu);
 
-	if (kvm_pmu_counter_is_hyp(vcpu, pmc->idx))
-		return mdcr & MDCR_EL2_HPME;
+	if (kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E)
+		mask |= ~kvm_pmu_hyp_counter_mask(vcpu);
+
+	return __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
+}
+
+static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc)
+{
+	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
 
-	return kvm_vcpu_read_pmcr(vcpu) & ARMV8_PMU_PMCR_E;
+	return kvm_pmu_enabled_counter_mask(vcpu) & BIT(pmc->idx);
 }
 
 static bool kvm_pmc_counts_at_el0(struct kvm_pmc *pmc)

-- 
2.53.0


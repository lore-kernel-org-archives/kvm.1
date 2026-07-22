Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD1481AA0
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710668; cv=none; b=nBAMHkdR52JrqSeVfavTVD2R2LylISLhASQGELYbXRgR7szPGP2rGj8VDdXq0o7K+Y8I6ccUV5On48+SKE35gkl0svnEX9vDauJTHXCDBAHIkowiexdtpCbybBIaVtwgFxk/+DOBAkC2PH+Rbl5QdBu6nltIEYZ/MYtj7oV5UdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710668; c=relaxed/simple;
	bh=9eT7XNxoQ5aXB7T24p3Wn7GrPFGNtzoJCb0xwP2v8Mk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IyxvgckEts3UiKOaGy5TgPYAStDzxDGJsNkb8iIXSGSfDf6I33nJ63gjAFK6I1vAhbvW1e2SziWkfj8iYR66xNdVv3pj/ZjDUAw2Aw2f7wURzFxgSsDblUIjo8De+OQmZWgXWs5b4/M/hLEIHqJnLc44tpaDvdFCPJD7jYIiNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=Y5iaYZyI; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="Y5iaYZyI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pCUyW3VP9An/NOKwTrr8txpx8hCygKcixKALf7H9gzo=; b=Y5iaYZyILSfdZACSqapSm3jlK9
	8KKN9ZKyTzJrO47UlnaptvPg3weXLDCOKePs1ZhMTDMuZl/U0enxzW6Tk1H6yTpci2y/w0jTMyQHk
	NnYLLGOQNjqKcvnVxtvwb5ES9Lu0r2HsB13Pv9VLhj+EqxL9AWFigfZP3zYbEiL2lZkzF51psZF5m
	omHDrtOcWu5wywujAT4k2ufpvGUI3hA/gpAGj2g5YGSvpwn6OHTb2VhA+Vnin3NOQBYE3F5tRooxW
	w7zgdGYf/dIaWcLk3+6CqWGOgtewshDpi2EO4JFlyAWopQY32Pm7u6FCrfbIPv8WS1ulUeECuxBrZ
	OjzuN88Q==;
Received: from mailer.gwdg.de ([134.76.10.26]:55277)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wmSbh-00D6yG-1C;
	Wed, 22 Jul 2026 10:47:13 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wmSbh-0004a6-12;
	Wed, 22 Jul 2026 10:47:13 +0200
Received: from eftekhar-ubuntu.tu-dortmund.de (10.250.9.199) by
 mbx19-gwd-01.um.gwdg.de (10.108.142.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 22 Jul 2026 10:47:12 +0200
From: <amirmohammad.eftekhar@cispa.de>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <rossow@cispa.de>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH] KVM: x86: bound the composed nested TSC multiplier to the max ratio
Date: Wed, 22 Jul 2026 10:47:01 +0200
Message-ID: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-SUB-07.um.gwdg.de (10.108.142.72) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

kvm_calc_nested_tsc_multiplier() folds L1's own TSC multiplier (M1) with
the multiplier L1 requests for L2 (M2) into the single hardware ratio
programmed for L2: M_eff = (M1 * M2) >> frac.  Each input is validated
individually against the per-vendor maximum, but the composed output is
not, and it is stored into a 64-bit field:

 - Intel (frac = 48): when M1 * M2 >= 2^(64+48) the true M_eff exceeds
   2^64 and the low 64 bits are programmed silently.  L2 then runs at a
   wrong rate; the truncated value can even land on default_tsc_scaling_
   ratio (2^48), disabling scaling entirely, or on 0, which fails the
   nested VM-entry.  This is reachable with no adversary on live
   migration: M1 = (guest_khz << 48) / host_khz grows on a slower
   destination, M_eff is recomposed on KVM_SET_NESTED_STATE / the
   destination KVM_SET_TSC_KHZ with the same missing check, and a
   (M1, M2) legal on the source can recompose to M_eff == 0 on the
   destination, whose mid-flight resume fails hardware VM-entry on
   vmcs02 and tears the guest down (KVM_EXIT_SHUTDOWN).

 - AMD (frac = 32): the ratio MSR is 40 bits, but M_eff can reach ~2^48,
   setting reserved bits that architecturally #GP the physical
   MSR_AMD64_TSC_RATIO write (see the companion wrmsrq_safe() change).

KVM already rejects an input M2 == 0 at nested-entry validation; extend
that to the composed result.  Compute the full 128-bit product, detect a
value that does not fit the field (its high 64 bits reach 1 << frac) or
exceeds kvm_caps.max_tsc_scaling_ratio, and saturate to the advertised
maximum -- keeping the guest alive at a representable ratio instead of
truncating.  This runs on both the entry compose (prepare_vmcs02 /
nested_svm_update_tsc_ratio_msr) and the restore/recompute paths that
share this helper (kvm_vcpu_write_tsc_multiplier, KVM_SET_NESTED_STATE).

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
This and the follow-up wrmsrq_safe() patch (next in this thread) are
sent together to security@ rather than the public list: the AMD side
is why -- the composed value here can carry reserved bits straight into
a physical MSR write in host ring 0, and today only the WRMSR exception
table stands between that and a real #GP oops on a build that lacks it.

 arch/x86/kvm/x86.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ce0d30e8825..5856b2358ee2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2676,11 +2676,31 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_offset);
 
 u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier)
 {
-	if (l2_multiplier != kvm_caps.default_tsc_scaling_ratio)
-		return mul_u64_u64_shr(l1_multiplier, l2_multiplier,
-				       kvm_caps.tsc_scaling_ratio_frac_bits);
+	unsigned int frac = kvm_caps.tsc_scaling_ratio_frac_bits;
+	u64 nested_multiplier;
 
-	return l1_multiplier;
+	if (l2_multiplier == kvm_caps.default_tsc_scaling_ratio)
+		return l1_multiplier;
+
+	/*
+	 * Both inputs are individually within [1, max_tsc_scaling_ratio], but
+	 * their fixed-point product (M1 * M2) >> frac can exceed the width of
+	 * the hardware TSC multiplier field: on Intel the high bits would be
+	 * silently truncated (yielding a wrong -- or even zero -- L2 scaling
+	 * ratio), and on AMD the surplus bits are reserved bits that #GP the
+	 * physical MSR_AMD64_TSC_RATIO write.  (M1 * M2) >> frac overflows u64
+	 * iff the high 64 bits of the 128-bit product are >= (1 << frac);
+	 * detect that (and any result above the advertised maximum) and
+	 * saturate rather than program an unrepresentable ratio.
+	 */
+	if (mul_u64_u64_shr(l1_multiplier, l2_multiplier, 64) >= (1ULL << frac))
+		return kvm_caps.max_tsc_scaling_ratio;
+
+	nested_multiplier = mul_u64_u64_shr(l1_multiplier, l2_multiplier, frac);
+	if (nested_multiplier > kvm_caps.max_tsc_scaling_ratio)
+		return kvm_caps.max_tsc_scaling_ratio;
+
+	return nested_multiplier;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-- 
2.34.1


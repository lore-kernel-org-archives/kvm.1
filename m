Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3C2857C7
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830957; cv=none; b=BiCWBqKBkKeXfwpUuW/gbTR+h52gd5nQ5OB9/FwW8O2rm5Dedk/sklbLkWWRi9mzVyUYta+oaN7iberdP3QH4zzPM2zhebloLZwmyuQWdH4cp8b+4YbqaplFvGAzz475dD46wCCZKlPCDZ57rO1x3vEf/BasEpgGzbRrIsVoWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830957; c=relaxed/simple;
	bh=i9b8tReiTU6EneCMAxiJtjPu4imoFar3nbaSH1KcU+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0l6+WoCwuG4ivy+IPB9PVeB0JpWL/VTAHsOFXu+8UD9bz7v/CuPFMRKbjo4AWwxdkffPhX8+6PPbqo0WqPQEnVyW6UXQS4CbX5etapzJDkxegX2KMh8NTD15lIOIz+vYCk6WwCNMA1Ns+zNeASkaC50jQ9EkdSInlF/MKw4o7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=S1pckoZj; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="S1pckoZj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hmbJsI2ay8C9qc2DqEOYo2aAAYG2npwKB0W6wJtzyQI=; b=S1pckoZjP2T7a/wfb8uPe7NJST
	uLgtTmesjxvByMOvl6sXJWtmItvpNZ6VspdBGkZtdtCzfsuQzIobc2gF4egsi7aOhxCpVLCmX9ErX
	jaGOlrwh6Pz59MZ2hr+XNkrSr97EzG7g6+lr+cFQ8FibyWEAG3LaMQovIZ8wVTUH37Nw94Hc5SmQt
	2Ubtq0qQvJpA8J4y2lv6ymAJq+h6/8djcIF4GxwjGXHkPrBJTKO6r1gB2vG9xgVOZIlWQUDVphhJE
	YyqYFGGjYqvhx8amSmqEBzLuthRCoEG8Pc5iu5ZLJOlkvzGAIaPsOGrNJ/ol8mOs8SN8Wix4SvHyw
	20l7Z91A==;
Received: from mailer.gwdg.de ([134.76.10.26]:44976)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wmy3m-00Dohf-11;
	Thu, 23 Jul 2026 20:22:18 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wmy3l-0007aw-0e;
	Thu, 23 Jul 2026 20:22:17 +0200
Received: from eftekhar-ubuntu.tu-dortmund.de (10.250.9.199) by
 mbx19-gwd-01.um.gwdg.de (10.108.142.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 23 Jul 2026 20:22:16 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH v2] KVM: x86: bound the composed nested TSC multiplier to a representable ratio
Date: Thu, 23 Jul 2026 20:21:59 +0200
Message-ID: <20260723182159.2320033-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
References: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-SUB-08.um.gwdg.de (10.108.142.73) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

kvm_calc_nested_tsc_multiplier() folds L1's own TSC multiplier (M1) with
the multiplier L1 requests for L2 (M2) into the single hardware ratio
programmed for L2: M_eff = (M1 * M2) >> frac.  Each input is validated
individually against the per-vendor maximum (and against zero), but the
composed output is not, and it is stored into a 64-bit field.  The fixed-
point product can leave the representable range at *both* ends:

 - Top (overflow).  Intel (frac = 48): when M1 * M2 >= 2^(64+48) the true
   M_eff exceeds 2^64 and the low 64 bits are programmed silently, so L2
   runs at a wrong rate; the truncated value can even land on
   default_tsc_scaling_ratio (2^48), disabling scaling entirely, or on 0,
   which fails the nested VM-entry.  AMD (frac = 32): the ratio MSR is 40
   bits, but M_eff can reach ~2^48, setting reserved bits that
   architecturally #GP the physical MSR_AMD64_TSC_RATIO write (see the
   companion wrmsrq_safe() change).  This is reachable with no adversary on
   live migration: M1 = (guest_khz << 48) / host_khz grows on a slower
   destination, M_eff is recomposed on KVM_SET_NESTED_STATE / the
   destination KVM_SET_TSC_KHZ with the same missing check, and a (M1, M2)
   legal on the source can recompose to M_eff == 0 on the destination,
   whose mid-flight resume fails hardware VM-entry on vmcs02 and tears the
   guest down (KVM_EXIT_SHUTDOWN).

 - Bottom (underflow).  The product also floors to 0 when the true ratio
   is below one ulp: M1 < 2^frac (L1 slower than the host) composed with a
   small but legal M2 -- e.g. M2 == 1 -- yields (M1 * M2) >> frac == 0.
   Both inputs pass their individual checks (Intel rejects only M2 == 0 via
   CC(!vmcs12->tsc_multiplier); a zero M2 on AMD is rejected separately),
   yet compose to a zero M_eff.  A zero multiplier is not representable: on
   Intel the SDM requires a nonzero TSC-multiplier under "use TSC scaling",
   so it fails VM-entry; on AMD it programs a frozen ratio MSR.

KVM already rejects a zero *input* multiplier at nested-entry validation;
extend that to the composed *result*.  Compute the full 128-bit product,
saturate to kvm_caps.max_tsc_scaling_ratio when it overflows the field or
exceeds the advertised maximum, and clamp up to the smallest representable
nonzero ratio (1) when it underflows to zero -- keeping the guest alive at
a representable ratio instead of programming an illegal one.  This runs on
both the entry compose (prepare_vmcs02 / nested_svm_update_tsc_ratio_msr)
and the restore/recompute paths that share this helper
(kvm_vcpu_write_tsc_multiplier, KVM_SET_NESTED_STATE).

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
v1: https://lore.kernel.org/r/20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de

The v1 review flagged that bounding only the top end leaves the composed
multiplier able to underflow to 0 (M1 < 2^frac composed with a small but
legal M2), which is the same illegal-value / VM-entry-failure class this
patch exists to prevent -- so it belongs in the same helper.  Note this is
distinct from a zero *input* MSR on AMD (svm_set_msr() accepting data == 0),
which is addressed separately by "KVM: SVM: reject a zero TSC ratio in
MSR_AMD64_TSC_RATIO"; both of this compose's inputs are individually legal.

v1 -> v2:
 - also clamp the composed multiplier's low end: return 1 (the smallest
   representable nonzero ratio) when the fixed-point product floors to 0,
   mirroring the high-end saturation.  Reworded the changelog to cover both
   ends and retitled ("... to the max ratio" -> "... to a representable
   ratio") to reflect that it now bounds both.
 - no change to the high-end / overflow logic.

 arch/x86/kvm/x86.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..a65d23cbb49b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2675,11 +2675,45 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_offset);
 
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
+	/*
+	 * The same product can floor to 0 at the other end, when the true ratio
+	 * is below one ulp (e.g. M1 < 2^frac -- L1 slower than the host --
+	 * composed with a small but legal M2).  A zero multiplier is no more
+	 * representable than an oversized one: Intel rejects it at VM-entry (the
+	 * SDM requires a nonzero TSC-multiplier under "use TSC scaling", which
+	 * KVM already mirrors on the input via CC(!vmcs12->tsc_multiplier)), and
+	 * on AMD it programs a frozen ratio into MSR_AMD64_TSC_RATIO.  Clamp up
+	 * to the smallest representable nonzero ratio, mirroring the saturation
+	 * above.
+	 */
+	if (!nested_multiplier)
+		return 1;
+
+	return nested_multiplier;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_calc_nested_tsc_multiplier);
 
-- 
2.34.1


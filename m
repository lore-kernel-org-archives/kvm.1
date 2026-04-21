Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BA379ED2
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789679; cv=none; b=Rae3P854jNMCqS4dNRyE2AROtAg3vj14Zv8rVzC3bclCB64DH3MSa2wvaFqXgdlUEIVpDtjH5mMfrgRGF1lHT2jlyqqgHOf1xRWxF2p31ESl+2lp0M7Ylg6j/Rdy2vxDRyfq5TQMx8QibwxKRbRk9cKKWNEmK297aCQbYRg71/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789679; c=relaxed/simple;
	bh=JgBQYCcFyw7eZBRlU8slk/gqMwHy5PO1mGjXHwFR09k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YOwywXt3ZaK/tj/wwBJexC382+8nXDE2yHL1JoTCt3IabiLjrBobpq6epzze65FtV4CMG2qIp21hXuWXZR6IjV/vCAW2DMhCqiG6vtUNB0Ekg8b1VsRE1sdHeCTmsblHZ6CO4z64Y43pBk7pvj0J1pA86B4fmaXXDAUof8ZmuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLLvBnCP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLLvBnCP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ec948174so42062675ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776789677; x=1777394477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mGHowqlkhnvPIJdGbn1Su1BmTTCjZzOEKR7Ulucq9pI=;
        b=eLLvBnCPLIEO6IriHt7qDNSPlBdGnGxoAAeUiXfHbgxgualIHuyJigrckF/fDIpEMa
         +b/QTPrHgvjWs8uMzpxA/FghvZv+avKpqZb9KmvhhtrOMIptNSW8fdeW0QfNVJeGbvHI
         uyqZPluIh4dOzLxbR6fePiQ9gMYdmij/csClQF7UpqH3boJgWGRwFld3sKpt5cgJeio9
         L1wBn034cVCSGA0PzgeZy9qLyjmJ+/krOG3WwoXZIPnbE6EUHRlH61Q3wW0tmZsZzrJG
         t3clq4eanMGPgSrC4Bm/r/4vdv5tGOEW1aEuqmwzk9BUP5kiU2c0vUA4kdzUeMGY+V2b
         c7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776789677; x=1777394477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGHowqlkhnvPIJdGbn1Su1BmTTCjZzOEKR7Ulucq9pI=;
        b=REgFnyTYBvjTvfFMUl3r1RrU+WlHmXVcvDgRLM1DBAg5loxFndU9/Fu3W7k+OLm4xb
         DyTkotuwncC43ZEbUst7xfFCZSaS+wJ91ZD3Fqd1Iolf/fJxx2DRvD3KnLbkVbcM3h1k
         DJOmgWJq7Zs1TkXX1Z8+eEi8bY23klXg8WTS6BCtrpNIvddX96AJfkpUdrqlCzPb/AxK
         vIMPe1iwXLY9s2o2ST7jWH1JinPMRdTpef7Ut9NH93Fk7owqzCsYRqqoBWkMM07Tp7M0
         5WUFcQATLKEZviAz9swwu3YLZKbsaVLjGu1I6AYi3ivK2mKZ/b2vSH71TMvJ7iqzo/yJ
         +YAg==
X-Gm-Message-State: AOJu0Yz91F0wwwlpkdzGOSIv7D9o/ncvDXmhXo+tMzr2IknLiBCjsQCJ
	dL1DtiDaa0PV4j4OzTBYw0DkI+MS5V9PsKFUOp/+904FFNfg491ef9DkPXr0QxJ00F0je15wLFV
	tMnl8Hl/MjtoJME9kBp9g7pmfO9Pn3hETd6obApJOLYYPYqltClJAxFrxm5RGQvt4hyLVK0bHZV
	w4ZjMAmElDvxC8+O6E97mlGwz1k4pY3My5NMubBsZAERDRP/llKZwN7sInbwg=
X-Received: from plik3.prod.google.com ([2002:a17:903:3843:b0:2ae:bb1f:5234])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1ac6:b0:2b2:5840:808e with SMTP id d9443c01a7336-2b5f9ee9487mr187401765ad.10.1776789676962;
 Tue, 21 Apr 2026 09:41:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:41:12 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421164112.2448553-1-jingzhangos@google.com>
Subject: [PATCH] KVM: arm64: Treat ID_AA64DFR0_EL1.PMUVer as an unsigned field
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	ARMLinux <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

ID_AA64DFR0_EL1.PMUVer is an unsigned 4-bit field, but was historically
marked as signed in the cpufeature table. This led
kvm_init_host_debug_data() to fail detection of PMUv3 implementation on
systems with PMUv3p8 or newer, as the signed extraction of the field
(e.g., 0b1000 for PMUv3p8) would result in a negative value.

Fix this by marking the field as unsigned in the ftr_id_aa64dfr0 table
and updating the KVM initialization code to use unsigned extraction.
While at it, ensure that both the 'Not Implemented' (0b0000) and
'Implementation Defined' (0b1111) values are correctly handled as
indicating the absence of a standard PMUv3.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 arch/arm64/kvm/debug.c         | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 32c2dbcc0c641..1b5e37a1a41b4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -565,7 +565,7 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	 * We can instantiate multiple PMU instances with different levels
 	 * of support.
 	 */
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_EL1_PMUVer_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_EL1_PMUVer_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_EL1_DebugVer_SHIFT, 4, 0x6),
 	ARM64_FTR_END,
 };
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 3ad6b7c6e4ba7..2834d7ef9dedb 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -75,8 +75,10 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 void kvm_init_host_debug_data(void)
 {
 	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+	u64 pmuver;
 
-	if (cpuid_feature_extract_signed_field(dfr0, ID_AA64DFR0_EL1_PMUVer_SHIFT) > 0)
+	pmuver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMUVer_SHIFT);
+	if (pmuv3_implemented(pmuver))
 		*host_data_ptr(nr_event_counters) = FIELD_GET(ARMV8_PMU_PMCR_N,
 							      read_sysreg(pmcr_el0));
 
-- 
2.54.0.rc1.555.g9c883467ad-goog


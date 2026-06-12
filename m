Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D363B6364
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292566; cv=none; b=d1n93SOyChPmc4pOk/2/GoZ62ISQTZpJey8vYB5IPmzAceukC+utsTStqxXHW2gQSgLFL1859jmoVHUyunI3EeFyfFuMY4Sq7iMMeADyElsiklBtdtRM40LtbWVZG/wFFFOhEWwd+yPfuA6QqsMpxTREP28OGKpst3WYVveUmS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292566; c=relaxed/simple;
	bh=ZG9ZKKsG5def4qAkO71pmX+aMwBP6QL7ujSsyD5d3oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iamuI6BelGnDCu+BoX0kPt098Jm0dKTeada06LKwj3M0e1shKHcp0NX72963H9BZK0XXUvxP6HPdKKjkBgm+1brVbEFYuJrGYu0fZIZWyjKoIZXFyaNYKPao4GfKfQpA2rkTCiYYnUfvutMGYqs9Tx/+RiBfnaBfNTuar3lhmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyDtXmjB; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyDtXmjB"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-486e64c8edeso1334066b6e.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292560; x=1781897360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUfvJDWatpVt+iiRM4HzP8H2jLIkMlFqueFXiDB4Pis=;
        b=SyDtXmjB9DRRaNSRzpLU1B/JEaDKfRT9w2ln2DX2NfVIRixXLQ4IYrEfGN52Iq9lQK
         X6u0LkCEGrjDl2jC6ksr4/QmJrlekkW6h5py/Qq7HOE+F8fHJLYglbK6DDmOkggCTuPD
         hPYI7re+lGjDA4BxqYKk331B4z+A0PaBIOk/+y/spK/LASM/vVdYWMSTdddoLgR2b2Dg
         ke/JvBcx2fFBwn/E4rY3wuM3YE86n4+w5c6pcOl+g7ubHwbCRLwCPCXsquAgjqRHOh2L
         rJCZ+XCkRGIAeFu9MMCZeI022C2q770TOHghaXAjPirpqqBXuee3ipgmSd0MAy4/K9Z6
         qEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292560; x=1781897360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUfvJDWatpVt+iiRM4HzP8H2jLIkMlFqueFXiDB4Pis=;
        b=NYILTswlEfsRQVd+AnhF5w+RWnssBSEP/JXQ8YK/3lfRyn4Kadbfse89LnRc/9KCYL
         IbTr+55r8MXakL0uUx5+n4gaH8Q8UfVHsELGC0p5kYzRx+W5Gq5m344mbfmrzjrQZxSA
         hZlgLy4aM/T+ISREtBJTJ5IF0a2PaiWjKdr581nh2JHhu0rrY5N46za/JOLipyipl5HG
         tW8dMwh29hn6XIcNHxnoCYjbxDD/o0isPopIR1PSFdxalEVt7oMjBt4YyT2cmMM9P9N7
         9pR2uporccvs7xC6WGjB4VoHVrqkCMLap7SoZ/cuDCsj3X08zIRQy7bPa1DymC3DgpkW
         WMEQ==
X-Gm-Message-State: AOJu0Yz5HMGQ2B8gsJlEGCMdRIZNsyt6iDokl7W3FuNZT1kJPHcX00PS
	DoGBnRRtAC7Zbg5ohKws5cXZRlKWS+GXdXmmHnah0dPjA6SUiYc4wyKnmp0XJIjnIg89HT2DtVI
	WmYL4DEXa/U0Kw/IWCrRJviMH7zgmOhDdCF5ve3qPMb4QO+6AXRIfajOlF/3uX2R6fYdFTCkDU8
	XFfJ2wCR2JS0sKoX6oR5yLOxIl7CgANHp8FGYs4ujS96C203jaM1djzeCiOLc=
X-Received: from jabjq11.prod.google.com ([2002:a05:6638:8d8b:b0:5e2:7e1d:1f79])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1790:b0:47b:bd7b:10e5 with SMTP id 5614622812f47-4872f35387fmr2525333b6e.3.1781292559384;
 Fri, 12 Jun 2026 12:29:19 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:58 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-11-coltonlewis@google.com>
Subject: [PATCH 10/21] KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Set up MDCR_EL2 to handle a Partitioned PMU. If partitioned, set the
HPME, HPMD, and HCCD bits. If we have the ability to use Fine Grain
Traps (FEAT_FGT) also, unset the TPM and TPMCR bits that trap all PMU
accesses and set HPMN to the correct number of guest counters so
hardware enforces the right values.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/debug.c | 27 ++++++++++++++++++++++++---
 arch/arm64/kvm/pmu.c   |  7 +++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index f4d7b12045e8f..c84321277d893 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -43,14 +43,35 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
 	 * to disable guest access to the profiling and trace buffers
 	 */
-	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
-					 *host_data_ptr(nr_event_counters));
+
+	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, *host_data_ptr(nr_event_counters));
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
 				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
 				MDCR_EL2_TPMCR |
 				MDCR_EL2_TDRA |
-				MDCR_EL2_TDOSA);
+				MDCR_EL2_TDOSA |
+				MDCR_EL2_HPME);
+
+	if (kvm_pmu_is_partitioned(vcpu->kvm)) {
+		u8 nr_guest_cntr = vcpu->kvm->arch.nr_pmu_counters;
+
+		vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD | MDCR_EL2_HCCD);
+
+		/*
+		 * Take out the coarse grain traps if we are using
+		 * fine grain traps and enforce counter access with
+		 * HPMN.
+		 */
+		if (!vcpu_on_unsupported_cpu(vcpu) &&
+		    cpus_have_final_cap(ARM64_HAS_FGT) &&
+		    (cpus_have_final_cap(ARM64_HAS_HPMN0) || nr_guest_cntr > 0)) {
+			vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_TPM | MDCR_EL2_TPMCR | MDCR_EL2_HPMN);
+			vcpu->arch.mdcr_el2 |= FIELD_PREP(MDCR_EL2_HPMN, nr_guest_cntr);
+		}
+
+
+	}
 
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 9ad3520417413..55cda8021400a 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -552,6 +552,13 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	if (cpus_have_final_cap(ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS))
 		return 1;
 
+	/*
+	 * If partitioned then we are limited by the max counters in
+	 * the guest partition.
+	 */
+	if (pmu_is_partitioned(arm_pmu))
+		return arm_pmu->max_guest_counters;
+
 	/*
 	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
 	 * Ignore those and return only the general-purpose counters.
-- 
2.54.0.1136.gdb2ca164c4-goog


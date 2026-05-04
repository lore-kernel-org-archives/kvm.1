Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F4421EE1
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929543; cv=none; b=mZ27GpTVAUI/4LoMCLb/AP0q0Y0Z4jZe5WV9qW0zzK3pErWpaFi/qeWzF3ajRQduCS1POo8LvLhE7qZSuuqnubS5FX1iLNFRd0owXZTfFpILKEAzaZLuFRqvfGxJOmAy7urn5tY/PJIlZ4yUyM5Ti4tyNXbZ9ipqsOXpNNgu1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929543; c=relaxed/simple;
	bh=z22FJ/RoHsM+jeuWzpMU9byGN80HsM7C3iFbEeU0P2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKZ2K9SvKDaw5ArI1i57durWW2Blp2f1vjfgPK/ZFnHKH+oaxL0VoNPMPziIRfTHrwxRgTn9Juo77GnH5qnQeBaSD5+aXDIuF5gatsiSxN6copOhfqWaj82ww9Tui4kYC1MTuNSRr1LGjLIPwid6xOlz47GD8oMU/KcqN8KM7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLtfez+A; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLtfez+A"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7dcd9f8dbe2so7980986a34.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929535; x=1778534335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjlPgXNwXeFHjDTHfAecQAjmNwOoUuZdzNZWTJemW0E=;
        b=cLtfez+AcMC+GjbVP/sLegG4Ev2Kqp0rj95GdVnSM5UIqNdYQvFaVWnpV1f4Mhou0u
         mMc6kkuCa+4rH95H0nkPzlN4l48xKX93DikxuGC7iGOb3SozrInCm7ZkhzGVi0IxJaac
         8vx1n3G7n5CuTEgzf9mk3f//CLemcxPL3xrr5tvRZAbWlKABI90N6jGyUZ9MxogyS0dy
         sJ72O2Bqomq8dvG89WMxlwRPToslhwLOEM7iCUzTnduOAdy834MG1XsLqoBWzxA+tC0U
         46AmUcRv43DKxqnqykvU9+XcVAVDu4vD04754WPXRphv9PC2Nnz2dj6z/tr5J1E3qQWY
         3obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929535; x=1778534335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjlPgXNwXeFHjDTHfAecQAjmNwOoUuZdzNZWTJemW0E=;
        b=loNCf43VjWQS4LUCtwzORvc6epm3qyQ8V2ppHII2P2NHlNTrvneaV9vxJs9lDVabRw
         Z8G1CfQ9fZ362CGQaL5h4pxliSOapsXApQLo+ukKw2x2mCDkqulJUNTUh/Z3WO5GJYmt
         m/EyVhXbJoG66Dbil3YFN8TNjZf/SeRH9t8Z6bsqrtoM1v/AN1YKMGlL6c/ctGTMo1Nm
         +NKlQsJA7eGNtzGDZTyOOHcLBnvOObwOF77Wu9nczNwLMN8zaHDGyRG3gdizKmtBwpKm
         G+cjC5eiCgdQDL7x1bO+X+TmkAY6vFSGlu602ybNuWPNlEq0S9n6VXTM+tUKYSAUVOIL
         v/Zg==
X-Gm-Message-State: AOJu0Yw5AtgKtpOjlDjbJ8zoar7OXQGxaRVeB0kAm6kwFz8cQti5FigM
	Oz3poVAldTJZzl0ay5gcxJZrz0z7RH2rFNAtyrb0YwMio7ji+urrHsNvNJ/G/7C1IeVujt/T1b4
	ZykVDmHyYFOeRvwD0e4ZD80Kta56hwquz3MXyCRcnDp2V4nar7Z8j0e1NcdDESM0XC3ulxL6fji
	6/T4klNpvDaHCu+UxZprvNZu3DkOfvA3Bd+1R3Lk9DtEn405sA2vp17AoIabI=
X-Received: from ilqt1.prod.google.com ([2002:a92:cc41:0:b0:4fd:69a2:6072])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:81c6:b0:694:8fb2:2c35 with SMTP id 006d021491bc7-6998a59a043mr161048eaf.2.1777929534601;
 Mon, 04 May 2026 14:18:54 -0700 (PDT)
Date: Mon,  4 May 2026 21:18:13 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-21-coltonlewis@google.com>
Subject: [PATCH v7 20/20] KVM: arm64: selftests: Relax testing for exceptions
 when partitioned
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

Because the Partitioned PMU must lean heavily on underlying hardware
support, it can't guarantee an exception occurs when accessing an
invalid pmc index.

The ARM manual specifies that accessing PMEVCNTR<n>_EL0 where n is
greater than the number of counters on the system is constrained
unpredictable when FEAT_FGT is not implemented, and it is desired the
Partitioned PMU still work without FEAT_FGT.

Though KVM could enforce exceptions here since all PMU accesses
without FEAT_FGT are trapped, that creates further difficulties. For
one example, the manual also says that after writing a value to
PMSELR_EL0 greater than the number of counters on a system, direct
reads will return an unknown value, meaning KVM could not rely on the
hardware register to hold the correct value.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/arm64/vpmu_counter_access.c | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index 9702f1d43b832..27b7d7b2a059a 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -38,10 +38,14 @@ const char *pmu_impl_str[] = {
 struct vpmu_vm {
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
+};
+
+struct guest_context {
 	bool pmu_partitioned;
 };
 
 static struct vpmu_vm vpmu_vm;
+static struct guest_context guest_context;
 
 struct pmreg_sets {
 	uint64_t set_reg_id;
@@ -342,11 +346,16 @@ static void test_access_invalid_pmc_regs(struct pmc_accessor *acc, int pmc_idx)
 	/*
 	 * Reading/writing the event count/type registers should cause
 	 * an UNDEFINED exception.
+	 *
+	 * If the pmu is partitioned, we can't guarantee it because
+	 * hardware doesn't.
 	 */
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_cntr(pmc_idx));
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_cntr(pmc_idx, 0));
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_typer(pmc_idx));
-	TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_typer(pmc_idx, 0));
+	if (!guest_context.pmu_partitioned) {
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_cntr(pmc_idx));
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_cntr(pmc_idx, 0));
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->read_typer(pmc_idx));
+		TEST_EXCEPTION(ESR_ELx_EC_UNKNOWN, acc->write_typer(pmc_idx, 0));
+	}
 	/*
 	 * The bit corresponding to the (unimplemented) counter in
 	 * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers should be RAZ.
@@ -459,7 +468,7 @@ static void create_vpmu_vm(void *guest_code, enum pmu_impl impl)
 		vpmu_vm.vcpu, KVM_ARM_VCPU_PMU_V3_CTRL, KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION);
 	if (!ret) {
 		vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &part_attr);
-		vpmu_vm.pmu_partitioned = partition;
+		guest_context.pmu_partitioned = partition;
 		pr_debug("Set PMU partitioning: %d\n", partition);
 	}
 
@@ -511,6 +520,7 @@ static void test_create_vpmu_vm_with_nr_counters(
 		TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_SET_DEVICE_ATTR, ret));
 
 	vcpu_device_attr_set(vcpu, KVM_ARM_VCPU_PMU_V3_CTRL, KVM_ARM_VCPU_PMU_V3_INIT, NULL);
+	sync_global_to_guest(vpmu_vm.vm, guest_context);
 }
 
 /*
-- 
2.54.0.545.g6539524ca2-goog


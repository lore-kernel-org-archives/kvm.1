Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C113242B2
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378122; cv=none; b=eTIp/CUNATU1oImBvRVgKmLsjIOMf6wBvgXF3ZWJD2D6iOejXLdyNaqPgkRp0l1YjTdlHotCzdtocdB5cvdCxVSQjcog/d2rGstUtyJk6ILw3OUiJBVloOA84x4b/UwOt86SXzTBsdDkcJfJTIkTgaFc+tVIjeN8Sw9J48dWmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378122; c=relaxed/simple;
	bh=NHQmFvVQNGqmMvQnG1Cw0kS00OH5C+7EKyCxke5Maf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zohc+Fv1GGoNu2sWEW4M2/agfO1SNos7paUDtmeFjSKHH5t4rqVglLh8Cf+Qk3a+/E5LsPRlzW9InOQe9gC5n3eEGtiyzAfTfuoZPdyupNhU6wRVYxDbUd2Mg4p7LbuhbEvro5lFEJEJBrnyPQXrEtBgJyuGfYHSaBBEogdgGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz/Urwe1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz/Urwe1"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8453f568e84so2274393b3a.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378120; x=1782982920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xB7qUPmcfFX2YiFs58VwnI7FiN+3mMnOwgtZFnYBHsA=;
        b=Cz/Urwe1gIdRu7c3m5+Z7j+u5BBibe9iViTUSYjA62h+kfpyqD5wD4/Xw3u886x3Bw
         o1eRgmtxyiYQ+nD7YAP7y11aYVYbTZSkv3pBPTOSL5o5eweaH/ESgCrUpI3xIdawr3xa
         VdsiF0eyrSl890VTZ9fj0HKZjxnVV/Dx9SAcrVzVFnabRIKpuaRGirokvRTtgydOxhW1
         DU5fdQMkpgZbz7Hpb7L7tLPjS5yHNBTRrOcsh2fDdNvisjaXCg56MU06WXwditMFWVWW
         pJpN0ED8IWsnWDnxVEXeksyU78hwefAVpi5i6G6uf4J5MNj1lkSPny4FW3l3x+M/76Ij
         82bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378120; x=1782982920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB7qUPmcfFX2YiFs58VwnI7FiN+3mMnOwgtZFnYBHsA=;
        b=aOwM/NwbO8Dbiyvyl5fJfGqt/VpPdlEE8t67rUGB1+a0G3nISQJngmNxxG3VmVVB+8
         Fq+cHPAdpWDmPS4In2IAQQPwoxJPmHzqlcjPLZXCZxGbTz2cAZ9zJYJ+5NVDVmMfxr9M
         uquf+LZoHFWyzOqX+akQLwJiPloU6TxCDsosXRT8o1xYvAd+yHsAunkHSxpY0rbjvxZ3
         o2U4io6ECltQHVZEc/gNc6iD4bmOlWp17LoOiNho4Qt9aJWJHuBy5fvMEjRgEkpjgpqv
         izyyjbajGGA/qGhpKRe/5D46o/u8h4Hr59/WBOTzlpmpRhpIb+lX5LHXsUKBbbhyAJrW
         Wj2w==
X-Forwarded-Encrypted: i=1; AFNElJ9Ll3oQTHxrrzsNrPRCjqSi+/OUbrR36/tIZIBQ3OAuiDEqS1lwS3y0kyRV/zec74mB284=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlpBtqKhjsrnqdAXXBSDCKP6Akuvw/Apn91yxWBHaBDkcnjvd
	w1xNyrxIxdBandm6mHC4NXXjtmn6t8jgZ3qlydB4/mbA6PfQ5vzL+8L0
X-Gm-Gg: AfdE7cm2UZgGL72piTDRGPdkFmaGrMRCtqpfgZG8hV8Hyaz8nG940r9hPozB/pai5kF
	QsMNtEH1QeJiWks5wY6NkJTYIScgx+CYIwaRfTvfPaP06qCeB0r4aq9EqSkDr4RhnP1BlINhz6h
	It9Px9kGVtrHxHZ7ZuwbqxajmJnv3I/8kyGRFgR8qiXi8F2MZCBz9EzeOIGeDayJ5q2cApuRUKu
	Q0Ip8G4IkSgmmgZpJULC9p+Gyxyq5P7EUOklNIBX6BNlrQ63J2HFw0Q9pWaJYVu45Wvvpl5+K7j
	1FFXH8E/YEr1AIkcm+neLxKy8JXYMSywDaRzkFnaKcUbPMym9k6OQNJKVzihMcGKEqoWqRxkzMj
	giN/2MC2pl9t3Pj4kwV4cLiNXtTEKJebS7dRd2ekoGiX1oLEF0HDZexBaWGmKJnsYi+016Ue0ww
	8PhSxDYw3dzzCgkH2GZs8f9g0Jek0/LKCaCFiKiApEt/BEpaiqL/5R2uEH
X-Received: by 2002:a05:6a00:1a8e:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-845b39d39c6mr2187454b3a.11.1782378119713;
        Thu, 25 Jun 2026 02:01:59 -0700 (PDT)
Received: from LIKEXU-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845b962bf55sm575643b3a.13.2026.06.25.02.01.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 02:01:59 -0700 (PDT)
From: Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: jmattson@google.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/pmu: Clean up vPMU comments and stray blank lines
Date: Thu, 25 Jun 2026 17:01:55 +0800
Message-ID: <20260625090155.6326-1-likexu@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up the x86 vPMU emulation code and its selftests by fixing comments
that no longer reflect the code along with assorted spelling and grammar
mistakes, and by dropping redundant blank lines reported by checkpatch.

No functional change intended.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/kvm/pmu.c                                   | 12 +++++-------
 arch/x86/kvm/pmu.h                                   |  4 ++--
 arch/x86/kvm/vmx/pmu_intel.c                         |  1 -
 tools/testing/selftests/kvm/x86/pmu_counters_test.c  |  4 ++--
 .../selftests/kvm/x86/pmu_event_filter_test.c        |  4 ++--
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e583356..e7f635b9c4d78 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -403,7 +403,7 @@ void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
 	 * read-modify-write.  Adjust the counter value so that its value is
 	 * relative to the current count, as reading the current count from
-	 * perf is faster than pausing and repgrogramming the event in order to
+	 * perf is faster than pausing and reprogramming the event in order to
 	 * reset it to '0'.  Note, this very sneakily offsets the accumulated
 	 * emulated count too, by using pmc_read_counter()!
 	 */
@@ -422,7 +422,6 @@ static int filter_cmp(const void *pa, const void *pb, u64 mask)
 	return (a > b) - (a < b);
 }
 
-
 static int filter_sort_cmp(const void *pa, const void *pb)
 {
 	return filter_cmp(pa, pb, (KVM_PMU_MASKED_ENTRY_EVENT_SELECT |
@@ -658,7 +657,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	/*
 	 * The reprogramming bitmap can be written asynchronously by something
 	 * other than the task that holds vcpu->mutex, take care to clear only
-	 * the bits that will actually processed.
+	 * the bits that will actually be processed.
 	 */
 	BUILD_BUG_ON(sizeof(bitmap) != sizeof(atomic64_t));
 	atomic64_andnot(*(s64 *)bitmap, &pmu->__reprogram_pmi);
@@ -666,9 +665,9 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
 		/*
 		 * If reprogramming fails, e.g. due to contention, re-set the
-		 * regprogram bit set, i.e. opportunistically try again on the
-		 * next PMU refresh.  Don't make a new request as doing so can
-		 * stall the guest if reprogramming repeatedly fails.
+		 * reprogram bit, i.e. opportunistically try again on the next
+		 * PMU refresh.  Don't make a new request as doing so can stall
+		 * the guest if reprogramming repeatedly fails.
 		 */
 		if (reprogram_counter(pmc))
 			set_bit(pmc->idx, pmu->reprogram_pmi);
@@ -956,7 +955,6 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	kvm_pmu_call(reset)(vcpu);
 }
 
-
 /*
  * Refresh the PMU configuration for the vCPU, e.g. if userspace changes CPUID
  * and/or PERF_CAPABILITIES.
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a5821d7c87f93..090c9bbb74f48 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -94,8 +94,8 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
  * is tracked internally via index 32.  On Intel, (AMD doesn't support fixed
  * counters), this mirrors how fixed counters are mapped to PERF_GLOBAL_CTRL
  * and similar MSRs, i.e. tracking fixed counters at base index 32 reduces the
- * amounter of boilerplate needed to iterate over PMCs *and* simplifies common
- * enabling/disable/reset operations.
+ * amount of boilerplate needed to iterate over PMCs *and* simplifies common
+ * enable/disable/reset operations.
  *
  * WARNING!  This helper is only for lookups that are initiated by KVM, it is
  * NOT safe for guest lookups, e.g. will do the wrong thing if passed a raw
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a73a9515d96cd..70ef84aa1a223 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -795,7 +795,6 @@ static void intel_pmu_write_global_ctrl(u64 global_ctrl)
 	vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL, global_ctrl);
 }
 
-
 static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index dc6afac3aa919..677dc23535487 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -146,7 +146,7 @@ static u8 guest_get_pmu_version(void)
 
 /*
  * If an architectural event is supported and guaranteed to generate at least
- * one "hit, assert that its count is non-zero.  If an event isn't supported or
+ * one hit, assert that its count is non-zero.  If an event isn't supported or
  * the test can't guarantee the associated action will occur, then all bets are
  * off regarding the count, i.e. no checks can be done.
  *
@@ -598,7 +598,7 @@ static void test_intel_counters(void)
 	 * To keep the total runtime reasonable, test only a handful of select,
 	 * semi-arbitrary values for the mask of unavailable PMU events.  Test
 	 * 0 (all events available) and all ones (no events available) as well
-	 * as alternating bit sequencues, e.g. to detect if KVM is checking the
+	 * as alternating bit sequences, e.g. to detect if KVM is checking the
 	 * wrong bit(s).
 	 */
 	const u32 unavailable_masks[] = {
diff --git a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
index 84e4c6ca67a3d..2d401ff091124 100644
--- a/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_event_filter_test.c
@@ -62,7 +62,7 @@ struct {
 
 /*
  * If we encounter a #GP during the guest PMU sanity check, then the guest
- * PMU is not functional. Inform the hypervisor via GUEST_SYNC(0).
+ * PMU is not functional. Inform the hypervisor via GUEST_SYNC(-EFAULT).
  */
 static void guest_gp_handler(struct ex_regs *regs)
 {
@@ -73,7 +73,7 @@ static void guest_gp_handler(struct ex_regs *regs)
  * Check that we can write a new value to the given MSR and read it back.
  * The caller should provide a non-empty set of bits that are safe to flip.
  *
- * Return on success. GUEST_SYNC(0) on error.
+ * Return on success, GUEST_SYNC(-EIO) on error.
  */
 static void check_msr(u32 msr, u64 bits_to_flip)
 {
-- 
2.50.1 (Apple Git-155)


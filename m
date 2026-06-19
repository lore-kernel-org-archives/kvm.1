Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B423A1693
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882430; cv=none; b=UzLvHrTUdynUazycbUD7X3qcs2+AniBDQIVIuzf7f7m3gOUP1G4zVdI/LjGHkD9UJXuTvDmGE/Dd2mRUHaEx3McO+8Wt1orcJqXEsLvJT8IlwnvUphXa3WBgDsesplVQ3cDQDePmsyBMZWeP+uncYOSthPzQtEgVPoSdC4rj9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882430; c=relaxed/simple;
	bh=vjLPLwBuCjJNL2bB4kda3IyY2d/sL9iiLeiW4CJEb3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHSb1tZpaFFaU/uM8QZc9yQCEyCpP+cJTrGL9A7jSvSioT0x4R9aPilwhiUCIffYEHxDRqmYyslENwQE1g77Ey9ewi4zcGtNKQbYUqdUTd917haPO2Zu/cEjys/2Q7IRWtoS3Ubl0P3BT+ypIUotFKIjhbFMn/9WK2gzYooFCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBUOiGQr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBUOiGQr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842b0dd8107so1388008b3a.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781882428; x=1782487228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uv0E4PvHOHuwpmDVFjauIwY/sN4JTB9e5wkPyuK7Uo=;
        b=FBUOiGQr4CU+fVwV+CcOPjB9v2kXLwTByIUEt9f0DnY0/bplaBMPfZyoL1MoRLUJaA
         zHd9W8Ml0fIUaR0gPVvNwsGvV4q7bH3d5BFmMVafWiI98hRQIwUK06wCONXmw90OYa2w
         iSyEJEeiewN0IzQ4ZWwyB+/9UXFlOFTwDP7VysM5wRNkqNqB2NljBvRIBdNYN7Wd96Bq
         8i2UXXrjKVPqG3xGCGm/Hf63sYgzfVLWQWtsanTOt2tofbAAfJCzFcqpQDnbCL5Ga2mG
         eCS1k23DHFrU5kD/J+3GqhdCwHtXewNLoLzM2A9epIkG0FJqbQSXTqLu96kyG9VutR/i
         4opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882428; x=1782487228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uv0E4PvHOHuwpmDVFjauIwY/sN4JTB9e5wkPyuK7Uo=;
        b=QOnPVnLps0jL249ZDDk8mOPAgcFOBBnzUAlh8oHCXsgJj88pYkiutL1rw0n65CUu/F
         Zwn77MJgscHo3EriDRLBlDN2WR+tI56R9kbzBj78c2sw7jQnHsqPLWCTehAKXgPzj4ii
         TdwDbWjAUKeWSqTflfH8b6I8SuRVHenu3W2b4QLW/KSFO5UeZZV2yVl7F18tKpqHJuqI
         i03pA+4Ktg76iV2AHLe/ZjWdR9yji6xcoHezeF+n9g1A9SBvQVST/5NLhzyV4NVhMRgz
         5HGN11Ruq1AavcVg2Sf8s6i9EC8hmaUOaCFBtpS6p22zlNz/zhQDPx/1pa33obSezuym
         j1iw==
X-Forwarded-Encrypted: i=1; AFNElJ/iwwxeBayuxwCa/VV2CUiUxGAsZyBgRx3vjjgW02u5YaDycTDecbMDGBF+VtNTJahQNUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cLjeChD1tvaI6VqnSqwtYixNADxyebJn6fgoMbwGk4EHdFil
	1lcr+JEI5S2pQX4HbZggxS/uCXJgwScZceAvcj9vs0H4miA1RcqMR43Tf2BnKzm4cCUuQmwSZUS
	N80FU8BnGhliCQA==
X-Received: from pfak18.prod.google.com ([2002:aa7:92d2:0:b0:842:54be:af3e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:10c6:b0:842:8500:95f1 with SMTP id d2e1a72fcca58-845508ccfd0mr4640169b3a.40.1781882427731;
 Fri, 19 Jun 2026 08:20:27 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:19:28 -0700
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260619152006.3684428-6-jmattson@google.com>
Subject: [kvm-unit-tests PATCH 5/5] x86/apic: Add a test for a PV IPI boundary condition
From: Jim Mattson <jmattson@google.com>
To: pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new test case, test_pv_ipi_sparse(), to verify that PV IPIs are
correctly delivered to vCPUs with APIC ID 255.

APIC ID 255 represents a critical boundary condition for PV IPIs:

1. It is the transition point where 0xff ceases to be a broadcast ID (as in
   xAPIC) and becomes a valid unicast ID (in x2APIC).
2. KVM's PV IPI mechanism groups vCPUs into 64-bit clusters. APIC ID 255
   maps to the 64th bit (bit 63) of the cluster bitmap. This tests
   potential off-by-one or fencepost errors at the MSB boundary of the
   bitmap processing loop.

Additionally, this introduces a sparse topology test configuration (smp=1,
maxcpus=256, and a hotplugged CPU at APIC ID 255) to ensure KVM's sparse
APIC ID map handling is robust and does not suffer from out-of-bounds
accesses when resolving target vCPUs.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 x86/apic.c        | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 x86/unittests.cfg |  8 +++++++
 2 files changed, 68 insertions(+)

diff --git a/x86/apic.c b/x86/apic.c
index eea0c8d8e0f9..2b220c9e3909 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -915,6 +915,65 @@ static void test_aliased_xapic_physical_ipi(void)
 	report(!f, "IPI to aliased xAPIC physical IDs");
 }
 
+static atomic_t pv_ipi_received[256];
+
+static void handle_pv_ipi(isr_regs_t *regs)
+{
+	atomic_inc(&pv_ipi_received[smp_id()]);
+	apic_write(APIC_EOI, 0);
+}
+
+/*
+ * Verify that PV IPIs are correctly delivered to a vCPU with APIC ID 255.
+ */
+static void test_pv_ipi_sparse(void)
+{
+	const u8 vector = 0xf2;
+	int ret;
+
+	if (!this_cpu_has_kvm() || !this_cpu_has(KVM_FEATURE_PV_SEND_IPI)) {
+		report_skip("PV IPIs are not supported");
+		return;
+	}
+
+	if (!test_device_enabled()) {
+		report_skip("Test device not enabled");
+		return;
+	}
+
+	if (cpu_count() != 2) {
+		report_skip("Requires 2 CPUs");
+		return;
+	}
+
+	/* 255 is a broadcast ID in xAPIC, so we must use x2APIC */
+	if (!is_x2apic_enabled()) {
+		report_skip("x2APIC is not enabled");
+		return;
+	}
+
+	if (id_map[1] != 255) {
+		report_skip("vCPU 1 does not have APIC ID 255");
+		return;
+	}
+
+	handle_irq(vector, handle_pv_ipi);
+
+	/* Send PV IPI to 255 (vCPU 1) */
+	ret = pv_ipi(1, 0, 255, APIC_DM_FIXED | vector);
+
+	/* Wait for IPI to be received on vCPU 1 */
+	u64 start = rdtsc();
+	while (rdtsc() - start < 1000000000 &&
+	       !atomic_read(&pv_ipi_received[255])) {
+		pause();
+	}
+
+	report(ret == 1 && atomic_read(&pv_ipi_received[255]) == 1 &&
+	       atomic_read(&pv_ipi_received[0]) == 0,
+	       "PV IPI to sparse APIC ID 255");
+}
+
 struct apic_test {
 	const char *name;
 	void (*fn)(void);
@@ -937,6 +996,7 @@ int main(int argc, char **argv)
 		{ "physical_broadcast", test_physical_broadcast },
 		{ "logical_ipi_xapic", test_logical_ipi_xapic },
 		{ "pv_ipi", test_pv_ipi },
+		{ "pv_ipi_sparse", test_pv_ipi_sparse },
 		{ "sti_nmi", test_sti_nmi },
 		{ "multiple_nmi", test_multiple_nmi },
 		{ "pending_nmi", test_pending_nmi },
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 0c433ac29e5f..0bdeb4b1826f 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -535,3 +535,11 @@ qemu_params = -enable-kvm -m 2048 -cpu host
 file = lam.flat
 arch = x86_64
 qemu_params = -enable-kvm -cpu max
+
+[apic_sparse]
+file = apic.flat
+smp = 1,maxcpus=256
+qemu_params = -M q35 -cpu qemu64,+x2apic,+tsc-deadline,+kvm-pv-ipi -device qemu64-x86_64-cpu,apic-id=255 -append 'pv_ipi_sparse'
+arch = x86_64
+timeout = 30
+groups = apic
-- 
2.55.0.rc0.799.gd6f94ed593-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654119;
	b=DFjw/ltkU5VQUDQBRWeAkDrb3nU1os0TvV8XETZvroY/ukpA5/gd8EzIDWI5ODUib0PK
	 UuRjJe6r+dcj9qNSH58/atnfbPvBQPsXZw8Gyrj9zNu8PajilTzu4MchJW2aeCxy0UOJT
	 zbCrlHofe/2RINKY+uZ8R5Q+6CtYg5x8QtWuk6DKFTvGKp9F1VEaNkgRFKEi6NF3ts6RY
	 H2pqRLYJO3PJ8gcljAcIXg8nH0LTaewxOC+bSecNSHzg1SlD+2yc2m5aQ+klrdvIYtbpz
	 UI+NTbmE5G6gl5eAD5MHQib7m7dO/XiSn1IF1e3MaFqTNcsV2aw86Dx4WvFf+Swrq+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vW6Ry9Ch0ZZ3uQ+M12uFowAtQ2l9Al/6tmRrBLbKdEc=;
	b=5S/sYP9RLXuLYkaNqbsj/3dWrwDnWyM7/MYSvQJy/pI+deUOq5s3TVYEh8KAvDn/ohkf
	 z1AElX0jj66TnvsOB3fcp2cewM2MjukCnVV5cVoCmecyZC1WG95kiDWbz8PQreLqMixrw
	 I3xsH5MTDJ0m42IxnWRA6OayLKYFsZ46s32dh2tnqSpcdjjmrziDz0K11Giqo1iFPN5G0
	 4n00Cvk8I5LTbNYWSP4tpPSUe50qpm3QLlQVEMAxqMGrBBk6WYCCS3x5cGBMqsbTZbYUo
	 tIMMvxpJMrEFmpTzPY0q6GVmZoPwOvNCJ3avyH/sW+QNREwuwXJgxGyPYKSMYbi0bwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D5FFD/qr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1366606A336
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5FFD/qr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E841F000C4;
	Thu, 26 Nov 2026 00:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654119;
	bh=vW6Ry9Ch0ZZ3uQ+M12uFowAtQ2l9Al/6tmRrBLbKdEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D5FFD/qrXglZcWhneQi/sg6e5WhxsiaxMzIeqA7aFN8KE0lKny7XlmqiGnAwtT4vQ
	 6zbgi6tiGNZbJgUt5G34rkMpuAmvTaNRY8G/qzXQCis2mR97Bujzq6G/uq7qirpaiA
	 msey7T9FgaNvQOjyIo121WbMat6obWyRcw5k5kpzduqY/gtxBHbtrO54Gqdcz1GcbZ
	 GALePXvxTHL1TTPfkhmlcxj/pM9vocTVAIgQAYpr4sTY5pSRpjLNWvjBoLDt6d1s/b
	 z+CZTStlAww+tCgtBp5wRy5vUcJgw5FhsKUMNrVL6mlBM8SewS5DGX56VCYR8/sVkr
	 2LYm2090scWzQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 3/3] x86/pmu: Check emulated instruction/branch count difference on AMD
Date: Thu, 26 Nov 2026 00:48:31 +0000
Message-ID: <20261126004831.2712453-4-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
In-Reply-To: <20261126004831.2712453-1-yosry@kernel.org>
References: <20261126004831.2712453-1-yosry@kernel.org>
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

On AMD, the emulated instruction test can only check that the
instructions and branches counts are at least the expected counts, as
asynchronous VM-Exits, e.g. due to host IRQs, add to both counts (AMD
counts a successful VMRUN as a retired instruction and branch in guest
mode).  This doesn't catch KVM overcounting emulated instructions or
branches, e.g. if KVM retired an emulated non-branch instruction twice,
or counted it as a branch.

But as every VMRUN adds one to both counts, the difference between the
counts is precise.  When GLOBAL_CTRL is supported, i.e. when the
counters are enabled and disabled by the same WRMSRs, check that the
difference between the counts is the expected one, to catch KVM over- or
undercounting emulated instructions or branches unevenly.  It can't
catch KVM overcounting both events by the same amount, but the presets
and the ">=" checks already catch undercounting.

Only do this on AMD: on Intel without the overcount errata, the precise
checks already verify both counts, and with the errata the overcount
isn't guaranteed to be the same for both events (e.g. only instructions
are overcounted on some CPUs).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 x86/pmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/x86/pmu.c b/x86/pmu.c
index 06d4992daf710..3b35092465f09 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -818,6 +818,19 @@ static void check_emulated_instr(void)
 	else
 		report(brnch_delta >= brnch_exp, "branch count");
 
+	/*
+	 * On AMD, every VMRUN adds one to both counts, i.e. the difference of
+	 * the counts is precise regardless of asynchronous VM-Exits.  Check it
+	 * to catch KVM over- or undercounting emulated instructions or branches
+	 * (unevenly), which the ">=" checks can't.  Without GLOBAL_CTRL, the
+	 * counters are enabled and disabled at different points, i.e. count
+	 * different code.  AMD only, as VMRUN is known to add exactly one to
+	 * both counts.
+	 */
+	if (has_perf_global_ctrl && !pmu.is_intel)
+		report(instr_delta - brnch_delta == instr_exp - brnch_exp,
+		       "instruction - branch count");
+
 	if (this_cpu_has_perf_global_status()) {
 		// Additionally check that those counters overflowed properly.
 		status = rdmsr(pmu.msr_global_status);
-- 
2.56.1.911.g883d8bcb20-goog


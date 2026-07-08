Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE63E9F8E;
	Wed,  8 Jul 2026 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492557; cv=none; b=edUkLskgvnZTAFN6jGKLOAyOcyG7ANlrdb9bCZuUIoxbVET7ubS02p6OZgGAYHBxu6bLHx94STlt71van52OloCtDLT5+Ejm61/qwwT4G3/U4Ew12uThlG3+KT3RF28lk9A3R9sMriIksEo3PNJKRhGhfGcyOUto4/5ZDAUn/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492557; c=relaxed/simple;
	bh=GD2HUwHV6FlacV0TO2DqT91c+B/VT66bJDdQXiqDe6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBBQoZLVQkBhhBCH5itJUOCdQmwItt+U75Siq/+SfAaNkOR7yIdYMFRLTACyUnt36nGd3bhyhKZtHBOcHQYZ655B4VTRh+I2SHFLUxcz4YGNO7VRXHYC1dP/NoqNO8EVd4J760ZAbZoQTW1w6hOoiKADqHYQWI/8VkUNNMz8eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kltrn0QJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kltrn0QJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14EB1F000E9;
	Wed,  8 Jul 2026 06:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492555;
	bh=e2Jl9IhO+H6btfXnhPiqPRgSb4AnTnrnBO/xkgNcV0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kltrn0QJDVtLJ/dj1SpCzM11nXV2KXOT6ecP3T32WKPWW4UoTwEJ+y/tj54aXbYyU
	 kHjyWHZxI6TNTbchIRy+fpDw+p62pq9y88y/YPHOiwNflJQ7+i5xlxBXuSn6OQ8fjp
	 GaymRDI2VP0T37rYLXp9izWzihgqA+Qs7eXMU7hiwyPVZQs6033lhp9+Sa4vPw6YFA
	 JCnWq3N30ar6cH7JRSnu5JVe9c2pS1mIsIZn79sbsInkXsnx+2+BqHMp9CbwyZLkbb
	 j4RFHdq1BwcWAuadYSjWb8GxYfvIvLqWS8MpDosBVdEvmhZwkCi7rrYd3bGkc8K+1o
	 /2oIHWKX/4TQA==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 26/27] KVM: SVM: Do not intercept exceptions for Secure AVIC guests
Date: Wed,  8 Jul 2026 12:02:24 +0530
Message-ID: <45df41e4ea0473e4ab6bc0d1363281a0fbe23a47.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

In Secure AVIC mode, exceptions cannot be injected by KVM as the VMCB
EVENTINJ field is ignored. As such, do not intercept exceptions since
KVM will be unable to re-inject those back into the guest. The only
exception is #MC since that needs to be handled in the host, so
explicitly force-enable #MC interception.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 707537ad7271..7c9c25135df8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4862,6 +4862,22 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	/* Can't intercept XSETBV, HV can't modify XCR0 directly */
 	svm_clr_intercept(svm, INTERCEPT_XSETBV);
 
+	if (snp_is_secure_avic_enabled(svm->vcpu.kvm)) {
+		/* Clear all exception intercepts since we can't inject those */
+		for (int i = 0; i < NUM_EXCEPTION_VECTORS; i++)
+			clr_exception_intercept(svm, i);
+
+		/*
+		 * Note that #MC is always intercepted by hardware in Secure
+		 * AVIC mode, so mark #MC as intercepted to stay consistent
+		 * with the hardware behavior. From the APM:
+		 *   "In Secure AVIC mode hardware treats physical INTR, NMI,
+		 *    INIT, and #MC events as intercepted regardless of the
+		 *    corresponding intercept bit values in the VMCB."
+		 */
+		set_exception_intercept(svm, MC_VECTOR);
+	}
+
 	/*
 	 * Set the GHCB MSR value as per the GHCB specification when emulating
 	 * vCPU RESET for an SEV-ES guest.
-- 
2.54.0


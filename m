Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BA3DDB0E;
	Wed,  8 Jul 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492462; cv=none; b=hSw19tmCo0sxj1vBbTXvjYFnHArhXio8zr4rnoV1Qz0hVbsI7dCuEdafwGQiDModCtlTNWUEP1JlUEBUpOkgAJCGtHL+qgc+XBLGj6yG1GSgUZyZpow9HjpB9TZGyV64c1BLHyPRv3jGlkqJk4FOcyO1DJn5t2CXoid4PO3XsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492462; c=relaxed/simple;
	bh=pQ2+0O1/vUX7u8TDVGYLpnrk9m56Mj01Yedq74kQyEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OznQe0TB4VW0iXQU/0sCXU3TF5dDW8MLJRPHtcbUbPiGcxhQ0Y5ThcxaHRGMCCS73QahnA6LORKBykmsA9gVbRjVVltoqWnI18pEn5beEdPXNTU6OMLNIBQ41UpC50824UtqRObYVnWZWacWgWdc0TqAGrn2EVOH1Wy1aF+Xlls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbtgbG/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbtgbG/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778271F00A3A;
	Wed,  8 Jul 2026 06:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492460;
	bh=b3XVUn1BcohMxobMftKt1cHsXJU174KVxE8Yhs2OnyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbtgbG/TnA7qhDRiKRNez+B+MnX6gmhigRy2sbVrh4uzwLA5crWQ5ry2QBbkhdm9A
	 criZcg9MgPj3t2e5nVF05UA/feYHBf3EGaaWFTSsmmEIzsX99SQ6YeDQ0uyDHAtHHI
	 mAAcAI+HOdhZ6pqgHILR2aYzIDtPRwOpwy01i3u2Bdown6N670prTSXUw5kzT/NNhG
	 DHtJQuATO+NbVU73yKtJ0Baa/vA9nUTAIi3KjFDYiJ94s4Jf6Teep/hv/ni/1MOGyO
	 XBqG7qEqvNuBeOr3fFsDE/0NHxvUr8hCMxZLDbfOXaCBh7gxVU/UFcMMd0PgWh7U3k
	 oNlNt5knhIOZA==
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
Subject: [RFC PATCH v3 15/27] KVM: SVM: Set VGIF in VMSA area for Secure AVIC guests
Date: Wed,  8 Jul 2026 12:02:13 +0530
Message-ID: <3f1bcfa9416bc819dd42884af73a8b2f0265ebf8.1783490022.git.naveen@kernel.org>
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

From: Kishon Vijay Abraham I <kvijayab@amd.com>

In Secure AVIC mode, VGIF is read from the VMSA (vintr_ctrl field), and
the corresponding bit in VMCB control area (int_ctl field) is ignored.
Set this bit in the BSP's VMSA so that interrupts are not masked. It is
up to the guest to set this bit in AP's VMSA that it prepares.

Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Co-developed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 00cb45ce145f..f5b9ff69dbc1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1031,6 +1031,10 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 
 	save->sev_features = sev->vmsa_features;
 
+	/* Secure AVIC loads the below from the VMSA, rather than the VMCB */
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		save->vintr_ctrl |= V_GIF_MASK;
+
 	/*
 	 * Skip FPU and AVX setup with KVM_SEV_ES_INIT to avoid
 	 * breaking older measurements.
-- 
2.54.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC83CA4A0;
	Wed,  8 Jul 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492550; cv=none; b=fD6DamqXOd6Jg+7gsDkSyMLM5fJbUy2tzY4/xsE0YyJXWlUrOcGcq8gzHNq1SlrRWkKcF4VL+fUXYAsGwY517f4FO84mV9mbO9AKIK/Kfb9icfRpIUYRftm+WkHxfc2uo29kr4ogL+Vv+mcoMKXEPFQhXsD3NfyktJD9FGsmufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492550; c=relaxed/simple;
	bh=c9bbA9RyXuu+Ps2Z0b8eDDPYSMkd1CsemFwkCaVIilc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqPm4nQ0fLQ/qJPHCVZWEVhnNGNKBIEN4Sr4zxt1BMEV7T3lmmhM/cZA3lZ2Q9oBxevWmvQqepS7mXBmwkB0Kp8vSgS7XNEtOX02uFP/A/Onw+LCBS3maO9DEBmMz8LkpG8E/0jHyFefnrV5MJiLzefkdDTrR4537uQdTdEB0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doYMQE1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doYMQE1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AAD1F000E9;
	Wed,  8 Jul 2026 06:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492547;
	bh=Sh8YUQpSbmpUy27dbJK2lW0ckYc/Wp/oBmQeOGq7Kus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=doYMQE1+Eua8rc+zEb/s2Nyv7qYDjufFBmuHVGgFdb/zNkkNQ4j04EAwqrdSPe6TT
	 +U53qUxWadxNqaB0ib9I0GUb2QwdRKTFLq+OseB7+B4FeZhy4+9zRf9pLKAxrbRrah
	 ZRvXBWtSaAcOIWfQvtdMQnbPkCwHadkE2kLjdP1i2ivSfMEbEUdR4XixPERbTgc08z
	 fhqzOrXZN8U0DCDqn+KyPqC5wlsCofJ3ji5fgyrLP63jWOqul50d6Q8QJ1E2qny3am
	 6p3gF4fm3CmY6FyiXIFfC7Y+Z2Xq9Oh+PhJirfrZ5DIPu1Mkqx5KfpZ147/ClJHdSk
	 i7O6XVpBVK09A==
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
Subject: [RFC PATCH v3 24/27] KVM: SVM: Mandate use of split irqchip for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:22 +0530
Message-ID: <22e41ea530956c5e1673099b60981665c767a29a.1783490022.git.naveen@kernel.org>
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

Do not support in-kernel KVM IOAPIC if Secure AVIC is enabled. There are
two primary reasons (besides aligning with TDX):
1. KVM IOAPIC brings in PIC with no way to disable that. We can't
   support the PIC since there is no way to inject ExtINT.
2. KVM PIT in its default reinject mode can't be supported due to EOI
   acceleration (just like AVIC), but Secure AVIC can't be inhibited.

The latter is not an issue with userspace IOAPIC/PIT (reinject mode is
unique to the KVM PIT). For the former, it is up to the VMM to ensure
PIC is not advertised if Secure AVIC is enabled.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e3758c054783..525fa8834277 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -938,8 +938,17 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
-	if (snp_is_secure_avic_enabled(vcpu->kvm))
+	if (snp_is_secure_avic_enabled(vcpu->kvm)) {
+		/*
+		 * Secure AVIC can't work with the legacy PIC since there is no
+		 * way to inject ExtINT. Besides, we can't inhibit Secure AVIC,
+		 * so we can't really support KVM PIT in reinject mode.
+		 */
+		if (!irqchip_split(vcpu->kvm))
+			return -EINVAL;
+
 		vcpu->arch.apic->guest_apic_protected = true;
+	}
 
 	ret = avic_init_backing_page(vcpu);
 	if (ret)
-- 
2.54.0


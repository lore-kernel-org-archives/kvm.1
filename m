Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF53CDBC4;
	Wed,  8 Jul 2026 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492536; cv=none; b=gRznpxKpzp5yN0796IRsdknfOqpDS4znZwZ8tu9uDLlhRZc4soSt1LNcN/W7wKWcge2+7VWpOEOVOtMwMoErsVCaAg4r9pdgWlgwL0/pi/LEJXiGFZYoS7Mf/zBGwL8HS7uDkaUAaGnaufVkSl2VPxFPgsMTRRvp0bbOFFp44Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492536; c=relaxed/simple;
	bh=OVNN7iH74D7zXArKiHiZsI/YkPEXxLp7NSxnSlB7aNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrI1weTBPteEoa+5cJxvyFgBPV26wpDU4Mg7Jib/jvmdSDuMbb7SD1Nl8wiZp425oAfmqg8Tf/l/fzkP0F1plURLLKIdtxNL1Fl4a2UKbdHdR7DncmM4hFEuxZIg5zHIlSRt27uC2EL0trhQYYh2pqp4BuEzKErY/aRT2JinJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrZk82Uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrZk82Uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24821F000E9;
	Wed,  8 Jul 2026 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492532;
	bh=EyC4gURczQRoGKjn6B1m3F1pMENmql3UjOldI/ArK9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BrZk82UhcPzujG5ErZtc5jZvuby8+R84Ww2yoSONaBdD3eXUAtH/203Ke/hhNzjuo
	 B55HnxvB9w/Ud2aJWX0O73C7etufItAKGH9mJ9XsvgerxMHCWu90RlLUo9aD09UcZj
	 dtr5f59vvkXpJ1MK8UlXlssX0+Z6/CK7auCgakCwQilw6WJ0p9MdTdb24qS52TiIuB
	 b7sK6R5lv0quLDTAB5/pxzQQvCj3wf0cAuojRg6C9h4oDFPogMx7plgk9PMSMGkiOm
	 vgkDUBYJvpiOu69YX/YrnMaOkdt0MPHttavIL5+SueNv7rIpjb++rpOd9co9qMdA0n
	 j+mb90rBbc6nQ==
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
Subject: [RFC PATCH v3 10/27] KVM: SVM: Add avic_ipiv_is_soft_disabled() as a wrapper around enable_ipiv
Date: Wed,  8 Jul 2026 12:02:08 +0530
Message-ID: <cb1d2b9a3fb82984e04fe57d882500afa2ad9c40.1783490022.git.naveen@kernel.org>
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

enable_ipiv is used to disable AVIC IPI virtualization in software to
address hardware errata related to IPI acceleration, or because the user
chose to disable it manually through a module parameter. In either case,
AVIC IPIv itself is available in hardware and AVIC requires setup of
related data structures. To distinguish this from Secure AVIC mode which
completely lacks support for IPIv, add a helper to clarify the true
nature of this knob, which is to soft-disable IPIv.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 9b4d3a10198b..c9e375c5a9c1 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -67,6 +67,15 @@ static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_IDX_MASK) == -1u);
 
 #define AVIC_AUTO_MODE -1
 
+/*
+ * IPIv is supported, but software disabled due to erratum, or because
+ * the user turned it off through the module parameter.
+ */
+static bool avic_ipiv_is_soft_disabled(void)
+{
+	return !enable_ipiv;
+}
+
 static int avic_param_set(const char *val, const struct kernel_param *kp)
 {
 	if (val && sysfs_streq(val, "auto")) {
@@ -1092,7 +1101,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 	 * Keep the APIC ID up-to-date in the entry to minimize the chances of
 	 * things going sideways if hardware peeks at the ID.
 	 */
-	if (!enable_ipiv)
+	if (avic_ipiv_is_soft_disabled())
 		entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
@@ -1150,7 +1159,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
-	if (enable_ipiv)
+	if (!avic_ipiv_is_soft_disabled())
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	/*
-- 
2.54.0


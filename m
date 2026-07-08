Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F53E5A09;
	Wed,  8 Jul 2026 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492521; cv=none; b=HfkCg424TvHvYdxeL8izNue6cxeyOA+rDEs2cyt5nFldUm1+AA/ckoZi1bk60Z4XwS5WCzpKYiA+xQy80v/aUU8+RPz8LOtDEeF9Sh9nbQFX8NONaLBCHqF/knExtC7sP+jJSK9m12/raV4Mvm3R3QY5lF+zlnOuKtwxiCaOj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492521; c=relaxed/simple;
	bh=Tx1hg6gev+cvUMAi7DdXpSHcI8/OsdmyAaF3XsV9Z8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCxP9Wz9DglOcCOrvmou5QPhG7b38zVhkBHb5h4jTn86cCTKwPJ10Lp+8Qj0P87uh3CLj4K12zQq/2Iye2ifqshx7486YmRoLzradiDNK7TYjem335ClVktIUiGaS7ijsaMG0lW/4+Nm1f1/Xj0YpuKABEpa58zS7laqUIrxEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVUMrYkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVUMrYkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6911F000E9;
	Wed,  8 Jul 2026 06:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492518;
	bh=0Ev9km8VaGfxmvNKs+MpPQzyQA7KptnJgPXV+E9Qa+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YVUMrYkDbRjzGvapccqfGcpYpi+U9VQ/dWJWAy0E2NVPt4KBrn0vt0YaZlTm1VYr5
	 RV/FaLOP5jn8tdxGKl95CXKqL+yYKf7HbDh+rNfYn33cmszxA4JsjUJoT7edYuUtxG
	 brSi1aKDJqILKeVDuxoo91MT7l5flZPBNpKkvOP7akxeNfIeKcG+NBtHTCLAMfmEzW
	 zu7i9q3nSBFytV/+tVHrGBToRTzsdSAqLC8lVIr2TQEhOfD9Tgj7sQCgUsdCvrEYmz
	 lobnFCoaD3UrIFoCn7aXmtZX+He00RhSYvi3pk5DkYZ/oHgmUDjM7GwcKSWda/Uguy
	 1GelNLpxUB7BA==
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
Subject: [RFC PATCH v3 07/27] KVM: SVM: Set guest_apic_protected if Secure AVIC is enabled
Date: Wed,  8 Jul 2026 12:02:05 +0530
Message-ID: <b9c1e0c8b5d81dce1cc58f6e7e536c89535e4fd0.1783490022.git.naveen@kernel.org>
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

Mark the guest APIC as protected if Secure AVIC is enabled.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c5b1d294b15a..7340c9e251e0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -884,6 +884,9 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
+	if (snp_is_secure_avic_enabled(vcpu->kvm))
+		vcpu->arch.apic->guest_apic_protected = true;
+
 	ret = avic_init_backing_page(vcpu);
 	if (ret)
 		return ret;
-- 
2.54.0


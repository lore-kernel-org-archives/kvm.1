Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E053E1233;
	Wed,  8 Jul 2026 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492542; cv=none; b=M8daA4Uh76iLBoV1UgeMLc4odG36iJVcmd+TWRizmuVwV73ZCEfUZXSGIAfnV9PEMY+TxsYudhFqAC12tLBDOx3+qhdbHxJqD+M3rbw3imVXiji0Rpa7Nbb0+pj0NUKbBvHf7Up/b57pUAaXqJTbtY8PSSimYlWhYYL55uqU88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492542; c=relaxed/simple;
	bh=iR31i42jPvWxEBrDXkLYBzjaFhH50J+zeXzmWErTtUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+MSWr82ZgLpYNX2NBDFbqqC91Qxqr64AcB3gbFHd20wLg0AqpHM2CYrAaswIv/aNMAdVA3NcK/q7TWa+9mKCPLACV6tCtts8Cw6jkRuJRkOHk8DatZ4YPdb5NgdpFTCzEcOsaQHayTevTlt45HgIlwHQoqq8juSiqOHcsFaxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5XHQF0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5XHQF0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F01F000E9;
	Wed,  8 Jul 2026 06:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492538;
	bh=PA8F1W7llGaOJi7r9r5rWMqSe3373z1as7VGI4CJ2vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5XHQF0ndIGTP3p8EJURObIxpJDUiOP0V/KlazC93DxE79dC6+H9HmXA+g1FmGLfL
	 JyWLdcUAnmEqVVCyU6aE3daBsW90iOzXF0dZvifcCgBFG6nI/nhCgWGoIek0ZonCfF
	 WPm0eDaaP4MvsD3MIpBGY5Mrd+YJMrTVsXb1s1EaIgyjHnyUEe13yncCN4sBOGlnXM
	 O9DfYfJoGDOmQZ8+x4YNBVlmac1jIBPkhmrLYnZXte05dQyA+4yiRy5dND6oQGpWdZ
	 WLo51dMEOeh8IawQM9alCYcM6GHk69KXoNWwUALvvxj7DBjoZ+/ixLveqHuUkFN9bf
	 8FwoYbK/ouCAQ==
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
Subject: [RFC PATCH v3 01/27] x86/apic: Propagate APIC_SPIV writes to hv for Secure AVIC
Date: Wed,  8 Jul 2026 12:01:59 +0530
Message-ID: <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>
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

Hypervisor needs to be aware of the VAPIC's APIC_SPIV state for
LVT masking/unmasking. So, propagate the guest's APIC_SPIV
writes to the hypervisor.

Fixes: c822f58a4fab ("x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver")
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/kernel/apic/x2apic_savic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index dbc5678bc3b6..cb3b55225ab6 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -214,7 +214,6 @@ static void savic_write(u32 reg, u32 data)
 		break;
 	case APIC_TASKPRI:
 	case APIC_EOI:
-	case APIC_SPIV:
 	case SAVIC_NMI_REQ:
 	case APIC_ESR:
 	case APIC_ECTRL:
@@ -223,6 +222,10 @@ static void savic_write(u32 reg, u32 data)
 	case APIC_EILVTn(0) ... APIC_EILVTn(3):
 		apic_set_reg(ap, reg, data);
 		break;
+	case APIC_SPIV:
+		apic_set_reg(ap, reg, data);
+		savic_ghcb_msr_write(reg, data);
+		break;
 	case APIC_ICR:
 		savic_icr_write(data, 0);
 		break;
-- 
2.54.0


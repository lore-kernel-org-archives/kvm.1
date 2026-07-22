Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4C42FCC9
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710952; cv=none; b=LtjwHPLMnxdJXlXLaqpSr/nDRQ5maGk1m+7C1xmCW+Is1g6MzNACz4ixWZQZiu8xTRDSfswBnow/zADj2pRhqM4PjpO5og1jQ+GXGkgUwWyqGrAyQxY1eNAuWZy1YE1460vRu/DrrgJ/N3qz/CRwIkTBIoPdQ/r7pcLwAkYPRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710952; c=relaxed/simple;
	bh=saTFwzZvLCE4/uXSR0koNnODP53mQ0MBMHx7YYN6M2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qny+AJIVaw5vu7wZO7OmQvfyPHSOwM1FmJVwli6TXakObeD6Bc49tpuYfV4ob9iAvdchhkoD02qm+YUk570Y2tqu+GKWiBsfD1sKvFXK5zHIgajhrlHZzZjZcnu6CkG/PhnQ+wbEoFcsUOKIHTBP1s3uezzJ5TThv80gSp+U2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=LDbdr3rh; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="LDbdr3rh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VvcHkFUOc73uwG/vA8ptfkg/bY1UZNlRLMt5NHLH7zo=; b=LDbdr3rhACDAV1qWSpMakpBNqI
	RR6an53k6huEgEUdpR/ZsmUCZGSbx8gDs+W54pH7VT3OMcOsxrOYR7hdlTrn4mu1I+Op+mCs6seem
	UdnoKwZfGcag1EO/X6XrJWbosBd7nxm2AfB5BBbFjaVBjzwOfYi0miLn0RJAhuh6mNkxdsiOSll0r
	ITiACkURu9pPQ6WwSXM8baYThGSGlIOCXmtaB1n9yVjthsqRExtxb9byUqzUO9HKjWn2jSTiZ8cTl
	Z0qMvh0YH6ZAnDJzLgLqTJDlQQr2jO2MQrr0ZeM6bZR5ecc+0f8nBw0ko+fJD64AODMVWHCrS9Wwo
	lvQ1BzHw==;
Received: from mailer.gwdg.de ([134.76.10.26]:54020)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wmSbk-00D6yZ-26;
	Wed, 22 Jul 2026 10:47:16 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1wmSbk-0004cj-1x;
	Wed, 22 Jul 2026 10:47:16 +0200
Received: from eftekhar-ubuntu.tu-dortmund.de (10.250.9.199) by
 mbx19-gwd-01.um.gwdg.de (10.108.142.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 22 Jul 2026 10:47:16 +0200
From: <amirmohammad.eftekhar@cispa.de>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, <rossow@cispa.de>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH] KVM: SVM: use wrmsrq_safe() when writing the nested TSC ratio MSR
Date: Wed, 22 Jul 2026 10:47:02 +0200
Message-ID: <20260722084702.1028983-2-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
References: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-SUB-07.um.gwdg.de (10.108.142.72) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

__svm_write_tsc_multiplier() writes vcpu->arch.tsc_scaling_ratio to the
physical MSR_AMD64_TSC_RATIO with a plain wrmsrq().  Under nested TSC
scaling the ratio is a composed value (see the companion x86.c change),
and a composed value can set bits above the MSR's 40-bit width; those
are reserved bits that architecturally fault (#GP) the WRMSR.  Today
only the EX_TYPE_WRMSR extable stands between a guest-influenced ratio
and a host #GP oops in ring 0 -- on a build or path without it the host
faults.

Do not depend on the extable for a guest-influenced MSR write: use
wrmsrq_safe(), and on failure keep the previous ratio (don't update the
current_tsc_ratio cache) and warn.  Defense in depth alongside bounding
the composed ratio at its source.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/svm/svm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4d2bacd00ec4..d7f2202b7c45 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -533,7 +533,18 @@ static void __svm_write_tsc_multiplier(u64 multiplier)
 	if (multiplier == __this_cpu_read(current_tsc_ratio))
 		return;
 
-	wrmsrq(MSR_AMD64_TSC_RATIO, multiplier);
+	/*
+	 * multiplier is derived from the guest-influenced nested TSC scaling
+	 * ratio and can, on a composed nested value, set bits above the 40-bit
+	 * MSR_AMD64_TSC_RATIO field.  A plain wrmsrq() would #GP in host ring 0
+	 * (caught only by the WRMSR extable); never let a guest-influenced
+	 * value fault the host MSR write regardless of the compose bound.
+	 */
+	if (wrmsrq_safe(MSR_AMD64_TSC_RATIO, multiplier)) {
+		pr_warn_ratelimited("SVM: rejected out-of-range TSC ratio %#llx\n",
+				    multiplier);
+		return;
+	}
 	__this_cpu_write(current_tsc_ratio, multiplier);
 }
 
-- 
2.34.1


Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7A27FB0E
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058933; cv=none; b=jAssdUcGeyoDK11B412+CQDt0m8lC/1fuHg6kP8aFY52wJZ9SU76BAJHOSqC7L+AjGYNXm7/Q+zVUtBIE0WvCYuXJXnZjDA2ozUaYKkU/eUDpDoGoOETDBQnD17b0DhekUDFQUrbwzg7GEWwy5kv8aZGRWKjq7U+KJg7+paZ/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058933; c=relaxed/simple;
	bh=PBPUvazHcWjYuzbD3d/xPveShQgYTtGXgb+VilZmCtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnOVFbnnuC8x6abEwUSUL9FRCzZ6mFhu6so0vfAwMZlUDHx3qJilLYSaBa5P7dixN+DhgBafEOzxQL6O7O1mFeeUXIlPLRZOhekFIOxrAjPtn/zAuZeEyOKOOUiAjMwrPX9hum0RMiUkKUydEnNJSMauWWh0KZejACYKuxYwF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1781058917-1eb14e680cbe4c0001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id uXWxQEIah6IBk494; Wed, 10 Jun 2026 10:35:17 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP33dd185c0c2bccb26bbc09eae7285086
	Wed, 10 Jun 2026 10:35:16 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.24.2
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH v3 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Date: Wed, 10 Jun 2026 10:35:11 +0800
X-ASG-Orig-Subj: [PATCH v3 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Message-Id: <20260610023512.3690734-5-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1781058917
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2348
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -0.96
X-Barracuda-Spam-Status: No, SCORE=-0.96 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64, FROM_EXCESS_BASE64_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.159832
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily
	1.05 FROM_EXCESS_BASE64_2   From: base64 encoded unnecessarily

Advertise the Zhaoxin PadLock Hash Engine v2 to guests via CPUID
0xC0000001 EDX bits 25 (PHE2) and 26 (PHE2_EN). PHE2 extends the
PadLock hash family with SHA-384 and SHA-512 support per FIPS 180-3,
complementing the existing PHE feature (SHA-1 and SHA-256).

Two unprivileged instructions are exposed, documented in the Zhaoxin
PadLock Instruction Reference, chapter 3 ("Hash Engine"):

  - REP XSHA384 (encoding F3 0F A6 D8, subsection 3.3)
  - REP XSHA512 (encoding F3 0F A6 E0, subsection 3.4)

Both consume software-padded 128-byte blocks (RCX = block count, RSI =
input, RDI = state) and produce hash output in the state buffer.

Both instructions are unprivileged (no CPL restriction) and available
in all CPU modes, with no associated MSR control. The PHE2 and PHE2_EN
bits are redundant by hardware design (set or cleared together) and
both serve purely as CPUID-level feature-presence reporting flags
requiring no KVM emulation. Both bits are advertised because different
software may probe either one when checking for PHE2 availability.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e264758d58e2..3702d7a30ae6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -152,6 +152,8 @@
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
 #define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
 #define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 087c41341240..3fb81f7a6107 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1288,6 +1288,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PMM_EN),
 		F(RNG2),
 		F(RNG2_EN),
+		F(PHE2),
+		F(PHE2_EN),
 	);
 
 	/*
-- 
2.34.1


Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C81465B4
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058926; cv=none; b=IDPD/GgOj/ZzSmjQxCMbshr9xaK8LqhB412fhQR4KqtU8479MDX0WmiLrf/dXmWVAwKMZ0W9HOW370ntzCQLM8Tyk2RQMOnL4N6bvlKCrH1tXYXjIdzW2DgIJ5uvwlJIGgdopbZjh8h5qMDurCln1hK1JgIp+IH0ZbUfTS6lcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058926; c=relaxed/simple;
	bh=LvqXSc8Xfn7hVMcvUPCj9ztTXe7ul5Dmd8/EQMyHN3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLCGeyPzzRFOEIrpMhe1wKJVVmIgMfqAZxb0JOirBHp7M+2Md+6SrrgnAl9cxTu9cp9KI5STuC00Xv/jBcKsEUZ15tMuE7bQXYHX8UhsYw/kT80EifHuNnFs0xiZ6Gs10IJabczNjuS0tThUnT4n5hth23A22seKNpvAeQdZrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1781058916-1eb14e680fbe4c0001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id cWXyKrrqdIwGy6UD; Wed, 10 Jun 2026 10:35:16 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP179db99e0c2d20671b9b939d8b475086
	Wed, 10 Jun 2026 10:35:14 +0800
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
Subject: [PATCH v3 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Date: Wed, 10 Jun 2026 10:35:09 +0800
X-ASG-Orig-Subj: [PATCH v3 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Message-Id: <20260610023512.3690734-3-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Start-Time: 1781058916
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2627
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.01
X-Barracuda-Spam-Status: No, SCORE=-2.01 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.159832
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily

Advertise the Zhaoxin CCS (Chinese Cryptography Standard) feature to
guests via CPUID 0xC0000001 EDX bits 4 (CCS) and 5 (CCS_EN). CCS groups
two unprivileged instructions for Chinese national cryptographic
primitives, documented in the Zhaoxin GMI Instruction Set Reference,
chapter 2 ("CCS instruction group"):

  - SM3 (encoding F3 0F A6 E8, subsection 2.1) implements the SM3 hash
    algorithm specified in GM/T 0004-2012. It supports two modes
    selected by RAX: auto-padding stream mode (RAX=0) and pre-padded
    block mode (RAX=-1).

  - SM4 (encoding F3 0F A7 F0, subsection 2.2) implements the SM4 block
    cipher specified in GM/T 0002-2012, supporting ECB / CBC / CFB /
    OFB / CTR modes via a control word in RAX, and CBC-MAC / CFB-MAC
    when RAX bit[11] is set.

Both instructions are unprivileged (no CPL restriction) and available
in all CPU modes, with no associated MSR control. The CCS and CCS_EN
bits are redundant by hardware design (set or cleared together) and
both serve purely as CPUID-level feature-presence reporting flags
requiring no KVM emulation. Both bits are advertised because different
software may probe either one when checking for CCS availability.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 20b33413189c..276e4ef90bd0 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -140,6 +140,8 @@
 #define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
+#define X86_FEATURE_CCS			( 5*32+ 4) /* "ccs" SM3 + SM4 instructions */
+#define X86_FEATURE_CCS_EN		( 5*32+ 5) /* "ccs_en" CCS enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
 #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enabled */
 #define X86_FEATURE_ACE2		( 5*32+ 8) /* "ace2" Advanced Cryptography Engine v2 */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1eb4b88aaa80..8aaa3f20670e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1276,6 +1276,8 @@ void kvm_initialize_cpu_caps(void)
 		F(SM2_EN),
 		F(XSTORE),
 		F(XSTORE_EN),
+		F(CCS),
+		F(CCS_EN),
 		F(XCRYPT),
 		F(XCRYPT_EN),
 		F(ACE2),
-- 
2.34.1


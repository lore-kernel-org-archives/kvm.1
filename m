Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C027E1DC
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058935; cv=none; b=byOiug4b2P8oQqAY9uId6tzX0ba8PqGeDEJn81nM5nkOFSht+Wytv1wXYTizL5Zr2MKzv6++0xf76C3U6eeXNONrRHGULPY+cIZwRQRXPEiavw69hGwJ+2Sg+LjP+Jrtu5ylFr4rtwETlOXXDPEojGKY3uym9VoW/n2au5LpGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058935; c=relaxed/simple;
	bh=Nc2fshPyr/aIhu+foihGacIoeXNaC2kfdR68oN3KEPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQzQSLVML0p30xWq+DkrNAYHphtm+HD7b/AAWR1wp/kAHJ95Zf7xxE4bDuJ7q8JlBAAa9ZrKWwTrdVfUcdgL+/2GHS2kqcLdlvSsLgEdlepVE4LjELBgw+pNaBD7Udv80+D0ZjhZUxcWfR3ik1Rw+wy0ClM4C9WOzWENNzn640k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1781058918-1eb14e680bbe4c0001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id Sffz6uBDLIQ0rpSp; Wed, 10 Jun 2026 10:35:18 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP927a0bf868a4e13f73f06f3ff2305086
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
Subject: [PATCH v3 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Date: Wed, 10 Jun 2026 10:35:12 +0800
X-ASG-Orig-Subj: [PATCH v3 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Message-Id: <20260610023512.3690734-6-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Start-Time: 1781058918
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2490
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

Advertise the Zhaoxin big-number arithmetic engine to guests via
CPUID 0xC0000001 EDX bits 27 (RSA) and 28 (RSA_EN). The RSA feature
provides two unprivileged instructions for modular arithmetic on big
integers, documented in the Zhaoxin PadLock Instruction Reference,
chapter 4 ("Modular Multiplication and Exponentiation Engine"). Both
support operand sizes from 256 to 32768 bits (in 128-bit increments):

  - REP XMODEXP  (encoding F3 0F A6 F8, subsection 4.1) computes
    A^B mod M
  - REP MONTMUL2 (encoding F3 0F A6 F0, subsection 4.2) computes
    A*B mod M

REP MONTMUL2 is the long-mode replacement of legacy REP MONTMUL, which
is restricted to compatibility and 32-bit protected modes. These
primitives accelerate RSA and related public-key operations.

Both instructions are unprivileged (no CPL restriction) and available
in all CPU modes, with no associated MSR control. The RSA and RSA_EN
bits are redundant by hardware design (set or cleared together) and
both serve purely as CPUID-level feature-presence reporting flags
requiring no KVM emulation. Both bits are advertised because different
software may probe either one when checking for RSA availability.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3702d7a30ae6..a769c83588f7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -154,6 +154,8 @@
 #define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
 #define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
 #define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
+#define X86_FEATURE_RSA			( 5*32+27) /* "rsa" Big-number arithmetic */
+#define X86_FEATURE_RSA_EN		( 5*32+28) /* "rsa_en" RSA enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3fb81f7a6107..94ea9abae566 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1290,6 +1290,8 @@ void kvm_initialize_cpu_caps(void)
 		F(RNG2_EN),
 		F(PHE2),
 		F(PHE2_EN),
+		F(RSA),
+		F(RSA_EN),
 	);
 
 	/*
-- 
2.34.1


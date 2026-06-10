Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81822A80D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058927; cv=none; b=HZCwio9QTuENfj+GWbc1N1+AHLrth8OWGbuNviWQ+NfcVxuTp9keQB6kpNO6ZrxIMfP3SONzSjg6SPZ1nREUx5u7NCfotAPW0UilrF8wKHPHzIdgcE6aUhAVPF/cOwRBDf8r0P+YpzSIR3hFx+WkTPxeWPuEti0rkEgkeNFFcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058927; c=relaxed/simple;
	bh=wy4VcW6zxfvNKRMWS0eZrwqMtBovB3dxMFw7xrcEszU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBALS4NCFqoaVIdfSPRKQFs/VaE6YC4PsASgpbbITex4OyA/75cK4JzplXe5wSwXeYsVtBnSD+gGHiuedN6K5P2ApdpiASRH6RngvdMpJWSwxIzC1619RYJ1Zh4DQhpjwaJYhlbZeQQl3vL/bNkdhZ5GBOdicqoJEcXhiZ3V17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1781058915-1eb14e680bbe4b0001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id 0cbQqoMVIOfBTmEx; Wed, 10 Jun 2026 10:35:15 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP4ad870936500fb2b95ecb346b7f35086
	Wed, 10 Jun 2026 10:35:13 +0800
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
Subject: [PATCH v3 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Date: Wed, 10 Jun 2026 10:35:08 +0800
X-ASG-Orig-Subj: [PATCH v3 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Message-Id: <20260610023512.3690734-2-ewanhai-oc@zhaoxin.com>
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
X-Barracuda-Start-Time: 1781058915
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2646
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

Advertise the Zhaoxin SM2 instruction support to guests via CPUID
0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).

The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
elliptic-curve public-key cryptography algorithm specified in
GM/T 0003-2012; the hardware-level behavior is documented in the
Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
instruction multiplexes its sub-functions on the RDX[5:0] control
word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
signature verification (1.4), the three key-exchange sub-operations
of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
uses for the initiator's ephemeral key; 1.5.2 responder shared-key
derivation; 1.5.3 initiator shared-key derivation), and two
preprocess steps for identity and message hashing (1.6.1 and 1.6.2).

The instruction is unprivileged (no CPL restriction) and available
in all CPU modes, with no associated MSR control. The SM2 and SM2_EN
bits are redundant by hardware design (set or cleared together) and
both serve purely as CPUID-level feature-presence reporting flags
requiring no KVM emulation. Both bits are advertised because
different software may probe either one when checking for SM2
availability.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1d506e5d6f46..20b33413189c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -136,6 +136,8 @@
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a hypervisor */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_SM2			( 5*32+ 0) /* "sm2" SM2 algorithm */
+#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..1eb4b88aaa80 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
 
 	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
+		F(SM2),
+		F(SM2_EN),
 		F(XSTORE),
 		F(XSTORE_EN),
 		F(XCRYPT),
-- 
2.34.1


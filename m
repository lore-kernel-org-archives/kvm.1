Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE5212542
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058928; cv=none; b=sDai/D45gAJR62wNgmuoWIYbLCxV6Ivmzjq0iO2K1tfK9RiRjV622YoAAjCRN4142i4pvPLY9hqpkLFUUSmF+D76xUKWN9ES39ODtDs5daOLZUVZcQjSozHz6IkpbJ5ck+XYjk/JJ0dQx/2CAIgSbAuYE2rD10ainSOIS/yOpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058928; c=relaxed/simple;
	bh=Lk0Dz4WL2rPPV8moSrCrsDWWP3Q4jBlbl3Yddurgel0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1G9FTrjTKFyIbODiGMYp9/7kLwI9Nve6mXCLCSsk3wPnTsH4gKuLRtyB5XW6MzNwyBn7xy3vEjaK3VM2A3Kx24dKyqbxkmKdk7+LuqvaDnZ1Qz8bwTi5bznfmf4GgaD6ZMu+1hNk70dXqnVQjwKqSwyY/xe9MTl4QAjGeab+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1781058914-1eb14e680cbe4b0001-HEqcsx
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id bWuE7flB2poELNDB; Wed, 10 Jun 2026 10:35:14 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net [10.28.24.2])
	by zhaoxin.com (8.30) with ESMTP546d6cfc54161ac63bf8f7ac75d45086
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
Subject: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Date: Wed, 10 Jun 2026 10:35:07 +0800
X-ASG-Orig-Subj: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Message-Id: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1781058914
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3457
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.01
X-Barracuda-Spam-Status: No, SCORE=-2.01 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.159832
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily

This series exposes five groups of Zhaoxin-specific CPUID 0xC0000001 EDX
feature bits to KVM guests. Each group corresponds to a category of
unprivileged cryptographic or RNG instructions that have been present in
Zhaoxin processors but not yet advertised by KVM.

All instructions covered here are unprivileged (no CPL restriction) and
available in all CPU modes (real / V86 / compat / protected / long), with
no associated MSR control. Each feature is reported as a (X, X_EN) pair
where the two bits are redundant by hardware design (set or cleared
together), and both are CPUID-level reporting bits requiring no KVM
emulation.

The five feature groups:

1. SM2 (bits 0, 1): SM2 elliptic-curve public-key cryptography algorithm
   per GM/T 0003-2012. Used for key generation, encryption/decryption,
   digital signatures, and key exchange in Chinese cryptographic
   standards.

2. CCS (bits 4, 5): SM3 hash algorithm per GM/T 0004-2012 and SM4 block
   cipher per GM/T 0002-2012 (supports ECB / CBC / CFB / OFB / CTR plus
   CBC-MAC / CFB-MAC). Foundational primitives for Chinese cryptographic
   protocols.

3. RNG2 (bits 22, 23): Second-generation hardware RNG exposed via the
   REP XRNG2 instruction. Two on-die RNG sources selectable per call,
   with raw and post-processed output modes. Provides high-quality
   entropy for cryptographic operations.

4. PHE2 (bits 25, 26): SHA-384 and SHA-512 hardware acceleration per
   FIPS 180-3, exposed via REP XSHA384 and REP XSHA512. Used by TLS,
   SSH, file integrity, and signature schemes.

5. RSA (bits 27, 28): Big-number modular exponentiation (REP XMODEXP,
   A^B mod M) and modular multiplication (REP MONTMUL2, A*B mod M),
   supporting operand sizes from 256 to 32768 bits. Used for RSA and
   related public-key operations.

References:
  The instruction encodings, control-word formats, and per-feature
  semantics referenced in the individual patches are documented in:
    - GMI Instruction Set Reference (SM2 / SM3 / SM4)
    - PadLock Instruction Reference (XRNG2 / XSHA384 / XSHA512 /
      XMODEXP / MONTMUL2)
  Both available from https://kib.kiev.ua/x86docs/Zhaoxin/

Changes since v2:
- Replace the remaining "user-mode" wording with "unprivileged" in the
  patch 2 (CCS), 4 (PHE2), and 5 (RSA) commit messages, per Binbin Wu's
  review.
- Add Binbin Wu's Reviewed-by to all five patches.

Changes since v1:
- Move the X86_FEATURE_xx definitions from arch/x86/kvm/reverse_cpuid.h
  into arch/x86/include/asm/cpufeatures.h, filling the unused bit
  positions in word 5 (which is reserved for CPUID 0xC0000001 EDX),
  per Sean's review feedback.
- Tighten wording in each commit message: "user-mode" -> "unprivileged
  (no CPL restriction)", since the instructions execute at any CPL.

v2: https://lore.kernel.org/all/20260528032234.1322565-1-ewandevelop@gmail.com/
v1: https://lore.kernel.org/all/20260513124846.1622462-1-ewandevelop@gmail.com/

Ewan Hai (5):
  KVM: x86: Expose Zhaoxin SM2 CPUID feature
  KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
  KVM: x86: Expose Zhaoxin RNG2 CPUID feature
  KVM: x86: Expose Zhaoxin PHE2 CPUID feature
  KVM: x86: Expose Zhaoxin RSA CPUID feature

 arch/x86/include/asm/cpufeatures.h | 10 ++++++++++
 arch/x86/kvm/cpuid.c               | 10 ++++++++++
 2 files changed, 20 insertions(+)


base-commit: 50897c955902c93ae71c38698abb910525ebdc89
--
2.34.1

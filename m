Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC3421EE8
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676535; cv=none; b=nUDUM7+GLV9ULJuyLpsGA8fC+n/oZKUjkgWPNO0XgR0K9kvctNp03gPTc7ZE9p0V8ygsvw/dt51lbkym7xjxI3i5MVN0MFdBQRPP0LAdj15UcXjwLalS2JyGXzvhxodmn2fhWBpxY5DyNP0pqCUKZEdsH701TcdM5Pb+1kNcqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676535; c=relaxed/simple;
	bh=aZyLfBGopL0QGvNVnnuQ0iptBrTpLGR9vFh7tXx3zsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGRsQa91wypUtf+UdbIe6arWfhZpUIXyNGpkQoIaxn6bc4mRVGV7SN57di7Rud/nIM+3Gfr7pZ22n0QXgMZTxI/4TArYwzoEBLvsNU4SS6e9cv6JgHko29Yvp6EHaU4dGBP2F+nR717morrA74jc3529NQ0a70zZaLHZq9v0No4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH/jjaH1; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH/jjaH1"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13354eb66baso2659793c88.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676532; x=1779281332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByktUNvjJyp/tVC7zVVMY3FW0HTxNuLUSrPRR6QCBAY=;
        b=dH/jjaH1iFHk6eDHDoWQc14NZYMgu1hET+pL4tOA4jokuzXhhWlXTxlMda8k7cBXaZ
         nqd7UwCxH04JgNI+q8SkFZAU17BTozs5kRzNd+/XhnQoCbc0GQKZ9j/nTHcOB/+lv+Kb
         TpVcimgwHtkX6PDfVStuTCi9vS6/U6MLAcQFgQ1tyqhVi3jPKfTgdDCHd7qC9lx+5SsY
         BlD/OcRS58meQIOSyrBzVId0Z/olw76By/RmKaSSrZqBF6/XcTWK8nVxZeWlrOcLguHp
         KHhhM/dT0kec/1dFzyigHu6/y8FB2ok1aumzUKzU6H/jhkCeMoskgoC940r7IlYUrC+e
         Qw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676532; x=1779281332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByktUNvjJyp/tVC7zVVMY3FW0HTxNuLUSrPRR6QCBAY=;
        b=NQ7A0yDIOxXnBMCUI7vPrsteI7w0MbvVVsXto65WDU5P9Vp7QL3KpjverhgUVIvEwe
         mm2SiuIqJACY/6ozkaBQVDc37TWGz7dAGu9YMjbRoNBLUjNK8m2Dw9a6EIr1lzYa5q5b
         JUMStBn/R9AQ690kAqV0GBYXOQbxl60yfKKcO/f5TBX8M8wOCF69ujX8FLdwVS5M3ygF
         F75jfzZfT803j51E+4K14wVA3pssA2uWX/OsCH+MNHix7JWlZrDhujEwOkhFGmNylNKn
         /OYy8AvzfK0abIekzfSoFs2zYALpnRns2EOO1B4IOK4N8G4DiOqJI+QzLf8BAJTFaovK
         qykg==
X-Forwarded-Encrypted: i=1; AFNElJ+7ZkduWZfdeF1fagA99zxY6Qi+TzgdFCu2dUiqmvXBR4Vbnsd8GMvMJygVUQPbukChKIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQ6/CXR75CgJE4yM32xseu3NRhjkRvfvD5JM/YOCGy5RMzfhq
	YF1L+k5jsmXDZFLO4o2IUZ7Z19YmGHCVYuit2ewFa3ZQboefkW3xqeWT
X-Gm-Gg: Acq92OEs4mLoVIiwv1+Gx+Dl4H+AhM1qqMfqe3scQ9/PMJ7hRhACO/2o7nImqlw5OiF
	IMmeaFvZWBEzvt9PMYH/l5o+hWAdJWNnGOLtOPKPvmZ/5/J76+POhLrILSItR/1v90Rnwfhyy3u
	EXc/Bad8Te5HK8TCJXmtjH2Z+njveG+iaMAzLou5Nv7mH8/tL1WIj+rQe1P+ZZq0MsbR4mWqpXh
	O1N1v8vYOszeFQW6YRS3/XPSjIpoMg+bV+xRf5Yp0AntmuKQMzEzZR4uRc1J4KGXfrN8hqFR9OQ
	HOCjlUjCfP/zSWHgjbFMQNHU/w11Ac9mAMTo4mg+uoPvbKsEbUcpeCSsOK7P2ub8ZsNE7oJqsD6
	ggQOX/a/v0G4r9heBK75PsCkDOTvdkYaW8kxNlrPbuUiMSydakNAKpN5XLjiAVODnstX+Jgfxzf
	kAszc1BAGUaD5wNbnGT/5X2zthulvMIYxItwcl7G4b
X-Received: by 2002:a05:7022:eacc:b0:130:7246:10aa with SMTP id a92af1059eb24-13431940533mr2131481c88.12.1778676531933;
        Wed, 13 May 2026 05:48:51 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm1066142c88.12.2026.05.13.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:48:51 -0700 (PDT)
From: Ewan Hai <ewandevelop@gmail.com>
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
Cc: cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH v1 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Date: Wed, 13 May 2026 20:48:41 +0800
Message-Id: <20260513124846.1622462-1-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOTE: This is a clean repost. The original submission was sent through our
corporate SMTP relay, which appended a legal disclaimer and corrupted the
patch encoding, leaving the series unreadable. The previous thread has been
retracted:

  https://lore.kernel.org/all/20260513083042.1603237-1-ewanhai-oc@zhaoxin.com/

The patches below are functionally identical to that submission and have
not been technically modified; only the delivery path differs (and the
commit messages were lightly tidied up in the process).

---

This series exposes five groups of Zhaoxin-specific CPUID 0xC0000001 EDX
feature bits to KVM guests. Each group corresponds to a category of
user-mode cryptographic or RNG instructions that have been present in
Zhaoxin processors but not yet advertised by KVM.

All instructions covered here are user-mode and available in all CPU
modes (real / V86 / compat / protected / long), with no associated MSR
control. Each feature is reported as a (X, X_EN) pair where the two
bits are redundant by hardware design (set or cleared together), and both
are CPUID-level reporting bits requiring no KVM emulation.

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

Ewan Hai (5):
  KVM: x86: Expose Zhaoxin SM2 CPUID feature
  KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
  KVM: x86: Expose Zhaoxin RNG2 CPUID feature
  KVM: x86: Expose Zhaoxin PHE2 CPUID feature
  KVM: x86: Expose Zhaoxin RSA CPUID feature

 arch/x86/kvm/cpuid.c         | 10 ++++++++++
 arch/x86/kvm/reverse_cpuid.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)


base-commit: 50897c955902c93ae71c38698abb910525ebdc89
--
2.34.1

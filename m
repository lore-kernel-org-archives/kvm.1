Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D3255F28
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938562; cv=none; b=g/A26MLbZo8jWtilYms/W2u249OWyFjkNy8BY5/f7k7zTPByzErjChE/q4C546DExzMtvsomzlJe767jpl4d9bCohhgikkTPx+kkCRSgyO3gzpgpqrzlgBbWYuSdU/e5cIHCKbgFztFwjBPVqrtjv32rJZV0kTv05ltVKvwFdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938562; c=relaxed/simple;
	bh=vWJnK3diqFBH9eqDvCJbWUB6NnB5rmR1E8QNfkVIIuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KIO4f2daXWm0ZgBHI3D2IqB0g/du6+L/wGiB17hmqUF7OzRjH1eT2UHLbU9m0O8XjegreaMNkt55Nb0qOkGu7RWzcB2D0MH7WaY8ZDPYqwCGLUy2siqfspq5jj/s8awFFxFs9MMvjTtLutBohVVnjxkGGOBZDBPtGzw/SA+ENmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvgc2otL; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvgc2otL"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-136b46c3540so5096998c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779938560; x=1780543360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hEQ9PkY1ueCi/OLNjUH4FCjzB8j6L3rLuWkZunHiu4=;
        b=Zvgc2otLcDha6cpWfADATeyZi3Zm+ryei9XTnY+z9Y+SwZPszf7jPkziHKNw6qBxgF
         YoTLtupJ47GhqWlVkGPxk0qghR0+mkWtFLgzcE5Ex7klmznjF/hJXiwZZUn2xZLucnuY
         BhjheFBsAcNmtAXVhcJtE2CKO3VcI6BZgenkKL54e8iWig4RUcn3ev3G+an5cNGvsgdl
         uo7rrfJnqpEVzrUQ3OuRXpj6PHvsLxzYv0+frxGk93+OLUd6ILX/U2l2OaV2yHoILS3k
         dYOugQEsfumRVonod1IDU1HHtBvqv8w9wkw1gd1IRM1FaSzrqRdS1YKK0q0t/wO1ZyyJ
         UYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779938560; x=1780543360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hEQ9PkY1ueCi/OLNjUH4FCjzB8j6L3rLuWkZunHiu4=;
        b=HbmVKDTHqAnxb3mmGcmx+xkw+JxmM2icp9mM89FLbzjRsOIRysc1NNbV9pPXRPZdO3
         SNrMsMNk+n30WPkQ/AvSIaAQdA/o8ViRyIryyLSwN/HVcJvcdBTpj5VAdO6PVTxPLRCU
         AzGaGctj9zDFz4TzGUu6nWVxoaWreHnQopgLOP6L7tGMGMms5umuH6PeaiRL2YbCSbx9
         4uItirvug42HRJaayFsEHqCHAGkbKEUCteqZeUaeg+brbfQbls9x3J0+W3w+z9ne+Og6
         G/afQaPyanFWQs47tQhdUxKqmXjtf0HjXE4t6oZB7CyFhxWkeP2+SapaxCbl8RE+DXhN
         kd3w==
X-Forwarded-Encrypted: i=1; AFNElJ/pHmYrs8V6Xa+rVSq0YryyrleRt/SYAEJH1ZrJI9ohxrR2VcCxQEGy1exr0WYw++EKWI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUo5Wi7Z2DdRlScOJ2dmUfOvlTooKuoSqhSwUIkyHPP5JQAwmG
	WS4MTY6CCDrX8g0sqnZqd4YWTnMAoRaPSXOtrvXjD475TB42V9r+Hz1H
X-Gm-Gg: Acq92OFiaUOYtCy82/cmY2PQEsJNKn1fojxzW2bnBkoisSdPaf2UWuSLO/+Ju/cGmL6
	DhvMBeSrPTbOiW2LUJOsOVzkf5jLVsvRDk2mRY0z5ByWNMaZY838tQae9afXrD2kpp86oCz/pu0
	EbconMUsbofsufczMBMzgz8GMzT1Yhmy7g9RV9tRYLPD1ntICUSMPeH9hBSVLc9wb6H+0re2yLV
	F1KzWqymtNtpRxap6oLh8sGS0fQtDiIfKvemIduRz61Y3iT+xZD1u2FksOK8jZ+13rGugFhMfIV
	dOpXWl5gBoAVlj+twjq8t/qUBQ0hXhmoZhKil2DQ98NDgx1ZYl+NoC9TvYSYFloFNohNplK2IVb
	BTOUKWnPf4SfEQonN+c43KxJIrjvv9BhPzKqoMk7rkMXvHE94manhD7ERTSop5O+9DqLtCGSiX8
	wcU5VOWBOy0JlrlYo3KqEkdDU7JGMdmhdWpZB0eUki42A9TUQlnzwV+Mq7LEo=
X-Received: by 2002:a05:701b:2411:b0:12a:6c4b:9cf0 with SMTP id a92af1059eb24-1365f70f902mr6031946c88.3.1779938560450;
        Wed, 27 May 2026 20:22:40 -0700 (PDT)
Received: from ewan-server.tailb932da.ts.net ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11650007c88.10.2026.05.27.20.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:22:40 -0700 (PDT)
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
Cc: binbin.wu@linux.intel.com,
	ewanhai@zhaoxin.com,
	cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH v2 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Date: Thu, 28 May 2026 11:22:29 +0800
Message-Id: <20260528032234.1322565-1-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changes since v1:
- Move the X86_FEATURE_xx definitions from arch/x86/kvm/reverse_cpuid.h
  into arch/x86/include/asm/cpufeatures.h, filling the unused bit
  positions in word 5 (which is reserved for CPUID 0xC0000001 EDX),
  per Sean's review feedback.
- Tighten wording in each commit message: "user-mode" -> "unprivileged
  (no CPL restriction)", since the instructions execute at any CPL.

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

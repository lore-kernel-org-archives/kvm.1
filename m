Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F50195811
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665001; cv=none; b=A++hIcNsVgEZ4pG3hsaj3lmcxghOXGGsKBV1/nVTyYMWm+j9GY42KGbGmp1YoY2tkx+Rtws0vkwBz78ULRefxaUobSPsY8kokKfnxW9KoArVrj+4Hmt+sUmuqN/W7hkZux7GWA1L3/7caJuEnstB6LixY+dqH+GLrQTOdOj2oIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665001; c=relaxed/simple;
	bh=06cERCm/1wP1/bxhxlR7bFIgZdsLMihDVgVoZxs+QDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QQOU5GxDdwOFFMfPQ+KRTa4m0wAwiBjA+p3tHqHMoIhaCi2NmrF3dfWETRZgNhaeIyUA2hWUlgqk2e7+hRHv88TkPWZeA4ZwFH+0oeHwsnz8uELiXZctb1FnPyLLrrNm60HwEZORmoj9tL51miz33cDINXOWY1GXQPXWVaX0X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHrzqI7c; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHrzqI7c"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132c338a537so2572093c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778664999; x=1779269799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=10KuKszsvhCVyXjfBSifCrCf3VsJXb0bX48uW5YD4DE=;
        b=OHrzqI7cKKYxHVpX5USsvfmJxFk+wKSFiliKwEKEXIToC3keAfAOk11NpaLrra3hhy
         hMS0ujdo59sQiyLTRTlFJjhlZQXXadzrgW6r5QVznV+MdsbjcclfuXbh/t8RYM1PLkli
         Nst8oV2PBN4jYL4hVDxt8mTvvTkStiZCDGMCvEOv/aGWybZnIwcKXlbDE4Zu1lYhwlxY
         MqtW+rTl+sjnRMw+wLG6nw9uMXOv7kYexEAZ86lb9qqFe3D0B58Up96jdGBFlt2Eazzj
         zZK4F3yTbaCt3Xx1R5hHzB9V0+bpxps0jvyCdOkvPQo+IjaAB7crqz0u48ZMShaUmHkU
         IIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778664999; x=1779269799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10KuKszsvhCVyXjfBSifCrCf3VsJXb0bX48uW5YD4DE=;
        b=UE0DvfxRpeIFet7lRXGxRmI/nBge12TzxcI8svZYQgpChkJX8MhCyR2O0SGZLy+TXE
         NLqMAYfOK0NN/U0k9zrVdBvZeT5Tx7vv98q/qgfhB4kDi+OV9ASHNZzTFiFY7x1NrFpl
         9FOWrKrEE6+NZAez5Dwvmvp8tUsjcFbhxsyVeztNRa6C3bsuwx2b0tPDTkszRQzmguco
         RyaofBirc7GYSm2pwjAeZwTJDhJ6yyxwDPr4veDdBiELFC+F0Az9Lt8AEMV2WRYlXgvv
         nt4Ynhu7sNotxr4qSmbIMdqj47mFjakUvbe1ZpRUR4h/t9YA6c1urgAc/FWDogXtNr/S
         63Ag==
X-Forwarded-Encrypted: i=1; AFNElJ/W/ATwioetAy03KUJVUpaJayQH+jyzwZCASlC6fEm52bv8iR5VFTx/WDWAcwl3q3mOcEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39pUp1E1pfEI89RafO4NpUSAfhsCQincvaOf40WTwI8QOq20K
	S+ew53OWTRTFgUqrpKm45doeYVmbdD8IXJkEoAZQtLhVqBvUUyzEuoie
X-Gm-Gg: Acq92OEJubcXGZEWOKsB/26TWLlFCKVY4aJIM0nciP7lvU2y+AuRkW51nC4siEv7g/B
	BdBv6rkSHWHpGHpowq2Ru/I2qEScsrM2fWtVuGN1oRaQmq+q6RsuCruDh/KK+g4Obb27/rIQNMX
	eRIt/TbyyEKZmt7sJ7HPT3t3ADk8FmnJCTfhVYqDZ8k8JoL69IzhERgTH0sB4lnXa3kwxwPOIlT
	G1/xws4wBbZlVg1X1uzZSuBdfzqbQZcWSNMtVH9IesF9hFjdvLlg57V62ZkepMZZ/ElO1vlQ6ZT
	aG4d8Hv8co9D7s+YA5pTwCrXYw7ytZX2EyyxToSu0bxQ57/VRaRygs/Tpwgrpu0XA3BkwVSP47W
	lpym15fX3zt1DKcXQh8oKBIhkB7bVGOGjGLdQTIqN8jSpkBvQWKoOEmeQ+n7zcMvghfHqKOHOVg
	mIVfYYUuhWhWvAzvfYA0cVc/VqyMjqPdiOh75erOss
X-Received: by 2002:a05:7022:fa6:b0:129:1d25:f1da with SMTP id a92af1059eb24-1333af7f94cmr4430337c88.3.1778664999023;
        Wed, 13 May 2026 02:36:39 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm22100439eec.2.2026.05.13.02.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:36:38 -0700 (PDT)
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
Subject: [PATCH 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX cryptographic features
Date: Wed, 13 May 2026 17:36:28 +0800
Message-Id: <20260513093633.1608334-1-ewandevelop@gmail.com>
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

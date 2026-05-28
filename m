Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C72EA172
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938579; cv=none; b=eBHK0r5msCNEL4nBZMv0x0Nd5PZ1lsh+zpFTAf6rHbaahJB495CPDoHyFIeciT+419vUoklp4G1hWtB543fLKh5rukl+PVSHMDk1d6xeTeBXFCphwKTBxC8DJMhQCm4YnHRg6A2pzFE+B6qQXw6ZuP6JMe4NEgo+UzOH/pKhd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938579; c=relaxed/simple;
	bh=Jvfk7gaLUjWx7ArQLFOHYObsLwYlIgAWiOPOiuDioAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUdEtf7Ck5yDSA14gtJ+3GwZj3RyJ5kHjTkPmobnGfY9ZIwxqR+tZpcvgIp0AdLGgapxnm2uRefLx99z0bMEbxoy9iZGKHVhujTtcwZ7duwMh/f4NPNHhaiA3eZ4VJ8ib/sUemNWbUCNn7VAaSa0Quqf+KFGtnLFvCTKw7YgypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcVKD3cy; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcVKD3cy"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1353c2f35cfso3309285c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779938577; x=1780543377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGJ1VhqmwIMs22XCOQT4AiP80fa6L3cM+BSo0I/Hwjk=;
        b=AcVKD3cylQrZqcygaknv7iPA7Hp1DT230/lLt8efshtmq9o7Jmzj7fzc9QCLrqtlbF
         FB3Ql6KkfIIsYqRQdLouz+4ml7cApkpCPj4Vmr48yLGlOs8OBo01FtZBfx2vqCG5TV4n
         xFs43LjxMJ/PRZrJhLkMnNxYS3HQ6dCe4y4JgheVaIMBb5DBy7e/Niza3hqrkVH+INWr
         5Xr9obR3Pj27+Crndjoy7Ximtv3wegJj8v4N6yVus1CUqMx83MOx/997TiY2zm9pmRkk
         TKyAucg3QbruJLucDV+bt5GovHAZCWm4U7DNagYQcxr2kMxO7WiOd9M7o9oGQXLrwadt
         DIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779938577; x=1780543377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGJ1VhqmwIMs22XCOQT4AiP80fa6L3cM+BSo0I/Hwjk=;
        b=W7wm+hq29rEVZNEu6gskSvtivhPzBoFUhCYPs51ru1iZthfg8XLDvzeHGDjYVALtBQ
         ELqX5uQ5t0MiN2KDfcMXngiz5SM8pJFKPbJwf7x7shDk87569DuZVy+/13Myt2crwAfP
         FwX4lK/I9i0EBbLNxpAIUgyFvg+tQZhQzcpHcfphfWo+oSdHq9bJ4IYiX4L5cAH025NL
         ShteOwDFNkAx2B1eFyklI2G1KCOHZ53lqB62lxOw1pJPiYx+JNlsQQA6tneau69OkTS1
         PidUN6Cx2KoaknmVlomC+/n4pz+okSRNOmH3s6CZr+cQ8OBSY4/rv+yJ2cTHDBQC8bxm
         T7Zw==
X-Forwarded-Encrypted: i=1; AFNElJ9g2akey7I7rlRkwEj2JmprLrmvXSb3wMq9LcI5iNxDGuCWpuY9JaAIDafGNOr/3thGBQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywux14qbWkvZXHQdesA4e3+D+XU7ZnVrFXGiNAsDYkYU6P6wC0j
	5R7hjU7PATT8uHfD9b2qK1jUgbAC/QdjBU6wghGaHTd097ojQZfrJFUx
X-Gm-Gg: Acq92OEZyyPF0PpTx9nNHNJA1PIR2glZnxJqq2qZxppvccO/LNk2cxvWJlQWlJkdHTZ
	GxtJtPzGdAyoI+FjBylyIkbb3RIAKXjkmSfwIFEssOlDIvY44ZsRff/tun/xYcKm+zU8dlAMmvi
	ZNUhyBBIS55zov4Ilq5EfmJapwdT6f3hiDDcWaEVUb+bWhj79F1Vc5ckXRXPMSLqVseFml57qYT
	v8h+vzi3L8KJVwvnRbDQoMq6LhOmKx2ZhfIOyINzlEvqM9aVuUSl/pB9uTY2UEmQMHABVuQ6vil
	EyY5HlXBxQcFk0MsIGpQyX0RzolEQkwH8DOtOkWtC6XDmg3WYESJAhDKmjMT1juh4D6ewSNF5aN
	NiEOAosmD79Oq587Bzbasor07BY61TBr1oFR3xOpUxVF9FQRe+NlaGYSKWV62xWuWVNL4Z/CEne
	Rls86oY/7lEYUblF8w+TdtuW+P/wQaMs1HkB3bjXNcWZEDdueAyhnbcejufmo=
X-Received: by 2002:a05:7022:6892:b0:12d:b7bb:4f54 with SMTP id a92af1059eb24-1365f810e21mr11285738c88.3.1779938576838;
        Wed, 27 May 2026 20:22:56 -0700 (PDT)
Received: from ewan-server.tailb932da.ts.net ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11650007c88.10.2026.05.27.20.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:22:56 -0700 (PDT)
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
Subject: [PATCH v2 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Date: Thu, 28 May 2026 11:22:34 +0800
Message-Id: <20260528032234.1322565-6-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528032234.1322565-1-ewandevelop@gmail.com>
References: <20260528032234.1322565-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise the Zhaoxin big-number arithmetic engine to guests via
CPUID 0xC0000001 EDX bits 27 (RSA) and 28 (RSA_EN). The RSA feature
provides two user-mode instructions for modular arithmetic on big
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

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
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


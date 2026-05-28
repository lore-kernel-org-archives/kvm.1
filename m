Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BD30567A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938574; cv=none; b=OGdMZu/jsw/3fU1lXBAG99rBDLeftolFF5FEygmZyI42AejlymCmul9ky88apBZTy8kbU8iJqY1Kn9kXFAS2VGf1PRp0rnxhv9fM3YokSCoWHjqmVqAURYs2fMr2P/9V79XoNU0vyVjTFifvB2p2XH+Qr/9p98zVxueEJ1Kwlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938574; c=relaxed/simple;
	bh=eMORQvS9aR5FjqYCVZbdydejsuj+xDuXWlicDHJHYgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMSyK5Qpqmct87AU2OPoCR89/F8QYD91YKp6qfo2bOjPtCdCuQJjDqQHBXCc2CAYFMdXQ+o69nkUn56yoP/amZd96FH+dUxrZ2e1lyx7ENvByu08MgWa1RZTlMrQj9FDHcQn5W5eU5A3DLsYrMMwP28ji0SwNO7JrLq/GfqQVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIg7dBd2; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIg7dBd2"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1363fe80fe8so7095384c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779938570; x=1780543370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWz98vafF6jvWb4m4QX8sFPHOZ07yidVKCklk7kM428=;
        b=bIg7dBd25ZHNQgZw/s/MnbkyotIkmHVy4VGeBahIkYbMHPS+BbQ3Jnzn+Ou8/PsoKy
         /1pkiXrLcYGY0lLVR5LNgJkCdWke1rwQBa6Cai1nrZOB4h/q6yjMPhY1OblV30ye+e1k
         C1TPNpx8FH/ikaXU7WcFg+uSmiuXpw1RR1SBEov7vmxMPZI2UliqA0uKZHc4VpHz6KWX
         xV0r4aCX0MRMitAf37Wtz9UN1+g6cp0yr1STgX1SeZzJtLKIKfzIEgmpD/+NCIHPiuMX
         sZhFNLfVJnhcX3Qxbp3GIPlzyhDG8MxdmESw9JI4Q9xwJMXCOjFqRV6jsA9ktYCSp3q9
         74pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779938570; x=1780543370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWz98vafF6jvWb4m4QX8sFPHOZ07yidVKCklk7kM428=;
        b=V1TzXL8JSv5ctlE1x1YndS79DFBydswOpOyeuTfWN/na1bFVecHlLwZ+B5YUl+6HnZ
         PvcpmGkzHOTNzTd7aGzbJ3AcEcZsDpU6xOuB5ijwqNshb0Gxw8uzwcEp3jEvrpIFuoAz
         d1t2nHTIwyXzaWNpg9Jdp7TqclUK1AGFpEzgFJLHxuuZQD5CIhnSX/H/v8zrpm+JVmDU
         cRuu6JEVmZ+enMLOT0A8DzOEUK409dQlMeeYx+jhqbjIjjQ19FSwhGnBtiuUwyTn333B
         EByreaIjcDHeF6yi1hCnNFXuvWGT2QXJvBXD/v0QKKJ2ofjIemDvLv86YkilwyrmB0Yb
         kDJg==
X-Forwarded-Encrypted: i=1; AFNElJ+Wp5UxMo1TGmuVNPKFyPK9H0m61gPY02ssKZnDZYKDAEgsU3sBVo9uJ/Mayu941XCXAYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iA6rVZ586yTkzjXK77vFIKh/wceYuLw28QQnT6Aln8NiNobz
	k37kSRq3dYbIoHbSbuIQ4B4eZY7z/UXVyMLT+jMxTbCXgPULob8gCDjZ
X-Gm-Gg: Acq92OFDNB6Khb+1Xh3ADJz0dJFoc1bzqHCJTwAk0OWBxnygnKai/YBr/Ls3x3aVIin
	TDI72cwdyaOqLUtF0v2FjjoagFNtjsq1jLBkaEMKCbIczRE58ksmvi/ITXEa5uxd0p8O2xkweZ/
	mRsioeBPpKIaAVOP4KBl10mbK12C3Hgw8/qXWfxXETdbp737lXbCZDLwnkNXgEHxQq/w/44k/fy
	ezGlZYiD88kYR6yBJT+bFsuOwjD4rnpCz0twJCIznVBO6uL24nXZjCH8chNT2O/nS0itNjzrDww
	QcXmXLlfb5wT5MxwnS2MtbtMvzPA8bLZH4hRIsqkNIklOHpwePhwoZIP15c+75RKfDlV9emOvRQ
	KRqKkENXKwYwaIRE6feo0l2wMhzFW4AdQGthPK0KO7zEd8Z8lE5WGaH5aN4iEuuGD/lfz9JvWxu
	q6urbcLi+dW3PTdWnLmb5812l+EohiDzZzOMX7XfWxbWKZr4vUYI4TascI6e4kbncJaybSsQ==
X-Received: by 2002:a05:7022:689d:b0:127:5cd6:fa45 with SMTP id a92af1059eb24-1365f818ee5mr10812257c88.14.1779938570253;
        Wed, 27 May 2026 20:22:50 -0700 (PDT)
Received: from ewan-server.tailb932da.ts.net ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11650007c88.10.2026.05.27.20.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:22:50 -0700 (PDT)
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
Subject: [PATCH v2 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
Date: Thu, 28 May 2026 11:22:32 +0800
Message-Id: <20260528032234.1322565-4-ewandevelop@gmail.com>
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

Advertise the Zhaoxin second-generation hardware RNG to guests via
CPUID 0xC0000001 EDX bits 22 (RNG2) and 23 (RNG2_EN).

RNG2 is exposed by the REP XRNG2 instruction (encoding F3 0F A7 F8),
documented in the Zhaoxin PadLock Instruction Reference, subsection 1.3
("REP XRNG2"). It produces random bytes from two on-die RNG sources
selectable via RAX bits[10:9] and an output mode (raw vs post-processed)
controlled by RDX bits[1:0], providing high-quality entropy intended
for cryptographic operations.

REP XRNG2 is unprivileged (no CPL restriction) and available in all
CPU modes, with no associated MSR control. The RNG2 and RNG2_EN bits
are redundant by hardware design (set or cleared together) and both
serve purely as CPUID-level feature-presence reporting flags requiring
no KVM emulation. Both bits are advertised because different software
may probe either one when checking for RNG2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 276e4ef90bd0..e264758d58e2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -150,6 +150,8 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* "phe_en" PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* "pmm" PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
+#define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
+#define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8aaa3f20670e..087c41341240 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1286,6 +1286,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PHE_EN),
 		F(PMM),
 		F(PMM_EN),
+		F(RNG2),
+		F(RNG2_EN),
 	);
 
 	/*
-- 
2.34.1


Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5142F49FD
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938571; cv=none; b=fXoqFheEuuyhL8pu0gdZaJ9YEed4TM7NBTbaSFEFCsUXVRgWjd3ITrraEsPmXXhi8AOoBKNMAAl4S7a3eXC4Pv6yrn8oFn3Bz5QLcqXZMRcsEA2OqIaVX8FslPByRff2K7yxFmTeUFJ8VNlziFddG5MX2WJNYJ32A3BnHH+tO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938571; c=relaxed/simple;
	bh=tDF3ZmKVpEC4shYM/JHRfNnBmzTPIz70W6cP79CziYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQgA/fBK2pxxJ29thxbPQ7xKVfaPKpLk9uforPCj9XMuhxP6C92M0Z+TH1ZGh48I6eyednPNfSinHREmP1Sl9Qnl7qx70lP39smLo7K5t9fBLeehy+81VgvDM9N0sm8NiTDyN7a7pWC59zp+a/SPSI5q86if9vVTb8GYr4/nbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpO9D6T+; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpO9D6T+"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-134fe980658so14342484c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779938567; x=1780543367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R9tOzrr8KJ8Ew/2llqW/EXyCybA2lhbdpTnPfEMUP0=;
        b=YpO9D6T+gu7EOSyIi1mo8/gguA3k+CWyfNP1/sggLUZI365twxqZyQxWQs+GLKwk2E
         ERF61R8ZDNd3WXUm3rOFzQ625LlgSlpfhV/xNHGJF5ETOHmovFmsE8QDTrp10FGhlWVX
         1webr4vziTLnLi40xSdCpTd+LFELKOfUO2AsjJxClpLuvuMoF2Tm4ZhwXPaVOQM/4t6D
         wL8We2Cc6KKAMPMPLNDwnKjCdJRdtxLqeWngtX221rG5DYVvoiTLARW1azEpmuz8Z4Q1
         MqPg22hOB2kV4sSGc6S6mxlGpfuuC7M+Kxg9IgYvAqAzBhA90cmtDpo35WqB6YnmO/Cc
         twHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779938567; x=1780543367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0R9tOzrr8KJ8Ew/2llqW/EXyCybA2lhbdpTnPfEMUP0=;
        b=BroC8ZVQ4WSp2xJ+lw1WYzNDmFOCPghffS9W03y5IQi18De6n5Ka+/hSaCGt1c9pnB
         NerXMMdIIu7fteB3ps7Qe4Q3MiOWlwcsetVJmdayEKMdbpAvIrBsYVyY2E7NZhFBgLH2
         yRT0PKvqvbDViJwEU4htR5Gg/FKsIqsfBJSRxmvaW4RFzf4cNvrztjhmnrLgxyqIT7uJ
         o6xmrd61gIv/MUxf1uEdZ52yVRnHbyNYnWUCTAp0ihFdLVHxbgDAnrOQaeE0BGgbD8Vi
         xMFojRbqllq7xV/xZ4Kt7Wyh0xdJrfMGRwE4GRfjZW04D7o+/WGznZHaf66WLKU3xUtZ
         355g==
X-Forwarded-Encrypted: i=1; AFNElJ8OvHFj5V1ompv7kIftmq5T3QqONzzo2jao3NhoZZvrh6WpuE6pG1XVYdfA4ABpeH5K5j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/qsWybrD+iQsIwVGgQ/DLblb+Z+UbC/9jGZKixSsySputp6X
	PzzlKc2gF5wZXwxOD+jaykh866QyvhwrSjsvG8CpszrgBFqj8DBTo8H/
X-Gm-Gg: Acq92OHcoRcznRkviocw5tF89Lg/2l7bHvnjiin0D/lLQg/Cu3PQj0sz625pHGnPoWl
	bNwYCfIG43NIuvQvGi5q6JE3CLp1yQlluL/e5+XBQ0Mzr2aedoX4bTd+miiX78+BF6mFsu8N7+b
	ihjeHg31sg1UJQNozhZY78XYDDL0y0rJdzWIhE9xuK/td3cPcJkDRHjIP/uqVY5Gy/e6VPCgpY4
	Se8lvq3D+FB+jcfXp1fWQFjcnvABG7U1n4mpICx+JO2Ut6xKjvARmoC/2CpgYEbGVb1ujohA6Tx
	c41eDOUiRzqXG1OvrGLkSy+65IDfh2RtiEJrYUV93W0/+0WSg4F0ve7hyYnS0xeLuj6tQNrNHBM
	1s6RU/ViXZt+Rr5mH1iEXPjeG1GeIa2iSUJ4X6Vm69rkZbUywLvz4WnSFNBNmgV2cLfmu/viEtO
	baA/kMinmaXhl5MznXNoQ08207BZA2Z6IJn0lMn/wFuPlwcj+ozicyzKNxfTI=
X-Received: by 2002:a05:7022:fd0a:b0:136:4103:a5b8 with SMTP id a92af1059eb24-1365fa38819mr8508431c88.22.1779938566980;
        Wed, 27 May 2026 20:22:46 -0700 (PDT)
Received: from ewan-server.tailb932da.ts.net ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11650007c88.10.2026.05.27.20.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:22:46 -0700 (PDT)
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
Subject: [PATCH v2 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Date: Thu, 28 May 2026 11:22:31 +0800
Message-Id: <20260528032234.1322565-3-ewandevelop@gmail.com>
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

Advertise the Zhaoxin CCS (Chinese Cryptography Standard) feature to
guests via CPUID 0xC0000001 EDX bits 4 (CCS) and 5 (CCS_EN). CCS groups
two user-mode instructions for Chinese national cryptographic
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

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
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


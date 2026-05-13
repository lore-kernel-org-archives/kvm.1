Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859983E869A
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665004; cv=none; b=DsukG1g6396qgXDTfg95MR2pUpaLSOOG/D6CO8mOoBTtOjiU2Q2dc21T35aKR6/kbZBjfLtTtMBmOTAxv1zX8a28jRN1Bcpzzy32kcu1EYxJjK//zRHsRQ9AnK++WSJi4gtv+8bT3I0vEJfQPp+8orCtWkb0HcpwT3TZeaCDPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665004; c=relaxed/simple;
	bh=At1gf0Mua3N4YYtHisgY0h9wtx8xtKox/CUCEWQanfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVg3itvF2IrpHSxAaQTl2yBvTeI5ELGcjZfdyfCzo8OQq6vsQxDfm/cYbCAt0HLQcVrGOxoav5kycZmKBVVk7Y9DJF4X8uISmExJsc+u5EDmxm9aErhpvGT0naDu6UAfA72stqpa6c2VT+TFzCxSLWhHhlan8CSW6EnKcptYMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcFQx3e5; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcFQx3e5"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso493903eec.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665002; x=1779269802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R9QlZtKzGZ9Srh0EOuGXWhWVZA7AopSSa5Bhm29kr0=;
        b=XcFQx3e5q0pLAya9m7yO0JSyxvUs0/irSrCJgQAuefwfmZ7WsWnUXA6AITwvBcWxRY
         T8GjxIPVlxlbsndMOmSuyu2q9j5MjGDVGek0GL0SOxkOfJ0vuiwhzDrOHL7O6MJqS7Re
         kXyHqoLgPo+8oVHQzQ/bVubBeKxv6shglDIBzQ9DAul9Ro64r1MDiML1JSHmdmH+iUX7
         c3Nrf3nYUt2YPHBuQpDmO5VHkblAJo5nweXRPQF9vo66ZJPUDzyIAFedIuPlGMQwJlNg
         uCtL65HjwySB+uXJtCkMGw88Jm9Az8dP4fXF6VNOXxIzWwg6a64s7N4eFr1HaL9As/zc
         lHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665002; x=1779269802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R9QlZtKzGZ9Srh0EOuGXWhWVZA7AopSSa5Bhm29kr0=;
        b=eFav+CXPuxTKZ8BltguzbE71CErA/pCtgnSDAW5P17KqnCcJe05z24S2YDDmZ3TFoR
         Vx8o2Rb86ipIgfzDSjET0d6N+rB6pPbnOsRixiYHmGNujfuMHs4YFMeGguoPvk941YU1
         qJbvLvPcTJrZ8cWqPosaGxB6FGRXF/wFtu4k5m/ODNcuEwAmcwRicw+Shj/v0ZX+aPDG
         +q3HupS1qvyENFdSfLaS0TctwWWUlISbzeogZafkaWa+K6lci80BP3wlLUOEsGzTCfiu
         Fxa1jU3AXiwtNWCp0E38TyJCY7ChUrILv/Krht2uzrAjc7B7BYo+menOQlVaashoQGk4
         nhlA==
X-Forwarded-Encrypted: i=1; AFNElJ8lOTAjNow0fpRTTy1q0PVQjAgdXtRSgKUcGU9yJk0VduboFjiA/cWXwzOHK+GyOFu6uic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlhb2Z5eltopWfEmewdX+du9C0vyFmW3yA/sRvAHdSDqoW0iAH
	uX5C6yj6Az+unpv8t6c5s+rdnRUHccDYsSBbPCcaMPya1ep+kvmqYiEU
X-Gm-Gg: Acq92OErN5n4wDn1TCy4eG7GyCH/T1oKO+ftiqEgV+iXo7ufZhqLjbwR1JWXbDQddR0
	kxsqUSDYUG+VUNYLnAne94jEtLcwxqyMWte9o1EKd8qfI3zhTQPzga07iC01VHySVpJlwqWYBDf
	91a95gLVXvpMUbEd369/nb3XmqpV1jZEy4hJIYGxgdE4WCOS3HJbage2SiWqB0rB5j6FqSXzaEV
	IWBLiuCoP8MfGX2hpMxiJPzSgWhnfUnpnooTdalwT3DQeIybdAejr9w3WKrAyRc6xbg0/FBPdEQ
	px/REnMJLXfHuWZ9b8C5RuISKhIDtKUqrpxjpcfi8f5iFN4l4Nq+S4NnBZlgJm2JJEKZaZ7u1Lu
	/x+B7gofCW/GpbBZSMieDT+vD73H7RGY1sBWMSqFlGaj9yFovYYPjxf93ZeMWwn7qNxbYIg3OyZ
	4V2SAvdEnME+I1M7sb6C8g7Uf/3O51cMlUj2rKeYYv
X-Received: by 2002:a05:693c:2c88:b0:2f5:5dd3:1fd8 with SMTP id 5a478bee46e88-301184afea7mr1772103eec.8.1778665002245;
        Wed, 13 May 2026 02:36:42 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm22100439eec.2.2026.05.13.02.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:36:41 -0700 (PDT)
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
Subject: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Date: Wed, 13 May 2026 17:36:29 +0800
Message-Id: <20260513093633.1608334-2-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513093633.1608334-1-ewandevelop@gmail.com>
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The instruction is user-mode and available in all CPU modes, with no
associated MSR control. The SM2 and SM2_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for SM2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 4 ++++
 2 files changed, 6 insertions(+)

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
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 657f5f743ed9..7b55110cc046 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -76,6 +76,10 @@
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
 #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
 
+/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
+#define X86_FEATURE_SM2			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
+#define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
+
 struct cpuid_reg {
 	u32 function;
 	u32 index;
-- 
2.34.1


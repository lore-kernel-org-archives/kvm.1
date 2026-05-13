Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6C3E9C0F
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665014; cv=none; b=JmMx2PXuonveqpitpdvvqX6noIsdFljWiHTEkPf0ZrRAwgZ7d5y9PK44eI5yrgToGqvIggLEdaHs/7bMYeCursSlOjhiC0/IL6CK2Bag0epCmimllW0h+Fu6ZyOeToMuYfoUtsHOYzM3KNHvafP/2PypQz4rrqI9NMnCfJyq5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665014; c=relaxed/simple;
	bh=jRvKpxoAIl60/V1P+VTJHEK99Z/0YiaHhUBAFANty0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sr1f/bfxJkl8f98LydpCIcXhus226MxBE4cdDWtBAJ+uktkUUlS0mkanB+EbyivUuM2iTyhIoslghPKW5ptiepNci+nMkJME5tdxLj89EayNytDZR2nTIHWruS37N1/knqzlXqPFVqtcaKmPmScbgLIv1dwxH1FrXKBIos2DLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFxTVHaW; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFxTVHaW"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ff5472f263so2646045eec.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665012; x=1779269812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtWmrYOKzZ6UotIe01yj+lYhNEkXI+QSLpIqgQNFL98=;
        b=BFxTVHaWIoJ+dvaar61jZAw6E6uczN4do0S2jk4xjrvtGdyKtZP+VNOkSYg2EICPc3
         ieLANU/WM6jlCCdbIl1+yzU7nU87afXVn+9zDsp2ulkk5PlMJWh6zuOMQn+bMYvlWAH1
         U+AMGjqH5uibv5ZW7ObAU487Qw8A/8NBk1oDaANZmclzMC0njGpmSF5emUw0PNn6KY1P
         nurQJnxpA8+LWXLNOf3RawUsSnRLgBiptbOGqmizgLjtoqnY/e1G1coCoDhs7BtTzigR
         zWBtI5/NH5XHHPX50TXurok5nQaozwKbZTWg56y4F3mu7SLJhxVvQLhZIlx9oUqfPvfB
         QPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665012; x=1779269812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LtWmrYOKzZ6UotIe01yj+lYhNEkXI+QSLpIqgQNFL98=;
        b=VKuQ0zba7UMA/VktqczxFi78EuA92aeJT/QHnIHFUq1M6Dkh2Wyl/WEewFF2UBf8Qz
         Bh4Gy6KUGmXPseeL7wYDp4aXm9acFVMK6v2mYOj0v5gBh96Pql1KX851zbKDRi37StgA
         DyAyDB4nU6+rPBh4RHUrSJKByik2OiGKy9SQpbGoWkywzWY3kYZKIbYtDVJ5XbycrlNu
         1tz1yr9EX1AEw3MZXjlScMn6rla5sB6Io/HmMEuEHvBEtzSwLprw8sBHgAu08ZjOw5Gg
         mLAG/fCnDDV5pBqZBmjzYz/sv7pAyEw/QRziDafqYD7SZ+0FYohOzJ0BRZOYddG88FMm
         Volw==
X-Forwarded-Encrypted: i=1; AFNElJ8aYjxevNq4tFeSm1UZJcpyR/+YtY3rO6NeoeBvRDnyDSlKlPgtIzIq7uSMlU1pj/3G/Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV06JDwsV7BsBSu9qSVoaLfl9Qp4pHoRqqO9MBW6ZW4b4sCIhy
	UZW/dshHqUwL4tNPFrjT5ECb6w2RoJydbDsAChe29inPgojn+m0gVS9uNWrBbachvsc=
X-Gm-Gg: Acq92OGfXbQgY57hbJLciN9UA5Bg6kEvACIBU12r5Y5t6LgAEp4eoFdLMHAJhlTcjRv
	l6E7BPwv4TXZFA6jLiziQO1u+elEDlvexGhWaTQhcMmp/TeFpw77JEttDJXUcZ7d1rfkpEEyiZC
	/2xzOxhi2BDAUM2YyU6oVER2658jZKOvzdCj1eI52aGV7G9dDB6PFbI+EdMjxToFtOSg63wkwd/
	viZIOk7lXPvl9JMOc7raMre6wFxobCiz4kimrykE3+ourXv2v02CSyq0Fpk0nBwS0xfMRKhvVDA
	5/sCMXFjShm+F3pjWJUx1SMH9aRBFsOSDUW9K/lPNA6AmwBxkGrJznn7EasxhMqlF2KKr1JvA7U
	3Ur68rf92N5QlC8wspdDhtYs7ZOy9icVSgdWmKEsg2Lw9K+vcP4uLEWDazAElvPUVue2BygGXhV
	jhQ6rPspnthriXPNCRKgZGweq5+65njVBqSvccqAva
X-Received: by 2002:a05:7300:e7a4:b0:2d4:94cc:eebb with SMTP id 5a478bee46e88-30117480740mr1458096eec.13.1778665012111;
        Wed, 13 May 2026 02:36:52 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm22100439eec.2.2026.05.13.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:36:51 -0700 (PDT)
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
Subject: [PATCH 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Date: Wed, 13 May 2026 17:36:32 +0800
Message-Id: <20260513093633.1608334-5-ewandevelop@gmail.com>
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

Advertise the Zhaoxin PadLock Hash Engine v2 to guests via CPUID
0xC0000001 EDX bits 25 (PHE2) and 26 (PHE2_EN). PHE2 extends the
PadLock hash family with SHA-384 and SHA-512 support per FIPS 180-3,
complementing the existing PHE feature (SHA-1 and SHA-256).

Two user-mode instructions are exposed, documented in the Zhaoxin
PadLock Instruction Reference, chapter 3 ("Hash Engine"):

  - REP XSHA384 (encoding F3 0F A6 D8, subsection 3.3)
  - REP XSHA512 (encoding F3 0F A6 E0, subsection 3.4)

Both consume software-padded 128-byte blocks (RCX = block count, RSI =
input, RDI = state) and produce hash output in the state buffer.

Both instructions are user-mode and available in all CPU modes, with no
associated MSR control. The PHE2 and PHE2_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for PHE2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 087c41341240..3fb81f7a6107 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1288,6 +1288,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PMM_EN),
 		F(RNG2),
 		F(RNG2_EN),
+		F(PHE2),
+		F(PHE2_EN),
 	);
 
 	/*
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 859ba43126d8..f28300c2d5e0 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -83,6 +83,8 @@
 #define X86_FEATURE_CCS_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 5)
 #define X86_FEATURE_RNG2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 22)
 #define X86_FEATURE_RNG2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 23)
+#define X86_FEATURE_PHE2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 25)
+#define X86_FEATURE_PHE2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 26)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1


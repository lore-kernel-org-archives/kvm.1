Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A443E9C25
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665007; cv=none; b=sH5qKwgg/YSxKEiHd5gMoRnqNIviRjNC8rsgAODclpYo9OnH+jeTDNddGv0lz1tZFdRC/S/zQl0pp9ftEZi2CkBJD5MtPZ312FYtJlIyj1crz8WTZz46RQHPuqQiQIOhNHnurhGrR9gKSspzPJUaOxExDf+UgzFSZsOVkrI9tQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665007; c=relaxed/simple;
	bh=WrAyTmwYSRYTeMp0wl4NRx12Jro3naVKJVOSJpgIEYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYe7Wvqzhc+wa1Y/sNudl0EvqW38nwB/KHn5ZdT/4Ey1rGNNCW1Cy0PU7OxZboPVJ7gEXk2XpyVNOVebVT9p+Os39yCWoOOLjraMzGuZtY56grXDEzjB7p8VjABlVMCq3cfft4TbNcLcBzWAWgXuxNiU6lGYYKZUTTT95/2Q2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbPwVnkt; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbPwVnkt"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so11147843eec.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665005; x=1779269805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERPLFt1DzdQWZj46mxvIXYh6fAkpMfWFMGg+XUXEJ+0=;
        b=dbPwVnktL2AAU7gfbif19em6/v/Z4clpb4Vv6H77ib02VXRhGqTHeQfSr/64pRnkJO
         2xO66YYWtEYfJm88IP+MsdKdBAX0lYaNfBOI6igW8E0hgqBaxmXeB7A+PzH0PSHHaNuG
         jk+Pv2X+Vy5QxC0RTS8fUKAzcJ1KPw63ogChQ1DPvaB06sNk6xzqMzbQfYhNrzlJ6zmE
         7ywp/g6BeX9NSmKUe+nvnTumpNhUenpumTjhEsXTj5nS9RJyoC934gBbYr47WI9AgTxE
         JEH7BFYGFgYdJ0CW711qKdsRwhi+hxC7lkl/cwJodSjgnglDFcFf6pvS7/tKLB5DOh4s
         M62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665005; x=1779269805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERPLFt1DzdQWZj46mxvIXYh6fAkpMfWFMGg+XUXEJ+0=;
        b=gyhVQHOEKtdkgtkETo3FPObFA0bx1fHlTJU6R9BPa2aVAhlAJEDrlCCqsrsPgKVPzG
         RKRIH5i754run3ND/PV5bc73/sNfT/wKqWZPsRVRmtU1AbfvqrzbypWM81iCeH4WueOy
         7EbpUTbFZxvHdx4KFKdlbl0R0TExGwNf3D5DMdgBtGZ4LdDCTo9ZAFm47p93HhTCXEuB
         IjWS9128/L0WBsPBrdB4KcNIh7cnXj5M4yEyNsoHbzqaKYGhx2WOTWA8PfimPChanrKD
         lQdRuQxt+mCxodrFOJje7JpG5eyhQUVMjiabWr/5Rdwjh9caeuNEBZpQEyWMDu+hRm2/
         Vn6A==
X-Forwarded-Encrypted: i=1; AFNElJ87/SUFN6zOAFLzxh96bAvbWrYD7Lf6Ld3HrwbEo66TofqT9aAa8phtoF8vZ/rF+w2XDdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuojcEvsGTSwmt0lZfC+yvr5vOtQgw00nkd6ZyPdG6MY6In3tL
	QsKcb54b+kMIX3/GUOyY5fA9QpJ2LWl8ZHQFxaJXIzg2MpBjNX6FnYD9
X-Gm-Gg: Acq92OGnZnw5q25H+uScwooUF1hCPnZN+X9QQ5OuJerqVDC2L6/zWjel/cxeQv+1qcx
	UB2N7cPN8uftNIbuAW5TNJw7bui60zqXHt8Xvlho4fOwCChFDjhngWoU+VKqdmuSOiwvBT6wXWI
	TQBCPb7wLqak2l4a9DwegklphBq2L0ok9LNeqgtRf3G6yjTgHjdqx16DiN0Et/zbW5sDRJVI82I
	ISfDW3T/vMxG0L7R9p3a8XDVGXt7RrPlxhCrvW+BQKvrNFq9g+fPvlj78T07C4mWrKiafIpe0VT
	fbGbyeeQzvmX54hwAPcXMqf3htF4sZQSLiTNi9WaPEF6K8EkF4snKZuquyzNuoCx+5QmtQnyG/I
	DLxhVexFSnmHeaaU3K8M5m4INGIcjbS3zgW5/yFqeisEs3zHQ7ZzOO9yjk08rrj+Jhj72nnXRuK
	T75iiVxvKFICnH4XDP1lz0vK+gM4MJNLssjIDzQmZc
X-Received: by 2002:a05:7301:1288:b0:2e1:e3e6:2909 with SMTP id 5a478bee46e88-3015468e76bmr1005616eec.9.1778665005498;
        Wed, 13 May 2026 02:36:45 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm22100439eec.2.2026.05.13.02.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:36:45 -0700 (PDT)
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
Subject: [PATCH 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Date: Wed, 13 May 2026 17:36:30 +0800
Message-Id: <20260513093633.1608334-3-ewandevelop@gmail.com>
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

Both instructions are user-mode and available in all CPU modes, with no
associated MSR control. The CCS and CCS_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for CCS availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

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
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 7b55110cc046..a1cd9116ef63 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -79,6 +79,8 @@
 /* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
 #define X86_FEATURE_SM2			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
 #define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
+#define X86_FEATURE_CCS			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 4)
+#define X86_FEATURE_CCS_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 5)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1


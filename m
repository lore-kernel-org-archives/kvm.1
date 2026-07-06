Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226C37D12E
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304501; cv=none; b=ttINZZ7oYL3iE2t85i4g+O4ugYduGEyLo2Rmpgh1Qezmggs33LZ45ECd04oiiWh+aDM5zwieh7fVWHRGPAEJfh04OS90wRa8tGgev4YCyWVtUnHus4GHVmcJYaLfedsQOBIjhF3DDXXWs2On8Z6cnkiHvAVRvIJuyUS+Oxny8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304501; c=relaxed/simple;
	bh=BtT0ls6YmM9d9nGGoTkQaPA0Kw5pw1Vw17vs5G6vw7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUVA30GT1Abf2dKMgr5Q7CtUfosxO3/46PAwY9v5ztmq7YT7HDTfHn4Ec/oP9+Kn0O7HMC+BNuCSuOsedbWUcXxY7Xyg60eZ6t76onkmynhidK7nr4y/rB/1IdoV/zSMWzW7fnDW/4XtjY6Jatrs+dPg4JwtpzPG9mkpRJoOYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH9IN9VC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH9IN9VC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc8e87f29bso4739145ad.2
        for <kvm@vger.kernel.org>; Sun, 05 Jul 2026 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783304499; x=1783909299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwFDdkksbt790fLoy4tClBNp4x5JbRI/xOADu+E9kr0=;
        b=lH9IN9VCstbvvKDNPTj9knkASQEKM0ANejIkUaMdyI6qI2kvy/e+BUDrlSaAQApZ7d
         PSpbQJgIvfYBrn7Ss84dRIriaDGYR+GW79GVQ0hGP5Jl6EG6Kifto8CDyMNR697oTZbT
         35h8utjOhzutusii5n1ajQ96BnxzJd6a8KaXsAhx9AI87PA6R1SdOvBAxyMmQxX6WgKH
         wJVWg+bw1EuTcZyqBLvESP+6rFCutaH1+CEeG6Mgs9dUILi9VHMsux5HtbeztiJ/nuCI
         0RF0FnkDpcKHXVpT3XN+aWlP2Fd196moSS0y5JEO8ovyu5x+rQZHSpoCutcl3xDAojcS
         FFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783304499; x=1783909299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwFDdkksbt790fLoy4tClBNp4x5JbRI/xOADu+E9kr0=;
        b=ia9KQe2JqcUOWegnRRmkmZ42k8r8Bs5tXjqIHIghKhoGGDmiUyqcgitOUExp0P+1l6
         Z5CsmnrDUw/L2QWwqMelcIYYhynYzONY8CSn0auePDDju9T1epS8u+Adaca+sdZw/80J
         32UbbOz/URyjHp9mmfPGYeFvqut04GiQ33XCrtWuOxNxfzaSq20vRd59siUBsS5/9cwE
         Dngx2TXhW+zHFe3re75Bf49BJPjaIcQq7yiJGat/pU32PYrrj6KIc9Au/96onqV7p/Gq
         qXnTGff/Lxle8bSE+JbSvfkS2v7GByR23NsgtXLO7/JA4lv8gXh8WS/O6VCZ2EJPA1MQ
         SRhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDHbi0ARXT1ocUZAwTJjDp9gHAyl6dMHiD65cWVX/0sC17054HWIN1zDDVbWz3KHV6FCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXnRFhSBp5DiU1IHH7tn9qxcosY8gFT+9jBWky8CfiBmPaR8M
	6GrU7V4ZLlrj8qkCWiUquZhUDoXlDuaB30oLjAxpwzhjnrc3mBGBNd97
X-Gm-Gg: AfdE7ckRkEBfEEQWVLcFbHZqd5Dk6c18lUPbfZUNiIyb4scQPSqfnBwF4L2AbiWrEQT
	uqf2+lVta/DmFRwQDU/1JpDiPgjJMJyLXpuc6ns160v5NOEQMhRW3ASNtG5RbcCxuby30bo4/9s
	1o/C4wEy3X0KHJ9JU9xmFB/zVY96e/E2AdK90QNmeCZ+BjIEdJ5BNhv5iQacQ1AL8CCSLWs1ZI5
	3vTiVFYVMhulCLD/dgy3njxhAzZCI5GEAh0VHX1k3RKN6ODEb9KUPDtKTXqF+UYBnUWbOSCyXxC
	LJkWWyByoTwG+Ga5MBP0CnCeHBlkKG+PUbErTI7Ffo5GkvCFumMa7rhVPi2l/YZU2qroWXmQ6mX
	fDeZMCT8O0ADPq0kVPshbLrkft8Mle4yMTvoxdrelTThif9XKzNaAD2Fe272hP4fq
X-Received: by 2002:a17:903:b8f:b0:2c9:bd20:866f with SMTP id d9443c01a7336-2cbb9f0371fmr85608345ad.45.1783304499269;
        Sun, 05 Jul 2026 19:21:39 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7126971sm39828005ad.18.2026.07.05.19.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 19:21:38 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v5 3/8] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
Date: Mon,  6 Jul 2026 10:20:39 +0800
Message-ID: <20260706022046.214956-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706022046.214956-1-inochiama@gmail.com>
References: <20260706022046.214956-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension array to allow KVM userspace to
detect and enable Zicfiss/Zicfilp extensions for Guest/VM.

Assisted-by: YuanSheng:claude-4.7-opus
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/isa.c              | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 7bbea8812d92..a27de850fa4c 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -199,6 +199,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCLSD,
 	KVM_RISCV_ISA_EXT_ZILSD,
 	KVM_RISCV_ISA_EXT_ZALASR,
+	KVM_RISCV_ISA_EXT_ZICFILP,
+	KVM_RISCV_ISA_EXT_ZICFISS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
index 1132d909cc25..9852a91fdecc 100644
--- a/arch/riscv/kvm/isa.c
+++ b/arch/riscv/kvm/isa.c
@@ -65,6 +65,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZICBOP),
 	KVM_ISA_EXT_ARR(ZICBOZ),
 	KVM_ISA_EXT_ARR(ZICCRSE),
+	KVM_ISA_EXT_ARR(ZICFILP),
+	KVM_ISA_EXT_ARR(ZICFISS),
 	KVM_ISA_EXT_ARR(ZICNTR),
 	KVM_ISA_EXT_ARR(ZICOND),
 	KVM_ISA_EXT_ARR(ZICSR),
-- 
2.55.0


Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21616368D7B
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871712; cv=none; b=ojYqVf7pq8/vMC9MD+XYBU24vGrHeu6TkBNwImmh6yRGq+bXDKZKLjn5Eq9s2/LwCeIEfx50R75m+c4mZXFBdtie6yriLQYL/CDDuLliP6SRqBQdC3v3judTVzgJAD+dC2HPw6djEva/2LKe3zQ5Po1lJ2bE2lZkiQmOn6qgsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871712; c=relaxed/simple;
	bh=EeYfw6IhI8uGLEKTdQeOo32Is4ccTkKVpfjBqOZYgRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBy4UrW4JcJnKV4u89FyjedDwmjcL6LO1E13pCJk+l8wNnAJ6dSwOW/zKb0uhf+7iKGfwRXSQJTlMcW+WHH1IpSjilAoSTRDnjuRnahuOEa25KOgq9ipF6xok5F0J38irwQdCj15j6+YVJYSl+eargc0UAPEMaLUoV7YnWjO4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1Gh9bnH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Gh9bnH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37de8008910so92907a91.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 19:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782871710; x=1783476510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGZz7zKK7YB2BzQhv1X8PZ94iNsskXKsVTHTOVc0QYQ=;
        b=f1Gh9bnHT6tL9Yyzn97vzRoZqP6kVCHuGHIEfknQhEg6rKdn6Hi8eMyhFCkiJcp5yB
         xkiAmUMnJprTuXzs7Ulna3tXvvAZVX/OUgUVEDRmdsFTrdJK/Sdvj2ZMXzQwnk9OScgi
         oJMr7xi8paEeOKuMBB+61lNZJO8dN4uCOvQk8TS4qNMj6TB3zyW0S0VUhyP1NBWjPEfB
         Pzxr7JIYOW2brzTii50lqenjJOUimD3N8ZLUPm9BXRY68+dSkyVxyO/9sV3RZEU8QqTi
         ArE3ts5uwYGQLNrsmy1SkPyTx/a3LBTc1TG8EF1tqGR9GYmwJ+1uKNMyOhc6o2/zKnBz
         W/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782871710; x=1783476510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GGZz7zKK7YB2BzQhv1X8PZ94iNsskXKsVTHTOVc0QYQ=;
        b=O1uaxizywgntTyZQF9Mr9Mid4uDT4FYCODMGN7BOdUiVnwIdAFPTztF8tCsmrf/FFV
         ZbrjRTteOeezFKDQuJhvX15vMUCIjP02BhNRESmjQ1LsPwiaDKD2tkZmFpDR+zT+sSQk
         SXsPHSfnwONbU+fubWOZXe54TV9xqLGrzLD5F+o5rvmi76qk+r5wS4tHHs27MjkifWHJ
         UP1OXdGbpwCmMdoy9M3Jcoebl7Ir9fWl6Z+Qi4JWy4jY1/VyYFbS5YmBolBX1IG+hM6T
         /VmSQyTkOky327hRGihnPQOAvkjWNOp3iIM0msJ0jJVClOLzx1hROHY0dUIlCoqX680u
         XkiA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1ukB2tX06/9odlVSxoYJTRY3zck9W3JgLFkSKOv7M8PoBCB9TMlCnxPOF4HzUKMrH0jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFC6Ec26JPXNk/sE+rdiLfQBbKEmE00XnZN4uHV1ApMsIuTYfA
	k1erdXftxnPyzRwh1AUbYz1VMmgRzbJpBX+nowWOQ0wQWRfSxCY3K1Tg
X-Gm-Gg: AfdE7clMt0d7jz90Mmw57ll5+3T+P8yq4Cs74buORRixzZ+7f/bwV6q+0a841oEOnLs
	pJkCRwmZ4DsyiYiI+RD97Wk2L+IfzhxbQm/O486ZTHD891lpg+x3KtvrVnLPCBLKmpsAE9nD+5d
	vShXaP39k2ExJ6LBpgQOkF2wTyQOpzubJIp8TMAJV7Q4ylSaidZv2alM4JTqbIuC+cpQcD+B8B6
	3Rv0Qr2FBn97SsLJZeP1sZXWSwL5aCwLxLjY8c8HbddNaEMd3er29KEMGo9DYvJNno3VqDhKSHR
	we0gRj7U/latj26hSGINPSqsA/yTL3kI0mojUoYtrYuKJjxxNEmR05iyI9gEC6AVNVbKN/JiZcE
	93f4WdR/Boi8+P24Oj3YQ5Mnmg4ueMKF/ZpYyFjmiLRlf8WzB9DT8lcR8m0h6qx2DDyqeb0rSKz
	XYlFVwsQeHYU8XWxhLOhEBzg==
X-Received: by 2002:a17:90b:2249:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38083fc45e0mr2967850a91.21.1782871710420;
        Tue, 30 Jun 2026 19:08:30 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380964613a3sm803133a91.16.2026.06.30.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:08:30 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 6/8] RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is enabled.
Date: Wed,  1 Jul 2026 10:07:43 +0800
Message-ID: <20260701020746.170157-7-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701020746.170157-1-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delegate the newly added SPELP bit from Zicfilp extension to VS/VU mode
if it enables landing pad support.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/kvm/vcpu_exit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 12eebeabdf14..61305da5256d 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -154,6 +154,12 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 	/* Clear Guest SSTATUS.SIE bit */
 	vsstatus &= ~SR_SIE;
 
+	/* Change Guest SSTATUS.SPELP bit */
+	if (vcpu->arch.cfg.henvcfg & ENVCFG_LPE) {
+		vsstatus &= ~SR_SPELP;
+		vsstatus |= vcpu->arch.guest_context.sstatus & SR_SPELP;
+	}
+
 	/* Update Guest SSTATUS */
 	ncsr_write(CSR_VSSTATUS, vsstatus);
 
-- 
2.55.0


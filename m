Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6243749F9
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378063; cv=none; b=LwDRzhS7CtPatz4t+Lpee71Q9xw/oFI9VW0Ys1shrtFUGxbwelHo4JtZMHQGcmRn7/XXDygnzoCF4sJ5uCwGk+YK4HqoQv6inBDhYv+kn8G3FOzn22P6ymwM0ujCkFSQclj74Fmy/4NjrYrObg5jiTyuJpLJmJQrLObQBD7mZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378063; c=relaxed/simple;
	bh=UVNndpb5pQc0JxecpJa8nTKNRVo/z5tCdH2JfnNU9sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tm0AMPYgvS3wWy9Wb+jIzN2NorIB3dvhXj+od2y8frMGSJbqNbm07tPos0Bi7Ajx7greyQV4E+zvh58V4+fOE1rnJ3hCV93HQCNqxtUg7/Ox81BmBmPY32FXhkPA7TncAvsVHpNvEZV3SIPsI5mWV4fzxLHzP3JSAu/2HfuVxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwS6qL0O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwS6qL0O"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6a97e1d1bso9719325ad.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378062; x=1782982862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdplxVcOKM5k/tf+hDlgyysA2XnFgzaLYRKYRu7Tbtc=;
        b=qwS6qL0OdPchT7XZYAZdeijVG317rEvdt19C1ecDR9g4mDrLNSlrEgjjVwVwKdN0eq
         J7iUpPdXxGq+MNetZ8mx/8MfW9QQr8B+3iDfOVWxTQ3R6hyWIFJ+dSom2av5cNhHHexZ
         sGjVZyWMKKnglWjUMObEDCrtBKngVYhDorEnCWYrCL/c4RDYG4+L6biArCwxRCIUoT1R
         vgeljXDe0zNNqaIclipAthp/aWhSlcgSmUFfDXJv182zLskdn160Xx3T10UwIi8s3qr2
         GQvTzaJ27LuNcnCDxodFxI0zHLUzBlU+D/BG730THj0ApgXcTAYZoOhctLrd2zsRZHD1
         O/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378062; x=1782982862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdplxVcOKM5k/tf+hDlgyysA2XnFgzaLYRKYRu7Tbtc=;
        b=qCzHB540U+G3qi/t39i9kqWKyYZ2dxR0sa75jhqthTRVlwWq4J3JutfCMvuL9K7yCn
         Abbrr5Kyl42sXlgvwvgYhAfyvr+YeUN6Dv8oS1R6dK4bvK4YDJhVh/VbhqfqQNBy9bUz
         WCww8n78WaBmxTDnWnfAplgagRE4faLTDAkFEmIFcJvKVskWif/EImRLM7BlJVScYDA0
         FXu0Tdb68Tdt4K+BfM9JiEX3I929e7O4Gh9yy31FPh7PqDCOFOsBfK/FR9R3BIDVMilV
         q33RBZKnmE7xH/sQWU9Gu/q5J3Ytrend/1gD1K/27XB14w2k+K9zMaxdZPQmH9APYV7l
         Pyvw==
X-Forwarded-Encrypted: i=1; AHgh+RpUKBVIc5p7aw+BUENaX4pDuIHqvlbVALZV9uvlurJLh2SQm2Sbb6iirOqrkLaxHJd6lNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1HDWHK8gLKmY4GVzZDHLcJHyy0JNnsnVlWBv+0u79KTruHN7
	wQWUmZVEITkw6JVnKuRvUsiFK6RAlDIyALoHox9kj1O3C2P1rz9DKB7t
X-Gm-Gg: AfdE7cmXSBeFML5f0/ba95zSWU0ZiTWhniB9ylYSb/frP/hwyuIjWZOvy9R2vCreowO
	6lCgwVjdX/wQwUdg0X2/Vg1xWTCpCdA5Fxe0jlR+0bCbmYB7VeRO8WpZrexxyXu7WrY5ZET1MTa
	a5ThehEgyAVwujrBpf8U4HeuCVXwq08IKLPwR+3waVGbDD9m/XHz+AjU20yur+tzgFM9ljjMT0y
	Tpqu96GivfTKG+ViBqzCi+0CgmdeEiZ87Zx+Dpjk6Oy4GLafqOVo4d4o+5kM+oexjO2ptRh1VQ9
	AvYOx5+x3nnHP6zqK1ReohJXFgG/Ia0TSQPjAyfKwUlGf8oRHnv6TXM3cheoYKaYcMxlUohcaOC
	UWr59MhAlSFF82KYgdJkEsLCht5SD+BckMvCLTc/aBzbSOt0RrVXTfQaSO9HuTrxVfuKvY5ee4N
	YTEajVB0aieZsVLbUAnaeSPC1/2scihdTeBG4rydiJ8xFw8g==
X-Received: by 2002:a17:903:4b30:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2c7fc62de84mr19781745ad.8.1782378061529;
        Thu, 25 Jun 2026 02:01:01 -0700 (PDT)
Received: from LIKEXU-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f64dcf88sm15786125ad.70.2026.06.25.02.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 02:01:00 -0700 (PDT)
From: Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: jmattson@google.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/pmu: Use wrmsrq() instead of the deprecated wrmsrl() alias
Date: Thu, 25 Jun 2026 17:00:57 +0800
Message-ID: <20260625090057.4864-1-likexu@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the remaining wrmsrl() calls in the x86 vPMU code with the
canonical wrmsrq() helper, for consistency with the surrounding code
that already uses the q-suffixed form.

wrmsrl() is merely a compatibility wrapper that expands directly to
wrmsrq() as part of the ongoing treewide rename to the q-suffixed MSR
helpers, so the generated code is identical.

No functional change intended.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/kvm/pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index b92dd2e583356..dd1c57593f48b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1330,14 +1330,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 		pmc = &pmu->gp_counters[i];
 
 		if (pmc->counter != rdpmc(i))
-			wrmsrl(gp_counter_msr(i), pmc->counter);
-		wrmsrl(gp_eventsel_msr(i), pmc->eventsel_hw);
+			wrmsrq(gp_counter_msr(i), pmc->counter);
+		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
 	}
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		pmc = &pmu->fixed_counters[i];
 
 		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
-			wrmsrl(fixed_counter_msr(i), pmc->counter);
+			wrmsrq(fixed_counter_msr(i), pmc->counter);
 	}
 }
 
-- 
2.50.1 (Apple Git-155)


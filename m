Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128713B5B3
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904648; cv=none; b=nughMY8pW/AMsk/NQjAOnvFZZyeb5WuJ4/HejPS5SioUqUm8Qhun5FYvuSmycOdkVYLiVLIW0gVKSujOpcZgyfzA93xTzJ95yoaDxfaP1carxidk8anq9ZUoEUXwBzOUyXQJ+4eRv83WzlqQ88yqIV5TOmik8xlsKNEv8yZHT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904648; c=relaxed/simple;
	bh=gGfxTLPCEXSgUtK5WaUX5O/nHFlYsALwKDZ9s87hSwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0nJQnxrUQ1qz/0AwMcXk2ZPjBXoQhYlBy9RdA1LE22Z4E9wL8mxHkOcd4MYhvDvWAf0oPXc34F041T2hFjP5tkIWqspSZs59VDi00Vx1rAFS6mMhDsSydGqiCWDMa2vkq1yACmqyVWyO9n0+FDRk0mDOWjgAiRzlnqSfHkJ5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioPxYieg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioPxYieg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceb096e675so11960745ad.0
        for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783904645; x=1784509445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nI0CkxxyoH8k0I7InDiV0iYilFi9jdMMJ7m2xkEZwHw=;
        b=ioPxYiegLCzGWvc7cISXavHNafqRKoVM42PpoNlqovOQhbQjvb4IdApuocZPxfeSHO
         VL/7I8bjyKZhf+yTWZYHnz4XVyO+j2BasF3jPeYuYHhW7o1Gnw/OQDx1+gqspQLcxdoV
         eQ6OQPs+OfFWnxlKoAOSsmjRmNYLMcWGDP36y+Y//EW63gFXIU10rTyD7nQkFLxkPr2i
         tqqV1RgMqfYGMoa997lcL38RkNwndFrmM3d7CJd70diWlrtDUow/zIAvPSyMiTYmnYKY
         0NhHdW74JBmyWSqf36qF9+WzFNE2UKReOshay/Y+83SXVWng/c1wDcn4CCgDbJYaZO3B
         S50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783904645; x=1784509445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nI0CkxxyoH8k0I7InDiV0iYilFi9jdMMJ7m2xkEZwHw=;
        b=ri6PTyasFtUgIoJudnAjZ4ULKjpKJGVo3Glu8PyBzcuEdnZVJfsDPYMG/FnvKa78z4
         P2yCXrCTrZ43SvpoGHZjNeVe5lak9XLYhyffRKi97nVczd/rsE/Vk9QvZfWBPDEM5N9n
         x5ZkL23lwBREA2FaIOaxM4idaJB63ksrODuDu3GBEfhC+1J+bkmdOTVWeOiZeJGOGyrV
         DAEOYYGics68fpJ/SSyVBLvWodOsYB4aRedZqqHu7SMrG7cgXFLFekgukzkfQomx6idi
         5MGwBy+f9+WhPFU9OwzDjetKGXAu3nvhE5Y2v0Rd7tkUWBPrG7Sweo+LEj4NyhE8S+/q
         o+Xg==
X-Forwarded-Encrypted: i=1; AHgh+Rqc5h9ktSCzMCA37atS2gtD07clUqreRPIcTKBGP/4IC7WZHOAgbKoLnTypsTXOi6bDLW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMhFd1cdxxmWR1SsVI6SyGM2XI1CVBiMyhuo0dYeQ2kWZQd4c
	JLC8rlhWowUdvXeiyS5D6nUsOrEu9K3CXrAY8SuE2Fg7jBgOi2wwi9Uz
X-Gm-Gg: AfdE7cnmk00N/bY83TceyWjFrNuqKUIOJxQW3kRoKIBYulVHJ/5wFQcA99QgWCSZ4ye
	ogXU8a+4TT4ZKaCbc2Hd5OckBYqw39+jLA6+YGnUlQGxF6ITtyNFk+NyDhMCijPOWzNukhqOaLv
	enuk44vjQA62hZH1aq6bEOiCclbPSN4EFE9eL5zsA9UIHpMUTEWFra900nZMjDZRTml22doPSc0
	A/FlF2LtjB7sfg/ZHv31kAoPDZ9JF9fWmX0zSoQBCV3/aU/SD7Zj8EdforjX5eIic2itiBKqecs
	ffwWdlmSozkR3Xnuo5XEObqzb39EIb5bCoPNeJGsi9bxhgPSKpHUdgmH6Fv8+umWoLGFmj8Wuv+
	vqzEIxXA30E+luXRynrKmkIv0j0F2I6/RbvSon3ONBCx5FzG9bFVYsvalMgtAIgheIltq9eOHNy
	+THPvsLcJUFZ8=
X-Received: by 2002:a17:902:f708:b0:2cc:98b4:e7d7 with SMTP id d9443c01a7336-2ce9f17913emr69731695ad.45.1783904645152;
        Sun, 12 Jul 2026 18:04:05 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e1aesm91755405ad.39.2026.07.12.18.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:04:04 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Andy Chiu <andybnac@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Thomas Huth <thuth@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v6 6/8] RISC-V: KVM: Delegate SPELP bit to VS/VU mode if landing pad is enabled.
Date: Mon, 13 Jul 2026 09:02:59 +0800
Message-ID: <20260713010302.303278-7-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713010302.303278-1-inochiama@gmail.com>
References: <20260713010302.303278-1-inochiama@gmail.com>
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
 arch/riscv/kvm/vcpu_exit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 12eebeabdf14..92a3ea7c7ffb 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -154,6 +154,13 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
 	/* Clear Guest SSTATUS.SIE bit */
 	vsstatus &= ~SR_SIE;
 
+	/* Change Guest SSTATUS.SPELP bit */
+	if (vcpu->arch.cfg.henvcfg & ENVCFG_LPE) {
+		vsstatus &= ~SR_SPELP;
+		vsstatus |= vcpu->arch.guest_context.sstatus & SR_SPELP;
+		vcpu->arch.guest_context.sstatus &= ~SR_SPELP;
+	}
+
 	/* Update Guest SSTATUS */
 	ncsr_write(CSR_VSSTATUS, vsstatus);
 
-- 
2.55.0


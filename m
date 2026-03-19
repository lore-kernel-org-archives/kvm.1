Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4B3C9445
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919205; cv=none; b=oF4i/R1icneT4yc3vJO0z8tPqUlOpquTu4A0/BVAHcj2L65qdFnAEPSeoSNYKrcLyHM4HAKXvJbWcp/wsG0aSPI0B74s5KXYrqohZaWPYUtk+DQRT+q7ftR92D1TMBXPCc/acRQqDXec4Jp8spCG6PiKR01OOlC8OEG7PWEOh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919205; c=relaxed/simple;
	bh=gDsnsepuovOET4ezqWG6ikRseEUeORN0anJ+kPf3XM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/gyTz2R/FrHBllsFJRDOfdrh05zZtMj/hNfocIiaok/hKTHwBnewDrLyGk/dGyaNTXBZMbKqkPUfTTCwd9HTfX8t4kVM2obohFDp7mMgPaAC5+Ff0mMvFHTTTHx8Uqe5/NeZVb2KDs/enNDqISAe18CdUXqa3KTJ11dcJm2/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZPYiQAAd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPYiQAAd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48538c5956bso7112085e9.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919202; x=1774524002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8yqnxF8hGCxxNwG0QPtk4/HBFqHIOCwK8FAKwORZgo=;
        b=ZPYiQAAdBJENt1c/OB+yE4ThxCs+W1e/BHHRX1JvBvmCS8tvld2bRUIC5o659a1EFB
         Sm9iMX7vDs8/3ijQawu2eDWWRzhER0czNoMpokjlUQ9AQkUw1UgsaKDoHZ8A58OscuD5
         ohH41nTwMIclrC6aBRmLxqieMH7gaaYhHQPfdmXjdU1UYeRthZtl+/Mh/wqpQqbpQ00a
         NF0YXCPtOusll5W9QnkrdK98gSZSAk0CciOTxX42GX+nl958DfuHlIc3YwWXCKcjiIJx
         yjg7ltoI/qbGsz4BEwxAzSWuPz5RRC8Py2yveIu6uGiuvGJ5KIopNeAx5gVSvq0nVwZq
         mhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919202; x=1774524002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8yqnxF8hGCxxNwG0QPtk4/HBFqHIOCwK8FAKwORZgo=;
        b=JiYwjXHK1/XEMb/iRlLfLFuDvjSxFShqXs7wPr60kXTSYHT/G6lRL0eOomkZrCnMEl
         d7EIorIwidqubuKQnuJjktDMtIoH/jaZTdf/s0s1JNmto1D40loN1eVsWSH5+LyWH/y/
         3wzHBxZ/jmJkH1dA4Nbgytj1RXLIPRqSZGYJZ0JKYFBKAiiPnA8hFv4kkfTcQaQKUqGF
         ENU1i7dd2ICyuc2yq+Dm/j1jyYMzsL23SQJnwpthtn0DV3iPTd3bqnCwr1JWm1xylO13
         Pg6zpPwY2im5O8UGTfWfdj8oOKOV09LLqz0wNUofvlyXuE7sEecM/ZYkRrSvlPbhGKFR
         e40Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeLxn8aVT20RShNmZVA+ltrRzOV17yBwvdmEpoRfZ0hnAUbO2ljJ9a3sNClrzOGuz/bMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMB236WajXUpIozrfqV4Jw+rxRynWTizapDJtHRQXpxASX1GK
	aBe35iW4iS1Lw7dh/zTVz8O/Rj0/7O0XpmHmwRgmPYjASaFM1IGyOyi71l9TJ8vD32s=
X-Gm-Gg: ATEYQzzTlWlZ0k1WNNznc25NyM1lSBum6STwYUw5zkMQ34swbFNBNGcm8MdOGO82Gry
	WIqwE/47riSc0qFJ1ojaIatREtaZiFuWeCDxnKPk4wuUEvnpStw/IrMFb11qwa8ZXb5ioyhFKtS
	4Hf+NeAIq1jR5cSHA579qN6zbUJBY7Xp9FaOoCsBgQ4+aRdEEQngh4qEQLxhlZzSbAMkRsUA34d
	HYtZeJyH7z2+IUIM0EAB19aaTb3X5gV1+aa/um8vROscj4Opq7sKyAqMSyykh82S7C95egEYxq7
	fDf4eK0E7KJkYMIEHKT6y/WXEVnQ/7ysMSgTW137DHVtRi7zyVa9gTzLzaZX3rozAtL49HmaSxI
	97BWC+YSnOztbFB6k3K5TbNIytRGxS/BplfwTFxaMbv/swxvyP1mcaxpXhW0zRj6bMXBaIFC6gs
	VcovVBitu1qCJkrj1PYus/+4SzmCaWTfUiCgcKwZGrstM8dT695Il7aHwjBCqt/UXUBP1TTrp1D
	+zMaRjFvD0=
X-Received: by 2002:a05:600c:6612:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-486f8b47e70mr46838835e9.11.1773919202026;
        Thu, 19 Mar 2026 04:20:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949a5sm56925475e9.11.2026.03.19.04.20.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:20:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] target/ppc/mmu: Remove unused hash32_store_hpte() helpers
Date: Thu, 19 Mar 2026 12:19:31 +0100
Message-ID: <20260319111936.68041-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hash32_store_hpte() helpers are unused since commit
6e8a65abbbd ("ppc/hash32: Rework R and C bit updates"),
7 years ago. Remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-hash32.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 04c23ea75ed..5705f57935b 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -87,22 +87,6 @@ static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
     return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
 }
 
-static inline void ppc_hash32_store_hpte0(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte0)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset, pte0);
-}
-
-static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
-                                          hwaddr pte_offset, target_ulong pte1)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
-}
-
 static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
 {
     return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
-- 
2.53.0


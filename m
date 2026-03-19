Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7313C9EC9
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919213; cv=none; b=IZapDr0FYo37kyVQg4Sed5+OdUXRfD0vGk0mX8SP4+O4hcvwCzaaGncsKs8/Qvsgkp+eb2DjOt376PBtpyOk/9GxKGy4fyLS1AQqkfVFxGQ0sCxa8zE38k2oAl1uzsNWdPL7rg0ZK6TP5abKIP+KLJeVBiMrkwGiW1hwK4UbjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919213; c=relaxed/simple;
	bh=JdokEg9D3pw4A4TE/3cUde9KNeJN9xWk15RdqgRp0ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1LcuVjpJ5VL14nf9TvkE63J2GC9nM1Q9Ip+ymw7RLHXk3/16tYCWAw9pAZEyfJOQS5omOC2F6S4hK+r1SjuQCJw5TZio9YU0+clKCFHr03Ixp4ecuOb6FFdrKYqyW20IkKZuGxF8JyHMKijAvobb0sqSIEThySe0wN88RnMtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=if+y3f5u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="if+y3f5u"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so8185425e9.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919210; x=1774524010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejOVQiRumOacnIAYVijEgBDEEbKLhlSk8KeBK8nEaas=;
        b=if+y3f5uRQfyM3HIR4lnhTX5zTdLnOIiHpDZcoiIS44Z9hfipU4J+hpY+qdgP7Fi8O
         0/1WjyxHCgoWprWeCHaEN5vtGdQlHlUQxyGHA9+wz6NQgd9fK+9o1XS15ZXxcQveab6q
         HrKEz65fujZASIBS1wASOu2lDRfRG7j/FtM5ZUsTKGH/WKbq3bLwrqZe4XV6/Pdl12k8
         B2p6w4R/SpheDazcfEjSh1BkDsUGmMsNukVLorjFyAgFTwZEgEp62H0Mm7qWLLiChDn1
         hkiFKNguk2JrYMGy/YbYoOwFxVGc0nHa1TPB16TZrDJ/NGDKZsxl6YLiSLLHvYpCI/v+
         wj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919210; x=1774524010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejOVQiRumOacnIAYVijEgBDEEbKLhlSk8KeBK8nEaas=;
        b=LpaNSwqeuODzmTmy5rm41q0rOjwu6r3V0IBxInu831VwhxJIkZVvVDFKpL1GOP8y/5
         B6hWzDiJJOG3fTBcfwU4ybzZzAssVXicy54h3hNmfsWf3gGnpNfNuHL63Vv79XIwKW2b
         STYXM4qFewOq7EbBW/d8/oNHDTcOglKZqcxwqj0p5c0o52KT139NpDz4B+yDpHJwP+d/
         lyiMxApIYydyQTHnc7Z5i6eUnsF97+0zYdwkKiimLb66AsFC1I7QDgp+xnfSfKLfXLVJ
         M4K5crgnFo/iQp4whjAg5rc2CQhhHuL8cJ+P0o8IuZucRYDrLNjXwAUgaQI5NFtjD0zB
         ofKA==
X-Forwarded-Encrypted: i=1; AJvYcCW7pbwTpc+mPrYSVIqedsLbUBeIn6CtccMt6F9n74nUEn8PAJ0hRLb5P2EHsC6QhElyrRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPXcMFD+sgzjUmIwFh66A22uiX9qYfs3R4EWJuhakkEKiVmk7
	EDxFsgZY47e55Lgt5trPO1WP027yK5VFZlW/GCuERf2gRUXws4N2ki/jwX9qFaJw7EY=
X-Gm-Gg: ATEYQzyF5nif0SgNYrtUI4rmBniox1Ac368HF5aKo0bLQZDTY1EnjCvr3vhUTyPOwFz
	8jJRLrAgsyz1vrwOWgoArWLMz3j7RjBM1L6gbfF6tzsO26MnNHQe/2f08UOEijREeqHuKzRan7J
	MRz+QkjwL1Ups61DngP5oDaIS0snNrxdbZ0AVrQXzj3X7Dzn1/4enSxse7mry8q0p4Va74m+8yv
	buH190G2j6iQG/DuCwFFbceqdDCRoOrC682eP9dEm7AkQkgc2JzTy20utKlqMrhupeDu0f8pud5
	2jn1miCXcQ3aHwnylT0uymTaE4HWPiYSjgtsOPbpsS7m6n1Mtmwrn8oIU0qUrzG09nev8/gM0mT
	O6A1StmOuFluyfQDi6xiip5Hh4XyB9bfJ1Dm+ki2fZ4h9jPPC1PMSTe+h/wZjxebmwnOQvTL5AO
	psEnj0GzLOa/Bs+FIZB84YeW96i19V0wiPl6TNZl/BtPJSzGz1IqW7yIcNbqjLt2bNJtZw4cmxQ
	WjEarO06Mk=
X-Received: by 2002:a05:600c:64c5:b0:486:fcdf:c065 with SMTP id 5b1f17b1804b1-486fcdfc16dmr11537745e9.27.1773919209867;
        Thu, 19 Mar 2026 04:20:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e23874sm70980525e9.6.2026.03.19.04.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:20:08 -0700 (PDT)
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
Subject: [PATCH 4/8] target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
Date: Thu, 19 Mar 2026 12:19:32 +0100
Message-ID: <20260319111936.68041-5-philmd@linaro.org>
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

hash32_load_hpte() helpers are only used within mmu-hash32.c,
no need to have each file including "mmu-hash32.h" to compile
them. Move their definition to this source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-hash32.h | 16 ----------------
 target/ppc/mmu-hash32.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 5705f57935b..bfea03ea872 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -71,22 +71,6 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
     return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
 }
 
-static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
-                                                 hwaddr pte_offset)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    return ldl_phys(CPU(cpu)->as, base + pte_offset);
-}
-
-static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
-                                                 hwaddr pte_offset)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
-}
-
 static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
 {
     return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8b980a5aa90..08c9f63a132 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -201,6 +201,20 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     return false;
 }
 
+static target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu, hwaddr pte_offset)
+{
+    target_ulong base = ppc_hash32_hpt_base(cpu);
+
+    return ldl_phys(CPU(cpu)->as, base + pte_offset);
+}
+
+static target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu, hwaddr pte_offset)
+{
+    target_ulong base = ppc_hash32_hpt_base(cpu);
+
+    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
+}
+
 static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
                                      bool secondary, target_ulong ptem,
                                      ppc_hash_pte32_t *pte)
-- 
2.53.0


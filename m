Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A33C5DA8
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919189; cv=none; b=rVPsUWEfCIR4vX942Wk0vxdgLrP1XSh7z0YriFcxM/BV30Ltmw/l5lLHakG7p/nNbq5gXVpCSNYOBpfCoQubVZqbouOFYSib5Vizb7L10IVN5yr5aLz2V5qCQA2k411jwIcaUjCLjSki0nas+u2kWE2VOtW0qn63jkA5Sioeo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919189; c=relaxed/simple;
	bh=6nqD5ksN+nCS+xoz/xmNteFQ3uwJ85VgW0mGo7T7KR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0f4ygM8GS+PurqJLBNOS/c6gO2uUA3cjHS6KjPEQzH6j/F/Y7nGUNawGc3Gabh364mg2wAvDZ+KK5lVtfHjuaheA99/P9kg5Engm9cJCmi/xjslDt9eC5Hgnih2x9IktD6CPLxav1rHBTfVK6D65LUB/VLv8ANQztXk5Or2uBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWt6WD1O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWt6WD1O"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486b96760easo9207325e9.2
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919186; x=1774523986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAlQ6OL3gpyVI0jWnvjBgu6bCA13ejnahNH1d2j0ink=;
        b=IWt6WD1OCHgcCuBKJVjolSo+snQdgjAtwRO864w/JBIrhfbznuP50wUy+iNe652C8R
         06oFmQXd3uckP4EZeiawWgg0LBk5lBMc7tLy7b9EMBZjMQWOSsoc+TJTXA5Jz2s6gKGD
         zLs3qYuks7ITFmKpWX2jaA/HE4iZ4imL4HBq2fNxH1/89UJo9MWNVbsGg96sR+/tkm+A
         E3gL8UJlSrxKiQ+ilzntLeqBx/X+O+jJpbKYM3+b2aHWUCrPRRC7f30IWAShoEaZyP7r
         Fs4yAyc29UEQaEgvxzEbyeluo/PZCDed2nBT6wzDKTqTXSzWWhk2IPAYmwH7XgWyR7V/
         TNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919186; x=1774523986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAlQ6OL3gpyVI0jWnvjBgu6bCA13ejnahNH1d2j0ink=;
        b=C2DAn/T+VZdcGbA8Dk/Qw4jSum7Wdc9eUvxS++QlhVUAM0Wh5f+Vq+VfU3qK5SOvnT
         DS2PzA3y1vq0JzKiITwZAiR7AKRW/cML1dC8z7zEJ1SB1Mf6eRTcqe2rjPX/3ySasHlC
         S7Fd0DNDSlVlJOWGytfL0C1rqj8jZBIdEkfuFngkyVEQ9uhVnwSnKtRCWfJza52HTUoK
         vi3eE/Yw31rsSgR/4HLrR6mrapjhq3en9cpCyNX9Ukng6achFH0XCG8JrG4RXgUH0x/2
         ROBQvgou9qy0XgWYXzOM0Lc3uvvrsygRXCpNzXuqT+KTlgSV5MCfIPo98tLwPMg6AeKZ
         h3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0kiadki25Ymk+KNADdnEReUyn0GXXA5VF073a9Li2SeDXE6zOFFHL1F74G5Va+ARlkD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysX+NW9oT/9D9Kz34D5G2O6t2nW/0liU3J0Og0dCVctH0lDVli
	owZYPu5w3NqZRNoqfQJTzSuNE6mwpTyIGrTHAggRfq8OsnZO/JJg2pocNM3VvJU709c=
X-Gm-Gg: ATEYQzzWTfpTcsnZ6PAV4QC/RdaVJ9+7WpF1u5wT0XErrYHeMAB5AHGpKccQZYprae2
	eyG0Nfv7B+bxKMO+QMpLuuDJGKSg1hXc/W+KhwIueK16x5kWngtdrEMWmyB/bnREt24KfX4ZTxf
	/zq0CjG8B4pli+/QgPv3wWMDvYgoQKFSmoOaAT1C/2whtKZvsuYlEAsA3eWAUlcAcwINx7ltdLF
	wYIEpAVucmv8fGan4brfuy7vUqSbchSBDy1m2i/5lbMl+hsXFqqubygo9b6MDJQxFRrME2K/7On
	rqq2IylUwf61P9KEFrTBffQUuloRJeqIph2NNyxbZJ/cj5j7PVnFx3CWktTGMuPQgyQVJ0MoMBB
	pVJ3z+Vr2WrSwqbZv0Pzk7OnTSSDJQVp6e4d9wYQsv0Jsx3iMDcV6DLEBg9tKXadOgnSfzlHtqk
	KIEt/HDcqCOQcX/bdXJVmqAcnoqsSJrq6ZsSx+h3V+XQWEsOzk8WNNP0D9cgBYAjuwGmMMOkiVC
	gEWSUpxUJg=
X-Received: by 2002:a05:600c:4fcb:b0:485:3f38:3de3 with SMTP id 5b1f17b1804b1-486f44384d4mr115148365e9.3.1773919186220;
        Thu, 19 Mar 2026 04:19:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm103526265e9.9.2026.03.19.04.19.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:19:45 -0700 (PDT)
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
Subject: [PATCH 1/8] hw/ppc/spapr: Un-inline rtas_load/store() helpers
Date: Thu, 19 Mar 2026 12:19:29 +0100
Message-ID: <20260319111936.68041-2-philmd@linaro.org>
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

The 32-bit binary doesn't use these helpers, so don't need to
compile them. Rather than using 64-bit target #ifdef'ry in a
global header, un-inline the calls since the helpers are called
from I/O (cold) path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 18 +++---------------
 hw/ppc/spapr_rtas.c    | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b022f8dd25d..9acda15d4f6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -796,21 +796,9 @@ static inline uint64_t ppc64_phys_to_real(uint64_t addr)
     return addr & ~0xF000000000000000ULL;
 }
 
-static inline uint32_t rtas_ld(target_ulong phys, int n)
-{
-    return ldl_be_phys(&address_space_memory,
-                       ppc64_phys_to_real(phys + 4 * n));
-}
-
-static inline uint64_t rtas_ldq(target_ulong phys, int n)
-{
-    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
-}
-
-static inline void rtas_st(target_ulong phys, int n, uint32_t val)
-{
-    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
-}
+uint32_t rtas_ld(target_ulong phys, int n);
+uint64_t rtas_ldq(target_ulong phys, int n);
+void rtas_st(target_ulong phys, int n, uint32_t val);
 
 typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                               uint32_t token,
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cb79ad34053..0871425237e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -52,6 +52,21 @@
 #include "migration/blocker.h"
 #include "helper_regs.h"
 
+uint32_t rtas_ld(target_ulong phys, int n)
+{
+    return ldl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n));
+}
+
+uint64_t rtas_ldq(target_ulong phys, int n)
+{
+    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
+}
+
+void rtas_st(target_ulong phys, int n, uint32_t val)
+{
+    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
+}
+
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
                                    target_ulong args,
-- 
2.53.0


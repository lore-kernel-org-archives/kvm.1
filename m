Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68B3C2777
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149502; cv=none; b=Mmre1KY7pULxyP2ktjSW5sTAjQuOHa44XLc+G92QXnbysrWN91NTPbrz5qMO6xgqVWe/NCKA6zpTimZcfpbbT2+bZiXyvpeRKaiRky8vRkIOQCVf62j1KntbAZGdij1molWpwLuwsH8rTnIj8/Ake1qs0wqUR/DPaVtljuYAZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149502; c=relaxed/simple;
	bh=37TrZQFbAgh1QOGKnLrrkx6UUnISbf+6VyCUt+gFH6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXAFv2+p3qzAx4YaAQoablUdGt4hP8bKQJl+5uRVMniq9Sir4pHnl3A3yRP9UdVjN0w5lm+IdNj2cglQoXbr4/KLNai0maSn+67/Q/R+lBE5GcCq5rpIV0YJC3XSV9pnigfmVTIB/KJO7+R6dQFB4nGQbGvpdziG6cpuj5n0F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYxkAm5X; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYxkAm5X"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso10227095e9.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149492; x=1775754292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpwa24XgbbGnpEc9o84kjwJoQeIsKIVNHM7RwypFzUQ=;
        b=wYxkAm5Xq5IndPPzDjcbDQioL1tUVKhPpXBuu07Apm8iedBRueCxZ25Dn5Pmn3wZ1C
         pd50ECxrh/PtQ8Itx06XVjM95n29IRdXmbHiGtMqgDAw93f46K8fu0qdO+kY+ITzwdkS
         PWQvBlrmjGfP0ap4pGFD0jvldlxAojRYLfImvcsxPrfJ+iHrXvTXOW/6/SsWoxYldMEw
         P/4epxko/XZfXcCgllM2M/13XoknwJ3hY95zj2OogklseNzokImWX9EPm2feZuSbtozJ
         HCvoLipvvqWV3G1XGzhtCF6RSiLSpmaif3/BhKCivSzIQtGiRXgMoD4mzZJdVZ4aePG2
         G6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149492; x=1775754292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vpwa24XgbbGnpEc9o84kjwJoQeIsKIVNHM7RwypFzUQ=;
        b=N4t49QPsD5gSZq/9hOHaW4DLvlE8lReg2v9a12DCFgiVms7mkqc+jVhHDEw9R0rNVY
         5LY6bGdX8kAgFO1QmKUtMbpiEdT5AQkFBmG0Jab+LkDCsPVQeS+4uDHQuq8+TdPK1G4R
         ZejUZIvErKItxjupf04hPOmIxVCoS/8MTinf89QAMqtHPiSnrD2n/XJpFiiS0ABnz6dN
         6mQ9iy7QPt338+7MrtSggx3k3oijmxQsel+bIs3pIGKrNiQxxwrKtsR+4lozHUABzrK1
         Pl15doxw/2m2Luzes+1dH1upjofTqzvQ9SmBo7RK2Kkv1doSfsBRF54dF65NGaNbEQpR
         Tqlw==
X-Gm-Message-State: AOJu0Yy73XZGxi+KtM7bbIGSMR/VZ0ZapGnu5G8tj9W49fyBsPdDlkbc
	DXV8M3bMpfMB2Wd83Qd8jLfSr8XmxrwnIN6Ifat2+HQraCHTwYt0Jn1HYrczk1nlJgc=
X-Gm-Gg: ATEYQzwgf9bwLyGE1qlvpDcg22CmO7XPYUWOs39uSM4yMjOIIGJK20c2g+MycMWiBGD
	2t6sbKIUvprxkfS7wVi20p6hDiK57edgzKp5pkCtADXDX9qWPKbTHmmCgXMAksDb34cn00b8rGO
	eV/MugPy1chTca5JVfBp4eZLBu5iFREVlIcfuSr8zaWXboNvmo5v6maEEN+1xf4x63orD994wMm
	6UPmR/6NKiE90/vMor/HFoqAh6uLJDTDJFYdPlvsDPs4Xi2NF/cgIyaOToYooTBEctFwr81RYAY
	dPcD2pv5R2oCQA91FqvfZqAbD2uneE2/oikIoSGofXeLNl7R0qzxUuTV1az5rpF4kh893CDXcgE
	xyny7KhH7yBVdN2Wiojn/F5jEilX9SoQ6Kvp/bAap3ZjQHIlfLLyj0Si5Pwco6HhRCJE0+Tl4W/
	0I26STtgyiOKtBczZtBN59Yd2tRAeFhejHSNxi9nQJ9rlWvAw0WqOMb0CMl7hM/Sy5ZK3jlTi0
X-Received: by 2002:a05:600c:c056:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-488835b75c4mr102142295e9.20.1775149491541;
        Thu, 02 Apr 2026 10:04:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897b82b50sm2140515e9.0.2026.04.02.10.04.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:04:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	Anton Johansson <anjo@rev.ng>,
	qemu-s390x@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH-for-11.1 v2 2/9] accel/kvm: Include missing 'exec/vaddr.h' and 'qemu/queue.h' headers
Date: Thu,  2 Apr 2026 19:04:27 +0200
Message-ID: <20260402170434.94783-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
structure but forgot to include the header defining it. It is
however indirectly included via "cpu.h", which we want to remove.

The QTAILQ_ENTRY() macro is defined in "qemu/queue.h". Include
both headers in order to avoid later when refactoring unrelated
headers:

  include/system/kvm.h:398:5: error: expected specifier-qualifier-list before ‘QTAILQ_ENTRY’
    398 |     QTAILQ_ENTRY(kvm_sw_breakpoint) entry;
        |     ^~~~~~~~~~~~
  include/system/kvm.h:404:5: error: unknown type name 'vaddr'
    404 |     vaddr pc;
        |     ^~~~~
  include/system/kvm.h:405:5: error: unknown type name 'vaddr'
    405 |     vaddr saved_insn;
        |     ^~~~~

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..b5763a562d7 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -17,7 +17,9 @@
 #define QEMU_KVM_H
 
 #include "exec/memattrs.h"
+#include "exec/vaddr.h"
 #include "qemu/accel.h"
+#include "qemu/queue.h"
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
-- 
2.53.0


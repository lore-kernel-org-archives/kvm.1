Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7F3F1652
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506601; cv=none; b=qRGCWWmyCllBVLFmvbgrs426BiqmDeISKJQmwRboEdi1XueoZJIeeSs1T5q2foRzGJGtLiQzUQr9wvV6TN3jajf0bkoypYO8DacR0nNDT+L497sduTCP/9JhcIz3dK8hKGvtAai9VH+xXVF/H431GselfXUXeBsX2hrFVaLNR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506601; c=relaxed/simple;
	bh=0RoxEeTW+dkRhWnBSljqlypTBfGWhhyYzVBMtv6J90k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFSunFhG5LnJ98dhO6RWH3tMMykjAdn6vXPxnqsu2zqRJOEcuhwnvX90AYPsqD0er3u6Zr1JCZEP9aYUihP9SaGYEvcBlkdyyQ/VUqMOJWVEP6eJLKAJIN+I0rQMp/Jd06G2tMkkuAek3pAt1DXK2my2nanJzdPKtja5WLXezmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=wGRPGnYq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wGRPGnYq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3664df32e91so2822249a91.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778506597; x=1779111397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkBT5A6/LBnTeUPklgGzPFjB6isZzD11PPCRi8U3YM0=;
        b=wGRPGnYqM2xP6Xl5zyTyn17PSjpSTCxY0jsype3eiNLMmfsj0JXvxduOc98m6/NOfV
         M5+dVGRJ56lULvnvl0jVfm4RJOdr7bnhOwQsvzO0IokTGYPTRNP4m+8PXcYQxKMZ9pp3
         liGNt4gZKRnDn6ihVkQyhSmerZG37trM5U63Rb9SIcwAhw8fW9s3cy/PBZo6rjUdX2ZP
         neJrrjVgq4JmMSV9/lMtXd2lx8obwM2Q2+I+64uG64CqiZRFhBe2Y5tz7aNaK4bPC/9K
         DoBY0wdX1RgBgdmF9WHco5FBnXroUlR5cC/kEKbPP2cwnGqYFZ4jgbdIutcbg5+uHH6x
         BjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506597; x=1779111397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkBT5A6/LBnTeUPklgGzPFjB6isZzD11PPCRi8U3YM0=;
        b=QG6ke6W6MQ+ChVlm9Rt1dbti7JhkNgDq18luydeQEf4Mlw7SzddVduuY8oFQRCbR2M
         GtqmPGHVoRpXdqcsw3So9qqmVmOxvfMVC8FRIGALU9CzYzu9rpo5lKJTJlRWfCJ0CtTf
         MFtU2uEVD338ySS1sBQAzf3WC/rJ3BenWQuQdxBYZ6FgG8jJtXmOlGMjpjperAJGTn8t
         gTyLeBzn/4CtDR4jP0NhO6On3CxUwA8xp8+x5bMTjP9tFmh7ZI/1wekx8bpLXA0p2T3C
         eAsl/ZHhOPtckCXvPE7hNMU+7lfGOmShovzlRslKR16o/rm1Hmyu9SX850oxa1hRqFiE
         0yCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8R0i0kDWW0UJ62qKMttV9CVrsFmdL5c9phMrQ81vi56jlEcRvMX0YN77mk53vZJzfx5Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGCiur5bbwrY3vrnLygs6ZVEb/5s9QV0Z10TOaDORCjfCrWF8
	maAIKwEqfjhKdoLDzpiCwmdGGRyMj1BlbuxFFL7duhpYYcG1JaNIevWk6HYASZXI6Ss=
X-Gm-Gg: Acq92OF+aGPs7C5ZG7j71QuAEI6/5jYO7PaJ0uUF9kBgASrxF+XhMdtozeUNNtlfIil
	dJbXnuHjAzlASN6IlCQO73j5fL8/2hk0/EgeMd8gGW+xlvog5QtBWcKOqNrt4pnTt9STOljSo1d
	oL/atkLGfl89R2IjGM1eVM2fHE9HV7ngftLMWBEEdN5q3t2zW/1mgGWl2LHya75kgINhqvGj/Vs
	otUNEGOqlKyPpe7ICXfN4WQGYQARxela2bLjVlPijBzNatvEQIpmf8v+cns+UuCn/uTp3fYFqPX
	OwB7xDzW44tO3wYYNluqTZuSwp78LRYvfdj9WI4+Ou2QpV+R2UyJL+tgQbVsZcJHGEFqpfb1ObR
	0CXsLa0ohtlSY/djuv5QQDc5DC+QHTKEdEhmAnh78cCQ8VopGNfRQlAbmBqD9mdr1MvOhTjJSuK
	eASimpHfoiBnTrhq5Il7mD74f372uFGvMqPaswSmIe10s=
X-Received: by 2002:a17:90a:d883:b0:359:8de8:1229 with SMTP id 98e67ed59e1d1-367d487d1cbmr11028452a91.21.1778506596853;
        Mon, 11 May 2026 06:36:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be3daafesm3034326a91.8.2026.05.11.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:36:36 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 11 May 2026 21:34:47 -0400
Subject: [PATCH v2 02/10] riscv: hwprobe.rst: Replace tabs with spaces
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rva23u64-hwprobe-v2-v2-2-21c5a544f1dc@riscstar.com>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
To: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
 Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

A handful of vendor-extension entries indent continuation lines with a
tab character, while the rest of hwprobe.rst uses spaces. Replace
those tabs with spaces so the file is consistently space-indented.

Cosmetic update, no functional change.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: No change.
---
 Documentation/arch/riscv/hwprobe.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index b1a84ac06da75..c3bb26d70c748 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -358,7 +358,7 @@ The following keys are defined:
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
         extension is supported in the T-Head ISA extensions spec starting from
-	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").
+        commit a18c801634 ("Add T-Head VECTOR vendor extension. ").
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicbom block in bytes.
@@ -371,19 +371,19 @@ The following keys are defined:
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVQMACCDOD`: The Xsfqmaccdod vendor
         extension is supported in version 1.1 of SiFive Int8 Matrix Multiplication
-	Extensions Specification.
+        Extensions Specification.
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVQMACCQOQ`: The Xsfqmaccqoq vendor
         extension is supported in version 1.1 of SiFive Int8 Matrix Multiplication
-	Instruction Extensions Specification.
+        Instruction Extensions Specification.
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFNRCLIPXFQF`: The Xsfvfnrclipxfqf
         vendor extension is supported in version 1.0 of SiFive FP32-to-int8 Ranged
-	Clip Instructions Extensions Specification.
+        Clip Instructions Extensions Specification.
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccqqq
         vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
-	Instruction Extensions Specification.
+        Instruction Extensions Specification.
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicbop block in bytes.

-- 
2.43.0


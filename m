Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AA3EC2D0
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506595; cv=none; b=I7JWVequVUFV1LpnSkFd2FbcBaTtsAtqwW7t0UC86kglJd6H44DVkbwKWHaJlw5E3Ojqg3Y0ZsreRfrIVDvHga5iFx2HZI6DHHoFJUYhNl+SoPOfeOp2CcLF/V5JgzPBKAVd5126DnLmiYC2wpzchRBp+Om46Icrqfi4rAORCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506595; c=relaxed/simple;
	bh=SZNfq+U9n3x985DbHaankrwq6lQqgPLZMKPvxc9aSu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHUZ+8ucuA5P6mrkkPPrCkKvmebWWHuKTz9V8+4I8iM0UW7ZxBECJhV7RsA3OYTj1zmEhhcINLN/Abe8xEv1J3kKL7DxQGysuocRgZ2DTOZizVuVW6SEafGb2MMpTYyRSTBz0qjTzQQz4gE6njPc7dAl6R7I1lU47al6VFhEzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=YW7uJepC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="YW7uJepC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-368763a1bdfso531592a91.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778506590; x=1779111390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOFE3ehNiNk6algJYrLucEv0fxL7pkMWqS8jdXvY7Mk=;
        b=YW7uJepC/6HjTt+PnLp5QuhbbRgG2pceJi8Hk9FQksPBk8x6kg4+zs4YZt62yhIyWo
         tJBlOGjY9hin7DEkM5lbwrYMw1uUcIE8Mdw3+T+IpXSDdvUfTjULXatPaUbTx+T4Q6R5
         5UwxCl83uSXipnZVNoddc+Nt8WuMUBqcwhZW6QCUlKYI1H+AhpuGrvd0T3x8Dc1nGa34
         ZMP7aNYkL57URmclP+cpkr/7SKgJPwmbSEYvLGHw66O+hKFzPcWoUxfTMm6hwpHbSd9j
         fW+obcGaaq32x1oQskwKKq0JSAchxiSjN5r090oG1gS/9/KVhhPRqKDioURGlIV16pF9
         I3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506590; x=1779111390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOFE3ehNiNk6algJYrLucEv0fxL7pkMWqS8jdXvY7Mk=;
        b=SpNwArUV9GsBEcuSWndFXnNLDo7UUxydWD+bhMmeI4QcQ6oyKyONiI69Ac1yDemMd/
         BayJOyWhKwHKPVW0+LCLKbp+6MtHSDGP3fnvEw/XG+Z5fxVuOvSTznvGlNvh8Bss+ZuS
         2CrdGFY6xxLhY9KHPD0KAnmMS3wixrG8f0yEBEsgW7FK6/Ww+GJgtCIjZ8zRRTbIn94N
         2ZKERiXIzjnF9tSbjSSOKEPmbQYK1i442YqmdrLUOfRoNxh7RKpwQjzNZvBysznDal/j
         3B7Qund35Fjb7JSoOhKUXkUDVJBgLbwWsrpjIdHJOCUvEBSeYBeSfvUPL92HtRJWmSdb
         CZHA==
X-Forwarded-Encrypted: i=1; AFNElJ+YZBaNIraFUjpNBDOzpzJrpxrxIgC5W1vkwszXx3AxjHcgTNzP2x1MmpAVWrxSEC/mtOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWOx1a9fIU7RXc7+alBP8/NOZJuc7/CWF4NlTtyui0aypTtxf
	HWTf/2+5bG7yQynqXmidIFV4S33Z3dhZRx1Qo6Kprr/cY54YOTtoduFb1phDkjaIGn0=
X-Gm-Gg: Acq92OFKj6zhX+IeMnioWSCFJoAH53jCHS/VktgJlVfwiyLD2hIDcRqiUzQIyjjxpIT
	tU1FmO0TLUK5XMGyTdGzpJvqOt9INJSPQlsW2fm3qwQ7mA665iWqOVsh+84g9hc0NA7ihL2sVHx
	My3lLbBsMObxvgZ1HvXQ5nT8tfaPxDTSkvSWtk2KKWi8HKFBHNB546mY+O+G69R3fkrCINzl63v
	aDWYIFekMVMJSDuJneIerTOT+T+J0onu1k6SOCD+hTWZr9GwJz6yolBkNn5BqSEzX7IiINd2HW+
	Vqn07ecnstYCyfs+NyAxj+WvijQK0NTsfZKHMNZX6OgEdQIcSRpR33t8aX4bC5KvBo6LMAe5o63
	txVrn9OaSRejZnwVb26mOukfYY8L10Kt3FOY5kabkcZB9CKieaC55K2undK+YVoG3q5zJ3ij5yh
	3Qkk3YejyOwCcFMw1lT05WXn0En0jFo1KZgQsWuEEA6TE=
X-Received: by 2002:a17:90b:38c2:b0:362:e7e5:a20a with SMTP id 98e67ed59e1d1-367d46c6798mr10065289a91.4.1778506590008;
        Mon, 11 May 2026 06:36:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be3daafesm3034326a91.8.2026.05.11.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:36:29 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 11 May 2026 21:34:46 -0400
Subject: [PATCH v2 01/10] riscv: hwprobe.rst: Document EXT_ZICFISS
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rva23u64-hwprobe-v2-v2-1-21c5a544f1dc@riscstar.com>
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

Commit 30c3099036a9 ("riscv/hwprobe: add zicfilp / zicfiss
enumeration in hwprobe") added RISCV_HWPROBE_EXT_ZICFISS as bit 0 of
RISCV_HWPROBE_KEY_IMA_EXT_1 but did not add a matching entry to
Documentation/arch/riscv/hwprobe.rst.  Add it now.

Fixes: 30c3099036a9 ("riscv/hwprobe: add zicfilp / zicfiss enumeration in hwprobe")
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: New patch.
---
 Documentation/arch/riscv/hwprobe.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index c420a8349bc68..b1a84ac06da75 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -391,3 +391,7 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_1`: A bitmask containing additional
   extensions that are compatible with the
   :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICFISS`: The Zicfiss extension is supported,
+       as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
+       extensions specification, ratified 2024-07.

-- 
2.43.0


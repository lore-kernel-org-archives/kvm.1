Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D13CF02C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441992; cv=none; b=gnQ7FA8QLgB6NbhkI9iin/dEadna9GXx3dIj2Cazv/BA5JLYBl0LoKIiIGJHaJm3YI5ZzeFLL7Kh8mNSyXSNi2bLzYqFRP5xSM3Lew4/9KHI/x918rwPU2zpGfdwLlsaQJLlx/nSvyoU9BunOdHoQsRqhTDdve4smPYUwl6Hu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441992; c=relaxed/simple;
	bh=rqTVVVJCoPVd96u+yhPMJffItnZ+P3H94JKRDHrTXaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPp8SvQPjOQX4y4gOjEAGKQbSP5v1AzBXTVCpAP8G3VSpk+FnC9/Uu79V5/spNngpZ/H289wIgjKCfvMhJWJxxgTAw01Ak/g4xugKjU2zl76EFfkTIjH6sI87dc4l/FfyK4c7+DKM0bWZnsSet5QnEK1HnE2KnOdAkqoEk/R42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOR2x72e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOR2x72e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0b9328c4aso24164495ad.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780441989; x=1781046789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHFIY+oFxYCby8roDhyuYsQin7Ul79zLqHihVHlWSyo=;
        b=TOR2x72e4nZ/3IXqxyDzSK70BSJlbKMDi+j8bZsL0QcBFP3K6IdSD6wP5enKJDNO/q
         aYeuHTLhWFNVL5DgV4Jipm827iiZpKGr6OZ9oV9whmVMBsVdMSrJCP3y4zYupQhUNc4x
         wrCqjVAwpNMoQaAQ79jDEupyEmBsRrxeSDDHrqlC/3HIgvkjR9IGhpJRvCvxtiu/nhMe
         ZeG43WzvOoFfb/xlYxDHWa5qleUioVAEDIYGrSCcjHDwW9lLBYMvuoF4GicdvwzcOXUb
         NQM5wO3lDogTEi4LJ6hjhHXLor+WSQd5dApNuTYmtXb0m/jzoiQCu3uXQ1uSyWbFthuR
         qdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780441989; x=1781046789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hHFIY+oFxYCby8roDhyuYsQin7Ul79zLqHihVHlWSyo=;
        b=RwCQLZGDrdTDIRul6YN5EqeISiX72Sl1HhueqlwL8tQa62DxXrQr/0lloaV4jotCXz
         0qkmPgBpT+EEC36ZrfD3Wph3Ektz5BucuzkwtsywKDfe474A3PruDKOg8LduAioZNtH4
         oVEc3YfT1SzDaG9/wqiLm4dNwajzyqnxxFPhowooOuWJPvnhmEdoSy1HAfk0d1yJabPD
         loR1Gg1HSMdopRiit/4hnF3NqUKQp8uHU5c0P4Bzu99EeQ+SZu/q6/0pLTpfZaJOs78L
         Wx/0590Ko9A8NPOnDMvXdrFJha5nhowAGF65+DGPBjzdwvwk6yYT/5+/Ae9oQbd7gTg7
         dBUA==
X-Forwarded-Encrypted: i=1; AFNElJ/BiZOxk617P/slMP4rUx3Q8gKruoKklfONdfwFafE5EMGYDe0uOOI2mOSllhYYb4ZF9Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQ7nFJyL3LE1yvxrJJrVeRiq3yMx0BZaOiXb46PkYGjaWVEyG
	44HQkPMa4o2z5k6GFhQjJqtySVdEnPK9mRWTdgz2UToVZeoPt8eLSg5o
X-Gm-Gg: Acq92OFv2rYrVv7tPS6+VC8ZpZu9s7jG6rECcFFRVqLBDUU+IgiGOkWJy7mn+RWdi2e
	S5KoUh0lLSc83Z1HxGTzSuYGSMKZBis/7iOPkdLOPzOlZezv0/F8dCc7zssg4sS4zCGHJS4D3WS
	tWDdPyGNM1M999ZRpPV6QrHK/DLKb2u6BmxeM/LfWHHDTluI7jzrvr/u3FveMf6YmV3LtbVgTcm
	Ie3fxdbGprCX66+k+lqGZtDMmB6Tt84Ri9tR3ZFPZqg/iHPcfJP8+i5Tk4VoK9JST41EXSIIzo0
	wgMdTPJMJ9SJ99MEYOz+vONYB6J5yrEjvDhyxCencxJJZVBJPs9HlAHtVAQpBCK8g3d1MkwUSSD
	Fexv77KUkI/5WnRR6/BJq+qoQC5gZAL3apgykhjsd3WetmfuLYn5vcl1rvfrYenTyNjD1Yf6ZnR
	FzzaNvmZZKCCq8wW+7bQ8R
X-Received: by 2002:a17:902:c950:b0:2bf:3074:34dc with SMTP id d9443c01a7336-2c163a59aa1mr7469645ad.14.1780441989552;
        Tue, 02 Jun 2026 16:13:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm3302965ad.75.2026.06.02.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:13:09 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 03 Jun 2026 07:11:57 -0400
Subject: [PATCH v3 02/15] riscv: hwprobe.rst: Document EXT_ZICFISS and
 EXT_ZICFILP
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-rva23u64-hwprobe-v2-v3-2-5529a7b28384@gmail.com>
References: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Shuah Khan <shuah@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 sophgo@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Charles Jenkins <thecharlesjenkins@gmail.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=rqTVVVJCoPVd96u+yhPMJffItnZ+P3H94JKRDHrTXaQ=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiwFHmbj4O13uthymy6JvU+rEL4dKfZMr+tUpU9DpyHf0
 ydWIhM6SlkYxLgYZMUUWQ4fbcne+son2vc55w+YOaxMIEMYuDgFYCI1PQx/eHnlc18+d3FcUZbm
 v82hY/8q8W0sHw4vvh+j1hzCevjDDkaG66/Wxs9YyBsrs37Fy717DyUeav92P6Wk2bE7UWuB6nZ
 dLgA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

Commit 30c3099036a9 ("riscv/hwprobe: add zicfilp / zicfiss
enumeration in hwprobe") added RISCV_HWPROBE_EXT_ZICFISS and
RISCV_HWPROBE_EXT_ZICFILP, but did not add matching entries to
Documentation/arch/riscv/hwprobe.rst.  Add them now.

Fixes: 30c3099036a9 ("riscv/hwprobe: add zicfilp / zicfiss enumeration in hwprobe")
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v3:
- Also document RISCV_HWPROBE_EXT_ZICFILP (bit 63 of IMA_EXT_0), the
  sibling enumeration added by the same commit (Andrew).
v2: New patch.
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index a09a8f16bd16f..3cedaaa53f331 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -289,6 +289,11 @@ The following keys are defined:
     defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
     load/store pair for RV32 with the main manual") of the riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICFILP`: The Zicfilp extension is supported,
+    as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
+    extensions specification, ratified in commit ff03d8485a04 ("Update to
+    ratified state") of riscv-cfi.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
   :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
   mistakenly classified as a bitmask rather than a value.
@@ -391,3 +396,8 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_1`: A bitmask containing additional
   extensions that are compatible with the
   :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICFISS`: The Zicfiss extension is supported,
+    as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
+    extensions specification, ratified in commit ff03d8485a04 ("Update to
+    ratified state") of riscv-cfi.

-- 
2.43.0


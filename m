Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F4369D64
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208809; cv=none; b=Oymb3cixkBlmJ5nudxm5DT4uD0X89Iaj9FsThbBogPgJuyXBRrRQkh+ETjHUOIU1VtpBhCrLyVJUUEZ3yfX9BP69JwvTZcvmVF64gDyL5YIajlTNaAIg16WBg6If87RFmK5giUbrJVj0VXe9TyMRFlDCcyyhXwjefH3n51wnoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208809; c=relaxed/simple;
	bh=q/QLrWSGJJhQtCezKRc6txtE+UkVnOpKgnOg6fjEGdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiLRJzDt3Wvgwhj/w5QpRoYoJtv6p0MUu0BDMaoRGtxLWdkMK9I06BDGe5JwTku1bdti0tgjOucyxiE5mK5LyGDAkZbcqG3WeILWYrZKfyQVeL4i7th/00ETw45yKM5m/7Fo3RQx9nZloKFtjDYcvxOt4kH6UygzWSiz1HRVtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI6qqUok; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI6qqUok"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0b9328c4aso2551285ad.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208808; x=1781813608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm44aTTKOxWn0lKZi70AX96tEsXQQm8LgJ40+/hEF0Q=;
        b=kI6qqUokt0GU6PTeVVWprdc80dAzZjvb7KJASalkAl+9n9iMrwDQ1daHyu4qM/OaW8
         mWMW74iNSKw1FAU0/mX7xWz7Scc6uJ2mLC5pQ784EZMzg7I1kETHt4S/28qCi3EhDGF2
         7P/Fe2EckOpxbJmpKaPZGgZ2kkhVeWjXeliR5LAy6q+K/szkEtVw2eZH+Gsn21OErkbI
         D7FwImBbAzSgUWWbuDzTNZYleVOKfmFD0u+F4OvikISN+ENlCgjuvjoPB/WPFv+hA6hs
         a9kjPy4jq5gT+AIeZYjzrbIvg5FyqkdOM9bdSERE2dguuJVjOHqdNWXcA9RbIvBAUyF2
         cVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208808; x=1781813608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gm44aTTKOxWn0lKZi70AX96tEsXQQm8LgJ40+/hEF0Q=;
        b=WuIWiiMqF27GFkrdBYaXJ7VdfsA41Vjrbpz1nRZeRWqVdhIj3YOPDp8JeECE5MK6tm
         kemZFWi458w4/GmRzmSx5uxDrO7Albc1YH43feRgkUSmInJv6jONXj0TcbdnUeLXIfSh
         pCr3w8B1M/6mO8DMpwQ5C58tJvCYGS9qgq7lDkfiAAjJtsCBJCyeIxL0NvLWpZFK0ktd
         IR6L5213imwaLeNXgxGDakEzevlt1gpYasLxo6GzhYTlvJJ3n5sk42AKJAlY7ilGUP9N
         L5p7YkO7BIdjs5JzX4uBh2j4qFNAplH4QaSW8jNKSZKKdBXSL+t9LLikTIXVmgB5pZmk
         5myQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t+ZoVVgT87N86V+n0HPRc/r1hum5AzNucpB2aRIYTbpO8vM6cD3GSww3KRAVX5eRmbdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/cUEXm+VypS72R3sY6TWuv61bff3PeM7WxRb0FYUTp7Pm7j0
	zfDUZvGm/UAnebeauw9XjsOzJXg/U8o16TyEPFTSU353l6Ta4NJqf1cy
X-Gm-Gg: Acq92OEBatel0A0rTfhmWOMSlWJZAvZymjsv9o7uMze07Y0o34Eui0VMkJwWqtXPrr6
	4FdFgn+6JTfffLywzDLyOmKWuK1VPilgI/4mDcTEG5ObxWnWgeFj5HDhwPDbFQgMvrq6kF7ocA9
	O02Y4VER5F4DZOf5rxQHCXpXBSs+A/3KiwVCrkjepnkfj5EYepiqDTnWw/7kqjQGmbd5qkhgDg+
	O+iN7jiHtsDaSFbCTCgZhDElt3id9/Ka3kjeP5PTW9L2yEWoxugSrXmwfe6STOl1N/OYRPaFZA/
	spLTOnXmX4PnyyRhrtgDaKSMlj+UyLc6QcKDfdNqKDcW9Z28sIHlhez91Ao7uhHE7pe0wXO8/Le
	+RIpUg4OJN7o0Gg/E5KY5vnVv34lB1JMAE6BsFLUYCs4g6GIj3gwVyy8ZjN39ZgoBriWhN18DOQ
	==
X-Received: by 2002:a17:903:4b46:b0:2c1:6259:cda8 with SMTP id d9443c01a7336-2c2f22a9f06mr51888325ad.25.1781208807828;
        Thu, 11 Jun 2026 13:13:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm288730475ad.22.2026.06.11.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:13:27 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 11 Jun 2026 16:12:40 -0400
Subject: [PATCH v4 03/16] riscv: hwprobe.rst: Document EXT_ZICFISS and
 EXT_ZICFILP
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-rva23u64-hwprobe-v2-v4-3-3f01a2449488@gmail.com>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
 Guodong Xu <docular.xu@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=q/QLrWSGJJhQtCezKRc6txtE+UkVnOpKgnOg6fjEGdI=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixtsQMhX89b/jK+JCRn0MornigW9b3hyMPzwofO+E6Zo
 OCz7+rMjlIWBjEuBlkxRZbDR1uyt77yifZ9zvkDZg4rE8gQBi5OAZhIxBeGf9qm976639f69W0V
 w+nNF3xEdGem/L+z0GGNnnNgRX2FMgvDf7dtpZJc33bcTb0lVM65UDi3+C+rk0eI372LQmZHZb7
 e5wMA
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

RISCV_HWPROBE_EXT_ZICFISS and RISCV_HWPROBE_EXT_ZICFILP are defined in
the hwprobe uAPI but are not documented in
Documentation/arch/riscv/hwprobe.rst.  Add documentation for them.

Link: https://github.com/riscv/riscv-cfi/commit/302a2d45c2435940d9a63571c66bc038adc74133
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
v4:
- Update the commit message.
- Cite riscv-cfi commit 302a2d45c243 (tag v1.0) instead of ff03d8485a04,
  per Andrew.
- Add a Link: tag for this citation.
v3:
- Also document RISCV_HWPROBE_EXT_ZICFILP (bit 63 of IMA_EXT_0), the
  sibling enumeration to ZICFISS (Andrew).
v2: New patch.
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index a09a8f16bd16f..d9928641deb99 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -289,6 +289,11 @@ The following keys are defined:
     defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
     load/store pair for RV32 with the main manual") of the riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICFILP`: The Zicfilp extension is supported,
+    as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
+    extensions specification, ratified in commit 302a2d45c243
+    ("Update build-pdf.yml") of riscv-cfi.
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
+    extensions specification, ratified in commit 302a2d45c243
+    ("Update build-pdf.yml") of riscv-cfi.

-- 
2.43.0


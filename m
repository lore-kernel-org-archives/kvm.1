Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C483CDBCF
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441983; cv=none; b=PjbJMOueB0kndO01bzHIdgpr7kqWmySQRqpsUMgzLSwMoYpxBDAU4YN0z0+4kmczYO+8adbcCDmm6J8SyB/WwIcjNr1fOek4528bBUCxBiAAqWwHOHRc2Ai/stcNf5D4zsKgP5hftmj9TLFE8n6C/ULw148hPx1LPt3WMS6MuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441983; c=relaxed/simple;
	bh=i+bSIzD9+RiKWCP11BdhBb8f9cURvGwMJkPT72+TQ9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFx41XoO4f2LfgVChBJTR7bEyc5aww7pfT4Mw/cpDYtx1lrETipFnr+xus4XfSr2WHviJ7xRgBmJ4r7pNbCGmDraVCmLQ0dfz+QPDj1mcTMou6Ha772Wt1u58p/br5szfsX3D3hF1B4SHYSPn56Aw57kVpXjEJ9xU0Bob1Knk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGjU8km8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGjU8km8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bea7176c72so94574275ad.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780441979; x=1781046779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=at7eAXfC0U9LH2oH4voN5YpVnxe6Tbb3DG6Uoa+BbDk=;
        b=bGjU8km8EMEA3CW6KivU39xLuhdgiT33LurGU4B+VdYFmoUUd0/wHKfFFgaAPcd4sw
         RtQgDfuy41imHbBsjF4EYLtFm+GCc5tjYi8aWhi2Yz7FzZLSwqHIBNLHa6hT1J7WENcn
         BR1F5tuDqGelLuzagAkZrO5rn0/PTYuFY+Q8ZMsaQWymZxfoQnHPcmu+rTsTWcr1He0p
         phpcJfKLmlE1mdYjDosBd6FPRf/Z+vkt4TIKTqNEGoWhTFqG9W6V9QoqEjZXOBQC23CO
         0bV1NlqbKVPnCAIT/rOyahnt+dlbdn1+gMQ9AL5Msv27YIsJLmQ6yqm8jcWhaxEPNr/k
         2DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780441979; x=1781046779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=at7eAXfC0U9LH2oH4voN5YpVnxe6Tbb3DG6Uoa+BbDk=;
        b=tENnYXdPoqbnIvKZlhe9HH/7HRkM8ftYbIrvG2c1rZmHSyWRYpJO56QFu9DQJm3PZ1
         0HsqH8UxxlkHoNqqm1xb/vzTlScSmX6xbScp2uLnqc2FXxjSdZxVUbWlZH0KWbt+T87L
         JMPh1nwuQqL+ep8ytt5Nblsx0e+XMU0cGGJ+WB5O6gYm28KBbejKx9cgdbJEtF93Yegb
         DlNU1TsL/dVe9Hvq5A9KuglcHCd2zkrOu9D7HfprbS3LFyZU6C9GViExsKyL7hgDeNBr
         sNV+3JHvb5R28+Vqaufv3gspzDPGZVWBFWiZgHFcbjqQTDtj6Zpj2Po47PgrT5+WT6PG
         k4ww==
X-Forwarded-Encrypted: i=1; AFNElJ8ybGlJd/g09g+rxr2KmFYcjT6YLS078TuqP3mmlWPSy5j9gZ2KQMsE323rxaRaTnSdPgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwovKACYbQ3SfR6N7osh+nWBqxgskG5FIjGwgyhdJBxALB0Li
	pkPNAnabWfSrfNaCUWCzzz5FgmCGmVZtPyJkoWWx7/ZjmGYYnJa7rOGB
X-Gm-Gg: Acq92OH86DEQfQV6iRe1pxDO3/ynTCnm6DJhkdrSN2bARl2Qs/a5k5KazLJ6JHdNWic
	Rci2JOC/HixJSIyjWgG5TxcXUITnlz0qubCUvkCPw7n8OPULqh613JVCocmxMyLZoYPzgcJz93Q
	uMsdJWu9b9QJqJWy5RzgDbo0KMe5IF3Dns0Ne91nn2tz9f7zsFD39IXr0vaRO+PZFixyDhays45
	Bt17Wf8rhfz3ZNvn4mSlVN4U3nABYfdmxCa5o/Up7CIIaaMvcYXvaA4+G4Hj4HzGo0Hl6YSEIYe
	zvrQ57XpC6sKnKRr7B3ia39y0JUwz1U+1rd1pq0qGedWy5JfwLOfbOz2b8sfjJg71qqcuIqM+MA
	nvG6MezCs/yApiOR1FbzZGlEbNVJzNLnqApxKG8JHBS6Q+Lapno978uouosz42cZt0MfGhb2Rcz
	f0HASdujTBrozLQqgJKm4c
X-Received: by 2002:a17:902:ce87:b0:2c0:b4f5:41e0 with SMTP id d9443c01a7336-2c163d8f7fdmr6885635ad.26.1780441979026;
        Tue, 02 Jun 2026 16:12:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm3302965ad.75.2026.06.02.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:12:58 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 03 Jun 2026 07:11:56 -0400
Subject: [PATCH v3 01/15] riscv: hwprobe.rst: Make indentation consistent
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-rva23u64-hwprobe-v2-v3-1-5529a7b28384@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20508; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=jQ+FZ1a4caFuCxBYqE0mSSFty3fjCcqiDo3iX06WP7Y=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiwFHub4ddWsl1beWbpj4xopx3qvKwz7152L6d3As2G7d
 YPG4Sk6HaUsDGJcDLJiiiyHj7Zkb33lE+37nPMHzBxWJpAhDFycAjAR/ihGht/hCVzTZ/8J4Lwe
 rr+MeTnXE90f395Fabuaz6rsnDklfjHD/5rJGpMOpr5eeoflc73exQ2LQmutJnG/T6z/an7llfL
 L8+wA
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

A handful of vendor-extension entries indent continuation lines with a
tab character, while the rest of hwprobe.rst uses spaces.  In addition,
many list items align their continuation lines under the 'm' of
':c:macro:' (column 7) rather than under the item text (column 4), so
the file mixes several indentation styles.

Replace the tabs with spaces and align every list item's continuation
lines under the item text, giving the whole file one consistent style.

Whitespace-only change, no functional change.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
[Guodong: extend from tabs->spaces to normalizing all continuation-line
 indentation across the file]
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v3:
- Move to the front of the series.
- Extend from replacing tabs to normalizing all continuation-line
  indentation, so later patches add documentation on top of a
  consistent base (Andrew).
---
 Documentation/arch/riscv/hwprobe.rst | 194 +++++++++++++++++------------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index c420a8349bc68..a09a8f16bd16f 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -82,121 +82,121 @@ The following keys are defined:
     version 1.0 of the RISC-V Vector extension manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBA`: The Zba address generation extension is
-       supported, as defined in version 1.0 of the Bit-Manipulation ISA
-       extensions.
+    supported, as defined in version 1.0 of the Bit-Manipulation ISA
+    extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBB`: The Zbb extension is supported, as defined
-       in version 1.0 of the Bit-Manipulation ISA extensions.
+    in version 1.0 of the Bit-Manipulation ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBS`: The Zbs extension is supported, as defined
-       in version 1.0 of the Bit-Manipulation ISA extensions.
+    in version 1.0 of the Bit-Manipulation ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is supported, as
-       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+    ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBC` The Zbc extension is supported, as defined
-       in version 1.0 of the Bit-Manipulation ISA extensions.
+    in version 1.0 of the Bit-Manipulation ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBKB` The Zbkb extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBKC` The Zbkc extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZBKX` The Zbkx extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZKND` The Zknd extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZKNE` The Zkne extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZKNH` The Zknh extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZKSED` The Zksed extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZKSH` The Zksh extension is supported, as
-       defined in version 1.0 of the Scalar Crypto ISA extensions.
+    defined in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZKT` The Zkt extension is supported, as defined
-       in version 1.0 of the Scalar Crypto ISA extensions.
+    in version 1.0 of the Scalar Crypto ISA extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVBB`: The Zvbb extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVBC`: The Zvbc extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKB`: The Zvkb extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKG`: The Zvkg extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKNED`: The Zvkned extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKNHA`: The Zvknha extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKNHB`: The Zvknhb extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKSED`: The Zvksed extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKSH`: The Zvksh extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKT`: The Zvkt extension is supported as
-       defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
+    defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZFH`: The Zfh extension version 1.0 is supported
-       as defined in the RISC-V ISA manual.
+    as defined in the RISC-V ISA manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZFHMIN`: The Zfhmin extension version 1.0 is
-       supported as defined in the RISC-V ISA manual.
+    supported as defined in the RISC-V ISA manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
-       is supported as defined in the RISC-V ISA manual.
+    is supported as defined in the RISC-V ISA manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVFH`: The Zvfh extension is supported as
-       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
-       ("Remove draft warnings from Zvfh[min]").
+    defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+    ("Remove draft warnings from Zvfh[min]").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVFHMIN`: The Zvfhmin extension is supported as
-       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
-       ("Remove draft warnings from Zvfh[min]").
+    defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+    ("Remove draft warnings from Zvfh[min]").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZFA`: The Zfa extension is supported as
-       defined in the RISC-V ISA manual starting from commit 056b6ff467c7
-       ("Zfa is ratified").
+    defined in the RISC-V ISA manual starting from commit 056b6ff467c7
+    ("Zfa is ratified").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZTSO`: The Ztso extension is supported as
-       defined in the RISC-V ISA manual starting from commit 5618fb5a216b
-       ("Ztso is now ratified.")
+    defined in the RISC-V ISA manual starting from commit 5618fb5a216b
+    ("Ztso is now ratified.")
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZACAS`: The Zacas extension is supported as
-       defined in the Atomic Compare-and-Swap (CAS) instructions manual starting
-       from commit 5059e0ca641c ("update to ratified").
+    defined in the Atomic Compare-and-Swap (CAS) instructions manual starting
+    from commit 5059e0ca641c ("update to ratified").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2.0
-       is supported as defined in the RISC-V ISA manual.
+    is supported as defined in the RISC-V ISA manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is supported as
-       defined in the RISC-V Integer Conditional (Zicond) operations extension
-       manual starting from commit 95cf1f9 ("Add changes requested by Ved
-       during signoff")
+    defined in the RISC-V Integer Conditional (Zicond) operations extension
+    manual starting from commit 95cf1f9 ("Add changes requested by Ved
+    during signoff")
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extension is
-       supported as defined in the RISC-V ISA manual starting from commit
-       d8ab5c78c207 ("Zihintpause is ratified").
+    supported as defined in the RISC-V ISA manual starting from commit
+    d8ab5c78c207 ("Zihintpause is ratified").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
-       is supported as defined in the RISC-V ISA manual.
+    is supported as defined in the RISC-V ISA manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x is
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.
@@ -214,84 +214,84 @@ The following keys are defined:
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZIMOP`: The Zimop May-Be-Operations extension is
-       supported as defined in the RISC-V ISA manual starting from commit
-       58220614a5f ("Zimop is ratified/1.0").
+    supported as defined in the RISC-V ISA manual starting from commit
+    58220614a5f ("Zimop is ratified/1.0").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZCA`: The Zca extension part of Zc* standard
-       extensions for code size reduction, as ratified in commit 8be3419c1c0
-       ("Zcf doesn't exist on RV64 as it contains no instructions") of
-       riscv-code-size-reduction.
+    extensions for code size reduction, as ratified in commit 8be3419c1c0
+    ("Zcf doesn't exist on RV64 as it contains no instructions") of
+    riscv-code-size-reduction.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZCB`: The Zcb extension part of Zc* standard
-       extensions for code size reduction, as ratified in commit 8be3419c1c0
-       ("Zcf doesn't exist on RV64 as it contains no instructions") of
-       riscv-code-size-reduction.
+    extensions for code size reduction, as ratified in commit 8be3419c1c0
+    ("Zcf doesn't exist on RV64 as it contains no instructions") of
+    riscv-code-size-reduction.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZCD`: The Zcd extension part of Zc* standard
-       extensions for code size reduction, as ratified in commit 8be3419c1c0
-       ("Zcf doesn't exist on RV64 as it contains no instructions") of
-       riscv-code-size-reduction.
+    extensions for code size reduction, as ratified in commit 8be3419c1c0
+    ("Zcf doesn't exist on RV64 as it contains no instructions") of
+    riscv-code-size-reduction.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZCF`: The Zcf extension part of Zc* standard
-       extensions for code size reduction, as ratified in commit 8be3419c1c0
-       ("Zcf doesn't exist on RV64 as it contains no instructions") of
-       riscv-code-size-reduction.
+    extensions for code size reduction, as ratified in commit 8be3419c1c0
+    ("Zcf doesn't exist on RV64 as it contains no instructions") of
+    riscv-code-size-reduction.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZCMOP`: The Zcmop May-Be-Operations extension is
-       supported as defined in the RISC-V ISA manual starting from commit
-       c732a4f39a4 ("Zcmop is ratified/1.0").
+    supported as defined in the RISC-V ISA manual starting from commit
+    c732a4f39a4 ("Zcmop is ratified/1.0").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZAWRS`: The Zawrs extension is supported as
-       ratified in commit 98918c844281 ("Merge pull request #1217 from
-       riscv/zawrs") of riscv-isa-manual.
+    ratified in commit 98918c844281 ("Merge pull request #1217 from
+    riscv/zawrs") of riscv-isa-manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZAAMO`: The Zaamo extension is supported as
-       defined in the in the RISC-V ISA manual starting from commit e87412e621f1
-       ("integrate Zaamo and Zalrsc text (#1304)").
+    defined in the in the RISC-V ISA manual starting from commit e87412e621f1
+    ("integrate Zaamo and Zalrsc text (#1304)").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZALASR`: The Zalasr extension is supported as
-       frozen at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+    frozen at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZALRSC`: The Zalrsc extension is supported as
-       defined in the in the RISC-V ISA manual starting from commit e87412e621f1
-       ("integrate Zaamo and Zalrsc text (#1304)").
+    defined in the in the RISC-V ISA manual starting from commit e87412e621f1
+    ("integrate Zaamo and Zalrsc text (#1304)").
 
   * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
-       defined in version 1.0 of the RISC-V Pointer Masking extensions.
+    defined in version 1.0 of the RISC-V Pointer Masking extensions.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
-       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
-       ("Added Chapter title to BF16").
+    defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+    ("Added Chapter title to BF16").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
-       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
-       ("Added Chapter title to BF16").
+    defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+    ("Added Chapter title to BF16").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
-       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
-       ("Added Chapter title to BF16").
+    defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+    ("Added Chapter title to BF16").
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
-       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+    ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZABHA`: The Zabha extension is supported as
-       ratified in commit 49f49c842ff9 ("Update to Rafified state") of
-       riscv-zabha.
+    ratified in commit 49f49c842ff9 ("Update to Rafified state") of
+    riscv-zabha.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZICBOP`: The Zicbop extension is supported, as
-       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+    ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZILSD`: The Zilsd extension is supported as
-       defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
-       load/store pair for RV32 with the main manual") of the riscv-isa-manual.
+    defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
+    load/store pair for RV32 with the main manual") of the riscv-isa-manual.
 
   * :c:macro:`RISCV_HWPROBE_EXT_ZCLSD`: The Zclsd extension is supported as
-       defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
-       load/store pair for RV32 with the main manual") of the riscv-isa-manual.
+    defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
+    load/store pair for RV32 with the main manual") of the riscv-isa-manual.
 
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
-     :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
-     mistakenly classified as a bitmask rather than a value.
+  :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
+  mistakenly classified as a bitmask rather than a value.
 
 * :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`: An enum value describing
   the performance of misaligned scalar native word accesses on the selected set
@@ -326,7 +326,7 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
 
 * :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF`: An enum value describing the
-     performance of misaligned vector accesses on the selected set of processors.
+  performance of misaligned vector accesses on the selected set of processors.
 
   * :c:macro:`RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN`: The performance of misaligned
     vector accesses is unknown.
@@ -348,7 +348,7 @@ The following keys are defined:
   * MIPS
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL`: The xmipsexectl vendor
-        extension is supported in the MIPS ISA extensions spec.
+      extension is supported in the MIPS ISA extensions spec.
 
 * :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
   thead vendor extensions that are compatible with the
@@ -357,8 +357,8 @@ The following keys are defined:
   * T-HEAD
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
-        extension is supported in the T-Head ISA extensions spec starting from
-	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").
+      extension is supported in the T-Head ISA extensions spec starting from
+      commit a18c801634 ("Add T-Head VECTOR vendor extension. ").
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicbom block in bytes.
@@ -370,20 +370,20 @@ The following keys are defined:
   * SIFIVE
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVQMACCDOD`: The Xsfqmaccdod vendor
-        extension is supported in version 1.1 of SiFive Int8 Matrix Multiplication
-	Extensions Specification.
+      extension is supported in version 1.1 of SiFive Int8 Matrix Multiplication
+      Extensions Specification.
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVQMACCQOQ`: The Xsfqmaccqoq vendor
-        extension is supported in version 1.1 of SiFive Int8 Matrix Multiplication
-	Instruction Extensions Specification.
+      extension is supported in version 1.1 of SiFive Int8 Matrix Multiplication
+      Instruction Extensions Specification.
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFNRCLIPXFQF`: The Xsfvfnrclipxfqf
-        vendor extension is supported in version 1.0 of SiFive FP32-to-int8 Ranged
-	Clip Instructions Extensions Specification.
+      vendor extension is supported in version 1.0 of SiFive FP32-to-int8 Ranged
+      Clip Instructions Extensions Specification.
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccqqq
-        vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
-	Instruction Extensions Specification.
+      vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
+      Instruction Extensions Specification.
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicbop block in bytes.

-- 
2.43.0


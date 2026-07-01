Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2B48AE10
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910450; cv=none; b=JgpUa2fbxMUhmimfuXK7wWaQUVEuemHQS84Ku1l7txHCWsMKWdCKEkrtGR/xNWliB4MM79LLhmZeqTqEK3Y+WIkL48AR41RH/YN+ZLEfZ1bB7r7YS/5XUeB9GhUXRs6B/4RAJ6FgTLnQ8nFxgvxfs1lGGnhfjpW9DjVxgFQo2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910450; c=relaxed/simple;
	bh=zzv4RpzLQz9N5QJYuvZNdW9u/BeWJDgXt1lzr+Z9BYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rokzb3IBNmsumLMc3GPwHiQyqOvMQVDmKN/OapORlB77+temM+NXhkbKXFXncyoEOWgnsKpgKFp4ImUoXMS+x4DX9Vy6AA4HXTA3Saqp/QkUDm1Uu6igFtjZwVr3ReJGTCjVCv/ZmNmkF51OdHhynIG7bEvcbYcvUA/8gt+Bhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvGIufJu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvGIufJu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8471013fac2so314850b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910448; x=1783515248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNYo/DlbFIEXnMINvFtAOJPsCSUEkojp0EkJfm5QRDw=;
        b=QvGIufJuBXpOyKkxA+Am2pZiNpnK1dHx3bxy7Vr0v2SlOFkOIwVu3Musx0D6AFydGK
         0iWum1cfSp+cvsySz8T4tYKPKtIk63DVmmk7PjiakxbhK0qo7vBCReU6Q3rMAw1wOZAw
         Lx/tjG6EPduT7ZF/z8qWdHwHCTKaLyVRNelFVz8eIqXWtYd2q8k4stEvAKV7i9rUUl8z
         anqrWw6n+NWxIbC/StmUQLglnpxoycLctsjDeZ0B0TD1scpcH+zPSFIdL6HWOvCNon4o
         9ZU1OUB6NQlMcBDVChUCAdAAAqo0C4OZ+lPkaOm9v8LalIjY8nc/bO7liUltfm9CH2od
         RO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910448; x=1783515248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNYo/DlbFIEXnMINvFtAOJPsCSUEkojp0EkJfm5QRDw=;
        b=bVwGPmO58a1D2VMQW7T/NvjuNUOpN5iHqIukmRlkhttfl794np2yn7YnmIMlNAf2tW
         aKBPT3eZbHFgxjf80ze/gjrIlS09tkb5VnhenyK/Fq6mf2Ax7l3TW+cPM5+BCwnASWdi
         IzICYZHaBztteiGIuzOPuzijYMUOZj7UxapkUaMnQG4D9kAmTV8TS4k6etzgR5wKxQzr
         sHz29445ZpuAzKcwzR6hGLFwWmoo85K1fkrHhxoa2p23Ie7xwvM8nwBJ4XEXqSkphTJC
         whjuinVyepMmsVh33tgryE08+KSjHkNnhDXomX5SKgbjWObW8sZEFHGCDMU3m1VWH+VQ
         mH4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rql2Bhym55/i6+YbXlyhRplfGpeNfI6xR2HynkFFifV4ElPbHnwVf5Ji35l/LT0pZO4w6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0wGvv2Eh0Rb72mAB4unaksFAxcAxGVIvQ4wPg+R++CrSrLLC
	Flx2CrIIRkH9t4DikaoeWJxHpFJvTQUQbaUu9KCi87SUFPMj2k5BxBd9
X-Gm-Gg: AfdE7clc/WodGAZtzl95KvDpUk94G3XJGBZs5ucyUaEfRWJCcwQcw5XFA8zpPpgZ7yY
	zGmKjIOCcIQ/Y9++ByjAX7Xe72Nzv/4Rktm76vnNNhmwGT+xnu0mMdAUXQQzX0EiekMvbXyNNfv
	pgvsM3RoacOgWXlpMbqUNdF6bcDbSl2DkaGjrivI0tWc69EaWHFskZbZfP9RVWT6TXjwgXtNyw0
	wA5wbqinM4yl0o0plpZ6ClBhciqhn0rx4WUEfdT6hmPfN2nwZRyXJ5idzsENFmfN0ESlpoRVT7l
	VDom6v9kbQj1OAoCaNLXBuYZnebU1c9azk1HDPqSMHVAKhfeQ0MUW13pJw5UTniKLBaEvexMNfM
	dBu/u2ePI7goN+RK2Ai3BKQC6KsoRyDC1X82ytO+79xJNWTeeUZdnh+4MOWQhUHHLC/3I/R1eCS
	A+bjj4Ixf8BIVaGZinbRDJ
X-Received: by 2002:a05:6a00:301a:b0:847:834d:b6a6 with SMTP id d2e1a72fcca58-847c09c8450mr1321318b3a.62.1782910447535;
        Wed, 01 Jul 2026 05:54:07 -0700 (PDT)
Received: from [127.0.1.1] ([120.244.9.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm3999403b3a.49.2026.07.01.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:54:07 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 01 Jul 2026 08:52:22 -0400
Subject: [PATCH v5 09/17] dt-bindings: riscv: Add Zic64b extension
 description
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-rva23u64-hwprobe-v2-v5-9-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Jesse Taube <jtaubepe@redhat.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=zzv4RpzLQz9N5QJYuvZNdW9u/BeWJDgXt1lzr+Z9BYs=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixX3tae54HSDm517WVHE/akZ2wyUs87/XY2r8u9ktmSc
 c0q7xk7SlkYxLgYZMUUWQ4fbcne+son2vc55w+YOaxMIEMYuDgFYCJ9qgz/fVW33XNV3v83JiV9
 fpLN0UdfY56kyUUnPP1+YnbxZCv+GYwMhy18OQtd2E9FfmEK/997+L1R7knfy7uueIlOfbDpEO8
 GXgA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

Zic64b mandates that cache blocks are 64 bytes in size and naturally
aligned in the address space. It is a mandatory extension of both the
RVA22 (U64/S64) and RVA23 (U64/S64) profiles, ratified with RISC-V
Profiles Version 1.0.

Document it so it can be described in the riscv,isa-extensions property,
alongside the related Zicbom/Zicbop/Zicboz cache-block extensions. Since
Zic64b fixes the cache block size at 64 bytes, also add a schema check
requiring any present cbom/cbop/cboz block size to be 64.

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v5: Commit message clean up, fix a double space (Conor).
v4: Insert zic64b at its sorted position (before zicbom).
    Update the commit message.
v3: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index f4dd34d446c02..bbd442cfbd904 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -494,6 +494,12 @@ properties:
             in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
             riscv-isa-manual.
 
+        - const: zic64b
+          description:
+            The standard Zic64b extension for 64-byte naturally aligned cache
+            blocks, as ratified in RISC-V Profiles Version 1.0, with commit
+            b1d806605f87 ("Updated to ratified state.")
+
         - const: zicbom
           description:
             The standard Zicbom extension for base cache management operations as
@@ -1142,6 +1148,20 @@ allOf:
           not:
             contains:
               const: zilsd
+  # Zic64b mandates 64-byte naturally aligned cache blocks
+  - if:
+      properties:
+        riscv,isa-extensions:
+          contains:
+            const: zic64b
+    then:
+      properties:
+        riscv,cbom-block-size:
+          const: 64
+        riscv,cbop-block-size:
+          const: 64
+        riscv,cboz-block-size:
+          const: 64
   # All three Zicbo* extensions require their block size property as there's no
   # default.
   - if:

-- 
2.43.0


Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EC481652
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910367; cv=none; b=WuGurS1k/ie4zKCA0+p66yxrLvJWdY12m+L51YaNu7+S6u8n4Dv3Eyu/whB9Czuex+k+KtaXAXXrHx7j53T+ejk/K2J3t+4+3gdKJXsRGEp4IJZJDtNtitd7LiucCzD6DYtl4dE/h6BluzuyER2ZKZCaPm+4g1vWnSDKs8JdepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910367; c=relaxed/simple;
	bh=dYo7yt5dKXk9dCII4EyoUO9rsvHF5lxpieGfcqD1BJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgIQNRKYAbVBpPMi+RS02VvpLOGcqaOaS9VYPpyihzwFzFTIpPNI8FNXBAxwMcNS7EVo0hKgz8KZHTjUcWnQFvfnJdCV8vAsE2Tdz8Nixwz3buDZ7ZzbqukNTYF+FD4Prx68lv8fgiRyjJCmlwpD0fPV4/zHPZFSv6SYBAyZ1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT3lFESX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT3lFESX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845537740ddso353800b3a.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910364; x=1783515164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F7FgRbrqRmk04PinsQvTrdFcJejR9/1kMD+TePq/fp8=;
        b=aT3lFESX1Hnd0y2K0Kykz62n5ve+o8JMPhShHW60siKX4ibU/FmtHb+mTVT0Cb844h
         aC8UrYHuFTRFxyXOdE6v/Yv6EW5bNdRTWboX1b/K/ie7Ysa019HMivKkR4WEykLwsO4i
         P5NgUTyCqK5FTMvFiIetxKmjoz6stBesQBgmLG8iQAh6X5PrxvnD38O6CaXpTnFAouJj
         sYIniyg+Wz6zCSeERC1n4mx4zA2PD7fNNPW66+CMQ948W+yu9GwFaOHYKhC/lOe8NA3a
         mIHGNh3Uwt0BJjmBzBMNiZqVD4pbtylKmjbzqNqPeGFkzLgLI8KMow6IpiTM5qJHshuI
         GDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910364; x=1783515164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7FgRbrqRmk04PinsQvTrdFcJejR9/1kMD+TePq/fp8=;
        b=aEFgOpC0ilxTdwFL+WW2switCRO+QBDYc6PY9BAzbW4S+qfYch7L8yZ0dAPJHJ2vsv
         vXnnAOIDRNnRwMrofJHa1Bszi4hiwo5ctWDnWg6BNEfS9gEgpCNCXwl6NIzlpsrB5cdp
         jNLE42lX7XPUH6vDRqT53RzA/Go45Q3QsCJZyCpZjbnNgtmO7INzgWlPhl2RrwYqQEWY
         Bt4FErsMDHihDnsLi2tKFzA14O4Bjexn/kNEwbYNrLGq4ioTvfZUpgbrmLQImCAfKXF6
         bMYXAF81Hig7suSBr57l9ThALPaIiFi2mFF5+AAxrmEQHkPvnRuSd7BApvVoHu75XUbd
         0PuQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMeTTHNPF7QmJVB6JDMnDCCsfZWcfKUdno0JBh3DPzahtpz0TFKCeT+hYZKYtEFy0HnjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MEUr7pbEq1lrWbU9InZ3bO4E+4L/dNoxozGfwoqQKbY0xY4y
	SAVT8brxem7mTZS0/lby7IIzBunB0RTypxPAhCX6aYGOjv0DGa0dgZc5
X-Gm-Gg: AfdE7ckrc13zOUlskUAar+PLjrmgANkquH7ByHEaY3C/5lJ0V+bRsSOdKQBefKRbDhe
	MHMd2AHRp7XeXy3FDQiWtFgzB1H3n5mtYH8/l1vyP5f3BaIqyltDlssCFh5/xZUVuhcz4Hm12B6
	9+oRRJ9cLW3Nm58Q+LFkBoT9jKzUZqx9sm4CTm/QLOnDNA7TcWvkON3yX83gweV7/7JNI/nIaup
	AXnBbARw81ETwWsJWbuX7gVaz+idBFy7z9VMOEYL8mqK7K4McvT1bJ7g3+RNBzV6wZ5Qh+qCzTR
	hV0jkszmM+haHYLk8aZTjYeTs9GVjaUdVWOJ6KoLBqAWAqp0g4RVHlJiNI8AvGiRtEKQguLZRWY
	MplUiNcW33R16rQubRc1GYMHG6/FmMPKdatDG6ksaauF0PcsogVCz/5jVlLSNYQiKnKQrxyx532
	dbIxCYYEprQpF5h5wrXZc+
X-Received: by 2002:a05:6a00:a93:b0:847:8921:9bd1 with SMTP id d2e1a72fcca58-847c51ac62cmr576526b3a.53.1782910364383;
        Wed, 01 Jul 2026 05:52:44 -0700 (PDT)
Received: from [127.0.1.1] ([120.244.9.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm3999403b3a.49.2026.07.01.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:52:43 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 01 Jul 2026 08:52:14 -0400
Subject: [PATCH v5 01/17] dt-bindings: riscv: sort multi-letter Z
 extensions alphanumerically
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-rva23u64-hwprobe-v2-v5-1-2c61f94a695a@gmail.com>
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
 linux-kselftest@vger.kernel.org, Guodong Xu <docular.xu@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10987; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=dYo7yt5dKXk9dCII4EyoUO9rsvHF5lxpieGfcqD1BJA=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixX3mYvHTv2jUo7ph8wd72at61FWY+pNspdruwEm8iP+
 DUPd6d1lLIwiHExyIopshw+2pK99ZVPtO9zzh8wc1iZQIYwcHEKwERm72NkOJDvc37nxjmTONuK
 15yM5atwX/njQMj0K/cNFk+enTT7DR/Df7fyT/4H3JkuzpfM0fePVK3/PC139f/tFiL6l/ufTKl
 YyQ0A
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

The multi-letter extension enum is documented as being sorted
alphanumerically (see the "multi-letter extensions, sorted
alphanumerically" comment), but several Z entries have drifted out of
order.

Reorder the affected entries so the multi-letter Z list is sorted
alphanumerically again.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v5: Collected Acked-by from Conor Dooley.
v4: New patch.
---
 .../devicetree/bindings/riscv/extensions.yaml      | 184 ++++++++++-----------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2b0a8a93bb214..5ffc40d599c02 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -457,6 +457,13 @@ properties:
             merged in the riscv-isa-manual by commit dbc79cf28a2 ("Initial seed
             of zc.adoc to src tree.").
 
+        - const: zclsd
+          description:
+            The Zclsd extension implements the compressed (16-bit) version of the
+            Load/Store Pair for RV32. As with Zilsd, this extension was ratified
+            in commit f88abf1 ("Integrating load/store pair for RV32 with the
+            main manual") of riscv-isa-manual.
+
         - const: zcmop
           description:
             The standard Zcmop extension version 1.0, as ratified in commit
@@ -487,6 +494,22 @@ properties:
             in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
             riscv-isa-manual.
 
+        - const: zicbom
+          description:
+            The standard Zicbom extension for base cache management operations as
+            ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+        - const: zicbop
+          description:
+            The standard Zicbop extension for cache-block prefetch instructions
+            as ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of
+            riscv-CMOs.
+
+        - const: zicboz
+          description:
+            The standard Zicboz extension for cache-block zeroing as ratified
+            in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
         - const: ziccamoa
           description:
             The standard Ziccamoa extension for main memory (cacheability and
@@ -514,6 +537,66 @@ properties:
             guarantee on LR/SC sequences, as ratified in commit b1d806605f87
             ("Updated to ratified state.") of the riscv profiles specification.
 
+        - const: zicfilp
+          description: |
+            The standard Zicfilp extension for enforcing forward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicfiss
+          description: |
+            The standard Zicfiss extension for enforcing backward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicntr
+          description:
+            The standard Zicntr extension for base counters and timers, as
+            ratified in the 20191213 version of the unprivileged ISA
+            specification.
+
+        - const: zicond
+          description:
+            The standard Zicond extension for conditional arithmetic and
+            conditional-select/move operations as ratified in commit 95cf1f9
+            ("Add changes requested by Ved during signoff") of riscv-zicond.
+
+        - const: zicsr
+          description: |
+            The standard Zicsr extension for control and status register
+            instructions, as ratified in the 20191213 version of the
+            unprivileged ISA specification.
+
+            This does not include Chapter 10, "Counters", which documents
+            special case read-only CSRs, that were moved into the Zicntr and
+            Zihpm extensions after the ratification of the 20191213 version of
+            the unprivileged specification.
+
+        - const: zifencei
+          description:
+            The standard Zifencei extension for instruction-fetch fence, as
+            ratified in the 20191213 version of the unprivileged ISA
+            specification.
+
+        - const: zihintntl
+          description:
+            The standard Zihintntl extension for non-temporal locality hints, as
+            ratified in commit 0dc91f5 ("Zihintntl is ratified") of the
+            riscv-isa-manual.
+
+        - const: zihintpause
+          description:
+            The standard Zihintpause extension for pause hints, as ratified in
+            commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
+
+        - const: zihpm
+          description:
+            The standard Zihpm extension for hardware performance counters, as
+            ratified in the 20191213 version of the unprivileged ISA
+            specification.
+
         - const: zilsd
           description:
             The standard Zilsd extension which provides support for aligned
@@ -521,12 +604,10 @@ properties:
             encodings, as ratified in commit f88abf1 ("Integrating
             load/store pair for RV32 with the main manual") of riscv-isa-manual.
 
-        - const: zclsd
+        - const: zimop
           description:
-            The Zclsd extension implements the compressed (16-bit) version of the
-            Load/Store Pair for RV32. As with Zilsd, this extension was ratified
-            in commit f88abf1 ("Integrating load/store pair for RV32 with the
-            main manual") of riscv-isa-manual.
+            The standard Zimop extension version 1.0, as ratified in commit
+            58220614a5f ("Zimop is ratified/1.0") of the riscv-isa-manual.
 
         - const: zk
           description:
@@ -590,87 +671,6 @@ properties:
             in version 1.0 of RISC-V Cryptography Extensions Volume I
             specification.
 
-        - const: zicbom
-          description:
-            The standard Zicbom extension for base cache management operations as
-            ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
-
-        - const: zicbop
-          description:
-            The standard Zicbop extension for cache-block prefetch instructions
-            as ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of
-            riscv-CMOs.
-
-        - const: zicboz
-          description:
-            The standard Zicboz extension for cache-block zeroing as ratified
-            in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
-
-        - const: zicfilp
-          description: |
-            The standard Zicfilp extension for enforcing forward edge
-            control-flow integrity as ratified in commit 3f8e450 ("merge
-            pull request #227 from ved-rivos/0709") of riscv-cfi
-            github repo.
-
-        - const: zicfiss
-          description: |
-            The standard Zicfiss extension for enforcing backward edge
-            control-flow integrity as ratified in commit 3f8e450 ("merge
-            pull request #227 from ved-rivos/0709") of riscv-cfi
-            github repo.
-
-        - const: zicntr
-          description:
-            The standard Zicntr extension for base counters and timers, as
-            ratified in the 20191213 version of the unprivileged ISA
-            specification.
-
-        - const: zicond
-          description:
-            The standard Zicond extension for conditional arithmetic and
-            conditional-select/move operations as ratified in commit 95cf1f9
-            ("Add changes requested by Ved during signoff") of riscv-zicond.
-
-        - const: zicsr
-          description: |
-            The standard Zicsr extension for control and status register
-            instructions, as ratified in the 20191213 version of the
-            unprivileged ISA specification.
-
-            This does not include Chapter 10, "Counters", which documents
-            special case read-only CSRs, that were moved into the Zicntr and
-            Zihpm extensions after the ratification of the 20191213 version of
-            the unprivileged specification.
-
-        - const: zifencei
-          description:
-            The standard Zifencei extension for instruction-fetch fence, as
-            ratified in the 20191213 version of the unprivileged ISA
-            specification.
-
-        - const: zihintpause
-          description:
-            The standard Zihintpause extension for pause hints, as ratified in
-            commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
-
-        - const: zihintntl
-          description:
-            The standard Zihintntl extension for non-temporal locality hints, as
-            ratified in commit 0dc91f5 ("Zihintntl is ratified") of the
-            riscv-isa-manual.
-
-        - const: zihpm
-          description:
-            The standard Zihpm extension for hardware performance counters, as
-            ratified in the 20191213 version of the unprivileged ISA
-            specification.
-
-        - const: zimop
-          description:
-            The standard Zimop extension version 1.0, as ratified in commit
-            58220614a5f ("Zimop is ratified/1.0") of the riscv-isa-manual.
-
         - const: ztso
           description:
             The standard Ztso extension for total store ordering, as ratified
@@ -809,18 +809,18 @@ properties:
             instructions, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
-        - const: zvksh
-          description: |
-            The standard Zvksh extension for ShangMi suite: SM3 secure hash
-            instructions, as ratified in commit 56ed795 ("Update
-            riscv-crypto-spec-vector.adoc") of riscv-crypto.
-
         - const: zvksg
           description:
             The standard Zvksg extension for ShangMi algorithm suite with GCM
             instructions, as ratified in commit 56ed795 ("Update
             riscv-crypto-spec-vector.adoc") of riscv-crypto.
 
+        - const: zvksh
+          description: |
+            The standard Zvksh extension for ShangMi suite: SM3 secure hash
+            instructions, as ratified in commit 56ed795 ("Update
+            riscv-crypto-spec-vector.adoc") of riscv-crypto.
+
         - const: zvkt
           description:
             The standard Zvkt extension for vector data-independent execution

-- 
2.43.0


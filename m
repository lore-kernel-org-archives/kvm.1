Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356822;
	b=zYjwuscRtj9byrxEZkDWmtkqPoxBo53nb3rNDrVUAsM5bl+XxVwlixd5wn0KIe/QTUh3
	 NCT/WucEzUZJcrUaoZlvUeCdtJemyYTJTAMc3VdQigPwmIQaUEraedQpwCKVXMCvQpVu3
	 Bv1Ha94nEyjZ2r9M05GF9NO4dOB6HSDwTBE/oL4rEPnFB7adeUl8IiiBZYMV+m9zhw+5R
	 v0l225i/dmz8WG/TJnUgCf7Glo/vNUHyNBaIVQCiEq4cneXH6oLqMtAXSqbrbNXdCVf1S
	 RTIVsXlw3cPujeFTDNA3aHb4m/qxL5M5aVFoUNRg6Nkq8t2AdlNBe/Fd8HHatbsE37Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=//gNQBAMoLDvwFviVMSOVAOYdNAOTMziQPqBvvmWCUY=;
	b=oqMPB3u9c/clEeJxNke4wercMr2oqholX3SQtlmPOxNxlOs5a9F8FxNNYgsBuFWZaHmu
	 dm0eqzjQYwN4cUQ2fSPP7WJ9CqjU1T8zs+cYLT8/IUKwEMzG4LoitZaLtSSVoFHyUmRm6
	 QWVgvhIBzJTx7ToEB9XiKoUNZRmWNvas0McJOF7w5i82lcWcSzaZFI2hTBWBOShKt1Ii4
	 ijMkq5SLHi4s4iMi3bG+SCH906yRqK9zx1k6h+AuIyplGBXCsQAIHiRMLCW5wXcU21Z5e
	 esaKUFV2XwLISM/4t48q4tQ+J68NKq1B5jiznBy1RS6zyFUqCdUX6y5aLhKMaVCD1yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eoUs1nyT;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1A606A323
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 10:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD1A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eoUs1nyT
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso3360585e9.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793356820; x=1793961620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=//gNQBAMoLDvwFviVMSOVAOYdNAOTMziQPqBvvmWCUY=;
        b=eoUs1nyT8EcqPkXtH75LsY5HjGuxSSAZiykXTwFEuaP8YUmEQ56utw2XCmyO+8+Xam
         mPssGcNTau5X5ujpid1VrdADNu8swZCVxsp0fwB3i1hd3wC2fyjfw0my2oyFC/yyIYnN
         eXLjCdhk7kbL1RLUeNk0rxyfNp5x4ev6T/HnGuqlsQlIwE3p1py5vyFwK2zR6cwiF0Rq
         FZVMK5US7z7cbIxSSK67fgAioA8Q+t9VKDc7OGOSHbNhyA9eZXkjWkYkA6Rc4Tw4qYnp
         0bo8peqf+QKSvdxiZk6OgRwIT23fKoVZQXbEZeg58YH+oE9zDSwNNM2Qx/QCQ4UjX9c6
         3dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793356820; x=1793961620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//gNQBAMoLDvwFviVMSOVAOYdNAOTMziQPqBvvmWCUY=;
        b=HAvrO2Bg5Zes6NJq66foB5t8LpsuzsNXF9BLH7M/unoAywL3pZRGJUsk48maxvsTVj
         qKkgbtJIQa928us16k5chCzfCXeZFx/Zuq/cBzddCDIqNO7gCO9SJGZ5Wukm8lQ3lddo
         R0tL++NhPVGzwnxKad+bPdiPdqA6i/l8R0XDgnY8tg1oE7caG+dvjeeQzxRPGAR6l2oQ
         6Rt79oe3Q4BHQb+jhWvgQKAF9Wraffrgd4WCX9tt+q9o3Xet8GJTeBW4hrb+tupNLeAw
         JYe2Mb+jTNK2AsjwIlXyNd68srTxaOCfAYTtAwtW/Rnk4yTbZT6k9sGSEJ8haTT2cDH5
         H2Cg==
X-Gm-Message-State: AFq9FYLT6EylSnXeZqJoQxTTtyZtnghYuKqnhEYhtvD3lmcwAcdQOa9y
	k5G9fNBhxaMMryQQXM0wpsuVcfPKbSl/suyZkT2fqz8ifExK4uYz66C7
X-Gm-Gg: AYBFou0QEBJvr3QafovjO7rk0GhsOaTuIAXEprrqsdW2sF8OdmLP9olasH1Ubvwletz
	dDxYZ6d63ETTKrMMLo052nG7pSAG6HFUVcUHHa98kH0U76rGcLtvU3AS038rqRuOzrraBzTMF74
	Ocd/fmWiHZw/mgmRUGvG9gbBB/08BChYWkIGmUTn2MXDX7ucRClVVUqF+PFSzkVjV1ZHJALj2hX
	/0HA1tZ3LVxUk6fuKHNvRYesu2UUEryEv8pWFIFwSV0I2n5Emj69u+0T1BZMM7S1R47GGh645XT
	pOCaT9Tv7qYLq/wUwKhGJaq14pLLwrsyAmRoSWznvdn2CJ7w1VGGp40We1kOvTHn1IIyNn17izK
	4F5ytyB0SF/6PgLhKz9SrY6IUaV78zAhIMKHKwDxpp72k6heemPHtBTktPrjJY/fSARlEsUiq3z
	OOQ1IkI/7yl0SniJBH7hqpAjBXoGST33BkLKr/J/QkgvOZAD4gVllMMcrPQ87X5ehkTugnFG5jq
	wNVMzb/5w9wApUZioqPd6XYkupb24yCrR+bqtYtPZGoqVVPeBAwML+BS8RcJFR7b/FoXXgrt96g
	VUEIMGe73MNsvpGUJM0pWPkvOptxnOQvsXeH6z8KpTw=
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ac18a88fa6mr40065535e9.32.1793356819790;
        Fri, 30 Oct 2026 03:40:19 -0700 (PDT)
Received: from IsoOmenaM3 ([91.136.216.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abebe33e79sm37954225e9.2.2026.10.30.03.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 03:40:19 -0700 (PDT)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool] Makefile: Use correct nm binary when cross-compiling for x86_64
Date: Fri, 30 Oct 2026 11:40:18 +0100
Message-ID: <20261030104018.71809-1-mikatammi@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86/bios/gen-offsets.sh generates x86/bios/bios-rom.h from the symbols
of the BIOS image with plain nm, the build machine's rather than the
cross toolchain's. Where there is no plain nm, as in nixpkgs' cross
builds, bios-rom.h gets no offsets and the build fails:

  gen-offsets.sh: line 11: nm: command not found
  x86/bios.c:18:50: error: 'BIOS_OFFSET__bios_int10' undeclared here (not in a function)

Pass the toolchain's nm to the script, as
commit 53ce8c598e58 ("Makefile: Use correct objcopy binary when
cross-compiling for x86_64") did for objcopy. Run by hand, the script
still uses plain nm.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mika Tammi <mikatammi@gmail.com>
---
I used Claude Opus 5.5 to track down the cause, write this patch and
its description, and run the tests below; I have reviewed the result.

Tested with nixpkgs' kvmtool package on an x86_64 host: cross builds
for x86_64 with musl, dynamic and static, failed as above and now
build. Their bios-rom.h and bios.bin are identical to a native build's,
and their lkvm boots an x86_64 guest under KVM once built without
_FORTIFY_SOURCE: with it, musl's fortify-headers trap on the memcpy()
from bios_rom, which bios-export.h declares as char[0], a separate
issue. Native x86_64 and arm64 builds, and cross builds for arm64,
riscv32 and riscv64, give a byte-identical lkvm with and without this
patch.

 Makefile                | 3 ++-
 x86/bios/gen-offsets.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1c0e7f5..62142ff 100644
--- a/Makefile
+++ b/Makefile
@@ -24,6 +24,7 @@ CFLAGS	:=
 LD	:= $(CROSS_COMPILE)ld
 LDFLAGS	:=
 OBJCOPY	:= $(CROSS_COMPILE)objcopy
+NM	:= $(CROSS_COMPILE)nm
 
 FIND	:= find
 CSCOPE	:= cscope
@@ -537,7 +538,7 @@ x86/bios/bios-rom.o: x86/bios/bios-rom.S x86/bios/bios.bin x86/bios/bios-rom.h
 
 x86/bios/bios-rom.h: x86/bios/bios.bin.elf
 	$(E) "  NM      " $@
-	$(Q) cd x86/bios && sh gen-offsets.sh > bios-rom.h && cd ..
+	$(Q) cd x86/bios && NM="$(NM)" sh gen-offsets.sh > bios-rom.h && cd ..
 
 check: all
 	$(MAKE) -C tests
diff --git a/x86/bios/gen-offsets.sh b/x86/bios/gen-offsets.sh
index 8771bbe..7f7b8e2 100644
--- a/x86/bios/gen-offsets.sh
+++ b/x86/bios/gen-offsets.sh
@@ -8,7 +8,7 @@ echo ""
 echo "#define BIOS_ENTRY_SIZE(name) (name##_end - name)"
 echo ""
 
-nm bios.bin.elf | grep ' [Tt] ' | awk '{ print "#define BIOS_OFFSET__" $3 " 0x" $1; }'
+${NM:-nm} bios.bin.elf | grep ' [Tt] ' | awk '{ print "#define BIOS_OFFSET__" $3 " 0x" $1; }'
 
 echo ""
 echo "#endif"
-- 
2.54.0 (Apple Git-157)


Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8E72618
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223198; cv=none; b=REs1SPn93vLQr4KXPoW5kgFzKTp4KXDt/CWcmXZ185+Sua81Bq9VRMroT0hotr8z6HXVkuTkTqCxQnZO88m64fAwfFVEngtis8g3QM8oxX+b8/lJeyhIMLR52U6eNNyyE+6YOUPiW1LEIDY/6YJJDxI16dumKDe/Golmf3SN5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223198; c=relaxed/simple;
	bh=XgbCD7Ssd+kGo1rqUZiy76sXUoW6AqZaTNUHW5cVLiA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qnh2HxFdv07Zo+0MTzNRHJnGSMnwFDcN2FfUJ+2mIx9a3szi7Gyhx/Bt1ukF7QRMqsUtqqGOFGQNhrepSV8Y4HsgwCo+WcTdk2AWAmbw1VXrxAplcCnxlsOOH+Ji0gnTg5Ak8J9lHmPhq7uZrwptOTNMCkQRg/ZsIXKbzNW+uRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zq8VNeqq; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zq8VNeqq"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4a485034d01so5042984b6e.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784223196; x=1784827996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Z+anC+/1XFqwXmxKZk/3VItIn4RPKH7QLbFgNe4Yzs=;
        b=Zq8VNeqqrjQu7Me7mGVw+jih5XR+bUcH5HaHvRlPR0hHSSNH+jM8cDtTDXxUd3WJJP
         nq+ioH4UQmw/EGk9YbWOy1aP1fjTE68tSxacOSyOwT066a5+LPrN3tGMv2X/joA2ExvI
         mJVyepPjJlQVY0izeDzPQ+AWTGVWbVSWYo0y+kNtbUA7sXxMXu/s8eR//jRmZijp9ZKK
         fNOR7tiKTl5q9uqHS6Zep2ziy22y9glvbvQufSdZ14v4SR1uwXjq3P5pj3kBf3YDTw15
         VSxniIaNvnt5MCf31k9PJGwTtl1R3lceG2s0ofJct1T1a8ARNdJgw/TV81cSZBthsU/A
         59nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223196; x=1784827996;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Z+anC+/1XFqwXmxKZk/3VItIn4RPKH7QLbFgNe4Yzs=;
        b=GqzMlaS2OgSb4mQd4cVVmnKp83JnT/YuCXUt9u60pThU+4G3PlbjS4KpKm7Ho3cevR
         UfUoTWkFsNC8RNg7SeoBKZMOki4FsVYyKuHUt9JuSxZkp+D8TSNNr90fHxhMQaYEwfMZ
         A/YsWuJQhbOQlzhBaLTzp+ZARsrU/+161JbM14KJaUUkslEsRH0ZyNOFW6jlF9ecZTBt
         XnWIqNz+wl30je3vAe+A3FTVYDc/ak1pU6v11W+gKRZucBlDGbyC4S9d3Xap51mMZK9d
         jHVo2YOjAGISTweOQq28n6tK8dC3GlX//eS2jNlGY0dhJ/tJUsXRvxoN9JGJyjjVFjmK
         JzFg==
X-Forwarded-Encrypted: i=1; AHgh+RrX8r5JFccP0onBcSNPMWt1l9xS/jSOAZca6gvQAlr/3+58YESMTBDS3ABrC9cJ3i15esE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPOYfiwa2ee0dDzxg3bz6juwytVPyQLzEfxQpef4UN2mQbGnX
	mw3HabuK8a2yXOBlH1Zxn8ifW1F9r0I4WStw7OvljFMo5JElnNn/gd530Jl1ZuJqVApifR0FEP2
	tlfRPNjcTtamL0jgWUd3IVM4GAw==
X-Received: from ileg2.prod.google.com ([2002:a05:6e02:1a22:b0:503:a191:13b7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:524b:b0:497:df42:1dee with SMTP id 5614622812f47-4a4c878effamr415255b6e.35.1784223195562;
 Thu, 16 Jul 2026 10:33:15 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:33:15 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716173315.2775989-1-coltonlewis@google.com>
Subject: [kvm-unit-tests PATCH] Makefile: efi: preserve .dynstr section for
 LLVM objcopy compatibility
From: Colton Lewis <coltonlewis@google.com>
To: andrew.jones@linux.dev, pbonzini@redhat.com
Cc: alexandru.elisei@arm.com, eric.auger@redhat.com, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When building EFI binaries with llvm-objcopy, keeping sections with
'-j .dynamic -j .dynsym' without '-j .dynstr' fails with:

  llvm-objcopy: error: 'arm/spinlock-test.so': section '.dynstr'
  cannot be removed because it is referenced by the section '.dynamic'

Include '.dynstr' in the list of preserved sections across
arm/Makefile.common, riscv/Makefile, and x86/Makefile.common so that
EFI binaries can be built cleanly using llvm-objcopy.

Assisted-by: Gemini:gemini-next
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arm/Makefile.common | 2 +-
 riscv/Makefile      | 2 +-
 x86/Makefile.common | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arm/Makefile.common b/arm/Makefile.common
index a5d97bcf..550ec0a1 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -88,7 +88,7 @@ ifeq ($(CONFIG_EFI),y)
 	$(OBJCOPY) --strip-debug $^
 	$(OBJCOPY) --add-gnu-debuglink=$@.debug $^
 	$(OBJCOPY) \
-		-j .text -j .sdata -j .data -j .dynamic -j .dynsym \
+		-j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .dynstr \
 		-j .rel -j .rela -j .rel.* -j .rela.* -j .rel* -j .rela* \
 		-j .reloc \
 		-O binary $^ $@
diff --git a/riscv/Makefile b/riscv/Makefile
index 64720c38..348a30a7 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -123,7 +123,7 @@ cflatobjs += lib/efi.o
 	$(OBJCOPY) --strip-debug $^
 	$(OBJCOPY) --add-gnu-debuglink=$@.debug $^
 	$(OBJCOPY) \
-		-j .text -j .sdata -j .data -j .rodata -j .dynamic -j .dynsym \
+		-j .text -j .sdata -j .data -j .rodata -j .dynamic -j .dynsym -j .dynstr \
 		-j .rel -j .rela -j .rel.* -j .rela.* -j .rel* -j .rela* \
 		-j .reloc \
 		-O binary $^ $@
diff --git a/x86/Makefile.common b/x86/Makefile.common
index a251dd71..054e2391 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -58,7 +58,7 @@ ifeq ($(CONFIG_EFI),y)
 	$(OBJCOPY) --strip-debug $^
 	$(OBJCOPY) --add-gnu-debuglink=$@.debug $^
 	$(OBJCOPY) \
-		-j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .rel \
+		-j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .dynstr -j .rel \
 		-j .rela -j .reloc -S --target=$(FORMAT) $< $@
 	@chmod a-x $@
 else
-- 
2.55.0.229.g6434b31f56-goog


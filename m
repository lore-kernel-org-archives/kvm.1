Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370408;
	b=MQ1GGWIN6Te6ZYDIH2CgTZISCcOl40el1i58fKbFjqy6z3QtFdZStOdIp1klUKXzDfgr
	 AJVPfMj4HIfOMbpE0DAsj2jbERev2Fw02sRLvjru1FSBLb0v2fx/34l5LS6kXyxKht8Zn
	 qYw697C16dwDhdZBzz7eKrXUtWTgdEXeFXANzC6sxpzKcNeu9CVIw6aPq2YWYOcnPqWPW
	 TueZNzsrw1I5UJQK5XViccMQbcV8niuVRN8anIH/K4//fE7wuBp032CXg2PgEMJT5BuM2
	 89j379qjfmsD77PwTKcGEwunz1uFOoHcaYdWjdB0xNKtnd1pbjBw8EXPs7i/FVt9HRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UqjzUR1+yUc+jg8di47GyhWBPL/POjKzDLuWTDyldCM=;
	b=LiQ4oU3Pp+qcgahOUNqN0jklzt6XjEJWB2Z+E04/Xb78A0r+pHlxDXLEWXuwZJEiz46+
	 WGfSbD1i4lVvPHoQL/YtlzP9SqH18hXLZciic/6VvJKfy4DZ0ljWCLupf4kPvNxIbWKIh
	 v5QDPl+k5AltOvUoew3p+g8zv+oOGWdFzGQbc7Nlj0TIPmzN2Q23xjez27g9Cm5wn+kf5
	 xJciQDkgIIIipBnxWYyaKJpMyQdJ4AausHLqyfdreLTPMFKwJsP7jWaOE7jjEDnWmhzxJ
	 9NEsyUe/V3bc4d89vj97uB4uLW9G7FeBaNtLCS7x3+O0nQLXPswsc76zKL4VAIpFUYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IY/U/1MO";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC684606A31F
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC684606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IY/U/1MO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so5598855e9.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370406; x=1793975206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UqjzUR1+yUc+jg8di47GyhWBPL/POjKzDLuWTDyldCM=;
        b=IY/U/1MOII6Nl4vZnjZVpZrdL3FFmaw8i6+6dhJ0sBOb0cdjcee1Vo6csW68gKo1yj
         +6KQ58Nwyv0tmziTdnfQ81idP6wy1F2gQhVj7Ibf77OuCHLxvfBdO/uolfmkSOM+EV6d
         oWniCzWRg6jB/Dlau+To229LvBbBaUzEGRxfeL02kuGqN5epQKnIdHDxJZodtBXaaejI
         MmsVDINdUJQhTwDysdbw6Cj6uTiKFw6+6V/IOUo7ljDTmksO/ewTpBDjCa+EW0fHNIex
         BiOh+0y21hN9bIWFzpGlKFSCdZjRzb3b4l3vvB5pZfGqd7AKwQVppthgvhTxJCvu/2SG
         xWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370406; x=1793975206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UqjzUR1+yUc+jg8di47GyhWBPL/POjKzDLuWTDyldCM=;
        b=tyv7CPaKw3quSiF5oEaQcQu963FygwdIdeQAphrm1JCB1r5DBADS9YynES4NJAUzw3
         EjSZaXBJG56W0ggLkbwDN8f2zzGTub1fZsGY0y7AQ+BSd5gihKMDLMkl9iIHgrDuguv1
         wDipCVjfTa7f8DNbRm9fOlJ19cvOHWhNpO47VnYXkpIzCumtcMVbdkbFjWaeSqrT1jI3
         R8mCHVxEXjOvo8GjjkixfUGD6xXT1UlsGUcW9XEDh2YTz+gqk44/kCIo94e1XmVRIIj+
         761yKjpNH7hRUfKF7BC6LKS43J+BL5gziOtNlcZnjcAgjSvgByZ1qG7adh25nQoaqPkE
         px8A==
X-Gm-Message-State: AFq9FYID4IchUYy9ZG/XxLqWSlsn36DeGoOOxVYTT2i7FASAGW2bI9Zo
	C7XC5EUOQ8qzZOFivFwBR9lt13hQ40rFEAX79hE2HhjQodlm2e3pLyw9
X-Gm-Gg: AYBFou0ur0UtRfvXFzlauRMKfzMv5+ZWsEbhZUFi+835x7vbQehmXW7qW+eVHqJpipX
	MhZztQgr6UzBqygBsXxV6iXS0Fbx4ZvvRBCVYWBWSVAhYcsEh/sSR27ZDRCkposMawruqfTZTaE
	Py6l4dZGmar+R0nBivvXB/UzxqrnTEBrff9Y1XB8sT0JC9vhoR6kja47iF2ZuZS2NcSXew4Q0F5
	KyvjrL/u/9TEDwrk8/dw01LwSWSHeROrTJjLpNNKRJgH/SlCHLE+WzeVeLqPmsvv9ORQ7AocqiU
	27ZfvnSO9pwGbtHK66znZdUBOrIQ1l3xGvFyaYV5NI3J2CMBRziN50j1sKvzfTOreQrriRq3xL8
	5yi4FhiZBowkVdEk0IItkicbtpVgxfzqWxzH4s6or8CdGEuF/T5Jcoum2NcqdSWsapk50MxSEEC
	61YI/wkwrg1rE2tJLYhRdypPxhhUTmDa8UcO2TrtDQJNSNHVTtLEsREoNnFiRBQzmwvvkPwaKUP
	HcBGtQoCwVEs4MPWUk5CMEr118LASU5wJhhnGcKE5/tCiYGhzE2yZ8gK0MvoRWurdTy7INyaHIV
	5+G7Kh9+r8qzdYM2kD/Kvt9Z92PaQFe9wrKKIXRfaA==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr53939635e9.13.1793370405971;
        Fri, 30 Oct 2026 07:26:45 -0700 (PDT)
Received: from IsoOmenaM3 ([91.136.216.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm142353465e9.4.2026.10.30.07.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 07:26:44 -0700 (PDT)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool] x86: Declare the BIOS image as arrays of unknown size
Date: Fri, 30 Oct 2026 15:26:43 +0100
Message-ID: <20261030142643.89313-1-mikatammi@gmail.com>
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

bios-export.h declares bios_rom and bios_rom_end, the start and the end
of the BIOS image in bios-rom.S, as zero-length arrays. To the compiler,
bios_rom is then an object of size 0. fortify-headers, a
_FORTIFY_SOURCE implementation for musl, checks the size of memcpy()'s
source as well as its destination [1], so the memcpy() in setup_bios()
that copies the image out of bios_rom traps, and lkvm on x86 built with
musl and _FORTIFY_SOURCE, as nixpkgs builds it by default, dies at
start:

  Program received signal SIGILL, Illegal instruction.
  0x00000000004010ac in setup_bios[cold] ()

Declare both as arrays of unknown size, like the kernel's section
symbols such as _text[] and _etext[], so that the compiler assumes
nothing about their size.

[1] fortify-headers 3.0.1, include/string.h, memcpy():
	if (__n > __bd || __n > __bs)
		__builtin_trap();

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mika Tammi <mikatammi@gmail.com>
---
I used Claude Opus 5.5 to track down the cause, write this patch and
its description, and run the tests below; I have reviewed the result.

Tested with nixpkgs' kvmtool package and its default hardening, which
includes _FORTIFY_SOURCE: x86_64 lkvm with musl, dynamic and static,
cross-compiled on x86_64 with "Makefile: Use correct nm binary when
cross-compiling for x86_64", died with SIGILL as above and now boots an
x86_64 guest under KVM. A native x86_64 lkvm with glibc, and builds
for arm64, riscv32 and riscv64, are byte-identical with and without
this patch; the glibc one still boots the guest.

 x86/include/kvm/bios-export.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/x86/include/kvm/bios-export.h b/x86/include/kvm/bios-export.h
index 23825aa..42fa4d2 100644
--- a/x86/include/kvm/bios-export.h
+++ b/x86/include/kvm/bios-export.h
@@ -3,8 +3,8 @@
 
 struct kvm;
 
-extern char bios_rom[0];
-extern char bios_rom_end[0];
+extern char bios_rom[];
+extern char bios_rom_end[];
 
 #define bios_rom_size		(bios_rom_end - bios_rom)
 
-- 
2.54.0 (Apple Git-157)


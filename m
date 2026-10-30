Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321067;
	b=RAz3coo1IqfoCcFCaHdL2cQxZwVqS86VVQQWOi+MUl6js/M44il7cuWuR6YOM0Cv/XEd
	 eCQYe5Q93uDVSQkf1ZogoHyNoxed6algWJgpcvnshCtdZezwsroyqwEJj1SoMHsNBgxYA
	 Ogx8FH3WS7TUgBEFNzanq9mq+JR9LCe5kIQJBwkdYzGpNM4v9r+AUG3FxmMQBAFtglr0I
	 gtdcOg9vMnl+QvaTD3GAfCUzElIWpCLggI5P3sOWI8Mk+OYnvrEQVSgulthjfHzOAZ4Es
	 jaWakLvvwZje4LvllKOth4j8+DVIrenTxTYXPmg0JyTLLyG5kPIcUn2oVoSYLcNk4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fDJFbvdkS3S3/SvfTOXomGOADmk0+mqHe0JMv4Qvqcg=;
	b=iGhTQ6MycWo1knl4ILDgmtwsKgj1Tf/AdJg3uNYCziHhTAxftX0PF1AORMLHyeUi2/1X
	 buTPO5R+5mzlKDKEISNWY8Kdr2lNgXTijHQS7j4+4YQBOwz3WEVniMpp59lwG+gXFDduX
	 bD1BesFXrtP4ksH18ihngUZHFPYu+FqXwYxnjEd25kg8kfTHEfvqWnRE6MgIjVFuqXosi
	 wZCAgWFgjsRe3KqZU3qIVDIFCUtiHtEMhCq/R4gKUvx63F00l6JSv5jdJJZayriK5k0/b
	 6HpxY1xFkAqFs9O1U79r+IcJvYT/rMDbmP1LJb9k6AMQSz3LJfkn0tUsduWaQlNNAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uv3Celrf;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E1606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 00:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A40E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uv3Celrf
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so7204155e9.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793321065; x=1793925865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDJFbvdkS3S3/SvfTOXomGOADmk0+mqHe0JMv4Qvqcg=;
        b=uv3CelrffGv2bJIFWAWSl98ENhLNHTHKfIhcpEhjZo/rhZxmp7Ame+7y7e9tESDqvh
         ci3Llvr/uezuh6b8ZwVgPzeJeb4PnA0KHE/Y3klwvl8xmIE6kItQBwPqz8sC4yMXD91o
         e6oVyiqQ9mAxHEcxHYyp6VfdixCElg6xkSlsoB8iKOrvZwSTuQs59HEp2+xam3i6xpcg
         cEgIsD4QIoo8xtw0rPmwMlrxhJpUHfjQY2ZXNRK0Bfs9fmI2DBoT/v4pXDjtTgefieVm
         bfOAoFiF78/P6GiN9/WbVEpAv3L7kFJYY4P8OXbMpEmcXM3DPHXKJVwBm1j6QQw1NtSx
         20yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793321065; x=1793925865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDJFbvdkS3S3/SvfTOXomGOADmk0+mqHe0JMv4Qvqcg=;
        b=MbWk7XMm8TUMcs86R8Ua3BWHQBRkWnwrJcdtcdRFKKGkQHHBA4stxTu5OAXP/1WPdQ
         1PLFKP+V0J1WIy5xZabAdwFsslUlyTAkrV2sle9cV5qlmm45CmLITY6hBS1GcPw+9HSl
         nyxyeDczzCyKRd2CAwhAvrHQevKYnp59OTJGjTt3bRujEbvtK4TZflwzMDzQfgRq52gm
         G+6Z/TJx3T0vsx4ebezuiMk2+Chu6hkzcB+taSAJWK4mGtzAIF7ULGnZYaYoPMeEOOhx
         DWuOw6dDyynACr1d8BpH/5PISdiFwr9KyeydQCaukreImfciFnzCZQbKBsEFnOHJ+IIG
         TeTA==
X-Gm-Message-State: AFq9FYLAiVvEMsChMaMoieWTF3/K7xQMgHn/1wDPcQHusKVvnXb8IEBM
	G+woVxUVGzoFQspzthdSVLW+c7+7jRwlqFL+LqAAYQNaxaBoUZ4j+GAa
X-Gm-Gg: AYBFou1ztHfygFqF7SlCepqk6D8EoYtc1j8fi/duk4p2714Em+t/5TiKaFOPFLLYHGq
	vlVO6YQHA4ghrahhlP758SOb3gaNpj5G7R3OOz+cc+/Prl8+RwAy3H/PDi5JnNZb3gSDbQ1L3Vy
	C0d8h6AF8V5xvs8MlZvXbhQrOzmYIgiRL8/tfK+/cf99q08oNanZttU0CMggbFDRu8h0+taLqZB
	+pdfMiDUYkfbO54CpF4XN9XpWyv3Iz4fayxf//Zhq7RFPGUEu8z71xt7oeiP0fWtxRIacy0cgkB
	lhnPe1F9dxobINXq1wiNA0EeN9pSJ/7bAG+nGIvBTizRZi+8SSzhJ8SNhm5JRK0kUZizHTA1jan
	x+cqI1Mq1ixI/89znXbnxESliTiEUJGkEV2RRpOtnskusNmT4sNUIzRv3abdLBkJ6sBlJ1PAnTy
	561xBKbsfI0GijUziWBnWJlrbiuw6mNc66yBlk/7hMCcBITCQdHYbpAKlocxQElTfxWFB0Q0Fm9
	V48THurS0e6gMlzuWELh3sq/rng1j2Lfp2NIpFGc51PPZg2Dn+XCptk/vX2UW+JSp9C3zwRXgPc
	F0eFDphA6HO+cpx9m8pIYPKhBSBIv5uN9qIEpTAIZA==
X-Received: by 2002:a05:600c:4988:b0:4a2:1002:223e with SMTP id 5b1f17b1804b1-4aa8a7ac780mr67449175e9.7.1793321064987;
        Thu, 29 Oct 2026 17:44:24 -0700 (PDT)
Received: from IsoOmenaM3 ([91.136.216.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a1dsm126683f8f.24.2026.10.29.17.44.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 17:44:23 -0700 (PDT)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool v2] Makefile: Fix the feature checks when SHELL isn't /bin/sh
Date: Fri, 30 Oct 2026 01:44:22 +0100
Message-ID: <20261030004422.33732-1-mikatammi@gmail.com>
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

try-build and try-cc pass their test program to the compiler with
echo "$(1)" in a $(shell sh -c '...'). The newlines in the program
survive only while make's SHELL is its default, /bin/sh: GNU make then
runs the command without a shell, splitting it into arguments itself,
and the whole script is one single-quoted argument to sh -c.

With any other SHELL, GNU make runs "$(SHELL) -c" with the command
line, which it first rewrites with a backslash before each special
character and then parses again. A newline becomes a backslash-newline
there, which make removes [1]. The compiler gets the program as one
line, ignores everything after its first #include, and fails to link
it:

  <stdin>:1:20: warning: extra tokens at end of '#include' directive
  (.text+0x1b): undefined reference to `main'

So with make SHELL=/bin/bash, and in every nixpkgs build, as its stdenv
passes SHELL to make, every feature check fails:

 - without HAVE_STRLCPY, include/kvm/strbuf.h declares strlcpy() and
   strlcat(), which glibc 2.38 and later and musl declare too, and the
   build stops at -Werror=redundant-decls
 - no static libc is found, so the guest init is left out
 - on arm64, powerpc and riscv, the build stops as libfdt isn't found,
   unless LIBFDT_DIR is given
 - none of the optional libraries is found

Give printf each line of the program as an argument of its own, so that
the command line has no newlines for make to remove. This needs nothing
newer from make than the rest of the file, unlike writing the program
into a file with $(file), which needs GNU make 4.0. And printf "%s\n"
leaves backslashes alone, which echo doesn't in every shell.

[1] construct_command_argv_internal() in src/job.c of GNU make 4.4.1

Fixes: 328a03bc3f07 ("kvm tools: Add conditional compilation of symbol resolving")
Fixes: 2c82d39a080d ("kvm tools: Add test for -static libc present")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mika Tammi <mikatammi@gmail.com>
---
v2: Add my Signed-off-by, which v1 lacked.
v1: https://lore.kernel.org/kvm/20261030003934.30456-1-mikatammi@gmail.com/

I used Claude Opus 5.5 to track down the cause, write this patch and
its description, and run the tests below; I have reviewed the result.

Tested with nixpkgs' kvmtool package, without its workaround for this
(it defines HAVE_STRLCPY): natively on x86_64 and arm64 with glibc,
linked dynamically and statically, and with static musl on arm64;
cross-compiled for arm64, riscv32 and riscv64. With this patch, the
feature checks give the same results with SHELL=bash as with make's
default SHELL, and with the default SHELL the same results as before.
The dynamically linked lkvm is byte-identical to the one built with the
workaround, a statically linked lkvm now includes the guest init, and
a static musl lkvm on QEMU rv32 and rv64 KVM hosts still boots a guest.

 config/utilities.mak | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config/utilities.mak b/config/utilities.mak
index 612ed1f..3c7cf2b 100644
--- a/config/utilities.mak
+++ b/config/utilities.mak
@@ -183,7 +183,7 @@ _gea_err  = $(if $(1),$(error Please set '$(1)' appropriately))
 # Usage: option = $(call try-cc, source-to-build, cc-options)
 try-cc = $(shell sh -c						  \
 	'TMP="$(OUTPUT)$(TMPOUT).$$$$";				  \
-	 echo "$(1)" |						  \
+	 printf "%s\n" "$(subst $(newline)," ",$(1))" |		  \
 	 $(CC) -x c -c - $(2) -o "$$TMP" > /dev/null 2>&1 && echo y; \
 	 rm -f "$$TMP"')
 
@@ -191,7 +191,7 @@ try-cc = $(shell sh -c						  \
 # Usage: option = $(call try-build, source-to-build, cc-options, link-options)
 try-build = $(shell sh -c							\
 	'TMP="$(OUTPUT)$(TMPOUT).$$$$";						\
-	echo "$(1)" |								\
+	printf "%s\n" "$(subst $(newline)," ",$(1))" |				\
 	$(CC) -x c - $(2) $(3) -o "$$TMP" > /dev/null 2>&1 && echo y;		\
 	rm -f "$$TMP"')
 
-- 
2.54.0 (Apple Git-157)


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793320812;
	b=MmzCPaBi87iEEMULY9OzaklAmLkY9CDWxmk6TI9vM3z1BvTQFx6QL5FLrSjbW69Or5Lv
	 j4bEtyn+o+Sf8ppkc5gCas7rURGXyJvfhiDyNqdW1HIQXVu2PoKcaB0Y6WA0tyIR9cA6e
	 wjzLJH7BetXuYTIiMVQqBuxHv+o9ikHSnNw+B3LKxxjX56fUMuvITHaZ8Bj6yzLeKgdu7
	 yxfC3QovEjTJbR0E8yLx205+l8UxDuvEIztkIcqZJkr/RMF+fsTGn7TLFqW7TzBiowvoV
	 HPtqndfQq7WhGUI6gqHMcP94XvOhrPsT18YihjPfXFywLkNd11y0uA+xRYDTO7pjtWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=g+ayCKw5I3K5VafWEEb2ONwynGPon+gb25iOXiWi2Zk=;
	b=XvSFiZ7JatEi9bTPjQjJDl4JDAPHK99TygmVfbte376aOzYc3BdlxsZdKHtfXa+ywKDz
	 ImQsJdSWe6kc5PT6VpwlFsCdt/xILTBFdT4rkVuYFCECjXD2GLJBqXRxkO6DLxb4fqVbK
	 lWK4UfDZMxBNEGFo3aFq9bmq6+7oLRCJIWHZzDvLA3WVr7gCuA2x/g7btmJbxnNn+uXEG
	 oyFAdqTnI1uwx59z0HsGr9FxC+tE+QhtMBSPkbrWRzwFZgzDKUU+tDI10t7tlFce23Mch
	 QzZgQl26lxmSKkrBZnQGINgNmZQG6qofObLWHUZ0rTF1VOso2Jd9qruuu1v4KsD7wbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VK1+zQTF;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3666606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 00:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3666606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VK1+zQTF
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so147909f8f.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320810; x=1793925610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+ayCKw5I3K5VafWEEb2ONwynGPon+gb25iOXiWi2Zk=;
        b=VK1+zQTFyDw/g8UTwn9ubZN3vqZpawI4ppratlLnIo8DhxRv55uW4AWIYVwlUILqmN
         AFD5ecz2loLnupgLqqUMSc0++eioTBp3shfi6vRQ0/bnPgOfdH24zEzQTJ/afE3DvKv7
         L2Ii0PCQbe2AB0Vsj64wfLoVa3qM5drMFkRSvwx7Op5WMQhLb7sUpOKgiJyP9G/ZsQci
         jTBQd/pdA4KXbKE+g8i1lWK8k3YQ8SttnZfZdZCNWs9lcyEgWcmBCGw4zRj7M+HTYwrB
         l+kodm7zwtzYZ+cYz1srlDj58k1wMMCkHJz/PNbvOZZQii7dFrOLDCOVHLNmQdNgZufU
         NXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320810; x=1793925610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+ayCKw5I3K5VafWEEb2ONwynGPon+gb25iOXiWi2Zk=;
        b=CVHVMd1/qEZdDV3XnfiedWQpuQbKXxUbHvHAjUe0p+YakUsOzbp64kgX/AZbEG1L5J
         DhqwOY4y6IcHfldcobDVIGzKRmuwISIRpMl/5KfNHciOJmw+SES9TM74RFv/joCGsod4
         5lZ52t+wXjMS48u5V4vC8ULsidIlvKRzbCtiW+AdCHeOBxZRuY6dNb+hDRgpzfRZ9+ec
         sOr5x3IPVaaKQK75DXZ2u2QYEuE7z98b69o3A/p1ejIoSs874Jv4QzNMuyu9b9A/Qsy/
         xx9aVmHvWsrhjp9iqGQtb8qti8/m+n3FoLyRlbl6SLW0QpEjKb6+MVM1VTg/6NiDUwEI
         XDUQ==
X-Gm-Message-State: AFq9FYLdeFes7ww5qEFhvjDmEm8Kk7il2bqvtVSND3+MaBJVWf2g2g0m
	pTinmi92DH+qm7aIUB8xL2byDfrr8mDQcSqd7QiB6KHRmPOQp1AZA9uf
X-Gm-Gg: AYBFou15CMRv+GZiapgSOpZ5JCZVVXiy71PLUPF0wCbLC7ltjyUWlLN28wyJKjtliyh
	66c1jmZuVI+SMkPp6HwUnx8/osMylYmiKTzH27DhfdXztG+I1UGojyxPOnHe1UMtZgqtP8MLlza
	FC1MberW5F1zECN1ly6p1w3Ygou04kU4Bcff0sHgpBjA7iP7/dD2XYBodaWzLuU1LCcna/N2CJV
	gDGkOyRhooQuL8/E9gM2PYZbvRgUkRV/qbukt6crzqQIy2SHo3oO9SLdiEBKvBotSO1tiDvMkXP
	cgi9T+0el2alLrAycpHtz54K3GMXifVr5ldz3ceGrsIhFTrYNzHdR655U9nugSlYgojGCBMKxN2
	qNE7VNf7fUG1GulRdGQsg3zsyFS9IpfLWNJAuRGZ9QLZKneqT+rLXILBoxn9AUyVsyxFls0M07h
	yqYllGPCt7sMn0IyGLOJWCl8nIlvsGwdYOWhHnam34G2o9uT+SbDaot0gnExH/p/tbZzLm47q+s
	Ha4Dm8qaRFFjlsAhBC20bOJXH/sEi/bW+mls+0GRt1yjRaH4p/xgfkwVRU8WQWa83eF4+3eb6eg
	p3khzIjNB3e4jiWTJB4Zduh4rEAYSxNcafx4j3g3AXTjK7KVeYoS1J6p5oU2zTo=
X-Received: by 2002:a05:6000:605:b0:487:1ac0:32af with SMTP id ffacd0b85a97d-48e6e50d8d8mr2305209f8f.51.1793320810103;
        Thu, 29 Oct 2026 17:40:10 -0700 (PDT)
Received: from IsoOmenaM3 ([91.136.216.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm115130f8f.32.2026.10.29.17.40.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 17:40:08 -0700 (PDT)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool] Makefile: Fix the feature checks when SHELL isn't /bin/sh
Date: Fri, 30 Oct 2026 01:39:34 +0100
Message-ID: <20261030003934.30456-1-mikatammi@gmail.com>
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
---
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


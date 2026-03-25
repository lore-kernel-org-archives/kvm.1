Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB543EC2C4
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451899; cv=none; b=atW+/c9t8A6wUCh0plNncO7RVX616tMxPPn+/b8NDquYQ1nTtuMDQsv1qCjQ6q+8YNQfyqMgK2FJ/m+5g8f913q2Rt9fzB+/g+0AuG1TWgTu1VeMUe9/h34Qn3lwZ5bf6IRiBghjH0hMFZK6xbZzy46N4e71+V4+NGpnXVlhvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451899; c=relaxed/simple;
	bh=MpdemPxq2gWh/o5rpmvTuOdiS0iQ60avu+K2dQvuaGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WijrEdKqWNknEtnyPpFurNrwKs+P6TQAd2+l0LC1kVWBQvZcER7MriMz87PNjdQkzKhIFDLB/hVdKJoATuBr5Yff0vpr++nqE1o3q23uPnwfs4gdfAhY+4NFFSxHrwq3uY5szyA9KIOELgRlEalxuIfzxopc6KTrgB8KaYWIpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kiz/M5pr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiz/M5pr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48541edecf9so23341105e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451896; x=1775056696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHp+isFeJ+Vwq620YK3TTBZ1M5KgDnZyZo3PdDfV4Bw=;
        b=kiz/M5prlcinIEsCJp8uLxu2Yntk8t7GUxjHXCgQ3r8oA8IENGRpGW8c79iEcyTNyi
         dOGOhPiSZ3ZSV94wCyywJJRMIOScvKXhhgdt/dHaKq+C7SxyHUBGaxltGfvvtjZ/uXvb
         d/+b8rX+89E09R2s7yrwz02Baba2Ip7+cA36nxBAcoJO3GbAp2ELzzF1HwsEELhz4qRx
         ppf8XLq7UwBqWH/06sr9NuU0olvJUegm5YDBlgmS7wOzkifxTut8c20MgvpTZR6Ac9xP
         jyXC8vqD8w8n7ooSgWAMURIr1foWl0F6rJj8d0PIjYuSxWwIyYLe13b5uISwfV9T3vM/
         0S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451896; x=1775056696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHp+isFeJ+Vwq620YK3TTBZ1M5KgDnZyZo3PdDfV4Bw=;
        b=ptNbTlarbMbiQDXWICQcaOQk2h8gQOEbKuOCNdtLsJ6q3DQ3n7XVnqhRGTgNtmorb7
         nFfy4WT/lun7bCppnkVXxLUq0rXmyXpfDW6UlDbjKwJiUYjKRpS3DMrxg6FyirAfflwp
         8+xjN7bFNa3HZjFF7FZR2fHlBjnJyCgNQzMd7BPjXtzPUr+vVU4Fa4or9emvR7dcc2Vy
         Xkmij8kvzezV+RYayecYUzNtDaF0ggHE84cQT2Wnvoxxihq4njR1sAzKILA4q0p3X35D
         xVSzbWr4PrzMuxLtSgIyjcZAF0YGrxPmlsZLRZkQRIysaX4h2GUacFeNV5eV60+QKHb+
         fohg==
X-Forwarded-Encrypted: i=1; AJvYcCW/yPW7X/ZFI/wUNzouTHqB81iGQ7L8chP01V/QN9dRXEjUUfpOjvw3p+OZ6/IWCEC5qoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvrad0LXTp9f94Do8SLwv2RMzo7FJ9yaeWKhxuV2CFdQ1WZnKw
	t2MyYrRGghgABE08aYT6xl73XPQp4X4uogfZQZSS0OGs2qBzODpjn4mVN6qH7KKWjoI=
X-Gm-Gg: ATEYQzzl0Mnqgm223D4l6Bw4clY1CdP3P/kNrohHQkLisT9gDzA/gDWoPdiZdFb0loq
	eJZAxSNRuwo3DE70yG973ucEXxxDZ7eAUkkNhdOy3BRBkNhFVIRIZVbfwvIu+EKclH8yi6fPZCD
	JhUsCgdHlOoZTbwx8aQmSUNkfFWscs6CFNSYlHoDxo2gPJkGqVNwBztOAwXrfJz2pBvDmyDKm9K
	KwjVeoFCy/Z+91V0YaX/e0wDijaTBho95DO9kUqOu5O6DNOb6FLbg0plgUpLz/8RGH+b/j2Kboi
	cR8qrlS0BedpWXWYW0v1jNb3IqV9mFOzpuch7T3rDrFEKt93MJWKEGdFz0Rr1Cyd5TOsYmYxYE2
	6JSs0Mf67EZQG3ghBWh4LPPcqsGRHLqEou9tnzmHh3Lg4JBAgSITzk21WpKUz+ZHvr8S59OhUho
	5NxvlQfus/MmDM6ZusVBdQWYD/n3vx8336OPHET+Ybjj+dtyDr0qpWhmi5auQHIhN3711XKn74j
	sPHTrl2Q6U=
X-Received: by 2002:a05:600c:a408:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-487160a24e2mr43858395e9.30.1774451895998;
        Wed, 25 Mar 2026 08:18:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e60322asm1408455e9.7.2026.03.25.08.18.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:18:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org
Subject: [NOTFORMERGE PATCH 6/6] buildsys: Allow building guest-agent on 32-bit hosts
Date: Wed, 25 Mar 2026 16:17:28 +0100
Message-ID: <20260325151728.45378-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Partially revert commit range 5053e0a65db...90e2e8ada7c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure   | 64 +++++++++++++++++++++++++++++++++++++++++++----------
 meson.build |  2 +-
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index eea90306728..e984ec2bd3c 100755
--- a/configure
+++ b/configure
@@ -381,6 +381,8 @@ fi
 if test ! -z "$cpu" ; then
   # command line argument
   :
+elif check_define __i386__ ; then
+  cpu="i386"
 elif check_define __x86_64__ ; then
   if check_define __ILP32__ ; then
     cpu="x32"
@@ -399,22 +401,30 @@ elif check_define _ARCH_PPC64 ; then
   else
     cpu="ppc64"
   fi
-elif check_define __mips64 ; then
-  cpu="mips64"
+elif check_define __mips__ ; then
+  if check_define __mips64 ; then
+    cpu="mips64"
+  fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
   else
     cpu="s390"
   fi
-elif check_define __riscv && check_define _LP64 ; then
-  cpu="riscv64"
+elif check_define __riscv ; then
+  if check_define _LP64 ; then
+    cpu="riscv64"
+  else
+    cpu="riscv32"
+  fi
+elif check_define __arm__ ; then
+  cpu="arm"
 elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
 elif check_define EMSCRIPTEN ; then
-  error_exit "wasm64 must be specified to the cpu flag"
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -440,6 +450,18 @@ case "$cpu" in
     linux_arch=arm64
     ;;
 
+  armv*b|armv*l|arm)
+    cpu=arm
+    host_arch=arm
+    ;;
+
+  i386|i486|i586|i686)
+    cpu="i386"
+    host_arch=i386
+    linux_arch=x86
+    CPU_CFLAGS="-m32"
+    ;;
+
   loongarch*)
     cpu=loongarch64
     host_arch=loongarch64
@@ -448,7 +470,7 @@ case "$cpu" in
 
   mips64*|mipsisa64*)
     cpu=mips64
-    host_arch=mips64
+    host_arch=mips
     linux_arch=mips
     ;;
 
@@ -464,8 +486,8 @@ case "$cpu" in
     CPU_CFLAGS="-m64 -mlittle-endian"
     ;;
 
-  riscv64)
-    host_arch=riscv64
+  riscv32 | riscv64)
+    host_arch=riscv
     linux_arch=riscv
     ;;
 
@@ -500,6 +522,9 @@ case "$cpu" in
     linux_arch=x86
     CPU_CFLAGS="-m64"
     ;;
+  wasm32)
+    CPU_CFLAGS="-m32"
+    ;;
   wasm64)
     CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
@@ -1287,7 +1312,7 @@ EOF
     test "$bigendian" = no && rust_arch=${rust_arch}el
     ;;
 
-  riscv64)
+  riscv32|riscv64)
     # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
     test "$android" = no && rust_arch=${rust_arch}gc
     ;;
@@ -1449,18 +1474,26 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=aarch64-linux-gnu-
         ;;
-      alpha|hppa|m68k|mips|riscv64|sh4|sparc64)
+      hppa|m68k|mips|riscv64|sparc64)
         container_image=debian-all-test-cross
         ;;
       mips64)
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
-      ppc|ppc64|ppc64le)
+      ppc64|ppc64le)
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
 
+      # debian-legacy-test-cross architectures (need Debian 11)
+      # - libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+      # - sh4-linux-user: binaries don't run with bookworm compiler
+
+      alpha|sh4)
+        container_image=debian-legacy-test-cross
+        ;;
+
       # architectures with individual containers
 
       aarch64)
@@ -1930,7 +1963,14 @@ if test "$skip_meson" = no; then
   if test "$cross_compile" = "yes"; then
     echo "[host_machine]" >> $cross
     echo "system = '$host_os'" >> $cross
-    echo "cpu_family = '$cpu'" >> $cross
+    case "$cpu" in
+        i386)
+            echo "cpu_family = 'x86'" >> $cross
+            ;;
+        *)
+            echo "cpu_family = '$cpu'" >> $cross
+            ;;
+    esac
     echo "cpu = '$cpu'" >> $cross
     if test "$bigendian" = "yes" ; then
         echo "endian = 'big'" >> $cross
diff --git a/meson.build b/meson.build
index d7c4095b395..ae412263ec7 100644
--- a/meson.build
+++ b/meson.build
@@ -323,7 +323,7 @@ endif
 # Compiler flags #
 ##################
 
-if cc.sizeof('void *') < 8
+if not have_ga and cc.sizeof('void *') < 8
   error('QEMU requires a 64-bit CPU host architecture')
 endif
 
-- 
2.53.0


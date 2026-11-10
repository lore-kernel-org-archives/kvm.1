Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342814;
	b=nBibRW+hKPCdcRPaxclCBwDi6/jbK4JcSyXjO9nKBg5B5nnYe0sYdmDJGd1PUMS7gpFL
	 lH7r+RXgjm/VYTtq7qEE2XlY/WD4uzjdUXe6hyD1Gi055xE6kAq1cTlFBM9eXXxup/psZ
	 J68wnSPk5JIx24x1wQIXqzYr9SxgvTUKxXts7soDH16EKDf10/s8Wroxyhq/MtGZpQrKJ
	 YItROaAHt8fblZ3paVljB5iUYL/VwoEtWwkGUtTOS5IDrHCCaf8Hj2nXOHQGs7gmHlsMe
	 XmcqBvtekwADWi5FPGJ5XlMURRkrJgl6EylQGFd5hjNBixf8u2qUfdJLLFl0XsKkjTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=W7PiBRIxIQWxlBVmTUgm82BXTtlWQOY8DOJouVlWEbc=;
	b=CY+QK9aiQ+RnlmhRpV9eERoB8P5KhffozIQACCKNZdqAANQ9qhpykdEqTIKSJHJSaBtC
	 FkNHnBRsVnlB5mdrhBoTSWgR22LwadoHNbW7KtceFQQ9H4ksnzUDxaLM/IanBROl7zU6B
	 q3o/0QaHF+TuwsVrIIApEd5zVLmdf6qLjDaug/Ne96AmgOeJquQxlBH14iYj6MumCkiso
	 ScckhB8ho0iBmf6VObIud9E2P9HfbvAhHFpxqGD21NykUlH69T0zrijK5/FmuTM+Edt4X
	 7bGRw3vO3PIIkCdGrotm+0EMkeLqRC7bsCCHj0V97BeDf3lpOoE/rg0hOhq4SinlVBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LHdDH70S;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C518606A325
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 20:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C518606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LHdDH70S
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e954d87b48so37465445ad.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794342813; x=1794947613; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7PiBRIxIQWxlBVmTUgm82BXTtlWQOY8DOJouVlWEbc=;
        b=LHdDH70SQTAlGlOHZJ8OmWoY5mSzDxfdJ6ry6utEM2+tbzPdbVR3zDup7Elpb5mkfC
         8SZph/EUwqHwoDt650JdmteglN8nb+iUQUJWRZEhphs4+oY7VMP9IH08n3Jnd1FsDYPI
         paNmd+8c5mgB8kKPIm9Fj8fs11njK2zNsbgeC1+KCSCBke9Ems/F4pkZJ1DOYavKnJXy
         G3MILmbXp1klukIYR5ga2VyCQ5eXmKEBQ0u3aT536pSRZdZicj7rn++w/3mWBbQmXsiN
         jMrTLFGV/3mjaxrOfmnKwTZmhHlGVryIXFjdx5NYeZ0jWXtwI02XyIBB8eGyWCbslK/B
         1obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342813; x=1794947613;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W7PiBRIxIQWxlBVmTUgm82BXTtlWQOY8DOJouVlWEbc=;
        b=h4JNxWdHGBTAaQ9TNkHnoC7U2N/p2EvdMIwh2m872BvJig+d5Z4sZGinJ32fa15guY
         H44BuM/irUReP2uEQxHLIFUUFggazMDy1KlXSdxabgwRd3fjCvTxh0k6EgyrSYIhzixw
         cnOKtU0JJTm5mff/Vvt30wmRKj1fbfRloxqLmM7wyjEHQUFuifua3aDaCKWFV8hRYhWt
         XkWS4XKqgJcflVTEVKoxc2nuHEdwUmV7Vgo1s05uXcqA6VG1NAPYO5oyJ4ArMyGbmIqO
         nxQ40K8JMW2Jaa0guALqQHutJaO4pue0M06fBViuErQai8cOfknUxu3JoRVCHDTo0sPO
         lyCA==
X-Forwarded-Encrypted: i=1; AL+hErEJUy3/DIkLEY65APFO6rLH6I5/QceLFPpQ7VYeZ+d8bwRMf3IHCOMBhxJbWjyEsutoBoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qxwfqKSxIQj8q9S+sjkMyiQTwB3SRY6lOvFjbhWZdDO1PP8vv
	qsnDwNxZqHuaIWvcSJ7uzB6IGIK1QpkWZ4DdiTTsdb7YAXIdvPPqv7oo3UONeBWybZutaiLwh6I
	ZUaFgVQ==
X-Received: from plbio14.prod.google.com ([2002:a17:903:12ce:b0:2e5:ffbf:77d8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22ca:b0:2df:991b:4368
 with SMTP id d9443c01a7336-2edd7a4a36amr2909545ad.53.1794342812593; Tue, 10
 Nov 2026 12:33:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Nov 2026 12:33:30 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110203330.11789-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Override memmove() to prevent "magic"
 references to memcpy()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Override memmove() along with the other string operations to prevent the
compiler from generating a reference to the built-in memcpy() when using
musl as the libc with a static build, which utlimately results in an error
during linking due to a duplicate memcpy symbol:

  ld.lld: error: duplicate symbol: memcpy
  >>> defined at string_override.c:23 (lib/string_override.c:23)
  >>>            $BUILD/build/selftests/c/lib/string_override.o:(memcpy)
  >>> defined at memcpy.lo:(.text+0x0) in archive $BUILD/build/musl/lib/libc.a
  clang: error: linker command failed with exit code 1 (use -v to see invocation)
  make: *** [Makefile.kvm:382: $BUILD/build/selftests/c/demand_paging_test] Error 1

The failure crops up when linking in the TDX library code[*] due to
tdx_init_vm() generating a call to memmove(), which is "fine" until the
perfect combination of static linking with musl triggers the above.

All kudos goes to AI for figuring out the insanity:

 1. string_override.c defines its own memcpy, memset, memcmp, and strnlen (so
    guest VM code doesn't jump through the dynamic linker's PLT in normal
    dynamic builds), but it does not define memmove.

 2. In musl on x86_64, src/string/x86_64/memcpy.s (memcpy.lo) defines two
    global symbols at the function entry point:
      .global memcpy
      .global __memcpy_fwd
      .hidden __memcpy_fwd
      memcpy:
      __memcpy_fwd:

 3. And musl's src/string/x86_64/memmove.s (memmove.lo) implements
    non-overlapping forward moves by jumping directly to __memcpy_fwd:
      memmove:
          mov %rdi,%rax
          sub %rsi,%rax
          cmp %rdx,%rax
          jae __memcpy_fwd

 4. As long as nothing calls memmove, ld.lld already has memcpy from
    string_override.o and never extracts memcpy.lo from libc.a.

 5. However, the one library file that calls memmove (either directly or
    transitively via a libc.a function like getline/stdio that only that
    file uses) causes ld.lld to extract memmove.lo from libc.a, which has
    an unresolved reference to __memcpy_fwd. To satisfy __memcpy_fwd,
    ld.lld is forced to extract memcpy.lo from libc.a, which also defines
    memcpy and collides with string_override.o!

Link: https://lore.kernel.org/all/20261105-tdx-selftests-v16-3-2024e8fa517a@google.com [*]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm          |  2 +-
 tools/testing/selftests/kvm/lib/string_override.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..031f78643af8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -295,7 +295,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
 	-U_FORTIFY_SOURCE \
 	-fno-builtin-memcmp -fno-builtin-memcpy \
-	-fno-builtin-memset -fno-builtin-strnlen \
+	-fno-builtin-memset -fno-builtin-strnlen -fno-builtin-memmove \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
 	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
diff --git a/tools/testing/selftests/kvm/lib/string_override.c b/tools/testing/selftests/kvm/lib/string_override.c
index 5d1c87277c49..3bc434f46177 100644
--- a/tools/testing/selftests/kvm/lib/string_override.c
+++ b/tools/testing/selftests/kvm/lib/string_override.c
@@ -29,6 +29,20 @@ void *memcpy(void *dest, const void *src, size_t count)
 	return dest;
 }
 
+void *memmove(void *dest, const void *src, size_t count)
+{
+	const unsigned char *s = src;
+	unsigned char *d = dest;
+
+	if (d <= s || d - s >= count)
+		return memcpy(dest, src, count);
+
+	while (count-- > 0)
+		d[count] = s[count];
+
+	return dest;
+}
+
 void *memset(void *s, int c, size_t count)
 {
 	char *xs = s;

base-commit: cf7fa575900051e489f95944c65f432ea706ed73
-- 
2.56.0.542.g3ef89b7020-goog


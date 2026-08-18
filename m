Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96237DEA9
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085889; cv=none; b=qVk92UvYoaPvIlgW4lKBjQIQRPrTcATheKCfHQDlQSeHON8M9CrpQWCw4NFqIGqr6VmWGwdnDiEole+1AY4EeKjRlVvkvkyFypZPAjIFL2/f3e13iY52/FymOUI+qiuPjIFDozJ04HR3gAe/6YIObT3gqRYDslNJMDB1vFEgwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085889; c=relaxed/simple;
	bh=ZB6FS7d6rxJm0eRcCioFKxP3aQ+ImQH6EdK/FZ+/OUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YfAVrLT17MJH239Jz75srWh4bly5wM28TdpCfFjORQMyju1Qq5teW/sEA27GmkI3uUkG7YWBXlDQJfLqh7gpUbtAM7jcuCjfO6h+KvgJr7SPtMPcfUkexCKzDKj9R9PUitsmXHjPAu3j0ntjNxEDLKC5HlTbHtrRHOAmPgxV5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mP0IAjWe; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mP0IAjWe"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a3514f912so518233b3a.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085888; x=1787690688; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmFVlsgAYCtkRLriUR3Oc/OpxK2wKe12tzMJ0rDrbCg=;
        b=mP0IAjWeFluqZFu3YPZzSdVpD4PBouHnTQMHeRRLzYznXuUTuXfKZ+jvUeNtkJaNno
         9bpIY41DumUgtvwjv0c01k77h8+G69JY11ySe4fAQDAYGkfqc3xrfMP/1pRL6y3YBw/E
         sTULDqnnOv3QhXTArhBiLMF25SgnriOAtMP5yW218b/mrgMlfDGgsKYWjj255MeMNLSM
         Sp2wBtaZ5iGbOKltkyxMA3PmvkYGeWv+lpyLQbBGmA01XC8//DR4cymnzUjiaDubXxwF
         lorTQ/o8kohlYLbLORb9D0YxckTEYDpx8zXrtFboclZa7JtY40ewvj5qGfsREzYNYS7C
         7HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085888; x=1787690688;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rmFVlsgAYCtkRLriUR3Oc/OpxK2wKe12tzMJ0rDrbCg=;
        b=KRfkxHcBWxW/iKGnLR7DfszeP0Ve4rP2Z98URT+B/Qetl2nRoSRveLs99ApiYbf1ke
         FKyNveK8esMqIb3f8efE+3NW6NIO2NeMAm3rOElLSp8ofHYKfSPoT6HYp797Hu5HuA8r
         PcX/xKC+2L649O2xQlF6NxnAZSz+cEPWYu1mLJBxOZx+xnnetShwP5UUQTS8CfnvrWrN
         g2SkXh7VUegdB678LZ/dj46Zda9uqs7JWbZVsZgkoTwOCDBI1BLD0PK4ZywnAdTuk7l4
         CWS5dLPu/o3lbROPHP3i4OeigT0y1AQieVzRYUHGYS1A1KS23SlxntsneQN4AWAp0rCD
         ND4w==
X-Forwarded-Encrypted: i=1; AHgh+Ror8Tfe9NOFa4Xq+K1PV+knCq8vDziCG5TlRptaQgo6Ejt6rzRgW9f5D50hTuCB3gPH7Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWIZiDX9cBoO/mrK2jUSmtHMo/a1rVRWTSSA8vGM8/hEAtL+U
	3UrGOB/8YIlodI0Jwo4OOG5XLg1hPw6fm+hsvKOtMgoreVUW/GWB2v+LU678NlkUkIj0onZf+8Q
	1VVxNutxq
X-Received: from pfew19-n2.prod.google.com ([2002:a05:6a00:c1d3:20b0:84f:dde6:e818])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c91:b0:847:9015:e68c
 with SMTP id d2e1a72fcca58-851cdaad991mr1536495b3a.17.1787085887607; Tue, 18
 Aug 2026 13:44:47 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:19 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-5-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 5/6] x86: Add xstate parsing and PKRU offset detection
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Add data structures and CPUID detection routines to locate the PKRU
register inside the Linux x86_64 signal frame extended state (`xstate`).

Signed-off-by: Jacky Li <jackyli@google.com>
---
 util/pkey.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/util/pkey.c b/util/pkey.c
index 2e42da7d9c..21b41f928e 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -88,6 +88,59 @@ static inline __attribute__((always_inline)) intptr_t local_syscall3(
     return ret;
 }
 
+/*
+ * Custom structures to parse FPU xstate and extract the PKRU register.
+ * These match the Linux kernel x86_64 signal frame ABI.
+ */
+struct fpstate_64 {
+    uint16_t cwd;
+    uint16_t swd;
+    uint16_t twd;
+    uint16_t fop;
+    uint64_t rip;
+    uint64_t rdp;
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    uint32_t st_space[32];  /*  8x  FP registers, 16 bytes each */
+    uint32_t xmm_space[64]; /* 16x XMM registers, 16 bytes each */
+    uint32_t reserved1[12];
+    union {
+        uint32_t reserved2[12];
+        struct {
+            uint32_t magic1;
+            uint32_t extended_size;
+            uint64_t xstate_bv;
+            uint32_t xstate_size;
+            uint32_t padding[7];
+        } sw_reserved; /* Extended state is encoded here */
+    };
+};
+
+#define FP_XSTATE_MAGIC1 0x46505853U
+#define FP_XSTATE_MAGIC2 0x46505845U
+#define XFEATURE_PKRU 9
+#define XSTATE_PKRU (1ULL << XFEATURE_PKRU)
+
+static int pkru_offset = -2; /* -2 means uninitialized */
+
+static int __attribute__((unused)) get_pkru_offset(void)
+{
+    uint32_t eax, ebx, ecx, edx;
+    __cpuid_count(0xd, XFEATURE_PKRU, eax, ebx, ecx, edx);
+    if (ebx == 0) {
+        return -1;
+    }
+    return (int)ebx;
+}
+
+static int __attribute__((unused)) qemu_get_pkru_offset(void)
+{
+    if (pkru_offset == -2) {
+        pkru_offset = get_pkru_offset();
+    }
+    return pkru_offset;
+}
+
 __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
 {
     if (guest_memory_pkey != -1) {

-- 
2.55.0.737.g08866a6d13-goog


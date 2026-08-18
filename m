Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F837E30C
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085891; cv=none; b=LQZoTsRD0BT5f0OhIdrPA+8yUhDhUM+pC2mF6F6YueqbO3hOFpUqtT+ARqsAx2M/gjwcFNxpy9FmfKHO77CPYqkZ6N4ebFKBbfeSIkPyQUBN1FKRQZQd7wkl8a3QW6TGZHEFHd7BkfrVlemViWSdKh16NFAY6U59Jiw+v4gQCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085891; c=relaxed/simple;
	bh=k4vS1xA8pK74tdHgapoiGseITwZ8VsarIos+MHTpqyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lfEC9sq2/ciOPgMLDsgIluhczllDyFJaiVg8nGgzqF5a8j28ecfxLfNWmXE+gsBfLzwai6KfbU0TCKpahCXuNlsRxlYWrU9g0uAfBNtG+wQPY93BZnkvhCq80QRMfa4kCxpvFBJ5EK31nXWL3mOhwoU5UyI/lGBlleDrI4EvBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrTKSLNJ; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrTKSLNJ"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e048a801dso420855b3a.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085889; x=1787690689; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FKKUj8w/BG3XrvFfnyuNucawzEx5NoiVOq2alPXUU0=;
        b=qrTKSLNJgTjOrbaR/A60F11ClMvJFbIFtPP51HK3xROwJtOy9XvVoxOK8iKV7LalFY
         FVWfUaRUYpKf+kbJWBNZLV3RTP2ViGx8GjSWLSLGzXha3HLcfhYptGMvp/OTr1+7bFPf
         RrSECuFGX2chHZkVwA+3LCt11A7BMq1+/LFb7e7sUX0GrS+4aNLO/Zznaps/B6tg2Nd4
         luw8SMx2evfXwUYi0nWJuIoZdB9svxxcrXrViMgoF+jq8vSVScMDdD/p7V0vHJbE6Ek1
         /EAw3iVmON/cDHhbzOnG/pByxg7iuIlHraSyCCONKlO0qqYVmjAmS5l2PxrAIjrX6i4a
         HTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085889; x=1787690689;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FKKUj8w/BG3XrvFfnyuNucawzEx5NoiVOq2alPXUU0=;
        b=hmPRS3o1hpQbU+SnAKs6kUMBA8S27DFZHiyMxo0hCmqL7mrXoI2W9IZ9OMAys+2j5N
         hMdetGx5t3reymH0hIjQ5Kj+x9loMTyyWj93ZuoD06UUsQrEDXHZ29VWynYpGwfWIdvv
         j7PK3rTwyUjcVynsrq0G/78FlphWgqxCQ8Gc2+yF+BkHT6nEQtOsnCHN7PqpzXjw6OgJ
         092a9CVDDKWoTvQ6k+MGHwur467NW6ILV6iQi1Bd9nFmR3s1HBOVFOUWX07VvVZ5kR8l
         fjGcgSchcKd0EJySmEnhZVbZ+G/PCXSutj2Wp1rohGvDYfigNeZGu8ofO1PWb6hTsuZl
         am4g==
X-Forwarded-Encrypted: i=1; AHgh+RruBRHZ6cb1YHbqZl9L4nFxsALpp/8oK9xUGoSzDzYGhbY+czUuQwtvkjrCR7KZV/XBDLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAkhZ+KHEhgFWfqQSlK5SLNzQBKTkpuyEpHonMLv08AjZJkzH
	jwll43T+I9O7RSFMZkOYlFBWQmijMK98NJP2Bxmf4AwnIQuCERje2STYH2jFsnEAvSHjQsYBiiN
	M7soH2gxi
X-Received: from pfbfn22.prod.google.com ([2002:a05:6a00:2fd6:b0:84c:2e88:693d])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc9:b0:847:982e:cca0
 with SMTP id d2e1a72fcca58-851cda94536mr1368944b3a.19.1787085888702; Tue, 18
 Aug 2026 13:44:48 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:20 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-6-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 6/6] kvm: Implement SIGSEGV sentinel for Pkey recovery
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Implement a fallback `SIGSEGV` signal handler
(`qemu_pkey_sigsegv_handler`) to recover from legitimate host accesses
to Pkey-protected guest memory when locked.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 util/pkey.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

diff --git a/util/pkey.c b/util/pkey.c
index 21b41f928e..689fec8003 100644
--- a/util/pkey.c
+++ b/util/pkey.c
@@ -123,7 +123,7 @@ struct fpstate_64 {
 
 static int pkru_offset = -2; /* -2 means uninitialized */
 
-static int __attribute__((unused)) get_pkru_offset(void)
+static int get_pkru_offset(void)
 {
     uint32_t eax, ebx, ecx, edx;
     __cpuid_count(0xd, XFEATURE_PKRU, eax, ebx, ecx, edx);
@@ -133,7 +133,7 @@ static int __attribute__((unused)) get_pkru_offset(void)
     return (int)ebx;
 }
 
-static int __attribute__((unused)) qemu_get_pkru_offset(void)
+static int qemu_get_pkru_offset(void)
 {
     if (pkru_offset == -2) {
         pkru_offset = get_pkru_offset();
@@ -141,6 +141,155 @@ static int __attribute__((unused)) qemu_get_pkru_offset(void)
     return pkru_offset;
 }
 
+static __attribute__((target("pku"))) bool do_qemu_pkey_sigsegv_recovery(
+    const siginfo_t *si, ucontext_t *ucontext, int pkey)
+{
+    if (pkey < 0 || pkey >= KEY_COUNT) {
+        return false;
+    }
+
+    if (!ucontext) {
+        return false;
+    }
+
+    void *fpstate = ucontext->uc_mcontext.fpregs;
+    if (fpstate == NULL) {
+        return false;
+    }
+
+    struct fpstate_64 *fpstate_64 = (struct fpstate_64 *)fpstate;
+
+    if (fpstate_64->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+        return false;
+    }
+
+    uint32_t *magic2 =
+            (uint32_t *)((char *)fpstate + fpstate_64->sw_reserved.xstate_size);
+    if (*magic2 != FP_XSTATE_MAGIC2) {
+        return false;
+    }
+
+    if ((fpstate_64->sw_reserved.xstate_bv & XSTATE_PKRU) == 0) {
+        return false;
+    }
+
+    int pkr_offset = qemu_get_pkru_offset();
+    if (pkr_offset < 0 || pkr_offset >= fpstate_64->sw_reserved.xstate_size) {
+        return false;
+    }
+
+    uint32_t *pkru = (uint32_t *)((char *)fpstate + pkr_offset);
+
+    uint32_t access_rights = (*pkru >> (pkey * BITS_PER_KEY)) & KEY_MASK;
+    if (access_rights == 0) {
+        return false;
+    }
+
+    /*
+     * Flush microarchitectural state (IBPB) before returning to avoid
+     * speculative execution.
+     */
+    prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0,
+                0);
+
+    /*
+     * Clear bits in the saved PKRU so that access is unrestricted upon
+     * returning from the signal handler.
+     */
+    *pkru &= ~(KEY_MASK << (pkey * BITS_PER_KEY));
+
+    return true;
+}
+
+static void (*old_sigaction_func)(int, siginfo_t *, void *);
+static void (*old_sighandler_func)(int);
+
+static int pkey_recovery_handler_installed;
+static int pkey_for_recovery = -1;
+
+static void qemu_pkey_sigsegv_handler(int si_signo, siginfo_t *si,
+                                      void *raw_ucontext)
+{
+    ucontext_t *const ucontext = (ucontext_t *)raw_ucontext;
+
+    if (si_signo == SIGSEGV && si != NULL && si->si_code == SEGV_PKUERR) {
+        int pkey = qatomic_read(&pkey_for_recovery);
+        if (pkey >= 0 && do_qemu_pkey_sigsegv_recovery(si, ucontext, pkey)) {
+            return;
+        }
+    }
+
+    void (*old_sigaction)(int, siginfo_t *, void *) =
+            qatomic_read(&old_sigaction_func);
+    if (old_sigaction != NULL) {
+        old_sigaction(si_signo, si, raw_ucontext);
+        return;
+    }
+
+    void (*old_sighandler)(int) = qatomic_read(&old_sighandler_func);
+    if (old_sighandler != NULL && old_sighandler != SIG_DFL &&
+            old_sighandler != SIG_IGN)
+{
+        old_sighandler(si_signo);
+        return;
+    }
+
+    /* Fallback: abort */
+    const char msg[] = "QEMU: Received unexpected Pkey SIGSEGV\n";
+    int unused __attribute__((unused)) =
+        write(STDERR_FILENO, msg, sizeof(msg) - 1);
+    abort();
+}
+
+static void qemu_register_pkey_recovery_handler(void)
+{
+    struct sigaction old_sigact = {0};
+    struct sigaction new_sigact = {0};
+
+    if (qatomic_xchg(&pkey_recovery_handler_installed, 1)) {
+        return; /* Already installed */
+    }
+
+    if (sigaction(SIGSEGV, NULL, &old_sigact) < 0) {
+        error_report("QEMU Pkey: Failed to get current SIGSEGV handler");
+        qatomic_set(&pkey_recovery_handler_installed, 0);
+        return;
+    }
+
+    if (old_sigact.sa_flags & SA_RESETHAND) {
+        error_report(
+            "QEMU Pkey: Incompatible SA_RESETHAND flags in old handler");
+        qatomic_set(&pkey_recovery_handler_installed, 0);
+        return;
+    }
+
+    if (old_sigact.sa_flags & SA_SIGINFO) {
+        qatomic_set(&old_sigaction_func, old_sigact.sa_sigaction);
+    } else {
+        qatomic_set(&old_sighandler_func, old_sigact.sa_handler);
+    }
+
+    new_sigact = old_sigact;
+    new_sigact.sa_flags |= SA_SIGINFO;
+    new_sigact.sa_sigaction = &qemu_pkey_sigsegv_handler;
+
+    if (sigaction(SIGSEGV, &new_sigact, &old_sigact) < 0) {
+        error_report("QEMU Pkey: Failed to register SIGSEGV handler");
+        qatomic_set(&pkey_recovery_handler_installed, 0);
+        return;
+    }
+}
+
+static void qemu_add_pkey_for_recovery(int pkey)
+{
+    int expected = -1;
+    /* We only support one recovery pkey at a time */
+    if (qatomic_cmpxchg(&pkey_for_recovery, expected, pkey) != expected) {
+        error_report("QEMU Pkey: Recovery Pkey already set to %d",
+                     pkey_for_recovery);
+    }
+}
+
 __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
 {
     if (guest_memory_pkey != -1) {
@@ -154,6 +303,10 @@ __attribute__((target("pku"))) void qemu_init_guest_memory_pkey(void)
             error_report("pkey_alloc failed for guest memory: %s",
                          strerror(errno));
         } else {
+            /* Register recovery signal handler and add pkey for recovery. */
+            qemu_register_pkey_recovery_handler();
+            qemu_add_pkey_for_recovery(pkey);
+
             guest_memory_pkey = pkey;
         }
     }

-- 
2.55.0.737.g08866a6d13-goog


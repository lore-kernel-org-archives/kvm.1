Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EB4252B3
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934395; cv=none; b=H//+PYrmvIWLAmLnBFveGmQkXoHvcQ3oZ7/7Q/aBN7E0XLp/WamHpGLkIR04Ufrv3E5h0mLNwlo/A3JR85mej/RpsRU73RVJaa3Wc1THeB1yzgNu92GEZ2/1vNHjtoptKIIel/MkcRMKovMSsEtVxUDlwzwnsMBdKtR8HJXipJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934395; c=relaxed/simple;
	bh=LXKQSRRHn2Tmdw6xmC/NKQLjwuUTQrIvkVaRCcna4n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CzLE5jysGaUGEdA85yCgq2Ji5WNubHFDa9i5v/i5DabiytQkDFqgH7GwybzJqUJjKsOsI8PA2LiRWMhtDLAwk+SEU1hTiMVydYrzcPdRyriebMN2YgHOC1SI6Rp0mkttVKh58fOTdnSAVfg9vI3YJroA9Gjk1kJwkIoINhJgTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwyAPGws; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwyAPGws"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38096521198so1608086a91.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934392; x=1783539192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aK5m/cPAf0bdBYumbExr1aJO4L8QPhhYatB0l9CbU30=;
        b=AwyAPGwsPYlhqFXRJB/aLLEjT9NP+Tf07Ufe/wgeSpEYpHBdwpzYAXN/Pd3QM/J9fW
         Z1PCeH8Nt3GRLV0KC/TSSreQ5cXvIHuR8xF4ztPp3Z1mGgSEYkV/cAN5JhrH5MNo0tOJ
         +sTeV+5aiqjpAwg6sJHh1jm/t37QcZDY7UUcS/nVMf533r6dg6Pj32SPEzqVtg0tBNmA
         Zz3JjW4C0eZdA8eV7hi/AG8NCXojXqxx1ltIDaVyZtmevZkQUphnWoglwcFZQ8+eKhM7
         Kfo/AM3ZxFoRdUUC43gJsZSTF6I+UmRGXuzLae2jINBb2G/oqE+J+Zp/XKy7lG8gTA6G
         q+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934392; x=1783539192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aK5m/cPAf0bdBYumbExr1aJO4L8QPhhYatB0l9CbU30=;
        b=KUfkSsVfDYUe8o0kJ0hoF50qRN6iGaa8byOSgT6k9QjDnieoaV/IIwwVmjT/xdpJ3r
         EiYEyKBQ3bKOkm+D2/bOofosEHcct59qRwus+683KSwcrfrC2uykcRkEuoLH00gL0aYb
         LLoh1tJTKEX7C/IY+zw7FfyGWP1jqwReCmb3dmdWdIWWBCbuQA4q2ew/PSnJ7j98fMMx
         s5EVzPeS4hz+29V2nT5J8RLfNGDW5QmU4+CXYnhwNCpVAQ5c+F+nRzwxqZa4bMkHlXUc
         IQgZTOHc9mxlY67K3zy3zJADoiIlczwvQeAVf4+q8yqyvRFGMNNynaIkkVh8spxn96g2
         lBjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbqZ/JmYQ56UMzxE/EnaoG0NljfJWVtyB1zUCXaliqaW8N81uPBJRQCxJFsY3n17/qPgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNTRCArcgCP3kmwE7uAMmQOYTeUUas0tuYPV2sG9zvWRJOUQB
	Psx4EvczFAi7T3taCd5ufpZRAshGZsSrmSSYkDR4c7KtNjMYJ7ZapH+wHIHcTzY4U0anVDOrzA6
	tweC2NQ==
X-Received: from pjbil4.prod.google.com ([2002:a17:90b:1644:b0:37d:ece0:dd38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:37f:9ce1:cdaf
 with SMTP id 98e67ed59e1d1-380aa1ed882mr2896319a91.29.1782934392117; Wed, 01
 Jul 2026 12:33:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:58 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-38-seanjc@google.com>
Subject: [PATCH v5 37/51] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5b9955343199..5220d205abc7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -155,20 +155,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -325,6 +311,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C723E8688
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067275; cv=none; b=IZ/Z5rV25gnIouW5KHI4FU3P5JnnKZswqip3E78D2eO0nYClfPFeJPrJE88jhCbjC4BMK4G0IbvsYD96SG6v1wfVLH8cMPRhBmVhf88NoTWKNtj0cm0WecmLNjF0xZbc/ZJsnM1i0hIzRKKDvXR82/nNxWVqoJ7XVGpW28aCcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067275; c=relaxed/simple;
	bh=jVoGol12bIRznjNhieU5A4Tdk7z3jKrmByZepFDORvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sTLXnHUZNfpE7My50pN9lNJfD4ClZRAIVCiH7UM2FpWaOEq4GlKtDLWHhzea3gVdmVtGRz5EWakJPYWNQ7zGnTSH3y5wy52aNYgsIUE2CWccCHkSvRVPnucL5Fxk0fnBSqvw8+QhoWib1UNG6erMaNm9wHBX+K0ZZGjva+hugn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WKT3vjwP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKT3vjwP"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso26603524a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067273; x=1780672073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kJfvO9zjLIcNgxwydf05ic8q1+t5yL6F8Cppp5YBjVQ=;
        b=WKT3vjwPfMnixG7ZQirCo+lluDVkV2CZZo0rcELgtwMV9SQo1UDSdpst96Vc0qXM72
         BY4qAZGZ92i93Bm2TDwnQxh3qMmPYNYuNSEG2QXc2FmGZLJIblzCGB92eutxiWgos1Md
         4gFYK0xj2QbKG264ZF4zXZKSqbGrlOJ/FTbwFokVvOmKaUa0Wc9uj5AONgu31aUxRkLW
         s0QVwZ3AaILl04eSzQGyMJB0s/1E1Meldn4ra5j8QBgmSncXLq9xezvwGH8A3ZCELs5N
         rkgZDGl/RxlUt90FbHiNAmMhtcEovoRh21lRW3Xmv4V/Pc4rRhoToVVqdzdQDXis6w65
         b/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067273; x=1780672073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJfvO9zjLIcNgxwydf05ic8q1+t5yL6F8Cppp5YBjVQ=;
        b=VTkF00MYW6lp1dAccLYndKpizoz2ZJw/Ro+XOuUCV+KaaMfDFixPTpB5TmWsPp53QO
         rpryxMgKiBlMU6DBcvh4mRwoZHg5r1LxDEoptna4tIeUcuqvUrSG+Ia+I/7TA5VAB14k
         oD+iBVVkNdYHt1L4ThZVMIYHUJUC50uBCqjT86Z4ltPblo+cRr2cKoxZKVKV0Qyiib2/
         vbY+2b9SvJBAyOuVQFEFARkOq8UbUavz0iElRJUmL7HxVTNYscxHau5VaLiXdAusjCQ+
         cfsiUcyZdsyygL2RMPKEg8+yismN4k8DFgE+Hty5Iv2xy7XDoyaPZR1+aBE61yNQcZCP
         25rw==
X-Forwarded-Encrypted: i=1; AFNElJ8sg9ADE+udbe9np1euyb149ZjZeZDEjaBw0rQgTRwlh58LI9fRHAy1RXlMqcYfQ81PmYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeHEu2reJthzZrrmr+dXQjw9vAdWqPZWqxfv9IgCsNq/GbXnb
	PVPWqiDUVz7nu1dJQ5MwesjPfvIddi9vAWHgmrzQDv7YQbud4eHWMPXBD1dB1hX6AImR/prxuP/
	YW++uFg==
X-Received: from pldy13.prod.google.com ([2002:a17:902:cacd:b0:2b2:a70b:98ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b64:b0:2bf:305a:312a
 with SMTP id d9443c01a7336-2bf3680a163mr2618575ad.22.1780067272464; Fri, 29
 May 2026 08:07:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:41 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150741.714145-1-seanjc@google.com>
Subject: [PATCH v4 30/47] x86/xen/time: NOP-ify x86_platform's sched_clock
 save/restore hooks
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

NOP-ify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 36d66abf5379..640b71d22d97 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -578,6 +578,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = x86_init_noop;
+	x86_platform.restore_sched_clock_state = x86_init_noop;
 
 	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.54.0.823.g6e5bcc1fc9-goog


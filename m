Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B33E1203
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872849; cv=none; b=juqv3E3pOsLd7JapTiwuEsZzuokKwfMl/haDH57WmkTpSvvjScmNqmLKOylvTo+Fcs1NiSzvFlWJcfR6ohzIUOkCN4UWbjm8gU4TZJ+9eVMkOJWlsURuDTLDI0vQ6XLqeXSap5LrkRCo5z2Gb0q0M4XrD8H4NXpnUKyFUFsM86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872849; c=relaxed/simple;
	bh=bIvGpEwSZtu1dFGmRrUgP1xhupYQhI4tOk7weRcJRgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GeQBX5sLR9/avZU4jj8rwIRn+jv/RVfaJYRmvsHO+6IA+LxCewwuq+eoSzOHLMU47pYWMzJ0FxQCatyXph6/EEYrBpi8JtG6y/m4GF3TxJ/DCQ5Q8dF5lOOXnybmhUxSfDWmzuDLWeaH0j2XV1x4wfw2xc8Ydw/YST5GNEcJkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQMfOm8L; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQMfOm8L"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so276478b3a.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872847; x=1779477647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eVzC+1NNlxe1k/R0gBkxcy+TPbGnZzPB3ftmmd4+5ik=;
        b=tQMfOm8LUOPoHNGBjDvA0nt2CkSzXhx9m1zO+XHx3KeB/YBqu4clwgUwjB4OUsbpwq
         kF8Gt1gSAhVDlG1S6IBx+9b8QB04SqRZK1dskYZFXyGhZY6ZqN1F8RaiQgQ0KuSDqs20
         7F+Af8csGSwtxvL0UIEzMOMJjuc/i2nRkvtlE2wWzlwQixm0O/enJrXs3SXZ+fl7qkFm
         2oOgPrsQwICoFJna7OkaV4XRUX1DTwI8K6tAITICgYkjI+DJsEqqoPz8r9rQJloPWs1Y
         Rk6n8UsRT9J18hmvoCIOqcjxq0AbyApvkJ30CXGs/obIbUaqLso4VfH43tHBjEaQVNN6
         laCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872847; x=1779477647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVzC+1NNlxe1k/R0gBkxcy+TPbGnZzPB3ftmmd4+5ik=;
        b=GIwE8RHn9cSrKGS5p6vFyLmCXubMozhF68/HEoulaNY2hFdZGCCgXfsxNoPYcpuWui
         lvOrV2Fy0NsAP+owL7wrfIbBvL+RVHPQZQZUo2Ynw2LWS8hyWWekBzS8vEjAD+GVgWS7
         Uhe8FNFqn36XWBrIY3bppTo93DlkXOsxTYX5zFFNXkl6Xzy/kpPE6xg/kTAKc21epXeF
         AR1RTO05XovGO+WZVHRrhT1MfTJpNJ3LzxQiJUHO44mnvoY4pG6RU1KUrx67X2/8zXzi
         yGNFWpqCq7TzbW8U7gzX0QegVGcmLlGPcQ1Egr4udwvKx8w0jlv3mR2kiX6Xnmwo+5nF
         ryMg==
X-Forwarded-Encrypted: i=1; AFNElJ/ry4xYJgLtXZDZyR+SF2gdHP9RQj4oyjnNNu5KwJcjk20Pt33hkZPeHFnq5f0w8BgFRuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9uliPvUHPlwjgZFmwAja+wuztRqNWG9zRggbL+tppbPSCtFI
	0UsCHLedsq2PGFTZJAJxEEJa24FCpDyKsnN+2KxvM0Z0dkiLRs2nop+ZiXCtwUyYn/vmRj2bPAv
	F1MkNYQ==
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:83a:58c1:f5e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1404:b0:829:9a7b:db84
 with SMTP id d2e1a72fcca58-83f33f30bf8mr5787888b3a.49.1778872846903; Fri, 15
 May 2026 12:20:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:16 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-16-seanjc@google.com>
Subject: [PATCH v3 15/41] x86/xen/time: Nullify x86_platform's sched_clock
 save/restore hooks
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Nullify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 3d3165eef821..21d366d01985 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -568,6 +568,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = NULL;
+	x86_platform.restore_sched_clock_state = NULL;
 
 	tsc_register_calibration_routines(xen_tsc_khz, NULL);
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.54.0.563.g4f69b47b94-goog


Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BC37F8B5
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872862; cv=none; b=LPWIRRixbXAlrTHwQ2sHgowtQWi5/gb5ss8p/Y5zWkiOUGZqYksCpZHM2Wp0qHJgFMx0pb8DWICy8osHzODXT9br+dfqQsUH5BceasX4beaAXFl4yPBvMfQKhK1IKo3dLROK6/opOa5ehUv5FdnccP0jj052xctlzXsG10i92Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872862; c=relaxed/simple;
	bh=7HCympHBB5xq3NRYbNWj3V2HpCZUGQZPcE1kS6YLWe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PztSPG8oGmI3NShDresbT7N80wRX3DUdU8OxCMUrslAiQmNMAcpTDSqPdD8FSJCarQxbu00PsY40sCNpLt7J2HO/4xlxwEx1qCtYd4/r93d6cr9n13kqUQ/OiRV5tNXH3AD/HMTWRMnslliY7hfZfCnZ4eMabuFU64KKA2YVXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qX1oxBB7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX1oxBB7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827adbf00cso61002a12.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872861; x=1779477661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4XJIP9GZP+0qc5TpuA2ddXAK/ReZERF3J3EAtmTAWAE=;
        b=qX1oxBB7mTdyVxx4knGRlOP64lC2ZjUh50UyOJCfzEr8oPwVWF1AHV3ss92CsVXVDt
         wb/m2rJB53f0WiUQECWRtlvOmBZoTufts9JBgPhhvAZPxqC/IPCiJ02ezn8MVSIxKIxc
         RX0L+5rPKWugT4pPD3LW17aTcNcr0tQCrp9soX2vFTpmvrWpc8LRaow6wm9WlFB6osom
         ctUqvYVYtnZVK1tv9QGiMKrbWeExjg1SWyMg/1bLrqUFJ2TElkd70DqNLQRh2ArbeCWS
         gA/Mlr3SysKWtfyZKUuVTMbrpTLsyeZuJIwXTkrymCHRqTeUJHrftZdF0G5xTMsSyWdX
         kZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872861; x=1779477661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XJIP9GZP+0qc5TpuA2ddXAK/ReZERF3J3EAtmTAWAE=;
        b=UQFLr05BCNQjXkb4tQizr5JZZhXOKZTeOMF37QnqMBwSaK/cb7Q73/CyWMALWQwJ7x
         yGbUHcg9dCyDdWFmbe4Y4omK0flKBDaMvm5tfQKRzmvyBl/7NO0VoVWE7kj4ehOiRUh7
         npxwweo4fV1AS514EekCTeDeqEIaFbPFV54LgPS3Bl2cMCAKJdsB7Prarn5fMRJyo4lW
         W6yRnMOVP10b0TR+bbQZPITqve9a3Q8ZOY2ZpSWesnE0TRKKsUoO1d5tNpjOHyHiWMHU
         kLalExc8Ul7rm1oQGTFIbO/Puv0pj3Z4uhyhohuSfst6CG69jpVmvI6+I3ftW+ROOmTh
         BaoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VvpAD9tyjrFmY4mweHy0dlGENUUG9vT3MWaqSh+uWcAlKK8RreoV1jkp7bL8quvZWHgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYwurUvJhVVZLRN6B7CVYfm4ntXBkHG/0rvvWRRM7vfJsvooP
	gU1my12X9VwOREOJR05p6+CFLZ1wkS8x3kg9PRWudLI41N5B/nq08EfFUA3xJNkDYNC/pxithx3
	bF6lttA==
X-Received: from pfje16.prod.google.com ([2002:a05:6a00:d0:b0:82f:6eb4:9793])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a20e:b0:82c:e1aa:21e3
 with SMTP id d2e1a72fcca58-83f33bca81dmr5806035b3a.10.1778872860340; Fri, 15
 May 2026 12:21:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:25 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-25-seanjc@google.com>
Subject: [PATCH v3 24/41] timekeeping: Resume clocksources before reading
 persistent clock
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

When resuming timekeeping after suspend, restore clocksources prior to
reading the persistent clock.  Paravirt clocks, e.g. kvmclock, tie the
validity of a PV persistent clock to a clocksource, i.e. reading the PV
persistent clock will return garbage if the underlying PV clocksource
hasn't been enabled.  The flaw has gone unnoticed because kvmclock is a
mess and uses its own suspend/resume hooks instead of the clocksource
suspend/resume hooks, which happens to work by sheer dumb luck (the
kvmclock resume hook runs before timekeeping_resume()).

Note, there is no evidence that any clocksource supported by the kernel
depends on a persistent clock.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c493a4010305..26f3291a814d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2098,11 +2098,16 @@ void timekeeping_resume(void)
 	u64 cycle_now, nsec;
 	unsigned long flags;
 
-	read_persistent_clock64(&ts_new);
-
 	clockevents_resume();
 	clocksource_resume();
 
+	/*
+	 * Read persistent time after clocksources have been resumed.  Paravirt
+	 * clocks have a nasty habit of piggybacking a persistent clock on a
+	 * system clock, and may return garbage if the system clock is suspended.
+	 */
+	read_persistent_clock64(&ts_new);
+
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
 
 	/*
-- 
2.54.0.563.g4f69b47b94-goog


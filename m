Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44793E3175
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872856; cv=none; b=Dx03VG0FX3Xn3L+S0ctk53uS/v+efE9v9HoQ2/YyDUkFPsksEuKGZGAXxtHrHM6c7+eXk99tVxOrzZTyo2DrAKr9F80t0U9lGecGa+TAc2Rlmulvsnxj+uijSx/q9Hf82rXn8lDomQnhME+etbzKtHkRiozd0MstTuaS96Bpg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872856; c=relaxed/simple;
	bh=xUpUGQiJgAA1ZwmKSf8xfquX01gunhdqbyqPreoYY78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sedIQ1byR4tVFGdC0hm4ydka6Oq3Wyh4vXgsDTvrR8mXBPmx/LYfPZxdk//AErD33rURst/6TMa8fyKOoZaof2+khSneqS80p2hWL4sTdHwkBhSo/CHmtRvjJEZwIcSkC5iJmM3dJT79BfNK1CGKshsLNrUeZuo0hE0cDrlnkaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWE5+zrE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWE5+zrE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b461b36990so1563915ad.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872853; x=1779477653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KhBZEy0/QKSWfL+Tze5jxYQtO7z6AVGLrSR5LBAuSZ4=;
        b=lWE5+zrE+getZ+4F8eR1KgiFAruihoO9kkdcxqOq0hvIFT9fFUuKKaL1WY06PArdfl
         6Vo4M5Wn9Kqay9z3iUP30BndhCOn8KUdMFD4S+sdaeUS1LoCNV4HHM17gpSC3Qbbd8OO
         OU0WFhXIH2pq7N1DB7Q1qIVfJRuD/sZN/Y3vvDJP/HL0creCyeQRoVhsCnkadDmhPmJX
         3VOZ+MDq/2Zf/V1v6b99x6otVvqV3GhJEO6yjHPK/FtbHeH8TT50IqOZ28R1Vc14H6x4
         bQfIfqDaLiWuH5p1dBRTTh9UA7pCt+e2JmC7TnRwUfaoTbhOsX4DvQkPdS3mw+JsJeQj
         5KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872853; x=1779477653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhBZEy0/QKSWfL+Tze5jxYQtO7z6AVGLrSR5LBAuSZ4=;
        b=SoToAv7p0sDUtIE3uDsYx9N6foMBQ+C0rL9nqQwy8boCwTgZgz6JJFl9I/sfD0Gd4v
         +EaWf/2xqBKU6GW8Y6SZoBTq3ZJMxhefDseALFZjc1D+rl3yFdY8ThdDu3Mn6cUfHuU3
         yAjvMrO5JPbSQpHd235aSl+94VoEXzZAdR4JMTTz9UWT9RWhdPcphX0F7l5uHYThy9sO
         ONRiKm1L3jE0u8F5OHG2IVzcu1GxOM1464T+lBg0iG+20bavz5aeGF9vZXi02xixSRun
         Z0T84xJaDQWlQurMgk17f0Mbj7e5RQcA7GFga7qRUqtWgaqLFFKEy/tyxJkRBfCNfDpw
         Wpkw==
X-Forwarded-Encrypted: i=1; AFNElJ/uuwlgUgp+ah1TiB+2Rmuw+3D6o000kJVQGYClT76FqYz3NI9k80tXq2ZXsTZE92lxD+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbhu5HPnfo2r/z7wKJmbqSCM6AZvmWr9Px2fBTh1mWhuUabd+T
	XcGngtUMIJgqOauBIYUnw/QVxSqHal+BJrg0ki/udtECTHh1D4Li4mj1XgeSj7/HcNL+XsoJmWb
	cNEMS0w==
X-Received: from plbmo16.prod.google.com ([2002:a17:903:a90:b0:2ab:194e:4d54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c28:b0:2ba:bfb5:9cc
 with SMTP id d9443c01a7336-2bd7e8d3b9fmr61656605ad.26.1778872852484; Fri, 15
 May 2026 12:20:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:21 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-21-seanjc@google.com>
Subject: [PATCH v3 20/41] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index ee7095febfd1..f087bb76457d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -444,7 +444,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.54.0.563.g4f69b47b94-goog


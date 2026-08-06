Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF54EA367
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059406; cv=none; b=hRcnZWz7hupgPBQ0g50l5+d5YwIDjLa5T292y1InrgnWQgmM4gMXU547DWLeoO7YlFKvNMfJz+izX0CMiY+V4gNG9g1tc9fNLeFh2CS36nzpF5Mv/dGXe6PxK1ixhtVB8rVGtYFFxNaa34dzs6bMgGipoCoXNzy75DhsECOQdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059406; c=relaxed/simple;
	bh=JVq3rGO4pg6RPeAnx1wMiHtknekbd2VNIRn3YGfu0ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxVXnDDgBIIfGl/TsHgzmz4T44dC2+CCXyrIhGiHP/1pT5kz2V2qzKgwI+XHWzKyftgYK6gDnJUO+jOl1h8bIPkgnSWcQJyMZ1Bt8gwac+dQvfdBOeG7c9U92i6jzPRciOEeex0bQ4wkUCHwrw+87o2KCwKKSYJ+xRHlbpDqgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlO+072r; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlO+072r"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so4350217a91.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059404; x=1786664204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VAfqOqpweyKvsFpq/agEYC9CEWnfcmlui4k8L8ZR5pE=;
        b=BlO+072rpsy9DCM83gKW5v7E1PZyyJ67zTdD/BlALmywcI2sQZNZHXQBXAKw4ZqNI9
         orlED5c7TiX1o7l5Zut9YzGld5blVDOpn4O9mYoe7uazWZ3HR54VXdik5t5XvyUMmZvS
         +TsFLGAHZJX4cHUParMffVovk8u+L9n5xjp7cu9DW6uVpOrFhdKFyUu23sRcU4P85abh
         lcJFYNcoagmvLj0NScnYB1g/UzRNDUojXfe6Q+bVTVdYnVBsi6rAnIxhswNTgjBQnyxt
         CzOjlFI/YqrwrR/TmfQQX/JACg7XjCCJIyF+KkCFJZ8NUpmy+enpfNSOQp0OU/SPRfR3
         UupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059404; x=1786664204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VAfqOqpweyKvsFpq/agEYC9CEWnfcmlui4k8L8ZR5pE=;
        b=NveD1HrDyXCo6I6WunC0dvnm+5Guevo16s0N3Be/HVvw45JUcbbhB6hbU5WqkHISWn
         Eo3E5f1k9sgXRfWqd+pRmnLdPV9LPtSIMfreKqhLcOe+mt9NT4m3hNmQ9XKglZL5v6mD
         a5J9Yj3ODsmChpqRXlgHOh+mWbEkuEDqCY7nigvUwzKSyOF2RWWYl8bLc1CwchO0zbZb
         vTOGrcqD6/1autAlpD9V/G5EKelbvzoX+vHB4m/MkVqwliaYx1iu5oPEsRd0yY3IlaiJ
         hxU/fz/TkLCyGIQ4qejSq8hbrCsRHGkEnG6fjDJ4FV+UgoeQ8S8Z/TQIexMM00t4S4z5
         0Asw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6zaFHIR1LSt0T/+WdKuyi2dcn2LtVO3WSj6XMWmKIoQ04OeJ+o4L7CCZo+okjLsfS29w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3vApV3XeUYofFbhHoSojkEf/cjuyyh6yg+wh1gkSAfMonzVz
	Ce8iPgl4DLpbX5e/89IU0d+JpszTKThCMoy+snq8r9cqzW23kT71sx9QaNss+0QAxb90rMzqw6i
	9hxP1Aw==
X-Received: from pjbcu4.prod.google.com ([2002:a17:90a:fa84:b0:381:7fb0:5a60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288b:b0:38e:8300:af51
 with SMTP id 98e67ed59e1d1-3903c54d040mr19813478a91.8.1786059403683; Thu, 06
 Aug 2026 16:36:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:33 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-17-seanjc@google.com>
Subject: [PATCH v6 16/51] x86/tsc: Rename pit_hpet_ptimer_calibrate_cpu() => native_calibrate_cpu_late()
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Rename the late CPU calibration routine so that its relationship to the
early routine is more obvious and intuitive.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1d41ef1db27c..dd9e04e325d6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -752,7 +752,7 @@ static unsigned long cpu_khz_from_cpuid(void)
  * calibrate cpu using pit, hpet, and ptimer methods. They are available
  * later in boot after acpi is initialized.
  */
-static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
+static unsigned long native_calibrate_cpu_late(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
@@ -927,7 +927,7 @@ static unsigned long native_calibrate_cpu(void)
 	unsigned long tsc_freq = native_calibrate_cpu_early();
 
 	if (!tsc_freq)
-		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+		tsc_freq = native_calibrate_cpu_late();
 
 	return tsc_freq;
 }
@@ -1472,7 +1472,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 		else
 			tsc_khz = native_calibrate_tsc();
 	} else {
-		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
+		cpu_khz = native_calibrate_cpu_late();
 	}
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog


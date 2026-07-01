Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D74C9573
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934354; cv=none; b=XJl+mHIVluLQwWD8/9QzaFx3Zd78J637kKhEXvsorbxaWEEiL+4KcFf/qTiDGwGIfAPxQXzajpy9k35M00E7OLg7MDfWI2Us4pBkHVLqJzf2DO9UcAa/HQ6us9Ka0IM+fsC1vxVuYzBYpZSmEtp6Qc86ncRwqbytzB3LUluCpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934354; c=relaxed/simple;
	bh=m7RzfJ+dglccDpbLj8Vzsd5+h0OdO8Af8uWyaDtsUyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UpyBqNBH3neFWv3A5I29njqj1WqPRfRNDNc5yXF6vPbMI2JL589gAOWynddHhhiz1T6rwo6H2Zdi865VrzL/nHRCsgK/G6oAzVOjwr77/nushp20KyroPBo5YnCaIWPnTojbqQiVibkyTqtMM2PgY+nPfMAvLdvgopA5M7jpb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlWPsOz5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlWPsOz5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478d2bea7cso1833102b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934352; x=1783539152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=s/QSbcUaf8Mr1OX5FYkbnza8ilhhfuHPZoXwnM4X05U=;
        b=jlWPsOz55Wm+xZIEcmfOM3gE+Eg7Py0kz1c7l35lC0aS2sWXxWHzsPEH01Qu0L4kg2
         sv16BZsxj1L1/q0CXgsQ/r42w9bVOygfqVnemNXYUcthFOOwHaPef4xxltB6CKvOvk2Y
         ncBvaI1Ubicjl/A1XIVmyB07uibZ0g+HU99SJZmGLQjgv6vM7JHAul4bWaz3Y2zHK9rT
         aSDLJCplhj4ty177sF+QvTsjC/FDNJfiqOQmM5mN7FVGsiAohogLMoGLNCtgdxP93/dm
         hk9M08eCaEHOvj3lf5LhXDt1RivVKP70K2LKrTkU1igc+uXIUM7z1z3flGmUjqtUZ59a
         w8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934352; x=1783539152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/QSbcUaf8Mr1OX5FYkbnza8ilhhfuHPZoXwnM4X05U=;
        b=ex1uAtPJ8DXebIe3gZ/pC+dnhg5MjUdT+ICZK/ec9ngUvyTN1Y72bENJfxA79/eM79
         IWozGgnlJ5cGrPozN98Dz72pPqVCtH8luOivZ8jf3/uoyVPRG+7ds/rE5b+BWsZThCgI
         j2KDQUNMFowcBi2IgFYHJneJzIf6kvM0atWPCaEUYYlpZLDi2kpNfkKkn6IluM5VnGmy
         kYSpb7T6U7rgB6g0tZtNTsY4HBY+f4dOEVG5+nPDgf8vtPnqQuogGxE69QaE5C7G9Z1w
         KKQ8e/b0K6pzL3SRhpB0dhP6994MWzgqkBwSn5FzgC+7r5h60JvjqN5y9AfqtjYOL+Xy
         NK5g==
X-Forwarded-Encrypted: i=1; AHgh+RrTKT8vNXeqdnl0tFtN90yNJTb6kr3JnVmhuCNhHIjxH2sxbLZ+ufrNXduwE9eboXILAl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcd2kt1Z60nX/lBDrbQxia8SrbJYoNWBs5esZJDibriCDAhYal
	KM0iY28I7o2ao3lZdgzr5ABeA1jfJhFNP6hqXV+AK9hvVRjdTgu68iKRSh1CDuUrQSSqv5XdWbj
	glhAz2A==
X-Received: from pfbhc3.prod.google.com ([2002:a05:6a00:6503:b0:846:aff8:5614])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e10:b0:842:499d:450e
 with SMTP id d2e1a72fcca58-847a82d978dmr5886277b3a.20.1782934351240; Wed, 01
 Jul 2026 12:32:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:25 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-5-seanjc@google.com>
Subject: [PATCH v5 04/51] x86/tsc: Restrict recalibrate_cpu_khz() export to
 p4-clockmod and powernow-k7
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

Export recalibrate_cpu_khz() only for its two users, p4-clockmod.ko and
powernow-k7.ko, to help document that recalibration is relevant only to
ancient CPUs.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4393902c0ddd..482cc3a8999a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -943,7 +943,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
 
 static unsigned long long cyc2ns_suspend;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D04AAC85
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059436; cv=none; b=XOGucYimSriSCTHEaeQ0L7bGwjkB6Gz/JN9qtJ9fhGyTjEmUJ2wj/UwZebzsd7gDR/ViHDKqXWRC4Ire4C/vsLXHHEDtwgGn/OMpKp54XGP+LUon+HyAs9UlpGXqmEECyPEp34a3YRM+8EGBor016YigBPcc6RwYTwptp4sHuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059436; c=relaxed/simple;
	bh=QnNlfXQgGwJN0/JkuWp/4XAMGB0Vt5ulI8HR+vmeXt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCqO8EdGu76LFMufr4/8DnTgC+Y6gfXcAEMR0FwKS2HCHVUln8d5fvR3DeeuWkPTtAC7mLTLXWwGfct9NxcJSiP2ERg4vJYlN3gb5i+pZKgEx67A5ZZFoibygiWQKaWbnw9uBConHU8UmJwOMfKCC1RDXj1dp/3aWy6igQ5r9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tpv7ciKH; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tpv7ciKH"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e667368f0so4358729a91.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059433; x=1786664233; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rt852L9wHdv0bDRlKJAMITX85TrVIH1oxytQu/w6xUg=;
        b=Tpv7ciKHeHDugIIwHzhfcocSLtVkDCTQdSye52PdWt5ziikon6hhKy9cAJ/E9mtCWr
         s5ALopwClQobqOcIoVSkGgEhx9ciY5ZQ2a24pfp7InkcROrW5UiWmwvjOUiCAxTvaHTr
         zHzS0OvcsRVS56x2h3uMIurqQ0nZ9/rF713VpZkL8MNz9GjbiNwa1arQAK6RXjfIWFPS
         WDW2ciJRaeTx1286dm0dTiI/27q20wvpxMPJvq5tIm0icRPd4Ku/YyiWzRka+4r3obyA
         E/6wGFEbBWNJTNtgaq1qJOGaFnko1zOgdcdctgsE/9LSkBLg/+JXV4zSkil8hE7vF2Qp
         ar6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059433; x=1786664233;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rt852L9wHdv0bDRlKJAMITX85TrVIH1oxytQu/w6xUg=;
        b=sgWplssjBpaj2R/ycjtwgJFGwilponpBH5eW4hFLYU91m7YbOk47ooP+iY4FGMP0nk
         Xx3+lE0KEXrruohMjXeJWGH1f7zOhROc3wgJLk64XJ7eWI4ujeNbjfwshkxgmV5BKQgX
         fp5KWXtq0xy4XYOwXFcTehmMnh6Ujrp7o+LXXRXuFaEUM+n0p4Mq77FCUWraZn8DWbW0
         iFaR4l8mEIXQiaBARCHDKSH1LMhZmCaiHJhGgM2BRnSJB7jRgRvqTM31IRH7FD9878me
         xzIwYnhjIdP6/QP2vYrqrPfd2moQtlXqN3DMoEidh6xBUSmAXa7eL4gOdg2QguNC4h8X
         hIPg==
X-Forwarded-Encrypted: i=1; AHgh+Roy16nhXkIPuziTbZ5n5sJhLks9wuBBidv9RF3si+tB4MQgWMI8HfoBTYalK3jXYEpdS7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87ppxlg1GHckfrh2iaQVD0NH3GQXSe+956Phd49jWBXHSrnqu
	z3EHUK153j4K3az3y9R6LnrE52oTAfteMNLpUXoPgVf4DhPwgsnokFdI1qThBNfH/LLUote7Q0S
	XiUVnhQ==
X-Received: from pgkd23.prod.google.com ([2002:a63:f257:0:b0:cbe:7907:901])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52c:b0:3c3:812a:2198
 with SMTP id adf61e73a8af0-3cb85df190amr24070365637.4.1786059433092; Thu, 06
 Aug 2026 16:37:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:56 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-40-seanjc@google.com>
Subject: [PATCH v6 39/51] x86/pvclock: Mark setup helpers and related various
 as __init/__ro_after_init
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

Now that Xen PV clock and kvmclock explicitly do setup only during init,
tag the common PV clock flags/vsyscall variables and their mutators with
__init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index b3f81379c2fc..a51adce67f92 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -16,10 +16,10 @@
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 
-static u8 valid_flags __read_mostly = 0;
-static struct pvclock_vsyscall_time_info *pvti_cpu0_va __read_mostly;
+static u8 valid_flags __ro_after_init = 0;
+static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
-void pvclock_set_flags(u8 flags)
+void __init pvclock_set_flags(u8 flags)
 {
 	valid_flags = flags;
 }
@@ -153,7 +153,7 @@ void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
 }
 
-void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
+void __init pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
 {
 	WARN_ON(vclock_was_used(VDSO_CLOCKMODE_PVCLOCK));
 	pvti_cpu0_va = pvti;
-- 
2.55.0.679.g6767b8d81c-goog


Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB10420E86
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934391; cv=none; b=YjblY9jIcN8X8Yf9N9bMrdRW8p19q7aHDveDVGR7wE8C44h9KWpDGH9+qQHkDt5wkN0usnGceqeqx5/nYLRR7tqq9yueCnGz0/6Ya42dc5xDjPZU2acxxthe/5XMNrbohTwS4TrW0z+Piqehyi0Er9ajg/ByXfPfc80T3cawopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934391; c=relaxed/simple;
	bh=FUN+trAftQTY8ZpFI1i4Es/NPmL9miMwKLy7njqUDaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s2eGbvxodaIctthPWQPdL1b3TggZN5eOkW23oy6Fmk25pf6KSlrwd9W7A/RSDtiCH+t3AlCU/n7ee75jZfpaxfMmBCIud9ELLqdMLdn6Q05XTeCb5FkY8KSjKrgMId46JQngYIPOFGG+HbcaZpoLHgLm0X1g9u8vMgVxir/i/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzbIpABP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzbIpABP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7cfa17fe6so22393695ad.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934389; x=1783539189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvd9sO5KFA4UCvVy/DPb0p6l2OFovCFuh6GrZNkoHew=;
        b=XzbIpABPzw891bJ2j3KkuzX2l3LjFAQaXXwR4xqL22Z56A8jjOV2yE0WC9Yq3hbJ6t
         mBLuHsU1JcRrXsX9A26ekw1xXHi8kqSBwIhWS2Gmjo7CPQx+KZSFj30oNvfdCgsXeIux
         hbovSJbfXEjvjTJuSe8/fzS5+Ht0yEn5MjrGNtAQCweBe/6IN3fjmhmdTohZrkDWTQKW
         PVEADBSLuVZ9sObXGxT3nAH4FZETN0h1gvWaQJDMPAwcTUNzCsPpitm53Gj5zfZpHzzt
         KtcS+DwLFjkIiXkGVyi9/eIT/dQLjn3L+E4GnHqSNnUoot9kZgEJNjOx38Psd+Qk0JC6
         q99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934389; x=1783539189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vvd9sO5KFA4UCvVy/DPb0p6l2OFovCFuh6GrZNkoHew=;
        b=L+/T+HvMtiKgJq0IfSQyA04wiipudkOGFHlRjhhvmibGsWgfJnTILMHonM8HV0RBGZ
         eKm7FcUji2viaiAURWr0q0shghGYAPUGjxpXNtPG59oSyUKjcwGxa6J0YsZh/SJ8vudK
         NhlImRbXxkKgcnIdb5I0l8CcxIO5mCx58BJt8ZdP4fAasvyppHRAsCbphO2MUX3GRbBW
         DpMVsxzKp36k0a60rdqw2y6/A0fLXD4djOvRelG/T9SnBtr6DvEGkxow84Q6hXbWSgfj
         l+5YsuMGNm1xRCFSsOKJ5aLbDJEexeonhnDqZ/UbBqyuSgDFCMiN5z2/4pU9PW2NkDdn
         6LBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7yfzSvPTj3oW3OcNlpnhlscKvpnx6lYf4qYG7d44CI/omEtlwoM13Wv1bzC5h7VEmpiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDfK//Ak/HC38SHo8Igx9iGKIKniU0rzIGjviaBEPTdxy/+fx
	/ruWKFwEpCb6A6P++scNpRjssaCKRvJDX0P2htiAtFpNwIuw/4SXpGOQ7qmvthQr4EhiDU9LElf
	cQaQRNw==
X-Received: from plho13.prod.google.com ([2002:a17:903:23cd:b0:2bf:1274:c8f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c7:b0:2c9:c46b:129b
 with SMTP id d9443c01a7336-2ca7e67c028mr32017335ad.5.1782934388785; Wed, 01
 Jul 2026 12:33:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:55 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-35-seanjc@google.com>
Subject: [PATCH v5 34/51] x86/vmware: NOP-ify save/restore hooks when using
 VMware's sched_clock
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

NOP-ify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0a3bd90576d4..5c1ccaf4a25e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = x86_init_noop;
+		x86_platform.restore_sched_clock_state = x86_init_noop;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


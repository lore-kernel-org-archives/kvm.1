Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368493E1CFB
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779994; cv=none; b=m/31xMY3E12Gq4jzbDOySDtF9Z6EqCIKuJrRQUO1xjSWNzV0nNz6G39iiyz3qWVtLcGSSK70t7pAQBKrx3DwtZAa1AaT6XFEh/06wILpTqp/UDAZwBM2ViAqXzaBfv7Duepmx+i/W1FPLtqM5m+Zec+ybX7IV+s+rpeGjHsNq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779994; c=relaxed/simple;
	bh=vYwafw0yTTkax4N9kK7BxvmBePgKDiUUWhKS9VN1Mjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jsNnIaCuTvNcEQg3J3ThDOiiRTCzm5B64aGTuGx37/rBvqo0809XNUBPp5A3MxrMP51FW8Mumxr5/6P981hv1vHfzSnYGit0ve8Of6fg9wppuFfG0INNx7xQ6iHLCdZ+ufo/GEFrVSunn+I9Pe4TJWQuFkX/R14+MAkGcF5u5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6/eiln5; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6/eiln5"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1759436a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779992; x=1788384792; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jQ9Xgia0qMFepkVGEti7/hov5lUDRQwCKPl494Tqn8c=;
        b=Z6/eiln5912hQA4BryXacoNrI4CFrgJC+Ck02N4orRVqe7a7MtpaaCcrKHEtUxAT0p
         MMNGc7nBNUk4EyzKjG/X88F6ZXVksTZoLiWeRCdGjGHreDEFfN0kwQ8UBZgjj6XbvULj
         re50nFdc7Cu3qaMH2YvHAAXow1gxeqsN2J/yrrB9e2o20UMKTFLOq4Z8IMrU03UHefpz
         UVsUbYu9U4PiVHBuv/iiIyzz5RMcskR8VvhNItTtvLMNyFV6sNmTRaSr8aCexiyPW4M0
         tEfd5be9y/3tsid10Ka6c300uU/SchVpWyBZlDKqj3tfLSysSb9J6Ull+gtyAwvXWkv6
         x3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779992; x=1788384792;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQ9Xgia0qMFepkVGEti7/hov5lUDRQwCKPl494Tqn8c=;
        b=YBsbeZNyO4L2yBOPp6TXgxsDRfZQZEStJYog6SGndd7fo+J8jsWZ0/FFBel6SYCL56
         xQy7vdE8udFQxfIfA+05O1ndhsyXP9HU9myA4ejv9pSL1LguWmP+D6nlJnE086DgGM2P
         W74XQ427OlHJ133qwXgDmKSYiEDM/PrAwSLxb5bclzaYA/P5Td+IARxpwXYOZ3xCF2vb
         IKEinbtEWaLbSIqXrqOes2tyguZF4raOY0u0Ptdep2WOm8sFGzYXTel9IX1B+dtft/VB
         vE/ZRX3qUOVquAiIumsz42nM1cmbGNAcSrkpt91E06DP6HhhADuCmEc3vWHCfjlNkQrL
         ohRw==
X-Gm-Message-State: AFuF++mVzPqJ4IBmNokFr0hA4oOoxzLWNlxU78HfB6i3CTTWa+ibd17p
	DvL8Q3GHPoHEYlaDaAEGpTeopNyT5RufUfqlgbMq1eQDhUv/Lm+lOaG4DmKtMIGDM/0rQuHv/lo
	uEFAVKA==
X-Received: from pgcn25.prod.google.com ([2002:a63:7219:0:b0:cbe:b8ad:f9bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2989:b0:3d0:f57d:c87a
 with SMTP id adf61e73a8af0-3d0f57dcc1emr4505658637.0.1787779991384; Wed, 26
 Aug 2026 14:33:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:46 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-7-seanjc@google.com>
Subject: [PATCH v10 06/21] KVM: x86: Avoid NTP frequency skew for KVM clock on
 32-bit host
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

Now that 64-bit KVM doesn't consume pvclock_gtod_data when getting the
kvmclock base, use the ktime_mono_to_any() version on 32-bit hosts so
that they too are unaffected by NPT sync.

Note, even if KVM still used pvclock_gtod_data for getting kvmclock base,
it would still be very doable and reasonable to avoid skew on 32-bit hosts,
it's just much simpler now that KVM uses ktime_mono_to_any().

Specifically, commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
monotonic raw clock") did so only for 64-bit hosts, by capturing the boot
offset from within the existing clocksource notifier update_pvclock_gtod().

That notifier was added in commit 16e8d74d2da9 ("KVM: x86: notifier for
clocksource changes") but only on x86_64, because its original purpose
was just to disable the "master clock" mode which is only supported on
x86_64.

Now that the notifier is used for more than disabling master clock mode,
enabling it would be trivial for 32-bit builds as well, but as above,
that's a moot point since get_kvmclock_base_ns() no longer relies on the
notifier.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
[sean: rebase on top of ktime_mono_to_any() usage]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 46c2c2ea64fe..ed7986669bdb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -926,19 +926,13 @@ static void update_pvclock_gtod(struct timekeeper *tk)
 
 	write_seqcount_end(&vdata->seq);
 }
+#endif
 
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
 	return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
 }
-#else
-static s64 get_kvmclock_base_ns(void)
-{
-	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
-	return ktime_get_boottime_ns();
-}
-#endif
 
 static uint32_t div_frac(uint32_t dividend, uint32_t divisor)
 {
-- 
2.55.0.887.g758fc8c411-goog


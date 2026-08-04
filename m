Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404F442B14
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886776; cv=none; b=gYaASL+J9QJL2Tm58iPF6gG1U6724bHY6xlFUEViqiljYD7DCHLgC2FKIQ7Oh2v9risl2QijiCeUUy9KPmup1PgTDDa00bfMAtlW+mC3yUVQ3QqQv0LVFR6Z5zVnkY/bKX8McJMSQY4eMR4cL5cwzrIXx+2ybtrIJ6mbPv4jrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886776; c=relaxed/simple;
	bh=KehEpJaIvmjEDR8tAws9CYU8Ggr/kbnv/XQ+wxDFWrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJFzyqx3C0DwgXiCGEaujfgdDBgwe8pu78Vl8ceKih/J5VgH/H5UY85AFm4MBrgEzInsTUEzadUg/rxAUz5LKtnvO6UESV5Nh4hyckQkKkc6Ud2isj4+SwucN7BJR5Df9PYhSYjXEnGKFnNOKXoAwiveDhbxv/B3kYgC2eS5Gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2TFwAJJ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2TFwAJJ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so6199075ad.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886774; x=1786491574; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SIdV9g/PsGWm2rzYrQ2UqZD2cXobDRmK0jleLEJwTrk=;
        b=R2TFwAJJRf4/O9R7t9O8AhP09DPxrcf1sl0ma5AqlAPNOQ0Sah56v7e65V2Gn/YCvO
         j/W70Tm/9g7ifNKCwvzn+/0OeOfog+dMqcf4Jjp+ljbj23kdGkYuQb77eHwzwMXlmC+e
         jJbJR+CX/raZLzXb3fJdBzI0wfgn2UU6wpy+jl+bL7Mp8F5unitsfyQYcoR0GqpC4D4Q
         1z7V/5qAkYrXfIJihE3oBnGQxIg/uK4x3URRPM9pryMWGPyWrRKeBwhi6xccUkGOSpQa
         rZwTpegIQ+fy/vTxDl4ZQbqJXvA21ncvxM7UTagZxtTsFRjtyLvcQL8AOOfMH3AizSlP
         jEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886774; x=1786491574;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIdV9g/PsGWm2rzYrQ2UqZD2cXobDRmK0jleLEJwTrk=;
        b=Cst8LAgp79s9X9Vg9ELzZudLjAabRuBWVscb3j2o31g+L38vqbgnnddS13q7iUBH89
         i9mK3V6EyyyoF6KYiGsYFN4MxM7y6VDG3i6P8PzGP1xuzvT+KVCs4IfnR9qRwQxNpUZS
         yvd2A+anc5uTvBmP7lnOU7iOwft4KliZnOn/Q6k/L5uL4ahUeTFJf1DylJqeymV5l+ix
         FvdtlEDwbDfOh6v2Mb/GfJane7qgiDA3LCq4Xk9A3nCo59ZOXSB+12mdaeU44gDHj1mc
         emEcLBnZUp5H6iyKl5F4ffZmKSH64/FC8eyvxim9o4/2Tv7/hfqmMpwmYnx1imAHrUIA
         h6sw==
X-Gm-Message-State: AOJu0Yz7Y5KMjAY/H4SYPyemIXmYkNT82DmzQgzeIfRKNOhHG2UzG5Fo
	gh4H7RGrrbLwKlIkJEpDQSjy8GwZk6mXc2N9jRWlDj61S7D7hp5ouuH+1pCa2iC1ZPM1ORsQIuf
	juQylTg==
X-Received: from pllq15.prod.google.com ([2002:a17:902:788f:b0:2ca:d209:8089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da87:b0:2cc:a977:4260
 with SMTP id d9443c01a7336-2d0ca9fe0d7mr23375665ad.21.1785886774079; Tue, 04
 Aug 2026 16:39:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:11 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-8-seanjc@google.com>
Subject: [PATCH v8 07/17] KVM: x86: Move "no master clock" fallback from
 __get_kvmclock() to get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Move the fallback logic for getting the current kvmclock when not in master
clock mode out of __get_kvmclock() and into its sole caller, get_kvmclock().
This will allow use early-return logic in the master clock code, without
having to resort to a do-while() loop and/or gotos.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c0bf4c14bc5..8666bd0337b8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1651,12 +1651,16 @@ static unsigned long get_cpu_tsc_khz(void)
 }
 
 /* Called within read_seqcount_begin/retry for kvm->pvclock_sc.  */
-static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
+static bool __get_kvmclock_master_clock(struct kvm *kvm,
+					struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock;
 	u64 tsc_hz;
 
+	if (!ka->use_master_clock)
+		return false;
+
 	/*
 	 * Snapshot and validate the TSC frequency as kvmclock_cpu_down_prep()
 	 * zeros the per-CPU value when a CPU is going offline.
@@ -1665,8 +1669,10 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 	tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
 	put_cpu();
 
-	data->flags = 0;
-	if (ka->use_master_clock && tsc_hz) {
+	if (!tsc_hz)
+		return false;
+
+	{
 #ifdef CONFIG_X86_64
 		struct timespec64 ts;
 
@@ -1684,8 +1690,6 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 				   &hv_clock.tsc_shift,
 				   &hv_clock.tsc_to_system_mul);
 		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
-	} else {
-		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	}
 }
 
@@ -1695,8 +1699,11 @@ static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 	unsigned seq;
 
 	do {
+		data->flags = 0;
+
 		seq = read_seqcount_begin(&ka->pvclock_sc);
-		__get_kvmclock(kvm, data);
+		if (!__get_kvmclock_master_clock(kvm, data))
+			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
 }
 
-- 
2.55.0.571.g244d577d93-goog


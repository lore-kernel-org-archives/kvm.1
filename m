Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABC4908CB
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780008; cv=none; b=mL4+Kobq6+xbFfpa5zBCIB5l+ltkkl3V4zDIHBIV/ulyAT74UzLA0FFUYz5MhSxZucAajN2G88j1PTdqW6GGGHAGYM0HTFLnGkECOFD9SD8DYiUjOBsxymtL4fhmEuwA8pzLh22IMqueHdcm7X9a+0O0pBivanVLFV1w9HsyTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780008; c=relaxed/simple;
	bh=JVai9/GonBe+qa9+c+N+2jVZBOVuhzhQjhyIBgD0mFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5FHoxwvIGsylAe1J8M3xVo35Ib2Ih7UvHz9udZEbHZ4RttA1/c+eVXCQYkGRCPJIGbkjja8LoRvD2db0aKLy0rGx3WtNmZl7Lri48ZZjO6P+s/mZ6B5qq13IHWStyB9MDnH0UwadH+rD/+kUkQIgYt0PVOcPuYmvldNaVel6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHOmj/uY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHOmj/uY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so22284125ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787780002; x=1788384802; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ezFSwGzdymoOq5J7PeW75j7ShifMhMEkSL+xAA8ccGM=;
        b=eHOmj/uYemQyLDnhzeAO0VxtF8iFKBrrj9CoWbFh6PAggzFSRFLhuS7yTHZd/TfguT
         yoULpa6G4KulsLHlo7PTA7HSVyCus8BDE+ciAZ5DFWXtWQRikLXSFhBBx3Yk5P5SMIiX
         Q0Hpj9CAQSAbf1hvvF87jG4I2IRsrL6COg4TAbVZedfVcM8sypDBE63FqgEZOh1Lu5MN
         NT4DbP2U06WUZpvtS+mkP19KxlPAmJoTOgEWnTKkp4gUvCO7ebhh32osbeh5O9KvidEY
         U/1AGpWEq+ZvROA5f5Tmy2RDVX7fvqndMHN4gkv+z7Lfw0r0McNCkEj+tvBp9T7zoBSF
         d+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780002; x=1788384802;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezFSwGzdymoOq5J7PeW75j7ShifMhMEkSL+xAA8ccGM=;
        b=jFy21gUzBRQXYgij86QwLEJpQz/rNiQ2rsi6/YCQkYKhVs01nR4CY109BUfz1PGfim
         LO6lpFwWu0xWGgik/vtCdwxjxvlqLg5jwDNSVX9zUgQDdatM9uCs1XTWB++EV+4hOqG1
         tRvANFXLpuLtZs3rFAQR+s785sxp4Ne9GLq4Gyp+Ildb6n1DTG7r6Q2gh0GOMz/NPqcg
         VjzHqCdA6/ZayFDa0VbfUijNGPBfOEVGUDSCFU7xfMZSFBdKhrHT/xbNAe7AIcdv9Qgc
         AlAvTTIiO3Db0MpfaYHc+b6OpLHXsu29MwQ+xXLWqcLId12ZV9XplnHuKrNf3Rvi0hM/
         c2mA==
X-Gm-Message-State: AFuF++l9ReWv1cCrS76yZjnmoANbo/eIZ/y27NTfYHM1CAtZ43pdTspT
	pzDR5bH+4JTDJbsqwGTI0iAieI9rpIg2PPT8vw/mkUr5sfkpL92P/SjUbgW2DZiYvM0I8ecVXMM
	+LRh/lQ==
X-Received: from plcx11.prod.google.com ([2002:a17:903:cb:b0:2d6:e968:e012])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2341:b0:2c7:ebfb:618f
 with SMTP id d9443c01a7336-2d707c1020emr164924215ad.14.1787780001912; Wed, 26
 Aug 2026 14:33:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:55 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-16-seanjc@google.com>
Subject: [PATCH v10 15/21] KVM: x86: Make master clock logic in guest PV clock
 updates 64-bit only
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Wrap kvm_guest_time_update()'s entire use_master_clock block in #ifdef
CONFIG_X86_64 and provide a hardcoded-to-false variable for the 32-bit
path, as use_master_clock is never true on 32-bit (host_tsc_clocksource is
only set under CONFIG_X86_64)

Keep the local "ka" variable outside of the 64-bit-only code as it's also
used for Xen code, but tag it as potentially unused since it's not used on
32-bit kernels without Xen emulation.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 31fa3c941b49..1614718a7d0b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1798,22 +1798,21 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 
 int kvm_guest_time_update(struct kvm_vcpu *v)
 {
+	struct kvm_arch *ka __maybe_unused = &v->kvm->arch;
 	struct pvclock_vcpu_time_info hv_clock = {};
 	u64 tgt_tsc_hz;
-	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
-	struct kvm_arch *ka = &v->kvm->arch;
 	s64 kernel_ns;
 	u64 tsc_timestamp, host_tsc;
+
+	/*
+	 * If the host uses TSC clock, then passthrough TSC as stable
+	 * to the guest.
+	 */
+#ifdef CONFIG_X86_64
 	bool use_master_clock;
+	unsigned int seq;
 
-	kernel_ns = 0;
-	host_tsc = 0;
-
-	/*
-	 * If the host uses TSC clock, then passthrough TSC as stable
-	 * to the guest.
-	 */
 	do {
 		seq = read_seqcount_begin(&ka->pvclock_sc);
 		use_master_clock = ka->use_master_clock;
@@ -1822,7 +1821,9 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 			kernel_ns = ka->master_kernel_ns;
 		}
 	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
-
+#else
+	const bool use_master_clock = false;
+#endif
 	/*
 	 * Ensure reading the TSC+frequency pair is done on the same CPU.  When
 	 * NOT using the master clock, the TSC frequency may vary between CPUs.
-- 
2.55.0.887.g758fc8c411-goog


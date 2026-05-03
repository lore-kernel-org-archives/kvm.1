Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258E36E47E
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839436; cv=none; b=c6QgIpJGnAv+5YLLTKlU9LSmExGZt8K7BRHvcKDRL9W7lTPsaZKQnVtLddKfXAphZrgoLdKyYBfw9vtC4ACVUdHzLu0etpfheq3YfS/YHW9jP0jlvQe7vrrALc1rtE9ExHPIJndazZmYdpD8+jRs8maGH8Jh8RwdZYlD36bXONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839436; c=relaxed/simple;
	bh=giOp6gfjXieT1/b6xUERpdXrEm1QCvEoZYYLScyzdfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSDRHSElvmUlQBaTrmhTrdqrH1GY/fvKoCE76kLGLx2curHkSFcZU+i7w1apqKLPedhLMwf8sNtnxHJhqjujGx+PzNBmiX0Pp3gxjrunM8RLmX10rmVC5dR5FLFx329y5YdFv88oW1zk2JK3wnFAItRo15e31ibWyc9uZaMiLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuysZIsg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRu8udzO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuysZIsg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRu8udzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777839432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+gTtkSHsc/58H8jQY/bg4el9R2aQOy+A7eA/4Fm6GM=;
	b=PuysZIsg26ihr0lBA4zeFawqhBeL5NiSd4lS6Lo91Y+60ITxMmZXPNg2bEz45TcbKACBjC
	6WQ6mBdJZLzc8Ixb/R168smPmyTTK39Blr3ggWuQapvYaXn5oXonid1z3KyM4XA1fPuPPl
	lmeziXJgZ/qtl0ouEIAjpF5VEf1R8Fo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-foG1oAUcNeSBsa03vaSHzw-1; Sun, 03 May 2026 16:17:09 -0400
X-MC-Unique: foG1oAUcNeSBsa03vaSHzw-1
X-Mimecast-MFC-AGG-ID: foG1oAUcNeSBsa03vaSHzw_1777839428
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so32711735e9.1
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777839428; x=1778444228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+gTtkSHsc/58H8jQY/bg4el9R2aQOy+A7eA/4Fm6GM=;
        b=KRu8udzODktaKGvUl+tthBmiysiyCM4ngAw5phIGnOoGcBNJbnawf5h+u4e2yVAOcd
         ct4+LThSibl0aaqG8Gvc2znLy/s/jUgDOW6NFth+BugpD0NV3Rhajtq2IhTvJUXyszai
         yOiImZ7x+A9xzCO3/X5hbcwWyiJvYx38j9ekdWbPIoEObYC0LN98RKyHNkxhB01D3LPx
         EO35Y+n3RjRJse9uPn3iTzvlYyB2cDZuRWZTeUonjEb8GmxJy3vvuKNFb5VwLS+t6FF+
         Nv3s605jXdUIyZgANTNo90fxqakj4iLmY05hGJOD0WZR2VdHnYsLuIoXH/GjEBDa+twO
         r2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777839428; x=1778444228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+gTtkSHsc/58H8jQY/bg4el9R2aQOy+A7eA/4Fm6GM=;
        b=tBvqh7IwAkafUWpqjg2aJCHByuHOOZV6+cl3fG5Ls+X8ePJw8i/RW449MtXEcwyF4s
         1+jG8DxD08j02O/0+dqGAi+NHsWKkv2RNs8IA2DV69QZVmcR02l8/PKMX7aD9uAdBumP
         ucz8zs16GgOSIqEKbRj7T09BILsLt5Q4Adnw1PibmfR9q8eaijoCeVhdGtYLDQ+ivuwy
         YvYyYGnGWaJenCQheENpA+qdwnFdxpDbYi71kplJXorNR1V0JA3wXBGgn1p5JqfJ5gpc
         2i1aYINsP1RrskdgEt5WxUwGDNu3zzl47T8ec/X0IOBAgjMC/U0is9dNKFSU9i8s5ZY/
         4TMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zH/YTqIyvo5wNfIHfbMDXO6qI/DUn82Wq0SckhORl1VsEp3MwFUkb3N7+ts+tvP1ISE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRB7hfZmdxSS1F9xkAMZHs7j1XILiGZQ5mCd1JbiVlY9Zl3wa
	LfnNyMim2bQCAIA2197w6DR7Y3ML0QfMk9xm1GVh+sS3sDIpAgLFrTQjR7hwOyvis+oR+cfU70S
	h6w9CfYgohatpXxEOmfv9ZKW9GcrnjzTSYkN1wnJCASbAw9webkMR6Q==
X-Gm-Gg: AeBDiet4gKZa/IvtuvWF+eyjsF6bktyHtOzq1P+MeGFBJ+vJ2pFhNXST5nR29MQAplK
	RkzuFLXD3J3yetAC/CpSJaSIDdZxhcb+RWCs4q4ESRWpX5jpHCNnDNlpyTaCN639oRGk0WimDzz
	ciV5RhJX7hJJBOZWdyuIFpSu1HtayXWtWX8wGqj1IKjXbK5GtHe//IrttXV6A5eaWvWx4yaOKzo
	O1JzV3W2O2T92KE9Z9hqYV5NGJ49HvXeJy3sxpqUdIztOc3qUHPE0Q2m92S+UGlbEejdcQjiGfv
	aFnULKCYYPYIjH0MfjMwUB32Bi66vybC25W6g5I8XLLXNORtxijHGnxKwuMq+eSL48cO9z94T3k
	rMtTPBBOBBHqJ5HvKe6Ayn2zXviw1VoBUpMcIStbk+l7SAI5GpOuUOy6VYt3SkCUO5fKA2DWqgS
	yTKqL1/g1z5u5TvZCCdhdEwR6P2ZvZtdxWNhI=
X-Received: by 2002:a05:600c:4f13:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48a970fda7bmr122451295e9.12.1777839427960;
        Sun, 03 May 2026 13:17:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f13:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48a970fda7bmr122451145e9.12.1777839427631;
        Sun, 03 May 2026 13:17:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef45sm21476274f8f.32.2026.05.03.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:17:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: chenyi.qiang@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Do IRR scan in __kvm_apic_update_irr even if PIR is empty
Date: Sun,  3 May 2026 22:17:02 +0200
Message-ID: <20260503201703.108231-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503201703.108231-1-pbonzini@redhat.com>
References: <20260503201703.108231-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fall back to apic_find_highest_vector() when PID.ON is set but PIR
turns out to be empty, to correctly report the highest pending interrupt
from the existing IRR.

In a nested VM stress test, the following WARNING fires in
vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
vmx_sync_pir_to_irr() again) returns -1:

  WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
  Call Trace:
   kvm_check_and_inject_events
   vcpu_enter_guest.constprop.0
   vcpu_run
   kvm_arch_vcpu_ioctl_run
   kvm_vcpu_ioctl
   __x64_sys_ioctl
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
performs two individually-atomic operations that are not a single
transaction:

  1. pi_test_and_set_pir(vector)  -- sets the PIR bit
  2. pi_test_and_set_on()         -- sets PID.ON

The following interleaving triggers the bug:

  Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
  B1: set PIR[vector]
                                  A1: pi_clear_on()
                                  A2: pi_harvest_pir() -> sees B1 bit
                                  A3: xchg() -> consumes bit, PIR=0
                                      (1st sync returns correct max_irr)
  B2: set PID.ON = 1

                                  Target vCPU (2nd sync_pir_to_irr):
                                  C1: pi_test_on() -> TRUE (from B2)
                                  C2: pi_clear_on() -> ON=0
                                  C3: pi_harvest_pir() -> PIR empty
                                  C4: *max_irr = -1, early return
                                      IRR NOT SCANNED

The interrupt is not lost (it resides in the IRR from the first sync and
is recovered on the next vcpu_enter_guest() iteration), but the incorrect
max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.

Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Analyzed-by: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/lapic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e3ec4d8607c1..5ee14d6bc288 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 	u32 irr_val, prev_irr_val;
 	int max_updated_irr;
 
+	if (!pi_harvest_pir(pir, pir_vals)) {
+		*max_irr = apic_find_highest_vector(regs + APIC_IRR);
+		return false;
+	}
+
 	max_updated_irr = -1;
 	*max_irr = -1;
 
-	if (!pi_harvest_pir(pir, pir_vals))
-		return false;
-
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
 		u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);
 
-- 
2.54.0


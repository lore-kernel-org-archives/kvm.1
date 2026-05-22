Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CA36A364
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471335; cv=none; b=V13gcFO71iCrZmz4BsGS01OlWCcpIgjWL73gHQ+eIoXzc+Ph7Pi6xBTaRXbHHyfyftvKE6+bue7la6YEi7wR9L8geNaGwNC5IlOtS6pAot6aab+GgQku7Toti/KWU6GzslMjjY9jVUeNw/Pe4al4eSVYKIzBnxRJ1uOLZdiZQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471335; c=relaxed/simple;
	bh=9NVfYGCj0T9OiqBOL9PpYdCXo7lizBbmhOXkRI3cs0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hhU25W4g1VIfDY+GhYUrA/cJvB9KYboezWQyUEq2gUJ/ZlizX3Ydk5yaUYZk6ROFzaYx8u7vs6FBsyDHNiUj5p3A6ZsWT60CScZMcPJLbvBmYlCB/WlWQHOi/Yj8LQ9YfAbytkeJ8/4+GMRjZUEDzJ1Dg+5g96ilboWVNwI4HF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKXrDbJa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKXrDbJa"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so103246525ad.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471332; x=1780076132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bibhEOGKFiboYdCJy5SvZAlGLGr8/ODY4Bmd6evDc4E=;
        b=bKXrDbJaWdD4U79DQAiry2gdwmoptvc31EJTK4hLnRAS7sIUw8+BNV0u5yeAg8gele
         9zIjZSaAhBuYMEQLLPcyfHuCUndK2E5zL3M86aCqZ7w4gq0JEfDntpS8WWWdqmWfdtdc
         EWUy6lTcRJ/xMPHUNYS0AZpbSVKev8yq8tebUaxlUw8jPRAXOLejMqb1Tcvdd2rdrmhM
         f7EF+H7WAGh+enI1FFwbgsmO2UtL/GfJ2Ks0Og4lAWUmtrONxdwkKrVNeyO1HPFvYOnM
         aXSiUfQK7SGkAb5Z+xEE+ACW/BrekjU07L+a2d2ekmiLUZLr4TwRWyNeh9T2F158kQ6Y
         DomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471332; x=1780076132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bibhEOGKFiboYdCJy5SvZAlGLGr8/ODY4Bmd6evDc4E=;
        b=pque32Lx+HxNJDzHJDK7KCPtBTaq1RObaMZMJvHFvppeBsYYgRGJDeLaJfi2c61hDs
         l2b6PvreuylxKz/LeTuUhfVDBDnyyxp1/5hFd0hw5SReZlDWexbJ6gI/T4aBtQmpPFtS
         Urg+Q1abBMrFSoJdPR5s7g3S6+t7dAGy5szk+WdrOkeio8oKC/MOFOcLOuS1fwlRFbmu
         yG3vBr605WFVV05CJW31YZga/DLxdwLqpqrvE/6REfIR2saOrMsN7X80HGHqoB66lMiQ
         ckFF15cJoBbDOpGqDDUZIZH+WKaYKWVJQv1NQ3JEgukHLMOT/7ZdgW6HXlt3uXg/lk0/
         +3uA==
X-Gm-Message-State: AOJu0Yy/V2ZNg5M+DvRC+CRGkZ2wC6vFZCf1meIG+hFro4kKThAGbpgH
	kq4qsRO4+Pz3sxim3QVM/fDWyZbZGWl+4+0zMSisjKjd2gd3qTDv8hTYjW0IxcEDik9UkrO4SNw
	rUvaNAA==
X-Received: from plbo8.prod.google.com ([2002:a17:903:c48:b0:2bd:9a1:9a05])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebd2:b0:2bc:b141:8551
 with SMTP id d9443c01a7336-2beb06f81f3mr50866535ad.19.1779471331628; Fri, 22
 May 2026 10:35:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:35:26 -0700
In-Reply-To: <20260522173526.3539407-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173526.3539407-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522173526.3539407-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Verify that KVM returns the configured
 APIC bus frequency
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Add checks in the APIC bus clock test to verify that querying
KVM_CAP_X86_APIC_BUS_CYCLES_NS on the VM after changing the frequency
returns the VM's actual APIC bus frequency, not KVM's default.  For
giggles, verify that KVM still returns its default frequency for the
system-scoped check.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/apic_bus_clock_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/apic_bus_clock_test.c b/tools/testing/selftests/kvm/x86/apic_bus_clock_test.c
index 404f0028e110..0c84c27ea584 100644
--- a/tools/testing/selftests/kvm/x86/apic_bus_clock_test.c
+++ b/tools/testing/selftests/kvm/x86/apic_bus_clock_test.c
@@ -137,6 +137,10 @@ static void run_apic_bus_clock_test(u64 apic_hz, u64 delay_ms,
 	vm_enable_cap(vm, KVM_CAP_X86_APIC_BUS_CYCLES_NS,
 		      NSEC_PER_SEC / apic_hz);
 
+	TEST_ASSERT_EQ(kvm_check_cap(KVM_CAP_X86_APIC_BUS_CYCLES_NS), 1);
+	TEST_ASSERT_EQ(vm_check_cap(vm, KVM_CAP_X86_APIC_BUS_CYCLES_NS),
+		       NSEC_PER_SEC / apic_hz);
+
 	vcpu = vm_vcpu_add(vm, 0, apic_guest_code);
 	vcpu_args_set(vcpu, 2, apic_hz, delay_ms);
 
-- 
2.54.0.794.g4f17f83d09-goog


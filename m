Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733923672B1
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471332; cv=none; b=MvXt1g+CWT0pk7UaqbiDuZnWhNAeiH8CcyHimVUDvK2QWc+gY+dDz6w/ZGKstY6mjy2SnrPcomLwHnL2wVGtEEb7tMDUbSziRITYasdLtQ3qTQeMSFDnNSdEhLTPT3wW67dkkRSQ+HRYd21C8LbDNxIv29RPKvxuOrTDABfIImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471332; c=relaxed/simple;
	bh=ZWyfUAbg3NJNSjuuvqn9PMvk+OPEkmwTNwodEh8+pj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AXFYBI7xW65xXaxx0QYsEUo8KeNV2lovaMq3XmeGmg74SKVewyjOn3mpHtJEvctazkoSYli8bm11iaY3XHqQFy30OchnSqOEqJCA4x1yvppexKJfuMV9RNvbH9WudkFlpRUwz3ZfIOSXx0b8scka52XOt+FIShJ46Y+qwXm+7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wml1LSb5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wml1LSb5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f85179263so9588004b3a.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779471331; x=1780076131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zfgSaM1zsajAFbytYQkOZfo0cdlpb3GjOd+8W7CqHNI=;
        b=wml1LSb5qjFtTmHhdxIxJcJK9rOTOMaoMyy/q5EZX/sqXUVA+vTgs17XlsUHWukrtD
         TstuXcCJSB8YUOZyxhKuLQTvVVrQJbCeNvWfmCKTEuX423+thOYMZeu2J+f5lLvKtyfo
         2EnXS24YbIqJ0Ap/7OLtnxo0mwmIMaSwCe1nNH4lNPBRP31dRIk0gXdq53Y1ATmB73Pl
         Fzt97QyO2W/AbMcsu6xZaJ9L6qcjkokD9pa5tMUBJPmyfx1DIZyK3Lw8W1la6IYZi5r5
         /WTwwYzYTTvynpymoGqMWXvBZxCYFWfJGQubUHm3iZYmx37hfgQ+a3Fmvoqn4T4N6eR7
         FAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471331; x=1780076131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfgSaM1zsajAFbytYQkOZfo0cdlpb3GjOd+8W7CqHNI=;
        b=iQ9BAyYj7hFpPlUQNuKJYeWmPsPaIP0ODia1K+TW7b3LVoDBzS7tLMru+AH5zw9f3O
         mKdgDc4cc2bcEmI/7T/0qlkmCHwMQ1M5/DUeRoTj0stpv6JqO8Zzalb7d8l4pv3Xsqvk
         1lyo+Gq/LxoDaVvDwMV3Xfsbkjo6LCrWcSo3JWuaQSfzJX6P4VvqVGLp3Rj+UE2DQkkX
         dlww+3n8VEQNw8KioHyjsG1LMlD9/cFLd3KfglFHumlBwFe//WoYloWdnfFgSdtBwdXl
         VhxdXvQ9QrOMtSfF5rU+cPUZbXh3gaFw97gi/IM9psV8eU3Q8frW84IC2Iy9J20YlT6/
         r00g==
X-Gm-Message-State: AOJu0Yy2geeviu15d3CEcPazgf6LX+2zX0Q4+876geXzoNLbrCHi31Fv
	jPMLufl2+ke3JrjNUOxrI6t5XaWfhzaQQ5llNzITP0DRoXf96Ac7jl6k7ZXcp8hBraCVzonET1L
	B/qYYWQ==
X-Received: from pfff17.prod.google.com ([2002:a05:6a00:bd11:b0:82f:22c2:7af1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1888:b0:82a:7aa3:a2fb
 with SMTP id d2e1a72fcca58-8415f63c1f2mr5112903b3a.37.1779471330435; Fri, 22
 May 2026 10:35:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:35:25 -0700
In-Reply-To: <20260522173526.3539407-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522173526.3539407-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522173526.3539407-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Return the VM's configured APIC bus frequency
 when queried
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"

When KVM_CAP_X86_APIC_BUS_CYCLES_NS is queried on a specific VM, return the
VM's configured APIC bus frequency, not KVM's default.  Aside from the fact
that returning the default frequency is blatantly wrong if userspace has
changed the frequency, returning the configured frequency means userspace
can blindly trust the result, e.g. when filling PV CPUID information that
communicates the APIC bus frequency to the guest.

Fixes: 6fef518594bc ("KVM: x86: Add a capability to configure bus frequency for APIC timer")
Reported-by: David Woodhouse <dwmw2@infradead.org>
Closes: https://lore.kernel.org/all/ab84153e33fbe7c25667f595c56b310d4d5a93ef.camel@infradead.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cecb2f84e5e0..7c5d99283be3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4885,7 +4885,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = tdp_enabled;
 		break;
 	case KVM_CAP_X86_APIC_BUS_CYCLES_NS:
-		r = APIC_BUS_CYCLE_NS_DEFAULT;
+		r = kvm ? kvm->arch.apic_bus_cycle_ns : APIC_BUS_CYCLE_NS_DEFAULT;
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
 		r = KVM_EXIT_HYPERCALL_VALID_MASK;
-- 
2.54.0.794.g4f17f83d09-goog


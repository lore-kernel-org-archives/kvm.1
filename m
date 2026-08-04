Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D13AE18C
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886769; cv=none; b=Obr5V447m5RQjjzhD/9zVPPRjnoUrJrjbgwxGTncHGBZHFK3quxv6DUHeKE6rOAIs6TqbkGz8uUfipr3G/Mb4yIqsZl7QwqPTr5z2+yFV1bPiRxnIp1v4zUNL+FdGvLfAZ00hCrLBHFnpiBgFEVpl5bwfIWx2B3xsjUJuxeMZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886769; c=relaxed/simple;
	bh=Zb1yCTfWtc7AjTnpDdKcnQevCbLygXR+rO0daBu6lIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSf6IRAqu2nXpS0gDNS1QtfmriFgOxGtQxVFH14asshhG6w7nGxRTdSly8zsD4kYCeqX1UGSZ5vXi8NLIIy1kHDTgU8kqFu4J6FBHyrfOMTfdIzPYiO0fnBCn8KW8ugFF8j9iXCO/zOW74Drc7FVoGgINhsdHNVSR7/N8CIkb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWkH36vs; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWkH36vs"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so535210a91.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886768; x=1786491568; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EE4fwjfSfyqQPmpr98wwjwDPG0KhcYlo7/lIhHAV1RA=;
        b=MWkH36vsFBw19gtotn4yWpq1kg0kpb/MTTMyTt5tDbAL/WKVT5ceMZ4sTA7ouheH9w
         Ic3U9nnnp4mZo1YkDDXz6DEzJLBi4ACn5ITEuJIA363b+ImTx0TlEIHbGXS44r7Jvh5+
         yv8tPZ37I1EpsWTIsFqn4dc+tTK6VF3amjiULONhW4wzIuLfpokMPeeZGlQCdWZPTGzM
         I9H3fw1x4/L6CzUibg8W5xrG+rGNF4AjoLxTqWGjmlOwkwfyLwyTS/L2tFCTF3JDbKwt
         Ul7rqZyKgMDSjq4XfZly5/I10D+2/K3W+ilXVjidr/IVf5yJ5c1KAfha+yMMlXnYOUxM
         MjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886768; x=1786491568;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EE4fwjfSfyqQPmpr98wwjwDPG0KhcYlo7/lIhHAV1RA=;
        b=HYFhL+1Lpxeiist6WcUQoHVHWKpUQAeorkoZOI6JyYcEZj1jEYLLtFbcFgHhtqichy
         Asz0dwwareTr/+T+jY4sE5Wew2d1WdXpTgbhwiqqYGVowu2123omUpLm0i2+gRI08MRL
         x/EMpcPVsiBtfhx+gqR4b4Nb89DphyIrpfNLXrVZJ80JjnH6qSdf7yA0aafx5bZl8MGB
         9hll+nsJuK9ODnP5xYQBXMgYM8KGItRgnpOkY0uS31cG3/QdK8RgOLq9JWpoh+1cy3dR
         VBteP8Kaile0bYsHAynpqyUKJTP0WxAogNh4jLlPy1rNGAZn7gi+W5Wz1Je3GPLCt7j0
         4Dtw==
X-Gm-Message-State: AOJu0YwtSQGb9NVdM+Z32r96pdF7SUHpMkkzVKLds1DQpztwhsdfudAo
	EYIf/qjZGxMUVKkX3Q4yNxFZQ0aXYSCD5BM3q9llwFt4lqQ27zjE6bOr5pfIOZPdrzKOAGDMJhY
	sIwVAMQ==
X-Received: from pjub5.prod.google.com ([2002:a17:90a:cc05:b0:38e:b470:e6db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280d:b0:38e:1497:af5b
 with SMTP id 98e67ed59e1d1-3903c54fbebmr2514068a91.1.1785886767530; Tue, 04
 Aug 2026 16:39:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:05 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-2-seanjc@google.com>
Subject: [PATCH v8 01/17] KVM: x86: Update "last guest TSC" snapshot prior to
 enabling IRQs/preemption
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

When refreshing the last observed guest TSC during a guest time update,
write the snapshot before enabling IRQs, i.e. before enabling preemption.
If the task is migrated between updating the local tsc_timestamp, e.g. to
account for catch-up mode, and setting last_guest_tsc, kvm_arch_vcpu_load()
would set the vCPU's TSC offset using the old last_guest_tsc.

In practice, the bug is largely benign as it's not even strictly necessary
for KVM to refresh last_guest_tsc when updating guest time, as KVM's goal
is purely to prevent the guest from observing time jump backwards, i.e.
super duper strictly speaking, KVM only *needs* to update last_guest_tsc in
the VM-Exit path.

In fact, the update kvm_guest_time_update() in wasn't even added to play
nice with kvm_arch_vcpu_load(), it was added by commit 28e4639adf0c ("KVM:
x86: Fix kvmclock bug") to fix code that no longer exists.  As of commit
28e4639adf0c, kvm_guest_time_update() also consumed last_guest_tsc, to try
and prevent guest time from jumping backwards.  That code was eventually
removed by commit f25e656d31ad ("KVM: x86: fix tsc catchup issue with tsc
scaling"), but the last_guest_tsc update hung around.

Keep the update even though it's technically ok to drop the update, e.g. so
that the tsc_catchup updates aren't lost, and so that the guest won't see a
PV clock timestamp that appears to be in the future.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..d3b47e38698c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1820,6 +1820,12 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 		}
 	}
 
+	/*
+	 * Refresh L1's last "observed" TSC to match the PV clock's timestamp,
+	 * e.g. so that the guest can't see a TSC that's behind the reference.
+	 */
+	vcpu->last_guest_tsc = tsc_timestamp;
+
 	local_irq_restore(flags);
 
 	/* With all the info we got, fill in the values */
@@ -1841,7 +1847,6 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
 	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
 	hv_clock.tsc_timestamp = tsc_timestamp;
 	hv_clock.system_time = kernel_ns + v->kvm->arch.kvmclock_offset;
-	vcpu->last_guest_tsc = tsc_timestamp;
 
 	/* If the host uses TSC clocksource, then it is stable */
 	hv_clock.flags = 0;
-- 
2.55.0.571.g244d577d93-goog


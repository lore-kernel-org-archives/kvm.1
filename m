Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0333B47FC
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402506; cv=none; b=QE0eedCTEJdeF8L61QEJwB4raQXkD2ZV+bfbHWoCaieulymXC9Nw4MJT5olkejZICzbSk+Q4t3x5QmPe7rsmsyuVMs7ndOHZMZC7TOkQUlA6Gu1jfFzgtHU+PGwfG5oCNeo6tWHLId6WAQO/yTZTekZJOe8L/mzKv71ZzOZ2j9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402506; c=relaxed/simple;
	bh=q5To44xBl/gE8wYNN3nfuNKweMRUq43GdPCEJJU3QqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g72vkguXZZleMTq5Y2nlVxdTtpx3qj2Bv86izPUWRDzqsYaaN/fksynajmKqLTDeziIi+Qhapvkop7/8P5VVaNGz3nnTCiA2n5c0ClV0n7ZMkgPjNcdchKMXV3VFBKVpopMpCpzePuE0DGGo8L7529bCjQpnzY8w+olbhPXV3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE+/AgqQ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE+/AgqQ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84885a4fcabso2664922b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402505; x=1787007305; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0u13O/4w/SnGeHc5D4Ig4kypIQphyw1Zk4osNUF32Cw=;
        b=qE+/AgqQkwFDz27cZHl+fQOIaJM5qgq63+B9GnUOuqcShfy6TSZImOMl1aQx2TVY+3
         Z2Mh8JcLQfwg8GmTGnVGQpmGOrpWSXD/swNrB3NL+hW+w2CSU31aj/y808xdcdlYiwbX
         rtfSx9xf4/wHkk6w1yJGUuXCmiGxofMfpUSS1YAIwG2TrWyQFSItmTiQXjpNAMJS9I99
         +9eEI7l2hkKN8ftkZSeL+cbkICbORokDJGcasVAKonEiTRCZl0TBJD3+fC8/NE3ia5eG
         nSeysKIdRZmJRQ9z3pBlUwB8typxhon4jvWsTsWRgSjji+7HFd4UE4krbeO+oYY9BHMU
         YEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402505; x=1787007305;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0u13O/4w/SnGeHc5D4Ig4kypIQphyw1Zk4osNUF32Cw=;
        b=s4qdKFBQNlIv70SQLIcpbj5pPJVuwedpok0gCo6/Qhlo3zP1VG4QOjKxbVC4J08Efr
         Rtydu5MiZ9tH/JxAhv4qHdiuEiAal/1wRa6qXwbwQqPrm+cFKvIZ9Gf4f0eI/ZsJh6x/
         Sd9E3v+KPzod+TOBVZnWCym8aBL+M5hCFKV+WSfXwCd0b+8mOjWlm5jQklw2QUfjHa+e
         oSAy2JkxVFP14TJAE8v+Ca5vpvpYAHPd6MTe+r9tiD2br7IxTX44IRpSK/c17rReOIpv
         B3m5pZneikjJ1jTKH3lA+WV462KsjtTn10mpk+/xt7aP9ixFrgDdn2sY3sXwxkPY80ZT
         5QNg==
X-Gm-Message-State: AOJu0YwRx63CyndmBdN4w1GoboWcS3B9Tet0ITTF5FWeqIddqEf5b3Fx
	nMilwn5hbklY8XRRMcaBcuioK7k35vyK3Q6hOmsuh/di/KNmthann74RhSL8xP6DFqidgXsCB42
	z7oD2bg==
X-Received: from pfbkq8.prod.google.com ([2002:a05:6a00:4b08:b0:84e:1951:8efd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8283:0:b0:848:86d6:298b
 with SMTP id d2e1a72fcca58-84f9b6c47f9mr4553523b3a.29.1786402504381; Mon, 10
 Aug 2026 15:55:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:39 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-2-seanjc@google.com>
Subject: [PATCH v9 01/21] KVM: x86: Update "last guest TSC" snapshot prior to
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
2.55.0.679.g6767b8d81c-goog


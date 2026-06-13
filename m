Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755423BD02
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310046; cv=none; b=oNMOeXRA7Af8OvMais585uwp3/t8qPt07mocHXDw5SIMBUsRt4dGf9CiQnRpi10M17uL/wMJdsalrEQeIVXjbQ6+H9m7qrUpPSob/NfVaNhjYR/RI8q+q/D7A8aSXiJxAtOdwQMDi7Wb5/fgrB+8bs7G7zN+SWLLkk8rRddTtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310046; c=relaxed/simple;
	bh=z2y3Udpn3PcQ5P8PyZ7p3m88PIL7r3+VZEmGyqxvHS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cqLoInwyqXpCsrDe2MEcskU919TMZjX2nJfqUFWHzP18CTAwKYqvSs7qxo9VsodwlkjGFqjwRzKV9ohAjVu82Ztd8f2mgZ2kT/fj3BXyMX6OtJdE1wtLF5fejvARNiCy9/3n9g8xvd9fRM62HdnfMbJJZpPX3njf6178Hqw5Nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYzFUWXw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYzFUWXw"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2a4babe45so8781775ad.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310042; x=1781914842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RpDrln9aFOeZE+9RVMRnWEbd+STgPtUuso+t2WcSRjI=;
        b=uYzFUWXwgshCEsvmzaEGxL0rpO1tdxRacX5P6IQ9a5ixutJ5PypQow/6yInor7Y1CV
         F4aLEDoHKtstDOatTE5n/XNVam1W1ZNVLn7hmSqiS0Ln5DpgOWLAiQ5GDb9Cejx0y9ai
         4nGumHEW2QtuPYGnJ4C1vnt3A+UpZkXN7izloAEv2fLAArHSDQdFeZS42Vz+u++7cBLS
         RJXU/NFzntOINk06W6F6GckVUO6ULuV/WlY6dtVpFfH15frZoybzGHJGL8w7THHxxHvW
         fPM87vMGbstcMDx7mGJB3KHKnke3gTSDKklAQlazLuOLYntydUu7zZGwXdsAlcOMfUGq
         A1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310042; x=1781914842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpDrln9aFOeZE+9RVMRnWEbd+STgPtUuso+t2WcSRjI=;
        b=F8lyeXSnIXvBHYdxEG+zgbTOyESjZy0VPfC/KgkhvKXOIzLYWg3Ts8YPv0dQp2ed2w
         txoiSQnBwoAeZ8LHTcqQtWOGQQxVzWT/YO+JWsDPX96TIZ8GCG5gEyIeY0u9UFC0q0Qy
         aLgmubZ8UykzNkNruTBNuWTxakLogD+y/p25c/7Ritg9FMvGZ3ODsmV8VKo54sfCs+pj
         mSQdHwEEentsWk1vW9pqwSswL8Xt5mfKmIWGF3nQiGthzEWX4depe4Ys+DgrKgsg9DI+
         QjWqNhB84yvntlnnYSdIbq6+AXET5oXh44/fwfW5vZU5SNUMrKikjC8j7/ckYE8Zuf3M
         jMbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Vk306r0EFcD8CJdmZ3fXjwAECpuQseWC4306Cdf1aOTk6dMwLzeC6pXEBx1k3HQH0TOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEd/B6HDeJocBpPrChqkP8B42CIQSqIl4SjEjC8UvbmwVhbVx
	7jI3+uHexVAhWECc19tVfIgTT4GcXxFm2ey21K5dMF3lgiIDD1nNL2K+fd0qgC+r1OIhS5fLDGA
	KchWC7w==
X-Received: from plbkx8.prod.google.com ([2002:a17:902:f948:b0:2bd:106:8ad0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e881:b0:2c0:b932:866e
 with SMTP id d9443c01a7336-2c6642915famr18540805ad.27.1781310041864; Fri, 12
 Jun 2026 17:20:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:17 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-7-seanjc@google.com>
Subject: [PATCH v7 06/20] KVM: selftests: Add helper to generate random u64 in
 range [min,max]
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Introduce kvm_random_u64_in_range(state, min, max). This function
returns a random u64 in the inclusive range of [min, max] using a struct
kvm_random_state.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/test_util.h  |  3 +++
 tools/testing/selftests/kvm/lib/test_util.c    | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 44c0104d60ac..d64c8a228207 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -134,6 +134,9 @@ static inline u64 kvm_random_u64(struct kvm_random_state *state)
 	return ((u64)kvm_random_u32(state) << 32) | kvm_random_u32(state);
 }
 
+u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
+			    u64 max);
+
 enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS,
 	VM_MEM_SRC_ANONYMOUS_THP,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index e98ca7ef439c..e208a57f190c 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -42,6 +42,24 @@ u32 kvm_random_u32(struct kvm_random_state *state)
 	return state->seed;
 }
 
+/* Returns a random u64 in the inclusive range [min, max] */
+u64 kvm_random_u64_in_range(struct kvm_random_state *state, u64 min,
+			    u64 max)
+{
+	u64 value;
+	u64 range;
+
+	TEST_ASSERT(min <= max, "PEBKAC, min = 0x%lx, max = 0x%lx", min, max);
+
+	value = kvm_random_u64(state);
+
+	range = max - min;
+	if (range == ULLONG_MAX)
+		return value;
+
+	return min + (value % (range + 1));
+}
+
 /*
  * Parses "[0-9]+[kmgt]?".
  */
-- 
2.54.0.1136.gdb2ca164c4-goog


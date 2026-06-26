Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB23C09EF
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509746; cv=none; b=AogmT/SikZdPCC4TPMrXkoxB7VzBMdSjJxfRMwzZMkRi3U4ebbWq7konwOiCMSViDODBVoYPTn0DFj7nViNjXMXe9omIBQSOz6gVi+F2yxKm8kGH5pcrXP2X4f13wXEuRsCV/6RaRxs0VLBLpIS/z2fk2piwy8nk50Oy7Ma8kA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509746; c=relaxed/simple;
	bh=DpuOXkwzCOgbf4lBzoy432Js8GwAiDpEe96hUsDd1ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d96W16ofNBGecf9Lm9onOsdep4hM8kfI+x6NLq0KfUKyKzBYiCDReW6fYZpUYBr0p3/UZn+YJlryLXFY4PB7wfbhBmcYnn3NnKWgkLAy5D2Yf3dr4417mzp4wr/CtuBjh/kVENTixaD+3ZC186PlzHvKbFai7t9dVDLruSFWH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhpZYjne; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhpZYjne"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8bad49b171so694186a12.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509744; x=1783114544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pWc4GlXVIsd14e/yCg7QaIqalab335GasYtgDQrZMX8=;
        b=qhpZYjnett3p46KGJgWL360EH41kXAGvq5bPtvHbyIf++bL/uulZskhbHkLL/VJ6Sf
         KIZbCb6dZVmq5ArdAkU8s5CNz96mrVKBBP6fkv1So1FIWQpH+DIaxZ8Y8eGW1FLhedsD
         fVBVqptx/KPFpVN+huCPUQN9xzJlH2b41Ub1R83hBfAFyeX5aIyAtrDDOxnxmeM8V/sF
         rLLfcx92Wxelh812qmC8e7etJqSKpTPonxJnUwZSziiMLuqfQ2dWOgL1qGuJ4qWYCWaI
         XJCjH1pHlRnX5ABsko104vA46ItdXQP8o6VzT0hRUmw7Ll1ZWh7gEXRyIsWAeDofH+GA
         VBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509744; x=1783114544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWc4GlXVIsd14e/yCg7QaIqalab335GasYtgDQrZMX8=;
        b=bprSz4cggPeCXHV+1hKM+tfDPf304YjGsXKdP+4I38CRDpe3kI/E5WQkgNer3nEUta
         tAG4AVsiLEDgljua/ELg/cOwPAeXZeJ6KEUpwU2mL+9MsiGJfCibRvGWeBwaIZoulyyp
         hS1PVeNOHJahB6U0loN1TuIm3nDvxa/JgjrJo87O9rznafsbpRK5AFkgqwb6QYfxhIxR
         TNlmqiLQR41IXnrww+hajh8rqFaDj2OtCFk6HUDlH3XXI4OFARbSzEzagCIDhUjZ7wHt
         JGWiJ17n7ITrPgeIPJ8VNvVlSQ3o6v7craz7oiZjyfnKWEQ2yMSwELwo45IqcioGEv3b
         1LcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMf4KkX9BHuJIQRWz0NPrvoX1UZV1FUPnUUwuWZIYS/9tb+w1R7ihQLfNjsCTOPKTBc8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsOy23h58M37HXsD5xt1erI++t1E2JXjGH8qCnHg33xKpsSH/
	hgrdNKVZ0ui7l7bRWCDWYlNa1lWaRvtdcHBZ/ImR5njEDXEl7YnUOER89x/1PN6JTH7V5tPfX2F
	pqVB1hA==
X-Received: from pfbmb6.prod.google.com ([2002:a05:6a00:7606:b0:842:723a:7919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:189b:b0:83e:f228:b112
 with SMTP id d2e1a72fcca58-845b3b8e2ddmr9010923b3a.34.1782509743991; Fri, 26
 Jun 2026 14:35:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:19 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-7-seanjc@google.com>
Subject: [PATCH v8 06/20] KVM: selftests: Add helper to generate random u64 in
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
2.55.0.rc0.799.gd6f94ed593-goog


Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0183A255F
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813394; cv=none; b=L+pwlaWtb3QvTqjKNf03bZrRRtgz3OLaOIm9oUMV/qyXLOLj5S7GSqOp8Ypo4dPVzly0kbulJJPXjyFoPcwFeK6WdiRrjbnNuhUKeM+YLFbKdQssoAAFTr+cT3JvZJH9Y1YsfsuqyMowi4Wb2skeNF+8GrY3ej50VWWEIQQCz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813394; c=relaxed/simple;
	bh=voOvk06YWqRurywBuUK2hn9zgbNMkMhLMOTchW42D5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZKuHj15cooEkUd4s2zknq3WsQDhyRFtU3klZIQrQ0wstgc2qEDE2vUahojK1iYQklDd6AXMzozJ6Ljzp0jAGFKNdOzpS8rmToFoWAEO2opXx5h0Eq0WqpHP+tX1w96oEYnaHpMbM/lwcLqZHgumvm9/qKnUsXQkPl/Mkk7UD+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NB0suDN+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NB0suDN+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso9333893a91.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813389; x=1777418189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSSgscTMb2e4GTrJ8K0fxWTxtmJkv8VeQPDezgW5IvI=;
        b=NB0suDN+oiiMwqz9Ym4403qdGLplHrI1xszgH2YO3SSVzcPdBrx+/6Hb1C+VJFnlct
         oLq1HuZV7j4+Kv+E2d6PClnYqhPnvR7f9+xi4oYkk2ZTj6qp1QfoNAurGpTWN9A7xIst
         bRDDjZ135qmBZEjP7U5euuGzuIAwKCubl1e2dwj1qDkfgcYmqLPhsRDrugp8y9fiAFbJ
         T5s3SmImOX+iQ5+bwdp9GybrDDR8bsldHRB7xdixfbwfmV8eDZth0YGCJ8x58cd7pQea
         gGMDNWZj5epD0a+hiQvx5DKCV6/EANhrM66mCOv8JVES24Hw75xSKlEvuAu1Mm+xG3ij
         I/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813389; x=1777418189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSSgscTMb2e4GTrJ8K0fxWTxtmJkv8VeQPDezgW5IvI=;
        b=ntltggcc9ROXNyosBfap0rSVtP3y6O6TrRC63okAuwwNAqXxZuqW9EkZEa68X1Y7d3
         pNLfAbELjiz2FzIZWn9U+Ga8rnrkB0GQ50fF6rivKDbKQAb9Bh/RfKCbPfCEhVyLjdVx
         e3Fjp99XsehdQI+9EOUZWIwHBa/h0ZzjdPEGfnuCnR0hODMAYGcA7rU9Qj8Kcsxw7fbL
         Sc+pAmOiHrWrY6TXav/IqTQykjJmfMGE4TzX8MO4cYgp1e165cvzuG73bjaIoYsZYKJa
         43gne9U4lbJezoVrvKmJpFVAlbvNj6KAVoSHUXY+ESeAzx5vaaDmrqEh+WKnwJTGn5cs
         44Qw==
X-Gm-Message-State: AOJu0YyH6dRnUBjnT7SgSGYV5GPTHo5qgArq51oqn8fJxpjVxW/q2daC
	4givBHhJuJa2V6WIQTLNrIQdSamCksDyodHyeRlPygfdyxA95oYrrLdBfdgrOsadugipLwApsmS
	kjkETJRc8
X-Received: from pfbjs41.prod.google.com ([2002:a05:6a00:91a9:b0:82f:6c9a:6139])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918c:b0:3a2:d838:bfda
 with SMTP id adf61e73a8af0-3a2d8393bb6mr9832338637.46.1776813389169; Tue, 21
 Apr 2026 16:16:29 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:46 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-6-jrhilke@google.com>
Subject: [PATCH v3 05/16] KVM: selftests: Add helper to generate random u64 in
 range [min,max]
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce kvm_random_u64_in_range(state, min, max). This function
returns a random u64 in the inclusive range of [min, max] using a struct
kvm_random_state.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h |  4 ++++
 tools/testing/selftests/kvm/lib/test_util.c     | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index ae39c4293b9a..584a4ab43db5 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -132,6 +132,10 @@ static inline uint64_t kvm_random_u64(struct kvm_random_state *state)
 	return ((uint64_t)kvm_random_u32(state) << 32) | kvm_random_u32(state);
 }
 
+/* Returns a random u64 in the inclusive range [min, max] */
+uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min,
+				 uint64_t max);
+
 enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS,
 	VM_MEM_SRC_ANONYMOUS_THP,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index e342d9fb4771..23d543a9053e 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -42,6 +42,22 @@ uint32_t kvm_random_u32(struct kvm_random_state *state)
 	return state->seed;
 }
 
+uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min, uint64_t max)
+{
+	uint64_t value;
+	uint64_t range;
+
+	TEST_ASSERT(min <= max, "min (0x%lx) cannot be greater than max (0x%lx)", min, max);
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
2.54.0.rc2.533.g4f5dca5207-goog


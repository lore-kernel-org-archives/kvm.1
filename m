Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F71A8F97
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100593; cv=none; b=O901RXp+drszkwJj7A8xrYLFQTZuOaz1xH0P5b/oNSK+4c1nLLWUQNwiYwDBX0v7UPqv/sROwlINX/IRZnvZT1/PzRHCgr4Plzz3L3jHb29kcZSdIvD8L4RQ4Qp9OLmiy7yFezMPmZXHF2tVu09AV2Siir7V7M8/Wl8F6xkV+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100593; c=relaxed/simple;
	bh=Wj+UbOSDYhhcXkbNuCEqtUYkT3jEsOdg5YGtZ2onw50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gkfcEYNyP3tS9FevptcfZeBwbAMLbOhOzzCa5LMLAbpf3fSZqW/JcmoHSTgTF8YcwyWxqYLjrq0jWDPkdXaGAFERjHFuoOgz/QhxFLyyCDH5uZ82l8SBUFHmsB3UOe6+2bVnp5a5kbh40Qk8AOS+ZoEweN/95WIXEcuWvvpRGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PccNeIXZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PccNeIXZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1845bddfso16823635ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100590; x=1780705390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6z2U56XL51gXNFdr4umtF89ubW0Siw/kvIEmINYMcys=;
        b=PccNeIXZDFHidJ2Y4Wg9eTshol0QBGPJAsUUPGi7ICdSZhalhK0HbcQ0B5ApeJYpo/
         SwvJywKaSA5urdaTNGEMPc5A59ILsXQEZZIrPP1WJRFII0UqZKRCbO/6O3nFKVWC1Yhv
         QieQTLR22qSZJkLHj9/jfEYUfCdiTwPnqY1o5KdKVdFBIPCgPckQAN3LTZT7Kvh+CrXR
         5I6e4hUd0z9UkvwlFoP8XjjZGzm9jn4S5NzPWmPvTm6UNcNSAtLjXfXs1ZvpT3rAfQCp
         CIXkgQLV4Y4Dwzrjr3jtbFbeGXdXUnjemot5930wAlwcB+v37uP6KCq4mb9LgtBGi+Bh
         /jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100590; x=1780705390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6z2U56XL51gXNFdr4umtF89ubW0Siw/kvIEmINYMcys=;
        b=RjdEoRVOCs95V5RuXlW5kztrBu/54taplsH1KAL2KUGygaE6ZIKMbFr1LPF6/zZ2YP
         DgAZesr2oIbcQiWvZcDTxzBOJMk9Ul+EWKjCFW/KXW87Gk+C0JCqe63MDwaPor92AQLz
         kwqkfeU875KJ8zrEXom41JKKbe2LdqIWOXpWQqKtsGfL7LWxBr5NNWzoqsMMvCYx1r3l
         VYsXZ2snsXouQN1qvMZ7mMNZU+LyJszF2OcmAwXutVQETK7JUSkCri8SlqhSJfOKC/gR
         QHhbPFIg1ZrYzJxT86t7MAMaq0AyCNZeMsfm7ohy3mQAhBPL2kPyUFLeBPLlNwTPX79a
         rc8w==
X-Gm-Message-State: AOJu0YzPBkU+IkqiyDL99DVkTaCZTGrG3ZdTv0w8VoAeqpScJSfxCZKi
	W0ZYIoqADXb+BOh8QoChibNVaVjMU4ejj/ejbnw1A4vhKPkvGQwQ9lg7uyB2NxdirNUVFYiFux2
	Ppr5sSgCZ
X-Received: from plaq12.prod.google.com ([2002:a17:903:204c:b0:2b0:aef9:a5a2])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17c8:b0:2bd:8dbb:293e
 with SMTP id d9443c01a7336-2bf367c80b3mr24794555ad.14.1780100589696; Fri, 29
 May 2026 17:23:09 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:20 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-6-jrhilke@google.com>
Subject: [PATCH v4 05/19] KVM: selftests: Add helper to generate random u64 in
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
 .../testing/selftests/kvm/include/test_util.h  |  3 +++
 tools/testing/selftests/kvm/lib/test_util.c    | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index ae39c4293b9a..d601227dbdba 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -132,6 +132,9 @@ static inline uint64_t kvm_random_u64(struct kvm_random_state *state)
 	return ((uint64_t)kvm_random_u32(state) << 32) | kvm_random_u32(state);
 }
 
+uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min,
+				 uint64_t max);
+
 enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS,
 	VM_MEM_SRC_ANONYMOUS_THP,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index e342d9fb4771..dc47ed9736e9 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -42,6 +42,24 @@ uint32_t kvm_random_u32(struct kvm_random_state *state)
 	return state->seed;
 }
 
+/* Returns a random u64 in the inclusive range [min, max] */
+uint64_t kvm_random_u64_in_range(struct kvm_random_state *state, uint64_t min,
+				 uint64_t max)
+{
+	uint64_t value;
+	uint64_t range;
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
2.54.0.929.g9b7fa37559-goog


Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDC2E1F0E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538557; cv=none; b=tNQc2vCDYcnZHAXpBnb9bGQNhlQsJvaeHARLxPwWoppNTAjHTtVlTfZ0J60sue7wiHhukMKT+FA1xd4SxkThLe2KskLCUElGiIY/HXRzSjs9xWfT9QSiLgOo5ODaMcwwB3bdApSSEX1avJBQBfrQFOne231mXK2D7PmjvqkevVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538557; c=relaxed/simple;
	bh=nXMNFoJGxvgH700sR0v5qvFlNpxFTIuzOHnSgpSJ0jE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FcV2RV3EVQtSEU34UjdREV8op/PTfHX73vMx+Tq4FYm/8BgT0TIkhagI7fZsm7qFv9NXyxLxcX9lnlo2MMhSYrpPb2G9/h+4QGeivlBk31sc0TsCRBWNKhi786kAKxBP0Iqk8M6XpbLzkDsnpCulq6emB0iRaVLQZ67PjZ3G+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGWT1MM0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGWT1MM0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85807671b1so124156a12.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538554; x=1781143354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhsS4g2OlkS1/KJbrnXrgNUTVZ9kOb2Vmfr1lJZkXHU=;
        b=FGWT1MM0FW7qfgv/GgnAdPWtSMOKvgYQ7C7B2qsxBbA7RL94GyGWBLrLHFX8DUMPkD
         HKFZOP/67hK0HfSrn43LwYqjP9l4pbe2UW0Di+JWOsWVVOFKFk32dACbxEkswJ9YuFu+
         6TKjeuPpX6kWQsT9tpNDeMj2R5iaitxninlgCeQTgRsbBeh1lDQ8a5K2omDiTNSDrjLG
         qF7+vu7o0lllHSAG15adXuKpFAxjPYEbL+VwFJB9OORWKF/Dy8wEXoTN5Mp1SpAXDoFM
         9/Urvy4RuYkqcSMzG1fHoxuxsYKgB9iY98wjGFmIL5puwV1wPVCuh/Lxsrk/2e2qo8k0
         CsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538554; x=1781143354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhsS4g2OlkS1/KJbrnXrgNUTVZ9kOb2Vmfr1lJZkXHU=;
        b=q9NXjK/gQEh4AjesV3rCcxHqFlG75ydA9MCnoLsugk+ZDnu20lAKQdVwXkNmrqAITA
         3P9af1Qbgj65N1v++htIXguBfTsyWxi4ENC6hd8qW8Cd8SNqwQH/m9tTd1Ln2IhyD+ZM
         qhKPzwMWu6EVnWJzIVgiJGd2aiuiDq0PH9X+Qd/WdFxbSvzmdm0kBjyzBBoij5WLHCg8
         DcQBQRmF29UwFcLGmZd9Q3DAx6kz5+WvlKByXhsK52OL7zXOw4aWF9OwTFKTV5QxC8FQ
         /GjLY9IN69kUaWq+VgEJUGAPYpOF+Oxfou/nzclopNj/4Ezi9P7VHyaO5Dod4NzIwJiI
         58Jg==
X-Gm-Message-State: AOJu0Yxm36xie9W1MPK7p5uDfr0akFtqH/4S33VkwEL8HVTXHs82S/vh
	c5tkLtTtYzrRY89gvK+xq8JaHDLumuNO5W9laDTyBhChc35Ea/MKaTS+Non3TFSMMBveDOII3cT
	tkeuO3zbw
X-Received: from pgc24.prod.google.com ([2002:a05:6a02:2f98:b0:c80:192c:51ff])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:228c:b0:3b3:62be:3584
 with SMTP id adf61e73a8af0-3b4977ff27emr6352035637.11.1780538554256; Wed, 03
 Jun 2026 19:02:34 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:26 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-5-jrhilke@google.com>
Subject: [PATCH v5 04/21] KVM: selftests: Add helper to generate random u64 in
 range [min,max]
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
2.54.0.1032.g2f8565e1d1-goog


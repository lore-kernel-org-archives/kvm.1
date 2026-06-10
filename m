Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D741F91D6
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052831; cv=none; b=Gz/syrAeAy/QmVkyBoN7D05dRfhVIUQ1AIvOAjjwRSk1+J3Sk3ksaBatDvFe71p+DuWE0xbyoyBymEnX+CigPuLVUVNsSC+zcLhkteNxsUHABEWUFz6VXvw2kfkDRCj+wQvokLy+rV0asASJZ/V1b93QPzVcJkDdFl2Y09Ar3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052831; c=relaxed/simple;
	bh=vIl+HWefkeqsv1qtuVtCcBVofBdfj9obESA6FgCgLp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HJn91W7ddrCIFVDgaYBAkTafZIYJWXMJeh9c5h6dcjAovi0x/GFY+GFFlmkt4j4zct1QV9L7GkY+8Y1F2UAT3tT1VGk1Pi5I6PEznt7aSuBYJyoZ/RqWIGIYwHZ+XPtLacy2eQ5LSBx4GUELf7McIxww8VxFStQbDmvjLREWVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+Sk0aaP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+Sk0aaP"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85dc345ac8so3076452a12.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052827; x=1781657627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8NGdw5RJ6bJAu+NqY9JKZh9Q+XXOC2uDO6XCtjvqorw=;
        b=L+Sk0aaPcgzNwZK6SXQ0EuPHiAGYHDVreLjDsb41JIuqi60SCm4ejLy8Q/1ZGBZ8PY
         32JkRSxwyTFfPAyoB9rgRPMZbixfbORgddOZ4go5GQfXCJPD193r8V6Zk7UQY2CgkVrR
         gfF0Gn7GKctU6iaKSQpUtHYzxyJ8UoYpsDRnnIPwPg7TlHyzqxCzAEwzuWTrORACqSMZ
         PM/XO50ey6TxGhGQqO6rqQC0IZKu0WKBgZbs4CiR78xi7Yu0mY52v28B8k+OjZ6QUAny
         vFwmu6Kk7B06YOzgxwaLVER/v97Cpc2wsDSEaDvTJb0TXnH/m+RCnG6HmYqQpat9PHkF
         4KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052827; x=1781657627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NGdw5RJ6bJAu+NqY9JKZh9Q+XXOC2uDO6XCtjvqorw=;
        b=h0DX/DDjZd9l68N7lW3NEkY8yReTOSb6h5ci5YN6NC+okVplXsC0mtlUuGUxfwrFY2
         NW/zGSoGuGRvI0LAWSA2WuoFMdauiJQPAbLMkNLi1kwL8QO0pJHv/p4zal7v6vx8UZNn
         mv+vdJwSdMh2sp2mWv7nF71gd0m8Z6eCzaX9oQoITacFMi44tf8L6nh6LvQaFgSMvWRN
         Hsnb2cZoHrKcwOv4vVikB7udPE+XGye3Udpy0xscym4BwaZRr7isu0ZLYLQTQAuYLJMp
         SE+XrtJe2Qf1wFFVhJkc+xFoCt+Aqsqsa8LdYJvFMCF0joLCnfcdmwH187NVs8Q01oAv
         lQ1A==
X-Forwarded-Encrypted: i=1; AFNElJ9LLg9Hmiv5ic28pp2PW2DETDgxqPi0isFCHdSWvq0PMJZ7IFFwZUkPHnoA5ZmZ5hK6ln8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAuo4kuNhsRlDF653G2Vlkc+elXyx8L3P37u/YJczVp5PoPTM
	P3nlyaf2Yi6VYbaRGqCqowNd12iZAUsyfH1cwOJ3Yl4xv2gnttqk2LiCLvxR9KTHQsG1w0CpjbN
	Pj+nZmQ==
X-Received: from pfbhk10.prod.google.com ([2002:a05:6a00:878a:b0:842:723a:7919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2351:b0:842:569d:b105
 with SMTP id d2e1a72fcca58-842b0f8bd8bmr25284333b3a.34.1781052826595; Tue, 09
 Jun 2026 17:53:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:24 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-5-seanjc@google.com>
Subject: [PATCH v6 04/18] KVM: selftests: Add helper to generate random u64 in
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
2.54.0.1099.g489fc7bff1-goog


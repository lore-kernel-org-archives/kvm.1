Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491222;
	b=tCvp6oh4ZtcGv94uT4+yT0Ot8VA5M319JSGbv3UwTPxD9lBARD/MXtBVDE8sNT8B+VvP
	 QeHKkVBYBmuU0nCaUVZro7ALYpCSiYFotXP40k0D83WWmR/qiJZ/elrzwEcBNQqx65msT
	 KtSIdjWffjvql6lE0SL/pl+3MNH78AXrC3pIInLukf5kz421KwZQV25QwoZUMajhJX21q
	 YfadnkOuVs4QhwCgcuZaxPuFSXSazTtOO67aVKbjYTLXh3SlcQwcPisl3xel75FM9f0iH
	 tVb72C3JCk2W20slvWCg4yPYzTkyUaE/rCSjv7pxNUkHXCju0oKwRtBytwJYi95b0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lP3ch59NAPtwcIuspqlGBS3z7FlOBtLkp+myFltPlfI=;
	b=xi3P4kDJyYhOGRD/7tZBGeK4DvHkfzsIMU3eXgKXemGf2LT44xIXkLbT0tS10eST5uQN
	 Lf4AVDzbUcX2PQFAwTs2/MHU5GJPkFyJp5fjffN5xfHThZULTpCWBmhgpD4qI/uzgUSoZ
	 n2PYsB0d1vlK/JTJwcved8nl/r5rOvm/NvaoSxKeZYLGbQe6XZtIRWbwaT0R8cR54isUf
	 smEQ9xwJeYw8n0AxWaEDEGJPNUs8ae3/o6cgNRKUFqfdkIvYdVM2q8qHeMx/VtO8j1yxB
	 oc+VOLF7vCrr0RbAkkg4fxVze1XuWFsJrfrmif9izz4tdCHH36smtG+Pp7xBWDUak5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g9qMj1DA;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B24606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B24606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g9qMj1DA
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b14c80b210so913053a91.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491222; x=1796096022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lP3ch59NAPtwcIuspqlGBS3z7FlOBtLkp+myFltPlfI=;
        b=g9qMj1DAfbSgv7PoH2K/ov7yLNupPTQrt80IYN2IyGMQKt/62HIN8JUH2r6VxjqVjc
         wBdYQZv0nmz7dkzwhKZ/9aJxi0tucck3CQoH9+uR5crt/CJCZ0e2HvFaxk4FRtoZ9P8M
         X+AcoYaqkNKLpD23XqRkpwtkDp1wWAIgBnfrvbbfiWoUQVKbV7YZ0AmuUCdsT1BrCxKf
         KJs7Vrmg4n3r4eaujkRyJAWqs8Ci7ZjkvEQoLhxBly9Ft7fcqRtFlAthjSyY/kGr6pwC
         ipqGX6vH3amwTQzkqmBbgZF500997lie+Cw/g+XnctUUHvOtRrqYgC55hm9xyE7eFxTl
         kkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491222; x=1796096022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lP3ch59NAPtwcIuspqlGBS3z7FlOBtLkp+myFltPlfI=;
        b=EzxHgCiLkLoYXdSOI6/czvr9aCk+56NTpshDWEfgb7y6GqvDzbBRvRHK5LLTVkylkT
         fR3X+2LjsyKAKuvHnx8Ak/fCZW0ji9oOA3r8Q7qByjMmB8vXmIyISvFdzA4dXMDmSEzx
         vJO5tXC4FoUSaQdckuYAKWHvmliR02Z5hCucoZv5XGmCfZRmPJuvVZnruJSW+ZNMTdTM
         XylXUT0IO38Rq5wrbRq8zFOBm3++cl3ktPRWCjYwFcmxVKYvE16CoZFF8Cmfx9s9ar9Z
         bhh1gXY2u4GoG0uce6mnyuvJTKgmwKc2jWiTQfjgcDx9yEayWRVjQRRx8muUywhbflTF
         aDIw==
X-Forwarded-Encrypted: i=1; AL+hErFi6CF7VvtgA8XE3Y5oewrgvhDcRQQ6BZvflqe/bEmZngi3x3GIN0Adn9C1FEk/tzQ5SUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uhN4Q/Ar4m1itpb8yPwari7ORpk42uIFllQbgFY6H5vGUZOIO
	nXNKT5yTqv1jnYWZsGleopVuie+i5ik40yljug9jWDCQSoKc4Gz6xKBi
X-Gm-Gg: AZFdTZfyGWZTzGf0Hl9KvpH9NAxIeqZOCF9CdWqc0RgxVNDwU9LAFzMzLIACG9OyOYc
	lpoqX7YV1UemNQFikWgtnbOZmg41Z+K24qFuBxe6l0l6d3GkktLueyvKBFj0qx/kOYEmTIw8EgM
	Q5rM+2UYEN9zO3eMztXXnHUtyx+J3sgKfNcSbhJg2AUx0NE0Dev8s5GlwqFhC3JPyWFEIItiJln
	G+8PogDmt6K7zO2W4JGXrHtZsO6BQ6sW8xT1cUK6k1M1HserU+xdgKJdUdnrmQIuHulzHXE3csY
	ZJxMO+/NH3CRhCtihaWP1LbtEXhifWxVJm6O79EdGMcAYq/Inn0AzGUn+kKrjnivtmOUcTO9EZT
	eRBbvDsUQd8i3LoFW8d17Fqr9YALd60CxwpVPKujYxWisB4nW5dgJ87Wtqs1tJx3RhZ5+1IYv+s
	Z+DNx8GPcf1GLec+sF00Z40hFwP1t6UUEZAaLhS6ZTA7zqkgXR4qxmHABu6Ma9Gf1/aJvG1h1MX
	NCBq3AFW6n09rFij/i+CTwuxvQ6gv5jPznoOREkExD7dbcSjZ2I/sIcGHCIgW5md2I6tk2hVQK2
	hqR7yEYVg8L+EPWfnm0gtdENPTfT/0V8tZXWFUczQA==
X-Received: by 2002:a05:6a20:7489:b0:3f9:a6b6:e16b with SMTP id adf61e73a8af0-4014c94a618mr11685070637.21.1795491221907;
        Mon, 23 Nov 2026 19:33:41 -0800 (PST)
Received: from q-Legion-Y7000-IRX9.. ([223.86.210.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm6495773b3a.3.2026.11.23.19.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:33:41 -0800 (PST)
From: Bingyu Xian <shanbeeyoo@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: selftests: Fail explicitly when schedstat cannot be read
Date: Tue, 24 Nov 2026 11:33:27 +0800
Message-Id: <20261124033328.612894-2-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124033328.612894-1-shanbeeyoo@gmail.com>
References: <20261124033328.612894-1-shanbeeyoo@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_run_delay() currently passes a failed fopen() result directly to
fscanf(), and substitutes MIN_RUN_DELAY_NS when parsing fails. Steal-time
checks need real scheduling delay measurements, so neither dereferencing a
null stream nor returning a fabricated constant is suitable; repeated parse
failures also cause polling loops to spin indefinitely.

Assert that opening /proc/<tid>/schedstat and parsing both fields succeed.

Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>
---
 tools/testing/selftests/kvm/lib/test_util.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index f5f7189f9..eccb03153 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -417,13 +417,14 @@ long get_run_delay(void)
 	char path[64];
 	long val[2];
 	FILE *fp;
+	int ret;
 
 	sprintf(path, "/proc/%ld/schedstat", (long)kvm_gettid());
 	fp = fopen(path, "r");
-	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
-	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) < 2)
-		val[1] = MIN_RUN_DELAY_NS;
+	TEST_ASSERT(fp, "Failed to open %s: %s", path, strerror(errno));
+	ret = fscanf(fp, "%ld %ld ", &val[0], &val[1]);
 	fclose(fp);
+	TEST_ASSERT(ret == 2, "Failed to parse run delay from %s", path);
 
 	return val[1];
 }
-- 
2.34.1


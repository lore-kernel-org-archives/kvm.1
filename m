Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768303921D5
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102166; cv=none; b=WtHJWETcWT7ggrlPf3y3YFfKFXJkMG3FQ9i7OJ5S2Y22WJSMNeDe6cn5NYwVgfmaEFde33zQIpuDk2U3AsSrRRn8IzYb1/ceCfQzFH8anWXLt+onXnjC5H8imsmYGFoE0t+UE2Zg32QRz3wNHDKdCE36tsL0UIZKWjdxDcloo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102166; c=relaxed/simple;
	bh=+bL8Rk6CStx8UbXDkUw/Qh7xUt1BHtB/vXrgsnDtA68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BnLIZa6Zt8j72CIvqhqbKHP8Jt9VvArkKI8K553buZrgvpsigVkV7bQoUNzDHUfLz5jpWIGIV/tD4r65ZB2jmvulk5/BnlJxgO+p1B61TnT+GR0LD7Hzdmkc3sK3hNVYjksH7/vbclkKyPbuzhtU13JGEIVxO2GhhK31LRm5K/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgZzFnQp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgZzFnQp"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3d66515so639175a91.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 21:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102165; x=1789706965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=mgZzFnQp2xexFiLdfJGHlJwd5BFV4ujejGlmosBsib43JyJClSgT3raon98gYfYYi9
         0hO//28K2PLjFw8RTb2G2B+OBodvnDMNWCRyfG2QSap6nlVA7vTPum7FPNu0NqFo9fV7
         Uui3JcTny+k8upC94lgB5/LbKhQb183aeaUFP69wLHKkHc2VdGplDrjsbnDUoGSAAhhr
         vfbt1f8xh3OTQE4f0UyxcUndUjPq/xVb8x7uHNN1Ci7S2OnVTWZ0bc7TeZUnwurKSIQu
         njlSG1RQ75ApmYj1s3WzTFSXIZdaWc4UOLEJTmun61Ng9/3PzrRmMPZrdOyPZNlTMlu9
         mTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102165; x=1789706965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4tObarZqWzLfPDYSwGxwQwAXuFMWWhRAhqBOMQynsA=;
        b=SwP00H3rg+MPCsRzG0Z0oRT53K6cpDEynGcfX78O19m/ukjpfV2rzsrJ7/1TGBGbBT
         1MubFynvtNF2oLS1FuDKahc9t6t5LjWenqFN/1FSU+V2CqIRR3jifpSAOVPTcVJwMuwj
         qKHwLPnNN6M5bu59+UoKUKwkpLDrFZgsK4g1xNLnTa1QuLDJtTyi42YF8eej9zctWkQn
         UFe+aNqhEQ4qdkx5hLCcWvvhBnzE7dH1xEGMiAM8kUSBMx7SQF61y0fHNXpLqEUwAliU
         cIewOk8zGUfhMsb6FoUuEhkBE7ORnqIYY1Ji5O3Rd0JwuK4eOvpTXKWgJ3NuT46lpsla
         1cXw==
X-Gm-Message-State: AFuF++nvcmVTw8CCEYtWW5eqNoej4w13Tm+erBpWSyW+cILEK3k0pXZD
	T8/f/xzbrWyZ+SkaimduFiAHzfM/sO0m1O35qTbT3wICOuxMaCjxpgu7RM4Qhdsl
X-Gm-Gg: AYBFou2+xJ9TnEEYyA/4duRiwOBbjhcX1ytXNHU6mHcMxCMRFS1hBOj+L/wErruV/wg
	9M3qInPQ9cV47jdkneYErbj9imLDHSc2jo0k8bzAgZuVuqDTgNkxeKVgtwIQuTuEroO2lLpdyY4
	jO6dKC62GxPiq37LYD7wregvq4M1XeRfNTXfZVRFflTCHcsffPckIAXuxRIzDY8QCx87vw1A8oD
	8s2VIL/8dEMc0Qu2JUKsVlFKhkHDAQVw9a8c2A2/vyZULAFziyA9e9mRAoYMSZheTdv6hNYGbAI
	FhHo7NcMH8AIFZItsD5GBpJMXrEwX3KEykSNCPMFyB6b/usNi5LrY5c0a77dkBxVOxejaaSisKy
	u+Sz+g9bSUtpMOn2HOzj3En3jQlgserCUzwqt/ZJL83Cd95n4h1uy9Ol+hxRvq+K1mpp6X1rEPB
	xNyWsWZK26a8TFWzB1fquYmMv1A0YqZNKJV+BIcyHu2QE+hHWMpqLDthkmN4rcRkWZ6uIxiJ2R9
	XU9zyq2Wq/eTzmnSBsFdXWF4OELWkIo7fwV0VOn0fxzCw6As0wYke5h6mfVt1I=
X-Received: by 2002:a17:90b:384c:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39d9bed82a2mr3634401a91.11.1789102164649;
        Thu, 10 Sep 2026 21:49:24 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm2883077eec.22.2026.09.10.21.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:49:24 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 3/3] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Fri, 11 Sep 2026 10:18:54 +0530
Message-Id: <98cc49bb43ebc45c14cdfd596a4e64b07d2e1f08.1789097569.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789097569.git.ritesh.list@gmail.com>
References: <cover.1789097569.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dirty_log_test already has BITOP_LE_SWIZZLE helpers, but they were
compiled in only for s390x, so every other big-endian host used native
test_bit().

The test fails on big-endian powerpc because it treated dirty host pages
as clean (because of the endianness issue)

w/o the fix the test fails with:
  Clear page 1 value (1) >= iteration (1)

Fixes: a049a377164c ("KVM: selftests: Enable dirty_log_test on s390x")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..8189eaac713c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -44,8 +44,11 @@
 #define TEST_MIN_WRITES_PER_ITERATION	0x100

 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
-#if defined(__s390x__)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+#else
+# define BITOP_LE_SWIZZLE	0
+#endif
 # define test_bit_le(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __set_bit_le(nr, addr) \
@@ -56,13 +59,6 @@
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
-#else
-# define test_bit_le			test_bit
-# define __set_bit_le			__set_bit
-# define __clear_bit_le			__clear_bit
-# define __test_and_set_bit_le		__test_and_set_bit
-# define __test_and_clear_bit_le	__test_and_clear_bit
-#endif

 #define TEST_DIRTY_RING_COUNT		65536

--
2.39.5


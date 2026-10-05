Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE912F7EF1
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172090; cv=none; b=XrAIJXVgc3hjAhNoYQvMI5sLzjQqKfcd/30EnWJmCJvvrrYkKV5G7xFl5sttiD4cENlK2KTzYYPTMPglADvqb5DCK5H813ilEaIb32oYrVKpTDRUAVARWNt60v5r5TYNRc5FCBlXQS8tCnFqqiiAbZgw1uap5UaXxE9d0hWUdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172090; c=relaxed/simple;
	bh=r5A4UZPux5Y3nKltnaBqnFx1Wecjg4H7ieud878T3Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcas2B190yTqREGc4lPXFe/HUQ4VMW6tX4uA3DZPV8OZXaHMdC8cEDRz/fL/50IGdtUA3GqS8D0p7LPxVfYNVujzD3fKhIunU58YOKa1eekIKthGjeCER3P9Q6RjgTipC7emF+tBN6XwDnkzdaFy1uq/wDESZmk9QyUXjgWVcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6zsiM+M; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6zsiM+M"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3512f0ac09bso407652eec.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172088; x=1791776888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=We84JRc/bHqMhmFuiHMoH3sRnXvkHgWbYpO/4GVf6wY=;
        b=d6zsiM+M857v2SPpIeD95uGfCMYk/ib84cNTJyb/OlhOAU7p7E5W5dUCGP4z1j4X8i
         RnNrJUGDIdzkcdsIHL61H9j7xw2v/cekCsl36asU793f69Sl0uVFmJB46EAwxspefM5c
         cQTMXC5a0BEpXXhfm/VZM9hKZPLJhPnxezOC0Jk1YIErJ51PPM3uSgSMoKfWMoWE6lgb
         uSXeklr1J6Gg6rTN0XeT99a16t23gIgEn78rYcsJh4hzEbOydu07rtKCKVwFLa4hSQ0J
         gY14zSVVD/KVSIDcGolys6OpRMZh1yqsL08G8Uc+8As4LIeS1wTA4h3KE7gNC0BfB6tM
         CFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172088; x=1791776888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=We84JRc/bHqMhmFuiHMoH3sRnXvkHgWbYpO/4GVf6wY=;
        b=QOJfVy2U6wx/npbyAcOtJ/XPqEDplAQEl8eWBowOq/oaIVSrZpW2p14lJqMRo9ecPn
         y9eDfW5+u00Zjx4fM8llxpvF3u+iOIhyqN9evsnlZNp1wYRL6KEHSJfsSKIan5gQ7QCZ
         WuqpHGPvSOaB0TRV+4N0URy1cxNxV+Ei/+XMZgZHiB3RHVABW8dOQUCtdSBuasqvFvTg
         BTcfFnyd1jFa3HFfSl9LjT4qy2uirIai12GXn1bEBWak381ULdhHnFQ2DaKkjXqCb3MY
         35KM6Hcq4iQ4/CiJOcj6kJbm4zv69uhNqsOi5fC3CS0qTB8ZITMgPpOUg+ISeolopMKo
         VBEw==
X-Gm-Message-State: AFq9FYI3MYh2XkLO9tBfn+p982QvXcLJLNWG7eG5aztZL+Mvn3yoH0cV
	qqmShmqrqs1VA31vCTS6ui7ZFpbC5t18n6MkKPcgwz5+oCrYavF2qJ0zcg7+Lw==
X-Gm-Gg: AYBFou29hm6zVEzUfmcxfRqY4fXl3p1jw/hy8/PrA4wCj7E+YS/5xmUiko7acez7Z2t
	T60b4GaUfRfsGuNbcJFa4QF6aWKiOgi5acJoudSBgedoNmEK82Ezlg/m+qk3bG2Mnkam7bPphGu
	jpgkI/IPK2mhFGN0gyLg8Z5X7MPVtmkuIuiJWs2/uI4Lm9DOrMRL8tazimbEEFO/SKDvL8At8Z+
	5KZxsDNaOwMjLhfw5nFHRunY9Q6Rpe1I2k9Dbl8tQV1qUlsHs5a+ZLEaV//7HQo5K+IqJCgb9dI
	6XLEmowjswMxUDXm7JlEQzSX7mYDzAqxvydHC1EVNZ1N7S1G4uJjI3jCsfOqWzSCNBfgBbI2J03
	Lf90fF2gn8C3SZb3bpjp/1F5aQA8oOd4Gt+dcq0Fl+i68/5eIaGxqYj6gxWuy8qLX7EsyvrKuCd
	iG49sveROySYyHUZzWM1cycSwkYJX1L2/umIMIl+pwbmXoB7B1BDl5WxU3o9LYeeaJ8SC1uE05f
	5SZ3KzB/xvnwwMfaQTAhjGEn1KA/AamOlwG7BxKd5kVj27mjVrXBmnzkdMi
X-Received: by 2002:a05:7301:707:b0:34a:e4f6:4a4b with SMTP id 5a478bee46e88-34f150c3c64mr10761322eec.21.1791172087608;
        Sun, 04 Oct 2026 20:48:07 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:48:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v6 5/5] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Mon,  5 Oct 2026 09:17:28 +0530
Message-Id: <0c3cf7d492acb9da38bcdd0331cb69929c947c30.1791014924.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791014923.git.ritesh.list@gmail.com>
References: <cover.1791014923.git.ritesh.list@gmail.com>
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

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm     |  1 +
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 57d1bf994fe8..38c350c5b5e3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -264,6 +264,7 @@ TEST_GEN_PROGS_powerpc += set_memory_region_test
 TEST_GEN_PROGS_powerpc += memslot_modification_stress_test
 TEST_GEN_PROGS_powerpc += memslot_perf_test
 TEST_GEN_PROGS_powerpc += access_tracking_perf_test
+TEST_GEN_PROGS_powerpc += dirty_log_test

 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
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


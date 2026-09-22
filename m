Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D94A2A5A
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101803; cv=none; b=Y+nY0b3+MgAMA/U27z2NtS7Xny7HIgpzKzABwb/fRenTwucJ5VwWd+YfTbIGGGP8a/9eBsWxgdgJirQvCGKFWq/25gtPaRr6nHgneuypxUBQ+qfbOBxfcC8ntijsmzMx/WSZraOsD91nDiOraQe3AOq3AUiOh2WU0k7r2zZxm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101803; c=relaxed/simple;
	bh=8jJqCGT0V05E31kT2F6hUmHDlVoJbvkdMk/x5qNavzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHIDNPwjO2COlh1BrJZRDVaGwJwTI1xk28asnrLNmZIy2f6sRgSHHTsGtVoB9iZkKG3U+BY/qyR/3E1QeTyRq86SxlR1r91M9Fhm3YTmB/mq25kYFPtBGP/TVp8yQZ6NJV6LgQ4puhuQDOGg9n2bEomY2oX4nWInu5+QQyUpz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLm92UZ2; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLm92UZ2"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso114881eec.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101801; x=1790706601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuPCkW/LjqBFJWCaN7Uxk8wfBxmnjaxJZXL9hcftaP0=;
        b=eLm92UZ2QC1i3OGXgsFe2eRU8bb/ii4HwTMxQubjqfOLdJOoMxBx9OH8fpK6aXvjtQ
         8J/AXxBYk9Xv2+366fTtiJUEUupTBwd+WJ8b908+KGfduJCtddm6RCU7be0tW/szqv8p
         invRsdwyteWLW+2HhSa1NeVFwmKzD/oW1D0bpUKUctoHqiehPlPa0O+UYuLOCjk4QUDo
         zvIcI3RkJ6ex3Wn/R+pD4sPNLz/lVXR4XfUmc5ViBnV6OKR7hlDd6QwEuopLimAL5YN2
         Arg+cKDrV2ouoTrEjaBy+DC0nIe/o9lHCk4ndbRXbJHuTnevWUK6/+wuqZcxKVgvJoHx
         Es7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101801; x=1790706601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RuPCkW/LjqBFJWCaN7Uxk8wfBxmnjaxJZXL9hcftaP0=;
        b=J1TWx19sAdHrLunN0VHwLPqOhGtidimBtU9NOAc0xEL/LgprNPolAa4YuuxGX9UTx9
         ff4KvMZQ5rXwtMdBOi6vDDArzqYRnxRXnT4EZt0kSfZ9R6OUVMhACQzxOjKwkvKMqzY/
         eo1Vcshx+cQpXZYNstJ6y0kt4rch8X3t4H6DOKCSucfQrMXtQeCbDYd0Le+xrk033DMN
         hHeQCto5KJN446UyIZizgYMFEv7dsB7JtI2vgphHbRg7jiv6CgvOMTSeQzEonaGhVkos
         OdGVjU71gxNvD61Nh9D3RfIhGm2kzHVXrFGjFgqJReVIVf0d7eC0eqr4/ziMN9sK6FvC
         /bEA==
X-Gm-Message-State: AFuF++lYPJKDBBWArxeYeqYzggiSNOAdYgwtOqTt4YJa8Slt5PhcXqW2
	e9ZI+0GE7nXsXsvYLJaBzRZD88Exo1b0Mdk8DJrC9ZSYKh6hlirT41LQVVCGRQ==
X-Gm-Gg: AYBFou2C/kcTdPxVPWFiH74789s/ZI+GP8bhdJ0sb0gDeFewypWj43wBR0eBoOLYdWc
	nwlWSFG73+xJdWZ+RjBVX0tCt10ha3NzNTmeyx3/4EZNeYP8sfgsZA9n7uH+CxPuRbI3yAjs1sZ
	FJ9YNXcAbesxlH6obnZQEBJh2iQWwbSO6fHbdJltbQ0nCVAZleLlcEtSDvBfNFbOBOTedrEb5wI
	krDGIYVUCpXCF0PN9FkCAvfuWAla8YLsruOpjYLuMpdGYrI/mmAbmm30xuBWdjp37E6wEO4Qhe1
	5hmIMaHARxfTdEyjsSJHHmkCtY8R0shDzo5MXhWQJcFjYzhnLsUkAjguOVAUPwFEvOULUURcq2i
	l4ekW48X6W4CSTrFCpgWdYvzqtoswpPDThAjlHlJXb2vZa5Pb+zYFgDsNTEr1mJn2/HX/bUE7SW
	CrhRTxu3JWG+FSKUOtW/RegFCKWzMBPuP24YX3pvRpqFOMd0RucZU7gpaJZ1USzkGmVxhRUQD6a
	V6/mwewdQBaPw/QC+k3mXmu+/l0JwmZ6f7SO9AdCbRtZ4znhy0kuQFCWqW9zw==
X-Received: by 2002:a05:7300:fc01:b0:33b:f062:a654 with SMTP id 5a478bee46e88-33e9548f062mr53363eec.16.1790101801265;
        Tue, 22 Sep 2026 11:30:01 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:30:00 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v5 9/9] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
Date: Tue, 22 Sep 2026 23:58:53 +0530
Message-Id: <55452f6b9bd1dc241d0a9a0781fbda1c2850d2ce.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM selftests are built with -fno-PIE/-no-pie so the binary uses fixed
load addresses.
On powerpc64, GNU ld default links at 0x10000000 (256M) which is also
the MEM_GPA, so the identity map trips with the error:
  PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f

Put the test slots at 512M instead which is past the ELF.
e.g. failure w/o this fix:

./memslot_perf_test -s 514
Random seed: 0x423558ef
Testing map performance with 1 runs, 5 seconds each

==== Test Assertion Failure ====
  lib/powerpc/processor.c:235: !pte
  pid=371 tid=371 errno=2 - No such file or directory
     1  0x0000000010018293: virt_arch_pg_map at processor.c:235
     2  0x0000000010008b3f: virt_pg_map at kvm_util.h:1325
     3   (inlined by) virt_map at kvm_util.c:1571
     4  0x0000000010001cab: prepare_vm at memslot_perf_test.c:353
     5   (inlined by) test_execute at memslot_perf_test.c:816
     6   (inlined by) test_loop at memslot_perf_test.c:1062
     7   (inlined by) main at memslot_perf_test.c:1136
     8  0x000000001001d713: __libc_start_call_main at libc-start.o:?
     9  0x000000001001db47: __libc_start_main_impl at ??:?
  PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 844ea9b7bb41..2913a4de4cc9 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -30,7 +30,7 @@
 #define MEM_EXTRA_SIZE		SZ_64K

 #define MEM_SIZE		(SZ_512M + MEM_EXTRA_SIZE)
-#define MEM_GPA			SZ_256M
+#define MEM_GPA			SZ_512M
 #define MEM_AUX_GPA		MEM_GPA
 #define MEM_SYNC_GPA		MEM_AUX_GPA
 #define MEM_TEST_GPA		(MEM_AUX_GPA + MEM_EXTRA_SIZE)
--
2.39.5


Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0752EF653
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172075; cv=none; b=r2nT1GuDBKAwkoChWt0Q586F6dpph89pAdjS5QiDij+Gtd1YqouXa8NPkdaNhvuCXhd117bcPwY/0aFoa58sduB+hvBAvCs79Sv4gBAebOAQbpPMzw0TsE+aWj9y3FIWTUHnSUDlmL/ticNY7DJnEVviAT39Gr33qVlTZWWwb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172075; c=relaxed/simple;
	bh=aSYMiDeMVCO2ZMsNHwEco+yPzqo0ags0E7+MGXeO88U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esoLt11CTIt5y9Z9Wc0ltEEpeojcYKHEHtf5pib+n0qkkAuPsRfIJwzyte46Bef+2FfK1YK4KNlgxZbAc+Sy+oSXcY9nTCQIYe75W0saEC5ELNj3L0RzFG8Hx5d5mahts26sK8om7eCM5RHbo/7P6EINK9gRXkOQSTr3bkjOg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsbebVgl; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsbebVgl"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3512f0ac09bso407506eec.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172072; x=1791776872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuztXYMaK66Ygvug6vAZf8NRi0Rh3rDwmnl655YdZxI=;
        b=KsbebVglCkHCEfzL/nl32Uf3RA1BpM7DP28vP9i2wuh8CU+qgiXjebHQxjlGXXkHtK
         S6TFtn5fAtpIW7n1mw6djITQ2o+r8L4b0Ov3YUpV7ygghXyu0OMawdKIqMc+3opJf6zF
         9QIVAHwglaYURkC4dbx2BCbu+smIiet+3f/JXMhoKewoNe5ckr2XZl+saKM5y26JN68M
         H1D9lnPpQn9aZlg8HgRqoerSgf/qqyt244ZqT3EUapXsWJ1ULWDWFQTW+B5yBhPiHDNn
         myWXIdwCS+qF1j6ZJqrxUjhhgxajgxr+LWB706nV07ODURNyJ43yrkBxLLnuEMTsQRon
         EQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172072; x=1791776872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuztXYMaK66Ygvug6vAZf8NRi0Rh3rDwmnl655YdZxI=;
        b=cC34lFU8aX0WB5r5gO40hujUIBQ5fWKuyaAlFQmeoIGV6d2vuvMEh2Y8Vb4CW6Impi
         ofpIargiV7SezsOw+b0K6t4LXwDUhjf5YJw24w04pKerqkOmJRsum/ebdPC2K6JBy/fK
         zqHIUQuE5cHlRESdiU/wPl9lLqRfcq4c+KDbzx4SXm06JPmfeFV2clmrZqTR47YtuMEk
         8m27fSbuYc5fyFxueS+67OorRD9SASzVXCJOs06m4ybbmPq0pdG1lG1dlR90inN8Iu6v
         rvQQ1I0VKHE3WwFQVuJIpYJG5Q8vZHSs0C1vYCiJo0bVygYdESf7BkNnEO7O+C9TmIeB
         pwNg==
X-Gm-Message-State: AFuF++n8fUJI0ye46Ns6sGIJq6cpD8ixIKfMN8RAUFun8zmCHZ7cJDcJ
	LkHaPDkZxBmT1hPmX3jotozZ+1/jEaZNapcGIdfgXlX8kQinx3Tf5svw+HXwIQ==
X-Gm-Gg: AYBFou1nRD9AKXixygcbsZidEKf7hl/9rukhTBuTxAsx9ormjMF4EJrkYlol0uvgVU5
	FBTXmiehItVz/gfclZn6gP2AZ6keWvOJuAFoHxQ8lFEIZ+yfnOM3zHLS7F13iPCMj0SktkPx5RD
	cPZcDBzejBwuSyIiOHP6Z24w9Zhq6zkIsXT1IuMDYHXg1f7ph//x22lTkuY73kADOVfyajpM8bN
	I58H9Npl5KbUlwVV7eNfOsV9G+ua6DLp3Ew4B2gsWRg4L4YLZeMe4jCEu14tgJh0JSdstwNQcbj
	yowmK+SXzspmQE01OcArohq2nRBz3+KZ3T9ubT+sglN3vwZmM2khM5aFguY6s+lvssDsNp1RI6v
	obNzgyGTlfkrlYkJDxC4OhEwYquCvPq/4PeCj++u5J2JamsRWIKD+d186uqrOdzcQHN8zTR2stO
	TLu9e3q9JVa5zvkhcXEFNsOHfWS7McnMlHV92uTNdU1SlKBjWN7741ZFPq0Vz7rl3OUcyhf0Qkg
	9a6lpiKO4lILC/y2e7zG5icvTmvRp1T+Xmmj6JmY/v7Acrj5f7vFVKVPCdW
X-Received: by 2002:a05:693c:829b:10b0:351:1251:dada with SMTP id 5a478bee46e88-3511251dc63mr9052789eec.33.1791172072369;
        Sun, 04 Oct 2026 20:47:52 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:47:51 -0700 (PDT)
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
Subject: [PATCH v6 2/5] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
Date: Mon,  5 Oct 2026 09:17:25 +0530
Message-Id: <2affbc2727a4fdae1d187dada40a26e0ab581c4a.1791014924.git.ritesh.list@gmail.com>
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

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm        | 1 +
 tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6e672484a22f..a7ecd7a242a9 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -262,6 +262,7 @@ TEST_GEN_PROGS_powerpc += kvm_binary_stats_test
 TEST_GEN_PROGS_powerpc += kvm_page_table_test
 TEST_GEN_PROGS_powerpc += set_memory_region_test
 TEST_GEN_PROGS_powerpc += memslot_modification_stress_test
+TEST_GEN_PROGS_powerpc += memslot_perf_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0239A048;
	Mon, 29 Jun 2026 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758281; cv=none; b=Z70DNnn29D+KSkPEy+3walNHY+oL6JuuvRX+Y0wRqHDB//hiBTQ6thO2pAY1oT6DxEmPQYlgfwTrex7VoC+dkfxzm/Je/sx3+gZPRjG8bmIbLB+T6HhQZ8KitNQ+77WCNN22lHJ0AYnI4A7H6NOtsOPc6bhIX3cuZDuh9JgSius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758281; c=relaxed/simple;
	bh=r8ITPRWamerKZiT1PeJ0WiFZ+W7+BvyD+Rnaai8JXag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm7nuGOD/qygHrJrodmrZd1OzjZTZsU3HS+ek+FwhJqYeS9o52HvhAXJeRIYWHeG3sMLNElR0uGC9it5Rk0YBGvxOUspigEw3gHj6sM1+XtXd+4gmgtQas4C4HqY7FK6183ZIFN3VWMpTIPkWsqMnAs+X8Ez50VWpX40S/b8xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISGMW0jD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISGMW0jD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D5B1F00A3D;
	Mon, 29 Jun 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758279;
	bh=pXWbT/H4Hub0xKmOdyXs1Y3SvjlEM12dklgz3mGPRG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ISGMW0jDyNUqwyh4SHdjMPL4I9jnl1Y3tymlubGFQWuQUyGgbWblvevCc0JuVu4hR
	 /OEnsEUAP500BE7Ema882u8Eejz+Ub/0fHmK+WA+FfV6krIXJnB4EmHLZcZxNMQLmF
	 cO3PLGIJFPEFz91iOVK/Aek8pV+sWJEV5Fko44ZcosDGucF1ss6rYXL//ocGowL9fl
	 sGeSk+BRm06VN+KfvKKZmHatJD7kolSeAi2A5jqg61vxNsfXnjuOM1nnxQFC7oKttt
	 3s2vJZ+3n3ky7ZkOnIBTdpGrjCGEXT/zBsGC2Q8xQ13HlHt9fsZMbxLa28Fen7aivj
	 nlsXkrwWeScsQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 01/10] KVM: selftests: Move STR() and XSTR() definitions to test_util.h
Date: Mon, 29 Jun 2026 18:37:36 +0000
Message-ID: <20260629183746.699840-2-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260629183746.699840-1-yosry@kernel.org>
References: <20260629183746.699840-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros are defined in two tests, and future changes will use them
elsewhere. Move their definition into test_util.h to deduplicate them.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/test_util.h           | 3 +++
 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c | 3 ---
 tools/testing/selftests/kvm/x86/smm_test.c                | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a56271c237ae9..c55148ebfe934 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -240,4 +240,7 @@ char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2), n
 
 char *sys_get_cur_clocksource(void);
 
+#define STR(x) #x
+#define XSTR(x) STR(x)
+
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
index 77ce87c41a868..cf53bf4697e1e 100644
--- a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -22,9 +22,6 @@
 
 #define SYNC_PORT	0xe
 
-#define STR(x) #x
-#define XSTR(s) STR(s)
-
 /*
  * SMI handler: runs in real-address mode.
  * Reports SMRAM_STAGE via port IO, then does RSM.
diff --git a/tools/testing/selftests/kvm/x86/smm_test.c b/tools/testing/selftests/kvm/x86/smm_test.c
index e2542f4ced605..21619e7582718 100644
--- a/tools/testing/selftests/kvm/x86/smm_test.c
+++ b/tools/testing/selftests/kvm/x86/smm_test.c
@@ -22,9 +22,6 @@
 #define SMRAM_GPA 0x1000000
 #define SMRAM_STAGE 0xfe
 
-#define STR(x) #x
-#define XSTR(s) STR(s)
-
 #define SYNC_PORT 0xe
 #define DONE 0xff
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


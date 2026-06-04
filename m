Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15B3C141F;
	Thu,  4 Jun 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605361; cv=none; b=gi9cw0Cei7VW2m2HHY+AgGYF6b6MR1XmnGacJ9EKjGXhVO8NCNFpIqJ4bK+6qAKoJLu86vY1OfgukNcmKMD0kWnghUTOZEUz7TcsfvMVtSd25xTbI+dKR60lerLICJZUm05vjIRJp6HMctgN1Or86iW6oVDi5V456fIudGQZ/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605361; c=relaxed/simple;
	bh=02xq5Gh+6kg4ilsbxVrU9m4kwFyjWaforNS02Ur7P4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7HYDyq4yeTfoQfPEdvkLrzGsq6dOQutBKFj9xDTegkEeQExkiZstdgWO8MAB/fGow7WG5PsGBqgpRkpV2AG4xhT3lrkfKTlo39i4FlBlTQ3wB7h4U9I1tcMOOc5Th4G3rb1NL+4W2m+fyKxAJ/P6Qj2qy0DUhfAl2a4hLlPmqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqhz2J1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqhz2J1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108C11F00899;
	Thu,  4 Jun 2026 20:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605360;
	bh=5vFdI1nPWjTWHGLKeQney7+T5Oug6fQYNZ9pJ08Nnm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqhz2J1Nlkc+E9dt9r9gfpl5cuRE/9bPxAwuLqT8odAFq0wOFL01UeEkpOydUfySV
	 r96obbSa/kk7Iqnjo5isi+StXSDoM/hPPjt1q42q27ZzV7fqkCj9GQQ8I9NwT0DbD0
	 0WMqC+Rbh9PBnf1u3wYWMN/7DSh5FZuLQoa997JLn94lmRl9qLVdEWXqxXobH8gfwE
	 3Y0xpiBbwjNljvT9vt0+7pNsTaQ2BnSgridsWNFkhxXboOvfRanO68tuCL0G5Ljwhx
	 iofr6vbMI6G1daV78bTXzdlLfR5BTY4TQclrNCsxfmZPXjndf/Yd06/lkOZnB5HEhz
	 prlMFKljF9ibQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 01/10] KVM: selftests: Move STR() and XSTR() definitions to test_util.h
Date: Thu,  4 Jun 2026 20:35:37 +0000
Message-ID: <20260604203546.365658-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604203546.365658-1-yosry@kernel.org>
References: <20260604203546.365658-1-yosry@kernel.org>
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
index 5b3aef109cfc5..0c655c48a75d6 100644
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
index 740051167dbd4..c260701d4691b 100644
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
2.54.0.1032.g2f8565e1d1-goog


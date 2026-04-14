Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0F31326C
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190079; cv=none; b=liXzUqtxBNqy7XSYG+Se5wzXFt4w6eHHMd0iBhvODxdrMjkUN0b/kLvsVsHrzV9XmY/gtLqaxtR+KmYwZ/RQJuL1/uILTln/m7X5hSVoBCD0uTS+jnT3pz5agirxSV35FnZix5uXWX3Lay7IByCEs9+bPdGk2faEWyQFjVlXKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190079; c=relaxed/simple;
	bh=Hd5qZDur7V+h51FM8gRRisATrFOW5S+Ps63Zhu3wHr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=miNsuEXZeNqtdpoywwUZ2E2pzK54eDzerf3/S3YZBHCnSaUhp5x4mIMerUWmUR6QJjLmTxi6phq2naNaM/PN8dySLCVv0kJ9RdjZR8ZO3F6X91nlBMqSZu4aWfvqAzPKkqu0axmr2FscWEx9jkC+SjU/KD0gCU5FTcmWY1M5ZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFrFibRm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFrFibRm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adef9d486bso54022145ad.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776190078; x=1776794878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WM5/xC3pViZfhGQrHlucwZXjKqE1LBX1FZovj8hMxDs=;
        b=kFrFibRmm75p21YyVHJx4k/ezNq2uglv0HRIMPeasUtt8RdFwPnQILa9y3xUI8wbVb
         AYw4aQfyFM2eMAW3+L13hqf6ythHyJlPwe/24CK8o12zb8cPS8MBnHBl7plXiYKzQPua
         K+y1h8yNWcyWWNUVi2eDOGwbN4xwLC3MAf9AeKkFSAPc7YabN8jn5bHlXhS7V9Bcf/tW
         RbWQePdtgEbzICVkoUMua25tnwUzefKc0uT16h7yGzP9LDX2SF+/5PDRcYKqc9pNacIu
         voqAySEas2ogB0kv6aMpibyG5pglJXLx68s31E1jmBcxfEYGMGqW1KCGrgD4RGeyyRld
         te2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190078; x=1776794878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WM5/xC3pViZfhGQrHlucwZXjKqE1LBX1FZovj8hMxDs=;
        b=VdZR2P/Ap2CO7TtKGYmyM3CqY7T7nsJEsai2B9agfL0y8ME1e121eUsA5T10cQ5szf
         Xcl8HHs66Wqzx1Mg6PqpFCp0aXwwHmOqFidbVB6VRLXEJjYs9cr2n6LDHuyjNCKoRM59
         JiOwmB36wa9CPhQI9A1f0/8M112vLKJxkd9ehTDC24ZsZbPJyYRpBHqCS1fAXnEPlCXV
         JT9k7nlYxB5gsl3HWVxagCHhfyk63OolJaQ9TE1ezNuy7kl4Glga7ro8B5LgHrOQ/Acb
         8ikpYBc701ZGKiguUUPzs3SvMbbh2v5daGfEKbOETVEveRTlieiPp4/4+3E6TaUDBbpP
         C6MA==
X-Forwarded-Encrypted: i=1; AFNElJ+p2lgCssOuSx/2u51hKYHGT2716UvgqD91TaN1/5kijH+LfoK1AKVGTrYjkpvyFNJ/+g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPROvHu6nnTZkgwUJkl6M4Wvxf7ucF4LTiqxpZFMyE4+2gqTzy
	xMlU6kN39fStzGbhoVQyuaCmOXBIqmsmh03JtX0YW5YAbkZEW9vIheP8Ug7W/CUz4DdLuWPHgK+
	XlTGKPGmH3fkYmo+o9YEAMgxoug==
X-Received: from plht6.prod.google.com ([2002:a17:903:2f06:b0:2b2:beb7:883e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:9a4b:b0:2b0:70c8:ccea with SMTP id d9443c01a7336-2b2d5967d7dmr123297865ad.13.1776190077309;
 Tue, 14 Apr 2026 11:07:57 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:07:48 -0700
In-Reply-To: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776190073; l=5152;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Hd5qZDur7V+h51FM8gRRisATrFOW5S+Ps63Zhu3wHr8=; b=y5FWOXefLy8anzMgGZDI+mr0TcpKgI3LdYzb5kMUkeHxWgjqCQI0nc35/Yk9qUxIepPgAoJvR
 tZRrtnX8rYgAJ+6+B6vJS61XLQHvLswBjKAIjBy0US/D69dygXWgVUC
X-Mailer: b4 0.14.3
Message-ID: <20260414-selftest-global-metadata-v1-1-fd223922bc57@google.com>
Subject: [PATCH RFC 1/4] selftests: harness: Move metadata structs to separate
 header file
From: Ackerley Tng <ackerleytng@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, thomas.weissschuh@linutronix.de, linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Move metadata structs to separate header file so that the structs can be
referenced without importing all the static functions, such as
test_harness_run.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kselftest_harness.h        | 47 +------------------
 .../testing/selftests/kselftest_harness_structs.h  | 53 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4afaef01c22e9..68cde1556ac41 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -68,6 +68,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "kselftest_harness_structs.h"
 #include "kselftest.h"
 
 static inline void __kselftest_memset_safe(void *s, int c, size_t n)
@@ -845,27 +846,11 @@ struct __test_results {
 	char reason[1024];	/* Reason for test result */
 };
 
-struct __test_metadata;
-struct __fixture_variant_metadata;
-
-/* Contains all the information about a fixture. */
-struct __fixture_metadata {
-	const char *name;
-	struct __test_metadata *tests;
-	struct __fixture_variant_metadata *variant;
-	struct __fixture_metadata *prev, *next;
-} _fixture_global __attribute__((unused)) = {
+struct __fixture_metadata _fixture_global __attribute__((unused)) = {
 	.name = "global",
 	.prev = &_fixture_global,
 };
 
-struct __test_xfail {
-	struct __fixture_metadata *fixture;
-	struct __fixture_variant_metadata *variant;
-	struct __test_metadata *test;
-	struct __test_xfail *prev, *next;
-};
-
 /**
  * XFAIL_ADD() - mark variant + test case combination as expected to fail
  * @fixture_name: name of the fixture
@@ -899,13 +884,6 @@ static inline void __register_fixture(struct __fixture_metadata *f)
 	__LIST_APPEND(__fixture_list, f);
 }
 
-struct __fixture_variant_metadata {
-	const char *name;
-	const void *data;
-	struct __test_xfail *xfails;
-	struct __fixture_variant_metadata *prev, *next;
-};
-
 static inline void
 __register_fixture_variant(struct __fixture_metadata *f,
 			   struct __fixture_variant_metadata *variant)
@@ -913,27 +891,6 @@ __register_fixture_variant(struct __fixture_metadata *f,
 	__LIST_APPEND(f->variant, variant);
 }
 
-/* Contains all the information for test execution and status checking. */
-struct __test_metadata {
-	const char *name;
-	void (*fn)(struct __test_metadata *,
-		   struct __fixture_variant_metadata *);
-	pid_t pid;	/* pid of test when being run */
-	struct __fixture_metadata *fixture;
-	void (*teardown_fn)(bool in_parent, struct __test_metadata *_metadata,
-			    void *self, const void *variant);
-	int termsig;
-	int exit_code;
-	int trigger; /* extra handler after the evaluation */
-	int timeout;	/* seconds to wait for test timeout */
-	bool aborted;	/* stopped test due to failed ASSERT */
-	bool *no_teardown; /* fixture needs teardown */
-	void *self;
-	const void *variant;
-	struct __test_results *results;
-	struct __test_metadata *prev, *next;
-};
-
 static inline bool __test_passed(struct __test_metadata *metadata)
 {
 	return metadata->exit_code != KSFT_FAIL &&
diff --git a/tools/testing/selftests/kselftest_harness_structs.h b/tools/testing/selftests/kselftest_harness_structs.h
new file mode 100644
index 0000000000000..cf9d15ad3de0c
--- /dev/null
+++ b/tools/testing/selftests/kselftest_harness_structs.h
@@ -0,0 +1,53 @@
+#ifndef __KSELFTEST_HARNESS_STRUCTS_H
+#define __KSELFTEST_HARNESS_STRUCTS_H
+
+#include <stdbool.h>
+#include <sys/types.h>
+
+struct __test_metadata;
+struct __fixture_variant_metadata;
+
+/* Contains all the information about a fixture. */
+struct __fixture_metadata {
+	const char *name;
+	struct __test_metadata *tests;
+	struct __fixture_variant_metadata *variant;
+	struct __fixture_metadata *prev, *next;
+};
+
+struct __test_xfail {
+	struct __fixture_metadata *fixture;
+	struct __fixture_variant_metadata *variant;
+	struct __test_metadata *test;
+	struct __test_xfail *prev, *next;
+};
+
+struct __fixture_variant_metadata {
+	const char *name;
+	const void *data;
+	struct __test_xfail *xfails;
+	struct __fixture_variant_metadata *prev, *next;
+};
+
+/* Contains all the information for test execution and status checking. */
+struct __test_metadata {
+	const char *name;
+	void (*fn)(struct __test_metadata *,
+		   struct __fixture_variant_metadata *);
+	pid_t pid;	/* pid of test when being run */
+	struct __fixture_metadata *fixture;
+	void (*teardown_fn)(bool in_parent, struct __test_metadata *_metadata,
+			    void *self, const void *variant);
+	int termsig;
+	int exit_code;
+	int trigger; /* extra handler after the evaluation */
+	int timeout;	/* seconds to wait for test timeout */
+	bool aborted;	/* stopped test due to failed ASSERT */
+	bool *no_teardown; /* fixture needs teardown */
+	void *self;
+	const void *variant;
+	struct __test_results *results;
+	struct __test_metadata *prev, *next;
+};
+
+#endif

-- 
2.54.0.rc0.605.g598a273b03-goog


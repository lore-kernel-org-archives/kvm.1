Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8231A065
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190081; cv=none; b=oXMIDs0uLVCB715dclSIA88Xmc8tiwaKhdp1rwValE/5fvE/rGNC1iqdEK9wWEzHH/4WEW/hMpliQpt9PJP/+N3gcZPr0fP51ZeTvhimYuoLEWKoZyp9ZWZzMLYLLzK35kIBcsPdKBlnklCFF2jh55LcTrPYhO5RKeMOqtftSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190081; c=relaxed/simple;
	bh=ALJBMYWS1x2rKXT/63YRmr7XiBihTr+8ZXwVGpCSyyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhqQnTi2Lwa4cBs9wc9i66wtSOsUXwfedZmNO7q6qsFreg2PDx8GMCGH3w8k3QT3QVMrZz43V4mIzqR0Ud2Ceqe/uUL1gbMsjqNgSDHhiagrmBtAs4xxKDrGh4iuG19AhJH2eUV7SdLiZn22GG7dPoIy2g2yIOjU5Pt5TRrSViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wE96A4aB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wE96A4aB"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso2554386a91.3
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776190079; x=1776794879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1L9bOnm0LoR07RId6eCuMgAP1rY2SX02HCtv6g1t/NE=;
        b=wE96A4aBVTKN6bkmX5d2KKt8+3Uc3/uX853cDp5N6UcpPqXJwyNtvg+wiZ3Vz4utNB
         kOhIqmDYut+qrUwOKA02Jixhm7QZvaHnmeRoyOFWm9tzX+I3PUrkdiO35xETr7MsO7k/
         tK3PQPEyV6zCZOxl7MG7598U4Sqlwm3sJXwROdup4uDgucehY3iFt+7Mf3rL8Ka94zG8
         7GncMgft239dAgROstempjHDLFPbgGUFU0FISaxxQ+XTB1JEsOiak6TEffsAa2Uq2EDP
         qJs9ejtirSdv7ZWRtCQiDrseJ3biEMHIiMYT64BEu7md6mND8s7cJMPIxgDgfVQTSmGM
         UHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190079; x=1776794879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1L9bOnm0LoR07RId6eCuMgAP1rY2SX02HCtv6g1t/NE=;
        b=Lz19eZhea+f1PiNrPQIJhn0w9a9rb86hf6cuKBqD1Zm/z3a1jJn4wTU7I8hVAenj5S
         dgJY+bjQh/Fy+bV0icBalkm2QMM5OE5ebM87YtmBPo9+yVU4n2GluFsdurrFZa2caPQm
         datWP/voejYkVkRY6mzitzIznkJR2EuiSjRxKCRKysZbMGeZWCU0s7ECd2GQFjwyn/pK
         aFOB9k3sB0+nnMzw6E6pDBNECSYQA095JiuKMqhLRI7Gfk4XDyQ244lk/4w+BeQb6O3s
         HyuBYgD4CabDLKepZSeK8H+wojTf7lmiVbszRPELTetE7efh7+Y+6yIZb+hvteFl94KU
         fxFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pYCMpYRZ8eXfh3naunq9NZ7oQTePtxhGt0l8cuZShRkSqJnu2gK3g4x2A8lIJZn6LOVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtbkLfDi2p9roIB5y6kvmDu3CvJNsFztY7hYdfNLvuwlKztmG
	CafrqwpIvYj3Znf3QWHa7519zrsZUGBXZSe5LFfAWpSCYrUERDB4vGbadQUB6rZh0foLDidv/rc
	hIbC/94F/6THXt1UkbyuQDvEQ2w==
X-Received: from plii9.prod.google.com ([2002:a17:902:eb49:b0:2b2:6ee9:466c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c50:b0:35d:8ea1:62df with SMTP id 98e67ed59e1d1-35e42838d40mr19277911a91.21.1776190079138;
 Tue, 14 Apr 2026 11:07:59 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:07:49 -0700
In-Reply-To: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776190073; l=1498;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ALJBMYWS1x2rKXT/63YRmr7XiBihTr+8ZXwVGpCSyyI=; b=FfRgVZaFM+g1a1sLY5U/nQrRiYSCOF6Jgw9QEH9uV4HeDMf/FykQ40BD262ioNmWKZ8QPOhlc
 3eqTBu+6HU+DSHB5OQwHKzlRQk88mwEmVErdbYW9Oy05e+xqIg9CXzz
X-Mailer: b4 0.14.3
Message-ID: <20260414-selftest-global-metadata-v1-2-fd223922bc57@google.com>
Subject: [PATCH RFC 2/4] selftests: harness: Set global current_test_metadata
 for each test run
From: Ackerley Tng <ackerleytng@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, thomas.weissschuh@linutronix.de, linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Set global current_test_metadata for each test run so other test frameworks
can choose to access fields for the current test.

This avoids having to pass _metadata down through functions so that
code defined other functions can still use fields in _metadata.

Test functions t->fn() are executed in series, so during the runtime of the
test function, the function can count on current_test_metadata accurately
being the metadata for the running test.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 68cde1556ac41..85d9b4527fca6 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1151,6 +1151,8 @@ static bool test_enabled(int argc, char **argv,
 	return !has_positive;
 }
 
+struct __test_metadata *current_test_metadata;
+
 static void __run_test(struct __fixture_metadata *f,
 		       struct __fixture_variant_metadata *variant,
 		       struct __test_metadata *t)
@@ -1182,7 +1184,9 @@ static void __run_test(struct __fixture_metadata *f,
 		t->exit_code = KSFT_FAIL;
 	} else if (child == 0) {
 		setpgrp();
+		current_test_metadata = t;
 		t->fn(t, variant);
+		current_test_metadata = NULL;
 		_exit(t->exit_code);
 	} else {
 		t->pid = child;

-- 
2.54.0.rc0.605.g598a273b03-goog


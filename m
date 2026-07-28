Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E12448BAF;
	Tue, 28 Jul 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260563; cv=none; b=qobM0SuJIjXRgSjK7Hd8bZSZulXPI1xyPcOeO0zxgF2A8/h053wNVkLGxcbPUMIS3BoTEJGDo2nZK+NjCQJHKHW7X2ySj5wrrFr0fxtDNThtjKQbhtM1Ez7yBT40QJM+vc4fdR/2DHOqXC7LautwQNQK4SGpwzju/e1djsx1Ek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260563; c=relaxed/simple;
	bh=PQ3AVkKoUnEPVakkildmuRQc76AuZSL7suPntp5dvmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaACt6hwYNn3XYFL+tMJfoIGJf35U/Vr6OCNZ964LglXLFwqYx2ZFF82k0GiAXs3fEiFnAPE8s5E2VG1wiiQbaonJf7tiPXXtw6kGbi7jNz9d50QI+aWPQMV8UGNj9floOCih4DohuddlhO0OVZowhbD5TrPmpr3TGQQnvjNIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLpGr7Cc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLpGr7Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2F41F000E9;
	Tue, 28 Jul 2026 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260561;
	bh=G90HBochtHFdD0ucjgwH0n0vlOWciBV+gK14hl2pB28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLpGr7CcrYNvnpmmTbCNTP53kWCk2OBBqOJFailqZgJilR/Tn1svWzIYEM1hZbX9L
	 ONnVzgU8cWMxBLkecHtAao/r6XAQuoyTC9QPAAtv6u6v1CnancYe2Uk5JcuY6nf2Lh
	 b2kfgQEmHZgcCTftcIFu2hTw96oaeikEwi7T0529giXx8Q0piz15ygb6d8HOBnNQRm
	 TMNTimhqzRmASc1vWlA5Bcngye1UE62m46cJUXS4Hk6M+/VnsbFTpfOF8eih/v3/SL
	 9HrYJ17DF/uRDxnCO7Er8B7BZ3DXbzRS2go2BPwWd0qyqJ3iYvy+C5i0M0H+aNcnSd
	 gGDkHVsVd6Y7w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 07/13] KVM: selftests: Add a blank line before logging assertion failures
Date: Tue, 28 Jul 2026 17:42:26 +0000
Message-ID: <20260728174232.2423257-8-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line for visual separation, which is especially useful for
tests that use carriage returns for same-line printing, in case a
failure occurs before a blank line is ever logged by the test.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/lib/assert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index 1d72dcdfce3b6..3e353ac39eeb7 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -74,7 +74,7 @@ test_assert(bool exp, const char *exp_str,
 	if (!(exp)) {
 		va_start(ap, fmt);
 
-		fprintf(stderr, "==== Test Assertion Failure ====\n"
+		fprintf(stderr, "\n==== Test Assertion Failure ====\n"
 			"  %s:%u: %s\n"
 			"  pid=%d tid=%d errno=%d - %s\n",
 			file, line, exp_str, getpid(), kvm_gettid(),
-- 
2.55.0.487.gaf234c4eb3-goog


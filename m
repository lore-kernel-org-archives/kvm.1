Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7084432BEA;
	Mon, 27 Jul 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196370; cv=none; b=trLoz+Z/cFuWU+YCkUW1lJS557gwc5FQceu/CVQQ68MxLZ6iyjiGQMQLejlsT4jHtlN1Y/luDnNn0TCCGno7zBCdWCT0oKKDAHIPwABEEXG6kpdMKoFFnCUJcwUJ8mMQEKXLvqX+GRSug1rEZVxGrpFIEYOuvekpaGXTlxyYUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196370; c=relaxed/simple;
	bh=E3d0dubS5PDJQFDmQiuDmbRIP+6gt55P07HCwgv+Nqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+BH994R5A7hH+AeZB+Q1dmU3JX+KQcpXdjGkhjDjj/pqvabGplnU7aauOalBvUv1ue9ws4WRLu7aKCpajecEugn+4ledMLmj8ybB4JzSJNgpwBrxtuBxjcDPf4dz8+4Ey7zIPiamptP44PAlMW1xasLw1ZlG0fiGti1qr5qJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F305Ug6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F305Ug6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679BB1F000E9;
	Mon, 27 Jul 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196367;
	bh=IXHlRoXvCPfPtJdPkuXWFttm3IqDC44e73cwYR13HpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F305Ug6b0yAab1/0kBHza9sRF6qbKJMPnMxuvvFvKR/6BS8yN8DgCu9Up+fyAwDCI
	 nQNwWvRoIktOimncm95EMvYhp+Xu0e/3jAAILqhx9vKL8POK6WgKSwzvSIkmFyllAT
	 ulBokVIrmS3Xas+QRe2UFetu8rhBSFtCNwrCX6VZP8DceVNxW8+q8VxmBLof8pU2ii
	 kDQfxAh2IRy/qsCs8v/OdyhfoxMcA5sMW80nBE95wDoFHzwbK/WjCg9BFQG/lApAlT
	 la4aV7s0yTmrgJH6ORRFXf/9s90YqhCvW+yUsGSZ4OBK0OIcAdJxE5xWdE6Z9x1Srw
	 xzw8/wVHDjggQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 07/12] KVM: selftests: Add a blank line before logging assertion failures
Date: Mon, 27 Jul 2026 23:52:23 +0000
Message-ID: <20260727235228.1007324-8-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
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
2.55.0.229.g6434b31f56-goog


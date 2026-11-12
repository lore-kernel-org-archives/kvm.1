Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494547;
	b=GhpLjV3ss1U2Q9U1gUsvfqlLcAK7WHl9kzg3xeBKpD21LR5+o1N0DY+T8Fb7VmNvWCo4
	 ijj6oWjxkJJIg2At969qpF2qrYgoU1CJkLAdmaH9RhOEtyodiCzSl2t+WvX4SHeypqETQ
	 E1+Nf6/5ffKuI6AV+F5hj7zvgEXS93KKQNSbflTmP22Lh2qvBa0B7oX4al4yNK8Jrn4uv
	 IOe+pqMtvOQBEU5ZXdYmPWCOojxulII6lAQCit6pvxkriy6VofF+Snj/+QpVM40vl5VI1
	 CyAQOCu5eqjcVgiUX1GtwozPmbNR4OrbYg1tZ5OSjqD0cY4QWkcMgKSQhVIL+ezI9cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Sender:X-SRS-Rewrite;
	bh=qZYyj62zk4DKgGeMeAwMpBAlP2Mi8ofGhkV/pgn7PNs=;
	b=2mfYcYSbdOLsrU1MpTVJMsqehR30PQxLUTMhWGEzPF6CpJcOJJTJwTvOVCXBQeS5iPyc
	 ZNsUttfbC60VrgcNy/HA3H6dmhEOPoRNTQfnRcqNiLZsErU/iRqW+tXMTOrEwoiWT6vBZ
	 VvXppOpB6nTzppF8s+kfyO2UyujpZ7FP25oyaGTfpFKI3OY0jNNHnGOTMB6OrDfSIK4EU
	 TU3oEZa498xlKUV0c3oLFKVSxnpmTXWgwtA8go2OgCmRDKIvdZbf0r0V3+SPl3JKoT7j0
	 Wne47XqPJxAMMP2jpOv3dwCztT49O804MQj9xAHjcQokpUmt0wWUGrc9wnp7xXVB3og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qSmsmSGf;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E1606A31C;
	Thu, 12 Nov 2026 14:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F2E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qSmsmSGf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qZYyj62zk4DKgGeMeAwMpBAlP2Mi8ofGhkV/pgn7PNs=; b=qSmsmSGfb1mtxy7pnlkZ7QJVdY
	M5PqfEID+y88Y0NyMwhrF+tZ6z2nHfHWYkTAg+cmRggQYOJw1m+kAwlDNDceoDktqtq072X8fofrD
	fvOHzETrBlCATXTp7rtjFgDzYbUczA2arBII3GwSgWvm5dd7IOatsTxTHxRMjciefd1HnnqCiJ5ud
	u0xwRF/qFB+NEXx4qESQzSyBYAOByukM+HJnLg18lj3PSyUKT2x7B58A3exvNb00DhX/FWmL6IZ/S
	LQmPetx0sN3Fk2663fmOTk4JUywQ+otRwPNy02MjopFS44uVA+rHiYv+Pc4qeDqmxh8mc64GcdsDa
	y1DRP+0A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRW0O-0000000ARvJ-00Aj;
	Thu, 12 Nov 2026 14:42:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRW0K-0000000080t-3EEa;
	Thu, 12 Nov 2026 14:42:20 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Anish Moorthy <amoorthy@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] KVM: selftests: Drop stale exact flags check in private_mem_kvm_exits_test
Date: Thu, 12 Nov 2026 14:42:20 +0000
Message-ID: <20261112144220.30801-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 7d0afe669374 ("KVM: selftests: Take into account mixed memory
fault flags") relaxed the memory_fault.flags checks so that they only
test for KVM_MEMORY_EXIT_FLAG_PRIVATE, since KVM may report the access
type alongside it. In test_private_access_memslot_deleted() it added
the relaxed check but left the exact match above it, and with the
READ flag now reported the test fails for me there:

  x86/private_mem_kvm_exits_test.c:93: vcpu->run->memory_fault.flags == KVM_MEMORY_EXIT_FLAG_PRIVATE
  0x9 != 0x8 (vcpu->run->memory_fault.flags != KVM_MEMORY_EXIT_FLAG_PRIVATE)

Drop the exact match, leaving the check that the fault was private.

Fixes: 7d0afe669374 ("KVM: selftests: Take into account mixed memory fault flags")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index ed8edde9b718..e07f4972ab7e 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -90,7 +90,6 @@ static void test_private_access_memslot_deleted(void)
 		TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
 	} else {
 		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
 		TEST_ASSERT(vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE,
 			    "Memory fault didn't occur on a private memory access");
 		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);

base-commit: e71c4e83c03926c300f6c43e79b783d47ba8b588
-- 
2.50.1


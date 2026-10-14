Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF6499F31;
	Wed, 14 Oct 2026 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008115; cv=none; b=B1mxM8Yb9MYiCRqdsJ1p0XXZlrs20mFnMk43X8dkSldR8hyHNuVR/fWDCFcuAVwzgLHal67a5gM5OxwiWOM+XsTF1OtbgI7MXzxxw5Jib31Ay2EDMOkydz3t+QouVKz9tirPxYjTP0dKPxxazBuq2UZFnI/eM/+8tCqA8ZISYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008115; c=relaxed/simple;
	bh=fSmlYUtUXBUpFwvqFS1gq6vUk1/0yKofFhB2WRbkT5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tU7dO1ZXvfMjY587JmKCP4Ifu6bcLGor3evgHHP5LGdakTzsai/+nCbylB7zllJ+TMxDZaP5R2XvPITCU3TDDDNyIxKHxQp3ZCCNmiYVKe06CTuJwdxCuvghBebjKV1EJOVOxVtNfCTxPimYbOgUVEbbUWtrCnOf5RJqwdaN490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIcgzCRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIcgzCRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9779C1F000C5;
	Wed, 14 Oct 2026 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008114;
	bh=zfxiiuUC7TK1F/tBXnedeOB24WqrbfTwvrq08iz8Zws=;
	h=From:To:Cc:Subject:Date;
	b=OIcgzCRAMmoL23I5QMqiv0uAbZr++NwXT0L7HP66wZSwcE3wSSuPod07EgXdxXFh1
	 V5qRSaIPxlx4Ta5hTKQH24cpURmZFCvudgo+sBCYvM1F0inEEJTFEQt5HC4JJ7/x36
	 ZOe0Ihg8gKyY7d1FLIDOSpQmxfhMwqFToq6uMTGsT0PD2YeUww8ZqrQBJUQBr/0HZf
	 ymRaul0idzF9JWGPC4pEojrMLyutgvB8fx3iGF/GDb0UGL3gnWgSpfU7SSDzsV9+ts
	 Vv1qa+6s4pEPfNeoN8ZEw8yTgBkP1gE17w8mHacYDPlMqEycSrdlEj5ochajETOkzC
	 xxlz2S+6xF4IQ==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Provide empty installation rules on unsupported ARCHs
Date: Wed, 14 Oct 2026 16:01:52 -0400
Message-ID: <20261014200152.1365147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unsupported architectures provide all and clean, but installation and
runlist generation fail with missing targets. Supply empty install,
emit_tests and run_tests targets alongside the existing empty rules.
This represents an unsupported suite without creating dummy artifacts.

Fixes: 43fbd8cd389f ("KVM: selftests: Provide empty 'all' and 'clean' targets for unsupported ARCHs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index f2b223072b626..17475d3c0786c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -11,6 +11,6 @@ endif
 include Makefile.kvm
 else
 # Empty targets for unsupported architectures
-all:
-clean:
+all clean run_tests install emit_tests:
+.PHONY: all clean run_tests install emit_tests
 endif

base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0


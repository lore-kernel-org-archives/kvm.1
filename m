Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820998;
	b=bOnCIQ/Nnp/teLnTjOfljuquH7bpbkgNk8SwB0QYdQQmcNTHUXuZD+KYZXVhApY7sVPM
	 m43UbY8IPBIgbU0TtYvS3sORNRTjtz5+xdj6R2+POdXucHfY/daklralO8jBT7pxp7G8R
	 IGM9vIdeAPQ//PIN3Yc7JRRoGbYuUffrar7eGxwA/+FGqPIDXac3+tHsXKiGEp/4sMp3p
	 YrbgwuAf+9tFS06ox6GzSILw6HACs2J4kdb4YYKrAU3aN9jt1Xdww1u7dFccDSSqCHzUi
	 /16aGKgSk+Z8c0IwKU08K47bDN7T/9V4Yr9WShg4a+2vQL2aOS7/9/9fndZAJVoe3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s39IiuYWgNekbEr0ZHa8+VduCfpBWW0ZMkcaLh0e6xk=;
	b=m+uzGz4UBYSILBFptIHxK4z/JkH5hFBedNbu5WCV7nvTdlvI0Fy81C2s6/RSchOg/LmL
	 pRf7JI5alsrwRZw1soRxgBqletd3Vr40RB7beu3HhMysoNN/14hL2KFWr5Sf6B3b5Xnra
	 +hxH5ly9xoMW1gS+IAIFEwEqU3XRAPFTCf9gUta7nBDf6RBgZKBM41DLTvMacBfsSjVfM
	 o2kI1HixyIJ1iZurrMyHB3/DDzwf/sPYBQ0ctz/eNRbTs1KOtFQrv2U8slWoUZuJZiPp6
	 bUJNdOA/OpimDCyUGi7DYkTD4qoTHxBZSkdVLZTHpfkqMCY4xBueRSCUUedH+Aw2k5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kckYkACl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B8607CC9B;
	Wed,  4 Nov 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kckYkACl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9301F00919;
	Wed,  4 Nov 2026 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820997;
	bh=s39IiuYWgNekbEr0ZHa8+VduCfpBWW0ZMkcaLh0e6xk=;
	h=From:To:Cc:Subject:Date;
	b=kckYkACl9iDb7wR1OP4mE2jYPEa03OEz3S++1rXKtJddwaiN7q9mg/zRxdZ6V+aPD
	 2tQySSjzFTY8YB4CC3h3uWgJ8Rdw04a4RAVpyM0KkOJgDX55iCVzD7VoMn1j1KGURH
	 qBbuPbv9IS08Gz27BYkD8nsoXXRVdUamBqbDxHSiKk4Q8Bwcd0KwuN5wSSb3SRYeML
	 p95KfuJFNJomDJuh4XP9KHV0vLGizRppGWp8y3T00MyU3POY43Ok4cBktO2VeirJIC
	 OK4MkqBZQH02FBDCofezOYrD1JHRHgrgiFZWQps/ef0VOCd+vyCuFdAfUKV1ADOfXO
	 0ijCSy6QjalIw==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: add empty install and run_tests targets for unsupported ARCHs
Date: Wed,  4 Nov 2026 14:36:35 -0500
Message-ID: <20261104193635.333141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Commit 43fbd8cd389f ("KVM: selftests: Provide empty 'all' and 'clean'
targets for unsupported ARCHs") gave the KVM selftests empty all and
clean targets on architectures without KVM selftests, such as 32-bit
arm and i386. The selftests Makefile also runs install and run_tests
in each suite, and those still fail there:

  make[1]: *** No rule to make target 'install'.  Stop.

Add empty install and run_tests targets as well.

Fixes: 43fbd8cd389f ("KVM: selftests: Provide empty 'all' and 'clean' targets for unsupported ARCHs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with KernelCI-style TuxMake builds that record per-suite results
with KSFT_BUILD_REPORT. 32-bit arm builds now succeed without installing
anything.

 tools/testing/selftests/kvm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 03d91f00092f4..3881df8d5b2b8 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -13,4 +13,6 @@ else
 # Empty targets for unsupported architectures
 all:
 clean:
+install:
+run_tests:
 endif
-- 
2.53.0


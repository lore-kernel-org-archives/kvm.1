Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33934104E;
	Tue, 17 Mar 2026 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788035; cv=none; b=FbUyzqUQLxEKFXm/yIM8nxEu+DAUsqJ2WGg90OKyiIUMN2M5LFVUOewDVbzLB45S2SHriy52oHnlVkTe4Kev+F3Yis+0d+lwdQAOTlzrsPa9UERTZHy3NI22MzRxmesVYUeH00wk8DU3hN8RhslC47qdZ/lKGPO8stzxysFsm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788035; c=relaxed/simple;
	bh=zAQReLpKpzwXSO+ONaXO+r/YMSfa1wBj0cnrHrQCjEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7GobDWXAM1FX9kSPqMnZ8GK054YU7ntxbiYsYK+mKorS1nSDprXQ29vUi8EavMOi4e0Z1WGe8uuz7eW0Xjqp/obFmPIDYmVz9rDo9QvS4aMuByYPoi0fef7YlBegZqHHRjV9ojKVgvo6ixMSHWTMHINv3bZhV/vQocW2Mte8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHe/fX8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHe/fX8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98350C4CEF7;
	Tue, 17 Mar 2026 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773788034;
	bh=zAQReLpKpzwXSO+ONaXO+r/YMSfa1wBj0cnrHrQCjEo=;
	h=From:To:Cc:Subject:Date:From;
	b=MHe/fX8tF+5Co36o24RhfeCexp72pYplePcZeKmtSDTZ8/9gpfuJKMcE1mc++sa34
	 bXGu7cJuOqJZk0aShis4lu0fHIbSihE2x8V7mZt/GAOO/EswABRpJ8Rq8M16vRaokZ
	 BMD4R72KY4XJTm+AJoxBrOrt5a1BYBNhs+SVKZWgec4Rk9Jq6jy2pWBpLNRHS4NYXO
	 4tHRZW4w8rhQDo74fLQgBFPZDEbWYB4OuTIPRVQCsdrB4s28kRaAom7nWEo1PTdsP+
	 qWJcUKI1WZYj2ccWpu8m7dHmPrW8J7DDTmnvGiHu/C7rcRi+5StOPu7QxFJvg6c8dB
	 KSY5YTaVZ9QNQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH] x86: Increase access_fep timeout to 300s
Date: Tue, 17 Mar 2026 22:53:27 +0000
Message-ID: <20260317225327.4068448-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a1fae402cbc2 ("x86: Set forced emulation access timeouts to 240")
increased the timeout of access_fep to 240. However, the test still
times out on some setups. More specifically, it times out on Icelake
machines with with some debug config options enabled (e.g.
CONFIG_DEBUG_VM, CONFIG_PROVE_LOCKING, ..).

In this specific setup, the test takes slightly over ~280s, so increase
the timeout to 300s. One thing that can be done to avoid running into
this again is separating 4-level and 5-level paging tests into different
targets.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 x86/unittests.cfg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index 522318d32bf68..397517e37b644 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -123,7 +123,7 @@ arch = x86_64
 test_args = force_emulation
 qemu_params = -cpu max,host-phys-bits
 groups = nodefault
-timeout = 240
+timeout = 300
 
 [access-reduced-maxphyaddr]
 file = access_test.flat
-- 
2.53.0.851.ga537e3e6e9-goog


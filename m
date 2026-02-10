Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A327CCF0
	for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 00:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684927; cv=none; b=jE+qZXwUVoVA5x2riHnnLMOWIVUzCOBYZQjUF3/yt8GCM9UHqOYvwsm/9fHlroqf9QbM232OjmXWeyxliUjVpTSIAaChhGdHoEE4QdY9GJMZFXDV5lJMsxWSUnC7a5m0mz+vHjpNDYI2Jrvbc3RVbI500vm5GVPFjLQ1uXDLp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684927; c=relaxed/simple;
	bh=Zd6b2Meo5Mf8sqR2tZUAuE6SnsLApq2sbIjcN11I+uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geLhQ+oUQOOy924kS0BMRoODIR0vvpDMJCdEp2CaPoVokP72jkxoke6wlPfLHYy/jnojGBjlughjWnFkVnTnCPuTIAQbBMjlCWVG8QaRmGOw6AijMGOlvXg1rpL4D4Uff+c7SiCurp8tZ8ba9b9tQfdKLB3N2E6zndV7Mv6ubZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hE7ehndJ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hE7ehndJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770684914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nf46oM5cgHfGu8ZR1tCRW4OSvAsJ8SAp5wx5Yw4PLoM=;
	b=hE7ehndJNuCsW0t+jTn/vxCvUJWohtHn+trcK2OAB2ceo7x1ygAIs0WLCMlE91LGwmVsaY
	LDHqnZNzokSKXT7GIUdu7m8o54nsqF0CbtOUC30SsdnjDDWra9dAY9T161/9fsjYhr/bS6
	vlGXr8chkFZ/TiKrAIHLNA5kCV474jQ=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 0/4] KVM: nSVM: Fix save/restore of next_rip & int_state
Date: Tue, 10 Feb 2026 00:54:45 +0000
Message-ID: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

next_rip and int_state are both not sync'd correctly to the cached
vmcb12 after VMRUN of L2. Sync the cached vmcb12 is the payload of
nested state, these fields are not saved/restored correctly.

Sync both fields correctly, and extend state_test to check vGIF (already
sync'd field) and next_rip. Checking the interrupt shadow would be
tricky, as GUEST_SYNC() executes several instructions before exiting to
L0, so the interrupt shadow will be consumed before the test can check
for it. L2 could execute STI followed directly by in/out, but that would
not handle transitioning between L2 and L2 correctly (see
ucall_arch_do_ucall()).

Yosry Ahmed (4):
  KVM: nSVM: Sync next_rip to cached vmcb12 after VMRUN of L2
  KVM: nSVM: Sync int_state to cached vmcb12 after VMRUN of L2
  KVM: selftests: Extend state_test to check vGIF
  KVM: selftests: Extend state_test to check next_rip

 arch/x86/kvm/svm/nested.c                    |  7 ++--
 arch/x86/kvm/svm/svm.c                       | 26 +++++++++------
 tools/testing/selftests/kvm/x86/state_test.c | 35 ++++++++++++++++++++
 3 files changed, 55 insertions(+), 13 deletions(-)


base-commit: e944fe2c09f405a2e2d147145c9b470084bc4c9a
-- 
2.53.0.rc2.204.g2597b5adb4-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1B3546CA;
	Tue, 16 Jun 2026 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646419; cv=none; b=uqacELP2kJ6q6AEcgOCNBR78HPzlzxTDBQ1VroYpmLjFI4b1ukK6sExwTW7TcBL1tMM5kupDZK5vIM8PtyOitkp7+9e0lWYxSwA1r6Vxy4jrPmep4UKkSMHiwX2F0w7E0tP769W7vF3WMJ1ypEBymU9NMQn8Par6m8VnPnZM4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646419; c=relaxed/simple;
	bh=stxVpWeNDSggbJP+PH4ewHTPqP7ixKPKtjk84/UHRVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ty6pP/kEtiopNlyoFzsaqSEomEZ7Di8cVfzn1mrx95fA5qZDcQE2yY1+wZt7Hmo2yjQ3U8tG89DZtjqzC5gNEQc67r7CPwobovdOCDGi/5gUgM+3igYhA5U2dh0mILDVWp+O5VbzxYGQ05kvFLbuKtZ896CCDqBzI3dXD988eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZk7bp8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZk7bp8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597521F000E9;
	Tue, 16 Jun 2026 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781646418;
	bh=EUyuYYMpgbZJl4mUVvufdwxZ/6sLlskD4ZZsx0zP5Ls=;
	h=From:To:Cc:Subject:Date;
	b=RZk7bp8TdrzNcU45bHoB3bwZhoR9asp1xdWcj9shDOelZrJEuyMDODkVkByzdckiE
	 LnT5sXejcfdARghNzPMj7iFSoMNTRZ6FnrABirLuKB9L9NFUqd8IR3Y64LkROC1oVd
	 WVRAp+nL1hMOHN4/zBF+F7eJEIvPYiZiPoctRvhysmKDuWlaQELOxWZ8zCDzSATYn1
	 U0iND8oa5nlXR5F7Yc36nCp3hPI/Tm42U1PXuYX7k7s1nYRq8R09B40STXJHW25SiL
	 RrYLWirk0EnfiHPWQV9+njMyanoCw4LokW0R01djL/we1q1uRIv6emLfWh5b8bgXlI
	 OZP4BMCFJ7aeQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 0/3] KVM: nVMX: A few TLB flushing fixes
Date: Tue, 16 Jun 2026 21:46:49 +0000
Message-ID: <20260616214652.2157032-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a couple of issues surfaced while working on TLB optimizations for
nSVM. I did not add a Reported-by tag for Sashiko, because in both
instances Sashiko did not report the problem (or the nSVM equivalent),
but it spit out a false positive that lead to finding the problems (and
I don't know how to capture that).

Sean Christopherson (1):
  KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02

Yosry Ahmed (2):
  KVM: nVMX: Always flush vpid02 on first use
  KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU

 arch/x86/kvm/vmx/nested.c | 62 ++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 30 deletions(-)


base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA533C141F;
	Tue, 13 Oct 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933459; cv=none; b=LdWX24obCMFfR+acSbg14cvnt51dD97UrV4G+zNmScVVPWvHfF51LquCutQQP+OcaNb2522P6YRpVJQA3mk1BvuCf+YBqmiqxeM+YsUxi1/7FUGyWm8T/iYdJ228C50JF7LTWgEXnWrWquB48SPo5nPbbOA2gzpRwqMXm/IY+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933459; c=relaxed/simple;
	bh=YfRUSc4c1XTM+mkyLRgJihenqCV1ak6iZ+ls5LVPB3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INbE14IbMHKHkJUCPNj+4qM6vmS+R6Rn0I8vt/43nuhLC8ziQQv56dj3OQs1PIHvWv3yzvD2N8SD9Dk97LX1bdJUKRlIFuMeDA3XrL9/dHFyh7ErGAeO/Keajhy36o6ykA6u1yB/Yok++0bCTKChaV93/Ath/d14x9qjemJ1YX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpdUtNmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpdUtNmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F221F000FF;
	Tue, 13 Oct 2026 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933457;
	bh=6hOLIuyQKlijr/OMJonUwq7pXnd16BkqW1znyzTaKH8=;
	h=From:To:Cc:Subject:Date;
	b=JpdUtNmAj8yqsAD8+dM1eArbKcwmYH/o4/LWTfDyX27uCB0mxgcXYpbXVAGLnCJQ2
	 QmzMgwPTh9xEW+JzsE6gAfbKIIuWPWK2FeclTPHjWb8ExahvsskqX/5VITij2KQyuv
	 RVgqJ9UA95ODN8h8RzuYJouzUD+mQ7ytaB8740qDvkMqev00BJlQ+Vojy0oJpp5HxI
	 qhDQ9F3sZ6M7tZfJTR+wRlVoeCruJFbFO97W0Ab/WA+tf2KfqiIpdWKlU0qTISe/4n
	 TUJrvfvA2vvXv7ty94Hao4WomjbePPtSdIj7tJNdDj1gUo4/CQ+xL36vSghrJMypfu
	 CGhcW9XIVHi+w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 0/4] KVM: x86/mmu: Don't sync cached roots created for a different MMU context
Date: Tue, 13 Oct 2026 23:17:24 +0000
Message-ID: <20261013231728.883001-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invalidating an address, KVM walks and syncs cached roots using the
current MMU context, but cached roots may have been created for a
different context after a nested transition.  With TDP disabled, this
lets a guest trigger a BUG_ON() and crash the host (see patch 3 for
details).

Patch 1 downgrades the BUG_ON() to a WARN_ON_ONCE(), patch 2 is prep
work, patch 3 is the fix, and patch 4 drops a TODO that isn't worth
pursuing.

Sashiko flagged the issue while reviewing the INVLPGA emulation patch in
my nested SVM TLB series [1].  The host crash is easy to reproduce with an
AI-generated repro (with TDP disabled), and no longer triggers with this
series.

[1] https://lore.kernel.org/kvm/sashiko-outbox-163479@kernel.org/

Yosry Ahmed (4):
  KVM: x86/mmu: WARN, don't BUG, when walking a cached root with a PAE
    MMU
  KVM: x86/mmu: Drop for_each_shadow_entry_using_root()
  KVM: x86/mmu: Don't sync cached roots created for a different MMU
    context
  KVM: nVMX: Drop the TODO to sync only the affected SPTEs for INVVPID

 arch/x86/kvm/mmu/mmu.c    | 76 ++++++++++++++++++++++++++++-----------
 arch/x86/kvm/vmx/nested.c |  2 --
 2 files changed, 55 insertions(+), 23 deletions(-)


base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.56.0.385.gd3acb90ef8-goog


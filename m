Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E333E36A;
	Mon, 13 Jul 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965741; cv=none; b=FNb6J1d6tllsCdylFoljZj9+vSxc6/6Hv7RPOqzs+d+eiJLoy4tGk5+gFWv4fq04nN/CEVqO2vI3l9YLLOHTHmIZ/15nhdwD03xE3QBVV5mZs2E3jyhADVoI+cAYf383gSAuaQnjKiFXtwe7k4/Kb80miiY/HpwaNn0ccepEpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965741; c=relaxed/simple;
	bh=VH9SDY3eoVEE0skXMJ/TvCetjAUvpOkchGJ8b7NfoNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQo/pGDX0XzeTU17Mx5A3SsU7WB3RscT0tQ6teFk5sQLk1rrNmj0uwmN69nx2CaUW21bhEAhedQm+9RN/gHqXVRSriAndns4go0KmUJRJzzMjLWhbrMWzD7RCN4JMeFpK3GFoTsWCxb5iQ0hID7uCJrEhUOEqRq0zktrmbzwGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnRczg2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnRczg2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222F01F000E9;
	Mon, 13 Jul 2026 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965740;
	bh=fnazSepY4P+JecMp13VnyvnDdcSGH25z6KIHzq0AmnM=;
	h=From:To:Cc:Subject:Date;
	b=FnRczg2HZfs6CumbQ9OViuWdbO/vqaLV8ehqZJeIK/dQg8q2Ykj6nNiuo/xdVapDJ
	 yKOAUQNLnfI4ASh1B5ndUDNIfzJKsjXCbzDROQpo856+ktOwc19dBAVw1RnaAuGzbf
	 pqG88efuSdoyoir+Qjsexn6DleP+tICBPRkSN15xN7BFwvmvSJK0Ka79+dkuYCNlm3
	 yla1VBsI0SauuVrjJAAfnTg/kKx7WmW+vspQiq3tsSeAfYaZ3yZjoX7RKKv7G7KQPs
	 4jb3vqAhVm2Im1fa6iGcMS/sY6AIKEOiekBPOSsm3YfUICMs4kSNei+AsvHmgUkX95
	 9WA3gnMebJWsw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 0/2] KVM: x86: Fix missing EFER validity checks
Date: Mon, 13 Jul 2026 18:01:51 +0000
Message-ID: <20260713180153.2728382-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 of the EFER missing validity checks on KVM_SET_SREGS* fix, split out
a larger series of EFER fixes.

v2 -> v3:
- Split out KVM_SET_SREG* fix and selftest.

v2: https://lore.kernel.org/kvm/20260706195413.1966458-1-yosry@kernel.org/

Yosry Ahmed (2):
  KVM: x86: Check EFER validity on KVM_SET_SREGS*
  KVM: selftests: Extend set_sregs test to cover EFER

 arch/x86/kvm/regs.c                           |  3 +-
 .../selftests/kvm/include/x86/processor.h     |  2 +
 .../selftests/kvm/x86/set_sregs_test.c        | 83 ++++++++++++++-----
 3 files changed, 66 insertions(+), 22 deletions(-)


base-commit: 3aec122bdcaf6f8c4ecfc7f6adf6773015ced676
-- 
2.55.0.141.g00534a21ce-goog


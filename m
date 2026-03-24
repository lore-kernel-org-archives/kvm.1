Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FD34B437;
	Tue, 24 Mar 2026 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385961; cv=none; b=kLwb1dQJHoFplZmSsfpCsmP+RgCVhrC+GhCSFVaMNYCf4B5iTihN006p0qXzePJ7hAt2fE4dldvVzb/lB/MSk1riRejriGTFiGVaabAxNlvXWeLCKQt8NZVtcQD3d/+vAUpiQN6xYXHmxHZZSRfQzwKstxj7Vnmg+cjwyvkS2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385961; c=relaxed/simple;
	bh=L0z1Lxs42aGCTvghHSEiaza1oFD4h7rrHSgTZgAQqZg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AdJPXrQJs2ZEV8P8tfA+7uIjH/BM1ULpYKK9KRUeC/X2ZqgVSbeMv+4/EqnkPo+VmOKKwJhAUVuzU65mwzTY+NcqQMC6kIcWlidfBf2pojdy6BI6DJeepMdztTeQqcVHC+7LznCWLl+jhsnoBjSRkI7g5PZsm/9//SXPSqwFvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3x39OxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3x39OxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7BC19424;
	Tue, 24 Mar 2026 20:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774385961;
	bh=L0z1Lxs42aGCTvghHSEiaza1oFD4h7rrHSgTZgAQqZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g3x39OxApG+v0jpWSEJrODD6ypk3m7v1WbSqdse3eGtetp4TOTHxPKVZEjcAH7UKP
	 e/j8bPU+p5kQQH1ulgYSFrBNFXpO9kP/y8QXVwSGgDYSWukrgDG02rFFOEJicjVG0x
	 skLNGg1jUl1Gy5pSwUWJr4Z8IQRDiG6IrsV0JU0LPfnQ+0inazuzuTimX9FyV6LHG0
	 Ehss198U5e2F//cZ/RSTVF7DD0kp2MuCYCY7AXTeMcpt+UDJR1g37d3QHfS741raVP
	 wLowhBkFFNS2jUZimw50jdigoowEfFwTrPV/okILxZQ5AZ3hjukK/Fq+Ik0OCDwwCP
	 YR/nmsE0mTYrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DC83808203;
	Tue, 24 Mar 2026 20:59:10 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260324172355.795530-1-pbonzini@redhat.com>
References: <20260324172355.795530-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260324172355.795530-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 52dad81e4b3b2087e38fe522da7465e6d0160ddd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24f9515de8778410e4b84c85b196c9850d2c1e18
Message-Id: <177438594860.1304315.17738380645061518811.pr-tracker-bot@kernel.org>
Date: Tue, 24 Mar 2026 20:59:08 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Mar 2026 18:23:55 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24f9515de8778410e4b84c85b196c9850d2c1e18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

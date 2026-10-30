Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401834;
	b=f3VI9DUsw+k9o1CKVHN72Qp3dsrCOU2ngNQa+xe5fVGGJBHFReJ3lxjd4zCErcSSkEZd
	 5GDq9MM/K1xB1GohmajjMwSkBz72kYAp/gWETy5XBQb1t5dUJdEYoYBx39knXh8nzHEJD
	 qWcGw8MjFQjpNUovb0i1HJc9zIpG5VI/KIl0G58XtXrhl8GzsJEkXaWniNnTtB8OroxZ9
	 Rb7lUyHDZLAPvfNnbl8gWC73qefG4s3LGWvgdLwojHyOWvO/ckkuqNNSrgwhbDFxC80BX
	 P7foPfYapkoA0B3FoWXASy9e3KErCQveQjBBAVMAz6d1rV7gbfNCL5NHDPyyw4ljL3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401834;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=dgVEPLHZqfk4d+u3xnhqQ4ndErci4fteR9VmyPU6UbY=;
	b=vv6n/dowS1mxXwW9JJCeE090ifB3MSjqi1iF4sXUYtf+ccmOO+7c4+lgPi7xrd5HZ5zS
	 2P03voscjKMfkU/ZCCVX9gyEfLT7epqApRJ/SUxH6FnMsdkR9YPPk4m3IUmAD5vKCRr4W
	 agr6QxFLx8YpOUcpqwBwTnUfDPZSK2MA6f5H5NbdM1Kkz+Of07IjR08zKdASVh92wIDbY
	 xzzLvh6bTUuvRAIlGNV2lsifSx5rU4Kjucj7sr4j76sn3M7K1XnmHZ9tXWcHr1tA6XMcQ
	 hldA19EK51ZKFhFRmTxV5fLNrfHJ4afWo4hTZlOEOT90v+ZOA0RwrFk+GvrLYDPczGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CcZL/xUc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A19606A332;
	Fri, 30 Oct 2026 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcZL/xUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC21F0093A;
	Fri, 30 Oct 2026 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401833;
	bh=dgVEPLHZqfk4d+u3xnhqQ4ndErci4fteR9VmyPU6UbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CcZL/xUcB/ma6IG1xJqjP9D7DwcQYDWU0CDMBLsvxL2pGgYhygrrv3e0fwsNoB348
	 deKD60h1LAVuFQGau/n7GGORACuNHj9CzehKH3Va/b1dMTX1pJU8Xdxxao2ZENH0TB
	 eCUs3hKZGl2Q0wmOgtB7OCpECSpEb+ksSYNNZevxfjuvYreLrPgN2egIMu/YzxOPi9
	 oKBzH4O773WAhRKT2xXzmQ0xGHL6uOufqR3o+jkyCdsjCz6eF2z1PbQ41jxQQDPnga
	 uxl24E+p721dnjZubW4qdqGugiBTiZwoGrg+DZm6kJoZ8NdzTucYPolmruu0WZFlc+
	 4YtGEe12nFpVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2363800478;
	Fri, 30 Oct 2026 23:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 7.4 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261030182552.1269009-1-pbonzini@redhat.com>
References: <20261030182552.1269009-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261030182552.1269009-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 1689c80fca308978ea1c9f03d15a500f4e44e2e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17fa96334e15c6b38e8d9dd3627f3a6c5ca034f8
Message-Id: <179340183246.1820250.5285511143655935710.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 23:10:32 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 19:25:52 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17fa96334e15c6b38e8d9dd3627f3a6c5ca034f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

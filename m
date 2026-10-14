Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02F252917;
	Wed, 14 Oct 2026 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937026; cv=none; b=icQPL5pGKzyZiPYip25aYb+qf5SP61IkblpqxXmhzAMtysyQ9c39eh4aEioPpQP/7rYP4xVnU2gvsZ3fz+HRfx50kilrEI4JuGwDSVs3ChLPPzB33krBwtifNuXwbCDi59uDg5dgH/L4KtTIYYeN9Uk0yEzMbWGOvcayNomgKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937026; c=relaxed/simple;
	bh=58tTh9a47JzFEcKQxD5aujR2nU/s0ipIdjg158I53cU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XR2dD/kCuKDMRxmcjk5XjOVVDtKSEbeAQK2J9rAQb+vTc/5o2+WJyqkjnYZ5vbe6w1ke14n6JF3VlKs9nU6iOGpSnFmVF/DTCjcawvqJGvf4+L1ZeAvdRC2q/vOf13FblYAlJYXWFP8f0rXiThZmh+QnEYfgCDVta+PA5NIIyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tnth1lnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tnth1lnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E61F000FF;
	Wed, 14 Oct 2026 00:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791937024;
	bh=DmuFcx1leEsBIrgsAmOI36pFpv5ge7Aq6ZGscy7IVWw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Tnth1lnRPeZWcAvSNvbEfORblkubfBdHyxxu35rWK0MopSOCbgI8adjC4LBW9nqzt
	 GFrQQHGjUY0u21f74y5zLB8yx9Xt1axbOLq2JA7EOPC3f/hEcxQBBplj3kQ0gNu62Z
	 GtBa/znNKBUhhHNOrcq48B0r8928JdRVUvv4cdhXrYP4gH/CDEu4a8mWyVQAXNLUaB
	 dgEOIRsCpZ7moPBJQRPFsGfBxhTeuxMYqeMuA83B8EwbPHAVkwTyqv4VCqe9Uo8PW7
	 gNKwvw32DogHN0UE89+P8Bi8JpRKYzqfudWS5evRcJfwi75raCHMgXYvS4BuOPQpDZ
	 l1R19OgFT9dcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773B139E8A57;
	Wed, 14 Oct 2026 00:17:04 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.3-rc8 or final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261012172419.138525-1-pbonzini@redhat.com>
References: <20261012172419.138525-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261012172419.138525-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: e90ab3669181c6469e3647ef2b30ae408275f496
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03741bcea0a9ec4c8f386fd5c6051c1a14070240
Message-Id: <179193702302.1530094.14094330381307114827.pr-tracker-bot@kernel.org>
Date: Wed, 14 Oct 2026 00:17:03 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Oct 2026 19:24:19 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03741bcea0a9ec4c8f386fd5c6051c1a14070240

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

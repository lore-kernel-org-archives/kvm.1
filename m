Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5332B119;
	Sun, 24 May 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779653515; cv=none; b=Ch9eKAvrmZLKrAenWhiTHE4jAbljozgtUrAhmlSKoXxsxr8ILkczQaHdjEEIE7Bo72zjNpmhuA9nxxAzPlthBnrgGsLigsTkYL007KBXZYqV4UzGhm+/+L4bTfO3G/jXdCKKYtqdyX8F06OowVhhpA7Dg7VwGqEk+e5cvgMM7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779653515; c=relaxed/simple;
	bh=j9CJMnWWEzOaWDlvgEXGrROgjNad80FWRsPTi3xgzmc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=deuTVG3fHnt7dfCQn1AxcM9Tupwr1eYm1vdU0KHpPD8wvi+TKon6ksgEIP5aNVHUychETQZDaWZl6JxwCW4jcZ+h6Kiq1tcXCbpZIRN86X3jPYwpWoJWm8S+ualzXAuaDCOdD+9PyT8uxyxref2IyaPY9CpwZp11mwnTXczfc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrcY+il0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrcY+il0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698C01F00A3D;
	Sun, 24 May 2026 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779653512;
	bh=W0KYrpady89eqncpCsMRmprZZU2zqFQeIrp0Dh+CN6c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TrcY+il0ETSEdFhkM7qtxtvT7UHdqtbjFqL/eCgnq6Y1SrAciOBQ7sR6K0zEsTGhL
	 QYPhzP+68RC8kqnMyQC/s9JkIs7sgAmv2YU8f5S57bwt9Xea8NRrk5DsdpmoEo45HB
	 RToAmQ2XQv75ChZTZUaGnpI/eV07+dZswgfPJ+yhKCTx6vueXehma4WHgS1Fedv32z
	 gWqoHXeBfJHIP8q32uLbzEJJignYyd0KnYn4uy4WZKj7jiFnSibHsKDMGybGWiHsuu
	 GKp/tWU23SdveL2EQeFPIQR3DCEPYlTMQMAQQ2gjckBjdbVNoxxVLKTgXteX9298x9
	 vODixFGY+x4oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199C93809A83;
	Sun, 24 May 2026 20:12:01 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260524074341.36685-1-pbonzini@redhat.com>
References: <20260524074341.36685-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260524074341.36685-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 9a12fa5213cfc391e0eed63902d3be98f0913765
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a97c4d5262d02f04d1f41113b0d090ea51f08dd
Message-Id: <177965351975.1864217.1580736158917295112.pr-tracker-bot@kernel.org>
Date: Sun, 24 May 2026 20:11:59 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 May 2026 09:43:41 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a97c4d5262d02f04d1f41113b0d090ea51f08dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

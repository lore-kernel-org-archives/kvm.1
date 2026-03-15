Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB73364045;
	Sun, 15 Mar 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607941; cv=none; b=rOD1u7VnKzwg2iaH4N68RppLNqovmVvJCnZbzFPhCCztWpIK/i27oFljgIPh+74yDbfcHKlCAvvAIg39u7/k+oW598+GTKtfgwIIIK88DQvzRopyp4ogFw/1BaYOrhv0YDaiDAOV19SpuKynrLHyQQoOlvsxEUDDYgO6QQUb4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607941; c=relaxed/simple;
	bh=F++goSbsAtFO/ybAlbrW6qdsXdB28u5+Y7DLOfxu9nE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jN9eAV5AntYx4B6qgAzLjt/yjyk3i9tGKrch8k2ZhRA85ZNGOvR7uDorCNERnVxhwHiCDrsxU/I2HOtZY1jEfPqOzWh1in+TonUgFR3JU8zLUdbO3e3nIxv9G0te/hCbrlNVKH7XzdQdGh+lxhVNHFnxGQv1iC/e/RPTwgtWv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW6gYRHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW6gYRHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48668C4CEF7;
	Sun, 15 Mar 2026 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773607941;
	bh=F++goSbsAtFO/ybAlbrW6qdsXdB28u5+Y7DLOfxu9nE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZW6gYRHWJr6JfbJfF/EjEKkqw5RQ+hyLGioqt9jUh1wnT9OZRA+WTz5PNf50KP4l6
	 13wlTOSAbeAms3dMsejBRWtkEAbrQAXF6HsYstiK5aXanNq5gPo+lW7hCdZbq1itaB
	 p50RJEpAptq1el0+FFDvGN8UAjV47TiMdfixESSp8ZnUy+nobVLAuRMSzwzQUA3Cwa
	 /tgVIwmiNUX08a+KUJsdZjsc9mPuLJEUQkWtucPKnNk15g6aTcw8L1xyipqzj6OGR4
	 gguuFoypOlmNlHPV5hcRgjS314THuAGxYSVR3VszbAREeAXCT5Yk5N3jCnEaZNW5kf
	 0tJKnUYJ9sZjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0318F3808200;
	Sun, 15 Mar 2026 20:52:16 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260315065711.249669-1-pbonzini@redhat.com>
References: <20260315065711.249669-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260315065711.249669-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11e8c7e9471cf8e6ae6ec7324a3174191cd965e3
Message-Id: <177360793451.1993738.4805107153767108916.pr-tracker-bot@kernel.org>
Date: Sun, 15 Mar 2026 20:52:14 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Mar 2026 07:57:10 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11e8c7e9471cf8e6ae6ec7324a3174191cd965e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

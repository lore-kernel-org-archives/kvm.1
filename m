Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595F27707;
	Sun, 29 Mar 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812483; cv=none; b=l3mMak5i9w6H/t4zASgMpfB6lfjOpmYZAfAaPXhMf58yLzycIWuzjRjfNs3f2RycL3cZKzKGCc3RFSZZOh+m20IdiDJdzZx3amiLs0nRwHiEDZrGlLwCP/LOgX6zH/OHZCTtiuNp3k+hwhePt980yBAUKDostzpSjl9scS26mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812483; c=relaxed/simple;
	bh=QVzsCF2AEbEzl/rioTYArTTQuMD+HsEjvwfIqDqMzJM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EqUP7y0stXtOoFGuTZ12/gBfVBE0qE5Tz957S/WcSZmG9tej0asAjYeinZQaMRPFaTud9ScZaiW3LkWY61DTMxhCjEOiAmtp8x7nCJMkHpcQWwREZByuMbclk0gXlqzwNiS8D4nWe2FPwKPkoxs20jEh832nFBKnFzi5VKG3JV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGLsG+JW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGLsG+JW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCF9C116C6;
	Sun, 29 Mar 2026 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774812482;
	bh=QVzsCF2AEbEzl/rioTYArTTQuMD+HsEjvwfIqDqMzJM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OGLsG+JW1dF/8JJ9f5uMGE3YLT6v4LVniN53DnMep8qxi9Y+PRtHsbrbpBu0ZIy1H
	 HdnZIfwwZPL7/Wf1b7jjHFvw8i6wieveZWHJ8+JjwwuNaz2zEgDg4b4JHbsfBQPxNT
	 4wuRgC1RNNPFgzrE2C6d4t3jv9KKkxbLDElhMolxu5SsBeZdqCRNf1fD6dwyHUN9fP
	 wK18DE2yRhMzzvGNfYlkC4Hm6PcHWja/YBSlOxH3B2hNehJ/bZ9fH9p178AusfHxTF
	 SI8o0R0KtYTC9LMrIi8wOHCixm7l0uzzVBbHpd8JDnub7wEIxJ7PHxx5k18fgfB8ml
	 vOTAQ50b89o0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0953930012;
	Sun, 29 Mar 2026 19:27:48 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260329162027.105662-1-pbonzini@redhat.com>
References: <20260329162027.105662-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260329162027.105662-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: df83746075778958954aa0460cca55f4b3fc9c02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac354b5cb04d2077c3821a6cbfbc7981ad45f84a
Message-Id: <177481246727.444538.1012498438681342737.pr-tracker-bot@kernel.org>
Date: Sun, 29 Mar 2026 19:27:47 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Mar 2026 18:20:27 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac354b5cb04d2077c3821a6cbfbc7981ad45f84a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

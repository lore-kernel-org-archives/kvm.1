Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D5383C9D;
	Thu, 23 Apr 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961129; cv=none; b=aaiqjg9FKAWTd0JqQwAcU8wo8pP2LErYxTcg4hShl/0YQhP/38kMKZZuQrl1oP4dqHhsV2kvqZ/ikgonUVYPG9CWdeqUO7dtzOiLmQcOzdTQb0Pc/hxSPsgLB9WEmzg1bmfmIObItXE5wTE8F2+xaF4rGDmTgDHM1hmYknxVkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961129; c=relaxed/simple;
	bh=ry9nza6CM990KkgnFuK65dchTClFVOAsxrRLaS4fM9M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ocm0mO+lMas0+JnAC2wUiH9MSsSvHLCzbgwhtOi2h8dUkkVz8I+eF0FlY8cxfvY1huqjZ1wfNoH9b/0WSz95J82D3lWbjB47AT1X6hJj/p+ZwFTDsMLKFAxejCdrey9mZnDZt9/VCNzsyOQWqLVnB05O5hNNLoXjGlEThpBbiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV0JmptZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV0JmptZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E0C2BCAF;
	Thu, 23 Apr 2026 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961129;
	bh=ry9nza6CM990KkgnFuK65dchTClFVOAsxrRLaS4fM9M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qV0JmptZhzw+OgxdWu4TLKY9dwh+jDMGjpWZ4O5EMFHqGGzaks+6pYYBAKzTN28VH
	 TsBfuzqUMsGYHGltplfYZQnMD2jwN+nvDfJqhC/aqHbDeEsQByz5G/7zHsVrrDjhlX
	 GybZDsZXGncv8aXTTuXZwoHrvUj6tJoRzKco+DAZ3MTFxoOMR923izvaLRg1vwWPSi
	 dwpS4NvvfHMu/UXKjO5GlLD/qzYQNm8ZZu/rZ7S1+NLHa5oqX00tLhlV5Z5ADHTEmJ
	 HLyRpRcfk/rn+o4LirIHWXleTvVxp5rOTPRtUaW+hkcbBwH7O0sAzJLlotF9IEyZTi
	 BzTixtGFWLbnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFD438111CE;
	Thu, 23 Apr 2026 16:18:12 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v7.1-rc1 (part 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260422152018.3fa67154@shazbot.org>
References: <20260422152018.3fa67154@shazbot.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260422152018.3fa67154@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc1-pt2
X-PR-Tracked-Commit-Id: 30471982cd667972ba93ce894765d4b8544958e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df7bf834a135e1f5bcbeecbec07605fa5d92f0bd
Message-Id: <177696109093.655676.8325417777245613703.pr-tracker-bot@kernel.org>
Date: Thu, 23 Apr 2026 16:18:10 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Apr 2026 15:20:18 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc1-pt2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df7bf834a135e1f5bcbeecbec07605fa5d92f0bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

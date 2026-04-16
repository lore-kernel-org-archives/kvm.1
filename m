Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0E1EB9E3;
	Thu, 16 Apr 2026 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352773; cv=none; b=L8AtUe/oumpEqBvspkV0hc2WhIkyGvRKaryHTtxg52AQNhK+U8is6cB3dByqzoc2uWlc3fAH8eTY+2fdw66MPxrUmDwjwRcj4wwkcDObOFsHWriRBlmlrGL2K6p7fySHB+j0km7bXM3f+yU+5jCmkTd5C7f+4jHf4lA34O5rZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352773; c=relaxed/simple;
	bh=SQGLVm8+gwSOrgHOnztkAy3QZn6FCqS4QKL2GjnDUUk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fVL2Bb/xMZKWdNDU8P/0sNAZbncWJq8tNnwzZi2ely/KQ1dLgEc1AxpUWxFsKuN2UxeUco7jiydh+V69YU6ygKiAETGCwIDTrO6PyvDDZAG+G8QJOPxUTw9jItwIW0iKPa/qE9ZUW7l5LmBvkpCsBk8Wwbc9aNge8NMsyy58wTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grzRA+ry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grzRA+ry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6F4C2BCAF;
	Thu, 16 Apr 2026 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352773;
	bh=SQGLVm8+gwSOrgHOnztkAy3QZn6FCqS4QKL2GjnDUUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=grzRA+ryhchirqv5RftkKe9XLqOgJduUF3rrMorD9QYHOWO4w3TLM2cCoAZI6YltL
	 ZUhOIav7TzWns9ZBRfrwkKfpS+sr6TSwNNiOLFme22PdkbLFEnpp3/7YlJZSR9pHUP
	 WSAgaRXkbfUNUHOf8XuqJeFqXpLbD/ykg9CKNUPdFAGU09dXqRik5jy01vnKusmE8Q
	 fg+gBR5iCk3Zj7ZNQDoJObCnXf+uHja6MG+8/CA4Ip6nTr3SrPu4oOLogm5QO0XGCw
	 xplcVXbRKfFa4thl6IP8jVtqYnp664mLovzeBtyACuOTn/qAqHX8h8JnA+c4OQiQfo
	 dVWs6zGf4ViZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F95380AA63;
	Thu, 16 Apr 2026 15:19:02 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260415214915.35831be1@shazbot.org>
References: <20260415214915.35831be1@shazbot.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260415214915.35831be1@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc1
X-PR-Tracked-Commit-Id: 493c7eff3c2ffa94ce3c5e62172948a1e38b491e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0bf3eac92b2be5f34b944cb82f1c23db642c7f5
Message-Id: <177635274142.3274006.11116553090921142707.pr-tracker-bot@kernel.org>
Date: Thu, 16 Apr 2026 15:19:01 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 Apr 2026 21:49:15 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0bf3eac92b2be5f34b944cb82f1c23db642c7f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

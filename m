Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866623E4C73;
	Wed,  9 Sep 2026 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979150; cv=none; b=oX1MJvMq9vrhBIS3EJnjzd8/YLIpsMsq99pOSDKGTtYpi2QTG98LQF3o8j6WKl4jUetjbr/z4dVGCSoLTeUF39rJPACOO1xEs78UKZad5raqmo+3dJYtVMkFwzvGLbS0gFhUfWclY8h87A240FgMLcEd5RY9yiKAFxC0pDruV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979150; c=relaxed/simple;
	bh=Nw9KAnbZf4r9Qnp5kADDzg6JMDKcvWJMmbfOuqXIlmE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aJvaEooxtlCqKvTKEIpUIM04YdrqK+sufyhavIiexAucDMuwBfRRly8Zf0D0K/SOvCWxq9xHtnHOqfL8gGpxgkzQMhMJTKjayi94/daxYdeTb9l48rmri4cwXXYEEi0tlnk+Dpnpm9Yi4ggPHAJWfde1RiUDoqPy9aKNJZPzuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RewST8Rc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RewST8Rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A461F00893;
	Wed,  9 Sep 2026 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979146;
	bh=4U2dqUB9rYju9cGE8O6PTrlGgiUtfu8eS/aeTlHfcVs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RewST8RcPI60gGZzPlDKPNeyQNRvWZJtrm17xtCNXOt0pv+9zkAu2+8mzs1qEGhki
	 S1C+B02O1ee8degPKbCw1unLfz0TohfvPYkihQRXDe2+J+BifukYmLZAcUKWtuSvFz
	 jNUqEgJHvDz46SGKPZOmM6xl4RDwsPNveykBrfIBUoBphEKV/fbpr7/dmd6nTfoXRg
	 te62lNFFjs+PQ739b0k/SheX58NZIvCbMaAAYD+TaCz9vk0MzBjdqei7ZpK0rPvZJy
	 4Fsum+A0DiHLHQ2J60zWiNcQuI031qhVDW/XzW/Kg/bYbqHaU51JROEQ1JYLtEvfVR
	 JdmJ/OYjVG0mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD2380AA52;
	Wed,  9 Sep 2026 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa,virtio: fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260909054245-mutt-send-email-mst@kernel.org>
References: <20260909054245-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260909054245-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 48a4ee65e677559776349128e6a81a6041986c99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f3989d75d33414389a57e78f4979931a0164df4
Message-Id: <178897908417.999556.12078163197648897722.pr-tracker-bot@kernel.org>
Date: Wed, 09 Sep 2026 18:38:04 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, astellman@stellman-greene.com, dongli.zhang@oracle.com, eperezma@redhat.com, graf@amazon.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lvivier@redhat.com, mst@redhat.com, nikhilljatt@gmail.com, physicalmtea@gmail.com, xiongweimin@kylinos.cn, yuz08559@gmail.com
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 9 Sep 2026 05:42:45 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f3989d75d33414389a57e78f4979931a0164df4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

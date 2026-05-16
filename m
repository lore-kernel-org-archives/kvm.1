Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577B2B9B7;
	Sat, 16 May 2026 00:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889957; cv=none; b=pwC46+ZLINAqiSGCeIiS7Xfzvh9n1C1xDneCdAG0uUCB7Ws4TMkv4ph1jqSa+C9PjyHHGDpMguUC21uFRvEdDvxp9550GtHQf86f+o9Ot5+DGGsIYx9S7HvHeQjlaz4kAp2K9Dv/LV3NbZ+3d2Fpiv8tCiHkTqI9myyhCKyVE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889957; c=relaxed/simple;
	bh=Ohe0netOEs2zy9WsGB7dVA+35837bZi1ikr8Nw8Dsb0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MhMx3zTyOjo33hHr7qAJ8lnmkazvp5a+P5bYBujN+0aPWaWlJRjhnoU2bdF3GQxzGxaIMJwp8+U5qzQ9QByE5m1qEEqNbcnHNTVBjw169d7oxdayAGE9BiXaeLRzxe7QkBvoiE8cHiVb0TKvQIiidWYUsLxU4O5n5yn19ZCphlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVOOTwR/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVOOTwR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D625CC2BCB7;
	Sat, 16 May 2026 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778889956;
	bh=Ohe0netOEs2zy9WsGB7dVA+35837bZi1ikr8Nw8Dsb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oVOOTwR/98ufVJ6yYMKkOqOv9uq6f6HSFI32IRRBsVvh7kN0cQKZDLSRZ47WDvTdy
	 Zl9FN/JCaRuAYtkp+dhuiR79HrJ4sqsc89wCOqtdAVgd/aUrs47JyiTx9Va/sPBOm0
	 cOuugHm9waBpBY/Th3hUuntkXyjc9jkL5n6rkQEaMKNDK75pdpUdNHTijk15kBhYGx
	 WVFZ9TqckxUad6S7Bvia9p5VOBGuN6ZqjIqnZrbUNl//p9dkM5CEVPk1TyWCX7+9la
	 ureIER0bTUnYMTQi405KBOqQcuBaWSPie9jTseUddQvdBd5QaxbgiHanhJ2gn/URVh
	 UHaZUa1qMzP8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E43930A23;
	Sat, 16 May 2026 00:06:11 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO fixes for v7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260515112241.39f9df48@shazbot.org>
References: <20260515112241.39f9df48@shazbot.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260515112241.39f9df48@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc4
X-PR-Tracked-Commit-Id: 702809dabdecca807bdd50cfdcc1c980feb2ba62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bf83e47b497d2630d2dcb408ec14ad95050cead
Message-Id: <177888996993.203181.5860381863995091732.pr-tracker-bot@kernel.org>
Date: Sat, 16 May 2026 00:06:09 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 May 2026 11:22:41 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bf83e47b497d2630d2dcb408ec14ad95050cead

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

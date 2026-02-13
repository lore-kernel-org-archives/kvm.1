Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA836BFCE;
	Fri, 13 Feb 2026 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945482; cv=none; b=q7+SWU0o+oHBKq46vIvhsfrf3fu/vxJsWMe+Ww8pYzDk7J0TQ+Erm29doOffal5ZsGW2wi9akPHkjyxGj5NjjgcGvbYxMFSNVsru4bLNJcAG31I50mWPetheuMr/FCFYvFnMEli0nP9cOXz7NG747tg2r7FYK6aX+WW6AOWtUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945482; c=relaxed/simple;
	bh=nMf+v3vGw9GxsDEKxkKutGjHtACwOXC3416TZoZsEuQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QOFCMPL4IEPhQRDW2L4v5mvqSXQ/fjuT7bRXujcrxNZcebxzJpfjUogFdrj44ij8aXmW9ftbIxHf7yqv+URSLJJbyCQFNm+hNA0N7vKQg7TjsVzi087lLH4zcxx/Y8CrY1N0K1hL58YTKBiGaNDK5T/N2eTkUEQLGASC7EOIULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3Q7UsNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3Q7UsNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E06C4CEF7;
	Fri, 13 Feb 2026 01:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770945482;
	bh=nMf+v3vGw9GxsDEKxkKutGjHtACwOXC3416TZoZsEuQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d3Q7UsNV+Peflri2TKUn7hbizMDxxYudk+nO+j6X+U3vkBjBN4k3O+fwzZgV/A+fP
	 633zu9rXR80XdcwVs8QnUXTc4whLCmnZhSTNwmB8AzO4QJWzWvN/qLtCXeNEj4C9AN
	 P/GGrLQCftY96kOOrEF6TgBf4bNiDvTZ7UutpnmlSohT/S1ED3qmmSujK6J8HPbR35
	 Rtfv/RThw4srPn7jt/Phj8vpi0G8/44KrYl1mG23waMHbM25O4BQ0gjulibFT/iOoi
	 aFEmVvtu7AAD/cKT2At/+2V+WKMCJEcEjL+1pE23cWH6PhJQQSQMAf3HZcIvlSQoLs
	 1B6rq1AIfFd2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2425393108D;
	Fri, 13 Feb 2026 01:17:57 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260212141525.6974025b@shazbot.org>
References: <20260212141525.6974025b@shazbot.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260212141525.6974025b@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.0-rc1
X-PR-Tracked-Commit-Id: 96ca4caf9066f5ebd35b561a521af588a8eb0215
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cebcffe666cc82e68842e27852a019ca54072cb7
Message-Id: <177094547633.1792804.12624497517888579251.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 01:17:56 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Feb 2026 14:15:25 -0700:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cebcffe666cc82e68842e27852a019ca54072cb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

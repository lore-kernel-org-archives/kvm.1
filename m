Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E63DA7CE;
	Wed,  4 Feb 2026 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230965; cv=none; b=rmLDJ1PFY6Y4rJBkutZz1cT62IqzH1OsVttrinJNr6M6cq9nPJxYStzZc7TRZrdOE/Pyoo5k9FVol1PwrERPTf9js/jC1wDjsXhikl4v+r+fjOlQGcDboP+/Q/6R7uoFj5FUpcUTtYDnyqEnOKHKYou10sKKgY1NH/tsa6rSAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230965; c=relaxed/simple;
	bh=CP//iRJXawB3TPu7bul2ZmaEPILlCQ82JYQhhLZzjR8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KVGYokQOfwRNpIeBGoXVlzLnon19nDQGwgqrJRGR+cuthCkguxReOxvw6FQs/pZk3T37++UXTO3Nflkd/UL0KveI9bunkGIMCiMUO+yyrFbYQgMJkqmmFkpI2BUWCNLaJNvthjG/2h1N/W5RCckWmMFR+xWCbXi+mgqOl3RY+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+MsPTDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+MsPTDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD32C4CEF7;
	Wed,  4 Feb 2026 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770230964;
	bh=CP//iRJXawB3TPu7bul2ZmaEPILlCQ82JYQhhLZzjR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t+MsPTDr1vb+J+b3ntsUM9jCdRWy7Ql9egnWkY2wRKop5kCO/olkqOyFM9HFvmRGe
	 O3OkR6v8skq/1EQeGo7t+im89zA5/zVmL9GWQqIt9yVA7JQd5ZAZ+jGiApwd7Yl8ez
	 rFyuhn4fxQZ4no2BElCtz30zsULl37sQ5rkHHyZGaEYN2IpapIJJ2IxrDj4yjBC2fh
	 NzH5WvqOxbV8njT8TEiO7n90Qhe+iDj2d6X3JXpaZDIyFg+Bp8JwSh6rXSDFS9KnXq
	 jLMus8gwt3p8fsRSKVEQ+lGBUvf8FtCWTCxuKalCJSbIcEqqZr3ozq5EhIuhw4KF0z
	 FY2bbJcNMy4eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B4753808200;
	Wed,  4 Feb 2026 18:49:24 +0000 (UTC)
Subject: Re: [GIT PULL] Final KVM changes for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260204175509.163280-1-pbonzini@redhat.com>
References: <20260204175509.163280-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260204175509.163280-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 0de4a0eec25b9171f2a2abb1a820e125e6797770
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27db1ae6ecdf23f4176276da6037eaafbd23bf94
Message-Id: <177023096266.20076.8450701601882633761.pr-tracker-bot@kernel.org>
Date: Wed, 04 Feb 2026 18:49:22 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Feb 2026 18:55:09 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27db1ae6ecdf23f4176276da6037eaafbd23bf94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

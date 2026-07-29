Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4541168B;
	Wed, 29 Jul 2026 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366552; cv=none; b=miqUFygExkjwQWniKb8prIiu3ErL9SvsA9R9ilJIbzj4iWl4TKrq4w+qNIJiGThy9Deotv1KCwqmGgg8GReINqiuoJCmQlALqYuTVKak2ZGGmEMkhfxk2EAiOi9cIJffkbbtmU1ubEMp71dd3bnFp7YyAe10I3/jGoJFoQkkdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366552; c=relaxed/simple;
	bh=xz9bqhWBuIFjVWI7kBlgm0V8SvdRR6T9tDuqwqbzFXE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LNbuYPsqA+XcLZQjnhADJxr/z98Md54gCjbNecPjgaPYNBnNkt8Hq4HZDy9nHXhfxyRxU2SQA5XC+7GJNKXcHzaRA8Q4AdAjAobomqv15Luc0F3/SD/VzsOzLhB8aThLPQACy1X9Xahne9bbjj2E1dKvDUa1YDwO6BnGrvVwErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuilhH1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuilhH1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983AE1F000E9;
	Wed, 29 Jul 2026 23:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785366551;
	bh=oc+rCb0PRJP5GvZ/w1NkCAStf3I6H589s2MysfNJVZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nuilhH1bPRQhTmzmockPBSHFCYq8aOHa10j7cKJ+Qfew2/7GmJimhKsdWLpneTFTl
	 rh58Y0VvZEAzD7bnEpNiG4mmG0LC9oWy80FfBJLhgLf7SSPjaEwa6Wi7NYFWrylCjX
	 E0tC3H69E+8JZJP8z+n+8EP+pIHE8uogjok8+jddSxEf5PJL8BMTu8tR5mCEPLEcO5
	 l257K/Ps6nZmG2qxgkgc1SYZ5cHJGsKpICPgdU98o/4BUz/fL76Y85ccSkFb/30VKl
	 KuOlavF1gXldYSTnCsPpmMh7qsTNGtFdsOLUYK+Omb5H7kGtzcNDKh57IWVflavQ6q
	 FuVUZmM1MB7tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CD9392624F;
	Wed, 29 Jul 2026 23:08:36 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260729214500.651377-1-pbonzini@redhat.com>
References: <20260729214500.651377-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260729214500.651377-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 7d3aae206663c4e006b25a1c7a20a4029e67da76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc46aed51f6280801f43a2cf4b5060cc33b572f9
Message-Id: <178536651553.3274958.12524000159662088067.pr-tracker-bot@kernel.org>
Date: Wed, 29 Jul 2026 23:08:35 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Jul 2026 23:44:59 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc46aed51f6280801f43a2cf4b5060cc33b572f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

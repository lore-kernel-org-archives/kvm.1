Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686D390987;
	Fri,  5 Jun 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683352; cv=none; b=jT665BQ9BF2v460Hij0wt0D9s3i1mavaBSJ+ygMZnqNtVwocmCT/ba12K14lQBd2RDBqrBTNn4JlcG7DELapq8GwAwgVqEEvjHmO03Ymoj75DSWzzA0IrZy9IM+ER3yox3XG7xcDtUPsP7RFn/C3px3EhbWkxxgNzhAUEq+P/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683352; c=relaxed/simple;
	bh=Du45GIo6mAgMt7hL7qPjbOu2hTFLKaehL2ikE8x/H/o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YavZXboaS6HTeNxVvQJ/nynCnGTM3SeCPzx39EgC+N6USjFfIUza5RpTAK+3bjalulTKmiXljr1VqgKyHXr5401BidgDxAw20Pq5g7gipmP0L2j9YOtnEx9lCHeAipBNccpF3hgQx813d7Sf5HTbfN7YXW1l8SbaAFEoc8bFeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlEUH8FV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlEUH8FV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAA71F00893;
	Fri,  5 Jun 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780683351;
	bh=Jx5IbW8Qwnmy9ZZLio/pk3Vm7Ueyl0Wmh8PzX0RGyeM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QlEUH8FV1MIzjwjS1Z8ngq7kW5DpkmfHRa6UiBzJ+4mb4B0Afopbhs4kxdLm2k+Ep
	 Ng36FnS83hO48Q1heFQ3ixrijnVkvSAj8cg7BCBd4ZURNPMZaY/4G9xhlYTT7kw+G5
	 Bffw2k6ziRu6/uaJy5OXI9J2VN80wnFn2tJjW91NImu4eStggfG4sgW+WSj4UBQ7OP
	 PjnHno3Q7nFwAqzeKC/G9NA8SPkG+uITSZLjQrptJCfczneucXZJ26A6fY0jkVEYJe
	 AsjcQmxUGrj/gKTzeA46M5E1TLI5SbL37wRKdaz4qavXg3aib8S1oVylxVHjELBrU0
	 Kpem+F7TvE1/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C993930BB0;
	Fri,  5 Jun 2026 18:15:52 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260605171359.183205-1-pbonzini@redhat.com>
References: <20260605171359.183205-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260605171359.183205-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 7ec0360122d8f5033177ed0210d5ad71ec5b50c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95b78879a80ab034cd56cc70f057c3cb4f2612a6
Message-Id: <178068335140.3867977.14360692300484017930.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jun 2026 18:15:51 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Jun 2026 19:13:59 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95b78879a80ab034cd56cc70f057c3cb4f2612a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

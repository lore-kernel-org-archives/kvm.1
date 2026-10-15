Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9153D0C5;
	Thu, 15 Oct 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077468; cv=none; b=DgWIk07/EOHK0WSzwHz/XpdxSQGT6hCOOoNZoX/1OTxluBn6Mk6bJ3B6l+rsigvXJfhCSwy57qZxcQYIhkuz0v8rTaMxOs8Qxxfr26DzeTx3R2gb392GeVj3ZeMiXP7TfeJcrdbyuVZlNRR2MFFZs9M2sOsjWukSdCwz5qXaRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077468; c=relaxed/simple;
	bh=agTK8JYH/616wePv/YyqxybEmT0hGLxE+cNNWVZocPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=adSlSRAz2j5ZRzt21GxM/ml7J8HME6kXTYKjpTnhYWPYF011j8KlhJcM8eLR26K9YCU1y6fHphhFpNWdYz+QCHu6X2+x84L5KW88pwqn/t3DQnAaePH/ehlGqDcGpfuguZ+puAFUDlR/CSSMK47+X5YQNWUp/TcIt59KWVcuZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7nVAxZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7nVAxZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BB71F000C5;
	Thu, 15 Oct 2026 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077467;
	bh=d12OQzNJu5LAOkwBM4UbVwHSopG1UzQign6pHGj0ADs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=c7nVAxZnPSpDy7boXG4W+zDtjahL0x+/uBkFDa4CjctAmplLWL+pygmsQf0G1eDJa
	 are9cxdoBr10eTjGtGvPiDfdQM77YjFRvlCER4mZad44tMfk1ZKTThA+/WYUj+K3Si
	 myl9wVlINfafyLvyBtkl3uZwnGtXRhpR0AmoM/4ZOenmmHJG8WTMeptK+LoTvAfSbK
	 wUKiB+E6kGld2gBs8rDIO9dF+s/DuxL4PPIzHnTEkPP29IpL+KFZC6RSFn9m6f0Hbs
	 UYZa2E6YMJmWWnB9lzJ0VfbQWnIzyZt9wzuM5XmZVqoLtbGQCng5FFNNvxGS07ycAu
	 OPKPd9YohLcRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772F5392EB21;
	Thu, 15 Oct 2026 15:17:47 +0000 (UTC)
Subject: Re: [GIT PULL] More KVM fixes for Linux 7.3-rc8 or final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261015095154.815793-1-pbonzini@redhat.com>
References: <20261015095154.815793-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261015095154.815793-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: c8f4cfe1cf93bce924e27f2abead7a4c4a487505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9aa622dbaab8addcbe6f65f17c7b4d613d270f05
Message-Id: <179207746619.3496071.11030383057384772309.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 15:17:46 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Oct 2026 11:51:54 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9aa622dbaab8addcbe6f65f17c7b4d613d270f05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687273C455B;
	Fri, 29 May 2026 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098046; cv=none; b=PaldHOxRhEkgZ5gB5R4ruQwjcVKP2FBHJBIOm1DYbreNHSR+LqavyiDkaQ4Wu5HKS8wlNgoO3S/FZOKLt/goOy0JK1MBWFSt12j3Dw/uG0FvoSUTR5rh7+o49LTxRgrbEK3rmOdQluv1l4ekflC/94cPDd8ZRexGG9BjzF+rYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098046; c=relaxed/simple;
	bh=GgaddMAIybGBYxppANDK9xLjaRmCFypFxNA8ppZWbo4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QQIKBXVea922m4RJH1A5w5fwgmahjtg7Wt8xCkm2ifqw744713veqiD9ML0mInFFvJ8CG7BWfL645lH5PE37fGZJFKpcfHPbrxgD2aJ2M+CVwVkxHpbi1v2iFRiAYK4TD53lvb76nxFHjI5wgP52rTEFQeMyZHMi6Xk8gC3uloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvo7JXeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvo7JXeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1A81F0089C;
	Fri, 29 May 2026 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098040;
	bh=Ia9gaSUuxaqXCwIpUG/RYHbYLFHKiwUY8Z2g9CVpN4k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Nvo7JXeNJ6YD/NkZlPc99ikpZqPq1SoaZXU9TJZvTEWdQzqvw7tNUIkQmXmZ8kMRl
	 Pl5i09uRiEAV7gSvepyy4TahdZ0SodZSYFXTvy91zgo9sCdCSa/ITGptjlM9jrtNnV
	 LOwTDTEq/N6lyuL+eZ4yhQuKvAZ21ufF84/QTPnDWNprlN2syIqTJNIocggMxOjQ6C
	 2A9Ohxi0BCq+msXzE6NnoCRf/FRWsl4xDv0vjWvXrhxP/NQry5VqAxJTcZ8UF4AwC2
	 GNC/jQpAsfjmb7qKtan6dBgS2pGYh0Yqe5U19aeLvOZDajM2G8RweVrT+ktxBNWth8
	 6xokbagvoHCtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AF439301A3;
	Fri, 29 May 2026 23:40:45 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260529183538.1104584-1-pbonzini@redhat.com>
References: <20260529183538.1104584-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260529183538.1104584-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 713074d53be5c8684cb31fa7a8f09ffb679338d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0ee290071b475410476b4126c72da4bf6a2194c
Message-Id: <178009804369.2001479.1737980352529572695.pr-tracker-bot@kernel.org>
Date: Fri, 29 May 2026 23:40:43 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, Marc Zyngier <maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 May 2026 20:35:38 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0ee290071b475410476b4126c72da4bf6a2194c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

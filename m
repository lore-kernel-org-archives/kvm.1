Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BC47206F;
	Thu,  1 Oct 2026 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890678; cv=none; b=s0X3GFPsESUXOGgcPGxctEyrnJ7iLGTRcRgHXG1ZAIQozTuH0skK66vKf9bfVtJLEkwq6pTRMa96fk4uMewgzB3RVkzwDG9VsMcFE3NI7/8wLnauvrv2/WhLIZSob64Gfj2HaV7swK8s2FlEx1t9GNV9X0cn1gCJW0zojLaItpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890678; c=relaxed/simple;
	bh=kgtczFsXphj9wHjwnorGW0vHNGvGzs+kHpCSBHopvc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NZhw56+eBwMdq/D2mqkAj09vlO1AXATT+YLNVxGpuhvpxNCiBOV/1HEre+naWF6PWvaR11tm9QF0UC/Owg7rLD8MaGqa2dcyJfd5c/l2/n3F3rqwd5wmvZwB1PZRDzKvhZm9EqPoK4qbmXp+N5Kvy11rcsm2km3yCNTY38YVce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU9RbI0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU9RbI0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809841F00893;
	Thu,  1 Oct 2026 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790890677;
	bh=htBMVr7p3vtP36/4AuBzt0J7oK0jmXSFJnYmLryxpwQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dU9RbI0RdjeyIcDRgfd82koglLTqgswzWLEYRqqIEq6czZCoHYHrNfg08JJe6mWFk
	 Obea6qQPGmjdvx6D8SZSufeEIsrLWUZDf8wJL2BdI03BYdahw8QRhcckw9L19XOwiQ
	 RlN3lhlE0uB8V5DL072dme30ONPv/FwRKRi9kesthPCw8TbJg5wRxloJUqBpvt09TJ
	 iP05lHPTixdd1ZN3b12DDpQG68jxSECbrRD9K2fySy4Z8KCMIM5Av8yWpNuq44a7Xh
	 qu6dWg1hdOUk3MvwZwl4gaUEC28NhKbVzU4lGhgbEHxcvKMvq1FT6Rx3Oi2iaJF30L
	 JArBljFW8RaRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7763F3811976;
	Thu,  1 Oct 2026 21:37:57 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261001172214.209754-1-pbonzini@redhat.com>
References: <20261001172214.209754-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261001172214.209754-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: f9bfc323e76120c2cd1fdea93bbf315eec5eb934
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a940b03cee1524c10c16e0f73ec878bbd36202a2
Message-Id: <179089067609.3100647.4120475823089435599.pr-tracker-bot@kernel.org>
Date: Thu, 01 Oct 2026 21:37:56 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  1 Oct 2026 13:22:14 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a940b03cee1524c10c16e0f73ec878bbd36202a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

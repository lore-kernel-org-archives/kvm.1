Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C138D6BD;
	Thu, 16 Jul 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219506; cv=none; b=q8lCJPDzWEtsA9IG0+yUyRKUuWpHBFtjZE1VmZecfeUQ0KXNShea5nOu0U8XUeH+koAV0c7MKWbPTAnKs8jRpe1RYvWiIq4gW5cmJixKN/9E9GHUakHaSZBH6PWEjKFHoSJYaw38hyuXy2j7lHwVK5IRAqoHlvnborg3umg3KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219506; c=relaxed/simple;
	bh=2v2aMqDkeQgCNRdu7mUAs6wUeA03EBDzr4SsdDS/OrA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=edSCv5U+IvX7GZ+AyGge2Tm1fPav6RF8kRkBQqSiIIkW72jI5xaCIaLu+4e90MHZXPujCBvFFwSUO/R0Ed68kUY88LkKmDhy2hrHIhr+BGf0Te35ZTOt2ohfWtf+2/NFA8w593/BnriJjrA7I5E+te27aiPoBPq4NtIJpHd74rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k68IK5G7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k68IK5G7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488B11F000E9;
	Thu, 16 Jul 2026 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219484;
	bh=kTLWXD53vQBPAmPrjRYq/90oCdMqoXBtTdK18i7agzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=k68IK5G7TcYb4a5pxgeoc9T/nL5ebEP4n6xmU7vjDKfgjzpc9Z+Dh4Bi81lXIz0hP
	 /1vRI2CZoXTugHcCLq1zCgC2Keae08ki7WfkYJ8R6fraun/DlD+63TUivgs9Fj/1nq
	 o+ToEm1OafCUbwDJKuLqAkf994AYyLs4MQH3dnlASQRc9QfaNo1x6N1YB/6Dm+o9O7
	 P8zOTHvFvnbCl6YYQsx08tLkNci5jEeFWHfIuuzxzlrxOgRmdVX4/kqtJg8R4dJjBa
	 1v6fAUBUhDxDSttwCOC51oFnhW4XwUyM1zPGVw1dzPqdz/ODEKiQm0ixxtkxb3aiC0
	 7Dz/pW15pSzLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CD23809A19;
	Thu, 16 Jul 2026 16:30:58 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260716074652.756719-1-pbonzini@redhat.com>
References: <20260716074652.756719-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260716074652.756719-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 25f744ffa0c8e799e06250ce2e618367b166b0d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c270a4218b810819ad68513cfeb8caa7830fc53a
Message-Id: <178421945716.1334695.9270541267982877736.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jul 2026 16:30:57 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jul 2026 09:46:52 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c270a4218b810819ad68513cfeb8caa7830fc53a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

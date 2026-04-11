Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64634A773;
	Sat, 11 Apr 2026 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937560; cv=none; b=OXMYgODySn/A94Atfty4OH+eswciLGL35PvOXze1xtHGWDIZbZpCedXGehsiIZrruNHQH07J8mW/eDpuqUvP57RsK1PDIVlyIdgkuSfL6WpNIwQ/8NuCldFbD4j7YVDletsUtWUyEZmlF7+Djrz4AArh1WKhlMRyVFuvy1k5O5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937560; c=relaxed/simple;
	bh=QgYmrpwIOllvrmJ/vNeR/nplQiyYeGpoQ0QNU5QjuBY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OL+vArpIK6uthL7vuog5e3O25hXJSNfIssuBEE3M/SOoTIAe19d144Tbf5WzoHXvtLRDPrPnlX0w0HNtlvLM68LzqpxGcVuWpzTUAbE4pld/tQ41vIGBBQws4L22CRfxUjAJ7Ndg3nra9a+p5D/LFiDX/2urIYTXk7JjLFDEZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKCm6hPI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKCm6hPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD459C2BCAF;
	Sat, 11 Apr 2026 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937559;
	bh=QgYmrpwIOllvrmJ/vNeR/nplQiyYeGpoQ0QNU5QjuBY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HKCm6hPIMxr8WREWelk46gBy7P21XEd5i/QbuTnh/YQ3IWiBGRdNBzkZRe96pot6z
	 XcfENIWDlRQT5Zaq4HWBS1x7zhkErwp9Qer5/YD0a8DqzM4cCmWB8iJTTPRQAY33Zk
	 wwWBGPS719y+DARmbI5REl0kpzIFVG8MhpJsF4lQV4QtNV7K3+R9yoaAbP0Z0MFvqk
	 9CALoKwb6pS6bpA+SpHH+E2eWp8DLNx9H3xbYqWlNF4Ri4qWoSVafVXjn+0eCIEn6E
	 o7yIrWKQH2aJnlJi7gsnEhQ8WqlCEEwHt3ILfOKSW+bDYY/TejYg6aa2O7LvSCMyI1
	 bO2lQ3Z4ryvuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEF53809A8B;
	Sat, 11 Apr 2026 19:58:54 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.0 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260411122455.87172-1-pbonzini@redhat.com>
References: <20260411122455.87172-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260411122455.87172-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 1fe7294dfb7d26f70bc8f6d7aff26bf76ed32214
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 086aca1030cff9e4729785bcfafaf4b8c489a892
Message-Id: <177593753319.3064778.12829982577022573304.pr-tracker-bot@kernel.org>
Date: Sat, 11 Apr 2026 19:58:53 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Apr 2026 14:24:55 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/086aca1030cff9e4729785bcfafaf4b8c489a892

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

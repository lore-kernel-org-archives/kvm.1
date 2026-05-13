Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDA3ACF12;
	Wed, 13 May 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699036; cv=none; b=Z7moXy2JdhDFJiY72iMFJV44+KWvfVACKCjVvOfGClZcWItDWswu6wQUaJ0fc4aTmC2l4vZWjaKeIH5CTyzfsGj4n7/dyglg8P6hIiZu7D7f8HTsDZ6yxQwkOPJDPZKXiUVHtyR1D1CQ2KvAQ72XVixOpf8yoFbBV1GLha28has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699036; c=relaxed/simple;
	bh=S9tHukX0pwLMSVfC7psGBn9e68lrABB3Vfv4htq/OaE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FteQCe/avOo6W5NIrO208nTjg4CIphA4i1QUEut7GJ/X6WpW3zJBXwlt1h3RdGWgvSDd9e44yOdgmSDYAR9PhaAAfLFHRv2lXxeLYvpLsb2fOgD+wq3KlWyqfUGhEWLtkOyAjUl4iIv8N/xj4MUEDVfACQfkf6Bm/415heBc7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5CrVBZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5CrVBZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0A5C19425;
	Wed, 13 May 2026 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699035;
	bh=S9tHukX0pwLMSVfC7psGBn9e68lrABB3Vfv4htq/OaE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i5CrVBZkTPODDxkCRZmwdFw778a/tdpokvptdxYKpD25UvhacyjRpre2IRlTSy2kx
	 I/IbMkja7bpxU51YqtlKH9H/d976PIu9/+Carzt70omwxB75llDLgwpWMo3uDneEHu
	 EXluR0/BmD/8GTLObaa3sbteST4Gm0B0CLCWAMFHNjkyBoIoYFn90sMQ08X0PxAK4o
	 B0yn3D+2q6wKLofYN9mCz8R++QXsAxSTz4Ww4zwfXIdCoBUfqhZ6UheiEch+Luyfr9
	 n5KzgImMmlxaNSswvSbOg3/0Fk62Cs80oa+kXGu+oolKkWr5vvP40ahC3QzbDnDiXa
	 cgCM3o0hXtGVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D17D39302E7;
	Wed, 13 May 2026 19:03:02 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260513163150.3440901-1-pbonzini@redhat.com>
References: <20260513163150.3440901-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260513163150.3440901-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 2d5d3fc593c9b7e41bee86175d7b9e11f470072e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1914add2799225a87502051415fc5c32aeb02ae
Message-Id: <177869898092.3790873.14930821106133480444.pr-tracker-bot@kernel.org>
Date: Wed, 13 May 2026 19:03:00 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 May 2026 18:31:50 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1914add2799225a87502051415fc5c32aeb02ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

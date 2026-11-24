Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485347;
	b=lJsvJNArN+iyqQoX+Ak0xFSTeSxs0t9b2XnvV4DYSsabkfacOy9QsR+34jpy7QEgqnzJ
	 7WD7/qTcZbkAzFwsQittfZH1ve86J+Tp/lIMhswUtWy6PcgIYtIgrmwW79Va8oV5bqg5u
	 cF4lwZSHDbqOJ++4liTqe6rpxGK/8+LjuABN9JAYFWIXC/AciR4l2f8L12JAT8DMaFmsh
	 1T4HNB/SG4JE9wlEtXVODjAdpLd7giwHs9odyPd0pBN4KeGHSeqO2QLcKpBAJ3QKpC+U/
	 6Fd7ja4WygmfplGCBNJjLPVGlHECcAkoxWgVyvqziJCfVMIMtp7iU5y2YlNvg9N3dhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485347;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=0EHZ3j65yBuclYkDgwxvOfpPnu/dL6lBgERw5kJRk+0=;
	b=26dw+HBO3FeYvxy9j/8kxtzg+yfGdRTegnWgoZix6IpxixMjaD6IcjDuqikyR6qm6dEC
	 2nB9vSD/MYyd0ZnHn7kFDdk+C3YOrYNg27r0kLT7GOH+cavo7O22qk6owSh6aFaP1jWck
	 GVRn6yTbfDOgflBpXsnzxyGeQtclOKpBKiKblSfo9+ZkSR/Y1RsUMnHOGth1u7+CRcdXI
	 zTzCpFjDrAeMgDZdlYUv4YUi55dDuwZTj5+W0Lx9Dng89qJ5v1ib5vxzex4PskR3WAEPU
	 3OGk+xywmXAekJQeHHn+5qtixLmvruJBbujd9CoLzqYHDx3xVJHuOP13aU68APcYvJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlMBVAM9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62A606A321;
	Tue, 24 Nov 2026 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlMBVAM9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090851F000CF;
	Tue, 24 Nov 2026 01:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795485347;
	bh=0EHZ3j65yBuclYkDgwxvOfpPnu/dL6lBgERw5kJRk+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NlMBVAM9Oj0ue822pwRo5EuSv2rFzdJRhDfpRR5g6Qo+lILAt9l6sgKVNHUtoZn3F
	 /nwwfXBirPC4gC3UNMAZxp94KMJhdCxVyzIfVbjT/hkfbjbSrDER4LbaPr8pARZWQ1
	 r+2c17pPuDRrvKnlyXwtTIlUjcKNsCm0EZGC/XrvUbYdGP6d+74MWd1krX5RcWMWUq
	 tQ2vtdoDU73063c50UP4iX+mmiqDz+AZ0ErDfpKtvHDtyLAqhC02PEtnEFYNy9/tu1
	 ZJEFYh2ZCEETu8t8YJe8P+0Zthzgw56csjmJ7Ch1L2Ei9rxYDFudACJgYVCZgzQdg7
	 u72i75jkSh74Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16EA39302C0;
	Tue, 24 Nov 2026 01:55:46 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261123103106.953938-1-pbonzini@redhat.com>
References: <20261123103106.953938-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261123103106.953938-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: bd1be6e0267d7a52425bd515c53e9a49bd4e2a12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42e225323067a222230068651cf886bd7fbb1fe2
Message-Id: <179548534568.3226620.17536081420443449632.pr-tracker-bot@kernel.org>
Date: Tue, 24 Nov 2026 01:55:45 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 23 Nov 2026 11:31:06 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42e225323067a222230068651cf886bd7fbb1fe2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

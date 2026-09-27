Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2A288C96;
	Sun, 27 Sep 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538546; cv=none; b=D0mvcwdRcDPipYAyekFFJBJByo7X00EpnpjOKlimBCSfxoov5j9mrY89iUDi8d8EQ22QFVZl7u1A4sljfFZYMJdJnuNj2NYg/YvIO4dvGjGgk3BSGwxDkPbYERoeXOnzpfMmcUehWUyYipdKhiJA1ggRCp1e2haj3aY1wcm0n7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538546; c=relaxed/simple;
	bh=8thr27q6ZlUlxinNlK0hjhVK5PgLuWj1vimBTo72fm4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FzS+x1SFG1ySG4AENA9InbzCnflyFpQOURu1dXp7p3wjkFGudRz6cIiwMJlRd1kS3TqDYrUs67RbyFDuXX1G7+kD0kCdrGbC+VYXetMYXC+Rkr28I/eBUEBWVX1dwpZdifftdhnpKWjeVdTedjzaKCgBaFLPEi1qXLdE16cJdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eshkMs/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eshkMs/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEF81F000FF;
	Sun, 27 Sep 2026 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538545;
	bh=cOgR/fzpF76RxV9lmHpqweCRZrQ1kgOxmIaOd9xBlhk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eshkMs/i9St4mCIr/zVEv3PZj7CO8L/l9EGj6TRQomDM5yOb0JuXE3A+gQMsG/scp
	 92+8zYLnXjhqoUyBvPmVGiP3fs7N+IUC6DRvCx5Pqry8oz5XDa1rNcWxo6DjcMmRaC
	 Yka6blO5quVcKxx7+wVUd9IkzL1eBnxxJ3UcvdeVpCwhdv7tHBf1zSdP+ommkPDLcd
	 +2jhSKYQhkj4ZPshXn8bzDFDQp/0QoJ2Vbk5uKzg+bnFpiOFDudu2/H1M9OnkSxFij
	 j9UVmbhfGqY8KtIbrx1nGbpCzjfpcl6yZaKnqo8eAe7XGjNfbcC7hon1rBDxDAQ58q
	 SDF4WHIGDOcyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A05380AA5F;
	Sun, 27 Sep 2026 19:47:51 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260926061606.715681-1-pbonzini@redhat.com>
References: <20260926061606.715681-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260926061606.715681-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: c2f24f140c2ee6c00775c2a93c6ac931acec2b60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eff8d2791c086388ba5bae36385afd9bc6f0507e
Message-Id: <179053847065.2777566.17117900407252086114.pr-tracker-bot@kernel.org>
Date: Sun, 27 Sep 2026 19:47:50 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Sep 2026 08:16:06 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eff8d2791c086388ba5bae36385afd9bc6f0507e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

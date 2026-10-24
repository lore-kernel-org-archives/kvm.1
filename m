Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792801942;
	b=UB6ZEyTPpC565FTj0WIuTRcSS4EbJR6g6+1lE1uI3Nr/1EMN0qTEYEHJ4YLYn463rEgG
	 lL7CJCmovrLjZJw+NdVYa31Vjx08BcE29P+vP4bQqZUk3LwBsCPr0QUVis3NAWp3W8BLc
	 vDwQWlGx9fkARFm9QebGeeTjnAwzf4OMcxSD6eJID7/7pk7p05AgixFozn0uxJNQGVMbr
	 QlvU9hclIOFrVceYQi2Sak0xfzUCBm9LtdR0skH0f8c+MbZGefVyriu2gRBcsBI4IC2Ml
	 jFtlXb7sxkMx4PVrGi97Gl2fAr2FtrEuHld2L1ooJrrGkJ/S62FB0ivdEMZUGg11v0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801942;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=y6hzHXdLz5G+ip3A5rBn7aJF+fowAsPVDWxdk8xrDnc=;
	b=4J3Uy9grlA+jmXxV+MeJz1J482XD3d1VPvlP/1zjXmARQMwLHLc+vez0Z3V+4954tjG6
	 1w13ZfC2ZPV9yDA9gC6Wo8CTb0hJ9EMIy9IahdGziljS/MPLHtZ+qbB8m3dArqmcgJ9qR
	 AqhJK7U5zncYlf+sqKjgRacus3Hrma9TlPc94diGf52vL4TB27znj28NIePuGnhfQg3dP
	 hFRwACkNJgNN8pHhnJXRDwzPALykAXnu0QLLM5pn59IffVgaCdZcbbSi1DqiCod2Lw7yi
	 4hCOIm0nLIynBCnx+Tf++S5fu64xysUyy/ckGzx5Pwo7G0Srzy4Won8V1Xy+IMk/eIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4nApqg9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AB606A31A;
	Sat, 24 Oct 2026 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4nApqg9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA72D1F01825;
	Sat, 24 Oct 2026 00:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792801941;
	bh=y6hzHXdLz5G+ip3A5rBn7aJF+fowAsPVDWxdk8xrDnc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=i4nApqg9lbExgKBYHbHUumWqhIdYXNcSfspkf1v7qnaffxlnCitpCahZ5qnVkcPAE
	 5fhFJoP0GkVerBHOLwDULzmwap8nx4Xa0FeasW0d89SrlS0WfNWm/OsPjC6fkskLhy
	 Q0ljwKP+8dSKQB1ggR2uAIyVwGOya/SQDTLAanlgdaFfaRXaoySur+SyRW9w0A6gtD
	 nuwYMcKB7+jrKpnGrqjdUARA6xCiBry3ffLfokVLmPs4c+P0L3Uuk2UFznyRjzrwn+
	 fUaf+uyOws+I3QI2/V8eMs87MP9ergRGQ3L5sOSnFsKczwrNEGXHenbPhB2BQ+SevG
	 FqmvBPuKfGvxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE6BA391B16E;
	Sat, 24 Oct 2026 00:32:21 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021225045.519bf535@shazbot.org>
References: <20261021225045.519bf535@shazbot.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261021225045.519bf535@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.4-rc1
X-PR-Tracked-Commit-Id: 076d7e989cb69f6ded7d60f2a080eb909930061b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26344c0dd32af8790d8474d233619db825441138
Message-Id: <179280194033.1369974.5967727727095952372.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:32:20 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 22:50:45 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26344c0dd32af8790d8474d233619db825441138

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

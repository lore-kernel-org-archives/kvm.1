Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792801889;
	b=Yb+iVO9PViNjj/YrOWqox1TemX6fBKkiCn7RmVUHp/FmJpz5QwK7gMlwj1MqPS7Q90VR
	 PSM2OWgp8Ql/uIrtWf0DUbwkc0sD/VyhT1NzvlmYkIHRfZQ38BcP/3BXcpWf9O/F4jV2m
	 /+5ai4INw0upVHtCWEUy5QhQEyNLPRq4WBics//bnf6a6O5GN6BPbKJSqflje+Uzp7JHC
	 TLiKtLfmrikQ/BDJ1l+VY3D5+/1tcHlspHD4eHK66/ZaM37I3F5nAFLtbtYMI0vow8uNM
	 v0KtpN2kRe6XkisCpeYKoxzEfHT9VpV9pX2WROhhxBB9dKdp0L2HCMtLktvunnNh6IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801889;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=sjQeLM9OWjEhb6ijlYk2QLCQmlTcffG14fcVhLRT5jM=;
	b=0UMq1JL9yGZQAQbG6+OHSD2PyG+oLsYp7Eq08nLJjJ3Tk9lJrnd++8ljxcny1v9oysKi
	 NXXdtekn3m9WSXVhSXPAF3OEnPA7UlAMgwMxi8xP6Lwkok39R0DmUf8dcGaPXvJakvdXt
	 rzuMy1m8Tgdogz+qk/BgiPon+3RxMvaJZVbGg3LREp2zDZgbMQvnPkE/aTq00CNArRblH
	 UxRyy7bKdl23HXFe3nwE6pn1/KG+n+tg7/dFi6E0qPMEBuYeFPI5SxAdNXw+jtqcBCzET
	 Xgj2pYB4IPAN+6iszlw/P8Ik3xxm2UlvDDksihlhT0Qe2JN6PVaVcTTFKXswqGYGkgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Z963Eo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD3606A31A;
	Sat, 24 Oct 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2Z963Eo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C91F01825;
	Sat, 24 Oct 2026 00:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792801888;
	bh=sjQeLM9OWjEhb6ijlYk2QLCQmlTcffG14fcVhLRT5jM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n2Z963EobQcaAOZKGzDdZvxvgd6HCizxNO87gixeKLH6Vvtq7NAiI5AEwLhNfUMFW
	 8Z2LfFAEaj+zTPBt45rUxUb1QcsYe2VyVKLT8agwDESOzojZ1efoJeSelJls9TuxXG
	 jByi6KMO+IQ4ghwJ8aQ7++3pdy51od6r+Wneo57CqdtdIUglJtAdQku4E9hiWIIKYQ
	 SL1xiWEU5n1+eeF7EZUB/WTUxlf6RrNSUao6zUr/7mQ5evN/mNMeX6crSnEtHbA5Sh
	 FJX5H6kJDS/96hbhngO3HFmwSkrES1hLWjsH8Ax/aWRsgWbzxCUR8t67ULqMS9jNGU
	 CpV5zBoYCHE0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 09BA2391B16E;
	Sat, 24 Oct 2026 00:31:28 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio: fixes, features, cleanups
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261020064022-mutt-send-email-mst@kernel.org>
References: <20261020064022-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20261020064022-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: c69023b5e16e5ffe9368603dca76d85bd544ee57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2516f45b7cfca237f4d8e1c91c1f307e295dc5
Message-Id: <179280188679.1367831.7681253040178931221.pr-tracker-bot@kernel.org>
Date: Sat, 24 Oct 2026 00:31:26 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey.drobyshev@virtuozzo.com, den@openvz.org, jiri@resnulli.us, kmehltretter@gmail.com, mst@redhat.com, ptikhomirov@virtuozzo.com, sashiko-bot@kernel.org, tanglongjun@kylinos.cn
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Tue, 20 Oct 2026 06:40:22 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2516f45b7cfca237f4d8e1c91c1f307e295dc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B902AD00;
	Fri, 17 Apr 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441882; cv=none; b=YOjhN7MFsnQVLN6u4C2MsDx7mXru6kBWvYTqFBBTC+vrVOzCp6b3zDtSLqH8ZdgehVJ4LQ7rf3bWsFgoArWMxwUZ3V+QqvK4z4aAb6c6azK9mMG28RKyte/g3N7Yc7rnhbRHsoycRUalcKGZqx5JOaYwZhLHjp7DN1l4q9pxsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441882; c=relaxed/simple;
	bh=/xy8ep8Sr0dUkZV3irqYAEw0NZXeGYMXl2Z3AK9sgxk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=I8FsTVQ9fqHGtfMmNr/JhqZqu96l4VVHKahne9BZF3dUZqeheiYjuB1eSAw29XNRlubCkELmgt622kQtdpdCB483J+7TZHEcK88GCggixY93njxpsJT5PA18YsaWxoQWaVhLyR+KDMMWvxNZuujC7XAA7hvsf+usFgNTQIbP5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjgmQ038; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjgmQ038"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E38C2BCB4;
	Fri, 17 Apr 2026 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776441882;
	bh=/xy8ep8Sr0dUkZV3irqYAEw0NZXeGYMXl2Z3AK9sgxk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bjgmQ038qRwOuJQ/3wLhmQa+rIgE0DIksBLB0q+bpOpVoLT9Fq27fymItlAv4Rd72
	 aub29S/gTBC17vgJ2d7pXqzxftgH2CM1hBOKzKUvnjR6g/R9C2ssTwqPQn0E1M6f31
	 LeAw9sSDYZLDb8V+MeUqG/85fY3bvpCoPEotExg8GrjMRrWsS8KVXABcE+3roVhZVT
	 HlEix3A/CNBVyOGbH4cLrCc0+ITqu0TfnCqRvNQj3lsl7DN4XUAL3bgrPamBa35zJ1
	 zDm18mzMGBap45eU+igZt/GUeWWePls3SCJdee8IuCKT9I1yTC4tV3tQYT+pjsJbfo
	 bnFode2MLRdCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EB7380CEDF;
	Fri, 17 Apr 2026 16:04:11 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260416164526.171467-1-pbonzini@redhat.com>
References: <20260416164526.171467-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260416164526.171467-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 6b802031877a995456c528095c41d1948546bf45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01f492e1817e858d1712f2489d0afbaa552f417b
Message-Id: <177644184958.46060.17323381263509814292.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 16:04:09 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Apr 2026 12:45:25 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01f492e1817e858d1712f2489d0afbaa552f417b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

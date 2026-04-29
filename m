Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09833F58E;
	Wed, 29 Apr 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471264; cv=none; b=cPlvfN/RlCexvG+sAAMuSdYV7j2v+i5O7sH4Jx4+n5LEnMpqZv+HiJ0HmJbZpLbk/nVPg9EdsmlvDLfOAal7L+Z4WvssBZqAPSlz034uZ3PUS1l4AvHUsGAO6Urz35cHqEghx+Qb4HD/eyo/xwHv45+PT++at6ueQnZ2oFRgCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471264; c=relaxed/simple;
	bh=bI4ohHhpZ2D6iuB+GgCFXxZny80BjtbBm/afJ7rthTo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XpasjNI03PitrjiWiWpadVskc8ijLsyM2oWSGUAEt3Ixjb7+yaukuuABOyozZbzY1Irn4fvQEuzufY6rbJazo+MSWsWsJXvmtx/lMkENv9eVGm2Qc9/D8wdJs6vBMa2xySfefYcCd+Z2Sef6+g1ZMPDppLsOgltWdSDM5zRQyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H16VYy+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H16VYy+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F59C2BCB8;
	Wed, 29 Apr 2026 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777471264;
	bh=bI4ohHhpZ2D6iuB+GgCFXxZny80BjtbBm/afJ7rthTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H16VYy+lS4d+djeTcdP+Q/BpYMy9x3n2K4NEIRW1jTdlKUSA6eU22P8AKtqSP+oYl
	 BZePgcUn193SOBWPaNx2Qm22lCDqtPsZdWkyWUFzAefCGDRmxTIdh1xP8VXvydbsOv
	 m1S99DbD6jxCMR1z3/o9kvN3sNmzoEFDxJG1PkkmM/AqmzHtPI9hrAHdpBC+lQEuYQ
	 Eqo7mQmrccUm3ri1G1xXID8jX8+jPpJn1rTNoG8XWC5NWBZEssyoMKmYTXWRo9575t
	 0gR2Ysy9dnV7RBacXcVnRVXappB4hASRqSlOSFrhsuUhT2ASi4Ni0sAJzGCxscei1m
	 wfyJjuJ9zZaiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 936F239307A1;
	Wed, 29 Apr 2026 14:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes and selftest big rename for Linux 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260429133833.16993-1-pbonzini@redhat.com>
References: <20260429133833.16993-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260429133833.16993-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 39f1c201b93f4ff71631bac72cff6eb155f976a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
Message-Id: <177747122045.1980932.17855825848288786558.pr-tracker-bot@kernel.org>
Date: Wed, 29 Apr 2026 14:00:20 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Apr 2026 09:38:33 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57b8e2d666a31fa201432d58f5fe3469a0dd83ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084F298CAB;
	Fri, 13 Feb 2026 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013888; cv=none; b=PP5JadUGlvUbROfC9bhkEeK7OraS3Wmt5ytVlU7vdkGY39XGGRFZWpxnlTOkTwlJDIZMkcQvHbkS8CFsdSSpYmdmsa96K+A7stIHTSj/6fiTDu53zUEoVs/p82xkYZcbtUPjj9UaG+X3Qdjw464G5QUZdedEZ9QIYJRl17sbcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013888; c=relaxed/simple;
	bh=JVCEqQ4r9lznf0yVZKSj9/BmMAYt8dK+jdf2rdU0BPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=plhaTCjMaFywHMHNG/nyJgFbDC9e1PdCDdQTi8MVPteeYLXn9iqo+f7GCQFS83CY8oI9iK/uUv8vibbQNk6OMDz5qv2EM9k8WtdN2tha9g+E26xXUsoNSK/88oWCmccjWdaxUd35RbPHcAmpiSNC8Tn+sRVcvUfjQdA//ENuO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nny2zp0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nny2zp0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F3EC116C6;
	Fri, 13 Feb 2026 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771013888;
	bh=JVCEqQ4r9lznf0yVZKSj9/BmMAYt8dK+jdf2rdU0BPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nny2zp0MZk2+rYa4l8baOm8JZ9lc/wZ/uXGG7XkQ200WExV8fBMuOrIxwCIVBLpSq
	 y7wBB3VDBKfNbz6PzmvmCoAloYcTPwNwnsBH/Z5ycRd7uVtpSHNcaGkyGID6j7/MPh
	 SovbwldQyR7M4nRXSkKnJk8cedC0vF6Lid9p92ASTlw/ugHXtDAGkvKbuxlHiIAtAf
	 W7EyAKPVkrF/xJg6YnXDscMtoQ7wWX9NxeBunPvuEjAVtkLAupHPnGV5Q6gDjEYrIv
	 Fj2DK8PXrkwfJ2rUVWSAC+nZANbOPwK2U3H8l0LMBFKJ9ILk2lW1zXzQ+dVYBpYh9P
	 qrkcDPRtOGB9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0DD3811A44;
	Fri, 13 Feb 2026 20:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260213162059.22230-1-pbonzini@redhat.com>
References: <20260213162059.22230-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260213162059.22230-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: b1195183ed42f1522fae3fe44ebee3af437aa000
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb5573868ea85ddbc74dd9a917acd1e434d21390
Message-Id: <177101388166.2542361.11440877444393583528.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 20:18:01 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Feb 2026 17:20:58 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb5573868ea85ddbc74dd9a917acd1e434d21390

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

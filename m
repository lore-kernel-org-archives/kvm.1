Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9113128CC;
	Sun,  3 May 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777847855; cv=none; b=M4l5cZ+ERszr5Ct6uVyb7QjC/h1jajAb8hd9fIM9Ax15cY75CbwKaLqvdA7Xpj+o7LetqOle66x4HCcjkkzIEUeOX5c3KnnTvT03rBiYWs29BxOmpeYL4sqC7qb1EE7KHtatJWWJAhvFH6T/O6r0PBr55La29nfe7JTGrQhuYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777847855; c=relaxed/simple;
	bh=QlPCM4sMPiQODdRZ+Vpyz71tayYKbY31KKv4AZEOcqM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nKk+gXqJpV0pV/ticYx3N1IS6iGaS25tMz8GcYIpQwaeTdpTBYkeNii2Vn1l8sczt6v+2BZhd4+XEUTqmyJPowTuwnjfWSeoFiZeCp+Di65jJLic72i7h+7KERDf6C8/eQ7eOdImzojiWm0EoNcxHlxhDmVkgowpbhF6WvFdO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9zE+3ig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9zE+3ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1B0C2BCB4;
	Sun,  3 May 2026 22:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777847854;
	bh=QlPCM4sMPiQODdRZ+Vpyz71tayYKbY31KKv4AZEOcqM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A9zE+3igpYutaH0gkVBPVcN4uALjz7fS71GAnhVCILfX8Fn/EsUeq1whVSM+b8WFz
	 14FwusyFyIDLTgaOqWZaXVfkmZhLr9HzlgNAEL9Oc9IKqkeIiHtLBRFI8Pm0GELXtA
	 96atxgLHagcFugGnyeNQqHeBURoDzgXz3AA0xxZFIG3Dighb7oPET5pi4FtcwvouB6
	 b5r+/2EgtYuSpD+BKWvGjFCmU7TVqBE57Fj7c5PoTIzttd12mklPj3gkHpT8eTCQW5
	 wI9Gh7w6go8S5/xVtwXcDKzyCQQOU71wrEUWs89fhjorzZQkH6tUy+U4HshA8uQaoW
	 vT0FQNcrBRuvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D150392FFD1;
	Sun,  3 May 2026 22:36:47 +0000 (UTC)
Subject: Re: [GIT PULL] Last minute KVM x86 fixes for Linux 7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260503212815.127436-1-pbonzini@redhat.com>
References: <20260503212815.127436-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260503212815.127436-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 0cb2af2ea66ad8ff195c156ea690f11216285bdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
Message-Id: <177784780604.479102.5814169825464895297.pr-tracker-bot@kernel.org>
Date: Sun, 03 May 2026 22:36:46 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 May 2026 23:28:15 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d35786de28116ecf78797a62b84e6bf3c45aa5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

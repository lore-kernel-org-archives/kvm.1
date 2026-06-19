Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04633B3C08;
	Fri, 19 Jun 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886942; cv=none; b=Vx+dU0RSCa5bqe9UA6sLZUPunL107nCG9f/PhvccIwtJj1hcdgssbBUBhW/iEbeRrQg5Z/SEnx50BTCf18xqdXM6VCO7NkQq1StZtnSDnrzrdC17zPGLEBUHZpKEZlRkVqNeWGQ30CmDJmWyjDmXzOq3GjmRA76CNAYi5Kq1uLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886942; c=relaxed/simple;
	bh=tr1xSYBce60LkpMo3/cxQNRnltAtFEzDoYyyIMgzOgk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SEZJ+TXWLLlkEv4cHuDpitixyjRM7gKZKNTESIJXhWi+lEySNtasz9DJUVDOdEheUsAJ8YSe30m8DXqKmsXgWcyhAvghE0TFE54koaaXUj8g160Uw60w6gKflEg625kTCWNusXBOaERsPcQ3bCHfn1r4Q3sMcz2Nf5FPtyfimnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSr03I2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSr03I2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D1E1F000E9;
	Fri, 19 Jun 2026 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781886941;
	bh=8pbkdusATBUef/RsXAw+OsK0chDzmWiJAUkn83wE3Ks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DSr03I2e+vhafA72nmxlAouGlzPrSVPE38TEdnV9a7DSTFfNVwkxDVB7ffGKkzKhW
	 co5b2f6jyZkGL5YHZmzJFF/7oF8/gNCIitbTaNBrQzqtD7+MB9t27VRcZkLPTWp10g
	 3bV3sq8+Ja+ncOhzUFTTWCu/B0xosOAsQzadh3M+6+Zeat5ITydMRgNs9lT4OUwdas
	 eMIwC283g6JDzsZN8w2bLwaA4EqBj9iJjKwiIUsuSr3XhM1aZ/VVeU0yuedzNyLjE/
	 XNYFAC9Cl3e2oy+x2NNZ/zT2gNAS4BxXL+iO8BQ5ttliKEE2N02jmAJIwjV5NNBeZL
	 yXJhfuw8IzG4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 012593AA7315;
	Fri, 19 Jun 2026 16:35:36 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260618152747.132796-1-pbonzini@redhat.com>
References: <20260618152747.132796-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260618152747.132796-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: ef057cbf825e03b63f6edf5980f96abf3c53089d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c98d767b34574be82b74d77d02264a830ae1cadd
Message-Id: <178188693466.3984250.7748475031458379095.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 16:35:34 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jun 2026 17:27:46 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c98d767b34574be82b74d77d02264a830ae1cadd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

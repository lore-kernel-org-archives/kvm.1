Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AA33C53D;
	Fri,  7 Aug 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115950; cv=none; b=OHfgmBpn+YoOgRHGw3FKs4chIrw3dnaCuTii93iGMp0b9aGdZXbuR0aY18Yb4pvKju+3Yby7moHQP3mqMYKhnqSl86ehCoHh80pcbPw0Grd7bHwAO0gj6Cl37mz+vI3Opl4QLnbbhhYjHx1DlGprN5bprC6nD95NvDIK7oBqzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115950; c=relaxed/simple;
	bh=g3RYZJOHxozYZGKsH1Jr85m5fSG1RxLdRgKP8i2jQ60=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sP4YRwC+pxjozkFGYwNCO6q6bDBrWGj5n1uz6PS9Q/AEDq2/rnD8bBggodWY9IXXny31TGOILQCDZMG6VVOcgHJ9UIdYsijphAPRhrh6irTB2TCJ0XbfM1oriP1B+BsdrnVoWdhTi1uYJnCxi9uVHlRoHCGEcNN+WopM51uYSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKNIy0bf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKNIy0bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62181F00A3A;
	Fri,  7 Aug 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115949;
	bh=KJ6oYLDwoxEqYXG3IQqNfrB63NuzlVKjsRDHEPSh0fU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eKNIy0bfa3fe4RXUik+ssdbmgwvNJ35WAR4OfjZlxEgzjLbJDL1TCuYmFzBc8sFlz
	 tpxN9PhEwcfCvzCAjkq/tBixz5zi2/Re65+sx1fcj3zvyuBcB0yC3bbWtlCU5FH5J3
	 2d94gLkfsH9Xl+omksPbfjHEKOSVYfSJs9UaOzP+2gfVXs9+b0u3XDamwjeHsgZPFY
	 KxmBd30srPxZkE8CwRUcfAD9t+WuE10qxdL6y56D1Hjlmd3Xf+vJn897yeLYNAXLG5
	 cKVYqD+MAv4hEdFILCCwHTclhFVw9sNe26f5KR5W4f9W/H22H9u8Xx+tjeD5JCSjqz
	 caJu8E7sGfrgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BC380CED6;
	Fri,  7 Aug 2026 15:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260807135327.2629594-1-pbonzini@redhat.com>
References: <20260807135327.2629594-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260807135327.2629594-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 5ec42d57655c690234c14aece6dd3f209778c1d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0150da6be1c71cd0ad9262293971cb9ea371672b
Message-Id: <178611590823.1849205.12083637547026312472.pr-tracker-bot@kernel.org>
Date: Fri, 07 Aug 2026 15:18:28 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Aug 2026 15:53:27 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0150da6be1c71cd0ad9262293971cb9ea371672b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

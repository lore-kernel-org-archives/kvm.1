Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724684;
	b=H9eSu8tyJCIorqpIBBs4s2+/3ax+r3HlPaaNrjaDVM+l/14rOLuviwwmITPYe5UaR2CU
	 t2XIaO53L9yXmG+nvtHrVVPjRJfkQkBknZkNyOv0oO/eRyIHos1ztUZyQbuWePKlT+hzr
	 rCsw6MIMgR0fsAQ3aEEE07iraeYgQ3u1JDzQoitNnNzpLZT7ncdYe0Jh2qvQQhsIWH6vo
	 3gNPb8g5G92O5cAmyucj07IbJCvpCOuowkL3K9DaHAnbutQp0Nabi//yRXEyhAfX1qtjJ
	 7yAD9PvGLKLpJTTk6fpG7+fBrwgVi6wmjsGXRfLEGGwx5HS9IJezFFSXBQ+fa24Pw6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724684;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=1YXCkUEqEbC1XLs/BU+Ixatu3bcvnBaN9YHj7cXndZU=;
	b=wIxeclL3rHwXNatDEN4PXizwYj9XymR1YQqa+YxegGthARt3+UmlCjvmNfNFgE18f51t
	 I3DEfsOAI9Y2ZLW6Gseko7rYfWqHyPbv4HcTOE+QdDnXoDpKHOupahrJNNGvJ0L9gK0Jr
	 p6sk0Yg70ylYnFNA7dDm0E85csf72Xz1NMH2oOe+QeRGD6hxLa5tuonJiPkzNyBJL7rgs
	 pbAfwWKmmRUAD/LufRvmFD9lE731Z1IrqUKMre2BM5S8Zqspq9ODrjidJcSttcoZtPkdu
	 hzNkhT97pngCdevmeHG0WOArFbWXSfnh3z8DuoWDHEEcMBq+5rh9jg2L6m6eDw8jh9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyKCYWi8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA3606A329;
	Tue,  3 Nov 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyKCYWi8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DC01F000C1;
	Tue,  3 Nov 2026 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724683;
	bh=1YXCkUEqEbC1XLs/BU+Ixatu3bcvnBaN9YHj7cXndZU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nyKCYWi8i8R/FfZt3/60s7v3wiIlPZbKRVsfBI+tOuHvGsIZNnD3nl7Rg6CdNVibx
	 fd38wTwhNosHKP/+d6sM0CO2gqeqPh+9RKh9Cyl+z6W8F0VWiuo0JTMA5BSW1mqIrU
	 9U9+wPBT25XjcNYyuXYRS4C9bcNbS4HsfQReM9wD+Iv0tIeq7TvvoqjL1F3o4Xb6XR
	 FXwDJRF+8Xj7sV5hy41nn80D+mH7x8b4XImxHvNvVMH7bTCwTdD7ZPWAMpBnXKfetx
	 1RosQIIbT+EMTg1CQuTo91K/17SB0oTLWHbAVNVcv0S8aVN354IkhntRLzS6d2iI69
	 FGBcmjneXwsrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42A7E391AFFF;
	Tue,  3 Nov 2026 16:51:23 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261102231002.13404-1-pbonzini@redhat.com>
References: <20261102231002.13404-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261102231002.13404-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 508d578642f08a3ffde7631c454497bd5a735941
Message-Id: <179372468187.1751950.13797965745197947210.pr-tracker-bot@kernel.org>
Date: Tue, 03 Nov 2026 16:51:21 +0000
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

The pull request you sent on Mon,  2 Nov 2026 18:10:02 -0500:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/508d578642f08a3ffde7631c454497bd5a735941

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

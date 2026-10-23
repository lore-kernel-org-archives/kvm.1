Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800001;
	b=nUBV4B43jQJIsYcrt+TiTpthuQA3OdKMURncSV4jyPYiXMx/ow5dgGnTdErAYAQ5v/vp
	 LEgl6ROiGZMkMcmoD1ytcbbU7K3Zulz64NQZZE6kjOGxfanrvbhFc2++XTNEpXWeygUG5
	 FjseFkohtkeY5i5z0oU4R6GocMkh0IXA7MnBJzXAatPYfXRME4Cgx/xmmgRX5cXNwTprL
	 izHM6Mh7WjLTQByNHQxzscj2pQnTRYecgUwtagIKhXXfsgsC/xzAQ2sIJPiH5RCqh0eY7
	 gGPMYALcHDDeeth/H02vQMM9vHRvPE5J3wIZi021QM5coLGrYNNqDYYs72y/nNuHrkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800001;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=raIKRDdJ2lXVWnao4F+KkUAradrOXqDPz4OspmwKAJg=;
	b=Wzl6z4+cPejKVO22rmo6bJ3BRirD0nVZ1O9nTAr1eaVQTN8IhRo+K+jjqOw9ALCbo6/T
	 GDnb3vOc2BUJNl/wghApGB5SSvrlQv3sezodedHMJNWwYgJl09Yl73YVCcA37H7s46q7G
	 4JgYwzLcPxduyQyJ0o7RqZjCmH0NFP7mhckNx6JJFHVYKrOQWy3/DMZCpjfgR4lSVRTCf
	 KzxYFmrj4bWfr7+SdRJ+A3uth2JRzii7P0wDuj1R+6Qvms5c80lEljCjx/kckeOb73Y2I
	 KlbmgjmD8+6JjY70gLK2IbD+ijaLepRfj60B9kPFBNqlInc1NCecO+/B/XMuPoV7FSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WcNz8lo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E50606A31B;
	Sat, 24 Oct 2026 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcNz8lo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FA1F01825;
	Sat, 24 Oct 2026 00:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792800000;
	bh=raIKRDdJ2lXVWnao4F+KkUAradrOXqDPz4OspmwKAJg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=WcNz8lo/f06b4NMB2Utuig8DMjjwqz4Pu4KfnJSNFuokUyfIUJw34dhtkQ4+zzOWO
	 GXXmHOk2UGcBRmmfxollQFijcT5ppqKR0ZAPzoXPpb5LKi+aAX+eYKgJhUV+8DNkXR
	 BR1iTCEu7MfJ8ByXZ9IrfsgryKIgCKRDt/5sDflxyt8vdn86qHt/47OrYibNRRBCZ2
	 GiLV+Z32Ko3KZpls0uZED1TgtKKX/ffpyHLN0AnBMnzeqUzT2r62g/lVJwEjNBciIY
	 m+N0NPT03ZyzukbmjDy8pBamttRMGnWVGfmJsHT1yPUO3He6mnGU6vzHsnXj4WT9fv
	 Fvhg3bdySA0hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0753F391B16C;
	Sat, 24 Oct 2026 00:00:00 +0000 (UTC)
Subject: Re: [GIT PULL] KVM updates for Linux 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021164511.125947-1-pbonzini@redhat.com>
References: <20261021164511.125947-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261021164511.125947-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 164405e8e9a0378c7e1aff2254625a6553a291f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56070f00d07e30caa9a66c3660045f5f2956a629
Message-Id: <179279999860.1343641.14152902217400138981.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2026 23:59:58 +0000
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

The pull request you sent on Wed, 21 Oct 2026 12:44:42 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56070f00d07e30caa9a66c3660045f5f2956a629

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

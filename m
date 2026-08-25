Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9337EFFD;
	Tue, 25 Aug 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687496; cv=none; b=V6N2EYp+EFQDNP/BBOfB2iFgFG3/fyuCjSlidQMLKXEiuv/75oaDSuO1BKLtm9+PxZ5ekmCSHKEnnTH80E+dl7WOUtzZEPuyw3yTEbppmAtLON6xwQ82VrRUiIogy/Fl1DjK09ryICqT7ifjqNT2+HSHqaJ5wFz9RhQGqcMnJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687496; c=relaxed/simple;
	bh=y2PG5Q3f0SvuykA0as5F0DW6BfFO5+hxUXV9C9S+U10=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=URBCS4pvqjYnyaHW084flbNMG+7YLo8KDvxpeMeMvgJ+CmRycmAaNmUnkp/fPReUdBlrvQeXuMqn4RjGtQOS7avr/J/Ji2nUksozNcoBDmmsH92x08I12Ve44Nkrrp+o5ocPHMcasdSA1nCCl2PKdCWawDeYECbkM+1dl+xBxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTfA+zVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTfA+zVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1284B1F00ADB;
	Tue, 25 Aug 2026 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787687494;
	bh=L+ZecYVZRtTWw+NM9ap1Xf2ZHWXKwKYwSQT8jXREDb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LTfA+zVOZOgyNNUrwWv1Gcl4kX6V2zi3g5K3ufPqNa6adiPSSNW4hdGT542Efe9kb
	 EyT2N3iLEI6NuzbIWlBfg2EV1coY16kihASBLPeUTErRLBK7Wi+o61l2/G7AGS9OZz
	 5XoZDwFtHSRWvlxxCzN9AvJMo3G6ohwsmuSjNFvPVV04xvkXrcE3r4WVX75CQUHczI
	 QgKkVtJ8GNmI/6ynHvuEJtIR+OfQ2vtAGaalgKS9FpsxHCGtiQMvR3IdhD5eusOCl9
	 Pd9Om1CumbJo+xXONb/9sJZfDo8fKPdkBKuEFbDnJz6diQyXlS3I4NvoCT8Zqy7ShQ
	 lgBhh8IegReSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1977B39253CD;
	Tue, 25 Aug 2026 19:50:42 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260825155236.46673-1-pbonzini@redhat.com>
References: <20260825155236.46673-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260825155236.46673-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 76671054f9a1ff6abb976583cd8da37650acdc97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bb6284aa7b3c369b41e7f33fcbe193161f008e7
Message-Id: <178768744095.4034242.13220905409617785903.pr-tracker-bot@kernel.org>
Date: Tue, 25 Aug 2026 19:50:40 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Aug 2026 11:52:33 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bb6284aa7b3c369b41e7f33fcbe193161f008e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

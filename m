Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E0401A01;
	Tue, 21 Jul 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653622; cv=none; b=Op6kC2kCe+oTgqdS9ge+dLmBMkn/HVJyg9SY92fOkk8fslIvbxmzDY2zCTnurYvXREtUSUW3RhOCbpmy1zQx3sS+580ldbMgiv85X6H0Nqvf0O6a47UTq8ehXRFdGrGtT6VdC9vziSPn6sRWKSh1ADfZLa70OWvVHVlt7UVrlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653622; c=relaxed/simple;
	bh=4hJJZq4YAV2ZHKm0qLwu/Ypu+24cVWcMEvlCebufYqM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YKE3Qn/fNBoSoMrU7cfG2NQcH8RFwxpJ5hCcAc5K7342b1QNUSlcHTGz+8MpoFbTdSKYQRk2TtLzqurY6MCKOVDVJth0XZXdW7JSehGczZSTtnMTfdXUnNkfULQB3q/k2iitaD3FKuGMoJjdAhbtw621x8Ueclwb7O3qgQyisGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu31jqNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu31jqNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2681F00A3E;
	Tue, 21 Jul 2026 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653621;
	bh=LBKIMa4wxJCNbyaAI8QvvCoLcAD0AmKI9OY8HPkXJ1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Hu31jqNbttSTfog/h6lkdNl/nK26wbyqVTGO0q4Dnv2Pbrkf6NtFMVCAI8gJG6MGg
	 T992Tkr6lUt/xtSjnnHLUxj0focaI4RNpJeGqLZ1Qbwrgtq3beWlPU5nyipyrxy0/C
	 EIF0p1oHgp3mkWuhC9Qu5EdHEV1ThM5tgdYwKkOGawQWit8e6THk5mxioFc0m5PlNc
	 x3AD5tLjPwB7WWATEPRKq4W5fzKjo9ly76NEiPocas7gIxk5hZ36oPU2/nu7YABayr
	 J+RCZWnEq2WZMXOsznr9pwQi6Xm65CFmfm8BYdBz39N0TifuA0fjfXXrDmDKpkFenF
	 3aDHxqlPH3jkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1039253C4;
	Tue, 21 Jul 2026 17:06:31 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260721102855.313301-1-pbonzini@redhat.com>
References: <20260721102855.313301-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260721102855.313301-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: e61e6fd4f139f2342a6bc86da602df7456ef87f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4b760b59fad082671b075f4f1fdac318c633a61
Message-Id: <178465359049.846420.2269556716349188041.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jul 2026 17:06:30 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jul 2026 12:28:55 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4b760b59fad082671b075f4f1fdac318c633a61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

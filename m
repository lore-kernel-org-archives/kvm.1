Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121272701BB;
	Fri,  3 Jul 2026 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047399; cv=none; b=GKyUmWINpfGKcKgZmkTcuz4HVdC1XqHA+8etJji4wffxsukzCEHFe0BUfEFw8jia54DTvs4y3TLQO99/QqbTTj5Fci/ZNuQ6NXUG8m+iWzyP0/HTCZ8ZvxX2c+v8vuH3hwKY5OIpMDyOnLpKkIkC0IpO4lgfUVMomW2jxmUM22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047399; c=relaxed/simple;
	bh=/QXLYWfctwowfMJ2uQk0ExrbO5K3FJbinEavSIfjMyU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K2sQvvD8uwxbxA14HNz/8bSjOVSw+EyAa3jy9ZyFsYdidLvdUtM85B4MCl3zlA1REgXf4WNgUvxTfSqOjY6FODxHVj40kqNNz6Fqwd5rHLY/NogVg2D62kcoUJ/+FkmbA7o8tvMI4ioDKgifXPTeHbRyMuqutlC3DYKCrj+n8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpB3mxdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpB3mxdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03251F00A3A;
	Fri,  3 Jul 2026 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783047398;
	bh=WHcNOY55q/ZWjIemuG1NO99upVJFbCS41Uy1PonlRdA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TpB3mxdvK0GkNRNgKuip0zVbxQGvBVkhnxoKgzZ9iEcuduULjQDyYS3cB3T0gsLnq
	 SgYCTCwwmdgd7SmLtJhB5RUvPzxpnOCyXK41ujHu3usWsZE8UxYbo8CMHbj0EOAJWm
	 FZSt0T4vOudvtJn1iZwEKKu7bfhDfVnv5um8HqSUbsMyAJLmPemSxqV/RkXWtoRsBD
	 lmCuC8AvIn5m6vP2KqXNBLYtLhOPS02x5FtQSNjE6VZzeDfjBpuIP1GqCJILUfJrC9
	 PATZgucrcUWycGydIJJcQP0dBdfXZFlGuH9Krg+YLQdyDMxnWId6Cy9iNnZzVO/SSf
	 I8KNxlGNTkQDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2E223938454;
	Fri,  3 Jul 2026 02:56:21 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO fixes for v7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260702123402.7f173c7c@shazbot.org>
References: <20260702123402.7f173c7c@shazbot.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260702123402.7f173c7c@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.2-rc2
X-PR-Tracked-Commit-Id: e242e974e812e7a47e3088860c80d9492fac314f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 826eec5b5efd785dc87638a54d5ecc9f88e5afce
Message-Id: <178304738050.2410170.10717489903428399407.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jul 2026 02:56:20 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Jul 2026 12:34:02 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/826eec5b5efd785dc87638a54d5ecc9f88e5afce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

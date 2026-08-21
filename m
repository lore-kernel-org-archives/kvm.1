Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4E25DB0D;
	Fri, 21 Aug 2026 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271084; cv=none; b=DXGaT43YbjsPjBjU29qBBjSSr6BbyaCOwmOSl16ayjCBUJEhgPsJO5O+LII5PeXgUDl7JPwZuUj76AHpOvy+XzQOuy+6m3vLtf9mmly/rgsf2IF8JSlsnEKpboaUYSGl3/MfWrS/2h92Zyv6q2nxb1VNT7EPsYjQO7FE9xM1GYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271084; c=relaxed/simple;
	bh=VyRLBcVEqjtiz+yK6OrkeJnMIQSH/jXdHWdtjTxMhe8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s4KdkZPQTjB1amuqfH5n3Xor+DNFFcgTqqdK0JxrmtmHlh2KlfIegOyTHlPEcc/DJPAvvzhilhbVRI+gC9HTqvNShQ7ss47n4sF2Lt1lNRvmQq/WidFH9JVDPUM6VtjiZM3yivJPZQxMouUe79vNzXdPN3OVHGjvU2JEhUzUU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IydJAiyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IydJAiyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43931F00A3F;
	Fri, 21 Aug 2026 00:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271081;
	bh=kb2HqAqvxHHJlqW4fDS68EegnlvDkI7kPzxPnPlo0oM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=IydJAiyl/Kg3/8uty0P9qRvjAIuXoF0L0wT7nZaUKJxbNiy2FcOBvUCl7I9qC3aYr
	 w53F2aMgIp+B8k09oltk47b/pWSaduO7bJaaoyzuMs+0QNC9F7YqESOiDhwmuWc5vC
	 CDJE7qJCfmolUOwgUukGGEPIjZm6keoKQAY9N2VBijj6Dg+ZUnJexfKYRoPMETQ7T9
	 xP06MKgpJpny5JxzwF3/liGXUqHyGqntzXkcL/DYjmPssR8p92JVFUcf/HUs+/xLxm
	 WiUDRNKpUH0g5Q6cWCr25VWn2DByhERRu3FF7UM8MGQeK1g7/UQQ95kqf9VhHTFQvQ
	 kC1NyI0Pp9LgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197873924472;
	Fri, 21 Aug 2026 00:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260818164326.387bb27b@shazbot.org>
References: <20260818164326.387bb27b@shazbot.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260818164326.387bb27b@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.3-rc1
X-PR-Tracked-Commit-Id: 4e3c1fc8abcb8eff062150b4340fa4569696d645
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a625b2a387628df94e385faf5c81bf252f304ed9
Message-Id: <178727103192.546823.17425327329216487398.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 00:10:31 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Aug 2026 16:43:26 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a625b2a387628df94e385faf5c81bf252f304ed9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

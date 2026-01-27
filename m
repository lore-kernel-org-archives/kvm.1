Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D881D9A54;
	Tue, 27 Jan 2026 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539824; cv=none; b=KGEFkfwdIU7udMtnFRuXjMZwnGxcWufJ8pwXAiZo8ZGdiHpV42Ha0EqoK26aLKofDluhayJzUsN/WuQeWYCzmzRZt2TWkpebhli3L4pTkoyEIor/DbqSQywpvKvjWEJ/JETEAuA3vdBTR6ltrspWJbJGH1/N+qG5TQFHcoul3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539824; c=relaxed/simple;
	bh=GRf966ihLktzX1JbjxptNTxAmuEDHopWtjl/O1K5Zu0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jvd2eoCKF6qiOxX7RMUg372OdX9NOyaZpWvJ9z4ARNtaNiKXF97DwqaCV3oWJHxLqJ7F+sIrU8eNhX/aNw/iuUQowtzaKgN3xHZDDtfvNB/HKXQsDlFr+LulCDoIdt6MUUot8R1JJkJa2LCLDqjs41RMGZArS/1lJ2LGvQvPW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUXatg0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUXatg0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6892C19425;
	Tue, 27 Jan 2026 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539823;
	bh=GRf966ihLktzX1JbjxptNTxAmuEDHopWtjl/O1K5Zu0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CUXatg0rvfNKwzTHkli/jgqS32VQinQcXxklnHUtqcb3NIqvQR7IlmOKHD3DJdmCj
	 a26qBSstFKUMIm864hR6X8kpbFS8UVKu3iaDese+9GLjmPvx5hX4SvyRtf+OyEbiej
	 s9KEYtGltz0vsI6HSS8LuapfsQvJqJKDEtHs7SmxzV9NAW0kyGcovqhAFOQeJWyws3
	 zRsME0gMAJfDK5l46lOB33d9gWkD80vEsu6YhXsZAY37dxKv4z8DS04C16mq4ZRzDH
	 rNgGnHhrLcatwgKJCNETCigUkZ26NXj6Ia9r3HPHMaju6HcNYHp84zQvHI6Cn0zOJ2
	 h+nbZTEmifVow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11D4A380AA58;
	Tue, 27 Jan 2026 18:50:19 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO fixes for v6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260127110550.6e5dd005@shazbot.org>
References: <20260127110550.6e5dd005@shazbot.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260127110550.6e5dd005@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v6.19-rc8
X-PR-Tracked-Commit-Id: 61ceaf236115f20f4fdd7cf60f883ada1063349a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f97d9dcf53649c41c33227b345a36902cbb08ad
Message-Id: <176953981778.1360837.5016674604579490098.pr-tracker-bot@kernel.org>
Date: Tue, 27 Jan 2026 18:50:17 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 Jan 2026 11:05:50 -0700:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v6.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f97d9dcf53649c41c33227b345a36902cbb08ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

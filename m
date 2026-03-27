Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062E35DA50;
	Fri, 27 Mar 2026 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654382; cv=none; b=a0TmTTW09We6Mb+U5NZdqAxl5GluJ27JvZgwbhJ0lSUD2buu2plsI/t8tHWuWy8uOO9Z5VCFD5M+wiDKMF2vYKzSF7ef7iimQ2JBH/4CSA+uYcccgW3RwYf2cz3oYLhtnEOpgy1Y4V1i+4arCOkMedbbxVGsdJUip/B+xcbKLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654382; c=relaxed/simple;
	bh=874aHN5/qFvck6556f5qUVXfra80Kj0TTC6YJdG7wyk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LFBZRROlidPkkLhj6pUsekYouv1phhHuRujB13eCsqDZWk6Ka6J/t5nEaTgc0AvH+lZjDpUzCykoOA+EDj2fXqi34rZQl4Skmbt2WqxG1YrcJUDRSAvVZF4Y7O8IMWsacegJVe8Sz37w/16KouygJ072jhvGQlp3k0VrvWi9VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpbiStq6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpbiStq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A7FC19423;
	Fri, 27 Mar 2026 23:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774654382;
	bh=874aHN5/qFvck6556f5qUVXfra80Kj0TTC6YJdG7wyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tpbiStq61hUNFsfJ4ROwDaGidyRW2qNxl/Sycu629vyHTBW6innVHdiX73iTpRBtj
	 Yfg/W8V4l8O/6XmVFQQL1uvD1ews7tsLKbc848DEPQF4tMqW7NVSSZReAVSB6gSv3J
	 BApFEEJHGAJD/vCt7XWsefUS0Nhazc5gHrn0nMZ4oJbIEsrXubUo0eN8S3l8sbEKSF
	 8H1BK9EH5alR4JDR5rFsNnlGgzkpf9KTPuNtSLM0lVgolBfp3UCG4F4OAmdkDR3PKP
	 Z20DPgPcv0lbK1MhdcXFCdJzjYOyAoM7pdt4sgMh3L6gilS8Aq/L3546EWDKpsW9Hw
	 YcTV4fjKgrxIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F6F39301F5;
	Fri, 27 Mar 2026 23:32:49 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO fix for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260327102655.65cc762c@shazbot.org>
References: <20260327102655.65cc762c@shazbot.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260327102655.65cc762c@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.0-rc6
X-PR-Tracked-Commit-Id: e98137f0a874ab36d0946de4707aa48cb7137d1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faf44e54f6def4dd85b2ae35d6b332f81f9d7e91
Message-Id: <177465436755.4116696.13252113139627307539.pr-tracker-bot@kernel.org>
Date: Fri, 27 Mar 2026 23:32:47 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Mar 2026 10:26:55 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faf44e54f6def4dd85b2ae35d6b332f81f9d7e91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

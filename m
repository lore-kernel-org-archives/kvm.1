Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09A2F7F1B;
	Wed, 17 Jun 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723694; cv=none; b=OEZJ5k/Wy4DGOwu1ba3ZByPvPKBoyfxS5uP+jNWKIAbY1FK0NnHv3p8zShzkotW+u2M2NOiI7PQbsLOkKAsghMX74f2Ej7ZrmOmf454uiRWLgZafVyVcicEmSSKddLO1JBkcycS1fk+9F+3zQAAM2kzWmPB/zDlGT35f0g4C1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723694; c=relaxed/simple;
	bh=xxyqxrAB5E1rF2EsOJ7qVVviGdb/My+SBO+x+983MsU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZHyVUz8IcO8NMITDpogX4+FKluqHdIems45WzCEO2ifxuqwh++3KzKBBfbWq0b2EH41J8dq4OZ5o/I7f6MLpvJw8mKsYKoL1Q6Y7aN9QZ/P7gDjtpleo3E1wJ8HV5XY66CnXATqFQmO5TEkChA7tXliibgFiRjRhiGoa09DcUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWASbP60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWASbP60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247CA1F00A3A;
	Wed, 17 Jun 2026 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723693;
	bh=/L4gQBuD5eZAkYy8a531A10k/AhZ3l4Z2POm9+KNEQY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=AWASbP60ldDIL4gXjIy/FEEyGehVy5th8OezGba5SM51A7gb+DqQgE6OoXwy2hfN6
	 Rml94eFLV8f3J0PnSoAfYumzzAZQHIR7kZTfxdIZyoJCb3AmrcxVXzMry8+1IQC+MV
	 tFnrX4cHtxV+0IjCobSkEIamQK+LkZCy6PYbFXmoqsjb7CzwbI7jfW9YNytYs6CITm
	 M+pyCwOwAA+cqHZ/oaiKFfFlEqe9pMhLLQirDr9I3aIN2G3XbHIJO/4MtxnQoj3iNE
	 lRDPXAhkxhk+4CZv6V8VdTU+sKpq203pSp0c6sZT3wURi5+MO3y6qgdmTnS1645I+O
	 ox7zXLUlw0Wxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BE3931008;
	Wed, 17 Jun 2026 19:14:48 +0000 (UTC)
Subject: Re: [GIT PULL] VFIO updates for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615163849.5b6ac84c@shazbot.org>
References: <20260615163849.5b6ac84c@shazbot.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615163849.5b6ac84c@shazbot.org>
X-PR-Tracked-Remote: https://github.com/awilliam/linux-vfio.git tags/vfio-v7.2-rc1
X-PR-Tracked-Commit-Id: 785562e31dbcd85ca583cf58c446e63aa8a5af08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dc0df03396a3329c644b29b421892a32ecb9387
Message-Id: <178172368691.1775335.10571244895207533786.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 19:14:46 +0000
To: Alex Williamson <alex@shazbot.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, alex@shazbot.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 16:38:49 -0600:

> https://github.com/awilliam/linux-vfio.git tags/vfio-v7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dc0df03396a3329c644b29b421892a32ecb9387

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

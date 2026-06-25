Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7B2BE655;
	Thu, 25 Jun 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409251; cv=none; b=qdHzNtl5rthSq3MltcMqoehvnwHuNhYsUOU3N/7JwuySTkAYEqXbe7y7K5qpDnD7G7nfkhXfWIhaR1xiOSrUAlPCyne1EsJ6YKK7StuJ/HyZkpQJddjP0O0uenUva7/dmv9q1B+BYvlPP7zY0JQyrc0Ku+3u1B+S8ytmoEFZuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409251; c=relaxed/simple;
	bh=ZYR6dBGDcYxKvHMkWNCI2lA2i0Kgw8rOhF2KAy9U35g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Uy+B+vvHcfPkTLdea3jovkSG/57yGcATr4bwI4H2KEhct32YM2qLGYbNbVaGIXS5MWG9Cbkdqm1/J1YnAYZ122d3VSuswEr0rGl5G6qZeg/cHZEcptrcc6iI4/itmhnP3sTlHWBeND0+f0KaUqeYKKNFmTn9ymqOhe0OHRPjTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBX0qTBR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBX0qTBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1621F000E9;
	Thu, 25 Jun 2026 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409250;
	bh=B7UtQvsRq3o+a95lJ0sWz6m+74eV6TqqVFqgno7QBUI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MBX0qTBR+IDQZeYKEmlvNpc6e1d+gLnXd4hGZfmTnd8UsEJXmaQqDDT/27g40y6Mm
	 o3X5hby+3SMSn4pMBzxplVeuC9t+gJ3KlUFCwc56nuC4S8H/8P/syQ8FMLCguGIeRn
	 aqb0SCgKea+/wRQzB92oQ2ggwzfDrOmWqJmuHSpuin6IcDTk9ErzHAwdNF/D1Sgwgi
	 QbFoBUDMZCAu0f+0fy0y1Pa9F62bv7+qGSy4ENlG5vRqs7XFmxGLNekIkFV58stbl3
	 T0EvoKDIz+WfBRhlqP6a5vycsCAv7uyaO70tBFJH0caYIr8czkXglPREKz/F88nlW/
	 50XgGzPH1cVtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A88393879F;
	Thu, 25 Jun 2026 17:40:39 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260625122325.100485-1-pbonzini@redhat.com>
References: <20260625122325.100485-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260625122325.100485-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 098e32cba334da0f3fa8cfd4e022ae7c72341400
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c75597caada080effbfbc0a7fb10dc2a3bb543ad
Message-Id: <178240923770.87998.13726639435071666376.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jun 2026 17:40:37 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jun 2026 08:23:23 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c75597caada080effbfbc0a7fb10dc2a3bb543ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

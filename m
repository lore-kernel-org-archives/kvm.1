Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47D3AF642;
	Tue, 24 Mar 2026 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332458; cv=none; b=Q5CIJj8KpX8UHgy1sWBvN46+YSOJqCPMjyuono/Af/DLoEIW67I5AzoUcDq8NEVl3hzCoAeekPRaKd8PcHy24blZP6YjHauu1dMEJmCia3LtLR4QC86rUdW0pXEm1atQp/BohHYIEqboh6zYLQzHHPP4wLuLGhYdop/ZF0mf23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332458; c=relaxed/simple;
	bh=5TiSu/asBer7FpjtJQ/4BOedGtXXS9dtYnxsawzLT50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDoKSu6JW0gDGiW4+MGSuP7VHJcEvvZIuWZ16bkVmkLGdXPnTDZHenyirH9HuVpF7PlKIFUjqT7DSJ6MY2VpZzPu682jwL1/Aj5qYqsHAPgz29f6TpFNuKUVirtz4you0C5gy+0dcsvQ6JZnAljUQCD5V40BXGwREevBLNbdV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/dAlcel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/dAlcel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272E5C19424;
	Tue, 24 Mar 2026 06:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332458;
	bh=5TiSu/asBer7FpjtJQ/4BOedGtXXS9dtYnxsawzLT50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e/dAlcelitlNgqMX3PV9hN3qEIImYy80941mmwKTFHdM70zinBHDdDtYi0OQLW3SZ
	 AxtzJBOaToA0pkYIiu6pUMdH5vPoYGCXeoNMPvORWXTYsFmlOjgDCSpAI4KLogLBDs
	 NicpDBqeiF8S7CCPzVRvTia5NWI2FZvXTK8Eg1hXhExpOwZukr4EkA4diTfZtrXbcC
	 PuddORW7REuHe7Wv/iNvIi6fcdYTxfs/3QvcBy1aN+a9aSlxL8RplWJhLSC91iAMN0
	 WloP4eQO3SqdyF/W3+AKkDT3TUuuObJMheCgUPT+IJHKNW4NGRkisWfyQtrk+otWqX
	 MA3nP66Gvc8iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6F9333808200;
	Tue, 24 Mar 2026 06:07:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Fix potential UAF in
 kvm_riscv_aia_imsic_has_attr()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433244628.469836.354325363149940595.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:26 +0000
References: <20260304080804.2281721-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260304080804.2281721-1-xujiakai2025@iscas.ac.cn>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, aou@eecs.berkeley.edu,
 palmer@dabbelt.com, alex@ghiti.fr, jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Anup Patel <anup@brainfault.org>:

On Wed,  4 Mar 2026 08:08:04 +0000 you wrote:
> The KVM_DEV_RISCV_AIA_GRP_APLIC branch of aia_has_attr() was identified
> to have a race condition with concurrent KVM_SET_DEVICE_ATTR ioctls,
> leading to a use-after-free bug.
> 
> Upon analyzing the code, it was discovered that the
> KVM_DEV_RISCV_AIA_GRP_IMSIC branch of aia_has_attr() suffers from the same
> lack of synchronization. It invokes kvm_riscv_aia_imsic_has_attr() without
> holding dev->kvm->lock.
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Fix potential UAF in kvm_riscv_aia_imsic_has_attr()
    https://git.kernel.org/riscv/c/7120a9d9e023

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



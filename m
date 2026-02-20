Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0132308F0A;
	Fri, 20 Feb 2026 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560636; cv=none; b=Fr5KJvq2jR6tDEfPnlQHswSlsusjIXYp5graNBpj6VZKZZ02oavDRKyzGWOr+MtzqS7yY3Zlr6ecEFV+hkd61yGpIxSqZ5QjfK3xUjs702c5Vkj9StHJJxL8jijZ7dxgndXNrUolvoFez+3nRr+FoIBLw4HYjDHmkQQtIseXKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560636; c=relaxed/simple;
	bh=Ifpckop5sDPNCgmdPL4sGXc0scyTZuad/LyPyb/8d1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrVziPf7q5Yp7NTseoXZa1VOXLapSOriar5RsKZMaR7XRSo7PXFyiXtyaGXQVnzGM3fFeMgVTIc5ZFhyc2pEigXLYI7zGPHRSbFQS09PkNOg/vN+59sjL5loAqbXGgGERuJM1h5I97y2tn56ltX6UK7031Aoo94eip+ykFiSNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK6b8wox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK6b8wox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C77C2BC87;
	Fri, 20 Feb 2026 04:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560636;
	bh=Ifpckop5sDPNCgmdPL4sGXc0scyTZuad/LyPyb/8d1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mK6b8wox98nl2xIIq+AirgaDUITrg6ikL3liq5eXJET9k3Yon4jEipvaywhEvQJuJ
	 +XZXQWUly4/pUm8yG4fuLZpep3z5QKB3RlQh6tNIaWtBPhTKANKc+h843s2NdFOmGh
	 xhFR6wzGtSgVyH7OQyfEs+lOXq5SnkZQc2gstZHdg2Yx8vF5pn3CpGHyuyA2NmUGVp
	 7uFPlJXR/Q85k9UoBJb/IuYyCxX5IVZs5lrw1ZDiTm5C2wUPUmGdo1/rwpE64PZHWl
	 C7hEU2Lbw9R9cCL5YkC1n86LlWOHsFJ2oRfSBtg6hbCOFvt+kQYVjbN5ckyV3zNYjX
	 kAG5miQD2CIMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400123809A88;
	Fri, 20 Feb 2026 04:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Skip IMSIC update if vCPU IMSIC state is not
 initialized
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156064504.189817.4302642983283569881.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:45 +0000
References: <20260127084313.3496485-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260127084313.3496485-1-xujiakai2025@iscas.ac.cn>
To: eanut 6 <jiakaipeanut@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, xujiakai2025@iscas.ac.cn,
 jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue, 27 Jan 2026 08:43:13 +0000 you wrote:
> kvm_riscv_vcpu_aia_imsic_update() assumes that the vCPU IMSIC state has
> already been initialized and unconditionally accesses imsic->vsfile_lock.
> However, in fuzzed ioctl sequences, the AIA device may be initialized at
> the VM level while the per-vCPU IMSIC state is still NULL.
> 
> This leads to invalid access when entering the vCPU run loop before
> IMSIC initialization has completed.
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Skip IMSIC update if vCPU IMSIC state is not initialized
    https://git.kernel.org/riscv/c/003b9dae53ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



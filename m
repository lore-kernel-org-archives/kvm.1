Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305F32FA3D;
	Fri, 20 Feb 2026 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560657; cv=none; b=BfN6C6Bw8cuyqoRk/vfqBGagE3uyxYbEmB49u6qBnGdS3xbkM1hNyWcHMwuWyZOgjLgJl/I8ETWo8XYeWjGLt6mYumkhipWYLyfuWjN5kHrVPDohMDZQtpFAF82i/VFxCE6qkQkImtbpbhH/Jp3sXOBRuT/ePsRgih+UHphsZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560657; c=relaxed/simple;
	bh=B9ojwB1QasO9eFz6CVWrutapCwSRDIdZql1m4r+SU+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mRg2iqIugM5mwh/qZerca8GNmyl6MAiDz9EwPrLjBGubEn79ocQb9ZcGO6HNpFAIjTsVBa0Q2jRmTcVuyg1rX+m0InlfuqcKxldZW9h24tJJK8drxKKWNWesXauqwR2Tl+nJ/c+Hbo5+bTwI56oylrlQJwS6mTbPgXw4x197en4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6V6kP0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6V6kP0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B12C19421;
	Fri, 20 Feb 2026 04:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560657;
	bh=B9ojwB1QasO9eFz6CVWrutapCwSRDIdZql1m4r+SU+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R6V6kP0b2K0E4zkJZCAWAYnE5G8mAjpiMEQdidmAH4I9Dx2YsY4O/b1KztZfm4Nxz
	 Lq/sng3k3At1ZHCTHzdppW6WihanXP+64wYH1osYwqIpmOvbRPHOjnMqS1Jkv0bE9g
	 hnRiqFJWjWMOeBJ05jmObWilO6+Dp4r75MaH8VlDGH2cmCn+h4aVU8Rmtt+POVPqVh
	 4rHAbZ1qS2KvYuQVcCfYXO+gjE/cZKbbOusBbHdjUhOVI4709oKPAuh62bTwUeMSDF
	 vLOOEmvvr3VlG2+lIvjvdwcmGtLPUEShkhtkrE2Ht5Hp3oW85jcch1dfqxu0GTNadp
	 5w4+FzcEa1MkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCC73809A88;
	Fri, 20 Feb 2026 04:11:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Fix null pointer dereference in
 kvm_riscv_aia_imsic_rw_attr()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156066578.189817.1206944543601300200.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:11:05 +0000
References: <20260127072219.3366607-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260127072219.3366607-1-xujiakai2025@iscas.ac.cn>
To: eanut 6 <jiakaipeanut@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, xujiakai2025@iscas.ac.cn,
 jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue, 27 Jan 2026 07:22:19 +0000 you wrote:
> Add a null pointer check for imsic_state before dereferencing it in
> kvm_riscv_aia_imsic_rw_attr(). While the function checks that the
> vcpu exists, it doesn't verify that the vcpu's imsic_state has been
> initialized, leading to a null pointer dereference when accessed.
> 
> The crash manifests as:
>   Unable to handle kernel paging request at virtual address
>   dfffffff00000006
>   ...
>   kvm_riscv_aia_imsic_rw_attr+0x2d8/0x854 arch/riscv/kvm/aia_imsic.c:958
>   aia_set_attr+0x2ee/0x1726 arch/riscv/kvm/aia_device.c:354
>   kvm_device_ioctl_attr virt/kvm/kvm_main.c:4744 [inline]
>   kvm_device_ioctl+0x296/0x374 virt/kvm/kvm_main.c:4761
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   ...
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_rw_attr()
    https://git.kernel.org/riscv/c/aeb1d17d1af5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



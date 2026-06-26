Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9173E63BF;
	Fri, 26 Jun 2026 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462112; cv=none; b=hx9Al9a9jJx9QiPZ/OokzRmW4sKxt699leR1AVMzrJs41Gr0GGXnpVuKwVnOEJNsQnDriS1du5Jg8HVXCICyL/dVCpAS+/X92TJnFh8qAE9mqE2acW8zy9mVpHbVSDUr6UWGfwkJ/Ifkb7244aM113OnPWJH4sAGPGDyRKxVCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462112; c=relaxed/simple;
	bh=7mBAUboXbBsIAvrg5DJH3kWL4Y1U+Y0QNvknv34WZ7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MD7hLPxnra/7K1o6c5VRKg9iyP22Uma+aCM/lM+iirkLAJip5nQCepjbJAHJK8iBGIFcl8eyPBv3U5QY2IuEBHeY8LCdCuekxeRl8Hgpk4lvoosndt0cTKQ0bH0e4NgKRimH31ZtssIMICBy9bCwwX3BP1Qu+OrKD6rxo9EdeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKaoLeCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKaoLeCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD31F00A3D;
	Fri, 26 Jun 2026 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462111;
	bh=72yOiaA8TWoMcBgxP6mWwE+LHov7bJ9rKxn3P+RprOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DKaoLeCVBLfxGRUCDD63mz3Yv7wl1NmkyC/oWe1VXxnYgbNOgx8OLIb97BrF9ahWi
	 9/keAucRqysUZAM8A/5IiD86BP+oNc90Y7vaAxe3E8/8cQ0NmxW9/zls0xbx8r6QBW
	 tHZnjpYjiJyQN4U0wFT/X1gcBAXyemKYO4HqQsMjy54TLKkdesvd33LtZi6FN5GxU+
	 vhJEpEXa0WW8Xr5G0nVV3hjoEOnOHOhpuPuem40C3KmCu/gOqyOqma4VMQnFra+8t8
	 HFwZ628Oz/edI1HY69uzGDt9l7vmmnqeBQUy1kcz8Dt4Wr7K5k+utU0I+nvK7y4e5x
	 w/sKB7Uq98upQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690A39389E8;
	Fri, 26 Jun 2026 08:21:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC
 functions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246209795.3816447.969073388950467321.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:37 +0000
References: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260526031517.1166025-1-xujiakai2025@iscas.ac.cn>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
 alex@ghiti.fr, anup@brainfault.org, atish.patra@linux.dev,
 liujingqi@lanxincomputing.com, palmer@dabbelt.com, pjw@kernel.org,
 jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue, 26 May 2026 03:15:17 +0000 you wrote:
> Fuzzer reported a NULL pointer dereference in
> kvm_riscv_vcpu_aia_imsic_put() when a VCPU's imsic_state was NULL while
> kvm_riscv_aia_initialized() returned true.
> 
> The global initialized flag is set per-VM in aia_init(), but imsic_state
> is allocated per-VCPU in kvm_riscv_vcpu_aia_imsic_init(). If a VCPU is
> created after aia_init() has already run, its imsic_state remains NULL
> while the global flag is true. When this VCPU is preempted, kvm_sched_out()
> calls kvm_arch_vcpu_put() -> kvm_riscv_vcpu_aia_put() ->
> kvm_riscv_vcpu_aia_imsic_put() which dereferences NULL.
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Fix NULL pointer dereference in AIA IMSIC functions
    https://git.kernel.org/riscv/c/76ae7c7ee004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7D3B47C2;
	Tue, 24 Mar 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332466; cv=none; b=sP+yAS1nn2GOdgGFkYGXi7WPaGjzVcztIrQQI/VeimcBdZFDYho5+0MEjt97R5bECI9xHePNa3LbwIYOx4CxbkWp9tkBMtLJPSMXga2YfZ2u+kwU8VcMiopJRFvCUoQCjl1q7sdzMsVDheFaAA0hOyNGz35iWhhKXkwcfjGjxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332466; c=relaxed/simple;
	bh=z4J3ormmSXU+X7jeV6FkQUS7GtywJzymGFhiKVjbDaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UMe4Yz/cTW3i9hcc9M8xmOrtOLjy7MmCIDO8/WrRRiy2cIp4ecNjEAQmFTCR9M+rKJFwYfNW6BlxPH8/IfH3alJSud1b4YM6k0AqcqckDJi+xmqqWBMru6+MDlaZPer0GxcyGaOg6TD24BvpM8P/QQOmY83jHqpYUPUiaGBJIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwoz5Ysj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwoz5Ysj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F883C2BCB4;
	Tue, 24 Mar 2026 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332466;
	bh=z4J3ormmSXU+X7jeV6FkQUS7GtywJzymGFhiKVjbDaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hwoz5YsjR1PACl+UQNn+HH+FllIaPq/7dXZ7ML29dJvWcP3Sy7qtE65yX0PVwt496
	 C50KSpIsgEURb5xPAiG3GJPawXBZBTkfae3QvOjntb5DRvqWxRXTXnPYnoimUQSUbQ
	 gvDMLUTf1JPzXzHl6NetEwiAtjXr6rCbJzlBDFRHcZJ21Vtrep7uhj0ZNP1NrHQJWI
	 bmqjM+5n4g0s2XeL7NL7xnHxTLmRpAL8gqYjG9CAC1LwILx+yARKcV7UQ9MrF6TnTq
	 kuM1HGFpLCFQjB4oq+KUm61KUg+q0SW6jfcLA/yq5JAbXkZ7Ti0FY08zRUFUGMMUAY
	 xEi/TQdsPaMbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9E3808200;
	Tue, 24 Mar 2026 06:07:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: KVM: Fix null pointer dereference in
 kvm_riscv_vcpu_aia_rmw_topei()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433245454.469836.16737695875391376252.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:34 +0000
References: <20260226085119.643295-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260226085119.643295-1-xujiakai2025@iscas.ac.cn>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, alex@ghiti.fr,
 aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
 atish.patra@linux.dev, anup@brainfault.org, jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Anup Patel <anup@brainfault.org>:

On Thu, 26 Feb 2026 08:51:19 +0000 you wrote:
> kvm_riscv_vcpu_aia_rmw_topei() assumes that the per-vCPU IMSIC state has
> been initialized once AIA is reported as available and initialized at
> the VM level. This assumption does not always hold.
> 
> Under fuzzed ioctl sequences, a guest may access the IMSIC TOPEI CSR
> before the vCPU IMSIC state is set up. In this case,
> vcpu->arch.aia_context.imsic_state is still NULL, and the TOPEI RMW path
> dereferences it unconditionally, leading to a host kernel crash.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: KVM: Fix null pointer dereference in kvm_riscv_vcpu_aia_rmw_topei()
    https://git.kernel.org/riscv/c/c28eb189e481

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



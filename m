Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA3301489;
	Fri, 20 Feb 2026 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560651; cv=none; b=kwLva2jPtBoqzc9yK4ortyT4UwEGhdxhkmHsvlgZMjO9KN7lW2d2kzhcpj+/4HzDrjZM9aW1P7qqOAbQdkqGfzL1mkUWyqXhPSIgTFX5qjom7tX3feYqa80zoUSj6RSpAVbzNAZ+xD/hjJ2QiijHYzd4EDQ99q8aCHcH0g7Smdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560651; c=relaxed/simple;
	bh=evdnVFP154xQL1h2OcymHWYDUXgDAm2JlzKuv7gRIj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lH+Hm/5LMnk5xscmx+TqK8QAXFa4l6h0F8rMraiA1dV4rOTqQpOnLTrYXVnKV/aKipOMAaNCu5qK1t74r7JOZfcrNGvj1pHbqf01xvSS0UUk3HTWRmwBnBQXyB5G9wXDhwLnZAL01ILwf9FIDleBDLPTWwVWSKWmG7uTtsutZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjHLnJFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjHLnJFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5DC19421;
	Fri, 20 Feb 2026 04:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560651;
	bh=evdnVFP154xQL1h2OcymHWYDUXgDAm2JlzKuv7gRIj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bjHLnJFfgZqUcJ1oX9WN/ZiccgQNg8JncNFzs31xxTRWUlnKNa5PO/Dqb47ef+sZR
	 tFn9N/9le0ZAudJ7/uH2aX06UIMGI3v7VClm3KFESeJbQ4yVgjXNOiSow0kMioK4bb
	 +4y7mS5u1w8idSQwRC8gIWoCH/vBjV5R3Ng4+W2S/XBnq7o1ygM4/2Bq6qr59DqBIS
	 b9yPRl+ijbS/nL2/WQlYKBxcDMN3Rp9LR0xmvmysoAn9mqlh/Hs6uadGaPHl+0Xw4K
	 mMs0Ywfb/nzhhkMJCR5PFwm6AJklxceQtA3747QdjMCBWOB2pLNkkxV1+pLRmWam41
	 PtY6CIM6IMP+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400BA3809A88;
	Fri, 20 Feb 2026 04:11:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] RISC-V: KVM: Fix null pointer dereference in
 kvm_riscv_aia_imsic_has_attr()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156065978.189817.14743297362954778130.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:59 +0000
References: <20260125143344.2515451-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260125143344.2515451-1-xujiakai2025@iscas.ac.cn>
To: eanut 6 <jiakaipeanut@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, alex@ghiti.fr,
 aou@eecs.berkeley.edu, palmer@dabbelt.com, pjw@kernel.org,
 atish.patra@linux.dev, anup@brainfault.org, xujiakai2025@iscas.ac.cn,
 jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Sun, 25 Jan 2026 14:33:44 +0000 you wrote:
> Add a null pointer check for imsic_state before dereferencing it in
> kvm_riscv_aia_imsic_has_attr(). While the function checks that the
> vcpu exists, it doesn't verify that the vcpu's imsic_state has been
> initialized, leading to a null pointer dereference when accessed.
> 
> This issue was discovered during fuzzing of RISC-V KVM code. The
> crash occurs when userspace calls KVM_HAS_DEVICE_ATTR ioctl on an
> AIA IMSIC device before the IMSIC state has been fully initialized
> for a vcpu.
> 
> [...]

Here is the summary with links:
  - [v4] RISC-V: KVM: Fix null pointer dereference in kvm_riscv_aia_imsic_has_attr()
    https://git.kernel.org/riscv/c/11366ead4f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



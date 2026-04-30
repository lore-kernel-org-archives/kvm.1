Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035E37F011;
	Thu, 30 Apr 2026 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519577; cv=none; b=pyx85HFuTFdCISh6wtm32K+f/KRVuNLI3i2pwY+yFeLw9P4J5YBlsnNtJkMvoXHvTq34xMahGJ6iNp4uABHY34BaXXyzIN7SMZVMYzzvpK3yT/THkxStfgMKiuSSWRnyCLYt70gHB9+vj3VA+9OpIPMwPNjc4wpcLSkKTBZoGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519577; c=relaxed/simple;
	bh=IDMWKx8m6rNQw0ZCNz9wwYzKSr4KAa3cIQDkV5a1RQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G9j468kRChmd7XtMpOBImr76rK1oxBFvSzcu66zHXFUSPUqzEqC1F+aEzh69yWJXOAJWEvK/WOS6WHNhg10C6enAJ8EqiWpIrjuysaroDUA1jXYuZvWoFr6wUZbh3hqJgRgsGF8xgs5P1cBCLVl6zd3Un+ngSBY48QBhiI8yqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Us4xSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Us4xSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6296C2BCB8;
	Thu, 30 Apr 2026 03:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519576;
	bh=IDMWKx8m6rNQw0ZCNz9wwYzKSr4KAa3cIQDkV5a1RQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8Us4xSbzW4gFQLD5L2V5yXNmiyJU9gy+rzMDUnwTCB88wRZeyRQcGUMytmIcBwNP
	 yqZbEoMkICm7T1yfU41bAt8YuRwSnZ/p/8XRi81LwYi467rYrw4QAzZl5w21rVZvVM
	 xC1HT1M81B8iE0n8NbczE5vX+CA6iqi2NknOcacNclVWNgL3Ewg3+DuFJgAEnaEV/k
	 Gv5b8q3TSRljOzFUUmvLr4gMVfIXDgHdK4jtxJGCFX5ZhUICR2CgD+26NcFYlTO1i7
	 XLNhEdPUAt9/Yor6L9JV4Ix723edKFA77rZ8FjcrGsnU6hEctaOdvYL9puAb38hD2N
	 XauPp6jwxGbMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE2E3809A07;
	Thu, 30 Apr 2026 03:25:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] KVM: riscv: selftests: Implement
 kvm_arch_has_default_irqchip
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751953180.2274119.17183218206073663905.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:31 +0000
References: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
In-Reply-To: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, seanjc@google.com,
 maz@kernel.org, oupton@kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Thu,  2 Apr 2026 15:48:14 +0530 you wrote:
> kvm_arch_has_default_irqchip is required for irqfd_test and returns
> true if an in-kernel interrupt controller is supported.
> 
> Fixes: a133052666bed ("KVM: selftests: Fix irqfd_test for non-x86 architectures")
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> ---
>  tools/testing/selftests/kvm/lib/riscv/processor.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip
    https://git.kernel.org/riscv/c/1ec8bea903f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E23630BC
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522163; cv=none; b=rlGVHV2C8qYHNEPrO0xcVGiu3u6F3y2tu1EB8GiXqNQoudxpLepi/nIGgWFcXWl8t7cuJlMeY0awMSlg3NqfkhiW63ySNq91bt4kg/RiAADhIY1H+FNYSdyREY7WffXGlATmLnhmpvxfzOEIp9SjQ9pRWM/W3xKUyTTf5QkNYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522163; c=relaxed/simple;
	bh=/yAJoCa+tdOOPshUE/A43LRN52owg3v5BFKm8i3T8LM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IYjbaoXHkroLtr4XIIEQXxDp2ToFfQJ2BbyiQOTokJJVC8b7KqitITe11RoaFd4BxRUtysKrpnYlN2d6JZobnRI0tvnRymwhTy9MYKRAGyhDoIw7GKJkhg5saB3soof36OPzBnsecSwbTeJW6/Wa45t1gY5SxXgCksK5Xdw843Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea/vUlXO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea/vUlXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC32BC2BCB8;
	Thu, 30 Apr 2026 04:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777522163;
	bh=/yAJoCa+tdOOPshUE/A43LRN52owg3v5BFKm8i3T8LM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ea/vUlXO8QAMnZo9aS3eeiw/XXfsvC/WwV0ygYsWmMJaV+j2mdhgSMBDoucO3ixea
	 LecOLHdPEbaK7XnLzvzCMtN+Y+om3patozKnNyEB41SSR4aHLALWh/+h7gLqJr52yv
	 pNoWtmBGh/RDeFW0kmQraXtm0inHMHEsGHreHiHnOx7aOsSI4vZ90DencUUU8uz3Z6
	 J1NZSSJwb4k94jm3NqyObnW1pff8xDL0KNNRYMdzJc7A8UkQji12Ks5x9eZ3mnUThC
	 13EmSaGrV+qxVuJ06aXhrnaV0D2eyzclL0DEDEoLdq13b+X9u21heIL4vyk1ItYv9O
	 fqeFuBOOlKo+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDAF3809A07;
	Thu, 30 Apr 2026 04:08:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] KVM/riscv changes for 7.1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177752211779.2274119.18444543512578889035.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 04:08:37 +0000
References: 
 <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
In-Reply-To: 
 <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org, pbonzini@redhat.com, palmer@dabbelt.com,
 pjw@kernel.org, andrew.jones@oss.qualcomm.com, atish.patra@linux.dev,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (for-next)
by Paolo Bonzini <pbonzini@redhat.com>:

On Sun, 12 Apr 2026 18:44:24 +0530 you wrote:
> Hi Paolo,
> 
> We have the following KVM RISC-V changes for 7.1:
> 1) Fixes for issues in steal time accounting, vector and
>     PMU which were discovered by KVM API fuzzing
> 2) Split huge pages during fault handling for dirty logging
>     so that write permission is restored for smaller pages
> 3) Improve kvm_arch_vcpu_load() performance by skipping
>     CSR restore if VCPU is reloaded on the same core
> 4) Implement kvm_arch_has_default_irqchip() for KVM selftests
> 5) Support configuration of per-VM HGATP mode from KVM
>     user space
> 6) Some more preparatory changes for nested virtualization
>     such as:
>     6.1) Factored-out ISA checks into separate sources
>     6.2) Added hideleg to struct kvm_vcpu_config
>     6.3) Factored-out VCPU config into separate sources
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] KVM/riscv changes for 7.1
    https://git.kernel.org/riscv/c/d880d2a9c694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



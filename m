Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617C36403D
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519604; cv=none; b=YuTibY2K2Pm+tuGNv7EPdCyVifp8ghZiG7aNfSi/k/amaZCcXqFWBzJqxAmlZJgpc66c7PYJeoVI9kvQjU3GVjFm3pk9Jv3zkLYm4XWvuzszaIqPxuKdDug3qKu4+RnW+2cgSw4X8XYJGjeHyfSiVUsWlJHRhNSOQ7SytUotSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519604; c=relaxed/simple;
	bh=GMxRZN/UtMTJF8yKD1Ke513bn+WSJy15blPJ0tX5gfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t02yoz1z2rXX6t+Ho1eEVJHeetn6fSGW5vteWhCcSjmZR2Uljq/0KFDK7ThGmU1p3RKS37xbZq1b43rnlr3s7DtM0AuP4j9+5fjIbEVwFkH6gq3cYqCaUF/xhW6ws7oNbAtsQyL2r36su6wfq0ykAIhn3OGsf5ezbnBARf5VntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRU5slQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRU5slQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC919C2BCB8;
	Thu, 30 Apr 2026 03:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519603;
	bh=GMxRZN/UtMTJF8yKD1Ke513bn+WSJy15blPJ0tX5gfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KRU5slQpE347j7zarnXTd98IfdcwAwWAv5FaN7VKfqW4w+FLBeunoUwuW1Gl+MC5j
	 1o2lneUKYMNx3FtNXlHv4v6kDGx8CLpXjLpftfJxHKm8cwO4vw3j7AwpfmGLCPXlw9
	 vKXfnBabJJ84EocUa5b7Sr8tT8gGM9ckSdo9rVGRAfAGwG4d082VtaJ8QJT0bYW4rd
	 Xo7BZUVpifR9m7RUXbfe/XZYBHEtSj/FfIQ91PxzEVnTqbCQTyI6sngdMaoJkQpGJr
	 uPZodzZ7fwEQavdj6qn5ieGrp4jT8vzCeilaPMWSzDBYAFoUWp1SZ/8IS7Y+qlgcCH
	 FrEY1w81628ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD213809A07;
	Thu, 30 Apr 2026 03:26:00 +0000 (UTC)
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
 <177751955879.2274119.5780580511705921514.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:58 +0000
References: 
 <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
In-Reply-To: 
 <CAAhSdy0sU997x67zZe00ZVPVrOT-=X8zOUk3OxWXeDcn-rHeXA@mail.gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org, pbonzini@redhat.com, palmer@dabbelt.com,
 pjw@kernel.org, andrew.jones@oss.qualcomm.com, atish.patra@linux.dev,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
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



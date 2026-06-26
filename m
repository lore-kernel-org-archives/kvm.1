Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007F3EA970;
	Fri, 26 Jun 2026 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462096; cv=none; b=HqB/ohU+Zirpr8KpyZxoOC3Ia93UHL79M0XVWDJabHSJ5TLeMaY8JBKccT/WuViq/Ce6bJTMXx8F/jkZTwOyvoYWPoK+UfeBuxTll1rjjAoxEhKbBvsB/y2x3xsjnxkEt6x1lDfmF83G13ZEnVmw2Lg49k17xwolSYRsxhNuP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462096; c=relaxed/simple;
	bh=Z2Hniqf4VH3ATut66GSq7ziVPUNQd0XUoPjHiPWLqg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uBHhej4M1WzUV2WwDW9/vkT3roGYyYowIamLMmA80B12LsriI2/NfKN4F/p711DGzSuZgG5nBAQbcwUcSA59WFIZXQTe1weZK1f028aF/ifliL4BV2SkfyPXMK1gDmETxXwTZq/FzfXbVUE1DPygNxKl4Kbc3Yzq8j3DSC/FV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy9obNaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy9obNaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564071F000E9;
	Fri, 26 Jun 2026 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462095;
	bh=9ng+K5LtfItZozFyW5DaKLk3vg89jUk5p+Jo40h/pz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gy9obNaagDLrQoDnAOJ9mWpvqgzIicpqyoeod0wvdXDDe+Li3tUihiHwItm8IN9PR
	 j2CMjq8Hhphd8FC9VSV+2cEQEMVhXUS1Stp59UV8bNTu+pBxueYh2S45iDWfZ/qaym
	 DLBjQnHS26sbvZAkitK+HeZo4FtglhDXlWF3+RxBNfJ+mdam37U4E+OReRc7HZWT3M
	 iwShpsnaYenuj21+AJcPCuUzrqfHiWRN02laL9IdavxX9tiqUmmKEJ36cwNsgvzHXa
	 GXdaMOleHY3lHrkOmx7h9DsqT++WIHzHTWg/2JsQBpXWJ07Zjy2d2WGlhbVTQv9GSy
	 FUppLP2bY7jPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC539389E8;
	Fri, 26 Jun 2026 08:21:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Fix timer state restore
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246208225.3816447.7133626201153668356.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:22 +0000
References: <20260526075544.796396-1-maqianga@uniontech.com>
In-Reply-To: <20260526075544.796396-1-maqianga@uniontech.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue, 26 May 2026 15:55:44 +0800 you wrote:
> The KVM_REG_RISCV_TIMER_REG(state) one-reg write passes the value
> written by userspace to kvm_riscv_vcpu_timer_next_event() when
> re-enabling the timer.
> 
> That value is the timer state, KVM_RISCV_TIMER_STATE_ON, not the
> timer compare value. During migration or state restore, userspace
> restores the compare register separately, which stores the target
> cycle in t->next_cycles. Re-arming the timer with the state value
> schedules the next event at cycle 1 instead of the restored compare
> value, causing the virtual timer to fire too early.
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Fix timer state restore
    https://git.kernel.org/riscv/c/6d4c17ed5620

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



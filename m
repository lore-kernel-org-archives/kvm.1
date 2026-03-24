Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03333B8921;
	Tue, 24 Mar 2026 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332471; cv=none; b=qT1OnH2pS/vElX7UnZH8/FOTy21YktJvBYAdVHUJvIoZlcrZeklegUHrWBCbjd2SeAAA1YFa5Yoz3m1SnGcmpFXOMdxYe5UYLCk4SeBwzk19sZ2pXtR8U7MuuFeqwS6umZLV9TztYw6QN38SBD/B/bxZRuQUThIikXjqpVay8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332471; c=relaxed/simple;
	bh=YORPjLn1SNWGXCVk9I6tBDAbeqhs9CT1QTCVC1Ub4mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oeZ1Z8KpgO1xlyiv2vdH4lPCrmrePSgMF22cLmysfAfB7Z7x+w57RuPYjvVYubig+etxEWKNAz3TvTg7n70OkYrYc2BLl+olXNAlFZnrdX26rNd/UPx/bkAf1GeE7/gvuAVatPu0Gn7Cz5QgcouakdWt7vM5QtEm9GdZtOZibmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aes8ZaBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aes8ZaBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE5CC19424;
	Tue, 24 Mar 2026 06:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332471;
	bh=YORPjLn1SNWGXCVk9I6tBDAbeqhs9CT1QTCVC1Ub4mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aes8ZaBFdbKKcRRKQ9zNoBKT2Kr/K5sZimTlu6ZoDL/qMv9cU2Igdl66Np79qb6cF
	 Y0PgVocdm0KPCSUDQ4zY/FWCcXDq39bOVjh6Go9xpLthEBRkRPrjAxu6l4FFhE40hk
	 1dI5r0G3qvhFJy8CEPfPNSsV2tmzhRhoIL00cNFmtfUlLcFnpR01R74LKUwsrZqMeO
	 tY6vrjtL2ye3FczovFRHaJV88dh3khU9HisnL701oD5rGNiUTfr1L0ZgmyrWH0wGmr
	 RuhUshSDPxVeOQnAEX+VmaLoaW6Y5k7I9g7CbsjEdmv2iz5kFDHz/cWGfm/RU8pMlE
	 ti67GWoViYHkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D403808200;
	Tue, 24 Mar 2026 06:07:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: fix off-by-one array access in SBI PMU
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433245979.469836.14855063551962927308.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:39 +0000
References: <20260227134617.23378-1-radim.krcmar@oss.qualcomm.com>
In-Reply-To: <20260227134617.23378-1-radim.krcmar@oss.qualcomm.com>
To: =?utf-8?b?UmFkaW0gS3LEjW3DocWZIDxyYWRpbS5rcmNtYXJAb3NzLnF1YWxjb21tLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 lukas.gerlach@cispa.de, anup@brainfault.org, atish.patra@linux.dev,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 ajones@ventanamicro.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Anup Patel <anup@brainfault.org>:

On Fri, 27 Feb 2026 13:46:16 +0000 you wrote:
> The indexed array only has RISCV_KVM_MAX_COUNTERS elements.
> The out-of-bound access could have been performed by a guest, but it
> could only access another guest accessible data.
> 
> Fixes: 8f0153ecd3bf ("RISC-V: KVM: Add skeleton support for perf")
> Signed-off-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: fix off-by-one array access in SBI PMU
    https://git.kernel.org/riscv/c/5c1bb0787111

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



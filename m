Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C834EF17;
	Thu, 30 Apr 2026 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519548; cv=none; b=YtrqsbevyOWgwBpaOFGl7wFp+XY0Y3vBcqVVAw+25j0gpaDX06siRZQu0Ktn05r0PFGuIgh6CVj1/eMkQPt4Y4KJbhDTJeqjuMIzUIWIX8fSMgCCL44Lv8629Hj8pJingz2A9zlCK5oS7ehhqHgODrCmGWoXLGlbMuX3HRz/I5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519548; c=relaxed/simple;
	bh=RtJO1GZhj3koVnHx0qwUJkqHkcUaFGtA/Q7HZ0KFCRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kt1jxmSVXQkTPGlUu//DRVY4LecpuEM/UPEyqZOtW+Nq6QXetU9/H74CBIIMpcnt295IVX0cNDd759HreOy4RhbFIlkRyoNARdI7EMrIuh6Lgoz+YFahyxVhVBU6mzJLYDweIohiAHlC5XGszWY+kGkcjm/8VERF9QTyNes0XQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4DSMgrJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4DSMgrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6536AC2BCB8;
	Thu, 30 Apr 2026 03:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519548;
	bh=RtJO1GZhj3koVnHx0qwUJkqHkcUaFGtA/Q7HZ0KFCRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U4DSMgrJbaoUSMpvE/6jEHCHrJOiZF+sKcHVUYTOeDJSlN7Ek4P0+BtQz4eM4IkO9
	 ag0RCEK94ydpNWjq78bOCT5UrJ5suiiAnJoPc9TOr1/c3gYbaIiNtK7jKF0JnzyOH6
	 AWW3EHW4benxvlV0k+80SfgLv51TS3h4EeTwUpRbZKV9Tk2qmOzITCUYRqvjAAygxK
	 wmk2IqqxOcPQBfXBYld5gPYhBdS8VU87ioOxshGPIAEDO0ldja0/UZ7O7EUMp0TdC5
	 9GhrfkcNNWocWsC2tSGEHxuwJghcP7ksDlaL6kZlCpdTKmwKarqFnokxKDxcNlvTR7
	 o3pIIIiVrnBdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F073809A07;
	Thu, 30 Apr 2026 03:25:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: KVM: Fix shift-out-of-bounds in
 make_xfence_request()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751950329.2274119.11010707282482271011.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:03 +0000
References: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260403232011.2394966-1-xujiakai2025@iscas.ac.cn>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
 alex@ghiti.fr, anup@brainfault.org, atish.patra@linux.dev,
 palmer@dabbelt.com, pjw@kernel.org, jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Fri,  3 Apr 2026 23:20:11 +0000 you wrote:
> The make_xfence_request() function uses a shift operation to check if a
> vCPU is in the hart mask:
> 
>   if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
> 
> However, when the difference between vcpu_id and hbase
> is >= BITS_PER_LONG, the shift operation causes undefined behavior.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: KVM: Fix shift-out-of-bounds in make_xfence_request()
    https://git.kernel.org/riscv/c/ddbf9c76c402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



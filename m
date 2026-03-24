Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0073AF660;
	Tue, 24 Mar 2026 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332462; cv=none; b=pnUwnyUnI4V7og8AeC9ISNeD2xUfQR0Bi2Yck0Ra1NWImoQyibvxlPScQunhz/5qUFkHkAdsVYRwJwZyG8PwAIhHl762L4ws9ekHtiEFWAeKBiBP1HvLDDk4UAwNEY51z6BfVHXVvQBD8I2lQRNivNBPjcyF3rt4503WzTsHCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332462; c=relaxed/simple;
	bh=5zNUfjCbe4xMMri1P2HaByUJAkjQzA8Nb9ip9FvYKes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BqmolUe4VuvACBaLF4j8iLEt2+yN8tnCOY5gajzlchvjfOeDGlZur58dd9CXdxOc9td0PiEAnSKvH9DUHQQ26xijKsbHl7PMg8Z8vYtJfVnq2CnD61mPiWizgOGre59RVoGk6oSQxVEgtRzycPKZiW7xgEDIzqQCjfk/RRk8VXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byrCHLeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byrCHLeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F02C2BCB2;
	Tue, 24 Mar 2026 06:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332462;
	bh=5zNUfjCbe4xMMri1P2HaByUJAkjQzA8Nb9ip9FvYKes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=byrCHLeFhkP2m2kqESbzXZCxNMNC//4fVSFc9OeISJD1jNXl+AxwmfLgRdod4s1oA
	 Oa72XoY5nRRjIvgFlTXq0Vi64GALRTxTUZvjB4l2/2o2eiMUv86OyfTtFQRnnnc84Z
	 cnPBrH5NSBZbBdFMhHQurVK8qLDbgjZpM8kEkZ2nwz5lvqfVGa6IwLDxNPmI/lKtMl
	 C4x4ei+7qwP2MIzEAzo6VgyvQZPsB+JHpK8TvHvAiyqZEer5QShnK/Fl59vZADpGme
	 QiIA0Kz4We8WXDmOFR0/fH8YvVu9A9ABD5T6VdX+IzjWeY3aB/j7liGA4P+8xPNWE/
	 eB1ZlnfTnv+Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B72183808200;
	Tue, 24 Mar 2026 06:07:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] KVM: riscv: Fix Spectre-v1 vulnerabilities in
 register access
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433245028.469836.11061694721898939145.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:30 +0000
References: <20260303-kvm-riscv-spectre-v1-v2-0-192caab8e0dc@cispa.de>
In-Reply-To: <20260303-kvm-riscv-spectre-v1-v2-0-192caab8e0dc@cispa.de>
To: Lukas Gerlach <lukas.gerlach@cispa.de>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
 radim.krcmar@oss.qualcomm.com, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 daniel.weber@cispa.de, michael.schwarz@cispa.de, marton.bognar@kuleuven.be,
 jo.vanbulck@kuleuven.be

Hello:

This series was applied to riscv/linux.git (for-next)
by Anup Patel <anup@brainfault.org>:

On Tue, 3 Mar 2026 15:19:40 +0100 you wrote:
> This series adds array_index_nospec() to RISC-V KVM to prevent
> speculative out-of-bounds access to kernel memory.
> 
> Similar fixes exist for x86 (ioapic, lapic, PMU) and arm64 (vgic).
> 
> Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>
> 
> [...]

Here is the summary with links:
  - [v2,1/4] KVM: riscv: Fix Spectre-v1 in ONE_REG register access
    https://git.kernel.org/riscv/c/f9e26fc32541
  - [v2,2/4] KVM: riscv: Fix Spectre-v1 in AIA CSR access
    https://git.kernel.org/riscv/c/ec87a82ca874
  - [v2,3/4] KVM: riscv: Fix Spectre-v1 in floating-point register access
    https://git.kernel.org/riscv/c/8f0c15c4b14f
  - [v2,4/4] KVM: riscv: Fix Spectre-v1 in PMU counter access
    https://git.kernel.org/riscv/c/2dda6a9e09ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1238B14D;
	Thu, 30 Apr 2026 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519595; cv=none; b=DceDVS+x7T3XPo7QpkDopvMnHe5XoszOqMNhc09KN2Vsq++s2V7XcQHPWLvONLOqZevJbr65EsZHHOmgxcgrrO5EPCwZyimgyXv1lh1Qvq+YygzS7iJX+Yr52UYX2vyA5gejZ4hdmAuqJpQmomF/OKOTusKu5Ue5N6Fw7yn6dqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519595; c=relaxed/simple;
	bh=v2FVe+EQzcRgy5kBHv31JJ1JABN71LAgpMDEFu1iEeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LHg37gOPM1/ceRozCJjFuMBIdAd1eK6zeITajowRh9f4UGHiSncREAnE2YnT0JKyky7a9HMnU5hPyTRJDvBA3z/N9EHH0yXRrsfXYcENo33IZy4l/lL4A+Sq28T98F7mM2jkd5EDscYKK5Anmj8yXs7SiV5dteqVrsf0VPKrqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIzodHHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIzodHHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEADC2BCB8;
	Thu, 30 Apr 2026 03:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519595;
	bh=v2FVe+EQzcRgy5kBHv31JJ1JABN71LAgpMDEFu1iEeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kIzodHHoxdLZ+cDEQj8Njp+uRU2rFvB5r8IfM+fIJ9hEZSG088leSKu/922hUPp85
	 uMHN4hDlcpbFHClaWJFg4kZDURxZTq1inA7wHZImmThwHGfHBgEpKvrqi7ijJtqwdy
	 5WH+gX1UuJLBbrZylZYd6CoFRANggv3/UfcfBb3+dpW1T1QlADsSguUSaj5Egn2fSz
	 Bdi/bACXwgbbfMZegVFixj8x6oV9POowqUolYkPDN08WqNkOFsPo8VKMx1GwPrzfov
	 j0EGamHpvvWNIqGxIFN2PoHCW88iEsn1BChR7+E1rQl0nVqgLLU8i9CPn6y4VH9hy+
	 marnzTmOrauAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFF3809A07;
	Thu, 30 Apr 2026 03:25:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 0/3] RISC-V: KVM: Validate SBI STA shmem alignment
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751955029.2274119.9759689276814198546.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:50 +0000
References: <20260303010859.1763177-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260303010859.1763177-1-xujiakai2025@iscas.ac.cn>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, alex@ghiti.fr, pbonzini@redhat.com, shuah@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, ajones@ventanamicro.com,
 anup@brainfault.org, atish.patra@linux.dev, aou@eecs.berkeley.edu

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Tue,  3 Mar 2026 01:08:56 +0000 you wrote:
> This series fixes a missing validation in the RISC-V KVM SBI
> steal-time accounting (STA) register handling.
> 
> Patch 1 validates the configured SBI STA shared memory GPA at
> KVM_SET_ONE_REG, enforcing the 64-byte alignment requirement
> defined by the SBI specification or allowing INVALID_GPA to explicitly
> disable steal-time accounting. This prevents invalid userspace state
> from reaching runtime code paths and avoids WARN_ON() triggers during
> KVM_RUN.
> 
> [...]

Here is the summary with links:
  - [v10,1/3] RISC-V: KVM: Validate SBI STA shmem alignment in kvm_sbi_ext_sta_set_reg()
    https://git.kernel.org/riscv/c/fa9681ed5c6a
  - [v10,2/3] KVM: selftests: Refactor UAPI tests into dedicated function
    (no matching commit)
  - [v10,3/3] RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



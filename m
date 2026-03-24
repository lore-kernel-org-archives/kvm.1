Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28A3B774F;
	Tue, 24 Mar 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332473; cv=none; b=nfUVMWPnpUdaJ19NlDSQRInJDDssrNx+PFlvSG8ychZHoW98k2v+PnCqdhayy3/8v9vITSe+oUyjnTlHu4thx/uAuz6c5Katw0rcA2JFLLvQWlYOp0aqxw491rJVlok5imcCaAilFULhnRegD1Iej45ELFw+kA4c5mOCenabt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332473; c=relaxed/simple;
	bh=YaPgiHQl56+sPNb1XcP4MC0aBJocLJM0xG2k+cBTOuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mKLgJfF0C/QTFuXgJFhG073KCdzKgzZtoRZkgJ18UsLip3pXwIDUTfk8gRlDRwYZklH8lwrXY/95mbIIiQsiuB24hFxPw2ZXjt3+abQeynio55jY9WrmWnd7mO8OKxwddwO9wBPTIVDLmdAiRAfnvXpci/cipbiFdRmTXrgOeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPrht0N5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPrht0N5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16419C2BCB2;
	Tue, 24 Mar 2026 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774332473;
	bh=YaPgiHQl56+sPNb1XcP4MC0aBJocLJM0xG2k+cBTOuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPrht0N5iNqPF1ITTro1KL5P2xYH3yruzSUogcoTheEVWP+y9EbXg8cUVa/e9udLr
	 uD5XTHGBMbg2w2uz8ibqYKpKtPRndWWyUCCnzvX09pKWvQ/jH7s+kFgycsEhFURmLN
	 06O5VDpT5hmYSURtbZFJCio2gUgMBXPvN0TrQTSr4d1RMwb9B1T1oqx3DAayMY+rVy
	 I6dynBKN1tvpVlRCzjKKL6J1VTs+g6nmeFHbpsRFLIeTpBQW63wgc8xTbcRb/Dos90
	 P0RulPv06Sa/xejlqUu879rw9BV/fqVbcQ7l7/05k3u3nt4yqezaORuBAoxbqXlUiG
	 XUpxBUSxmYaiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 599EC3808200;
	Tue, 24 Mar 2026 06:07:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Fix out-of-bounds by 1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177433246104.469836.4154059877699067385.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 06:07:41 +0000
References: <20260228152226.2116895-1-ethantidmore06@gmail.com>
In-Reply-To: <20260228152226.2116895-1-ethantidmore06@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Anup Patel <anup@brainfault.org>:

On Sat, 28 Feb 2026 09:22:26 -0600 you wrote:
> The array kvpmu->pmc is defined as:
> 
> struct kvm_pmc pmc[RISCV_KVM_MAX_COUNTERS];
> 
> So, accessing it with index RISCV_KVM_MAX_COUNTERS would be
> out-of-bounds by 1.
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Fix out-of-bounds by 1
    https://git.kernel.org/riscv/c/5c1bb0787111

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



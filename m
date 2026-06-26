Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405F78C9C
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462108; cv=none; b=NWwIZkv2UcLm1sY7zWrE/PDJ7O8A8I4m7rLgZzqWN0MZGynQsZcgAnLFIZoFSQeRFYkL0oxuhliCmHiuC/CZ4u/p5NBRTM5qimjbcRY0Cyn2/QmAu8LZehA4Y55SdVfjw0qp3aVNfMg0OVO6cPPzC9Y67E3kd0707bXl8P5i1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462108; c=relaxed/simple;
	bh=Yf1HMkQQBXc53Ujp0ecZLdOwCwuvvhBsYHVNFUminLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+Vv4Jlj9we0egJmWlSzu27TPLb29N0IOzLRGy4wzF8vyboe9Oo8FJBYeQQ3NqepXD2+unwTrUZhhUHjJ5ypU1dd+XVJD+djfNgmQCAGdxVOxR2IBPLilSR213Y6sXV2BtPpy9ot7bcM4GxGnp7B1+gGHkW47i7uapIGWG2wgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL7c2/2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL7c2/2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186871F00A3A;
	Fri, 26 Jun 2026 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462107;
	bh=mk7h3t64f2TC7G5uCE6P3aFH1vKYFIvF6Dljp3/wEjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FL7c2/2NE6NmJK6Wc09lcQ4XlJvQgQzXLv3UtZhOBw9201ZskygEJlGPjs3oEIUuY
	 qvBiSx9M98D+cWajWSPs7DMFnAA37v17A6Ljtosm8oSu5D9YJ3EpYUU6nz6S39zMfm
	 IW4UW2EXTkFeehY8O5/vEza8PGBZsF0AdkRDLNLfC8egQoN7ZD806X2aiakR22HM29
	 uYsv/CExk+RNTlFR4rLTAVjIf/RGtGOEbJiPSjjQGsnE141ggFQGzA20SejpV1wVG3
	 fJXszgqvJwKasROiCUa7NWPiF0WRFNWfmBYEzk5GFc3vFzlmtdOTzM8wUA275y4wf0
	 4PtmVYK93aKcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698A39389E8;
	Fri, 26 Jun 2026 08:21:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] KVM/riscv changes for 7.2
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246209390.3816447.5191620601688029372.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:33 +0000
References: 
 <CAAhSdy0WTa-jDxg0cQxwqfGM+Det+WxM-ELV3F2ktrcbw8g7Bw@mail.gmail.com>
In-Reply-To: 
 <CAAhSdy0WTa-jDxg0cQxwqfGM+Det+WxM-ELV3F2ktrcbw8g7Bw@mail.gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org, pbonzini@redhat.com, palmer@dabbelt.com,
 pjw@kernel.org, andrew.jones@oss.qualcomm.com, atish.patra@linux.dev,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Paolo Bonzini <pbonzini@redhat.com>:

On Sun, 14 Jun 2026 15:19:53 +0530 you wrote:
> Hi Paolo,
> 
> We have the following KVM RISC-V changes for 7.2:
> 1) Batch G-stage TLB flushes for GPA range based page table updates
> 2) Convert HGEI line management to fully per-HART
> 3) Speed up dirty logging write faults using MMU rwlock and atomic
>     PTE updates for permission-only changes
> 4) Use flexible array for APLIC IRQ state
> 5) FWFT fixes for missing CSR dirty marking and stale feature
>     exposure to Guest/VM
> 6) Fix logging enable check on a memslot by using
>     kvm_slot_dirty_track_enabled()
> 7) Fixes to avoid skipping valid pages in kvm_riscv_gstage_wp_range()
>     and kvm_riscv_gstage_unmap_range()
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] KVM/riscv changes for 7.2
    https://git.kernel.org/riscv/c/c6f1b611c66f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



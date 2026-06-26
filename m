Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2663F1AA4
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472606; cv=none; b=uWdW0VVSPMosTM4C1SpAwif9Fyh/3i46L8B/R/VLkU/8up7Pfx6FDsLV/SNCsXMUGejrjFh2+dBQD4BiIHiueAQR9E6+tFMgutuVoq/AtQpzCR2qgK393TV4O47pSEqUe1UEP09VsFkwW56PtLgwoAmIaJyyhkOXPB2atYc6+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472606; c=relaxed/simple;
	bh=Ah91bTs6hU47dK3orbpX/d+mtPYK/wK7DhtYOAlA+Co=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JuOoSRqFYS+mvHDCG4zRQf5qdrXJYJGcbeLJI+WUJSOYUWo6R3/3CLCpsoCuKdd80/F32K1I0R+GVw+C8NX9RzIKRiVZxJI60TvUMIcV6r9MtbAsKdVKGWCl+FPQY9QAw8zdw/028n3qYXDwPOtUuC69mVvGc/4pHnEyn2jU/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpLSaVIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpLSaVIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97CA1F000E9;
	Fri, 26 Jun 2026 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472605;
	bh=7dXhxtAlDokcF9pKghUWMyq1InGndCuu3bVRMCLzLqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MpLSaVIHlc/UHVTV2d/ri77mCl2Kg7m+1iuMibstcEmSom97yEsJVVahr92hLkku6
	 wplJpWldvRMeurbvoIfXqLKpThnKq4j/RcHvV8RX7l0sfMkIEQuiZFPpZiaiNMp/f8
	 O9O43J9vD6RQAYcmtG4/8MIfCHJt9bmkFyMmgcSuT0FHG6fMpArlKTOvHa0rJ3kE7d
	 gLe1vQ88k6YeXf02W0e737C0VqtFKj4dWrqjLXkKSgKP8+T4Ug1gMa/lo4u4+rb7Dc
	 e9wUmg/zUD/MdUoKRwEwgkcriKutiabksBIjvorRjbh9gKcgslGUXXUOh16VNT+Rk1
	 SS9rd7qaam6jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC639389EE;
	Fri, 26 Jun 2026 11:16:33 +0000 (UTC)
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
 <178247259228.3816447.10031168625434105729.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:32 +0000
References: 
 <CAAhSdy0WTa-jDxg0cQxwqfGM+Det+WxM-ELV3F2ktrcbw8g7Bw@mail.gmail.com>
In-Reply-To: 
 <CAAhSdy0WTa-jDxg0cQxwqfGM+Det+WxM-ELV3F2ktrcbw8g7Bw@mail.gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org, pbonzini@redhat.com, palmer@dabbelt.com,
 pjw@kernel.org, andrew.jones@oss.qualcomm.com, atish.patra@linux.dev,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (for-next)
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



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEC372063;
	Fri, 26 Jun 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462079; cv=none; b=H+d2JZgQD5eVZvBxpqyw2l7n7FWVBkuLcf21oFraDlbCV6PwidL8FOa2moaz/7YzMmSljxH1DQEBy0fywgucoEoP2fy22uiMkRBLfST5RpVuf+LMGgYwcC7ZxDZFfaNMfah+l5m4KK+osWFAVggqPAfyL/RZTrkEghpIFFHUfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462079; c=relaxed/simple;
	bh=UotCwOvZgij9NpPkcLUFu7pGCSSo0wP9vnbvBVl4u1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ubHUd/z/1iIceVRj60JwmyNwK73kJJBR1mRcr58LMPHx87yeksy+NDoAxORop/JRS/Y0e1z61fh1736jLsbRohfBfEPdH7q3Es3+SP5yztoMZxCKlT8fuSeX2T84o8W2zzHAAQJBKGgkzH5qqg5lWIhOHbsMatk6gYZXg5paYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9jnzJSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9jnzJSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167DD1F00A3D;
	Fri, 26 Jun 2026 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462077;
	bh=B5R9EaYncZkXDWvxwVpfZCNbo6uu2MiUO7r8Emfv8vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T9jnzJSYGxTlYaYKe0nBjZNa0hbP4E3pmzFdP2LeEP/dKPjmP0tg/eZMPPfCV2+NH
	 9tGxT25LwknlXlbtv7RGSU/BNTJjJ0h652zeOk0JGf/rqXu6Mnz/IVV0M3qtISv9OZ
	 r+wIk2RDmlPPJyszUP+BZ17gbZkhzs7ZDY40sa6Y/i1xG4iFedLrnWJYVh+SGaSF8Z
	 LMvYJoB97Oc85lvJYMPJEMzGAujT77kvoJ+jZ5C2ojEKPvedzP0mkp1bhVpwXVsLJc
	 bTNtdHkxkDdEL9FmYwNc1MadPY+WzOg26A0XTS0tQ+685QbZgKFGyznTcHg8hZgxyO
	 WGoaJYIKYEHJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 531AC39389E8;
	Fri, 26 Jun 2026 08:21:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] RISC-V: KVM: Convert HGEI management to fully
 per-HART
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206416.3816447.5019323970795639399.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:04 +0000
References: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
To: Anup Patel <anup.patel@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, pbonzini@redhat.com,
 atish.patra@linux.dev, tglx@kernel.org, palmer@dabbelt.com, pjw@kernel.org,
 anup@brainfault.org, andrew.jones@oss.qualcomm.com,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, guoren@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Mon, 25 May 2026 15:19:43 +0530 you wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> This short series converts RISC-V KVM AIA's Hypervisor Guest External
> Interrupt (HGEI) line management from a global "one-size-fits-all"
> model to a fully per-HART (per-CPU) model. It also performs the
> corresponding changes in the IMSIC irqchip driver.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
    https://git.kernel.org/riscv/c/59ebc16276c5
  - [v5,2/2] RISC-V: KVM: AIA: Make HGEI number management fully per-CPU
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



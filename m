Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BF32E6A2;
	Fri, 20 Feb 2026 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560656; cv=none; b=SDbyCieHcn7hHUdSQuYXw2DgJGcGnyY7oeNZ7qXCGJJx2NqlH3iSc+EyGQ2ZzeE2yQtWabttjb0BPaqD6RCbtpSnKMlNsKpqcioB5WLFUy3KMj4XFmbUiWOpQIJjvMjMkuAEgJGwyJUhHW3cLHOFU8AJ7zSez9IUahRkO6dznhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560656; c=relaxed/simple;
	bh=3KVU56LlvB/E74bXL0kiXIK3YWovwzwFpcCv6TDm0yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J8ZalURm0opRIlrvFRScAz2/XHsK/qO2eOJ+4UCbCsJYa+IbgGOkSmng5U8un9Qh5z/k+G59LegY+Laf2mUQaRHb57hT1s7UxuAXv91yWRz9gqeoT+lFw5cJ82BbqF7tTEsob6DBEQtnnSyqo1MawY/qpLDnrE0sN3ePy9cozpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI8xqvtK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI8xqvtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C601C19421;
	Fri, 20 Feb 2026 04:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560656;
	bh=3KVU56LlvB/E74bXL0kiXIK3YWovwzwFpcCv6TDm0yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PI8xqvtK6mt4NbScn0lPJJcRTuhp4oZSjEV5Bunk199bmj2O35FGRjyUrG0ucZtwv
	 Sry3bA5yvXF3253Owr+6Y2CnaxKM5TG1sVYwgjaPUHZ3twZ5MLNZJ7n5whiDKx2nFF
	 bz6ONRijkFxar+yzOhAvv4Qhg+pl/ROaVFIz0JIW80Q8C0LZIOjvvvElTU/hKGtrqK
	 eIy3/yUYokjnwhHTpZ5RoqmDfe+k4v+ccLgGMS7LzrK8cXPG1/joPZL0VCXMMJ16Ig
	 /tavtvZ52AbSW/kNnBu0thcamZtTfO2cdraY0OjA7kRtTRD3V6taSv56yzsXXjCjUA
	 Zn2Y5nUyVhhWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0463809A88;
	Fri, 20 Feb 2026 04:11:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] irqchip/riscv-imsic: Adjust the number of available
 guest
 irq files
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156066430.189817.17794056497252031488.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:11:04 +0000
References: <20260104133457.57742-1-luxu.kernel@bytedance.com>
In-Reply-To: <20260104133457.57742-1-luxu.kernel@bytedance.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@linutronix.de,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Sun,  4 Jan 2026 21:34:57 +0800 you wrote:
> Currently, KVM assumes the minimum of implemented HGEIE bits and
> "BIT(gc->guest_index_bits) - 1" as the number of guest files available
> across all CPUs. This will not work when CPUs have different number
> of guest files because KVM may incorrectly allocate a guest file on a
> CPU with fewer guest files.
> 
> To address above, during initialization, calculate the number of
> available guest interrupt files according to MMIO resources and
> constrain the number of guest interrupt files that can be allocated
> by KVM.
> 
> [...]

Here is the summary with links:
  - [v5] irqchip/riscv-imsic: Adjust the number of available guest irq files
    https://git.kernel.org/riscv/c/376e2f8cca28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



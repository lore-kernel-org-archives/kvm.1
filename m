Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367253DCDA3;
	Fri, 26 Jun 2026 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462098; cv=none; b=aEY2ivFcK5oslKS++j0iXOdt9wyRMK20SppeJGFUBhvZLr+vUEPfugFpc4kyycyzaU5xhLGd6sjU3WSTxYAwZX0lKm+6POUlSnAjnzSzWn1JbB8T78F0XYuL0qFNMMw2leFVDeqUzl37cUE0kV8DNsENG0JUqn9jAZM1Tx/9uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462098; c=relaxed/simple;
	bh=t3RkhFcAIlm67dMwMMR56C6vIlalE2Osaug89dUJ3V4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tRm3oiJ3f5QjNQvpsJM2r9wcW8RQurky4FPx7hemohmR9bQculMVTat4mNW0aP0ed0HvmIIsQMkkerzB48OOCoPyeDuGzeUQmpeOgvT0wtjhnzZyjzUXZidEfv1DCqyhmU7XJ37v5cTMZyMpARRyf2mhnNdJFG9UJ8db1ofwTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYAaSqi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYAaSqi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC1E1F00A3D;
	Fri, 26 Jun 2026 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462096;
	bh=5bdyaQScC5yxhGtHkOxVkC1utqWcnR2A5uiAb1rzExE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYAaSqi0jPz/YuW5AFJNSp0ysnIokkd6BattnJBHSvG6/gt61mTJCv1OSGRrewaHv
	 3J2mpaEm3Iu3q2EN/gvGe5ZWnvaBvMZynHHRh0olFEPayEpeGbTDgc3rQ9Kex+IDhI
	 9bPEJat8OyHqJNHkejMiZ5zNeRHspizduJt+6r8iXKePvk92ufaeYilT01W2GOVMdp
	 XjY6coBfzvgCE3suJ69LdqNyXo09sVuPqmx38CTu1n4eZ7utdl2kAz2Tf4EWoDQLaa
	 WQRb+w6dxVrCedOW9CsNLH9yTou1Hvd7IM8JjmJK3bB1dFqCbTQWSYUOZQUuARNrEb
	 FkgccnXidLbmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E639389E8;
	Fri, 26 Jun 2026 08:21:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] riscv: kvm: Use endian-specific __lelong for NACL
 shared
 memory
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246208372.3816447.9810005317307164502.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:23 +0000
References: <20260608155252.4292-1-seanwascoding@gmail.com>
In-Reply-To: <20260608155252.4292-1-seanwascoding@gmail.com>
To: Sean Chang <seanwascoding@gmail.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, palmer@dabbelt.com,
 atish.patra@linux.dev, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Mon,  8 Jun 2026 23:52:52 +0800 you wrote:
> When compiling with sparse enabled (C=2), bitwise type warnings are
> triggered in the RISC-V KVM implementation. This occurs because the
> user-space data unboxing macro '__get_user_asm' performs implicit
> casting on restricted types without forcing the compiler's compliance.
> 
> Additionally, raw 'unsigned long *' pointers are used to access the
> SBI NACL shared memory, whereas the RISC-V SBI specification mandates
> that these structures must follow little-endian byte ordering.
> 
> [...]

Here is the summary with links:
  - [v1] riscv: kvm: Use endian-specific __lelong for NACL shared memory
    https://git.kernel.org/riscv/c/52738352a6f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



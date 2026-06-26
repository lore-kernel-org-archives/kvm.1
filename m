Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153163E9F93;
	Fri, 26 Jun 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462095; cv=none; b=dGdinXD9T7uZUcI7izTI9l8HOeC2AHd96ihR3ctLIvGbAW+5bjmf84hP8xKGDJ6ajvcjuia76kEm1n8CiwGMSu9Z5BE2xK54woNRQ4jV36XYTUBhnYlqKeo0oIgyWp1U5kihS1AUPaOTIdKZa7cSrlq8rl9vz+ZDA6cecgHuWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462095; c=relaxed/simple;
	bh=LfyVuDjuaXqLOQSaVmwimxEQFAl41640zftbAge2Qp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HDFD3H5F37ECADRlsn2jdhkQhHQZsv8X3zfWI2J05Wau7bcwisA2X/a9LBcq4vmLDEJL+8ChLQHFaEmlItVn7HtHsqOVz6ra7skKYPHvxqWIIjV4BMuH+JrKarC9k3Rm7PcJjI+eC80TEsz9ISCgGEckn77xMlcdk4wqk25e5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqxGMNNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqxGMNNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D090C1F000E9;
	Fri, 26 Jun 2026 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462093;
	bh=p5+rIqdVv344EQDk5zZnFOdYzj2jMyT9lQ7p6WTw/Os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AqxGMNNytH3yg2QXdoyhU9CAHGPY90p1k6s3uowWLx6ea3WXmlnZ3vzgQS4KLBOHe
	 +KFJfvXWvyDW5YLRusseh09kaj695+9bqcQUpqxrnjgVwetdjOR2JxmVBQwg5VlhIB
	 PTJ3cnRE3KwvbWnuMoNO0fT7tGR7BhQEwvFtkeMLdASmixXxD2fQlmZ+lK9JPch9mn
	 t7+jyKnIbQFE+QtZ1Sb9L5Aq5TQgQRUUUPMAmITLivRKIwBKGrn04Lkxi3DAOP+hSU
	 4JlJ7OFphSa22D5OXHRQ8P5D9J84BgNkWARuQoiDJFgnBcHjtYSB3bj58AIReMmS9H
	 uSD+zHAFPodYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1975839389E8;
	Fri, 26 Jun 2026 08:21:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] KVM: riscv: Speed up dirty logging write faults
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246208080.3816447.14235715613320602429.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:20 +0000
References: <20260517153427.94889-1-tjytimi@163.com>
In-Reply-To: <20260517153427.94889-1-tjytimi@163.com>
To: Jinyu Tang <tjytimi@163.com>
Cc: linux-riscv@lists.infradead.org, apatel@ventanamicro.com,
 anup@brainfault.org, pbonzini@redhat.com, seanjc@google.com,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, atish.patra@linux.dev, pjw@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, radim.krcmar@oss.qualcomm.com, andrew.jones@oss.qualcomm.com,
 conor.dooley@microchip.com, yongxuan.wang@sifive.com, nutty.liu@hotmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Sun, 17 May 2026 23:34:22 +0800 you wrote:
> This series speeds up the common dirty logging write fault path for
> RISC-V KVM.
> 
> When dirty logging is enabled, guest writes to write-protected G-stage
> 4K leaves currently go through the full fault path and take mmu_lock for
> write.  That is expensive once the leaf already exists and
> only needs its permission and dirty state updated.
> 
> [...]

Here is the summary with links:
  - [1/5] KVM: riscv: Rely on common MMU notifier locking
    (no matching commit)
  - [2/5] KVM: riscv: Use an rwlock for mmu_lock
    (no matching commit)
  - [3/5] KVM: riscv: Add a G-stage PTE cmpxchg helper
    https://git.kernel.org/riscv/c/7dd416fdd3fb
  - [4/5] KVM: riscv: Update G-stage PTE permissions atomically
    https://git.kernel.org/riscv/c/d7a26a0ba715
  - [5/5] KVM: riscv: Fast-path dirty logging write faults
    https://git.kernel.org/riscv/c/7705be59eb2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



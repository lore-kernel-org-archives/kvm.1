Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F733F6C31
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104808; cv=none; b=BWl2qpMOPkNI4HebMdiQbRMrLipXc34hFT2CszOJ3cA363yiR1SS46pz3mk8s9Ir6JtRYkD31ftYG3mVlUYh7A2u+iiz3/m5QqpG2M4LN1QYNHDQBi9Lm0y0zbf86zv66sp5+OGnVWzwNb/beBv3AZPeUxPkauKbHmNk4Sy2DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104808; c=relaxed/simple;
	bh=tbO9C9Ep2VCk59GcPRNIFLQmbpfZ8X6qAl9S4Uh/GWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boLBctHw5RvGGC/2eGzcbeLq3MXseMtGj6bwUm6OqzNBmbW6creqW4lY2wz9sfpKQLgQcbBuT23SCEXNpDZShgzz1TkhyVkdxeZCnA9YwRN3Q3/2zNAoz1Wa6CP09d/2XhwKvj7MGhEy/94f/Bt912XsCFn6coMxBpADo9K5c+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1cI1w2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1cI1w2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CB8C2BCB8;
	Mon, 18 May 2026 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104807;
	bh=tbO9C9Ep2VCk59GcPRNIFLQmbpfZ8X6qAl9S4Uh/GWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1cI1w2Z82xTvvZbTgOiF5/RpdOaaaedHzb7Hqsd+i8sXg3Bh0eJygj97BtmcK1j+
	 9JtaLzqBGctMlqQe5FKIsn5YBDnEwSG+S86iDx9INBjWyK1PD5r/CgWpNEVJ/VabCs
	 +neqYQNIt5KTjSpw/KzD0Tu/v4HhAQXOMR3Ku7g6UNmjcJmq/PXfYzVJdNJdd5sEze
	 gj2nzU0KYxBKKClVl5SPZMu84PJZvf5GD4Mq6NBD0KbHkElSVWN7No38nXxY2Qm7LR
	 3lq9SBbeZik8hUB9bJxdCvBKkCGKo06oLNPxCr2aRew9XWm32Ra+pup1mEv5chTssU
	 kjx4RKRkTcxtw==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	"jk.hong" <ryan.jk.hong@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	zaiguang.hong@riscv-computing.com
Subject: Re: [PATCH kvmtool] plic: Fix lock/unlock mismatch in plic__irq_trig()
Date: Mon, 18 May 2026 12:46:34 +0100
Message-ID: <177910310386.88593.1034039489533987141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414131714.538976-1-ryan.jk.hong@gmail.com>
References: <20260414131714.538976-1-ryan.jk.hong@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 21:06:36 +0800, jk.hong wrote:
> plic__irq_trig() may call mutex_unlock(&s->irq_lock) without having acquired the lock first.
> In some condition, the function jumps to the done label and s->irq_lock is unlocked without lock first.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] plic: Fix lock/unlock mismatch in plic__irq_trig()
      https://git.kernel.org/will/kvmtool/c/5a1233d80dec

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBA3F7870
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104805; cv=none; b=dTiDC9ZR2EJLAdOkHLelwR+AKvyvZMbXlKGsb///PtzLOFCD3Fc0d6xbTQkeUEGTZ4ILYlX6aqRnmaLarTP4GV8nSx9rBI8M8qtfbPnbfEkmuj9wMV5spsS/amPHYOU8weCOT21A3apFK5GAi1CBcOJtcEgOuMe98RXawt0fJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104805; c=relaxed/simple;
	bh=LJTVpNE6XxGYQze/3hMeYGeOd6veye1Os/MiTzQu7Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGjP29/HNyKM0Y8GPwj7Smvk5weWI/DBEidU3PQ2/x2HRpzhSdQf/L64KHD+7TE7MnCxPrefS6F4pu9l2dxXM0e0Mlm7jn5+5PeiGvKZcFAhq2YKp71PlD8TNxWALJMjGl9kFSdnKBwAEjvRYWGXwoRGDFnQeM/wf9K4qynvCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTHFmSRM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTHFmSRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C28C2BCB8;
	Mon, 18 May 2026 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104805;
	bh=LJTVpNE6XxGYQze/3hMeYGeOd6veye1Os/MiTzQu7Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTHFmSRMDnHqGD8Cl07u9gLPQ6PDgNa/zwqnMnCcCX3yvDQhyB/ASFDehiXaZQ/7x
	 oSObj3Cx5jOPLu1vQfBYuUS7jMO68wHN8AMFKOHRMh/8hHZIS46DnPB25d0A5F2WUi
	 YfSngwX1i240sDNslbTVnpi0UbsLm+/+gfQRtoZzpZD6pR8jmnaORAFPlUFs30dWhS
	 37nLHsQOSliXp/6Tk3WbDyi4JTvFbbfQco88+2s/a4YXitu37vBCwikeAb4vCUB+Y4
	 AZPTUyMrYBasf4pgvvkj3p5qBodV+jsmfiFlJ/tc38ykrbPWqkQIYKdutgl/TeayG4
	 KvoOoAICP2Q4w==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	Zongmin Zhou <min_halo@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] riscv: Add Zicbop extension support
Date: Mon, 18 May 2026 12:46:33 +0100
Message-ID: <177910284053.86184.16032465455612224497.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324020227.214445-1-min_halo@163.com>
References: <20260324020227.214445-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 10:02:27 +0800, Zongmin Zhou wrote:
> When the Zicbop extension is available expose it to the guest.
> Also provide the guest the size of the cache block through DT.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] riscv: Add Zicbop extension support
      https://git.kernel.org/will/kvmtool/c/716a7c8eddcc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

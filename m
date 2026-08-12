Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405F347532
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538584; cv=none; b=qIJu0RHxIhEdBbqxSaoDiiXFG84Yh3usWnJVKaPMqF7MinbMndDuCctYkj0pNx80XUMVvLuOR0MEgoR+v4y+YOQePQ9bFkcwYNr+LLNY1bOPnBw/jwDjAHFikCZdlRiaAgX77iTqZmWxyd3wU54qC5CGvJdxx2wV+ydFmbdZO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538584; c=relaxed/simple;
	bh=VFG95vPM1lnfVDbcSxaaz8CVUKDbzXdSVZrkWTvifpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGLeqyZKozoPGAzBx9VjSXfzey19YWkfIs/dztzkZKfSUFQ8UFlt/04WcTaxEcVcN2GQ+Q129atPqbh1c/voW/I99Sf0oCcI/1MfYql8vB/CR7gSztLDTRFhjd+z8diibpru1N02G/6rPscUUKzEMWY4RmTsqvMArrky3vgD1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fenpdk7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fenpdk7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307FF1F000E9;
	Wed, 12 Aug 2026 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786538582;
	bh=nryLpqAojdgxbsL4qVm2RXl99LJBr6MU3sWlNLsEpIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fenpdk7rpnvgtW8lEhetOj2eyV5XpiiWQchXYZju4feRzhgnjr7lzGIGPAwMkOYJf
	 XwRLA1u4GmXkUOpTLk5BKVjXTJhRBqCfCoEUKoAO/0Hy/M0UOuFSPhnV+AkIm8/Xmc
	 N0c/s055uPbbdcl9385F6LR+IGpJmpR0EBLvUYjcfLoDzYmXKRelwG4ciZZVOccI3Z
	 tMvmgCtzs/9zszI5LQ5RmMmNzA+RlVdFQXM6OjzAKOOgdpI60JD30c+Lzdd2mINoed
	 AiGF2eCP2na/gKAuNpJJVtBsx99oi9u2hZsv9gU7b0MyH4PR+ub5EDeK2WKDNdS+ou
	 LrNoeGp+dJkWQ==
From: Will Deacon <will@kernel.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	julien.thierry.kdev@gmail.com,
	kvm@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool v2] arm64: Fix resource leaks in find_pmu_cpumask()
Date: Wed, 12 Aug 2026 13:42:54 +0100
Message-ID: <178653832325.2645867.10313265431292725253.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806023218.21068-1-min_halo@163.com>
References: <amzVh6ILi4rd6PwU@google.com> <20260806023218.21068-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Aug 2026 10:32:18 +0800, Zongmin Zhou wrote:
> Close file descriptors on read_file() failure and close the directory
> stream before returning from the function.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] arm64: Fix resource leaks in find_pmu_cpumask()
      https://git.kernel.org/will/kvmtool/c/f67bc0bdae94

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB683E63A6
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937585; cv=none; b=HlVHYe/I2lc0DdL356IGNAZPo+uou580SGzrgVruQ3UxPjret3tiLH2tOUUa9bg21oDFbPKeVRYzAoWZM1Vccfu/ZJ85d41yb73wPoXcWayYnZkbYiSK/YHNGqwQECTV9sUM81ePBb63yqEfYZozbLIj2lbYC7j9wm+50+tq33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937585; c=relaxed/simple;
	bh=Ol2vVQ1v+0ZSEtKPxQPqDb7pSyd/LNqBzi6haiPHva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3KPyJ4K0YWQ1j16feR5vC+s8cvjCUaRpn+TbNb3PaHfCxH4MRhJ3Ft5f9AAf1uR50CqzoRXWZMDbdrxKccXIXpJv9q/f5whMe3vOLsnHKuTXo2qlrauSN0th/eWlVcUT+3h4X5Gr/0JXEB9m41JOMHwhtMM+FYpt+i1GsgbwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7lmuVxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7lmuVxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C1C19425;
	Thu, 19 Mar 2026 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937584;
	bh=Ol2vVQ1v+0ZSEtKPxQPqDb7pSyd/LNqBzi6haiPHva8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7lmuVxOL5C+w48KibXdpYcXTk/JBVEPfTRR2fcJRqBptqDwpEdS2gIUaXmI4e8J5
	 sg6H8qWGuBS+CUTLzDvUZOigNtSCSjvXLQbgt0ooIvhYhVR+FnIhQxgTm8PPF1w82K
	 I+j6l+mMBIGslj9kNo6wY9v+M5gpOd66OGb3Lh+q8ajd5PTBNeizWhyw8SIEM1sY1v
	 i7oa4kH5owcywcL/+jt1hOMsiXAvOIwzcXdwzjnYL7A0kERkS9eqweNnycsuhDmPeV
	 9cNtxL8B/moCiXCTs3lE0+EzZ5eTKAIuPpGiKMlIL7xehpTgdY4VB2KoLBx/5eK6Yj
	 ndeKfUdATRENA==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	Zongmin Zhou <min_halo@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] vfio: Fix memory leak in vfio_group_create()
Date: Thu, 19 Mar 2026 16:26:08 +0000
Message-ID: <177393405832.600804.1753914558671156806.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319082432.34719-1-min_halo@163.com>
References: <20260319082432.34719-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Mar 2026 16:24:32 +0800, Zongmin Zhou wrote:
> When snprintf() fails in vfio_group_create(), the function returns
> NULL without freeing the allocated 'group' structure, causing a memory
> leak.
> Fix this by jumping to the existing err_free_group label.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] vfio: Fix memory leak in vfio_group_create()
      https://git.kernel.org/will/kvmtool/c/eb915c763e4b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

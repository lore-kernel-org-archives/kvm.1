Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86ED439904
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583734; cv=none; b=LJm99zg49nJWGofhBUzax+UbflBw4ubtsilkD3TOYfu09dF0x2WSMTQ/5Lr47jlXQDl98b5Cu1nytXHX8zIAM5N2WuUmqS/zJ5XXzwUBTl3HqmvYVyXQCyGC0dKrV15Nk46QRmcbsOMJQ9dckk9kM6n0uHEYBJ6UAalQJp3DGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583734; c=relaxed/simple;
	bh=ezViDqC2sh3bsmVSE+s1GDsC2dwtV7VUcE+2pBh1xbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyDDKtZqWXcKJL+97b1BuK/DqTGTepcaDzkqTJUy+DT6p2F/jkAmL/AQ+JEFlE0SxnN1cJJmUU7zu/OXsbw4GSbtbd4ZVLvtRPkMncgl0SK+plCt6AgP9RET+C1JnmWdwAWYDplvqxRFDATalOlhBo38ToEEU1JlP/D90O3f8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl0s7olI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl0s7olI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858F1F00AC4;
	Sat,  1 Aug 2026 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583733;
	bh=pYc8FE36sw4EsWNDAiDc/dGegDvdfbg7N3YW0yIs1qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tl0s7olInQHGasdChz8GiA9Vpr12IUi2MlGjftC89EIGmq3gGeT5fqeYk2/D95Oxt
	 q3oz9vY1Eoc5tL+Qg3RO6VIyNgDGbkNoGHnGJoU32tJZIuuUjGKazFGdYlQm8USG3i
	 Bx2ouUwRmZkbGFA/sAt/ovIpfv5B7vFrdATh8KXRUAb5C/pKYSuAdwTacq0XChmmBs
	 vfcK1f2dN1kTVdaJ6d3SAriHsTHHcF26Nkahr+AnmfcSUNa83FM51dntwhkMZej1Zw
	 AhlWC7WUGcxuw/W2IlexrbHLyKml4phZLOiQ/9AtoaInZfIzRel06oy40GvV/2mbuG
	 QoweRGz8j6YyQ==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	jean-philippe@linaro.org
Subject: Re: [PATCH kvmtool] virtio/pci: Serialize legacy ISR and INTx updates
Date: Sat,  1 Aug 2026 12:28:32 +0100
Message-ID: <178551819891.370614.4195141930046292210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729014348.6601-1-xb@ultrarisc.com>
References: <20260729014348.6601-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 09:43:48 +0800, Xie Bo wrote:
> The legacy virtio-pci interrupt state is represented by two pieces of
> state: vpci->isr and the legacy INTx line level. Backend threads set ISR
> bits and assert INTx when queue or configuration changes occur, while
> vCPU threads read and clear the ISR and deassert INTx.
> 
> Those operations currently race. One possible interleaving is:
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] virtio/pci: Serialize legacy ISR and INTx updates
      https://git.kernel.org/will/kvmtool/c/51f527bde8a2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

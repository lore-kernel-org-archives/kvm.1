Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0703F789E
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104803; cv=none; b=sAvJhtQT5LWZWVLsydu7RjNMjI/APywcoD7xPgnH5PD1gXo57qGVblPOh1FFTdXZrP0ieXZTD7+IdtfuYBhH0Y5Cag96PEOtIn+HGMOmdFH6jwpmtRSuR4urwVlM2G+thWqMoFLXgjDp8A0qdvlzxmWPphsPDgJ71D8NXQwGL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104803; c=relaxed/simple;
	bh=trtPFUmBxGb1F+knHnOh+wcn0AukHjjJobhuqnaiSto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiCWpY9QmnNoF01Ker12l2eHY9+UTynOTQE/qXko47oOxJD0YLtNK3DdU2tR+f5TkvyEpfR4Ci4bzNDPllGxOlqnu9HI0LPZX3vxDYfM1OvInrea2ToQkx2/D6zWV6BzI6CPW0T7nEyCjDQ0gWxUtydXGFltn//ZDolQu1Tmc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGvotYBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGvotYBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA4DC2BCB7;
	Mon, 18 May 2026 11:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104803;
	bh=trtPFUmBxGb1F+knHnOh+wcn0AukHjjJobhuqnaiSto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGvotYBES9mnbgR1/7+VnRXAmgNwNazbBFH+3Nd+q7OVtCTgZRy5dQdFgKcp+tZTH
	 bKb+IaRrqqEKcpSdhpPaG3OuqoU3aKj1QUUtvJr3ohePp7Lv8H2DzUvby09l5pM8EQ
	 t1w+bF3HFIEorhLx0Zy8nogj6svKHW9vnjcz2TPUFMozR6CFZ6db6sOIEMvxF2hXxa
	 qiqaKMn+PNQt3EsIGBoxqVjtB6PSWtAKr4ho8pC2OX3ry5JoYUHAaDHU52lL++gNOI
	 KUPja48f1dPHH0qDdNdGL+b6o4chuFCwHrFHP3Jq/8/zlTqJk7DhyIl8PE100I2FR8
	 OzmvFz40+soWQ==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	Zongmin Zhou <min_halo@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH kvmtool] riscv: Add BFloat16 extensions support
Date: Mon, 18 May 2026 12:46:32 +0100
Message-ID: <177910305018.88121.10185183014562299266.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331094614.123614-1-min_halo@163.com>
References: <20260331094614.123614-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 17:46:14 +0800, Zongmin Zhou wrote:
> Expose the BFloat16 extensions (Zfbfmin, Zvfbfmin, Zvfbfwma) to KVM guests
> when available in hardware.
> Add command-line options to disable each extension individually.
> 
> 

Applied to kvmtool (master), thanks!

[1/1] riscv: Add BFloat16 extensions support
      https://git.kernel.org/will/kvmtool/c/455cbb9bb191

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

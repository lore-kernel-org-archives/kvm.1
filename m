Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713291;
	b=b2bclSsmxu6fIKXmJHsMoMn+BJomSIanx/2gq1Zq79gDw39f5BYV9WUDZQZB/p+tV2H/
	 ZFstc+KZYao+wUACxtk/X585h/yKi64V3IN1n62nv6yGZogJ+nrdRkE1sJ+2EeVX58M/p
	 TLspiNYZ7JIHqC/i+LkQcAfQWqYhK07s7EakVLLc0W0yt10+s4ob6SVnQGyIvpqtgdPga
	 hAf6Q7Hy/0olaOB7hgUJsWFdpSxrlmnOq9i61PStBJu8Y85DXQpalRYNbHjA0LAXbHLb+
	 x1qXLpAzrnhNb5kGlNuPyC2IXCfwzGbHv6kAlk5SPxF2NxmM0bqzSve0h3HljqSg0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TQwlNEzbmht4hnnX8BCTGxhRsczcBut+0fxv15UgHBM=;
	b=4i8sMNBiKTzcIa87EZxYkc0hwS1w2RxC3hKgThkhGrp9Zmdv+iWcHeH4eTtDl45/WU88
	 Ke6rXvij+t3DXiDzzCN7kBXVVeh4B/L7a+sssFqz5zRVQhZ5DxZVOmmFzOicw5AfjH6yh
	 ssTWsdn687VMshOhwnr8J+L5Ust9p+XnG1OA7ExZLyb07np2PCgZ2Y97QRvGOS5RwHXZw
	 VnPWvl39M0Sy0HjqGoO4RnJtj28NaPMAd8IY176RcplEZrngNPkdDo5akL55pTk5Uf4Je
	 4hkm9BH3WHFg4ZL9/SagH9osGGBIDFHM/5iodnxB04HD5CV+TVAhp+UtfQN6TPxnnDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bfnc/BMs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CB606A31E
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfnc/BMs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B861F000C4;
	Thu, 26 Nov 2026 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713291;
	bh=TQwlNEzbmht4hnnX8BCTGxhRsczcBut+0fxv15UgHBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfnc/BMsSmca+5qiho/vQXFWa8NAWkgC+lynnXTrjDF2vYFdGz/P9AffZYCRv9C8w
	 fHbgqAzGHfTfTMpxv+iILy9o13OI6WnornOjbGavMbMqfQukUIwvdqtT9OTZCcZ/hV
	 6hzAdT7/+SDSruc1i2IMoKSXNk2dUYa59/AMtzpLputj7Q+wqkju9IRTL+lSTR0EV9
	 d3gG2Jg9sHAVScYPLyLObMYkFBOn/Wt31riJk6TTaWfNi0SKAXfIp9E6ExU1EvpQY4
	 t7QHrdcJi1mc0LMd9ldEednm17l7hQ9RheS91pK0Oy00vDKrGNLFTV16krOSrG17IF
	 uJ4E7OMhq9+jQ==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	julien.thierry.kdev@gmail.com,
	Andrew Jones <andrew.jones@linux.dev>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kvm-riscv@lists.infradead.org,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH kvmtool] riscv: Place the FDT after the kernel's image_size
Date: Thu, 26 Nov 2026 17:14:30 +0000
Message-ID: <179570915035.2893259.9450274384721456114.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019144304.2678066-1-andrew.jones@linux.dev>
References: <20261019144304.2678066-1-andrew.jones@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Oct 2026 16:43:04 +0200, Andrew Jones wrote:
> The FDT is placed relative to the end of the kernel image file, but a
> kernel's memory footprint includes its BSS, which isn't in the file. When
> the BSS is large enough, e.g. with lockdep enabled, the FDT lands inside
> it and is wiped when the kernel clears BSS, leaving the guest hung with no
> console output. Use the image_size from the Image header, as arm64 does.
> 
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] riscv: Place the FDT after the kernel's image_size
      https://git.kernel.org/will/kvmtool/c/fcaa9485b7a9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

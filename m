Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713307;
	b=SNDiohoGbKUZUCLJ4X1lIUt1Tz1HV9IvjSQmn8mc88uduLyxRuZi+GE1f0IvPK4HvR43
	 ki2W4F82vsMfu22KAd1BrKKmFnIP2JI0If71iWuot40GhzezxZ7udvUR+MNbexnVZOwwh
	 M40+CPqPBlJwkWm2mQhb+sybORed82ZM+UBAguzhoNeZBS6yDitsf0zWj/nDUfuEdT3ZV
	 yjcxX9FoFX/7YuSv6+TWlTf6NeKalcj3IatWzuPft1d9PFxEeBjXh6T9CQu4uJ4XCg3Hn
	 I9HCk7dntwMWzuOaopajtkpnPjG8DPkGObWXv1vYTeMT2hZamy7Mo7Wb6I/jhGQNC7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713307;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ACwThbHhdyubLgbGG8BlT9YALy16BOCqO3d8ao1PpM4=;
	b=vcE95hpiLShSLZrAa5ZyM1J/4EA1E7ALQobob4+FM0BlQL1RKiILy2ZV05JBt1BgL3LG
	 iZZivSDurCLpxnzXSjuBuENeEd4hqVHmyZ4IG53G81qClt2Zh6yysVvTx9uEhfefLfcOA
	 iuu8rbm+vWZ1TRoEVNNwWsoLDpAbb8p6JJhjcbELZRoVntoZvlUEmNgCAkWC3DevWuybj
	 bdz/XqZqVwDNTwTlJt6EkhqcPzXuCBkrq9e6q8O/NawKLwvYxSAXBHtt6aqetHTYY1xJF
	 RgocPhtv8op7l/9r4daaOGZ5SOi0KauT1vVxyGpw2fDZ8v+eej5gKa8Jzouwz1KDgiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZRQ8XMP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7F606A32D
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZRQ8XMP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE1C1F000C6;
	Thu, 26 Nov 2026 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713307;
	bh=ACwThbHhdyubLgbGG8BlT9YALy16BOCqO3d8ao1PpM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZRQ8XMPv43uPWp1uQsQh5tT8GVHv7TD3cz9gE9JPhxgn7xl4AniQSdquMh8Yvg46
	 yVPqMVHUclpkPjRZTLtmTW5aF3wpw0yIXRreNeXU23dQHoBoXgcZKYcrENFkIHve34
	 Y4TQ9Rh9RapKYmTQFH832rTnZ42ObV4OIvCTPd/dtNrw37X5DBw8gAH1KOlh4nlAf2
	 C079li9IqpHo3mOdaDO4F/mTQ+LHztyYWW0Yrc2dKg7l1k1ws6xQOQjoO55JwzfLqE
	 3AWVKnMRXtUvHsQQQ4MBpMPyEGVBdEC2x1CHvOMMWeKTkfpav0pW9T7crDwfO6UKAY
	 fbZasCOPfNv5w==
From: Will Deacon <will@kernel.org>
To: Julien Thierry <julien.thierry.kdev@gmail.com>,
	Mika Tammi <mikatammi@gmail.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	kvm-riscv@lists.infradead.org
Subject: Re: [PATCH kvmtool] riscv, arm64, powerpc: Align the FDT staging buffer to 8 bytes
Date: Thu, 26 Nov 2026 17:14:36 +0000
Message-ID: <179570952413.2896399.3729150509718337186.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028190531.48302-1-mikatammi@gmail.com>
References: <20261028190531.48302-1-mikatammi@gmail.com>
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

On Wed, 28 Oct 2026 20:05:31 +0100, Mika Tammi wrote:
> setup_fdt() creates the guest's device tree in staging_fdt, a u8 array
> on the stack, and then copies it into guest memory with fdt_open_into().
> 
> The Devicetree Specification requires the blob to be at an 8-byte
> aligned address [1], and libfdt has checked this since dtc v1.6.1:
> fdt_ro_probe_() fails with -FDT_ERR_ALIGNMENT for any other address.
> The sequential-write functions don't call it, so the tree is created
> without errors and fdt_open_into() is the first call to fail.
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] riscv, arm64, powerpc: Align the FDT staging buffer to 8 bytes
      https://git.kernel.org/will/kvmtool/c/6ad12e755313

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804784;
	b=Ov6VLQ64yPfYrGVzoCPTQYet2r5FLRVQbACYtUZug0eMl41NELbniSwsqlZ7EhqsYcZD
	 vH8kuwavaUToRrlj0PygOsQeopRCyr5CWI22jJUlq9Jv9evMWPYmNcYi1iCoG9M/mijUK
	 mFHELHkO6rd6IXVEs2LsXdRmkM+VpbVLtJe6yp1oqJcONQXW4xfupfEKuOUFGGRshSMYK
	 XVh3MDDn4xAlok+bM54iMVVkiOttJJgIRwJGAalVnHRPrM1qoa60lfRAeSgEMSU4AaE4E
	 /1cUndv6dPA20mxvCWlhzlX+VldCChjj51ang3v/OUTYHYW3SNsvJSLnpRHvqqdQkNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s+W2kFM9mGlyI0Xlc897xQd2x20RHKn3GOXtEipIeM0=;
	b=qDzdTWxD/nsLyOaTiPboTr5i0xqq5JZ7t1dazi7Hi2Kc4XwGsTPA6ZjSLSib4vXUQlE6
	 y5kwuJorAp0sVDOLEgGMF7SnQ+4EClVdhyDcn71HlXIz8VpZtjTurRzwytbooDXuh1/pC
	 LjxL8aj7r/eOaYQLgnYAEz7qcNTc6rV4Foh602i6Oh1knmGAn6hZmrc6FuHgCR8BTjgZL
	 P+D8sxZWL7N0uwitun8R66qr7D3+wUu6mkqmr+ri6cwEg+lOmCzV6j+eZjmHjic+9gXFl
	 5HL8UMKhpRyDB8KhdpvUN0MWiXijsTeNWSkwLJx8vbyIzxMVrPzbCGpwsI9591sNj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OY5GTibC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1860A3838
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OY5GTibC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB95B1F0089A;
	Fri, 27 Nov 2026 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804784;
	bh=s+W2kFM9mGlyI0Xlc897xQd2x20RHKn3GOXtEipIeM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OY5GTibCBFn9+Q68emUYusroAEXqpVlRkjsAfxGTvOy/E7O+hWTianxvR0ABO0Tvp
	 Nk+XHB4cr7jjPadZBacqeUGBj81clmov74rstY7oUMepi8w9VPaxts6GTBuVipCpdu
	 NgUhoOQyjDVwRcKMfH8+sVLfcT29jP8TWo18CHQl4xlIO3Td0A0OTzpfxTtIL3ejUs
	 D8sKDTY0xra6S1c7tGcryraNa6wT8NOVlzWDybyV33s8FvtiriGiOov5M3jKOtgmt6
	 luo7HL0MgVJlmzIJpAn+7MG5TNcLWJXs3ak92BD/1M9bSRN+f8YltiE49rLRAcd4Ze
	 TToRMocVTPOsA==
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH kvmtool] Makefile: Make the clean target independent of the build configuration
Date: Fri, 27 Nov 2026 18:39:14 +0000
Message-ID: <179580207397.1722682.16898673061022985401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126195438.3313169-1-fuad.tabba@linux.dev>
References: <20261126195438.3313169-1-fuad.tabba@linux.dev>
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

On Thu, 26 Nov 2026 19:54:38 +0000, Fuad Tabba wrote:
> 'make clean' only removes the objects and dependency files of the
> configuration it's run with ($(ARCH) and the optional libraries the
> Makefile detects), so after a cross build a plain 'make clean' doesn't
> remove the objects and dependency files specific to the target
> architecture.
> 
> Remove every object and dependency file in the directories the Makefile
> builds in, along with guest/init and guest/pre_init, which depend on
> the configuration in the same way. List the directories by name so that
> objects elsewhere in the tree, such as those of a dtc clone used for
> LIBFDT_DIR, aren't removed.
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] Makefile: Make the clean target independent of the build configuration
      https://git.kernel.org/will/kvmtool/c/62c3242c6484

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

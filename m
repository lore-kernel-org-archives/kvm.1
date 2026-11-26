Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713315;
	b=jMI3CX5tLDPOmwjWn9C8W2ExO+TtNa7pvTUnv3ywRXOUdSP+inK9vAU9eT+B/rh460iJ
	 2ONCx+HxkQDEzXGaD+B8tXdD8liht8JCDxYWX7+h2NrP7emjpC9XzV1/fQLIQl5nrE7AP
	 5FIGJkIOEe/EeLSfYPb3ZlGB9e/rJDnrFKw/H+exIcoCq2tvcp3oVQLIOGFR6/L0ZJijc
	 qXEe6YKkXnDVXdXqgoA26Lf1s4QlJZb9OGk/CBsWCiomwNqashZ6fobE1tY/WzNCBzska
	 Mgh6vJgu7XmgH/E1EoimvCY+FERdWfWjj2Y4dEH0DozQgXteVS1vQ9NHK/n7aQbBcNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zJyJDH0ytNJp7/5Pg6NlbzI1N64mrmledt5X+dcOWYQ=;
	b=i/5qn3SAZg2qkHCvIriuiA/+xPFmmbqfW+2YY+YY7CmPtDTEctXBA/+YmDFfGZDJgYKi
	 akW0pqhcNTuQHkK8SxBZ4ZTu8+6LvPgdx661h/TNMZaH7LYoD1e8wYEnKDDGotR0EzVT2
	 iWWuaA/h7M1tUi/92WhY/Kq4EpPYhNgdl+vozjUeXpS08Waf6hDOzcNp5OUvqSLyMiqT9
	 QtzZ8uVGcSUslwDg1PdD0CaUBUlkTjvBdzmBcUszI1uVShRT6zvEmcde/zZHwvJKp0WtP
	 wEXhvjoAio7t8y/5mGGKjaMQQCv7LKDpARWp30eULhECZXQum+Ramitx7C14NtyU0Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqLz7Np3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF9606A326
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqLz7Np3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181051F000C6;
	Thu, 26 Nov 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713315;
	bh=zJyJDH0ytNJp7/5Pg6NlbzI1N64mrmledt5X+dcOWYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hqLz7Np3mZ+6Ap6XH6d/MC5WfiRl7DI3RPpzSUoZHAcsKsn1VX53ooKto5FdFMSSq
	 ykEIxrcSX0jvmV7Dssjm6TnNgrQ2H1BwaFp4UElABTPs7cFjc5iNcntlvR3xHwzwaU
	 j/0HM/5DwIGFu8+Cj1uRtpRT6gDXM2oCtqCupop6XNiGKgntP2ub0Z8TmHqIOnQHWd
	 J1NPWLXtox45nVXYmbklG8bcvpLN2x01wSYEQbIF/UW3cZBVn3NBCiiFNDKGOmXUpg
	 k4dkvi3Q6KGjbwQej2kAQILQAbZyF6ujLJFBPNmRuRqJjj2pyMaOpLj4xDnC//Dor0
	 qREiTsMwKsMvA==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	julien.thierry.kdev@gmail.com,
	praan@google.com,
	eric.auger@redhat.com,
	alex@shazbot.org
Subject: Re: [PATCH kvmtool 0/9] vfio: Add support for platform devices
Date: Thu, 26 Nov 2026 17:14:39 +0000
Message-ID: <179570943526.2895721.10234490555564321046.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261024161902.2093581-1-smostafa@google.com>
References: <20261024161902.2093581-1-smostafa@google.com>
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

On Sat, 24 Oct 2026 16:18:53 +0000, Mostafa Saleh wrote:
> This patch series extend VFIO support to platform devices by using
> VFIO-platform.
> 
> One of the main difference is how the guest discover the device, which
> is done through the device tree.
> kvmtool can only describe:
> - regs
> - interrupts
> 
> [...]

Applied to kvmtool (master), thanks!

[1/9] vfio: Fix fd leak in vfio_group_get_for_dev()
      https://git.kernel.org/will/kvmtool/c/26d4c79259e3
[2/9] vfio: Factor out wired IRQ setup and teardown
      https://git.kernel.org/will/kvmtool/c/604a2f860f8d
[3/9] vfio: Support edge-triggered wired IRQs
      https://git.kernel.org/will/kvmtool/c/a9da3b73e77d
[4/9] fdt: Allow fdt_irq_fn to generate multiple interrupts
      https://git.kernel.org/will/kvmtool/c/2d06752ef089
[5/9] fdt: Add helper to copy an FDT node
      https://git.kernel.org/will/kvmtool/c/f49a8f4697bf
[6/9] vfio: Reserve guest address space for VFIO platform
      https://git.kernel.org/will/kvmtool/c/35c61fee2003
[7/9] vfio: Add basic support for vfio-platform
      https://git.kernel.org/will/kvmtool/c/eef82b735841
[8/9] vfio: platform: Add interrupts support
      https://git.kernel.org/will/kvmtool/c/9c63bea1df04
[9/9] vfio: platform: Take the guest node from a device tree template
      https://git.kernel.org/will/kvmtool/c/eefffe660bba

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

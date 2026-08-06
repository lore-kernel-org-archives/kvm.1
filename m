Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67A485CF1
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036351; cv=none; b=kXvcY0e30AxR6S1q8vTw5s/1u7VfrHhlONMipRIEcxK3wxENUY6PWJjx15SISzo90fz7Tm1PypM2mMaJe60jwQX1kSlzUujts3FV8vF5pZT/dLHMzZcLhZlKy2gyRwoEhbUfMGKyLRQHfBeLZm9ltGlKM2nxcXkNyQry/xCjXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036351; c=relaxed/simple;
	bh=kno5XV2WE5NqhzGPO/LMCKf0kX6BuVSg4cs2xyEiZBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQSdsgM9+oSB99i2x2peeNy2M1F3S1GDutkGADIJgZflY+YUGkQt/MBTjUMoV4oSpa280Qrffy07Xig4CK8cV7OoyAUGnAH+NHp0ZyOLHixpQXF8RAQQY3R04RXOx8OltkV7BgKz/l505QR8fWLaV0CDynoi0QmCUD4iPoYa2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqL/dPmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqL/dPmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48461F00A3A;
	Thu,  6 Aug 2026 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036350;
	bh=4i5Ppn5xBnro40zYwYi8eleXJi9kUW7HYo7vrhdh9yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqL/dPmmvQGagYtO6xGFUJMlo7gSU2Z5Ir9m4u0m7sJ2QlaFdRDBBdWq2syw8L33G
	 KjDBzY9f8eAVQgLdSDk8QkS8VPRPPLfsG1aDOFBtNLpjreHiVRMk4ZBA8c8Y9RnnkE
	 XAfooKMOfZDWE6gQkwtvqqX+sxhUSrOmzsn6kgLUsTG/YvtcBDH6iN1h3YyENMVgoE
	 Cjp3N8z1b/BO3gLM9urI4wW8wmA/Ib+SBT+lgeafAKXlRFG9zgxP/QLFgZPZ5Mnm1s
	 KhKb8NJdAFiPqjPDg4t6VZOwTrqUhuOu3LLEdXLeRUmgzy0z8LiQsTAragbF/EC0Qq
	 Nteq7B+fsAH+Q==
From: Will Deacon <will@kernel.org>
To: kvm@vger.kernel.org,
	Xie Bo <xb@ultrarisc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	julien.thierry.kdev@gmail.com,
	anup@brainfault.org
Subject: Re: [PATCH kvmtool v2] virtio: 9p: Order used ring updates before notifications
Date: Thu,  6 Aug 2026 18:11:49 +0100
Message-ID: <178601871259.400708.14727067977193300905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803013226.333910-1-xb@ultrarisc.com>
References: <amzWlInb1rgkRy_4@google.com> <20260803013226.333910-1-xb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Aug 2026 09:32:26 +0800, Xie Bo wrote:
> virtio_p9_do_io() signals the guest immediately after adding each
> request to the used ring. Unlike the block and net backends, it bypasses
> virtio_queue__should_signal(), which provides the full memory barrier
> needed between publishing used->idx and injecting the interrupt.
> 
> On weakly ordered architectures, the guest can therefore handle the
> interrupt before the updated used->idx becomes visible. If it observes
> the old index and goes back to sleep, the completed request can remain
> stuck indefinitely because no further interrupt is generated.
> 
> [...]

Applied to kvmtool (master), thanks!

[1/1] virtio: 9p: Order used ring updates before notifications
      https://git.kernel.org/will/kvmtool/c/59ccded8ade3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

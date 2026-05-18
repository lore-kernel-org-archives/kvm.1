Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85C380FD4;
	Mon, 18 May 2026 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132077; cv=none; b=e9TNaziyTsOSuBqnxk1nqnKJINKh/uy/FEjTmE0Ke7Zfvx0KQAkPMSpmz0eHjEvv7IBY+MKOXh0T86b/tZrE4R4B5H2BVMEyAv3pYy+mrN5Ub+hA0Cyy2hMZIG6boVO6YIWB+p7GjTqlYAYXnOfs3GbkWyeclFxrQsVmhQ5ee/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132077; c=relaxed/simple;
	bh=c3uPMQHaEVcm6ipsCrum7wOJd+GaVS/I9igJJ9xAe6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jheB7qOjALqe68PFGyorqG8lNq0Y/XFiBmkn0B1mW/1u3DSY0LP5UzZlN4bRWFSQnJpfaPabUxSuEYfvhOs/jxxsS+9ZcmZctjVkUsRT8ECuRPqEOP6QmvD+dFmrqacBxjW/qx0iYSUHYOx7pUomXiEJIpfONZtgCtRnn1bJaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i50eDcOM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i50eDcOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE22EC2BCC9;
	Mon, 18 May 2026 19:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132074;
	bh=c3uPMQHaEVcm6ipsCrum7wOJd+GaVS/I9igJJ9xAe6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i50eDcOMXJ0mQncE+Ac4kTyy4iA37ZeF0XvTA7g50qDmzlTQ33uveSBBk1NUMG2Sa
	 8+NMlDJvPlHZg3oLSNlyQlam0qdAEjXKOUWZauUg1Sg5hrBUZDANWsZll6NUHapZi9
	 woc5cY4vF+ZN0tujru2M0mGf03frTyScFMSFav1E8iuN1J4wQnTZGvMsmC68hSMdXV
	 xSWTTeBgQuDiAVrWsiOipfrgKNwxRnpqI0G8FBcj6KSHCUhG/4HaYbYAoWztYlBm9M
	 Dr2KdfvLA55ozYVDkVCPAsnXbWKhmYoc9kTOQX8snJJ5VPwa6m3MfsahCmUWDKB5lF
	 0VO5QdkoAYNOg==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xianglai Li <lixianglai@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V2 for 6.12] LoongArch: KVM: Compile switch.S directly into the kernel
Date: Mon, 18 May 2026 15:20:58 -0400
Message-ID: <20260518155236.reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517091855.1023223-1-chenhuacai@loongson.cn>
References: <20260517091855.1023223-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, May 17, 2026, Huacai Chen wrote:
> From: Xianglai Li <lixianglai@loongson.cn>
>
> commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.

Queued for 6.12, thanks.

--
Thanks,
Sasha

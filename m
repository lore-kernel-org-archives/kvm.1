Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7833C1AD;
	Fri, 26 Jun 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462079; cv=none; b=sCodaa9oXK0imoYlm4O9fRjDBKWbEup3KJdQDE63m+xUlFQEr3ZdKGXLQPPjggv3+fTkEG8F1w0pKl3wY/Of19i93FVJYOSchm9U3sHtGBZlc7ld9eZNG47V56w5wsmGOce2mqZSvXHd6OETx5QU6XzFYXTBl+dcSh9qefp6WL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462079; c=relaxed/simple;
	bh=2uCVYqHtgZGFgvjD+ummxhr36AIRZkHLgpGTEeXDc7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cYl2W43dm94pfjq6Jng7FAjx7Nv1HzAdRBDoyJb0LTAjwd/Iqar+NVwmlOSV83rdLMfYTTHd9X1Qb9NOgNmfO18gf3fWijkc5Dco39NfjFvNhRS6IFhiMVGz1823XYK7s5yAMHCqnmDNaDFLLfJli6rg1RyRjTOTe6G59yJgoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6xKGOM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6xKGOM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946431F00A3F;
	Fri, 26 Jun 2026 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462078;
	bh=JI0GxwAojLxKVFwlEOU4ZPICdfzGKw9cICvZEMficB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I6xKGOM7/fsBQEKDF7dia1uD6RiDe1aFMJruUQis5I9vTwn0YNsK6D2SxTFHivvxq
	 pDeY0fVr1TMG85kvEefOc2/Vg0HbxreL9gDXLR/3h2OTYwBiCgvSeaw5te5ws9XInA
	 ExQiy0LqB1rnjTl1mIz2cN70ybxsPI42URHmE0C18xvjsF11jnSybCBFtaLVfNAkum
	 6CM40mcgNBrrUxIyXmAnVmIUKGmJ/gkJpXB+q7zpcja89npZZxT78x0QsiUSzLJv5C
	 37zTEizn9T1NYR2iBPbbsxPxR+Ra20Y2yvc+9mP23hgcK69ElukKON03y3j6XmQoN9
	 j/bhWMw9cnrsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09BA39389E8;
	Fri, 26 Jun 2026 08:21:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: KVM: Fix invalid HVA warning in steal-time
 recording
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206549.3816447.5536790669750884836.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:05 +0000
References: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260415075216.2757427-1-xujiakai2025@iscas.ac.cn>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
 alex@ghiti.fr, ajones@ventanamicro.com, anup@brainfault.org,
 atish.patra@linux.dev, palmer@dabbelt.com, pjw@kernel.org,
 jiakaiPeanut@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Anup Patel <anup@brainfault.org>:

On Wed, 15 Apr 2026 07:52:16 +0000 you wrote:
> kvm_riscv_vcpu_record_steal_time() assumes that the steal-time shared
> memory GPA (vcpu->arch.sta.shmem) is always backed by a valid guest
> memory slot. However, this assumption is not guaranteed by the KVM
> userspace ABI.
> 
> A malicious or buggy userspace can set the STA shared memory GPA via
> KVM_SET_ONE_REG without establishing a corresponding memory region via
> KVM_SET_USER_MEMORY_REGION. In such cases, the GPA cannot be translated
> to a valid HVA and kvm_vcpu_gfn_to_hva() returns an error address.
> 
> [...]

Here is the summary with links:
  - RISC-V: KVM: Fix invalid HVA warning in steal-time recording
    https://git.kernel.org/riscv/c/653f17c74260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



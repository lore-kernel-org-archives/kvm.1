Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D11D63D5;
	Thu, 21 Nov 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193785; cv=none; b=qktZd0fNVw4Xs4fb2/QmtMur3FohjjpZZVe9b01wVxQSLpKP2FAT0n9vgVG+qKiMZ4hycpjL/Sunq6Vg6BFvmkMLI5DS7VTS/W6k52jO8Ej+5RgZXL2hcz5VEvieX4NhaZ0iJZC1Vu0fwQhCs+/a1zKqH6aGZvMI5kkheiNWI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193785; c=relaxed/simple;
	bh=jvsduXpg/u7NqfUPDBftgO7Q7vJ3NiPU2Z+xJVOq79U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnpSd86BkvZxepG4u2noEJL7ev+1+Y40C/eUqH45PBX7FyVSGAqv7X31sEvG9Kgdsl9qd+5xVDLaDra34LNFMtdQpk/0zFbyIijTxl5CvQ/qPrbKJVhymg7GhL1CRBn9yVpXBD/Jkfp7vvXeTCywPzfHHAcczbb3JHlHaWgerOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFmuZ5i1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFmuZ5i1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB436C4CECD;
	Thu, 21 Nov 2024 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732193785;
	bh=jvsduXpg/u7NqfUPDBftgO7Q7vJ3NiPU2Z+xJVOq79U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFmuZ5i1F55hB52xR5kd8FOf1Jz1eB1+gKHkQGqkMsnDWDCO38hT2/GjEmOZ5oTs+
	 xqTQvvicuo9wBqUxJsBg0UGyYatLEt8JjZUXg7EBoIO7z+bH/aoWXq8EbvRxCm+agR
	 kvgK+JDg2cFJUwbOcROmizRD9QIUN3GLmkJekMYi33V7jECStGobc7Vj7tH/3JRQYM
	 rIKhLVy2ND8CogdSfK7u8SdCp9yJB9+EA4voxH5mzJeGk7ftQlxs0jyAYzDx65ALyx
	 tVI6ZGsI4r+ZFgudYr8J4HPe6nSvNyQFbKvxWTIpOTIhOP7Zto2+2QCFLtlIBjbbvr
	 bZnJmQKZAn4Dw==
Date: Thu, 21 Nov 2024 07:56:23 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 6.13 merge window
Message-ID: <Zz8t95SNFqOjFEHe@sashalap>
References: <20241120135842.79625-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241120135842.79625-1-pbonzini@redhat.com>

Hi Paolo,

On Wed, Nov 20, 2024 at 08:58:42AM -0500, Paolo Bonzini wrote:
>      riscv: perf: add guest vs host distinction

When merging this PR into linus-next, I've started seeing build errors:

In file included from /builds/linux/arch/riscv/kernel/asm-offsets.c:12:
In file included from /builds/linux/arch/riscv/include/asm/kvm_host.h:23:
In file included from /builds/linux/arch/riscv/include/asm/kvm_vcpu_pmu.h:12:
In file included from /builds/linux/include/linux/perf/riscv_pmu.h:12:
/builds/linux/include/linux/perf_event.h:1679:64: error: too many arguments provided to function-like macro invocation
  1679 | extern unsigned long perf_misc_flags(struct perf_event *event, struct pt_regs *regs);
       |                                                                ^
/builds/linux/arch/riscv/include/asm/perf_event.h:15:9: note: macro 'perf_misc_flags' defined here
    15 | #define perf_misc_flags(regs) perf_misc_flags(regs)
       |         ^

Looks like this is due to 2c47e7a74f44 ("perf/core: Correct perf
sampling with guest VMs") which went in couple of days ago through
Ingo's perf tree and changed the number of parameters for
perf_misc_flags().

-- 
Thanks,
Sasha

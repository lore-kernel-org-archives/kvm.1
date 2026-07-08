Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619383F077F;
	Wed,  8 Jul 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495435; cv=none; b=N7JJuaO3LqSjGPInN0i55aPPm8asZr7ZYaY/qSVYznFXZbTbFSyO4SyDTaIVppO4WhJs1Zvn4mra2jjJR+LSCSgdFOxtNTxP4jlQVegQ5Imw2Vt/tf36fGylIfD/3BaeJR9wC8y1ofeH9yO0Z3FidmuOQIf9mixQMXQcXd9DJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495435; c=relaxed/simple;
	bh=h+XxSiGVSg9hEIBd227KOiUzOcWry9yMrFCd2J1bc78=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e48mMBv+LNzHCeZ1zU4s8MHM58k/9UeBiWXaFisBWs1mKje8BCkr68LKyf87gzxl9cdTIlEUYEynp+iswikzbo8W7IhSUNTFoBHfA7esEPaV5fpFtHetHAo1vDAlKczs4oR/4o5f6RtW/Hr/pV4QE03oIRsDC6egJrnqDCO7lRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrP7tFnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrP7tFnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6121F000E9;
	Wed,  8 Jul 2026 07:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783495424;
	bh=17F/Jr3rKociTFUmjiT8hNoe4yR6eIdvM2BSmhwTG1A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XrP7tFnPcV4SbOo3PP0s7VRX7iFL46u8xxpncivYDlLIvx2GyNbLhxqf0Iv31POkb
	 0gjM89TK3iJBQJeTZm4arCQ/dFQAOoLpHPoluFZDCq55Ql5HOLgkoMA8NTk15w4SB1
	 p/xTOiDyswU8uSBVuaBVNgsp6wZ1DGCfRRxXmrm5GWBl0LTf87KS+lmq3erZQEUEFa
	 drx4y6FWzPhwg/d3FAL8PMi9CSpIPk8PEu02/oAY7d5C/37JBL6S4PzGnAbfT3rGUY
	 8oKZ74Vu7SCNXdeAdobJdo+/dJXGkgYZzMJf7jBbU0kd+TmQFtcJ6SyAVMJFaynxph
	 K9/7SN+vdBLEg==
Date: Wed, 8 Jul 2026 01:23:42 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
    Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
    Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
    Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
    Chen Wang <chen.wang@linux.dev>, linux-doc@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
    Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
    Jesse Taube <jtaubepe@redhat.com>, 
    Charlie Jenkins <thecharlesjenkins@gmail.com>, 
    Andrew Jones <andrew.jones@oss.qualcomm.com>, devicetree@vger.kernel.org, 
    spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 03/17] riscv: hwprobe.rst: Document EXT_ZICFISS and
 EXT_ZICFILP
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-3-2c61f94a695a@gmail.com>
Message-ID: <e9d78a59-12d8-8969-37bb-583a1a6951c9@kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com> <20260701-rva23u64-hwprobe-v2-v5-3-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Guodong Xu wrote:

> RISCV_HWPROBE_EXT_ZICFISS and RISCV_HWPROBE_EXT_ZICFILP are defined in
> the hwprobe uAPI but are not documented in
> Documentation/arch/riscv/hwprobe.rst.  Add documentation for them.
> 
> Link: https://github.com/riscv/riscv-cfi/commit/302a2d45c2435940d9a63571c66bc038adc74133
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Thanks, queued for v7.2-rc.


- Paul

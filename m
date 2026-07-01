Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2A481253;
	Wed,  1 Jul 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912476; cv=none; b=t+Eqk8fkf15UA37jWyp8qlGpBTXYzUT4LGr2I+X4V855sruoFjNSnTnkqLUniRNmmz7NnMuXu8WRR3zHc/cqVS+dZpCiawKK4PQK8w5SKxiYr4xeKmisrhlLojs+BuH/a7/DmRUH5N7EZat++S2ctg6hr+l2t1tAOKpaplFZmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912476; c=relaxed/simple;
	bh=mazLK4uun9sVY3shyaEGOYQyPdm3lUeU0adnSqdfl90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dD1F74Halkbiz079dJdghAnEtFNkVV9GVj/qPSZAbk6fzuJcvg8CbChy8xAyFLp95DWEL2TPBk9i1a8K+V8PgM/DBZ7Bz7t0XxLXzNvLnDAPnYe+EQfaoD1w5tym4s+HRd5z88Q3PxdR3rqiCBT9sY/nyD7onCx1zxyJY/6k9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly0Up3nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly0Up3nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D5A1F000E9;
	Wed,  1 Jul 2026 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782912475;
	bh=VePrBvVa39r7DLJgUNgVwwkAdaH/rFFKp/ZVcKljGuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ly0Up3nvGvH1Cx3RkefH5EA1NP4CXbniAYdcMRz3bpmewgeRcj88rkLFi34PpwjFp
	 snMlBOTdMYRmayIhV4tuJygNoYCvEASNihHseQvSzi6ZYyv7xcFsV0iZ2IAt9PAhck
	 rrNyVVk6IWtu5fDz+oJZLuZzV3Lrl09hQ7FEoUKfVYVJohqWGhQCo8yS8AhIJsL3WB
	 H7+ZtRcbwh2XGEMrBK9xJzgo6WbT+9jGN97ivkyFu7Oimr7jK0KLd1sntr96u1oN11
	 kYWDtNetxIu9q4ACA/tPIuWkhaHbHH3GjoH99w3B8prPgacs3aDwTRPv6+YxGbR9bK
	 U8dYWKW08zy7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] riscv: Add B to hwcap and hwprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: conor+dt@kernel.org, kvm@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-7-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-7-2c61f94a695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:27:54 +0000
Message-Id: <20260701132755.50D5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new B base extension is added to the host's hwcap and hwprob=
e, but KVM support was omitted, preventing VMMs from enabling it for guests.
--

commit 1f4cf004cf603a91f99c0c6776c5ca74728ca05e
Author: Andrew Jones <andrew.jones@oss.qualcomm.com>

riscv: Add B to hwcap and hwprobe

Add B to hwcap and ensure when B is present that Zba, Zbb, and Zbs
are all set. Also expose B via hwprobe so that userspace can probe B direct=
ly.

> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 0acb7a01ecc0f..58523b3a1998a 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -11,6 +11,7 @@
>  #include <uapi/asm/hwcap.h>
> =20
>  #define RISCV_ISA_EXT_A		('a' - 'a')
> +#define RISCV_ISA_EXT_B		('b' - 'a')

[Severity: Medium]
Since the B extension is now exposed to the host, does this patch also need
to add KVM support so VMMs can pass the B extension to guests?

Without adding KVM_RISCV_ISA_EXT_B to enum KVM_RISCV_ISA_EXT_ID in
arch/riscv/include/uapi/asm/kvm.h and the corresponding KVM_ISA_EXT_ARR(B)
mapping in arch/riscv/kvm/isa.c, KVM's ONE_REG handler will drop the
configuration request.

When a VMM configures a guest's ISA by writing to KVM_REG_RISCV_CONFIG_REG(=
isa)
with the B bit set, kvm_riscv_base2isa_ext() will return KVM_RISCV_ISA_EXT_=
MAX
and explicitly clear the bit from the requested register value.

>  #define RISCV_ISA_EXT_C		('c' - 'a')
>  #define RISCV_ISA_EXT_D		('d' - 'a')
>  #define RISCV_ISA_EXT_F		('f' - 'a')

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rva23u64-h=
wprobe-v2-v5-0-2c61f94a695a@gmail.com?part=3D7

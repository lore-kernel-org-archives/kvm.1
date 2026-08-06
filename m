Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20482E7631;
	Thu,  6 Aug 2026 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041092; cv=none; b=As7NJBErQ+vZ6AArqjtqSUZHFstCeCSdCWybwiXar3/oOBxZp5hrm3uFtsuIbEnPYWpE6GO/AoiOZv8dpoDLSdDiiaAIAH+ot2uZOhbBlmIpxV5v2womFpCjKUfVu0vqiioCRXtq9pObEBzRacxVBJYIcGIc4QEGAexM003xBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041092; c=relaxed/simple;
	bh=Fcd8o8lKkfFW7V9teekNGaV1XuPWdm4NyMl6FNnh/Jk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c81sDoVWjoSkcqgmH/xkj5UfFP4IHUFeohICDfJOc73Lex/bW7wDOccU5n8jaNSBmkdxCH7XQvXjRk1U5cSkxiX/jFlj3wvFl3TE8x36VlvYJO3g48HJVmrOcvlq0usBBwASJR2ql97i4G5yLyoHy/TcgrtE/bHSEC+eGvnSRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtv22uXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtv22uXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470951F000E9;
	Thu,  6 Aug 2026 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041091;
	bh=44M6jU/Kh8m/G1eDNu1JXoHIPfmG7QRrcFJA1Q9PNY0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Dtv22uXuK+7t8r3nCF4xtLj9ZE0N6JSnTz8DbzNOxgEwNM5aQeq+cMVN1sxrQ57ag
	 xtYg1nxiom1fw/NBSWSXcijfhwmbkjDnI4BZsi4d1Bd4ca6hQciNOu/HO02Joy68ED
	 C/MLPgoUtUoAKm9LvILDbulTamZGlhKRrOq2hZQfltwviigCURwFWSPkpa2p9A1aOh
	 Eadr1J/UnRjIIA8Zpa0xjhS4TNuHNiOHMEC08Az7rkZoQmnTgPejxSuefiMC77oG4n
	 P+LGJio5+Qu6DYiunq/Y7+9q8n24rg0AV5eU77Yqja2WXzvT3bT7x58ZO6KAIpnWtZ
	 vNT0nxgWGwmoA==
Date: Thu, 6 Aug 2026 12:31:28 -0600 (MDT)
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
    linux-kselftest@vger.kernel.org, Jesse Taube <jesse@rivosinc.com>, 
    Conor Dooley <conor.dooley@microchip.com>, 
    Charlie Jenkins <charlie@rivosinc.com>, Andy Chiu <andybnac@gmail.com>
Subject: Re: [PATCH v5 05/17] riscv: Add Zicclsm to cpufeature and hwprobe
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-5-2c61f94a695a@gmail.com>
Message-ID: <3cb41566-deea-689b-c445-2226d7f3f25a@kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com> <20260701-rva23u64-hwprobe-v2-v5-5-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Guodong Xu wrote:

> From: Jesse Taube <jesse@rivosinc.com>
> 
> Zicclsm requires misaligned support for all regular load and store
> instructions, both scalar and vector, but not AMOs or other
> specialized forms of memory access, to main memory regions with both
> the cacheability and coherence PMAs, as defined in the profiles spec.
> Even though mandated, misaligned loads and stores might execute
> extremely slowly. Standard software distributions should assume their
> existence only for correctness, not for performance.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> [Rebased, rewrote doc text, minor commit message revisions]
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Thanks, queued for v7.3.


- Paul

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12E3E1718;
	Wed,  8 Jul 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495405; cv=none; b=R9S5yxcckUxYxDotMtyeGW8EF95jjXTM/8rYEIhUOXxvi+yoXF5bGEJ2W6MYpiAqMNUe+szCjlFcF+dAS0eW3k3Ktyl4cXc5n6v5s3JesXiyFYX8D62jMyuQTq8BpCTCYuFmJq56c2GXJMWtsIBo3ER+hRaoxkpglErgjtLgcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495405; c=relaxed/simple;
	bh=PO3olEpxnMpKR9NPVcV8s1UPGIO/cqJN4SeJNyJu2L4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H1N+yyOl0bl5CMO6loqAvljhCXfvUV/Lnwvk02/lPzDlIvGzzHzRxsfSwdi465xhB4dBRgkoihjIg6PD/ujp6r34W/3Mg662zOI8bH9S/DEKoxM8Pbl1rNU1qGFyDPCKZWjyFW+0mcNeEJDbtT7/Slkt2HdY67rkYhxV+GlmSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2Cmya1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2Cmya1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0391F000E9;
	Wed,  8 Jul 2026 07:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783495386;
	bh=g2YwrV68FCrFirnBYGtqFd1JPTatKETi9U9WjISw31A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=X2Cmya1cHeLKtJshVCMlBM9ZnWhFHDHpcJcZb8TF/jzOZBJFCeMbgam57pJSw7eNU
	 s+e5YW6dEMvZoN2C2r7K4447QuRCakW3Yc5o7tFbrKa51/QofHmLLTNhvxzvK8xUXT
	 uPBGrbWZuS1V5/ztmqvW0HoIL0CapAQBjItq6WgpgUaGvRxPj8yBCR3nz7loK/WjuF
	 L6gWCyIXGDHKxLLBduYGPy8E4g+HjXPXSRRlSf1T9vwZUWvEk6k8cGkIbSXE3Poqm0
	 Q5fz/fgyIBzme3FFt1WXS5EsMgcn834EQ9RSPIxq3y00OF72E2ViJDkRT88prOXxWN
	 ueZki51i+3vzA==
Date: Wed, 8 Jul 2026 01:23:04 -0600 (MDT)
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
Subject: Re: [PATCH v5 02/17] riscv: hwprobe.rst: Make indentation
 consistent
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-2-2c61f94a695a@gmail.com>
Message-ID: <a8c7d654-703b-4e2f-575f-32ef035f1117@kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com> <20260701-rva23u64-hwprobe-v2-v5-2-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Guodong Xu wrote:

> From: Andrew Jones <andrew.jones@oss.qualcomm.com>
> 
> A handful of vendor-extension entries indent continuation lines with a
> tab character, while the rest of hwprobe.rst uses spaces.  In addition,
> many list items align their continuation lines under the 'm' of
> ':c:macro:' (column 7) rather than under the item text (column 4), so
> the file mixes several indentation styles.
> 
> Replace the tabs with spaces and align every list item's continuation
> lines under the item text, giving the whole file one consistent style.
> 
> Whitespace-only change, no functional change.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> [Guodong: extend from tabs->spaces to normalizing all continuation-line
>  indentation across the file]
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Thanks, queued for v7.2-rc.


- Paul

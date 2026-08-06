Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8402E06EF;
	Thu,  6 Aug 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039565; cv=none; b=TIZJHnurYLVEYd0KskHfrI1k5esz6mK/UsRBtlUOunGKp72fw4nQQfr9GQVjCmn848d/kuzrS250DTseVaZqpLUS5ZcLXj+LLJWRycCs4bOs+QZeH0abWPkv6ZnXHgsbqbi0WxHDKMITAhOYDTnwY6Yi4+JDx64+QLiepzcS2Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039565; c=relaxed/simple;
	bh=KiYfHqCHFGmfrfJH+AeBviS8gL4ccQy1n2LBSmSt/Xg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qc3aXMXh59E3qGhvpXge6yQkXlL2zFFGKzOEsJG1k2+loTbYSNNP3b6DHr6xr3G5wx8fVzXirTr4pBVBlLVoJNOSk7KVg2lb8LCMq23lxMgLR7L0fyXTM9vTxGOtt1Ymq0hJiNdaw3aoPSZnw9Yd9GOKGGAGVTgsDMED5VRnPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILRYTfxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILRYTfxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B426A1F000E9;
	Thu,  6 Aug 2026 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786039563;
	bh=GXPgn1oZ8GLufiYOpYxHEAlYi2lmrI8rfY2EyqvnlW4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ILRYTfxuiYC2kZl9KdNkWRPvXSjr6MXA0bKS04Cnqir3xLyZGPYgshvgr0YLqEbtn
	 BIezdHZq8hSLipcKPUxQaCtvyt96Erm440ZAtBw1Ng7J20/OoBc+wHpGNED+JFr5lL
	 5HQnj8sm1MTHjAOLMyGchxjuo9m3PAdfArqsrJLnv51uJ2/LqYyO3K5+okVLZpniy4
	 ZuZlMqEl01CrRT3Y6/WrcIkE3x5X7e7mcZDrnroexrYTtUEr5+ky+svBNsEjwPgKLs
	 +QKJJe1PzWW/PpcEvKNloJSO5Zc3FZZykPZ1uMJIh/ZPp95DC4FVTMALmj2jVTTVdI
	 Z3feliwYyDR5A==
Date: Thu, 6 Aug 2026 12:05:58 -0600 (MDT)
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
    linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v5 04/17] riscv: Standardize extension capitalization
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-4-2c61f94a695a@gmail.com>
Message-ID: <59f93f2b-db1d-f7ff-d893-05dbca87b549@kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com> <20260701-rva23u64-hwprobe-v2-v5-4-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Guodong Xu wrote:

> From: Charlie Jenkins <charlie@rivosinc.com>
> 
> The base extensions are often lowercase and were written as lowercase in
> hwcap, but other references to these extensions in the kernel are
> uppercase. Standardize the case to make it easier to handle macro
> expansion.
> 
> Acked-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> [Apply KVM_ISA_EXT_ARR(), fixup all KVM use.]
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Thanks, queued for v7.3.

- Paul

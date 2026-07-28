Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F119379C38
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255964; cv=none; b=KghbqlOPNr5+a2TiSt75DDPH0/Qrkl5axNQ/HsCCoEcHOtkwNftVBUhOF5W7Xr1mVFkGTZRwnWv55YnQtApKHCtbYAPL/UYOc1muOD9TLOO0kv26osMyS0YuvAqFl9UncUxZmp2IXR0onJQZEBeohGCXUo95cOZhzSDTHUNmPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255964; c=relaxed/simple;
	bh=cXGsuhxvawCJhH1ijlMwlBJ8BtQ7Tub4R5UAY82z6ME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h1q6/jShE1mVgYHvRb29ZleuH9rRL2MKNC38r5aohL7qeDQsEylv4+HwwOsOpWXmMJ1kupUQIIdYgHx2mpdRK9budDBQvzd/f4pB9SmBQ11jLRToWCa3PhS7uI+QwouDVWFPMT433QnpUgUmrbzBTXZPvxtMCjIzTUJ0SAruKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJjvfRKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJjvfRKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C21F000E9;
	Tue, 28 Jul 2026 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255962;
	bh=TjQmY2wTlB3mjGRHZ0jd0r5CHkerBUOCTm2hJBYayyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJjvfRKf8It8FDggV6bvGsoEjTXgO+93faAmCO+OFpwOxSl8D0l8a3c4Bau5APACt
	 +ei3yoLNO3WSqBXjSLGOO25tfdq6eoijWBVOis19KIqKslvxrwwS8xQd5iKAk/AiBC
	 ic/iXPWtNVFJwHvc1ckSCZhgt4HAwPeR4CTKYrSGH9kP79hhSZvrLU4Elr0MGRplFQ
	 BNMxbRVw3G1XZXhJIDIhLWHyJw0cWgJrPkCQg5O8YO/tEr5nWAorSNQKFBrtw1GAfv
	 CERN1VnIFoUdZ6ptL/Aba9fLdBGcfh1ViDanmAV7TKail/aPy46wsfllb3Rf6r8bG1
	 KG35kz+gMOKjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] riscv: ptdump: Create ptdump.h and move
 declarations
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728161449.190058-2-fredwudi0305@gmail.com>
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
 <20260728161449.190058-1-fredwudi0305@gmail.com>
 <20260728161449.190058-2-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:26:01 +0000
Message-Id: <20260728162602.0D6C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Exporting the generic symbol `note_page` pollutes the kernel's glob=
al namespace.
--

--- Patch [1]: [PATCH v3 1/3] riscv: ptdump: Create ptdump.h and move decla=
rations ---
commit f9b97fdc17623863fd64f27ed80770e08d139f2a
Author: Dylan.Wu <fredwudi0305@gmail.com>

riscv: ptdump: Create ptdump.h and move declarations

This commit extracts page table dumping structures and level definitions
into a new header file, arch/riscv/include/asm/ptdump.h. It also exports
the note_page function for use by other kernel components like KVM.

> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index f4b4a9fcbbd88..d9a955b8a532d 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c

[ ... ]

> @@ -317,6 +280,7 @@ static void note_page(struct ptdump_state *pt_st, uns=
igned long addr,
>  		st->last_pa =3D pa;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(note_page);

[Severity: Low]
Does exporting this highly generic name (note_page) without an architectural
or subsystem prefix risk build or link collisions?

Since it is now in the global module namespace, should it be renamed with a
prefix like ptdump_ or riscv_ to avoid polluting the global namespace and
adhere to standard kernel naming conventions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728161449.1900=
58-1-fredwudi0305@gmail.com?part=3D1

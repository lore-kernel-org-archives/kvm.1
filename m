Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395953FFF82
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156063; cv=none; b=gpyqGjhZROqV1I8NEtaqBjlIyIqTfFtC5OBMfOQ8nR4tVJhNJr9JxZdRSqn83i+qcaQeAU/cCmEtygEYS9FlggPPsHmQdfbzw+67W47BEW/sqZO+yT0rl7UZ8I67vSxbSFpXiYo8FlQ+yqpT8XyXd2DnxkekoCdb2GdNW/dKi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156063; c=relaxed/simple;
	bh=vT5ibV5Ktvla8qTpOkxrOfAkUaDF6rbpoB9Rcr1iOD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N7bQcCTIBE6zSXv74BO3g5NI9hQxjbrDkX6ewR90Y0AIJSdvfAO0J/fLpXn5dvKxC48GY4XaPI1yJ0vYfi8odT/uOrUuthD6kRk/U0oBlvi9aayU3tXANKrC1DGBs3u6oN8ymtf+2eoTBCZCSwe4YOuED4PHNKePJRf/lrQUulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMLYlk4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMLYlk4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FB11F000E9;
	Mon, 27 Jul 2026 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785156061;
	bh=SBrcx1QyN1sj//hsQYmrecyZur6ecE3DlJ920/FY9D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMLYlk4T8tu0FI9rTOibXplPvjiL2JIPPL8mQDWOMnNPWEJ2flQ3m5/jzFdC6PN+L
	 Q+bkftfbbr/8zyQ/8HwJNMtz5YR9VrLDdeTvK7zkbZxwQcicpq9d4m75RpVkWSGyep
	 8GTIW2wossuR+yXaDF/VTYvpSfa1LiPEew9VE9mT0oYhpieIW35yEI7JNK0KSeF5je
	 l8o0fhzBNx7q28h1kvaI1lvEpLG+LE65jVhUmHMxwCm5jXacnPTr2gw+/moL91H32c
	 osj2HXV+UUsO3GbYlRyN/uw3ovgugYk4H+3KTbtM+MybbucA122TsI3Od+CdwKdf2R
	 rq6nvHD1t9hNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] riscv: ptdump: Create ptdump.h and move
 declarations
Reply-To: sashiko-reviews@lists.linux.dev
To: Dylan.Wu <fredwudi0305@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727123013.118984-2-fredwudi0305@gmail.com>
References: <20260727123013.118984-1-fredwudi0305@gmail.com>
 <20260727123013.118984-2-fredwudi0305@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 12:41:01 +0000
Message-Id: <20260727124101.A5FB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The refactoring to make ptdump reusable by other components (lik=
e KVM) is incomplete. The newly added fields `bits` and `num` in `struct pt=
dump_pg_level` are dead code, and `note_page()` hardcodes access to file-lo=
cal static arrays.
- [Low] The function `note_page` is exported globally with a highly generic=
 name, polluting the global namespace.
--

--- Patch [1]: [PATCH v2 1/3] riscv: ptdump: Create ptdump.h and move decla=
rations ---
commit 7ec3e13f790f5980858ebc9e23a4405735f7e6cf
Author: Dylan.Wu <fredwudi0305@gmail.com>

riscv: ptdump: Create ptdump.h and move declarations

Create a new arch/riscv/include/asm/ptdump.h header file and move the
pagetable walking state structures and level definitions there. This
allows other parts of the kernel (like KVM) to reuse the ptdump data
structures.

Also export the note_page() symbol so it can be used by other kernel
components.

> diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptd=
ump.h
> new file mode 100644
> index 0000000000000..eb9d11dab6098
> --- /dev/null
> +++ b/arch/riscv/include/asm/ptdump.h
> @@ -0,0 +1,41 @@
[ ... ]
> +struct ptdump_pg_level {
> +	const struct ptdump_prot_bits *bits;
> +	const char *name;
> +	u64 mask;
> +	int num;
> +};

[Severity: Medium]
Are the newly added fields bits and num essentially dead code?

The commit message indicates this refactoring allows other parts of the ker=
nel
(like KVM) to reuse the ptdump data structures. However, these new fields
appear to be unused.

For instance, dump_prot() in arch/riscv/mm/ptdump.c still unconditionally
iterates over the file-local pte_bits array rather than utilizing the
caller-provided bits. Additionally, note_page() continues to hardcode access
to the file-local pg_level array.

Does this incomplete refactoring prevent external components from dumping
page tables with custom layouts?

[ ... ]
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index f4b4a9fcbbd88..63655a9c8df3e 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
[ ... ]
> -static void note_page(struct ptdump_state *pt_st, unsigned long addr,
> -		      int level, u64 val)
> +void note_page(struct ptdump_state *pt_st, unsigned long addr,
> +	       int level, u64 val)
>  {
[ ... ]
> @@ -317,6 +280,7 @@ static void note_page(struct ptdump_state *pt_st, uns=
igned long addr,
>  		st->last_pa =3D pa;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(note_page);

[Severity: Low]
Does exporting this generically named function pollute the global kernel sy=
mbol
table?

Using a generic name like note_page() (instead of something specific like
riscv_ptdump_note_page) could increase the risk of linker collisions if ano=
ther
subsystem uses the same name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727123013.1189=
84-1-fredwudi0305@gmail.com?part=3D1

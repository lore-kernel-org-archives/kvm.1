Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5169330315
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482649; cv=none; b=PfUxvl4q1mWuB6uFXes68NYg5OUvZfROgrAvGwWn1zkGrCi760CgIQFGPmntwALvHf1svrZNB6dY4cFN1ksXRfoA1d4qGYi2RZaBwztaCQtyv2OwS8Ex66jwlNlzKc0+G43q18JCElTEe0UqNiBii3lsYyElFXsc0aKdzEYn3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482649; c=relaxed/simple;
	bh=Lwiguy7NALCYksCEODas6//u3AxPPckZ2ZZlqovjMvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l38rjcGUFhCog4CduZgTEWP0uiObidGWk7FRunj9cTyaGvjolFZwEZoPCXc8f0/rtwIqmOXMRyBxOW3BEcAkZwC5TAY5NGA3v3Aqs5QTV7QMsTmelhSw0p1eVCaYkHJH0PT+8hi3/kVfbAa+CIP2f/LALYSqVmVpWlKt5/nOe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzrvhkbR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzrvhkbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535251F000E9;
	Wed,  8 Jul 2026 03:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482648;
	bh=n9SX3b97J8QYGb8Qxs+EaqzFFsIy7BOz/nJu+z4u1ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EzrvhkbRjukwqhGIVKse9ZhbPyiN1BzbBpg0469uyFd6QPStQO4hLUWEtzV/XNt+c
	 pAJ2VkA9FXX6a3Etd2IQJNly9lwpVVRZK6W+Dhmd8XEwBlnBfnTrUoR3jlbaAvuOy1
	 pydEN/eZhNQl9dvrQXcrH8CINRJVob9iU2JFkLog9PfcdpeoRh8ugivGboNtsNaO1r
	 IHwXDfN2tBtxBaZY/olaR/Mt3o1b72bwt1ds+oZUAV1Y19CYpd+llopjw3AaJJE2ee
	 A6Ul+uGS/ejGNTF14YHwX3KTByd8f/JDotHmKhh/aWtk1aAD0btcbqtbE3uqig0LZp
	 /ByUZq/wWww/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/17] riscv: Introduce instruction table generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-1-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-1-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:50:47 +0000
Message-Id: <20260708035048.535251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Zcmp compressed instructions (e.g., `cm.*`) are incorrectly gene=
rated with 32-bit sizes instead of 16-bit.
- [Low] Unsupported instruction extraction stubs lack a return statement, c=
ausing `-Wreturn-type` build errors.
--

--- Patch [1]: [PATCH v3 01/17] riscv: Introduce instruction table generati=
on ---
commit 893d119e65d6edd9ce9e98809ffad3450c8d6a8f
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Introduce instruction table generation

This commit introduces a shell script to auto-generate a header from an
instruction table for RISC-V. It aims to replace hand-written instruction
macros.

Link: https://github.com/riscv-software-src/riscv-unified-db

> diff --git a/arch/riscv/tools/insn_tbl.sh b/arch/riscv/tools/insn_tbl.sh
> new file mode 100755
> index 0000000000000..f09b93951cde5
> --- /dev/null
> +++ b/arch/riscv/tools/insn_tbl.sh
> @@ -0,0 +1,258 @@

[ ... ]

> +        non_compressed_insn=3D${name##c.*}
> +        invalid_inst_functions=3D""
> +        variable_params=3D""
> +        constraints=3D""
> +        match=3D""
> +        mask=3D""
> +        make=3D""
> +
> +        # All compressed instructions start with "c."
> +        size=3D${non_compressed_insn:+32};
> +        size=3D${size:-16};

[Severity: Medium]
Will this correctly identify Zcmp compressed instructions like cm.pop?

Since they start with "cm." instead of "c.", the glob pattern c.* won't
match them, assigning them a 32-bit size instead of a 16-bit size. Could th=
is
cause the generated insert and extract helpers to wrongly expect u32 *
instead of u16 *?

[ ... ]

> +            printf "static __always_inline void riscv_insn_${formatted_i=
nst_name}_insert_${variable_name}(u${size} *${insn}, ${type}32 ${var})\n"
> +            printf "{\n"
> +            printf "\t*_insn &=3D ${insert_mask# & };\n"
> +            printf "\t*_insn |=3D ${insert# | };\n"
> +            printf "}\n"
> +
> +            if [ "${only_base}" ]; then
> +                invalid_inst_functions=3D"${invalid_inst_functions}stati=
c __always_inline ${type}${size} riscv_insn_${formatted_inst_name}_extract_=
${variable_name}(u${size} ${insn}) {\n\tBUILD_BUG_ON_MSG(1, \"${name} is no=
t supported on non ${only_base}-bit systems.\");\n}\n"
> +            fi

[Severity: Low]
Do these unsupported instruction extraction stubs need a return statement?

Since they have non-void return types, omitting a return could cause a build
failure due to -Werror=3Dreturn-type on supported architectures like RV32.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D1

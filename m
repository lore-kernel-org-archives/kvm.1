Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FC34EF0E
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101601; cv=none; b=Omokl9GmIl3Ts9r+RitEqXH4/8IIKsAJflSPpE6ZoWQwXiPz3bxNlcWnVAzl+QfvOv4/gcYx56TILyxDE4menLTpqQdAsN/Mw/BpesGhzTIN9tir+xeG4i+ym7hq1ChUy3q/oD5cab0XQntw2wpm3l6i4WL0erFwVoBwkz66lWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101601; c=relaxed/simple;
	bh=lhxGebDH70yVwpr9sTbkk5k8w4ieyRez4b+RFw1gjcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3QDjAzSwTVhKHg642E7eKn/tiJvtcS/mg50MP2AgcnI5eeB6gYGtanLQVMWFeQrqEOjZ8DDtK78wAKLE+1kevl6T6J5krF/OUEXzZRlielmt85Kgkrb2cYqDM5fSFEeT+G5Kk0jI22KlTK4U5OYBULgxeMRTSMg7x/ns1gGINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebeAYJ21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebeAYJ21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854F11F000E9;
	Mon, 22 Jun 2026 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782101599;
	bh=0NJ6bODKcRM2PfxQP7+tIYAAFFJmT7UtRbeg6pj3n6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebeAYJ21Xbu0nBxIX1v9NpFbCvIY+ibX12G84NhCnfC5JotKeQG6SmBOGUPugtXiY
	 ZYK7x+I3iJfldLjj12i60o+8q0a/VwFHv7ouB8Y8OvLPGk4hojJ6Y/wKElUOl1T10m
	 T92eiKOtQqyqqhz8dXvee0z0KBN6MokkGEWny1d5tEj9cSkRjgxYBnXuZbU2NzdSIO
	 3CmIWxkQihQxqvB37PZFBedbNF8+3BSs1mKma5491Dn4rsVHH+YGskuFxgpZTyNNg1
	 iVWGlV8MTT7XerhEYJM4oVI37WYMACCx/2wKizo4/F7GN8xPdWNJ2vdRgrACc0dPdi
	 50yok+sfwrHwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/16] riscv: Introduce instruction table generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-1-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-1-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:13:19 +0000
Message-Id: <20260622041319.854F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The shell script incorrectly truncates multiple instruction constr=
aints during bash parameter expansion, causing generated matchers to drop a=
ll but the first constraint.
- [High] Extracted immediate values for compressed instructions are incorre=
ctly truncated to 16 bits, corrupting instructions with large shifted immed=
iates like c.lui.
- [Low] The generated header relies on `sign_extend32` but fails to include=
 `<linux/bitops.h>`.
- [Low] Signed integer shift overflow when generating instruction masks and=
 matches.
--

commit 2e4d01f18f465b8609784ae2ae57f5539bddd357
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Introduce instruction table generation

Eliminate the need to hand-write riscv instructions by using a shell
script to autogenerate a header from an instruction table. This is modeled
after the syscall table infrastructure. The table is generated externally
by riscv-unified-db.

Link: https://github.com/riscv-software-src/riscv-unified-db

> diff --git a/arch/riscv/tools/insn_tbl.sh b/arch/riscv/tools/insn_tbl.sh
> new file mode 100755
> index 0000000000000..aede14c80146f
> --- /dev/null
> +++ b/arch/riscv/tools/insn_tbl.sh
> @@ -0,0 +1,256 @@

[ ... ]

> +echo "#ifndef RISCV_INSN_GEN_H" >> $outfile
> +echo "#define RISCV_INSN_GEN_H" >> $outfile
> +echo >> $outfile
> +
> +printf "#include <linux/bits.h>" >> $outfile
> +echo >> $outfile

[Severity: Low]
The generated header relies on sign_extend32() for signed fields, but only
includes <linux/bits.h>. Could this missing <linux/bitops.h> inclusion cause
compilation failures for future standalone inclusions of the generated head=
er?

[ ... ]

> +            if [ ${offset} -gt 0 ]; then
> +                s=3D" << ${offset}"
> +            else
> +                s=3D""
> +            fi
> +
> +            mask=3D"${mask}${s}"
> +
> +            match=3D"${match} | 0b${bits}${s}"

[Severity: Low]
Does this code trigger signed integer shift overflow warnings? The script
generates macros using signed binary literals shifted by large amounts
(e.g., 0b111000100000 << 20 for fclass.d). Even with -fno-strict-overflow,
this can cause compiler warnings if -Wshift-overflow is enabled. Would it be
better to append a U suffix to these binary literals to ensure unsigned
shifts?

[ ... ]

> +            if [ "${variable}" !=3D "${variable#*!}" ]; then
> +                raw_constraints=3D"${variable#*!}"
> +                raw_constraints=3D"${raw_constraints%%[=3D<~!]**}"

[Severity: High]
Does this parameter expansion inadvertently truncate multiple constraints?
Because the ! character is included in the character class [=3D<~!], the
%% operator greedily matches the longest suffix starting with the first !
it encounters.

For example, with c.ldsp which has constraints like xd!0!1!3!5!7=3D11-7, it
looks like this strips everything after the first !, leaving only 0. This
would cause the generated matcher to only verify that xd !=3D 0 and fail to
enforce the rest of the constraints.

[ ... ]

> +            if [ ${sign_extend} ]; then
> +                extract=3D"sign_extend32(${extract}, $((offset + left_sh=
ift - 1)))"
> +                type=3D"s"
> +            else
> +                type=3D"u"
> +            fi
> +
> +            printf "static __always_inline ${type}${size} riscv_insn_${f=
ormatted_inst_name}_extract_${variable_name}(u${size} ${insn})\n"

[Severity: High]
Does this return type cause unintended truncation for compressed instructio=
ns
with large immediates?

The script deduces the return type as s16 or u16 for compressed instruction=
s.
However, instructions like c.lui encode a 6-bit immediate shifted left by 1=
2,
resulting in an 18-bit signed value. It appears the generated function corr=
ectly
computes the 32-bit signed value, but returning it as s16 silently truncates
the upper 16 bits (including the sign bit). Could this cause data corruption
when decoding such instructions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D1

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3333B951;
	Wed, 10 Jun 2026 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106996; cv=none; b=e8SPdmcxcwzmILsWF+SnP4MeXNDRrYwmKy5pv2w1DqjtH3NiDxMfoELDn6ogzxqwAQZK/FD/s18YC+riAZlRgRjxMs3WoZk3Tf/EItqXDVAjq1hWNvdI9ttSuc3HgQrChAuKAB4p/Me0TIlzHlpe+HJJjs7f5AUGOOITS+kIYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106996; c=relaxed/simple;
	bh=yHnlfRfzdScgY+L6lCO63Nq6VBektdqv83HheroE71M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZC9jV3JOJVTVorK0R2dPgUplPlmQhCQj9kQNwkzdMs3E5e933Pdh/j0h7BIT/Kt9ER4nMXKQ1SefYQuznCD28ghbk/q20lUqP3VrLsbTUq6gQdcOIaZ2jZxGytNRcilNXGBcxKrAa2QrHglnb2c9nFvUq56/EIznM8B0CBFPNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Evzdm+SM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HzG5JS6i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Evzdm+SM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzG5JS6i"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781106986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msjhwjsuJi/htIU80DZBT36GfATEuBVhKi4XiG52gs8=;
	b=Evzdm+SMUac0KWBp/cSjFK4ibPrgnP+r5mKRPgQnPivfV4ERX9NRAyOQ5yu543SPvXmg5h
	yJAtK1t0KzFg+b8Uv9bz/Whm8ORmqCXerfUfGAoBvEOHHqpG1ZjMl/DVGIWUUgw3ehKjA8
	YEuA5NKVOeL7SEE3qt2+QH/88E7UkZ1cxv4/gt82Sr8lUYPK5RaqDIpz/AnAQJNjdr6dz0
	b79Kc4fVb6yQFzfE4F37jsmNrWmbm3yNKG89hEqFJNpAAoPhDfGnPl47moLlUPZpX2sgTO
	ZX02s59l5CieC6vsqboDL1jvp/5At+Yu0wlxI5s1r6RrDBUdXrTe4621WGAIJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781106986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msjhwjsuJi/htIU80DZBT36GfATEuBVhKi4XiG52gs8=;
	b=HzG5JS6iQRXS2PQdNGQVgSzLFt0ZH82WyaHCRre7c3gkPL0HlgAN+iMasP7WUDwalbAl1s
	ZM7DaVfLKgoCAYBg==
To: Charlie Jenkins via B4 Relay
 <devnull+thecharlesjenkins.gmail.com@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Charlie Jenkins
 <thecharlesjenkins@gmail.com>
Subject: Re: [PATCH 01/16] riscv: Introduce instruction table generation
In-Reply-To: <20260407-riscv_insn_table-v1-1-54b4736a1e77@gmail.com>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-1-54b4736a1e77@gmail.com>
Date: Wed, 10 Jun 2026 17:56:25 +0200
Message-ID: <878q8m1j9y.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> From: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> Eliminate the need to hand-write riscv instructions by using a shell
> script to autogenerate a header from an instruction table. This is modeled
> after the syscall table infrastructure.
>
> The table is generated externally by riscv-unified-db [1], but is
> in a simple format to make it possible to use other tools or modify
> manually.
>
> [1] https://github.com/riscv-software-src/riscv-unified-db
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Thanks for the work, I really like the idea. This will make it much
easier to maintain the instruction stuffs.

> +c.ld common,32 011<13|00<0 imm<3=6-5|12-10 xd!1!3!5!7=4-2 xs1=9-7
> +c.ld common,64 011<13|00<0 imm<3=6-5|12-10 xd=4-2 xs1=9-7

Not sure if I confuse something, but the spec says "C.LD is an
RV64C-only instruction". Why do we have 32 here?

> +echo "#define COMMA ," >> $outfile
> +echo "#define SEMICOLON ;" >> $outfile
> +echo "#define SINGLE_ARG(...) __VA_ARGS__" >> $outfile

Aren't these macro unused?

> +echo >> $outfile
> +
> +grep -E "^[a-z\.0-9]+[[:space:]]+" "$infile" | {
> +    while read name base fixed variables; do
> +        echo "/* $name */"
> +
> +        compressed_name=${name##c.*}
	   ^^^^^^^^^^^^^^^
	   this name is misleading

> +        invalid_inst_functions=""
> +        variable_params=""
> +        constraints=""
> +        match=""
> +        mask=""
> +        make=""
> +
> +        # All compressed instructions start with "c."
> +        size=${compressed_name:+32};
> +        size=${size:-16};
> +
> +        # Replace all . with _
> +        formatted_inst_name=$name
> +        while [ ! ${formatted_inst_name##*.*} ]; do
> +            prefix=${formatted_inst_name%.*}
> +            suffix=${formatted_inst_name##*.}
> +            contains_dot=${formatted_inst_name##*.*}
> +            formatted_inst_name=${contains_dot:-${prefix}_${suffix}}
> +        done

Does the simplier
     formatted_inst_name=$(echo $name | tr '.' '_')
work?

> +            echo "static __always_inline ${type}${size} riscv_insn_${formatted_inst_name}_extract_${variable_name}(u${size} ${insn})"
> +            echo "{"
> +            echo "\treturn ${extract};"
> +            echo "}"
> +            echo "static __always_inline void riscv_insn_${formatted_inst_name}_insert_${variable_name}(u${size} *${insn}, ${type}32 ${var})"
> +            echo "{"
> +            echo "\t*_insn &= ${insert_mask# & };"

Why is this required? Isn't this part always zero at this point?

> +            echo "\t*_insn |= ${insert# | };"
> +            echo "}"
> +
> +            if [ "${only_base}" ]; then
> +                invalid_inst_functions="${invalid_inst_functions}static __always_inline ${type}${size} riscv_insn_${formatted_inst_name}_extract_${variable_name}(u${size} ${insn}) {\n\tpanic(\"${name} is not supported on non ${only_base}-bit systems.\");\n}\n"

Instead of panic(), can we do BUILD_BUG() instead?

Nam

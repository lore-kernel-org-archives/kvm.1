Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210261D798E
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139973; cv=none; b=JkhFoBCeLak8WCVGDlNYoPBLJpWAJHcEXsLbR8LBQ0nvbhR5DCgXFuex1aHx0CPFezXyGaNOwbDkdkL7Gb72Vxst7S/O/DJLyz4XmP+HBA12KX9zJ5NUY7KFQXRaiQbS+1uflaNYZLeOXojDrUpRGRFvZ4Aoco99JMEFzCQptZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139973; c=relaxed/simple;
	bh=tlYJdwjt2jvaFbKtXeL1njWq773Cas3GWF5HwbmzqD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+NkuImjfOhkCyxijvPXOfpelTXni07aIZW0neGmiPvP9PXTRM4LQ7D4cx0FPUouA5Ysfw0wsa5eNMUCDdkB7bdTrbgnUYmL7O3Ozn3mbm62rr2wXbkh+t/F/6CGEOGEzRYe16YTJi4tD3yA1Eosmlv5Trda5f3Y0VALbDyy60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvWWnYEm; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvWWnYEm"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304d7f31215so6677826eec.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781139971; x=1781744771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VboLQNAR8iiox5vG6qq6qNpSq+23FwPh2uptUxiLAaw=;
        b=FvWWnYEmq470Eysdd1SKG1uDMRxao45PEzCSOo8EULrYfZQUCHdM7kQmoyaoEbSduM
         6qSsdIJEmKebx4cb8rBjAF4kuxWnqWFyjGiRWgC9tGQjo+aTGbgnroCE3P9ZJWE6GEDA
         u1fwRpm+VhCY1Clfb5vh1sfdIsZ91iVd6mYjIHuJEl+unbxhFRrwktegfqFnweFeho/1
         G7MFG3yPRbbbWTBkXKHuroc6cffuGismDTOyp7lLiDIF3Fq1FogNtIRt77vgt6FKH+pk
         mZLn3RHACK2p63Iv//anLvD5cNCnoioDCXxUvorKyZ4De4E2ADzGki7w3mGhRBM9BC2w
         1cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781139971; x=1781744771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VboLQNAR8iiox5vG6qq6qNpSq+23FwPh2uptUxiLAaw=;
        b=ctS0id/DF+YD89GR6CCkmdGL7vWugwq5O9pofE9QJCPrmqSpsswuu4PFa/S6xph/bF
         G5A4raCvyV3kmD6VN79gB5I0wZYQjgDEi5Xl7MijJML80/+8itJzn/0hUd1VekUz4A8R
         29vC+MyyX+h2V+5x7NyA/FaLpkS1cf1rfuUOM7RUdzdavVX9j2/rPihq13udZPnH9T1I
         Hnqzz3J9C/hc+GEVxLcKTu03lwkNa3CfQ/9GuQfF62reUoZSdHD8flvXmvl8gGPj2YP2
         TKhWvH9jSXtP8QSfTs/KpaRL/264nY532oDm0f8p85ymntEJc5JJ8R+iu2dVPd1Fs3HU
         byUw==
X-Forwarded-Encrypted: i=1; AFNElJ8jgBqY97VD0qWDxT7ZzUnZga8kuVOwuNV50PIvB0Nobw0K8DAK4porQrtG6AME/yFlv0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAoHLSEPz1/56gmLrUY0R3iPop2EGc/mG1Px++mHrphxwDY4b
	SROCpWU+KWtenlDzKVBBJFr4084/ZDcpK9DkqIdvOHJGNVHoXGBVVGLy
X-Gm-Gg: Acq92OEw0zbGJS6NreWV6Ca/kjzCK7XGLORCBUDFHStvDcRSuFA04PsK2QV71gzgRVI
	xJco0rvP8rvxy3QsC2zd/99FHdD5i4suhR+T3b/fjQc//1LdLzJSuXyulTMuKt0ufHR2uyuFaBv
	egWo0uOlP7mEjSJg7G/VwAauWGtSE+t4ZeBPT+uD59CBsuRQ6+Lt7+Xj4Hu5UXqphVqnvLd0K+4
	XxBnVyawE6KSjQK6w8S/YIrwj2Yqczl0OgnDgxe8wu5Ith7D92lrU6z03u1jXirbJOoNUvbLUjA
	M9pstqRkDPNdQhs5n9JNdo+xlWaIFAPfb/TQpr7yz/TGBv67ESF7V+7ZiGfwF9Na5j3WhuTPBuF
	II4oy+YHg4I5UXSgzyDZCy5mcZn5qkhbO8JmqGKGuAXQCgj+rzPdo9ZABQdX+Xzusa/z9NcM/wY
	ViKNgOZd7UPchQlLxe3dLKHQ==
X-Received: by 2002:a05:7300:510:b0:2f3:986d:2d01 with SMTP id 5a478bee46e88-30804bbdd85mr548716eec.19.1781139971040;
        Wed, 10 Jun 2026 18:06:11 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806ebb79bsm71245eec.25.2026.06.10.18.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:06:10 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:06:07 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Conor Dooley <conor@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/16] riscv: Introduce instruction table generation
Message-ID: <aioJ_5SIXdGQg55R@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-1-54b4736a1e77@gmail.com>
 <878q8m1j9y.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q8m1j9y.fsf@yellow.woof>

On Wed, Jun 10, 2026 at 05:56:25PM +0200, Nam Cao wrote:
> Charlie Jenkins via B4 Relay
> <devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> > From: Charlie Jenkins <thecharlesjenkins@gmail.com>
> >
> > Eliminate the need to hand-write riscv instructions by using a shell
> > script to autogenerate a header from an instruction table. This is modeled
> > after the syscall table infrastructure.
> >
> > The table is generated externally by riscv-unified-db [1], but is
> > in a simple format to make it possible to use other tools or modify
> > manually.
> >
> > [1] https://github.com/riscv-software-src/riscv-unified-db
> >
> > Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> 
> Thanks for the work, I really like the idea. This will make it much
> easier to maintain the instruction stuffs.
> 
> > +c.ld common,32 011<13|00<0 imm<3=6-5|12-10 xd!1!3!5!7=4-2 xs1=9-7
> > +c.ld common,64 011<13|00<0 imm<3=6-5|12-10 xd=4-2 xs1=9-7
> 
> Not sure if I confuse something, but the spec says "C.LD is an
> RV64C-only instruction". Why do we have 32 here?

This is a weird one. The Ziclsd extension introduces it for RV32[1]. All
of the data is generated from the riscv-unified-db and because it is in
the Ziclsd extension, c.ld is included for 32-bit in the c.ld
description [2]. 

[1] https://docs.riscv.org/reference/isa/extensions/zilsd/_attachments/riscv-zilsd.pdf
[2] https://github.com/riscv/riscv-unified-db/blob/main/spec/std/isa/inst/C/c.ld.yaml

> 
> > +echo "#define COMMA ," >> $outfile
> > +echo "#define SEMICOLON ;" >> $outfile
> > +echo "#define SINGLE_ARG(...) __VA_ARGS__" >> $outfile
> 
> Aren't these macro unused?

Yes thanks, I had them for an earlier version and never removed them.

> 
> > +echo >> $outfile
> > +
> > +grep -E "^[a-z\.0-9]+[[:space:]]+" "$infile" | {
> > +    while read name base fixed variables; do
> > +        echo "/* $name */"
> > +
> > +        compressed_name=${name##c.*}
> 	   ^^^^^^^^^^^^^^^
> 	   this name is misleading

That's fair, I can rename it to be something like "compressed_inst"?

> 
> > +        invalid_inst_functions=""
> > +        variable_params=""
> > +        constraints=""
> > +        match=""
> > +        mask=""
> > +        make=""
> > +
> > +        # All compressed instructions start with "c."
> > +        size=${compressed_name:+32};
> > +        size=${size:-16};
> > +
> > +        # Replace all . with _
> > +        formatted_inst_name=$name
> > +        while [ ! ${formatted_inst_name##*.*} ]; do
> > +            prefix=${formatted_inst_name%.*}
> > +            suffix=${formatted_inst_name##*.}
> > +            contains_dot=${formatted_inst_name##*.*}
> > +            formatted_inst_name=${contains_dot:-${prefix}_${suffix}}
> > +        done
> 
> Does the simplier
>      formatted_inst_name=$(echo $name | tr '.' '_')
> work?

That does work, but it dramatically slows down the time. I was trying to
avoid using external programs because this is called on every
compilation and there are a lot of instructions to parse. On my system,
it's about 10x slower to use echo/tr. Taking the time from about 150us
to 1.5ms for each iteration and the total time from around 0.8s to
around 3.5s.

> 
> > +            echo "static __always_inline ${type}${size} riscv_insn_${formatted_inst_name}_extract_${variable_name}(u${size} ${insn})"
> > +            echo "{"
> > +            echo "\treturn ${extract};"
> > +            echo "}"
> > +            echo "static __always_inline void riscv_insn_${formatted_inst_name}_insert_${variable_name}(u${size} *${insn}, ${type}32 ${var})"
> > +            echo "{"
> > +            echo "\t*_insn &= ${insert_mask# & };"
> 
> Why is this required? Isn't this part always zero at this point?
> 
> > +            echo "\t*_insn |= ${insert# | };"
> > +            echo "}"
> > +
> > +            if [ "${only_base}" ]; then
> > +                invalid_inst_functions="${invalid_inst_functions}static __always_inline ${type}${size} riscv_insn_${formatted_inst_name}_extract_${variable_name}(u${size} ${insn}) {\n\tpanic(\"${name} is not supported on non ${only_base}-bit systems.\");\n}\n"
> 
> Instead of panic(), can we do BUILD_BUG() instead?

That's a better solution :)

- Charlie

> 
> Nam

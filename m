Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142121ABBB
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782868657; cv=none; b=GD6WEBrNbVg2ckAEGELZIHivDxtMSGH9CtPS3j1OOQigtDp4etLI/TvjvQaAqrvK75JakfZw+P0F13Zz85USWGVbWNSu86fySM3oSxi3il0r9ywYTuJ1Z5kLbJmEazn/d2ZfXFx+K6BlOUCVaHIWOKb5Q9175JIwXgODVa9bJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782868657; c=relaxed/simple;
	bh=CQHsEGW6uZDOfOIxjkX8MPVwgmPkCXJJaYhoUHPiLVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQMZsqPL2lbujWLOMC5EJLbh1ZpiMiukRv4xukqVHvDuGEWNtS8QggmRKhHWxu3mgBHC1ZMJ08CNgJlkSYtf7E0m+7BUWeDJPeR754NgHYL1yWmYulKqY0sjxqoaGvP5QqIJ2EbJ1WERSBTT00gie88+vF5TLLjwTcIYFCgN/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdP4VqQH; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdP4VqQH"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c591fb1cbso95040eec.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782868655; x=1783473455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtMWeNmrDijSuvzYdFzBzIe5+kn8Pd5DLzMwnJd/LPU=;
        b=rdP4VqQHjKzL/JPrPBncu9cZE3Dse7xDbt8zAB1IK9X2kTxYyA8acIbc+cFzR8YMLl
         wsxQXe4JPpfG5cdMvEhmz8byHpr8ZRyXeq34dhiNiD0Z3tPWx57wXYV6RObyYDPK1+S9
         Sj4vuCvV27GUbDkP8b+AFHfXwbw7nS4geuQgU8X60YUynh+d9VqxapOw83eSd6EtHPxp
         WrnpxlcqTfkexJQyHxaVVu0o+6dxGwxe3UmeX//FthYjFQqmmBdtsz/2c9iUNAa8nHis
         kD+vkVMsw0V++fOpSl0KfpG5mXL/9tNsTryX8SlmEJSPipu7ZPVNXVrmWb4wXtMrqi0M
         CWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782868655; x=1783473455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtMWeNmrDijSuvzYdFzBzIe5+kn8Pd5DLzMwnJd/LPU=;
        b=rUk2995IWvsdtrlC4Q4kF0tH/2aA0UyyWZYeEOTeDWXeo9chCpmE70XWWSCf/6W+p0
         Omo5RkN82EIB1rE5wantKa2ZybBQRJIhoUwfnf+6/iJwdkZICG1y0bSN/MiAujOnCpy8
         OJB73jZaze02yj75jCyM6l3+H8YqT3VZEgYMoQOuXi4JEU9itQ5I6eZO5XIDZqAqdrVo
         Et6julRXOc8d/lqVNGg+jGZ7nT0BuYQTgugHW5niTyyVua7Wua5fX37zrE7wQw4W3Cua
         bZIF1lhJ+sQ4hgnc3LLnhfblSOEopJCRyNq6RO3oyrIwlQ+36dSEMr2paW9g/oJPy7wZ
         3rtA==
X-Forwarded-Encrypted: i=1; AHgh+RqKYX7UZMj7xSikoiS2xKTTZ85quLWYRh4mfJgJqjqXEumRsRxoJhVpM2bKf38OvXP3CW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxk+XBt3Jx5g+xc+kmOie5gdr0uhckFr8SGTcwxRaXOcXyDjYo
	PPVOiixBHlCb2O62nu8pckIwgmfPXIwR0kCqDvJL96zyPQoBBRP+9k9h
X-Gm-Gg: AfdE7clG7MEkMx8GXK55BeyEJJX8fRqBcAzjMxkEO8yz/WesUTt0/eYXNLLOwsWBbDv
	jjh4xPZqNP3diAzfjTPKdrLjTin0h1v8ydwKOcZPdPYzM6ArKOkNNYA2lhCYVDzWhGMBFI3S8oP
	/XYowbZjDGFkKDiqpBsU1kWx4Yil4+qTMZkfYdcB0+wrRczvP2QAtA7ioJW9D6hrRpfQpXAJmWC
	YlExAeL2scxVMg6tmXh79tfcRny2WBnoSdLRAJNjAAjdvLQS1U7ebV6nP+tJVvx61MBbSbBOMTh
	07Q2bkdVv5We+fJsS+CFv1GmXMudmhBaczuG/ft363rQp1phG4qUsdDA9dejZmWeLNE/AJvosHS
	HlVfHVfc51bplGqMBKhbVd7pq+/j46+T2SGjczVml3+jXF7yvidXU6rYc+DKtqJVsMFja3cnjbh
	2oxJSsHW2aKRtTjDhrWwfWH9AfvU3/UfT6CnKzR1SJ21c=
X-Received: by 2002:a05:7300:fd13:b0:30c:9f31:b62a with SMTP id 5a478bee46e88-30ef084fd6bmr2062142eec.10.1782868654974;
        Tue, 30 Jun 2026 18:17:34 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30efaadc5bfsm940139eec.28.2026.06.30.18.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:17:34 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:17:31 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Conor Dooley <conor@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/16] riscv: Introduce instruction table generation
Message-ID: <akRqqxVMmzCJUpxp@blinky>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-1-7f0810ee2274@gmail.com>
 <DJMJB4B8Q57Y.34SUOKB6MD8IE@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJMJB4B8Q57Y.34SUOKB6MD8IE@oss.qualcomm.com>

On Tue, Jun 30, 2026 at 06:45:51PM +0200, Radim Krčmář wrote:
> 2026-06-21T21:01:19-07:00, Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>:
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
> >
> > ---
> > diff --git a/arch/riscv/tools/insn.tbl b/arch/riscv/tools/insn.tbl
> > @@ -0,0 +1,1392 @@
> > +# SPDX-License-Identifier: BSD-3-Clause-Clear
> > +#
> > +# GENERATED WITH https://github.com/riscv-software-src/riscv-unified-db
> > +# "./bin/generate inst-table -o test_table.txt"
> 
> I checked out the repo, ran the command, and got a different table:
> 
> > +andn common 0100000<25|111<12|0110011<0 xs2=24-20 xs1=19-15 xd=11-7
>    andn common 0100000<31|111<14|0110011<7 xs2=24-20 xs1=19-15 xd=11-7
> 
> I assume there were some recent changes in the output format...
> 
> I think it would be nice to use their latest format and also note the
> UDB commit that was used, so it's easier to reproduce our file.
> Hopefully there won't be breaking changes too often. :)

I have a PR open to fix this bug that I missed when it got merged, once
that gets merged I can link the hash and there will no longer be this
mismatch.

> 
> Thanks.
> 
> ---
> Sashiko seems to have noticed a plenty of other issues, so I didn't
> review more...

Oh thanks, I'll check that out.

- Charlie


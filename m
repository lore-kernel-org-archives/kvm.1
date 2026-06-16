Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB23DA7C6
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589996; cv=none; b=PczIVStpravx04lp9Dh57NbAf57YQ1B3X8ybUuVyGwz+HstPyjOqEeU369xdNTZYExaoaBmy5j2iyYnO5wf/irwVez26c1OyTcrv9s/0Q+5ruuYWXlqdEIb1XcNlVAUIk/fx9jny8vJLysTZiV7ZvB95jKtXGufCgvu4Kn7FtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589996; c=relaxed/simple;
	bh=mePsKDgnT7KOddPsWmdqbXoE1a6nKcnpxg0gh2nBVl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1w6pXht/UdDswF/FktjG9ETfRsJKlFuD3O4nOkp/no3aOusJpjVyKtv+HdZNVpHkOe8pMKrkchNcw02keKkCSEoV24olcw4RB+i/I1RBabquJTHeV1k0jA6uT5fncqHSl7mmq2feTwikZUfu28Bkr9rOE9lsCZrOvPc6SR4QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsRXjzhh; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsRXjzhh"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13721dfd471so4560541c88.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781589995; x=1782194795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYT2HIZ/TljEaPuQNyUPwKuwE+O4A3F++I0Be4tA0UM=;
        b=UsRXjzhh/OPRjISmvTo/9WfMbQdKEGrdt3absXsOCVkL+IU9aoHRe/USl0dQD1RCiW
         AhYg/uwMkg+blc9s/8JI3jwvDyfgh3zV9SraUR/NwCgPUNdumH5nJevwgpKBDdus3Qt7
         jAGQ+9rUQCBx641pyaBNpkFtqwDZlL+XXje9JET9IW35adAKfQwhGxsdldxUbUHF+X2k
         QayaiDrJdCF4/+lLViZSpatRRNy+T2sLPpLG+1tZq2vq3zSvZz5mWCvo8ByHNvvho3F/
         BeNSb3eEfXLL64YEANpULqntGFHZvUaTB0hVCCAJxnRYaYZB4FIooebNzbQSdKlqg1q9
         P3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589995; x=1782194795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYT2HIZ/TljEaPuQNyUPwKuwE+O4A3F++I0Be4tA0UM=;
        b=P6Oql+1XQxlbsIcaY18bLWl5B3VxToAHGOjJWdRzEf5t3LHwRXmniEQ9vDVAKhVVh2
         vPkm6m+3spGKJiFkWdx4EQRJ+U3eUcm8zNSch1mXH1dDBmObOXlLLVeBLHEEgClQfDGd
         kWqOwGIGNKLNx8xCx2qOToJiWr0kkk58CvrHRo31iCNTQUz1k1zVgNRZeI/W+HMnBa7R
         LEwi3Ce1ix7FpoVXWB/zR17b/k4zFBTdqxIUuPjY9Lad/6ZZ7Bivn6rmYfI6mmOQyIK7
         XflOJn2Xj6BBx//V29QyIUxJKQsbBz0a5PU0HvIzc6BsbUOKGG36wemfkTvMORSEVUl5
         2oZg==
X-Forwarded-Encrypted: i=1; AFNElJ8YlEJPkZJ4+1kjlZX4fzUbvb83hT7luBncPst3gJPu0f2IjfHJnX9fnaW5KfDElCXZDGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhBkPvBEj0vrrC6lNCgjMfs1cJo7aSo47VMikwD9KttwQKQb5
	2HPuO+Ve8fOErNS84FE3UbT7YV4K8zWSYiHh5IYc60SjLwKGQVmJXfQK
X-Gm-Gg: Acq92OEEqXN7gkkyhpAPaBfwQ2t8KG9wAZLajER/Il31acavjsqUx/tCJRIdfOdt5iS
	BW6CzVvoVg9rrh+eg0aODdqTuVsdUd2lByGkRTbR+0TMGu4O8J4BRxjCuKQYps087IreAA2Di20
	AJVwwbbphLXSNQgdCDgW1rlSvG2Xq4M4iQKz5OpIvpgWuU/n2yyBlyRaGkl3LNGjmxBLKFD8ykg
	NpQCAtKjLWewlszboivXKwuJDx/bEKAw4sQqlZTMeSUfJWjkFP3uAdPejw6XwtCcSRXASCHkURW
	zZqsbwhPjiUyuNniOukgaWyA14/+qExo5V6LSYe6v9bY+F16eUwFbfuzTwP0wwBiIwS1jb/P+oQ
	lv9avFdHyiX360+N0UcRA1julvzSwzr+a9abqJSHH5zvNQHuCeDx0DQIFyz0/8q29ixsQsJqhAN
	XY5r5CeSyTak0=
X-Received: by 2002:a05:7022:305:b0:136:b370:64de with SMTP id a92af1059eb24-1387901e454mr5481988c88.32.1781589994812;
        Mon, 15 Jun 2026 23:06:34 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b96d6c4sm12930812c88.9.2026.06.15.23.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:06:33 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:06:30 -0700
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
Subject: Re: [PATCH 04/16] riscv: kprobes: Use generated instruction headers
Message-ID: <ajDn5oINgUzKhELv@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-4-54b4736a1e77@gmail.com>
 <87mrx1eh8c.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mrx1eh8c.fsf@yellow.woof>

On Thu, Jun 11, 2026 at 08:14:27AM +0200, Nam Cao wrote:
> Charlie Jenkins via B4 Relay
> <devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> >  bool __kprobes simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs)
> >  {
> > -	return simulate_c_jr_jalr(opcode, addr, regs, false);
> > +	unsigned long next_addr;
> > +	unsigned long *regs_ptr = (unsigned long *)regs;
> > +
> > +	next_addr = regs_ptr[riscv_insn_c_jr_extract_xs1(opcode)];
> > +	instruction_pointer_set(regs, next_addr);
> > +
> > +	regs->ra = addr + 2;
> 
> c.jr does not change ra.

Looks like my tests need some work :/

> 
> > +	return true;
> >  }
> 
> We have CONFIG_RISCV_KPROBES_KUNIT now, please try that.

I can try to extend those to cover more.

- Charlie

> 
> Nam

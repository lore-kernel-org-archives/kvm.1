Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0F3CF1EF
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767891; cv=none; b=cMaPKbgcfBnVHILc8LduHGmdkFn3YAL0wmFRJMA2c1o+cMBLLQL+uvDy/aLD0f+wFdEyJFgxjwDVdHdV+dldyKVdCDi4czuCaTK2toW7LbvuhxIvZkdQgFn6ahUW3aCylnD1WJg4tGoA98ba+Eo1LLAfDSIxvLHnrTDK0ip0KaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767891; c=relaxed/simple;
	bh=6gHDvb/XrBCDo3iaQ/AtRzRqDsBx2bBZl2E9ZY6BymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up1TbQU6GoC/a4iJ0EeEu4zzxOYw/vJq1CsRuObRlQ5ydCyub4oCuGJs1RbQGGgGwW4gbmBcyUHhzpznvlkcbp620PRpiVKrv1e7uWzmYaA1TZHSrpt0ENQYn+z5gnD1TKyPwCGhh4kiyhpkIUdMtqsFDlXIcSW/Yfmf4W6JM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUtrcoHh; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUtrcoHh"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13988680a69so1613858c88.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781767889; x=1782372689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSCBYXCt65DixNVaZdVjTYa+6C9GG/pjQw7EWmlt+FE=;
        b=bUtrcoHheHon0sIWso36YfkDKPe8BXeruJEAqsn5C+L/TYzyFLZfH6cojIT2M6q8Hq
         dxTWRJjU34F+FPq+BAMdq/1yLtJom9UJ4LEylhwvqKEZWMkFyLg0HxCIwB/MZ7nUdkww
         rtdLz30KacYrfNyn8RXaIHQNjgGhKre8rdVAtFwyTpLv8iDN7zvEytMgO0icKRkPulNO
         u34XA/9AaBoCmT86nQeUfF/9vtL8imPRNFKXf9zPRSVNlp7+nxhOAedqdDQbOUrnqRI/
         pvbEo+v0OlCeMg3Mc80sNMaB872sBUCGqWljD7/+Z3s6k42TCaM2OlYD5oAvHdGm2osj
         GToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781767889; x=1782372689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSCBYXCt65DixNVaZdVjTYa+6C9GG/pjQw7EWmlt+FE=;
        b=oMUZj18AbXCivaPihUjHFQcubM3qoZ6DrnU+lMmQrhRSVJCSPBbRZHLonvmoC/ejNS
         BcwZqlPYp3yyv4wUZ5e1cRqK8O3hLL1j7sbXr/H0V2Y60I923D/JHAPiC+TzmWxEUEX2
         yt8eMlW3/2BJDAtG6uEAKpGM7BFJXwpQcLvxpdUYyqGApE1mEkmUIdHKoJEw+iEK8HHt
         KbU4fmz7ufU43CAbpYWhez0BjmfEQiqFcfZOTjhjAVbec6ISGKcdoLxJqK9OMDlfeL0l
         KzsLIIGoc75iVP3jC5xM2eu+iYO/UE1IIFUTE8fNX0YjUSc5sUxbhBW3mfyFnwY8lcxq
         rTjA==
X-Forwarded-Encrypted: i=1; AFNElJ8MBtXjwQe0f/4yXCfZ2FNPZWS+k25PBRtEqHd5GEK2WpHmBA4ajWdtE2UT/P9oVy9SFe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUWJdNRUvvNcRk63kl96vHIDxGvDAqLFLZnPzHyMVmP3DBbDi
	V6HMjtreo9vNQgCUzy1Upw/FUaGkLtcdGBICZZntEwhFqZg7kXQ8QISv
X-Gm-Gg: AfdE7ck0lHJqEdzXtYso9o/e5EiDGrW0BWxydiAI+BWl5bfqEaaUEmmPLJExDbgePfc
	rR/MaSdl04fokfOoUVzeqvAFNCnOojT4vnZWj6terEibhA56pMPPSSStY4ypuHqTV2qCBZdXN6V
	rvaRac5kiCiv9XF6rNUQQXQsIOVQzhk3pq+7f5WZP+s2JYfDYfT0HO52Re5TwMpZKIc3zdRK9/C
	J7E9hyB/seIx+cnHsW5c0va8qwSgvu2okDyoppzaFRx9m3U2TlCtvJRricd1NOioiPFwvKu73Ry
	vjZmj/K3Fnp2LO5aWdKIOSHuj/zG1ghGypqfl7Z5+w5XmeNOqIIPDXFaKF1s7CF1uoFEE+1z5K0
	jZDZas6h868l7DhnSRqRZN2lSxGJtc7wLRRG7fHWl8Czy7qrjMhWzWVYqx7lIuZ1EIKCkHFP5DE
	w/
X-Received: by 2002:a05:7301:1286:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-30bf0a2bcf7mr1930579eec.34.1781767888969;
        Thu, 18 Jun 2026 00:31:28 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bbbd636fasm7319764eec.22.2026.06.18.00.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:31:28 -0700 (PDT)
Date: Thu, 18 Jun 2026 00:31:26 -0700
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
Message-ID: <ajOezhejx7PcOw_x@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-4-54b4736a1e77@gmail.com>
 <87jys5egum.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jys5egum.fsf@yellow.woof>

On Thu, Jun 11, 2026 at 08:22:41AM +0200, Nam Cao wrote:
> Charlie Jenkins via B4 Relay
> <devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> > This was again verified by checking all 32-bit values for each of these
> > functions and checking that the two version have the same behavior.
> 
> Your checking is missing some cases. branch instructions and c.jr are
> broken.
> 
> Btw, any chance that check can be added as a new kunit test case? I
> wrote the CONFIG_RISCV_KPROBES_KUNIT, but that only tests some values.

Okay I looked back over my test cases and realized my mistakes. I was
iterating through all possible 32-bit values and passing them into the
new simulate_* functions and comparing the register state to the old
simulate_* instructions. I missed the _pc + addr bug because the _pc
value I was using was 0. I missed the simulate_c_jr ra bug because I was
not checking ra.


Since I was checking against the previous version it's not possible to
do a straight one-to-one conversion to the kunit. I think it might be
possible to do something similar but I will need to mess with that to
determine a good way of doing it.

- Charlie

> 
> Nam

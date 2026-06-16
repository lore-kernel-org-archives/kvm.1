Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512A3D6CC3
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589511; cv=none; b=Z5OQzYKIyoCsTQFZssL0deTmXrDJF6EpguRxpESvecUHFgLPpAU+sT2SKUL+w+d+PvrLyqdrssMftQtosdWHqj7EOu2DRiodf5fGv7/+dsnu7eQ7B4kHYp/B/gCpTf6mSf6BiGeKGHlnBEOwV2FPv5pjXjaTNAWueq9HyAHIcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589511; c=relaxed/simple;
	bh=pjMEfY3K+/Xw+PmVqjvzMCI+L/T2uYNTTllsMVPPgSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJJHj4exxbqSDkQDMggIqsDA7IOFEjNdnUYNxDlVgq0kcmiVSQ+wIL6ES78X/KbekJseb4MnGZAAVkYX8ioUY3mVuAmPSMYfRk+aTbnm4Ev8eZB5ZWCmDY/ys4JeaPU24xbM3zZrVMrh+KfCgPFqSjW1ke/vR/zQeudDfIkKsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd1F8ffK; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd1F8ffK"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bb7d20ad9so70736eec.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 22:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781589509; x=1782194309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PSlzuZQ4Daz0lqLHFL3WubdgzTXoK9WA+8u5CazoU0=;
        b=Hd1F8ffK4luKmn10FBey4LNmAziM2x1JdWre5YrYI3qDbm0qTH0T2U2DTCDooEeC6K
         kjfv1HLJFQLK/H11d/csXCEOO+nWvzSAjP4hzFNSvQhlbqEbKcwIGEaqCCJ0nX2YILs+
         MzF+fOLkosX+N8nTUV7H/L55DfkX2ZVyWwhrvjg8A3cldnZR+UsU5rC31BmpL2zCwjlH
         embfY1INszhyMb5imBI+bBrasYRUCOwW3qOP97l6Gz4B3yXB60d/TngHIMCKPh9OsPvG
         ujTw0DuHQF57+grr6rYfchZKmlnXAjuqCrEPn3NSVnx3jmC2Ia/7Ek85oyaDrQSBT8pw
         03xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781589509; x=1782194309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PSlzuZQ4Daz0lqLHFL3WubdgzTXoK9WA+8u5CazoU0=;
        b=qkx+HiaTDqW85tfmY/XjmpwBLon0/T0mjRe9XMhfzffn9MsleIHWUJxLlSJq76ffsv
         Hwj0qdg/yJfGS63kp2NRaYcAxyCbve40hzz/n2vbdHRx+YrqBQlVcZx3pPv76xCwgeu5
         y0lhJ8Ta+Xph9OMsEsegNDZrfopgUBLJs80mg05Vr7rysp5u2dkhh+TKUki4PQuRRCnd
         W9UK5z/4ZrK5AudA6Jx7AEkBwCvZyT/h8EzMH+hnFuK55Uoe9ZJ9Hh7yM+hYtBhxSlq3
         jdNBkII7nrMcCKoxqRdynRHuFX6Fy3fdoaNlZYbROGE7GpaB+pM6PtUI9W16FQsUuxjn
         kDqA==
X-Forwarded-Encrypted: i=1; AFNElJ+TYLhdJcoOna6J6Zwc3YK8uf2631cAfHHUfYT0GORAoD44U10Ds+5klvf9u3JjvZGpROc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfE2VmtJEMxz8St3MY2zKi2IT6PXCMgxGVVABl6rmf+G6rnEsT
	piD43DyQXrKph1CmJINGYvitLDUKqDCZmVxP9z9oFbjcrJVThrhYFYK5
X-Gm-Gg: Acq92OGzEs1t+s4VoXwCKtLQB4CGiBF0gr2QjoqJg2hNTQSPbVazdjfYNsgiQqz1Z9U
	ZFjCnPK1M9dHsHE0CczQDShzWZd08j0a9W+53Kcz2U0bH+B7CyoBTJCoAlH2ZIpWpYE2/F8I/2E
	MmXOsWpYqvYnQNrm2yHxt38nZagHj3sQtcEXaaPMV+tgxaehdqWs2W2RGnL3jC3+c1xnxScZxVE
	4IVepJ7pwzStPvppRcA6oQYxetwsTt3Zmu8YS7a2JG8QrT3hwjlTPFkXpBRbmKcMz69+YcZr5KM
	zrsPwZpIml0dPp0k0jd1HgGhtQ6bGzS4f6pYhgqdfzOlWbpdSQiu9MRl4FEIfu4A32373KOf8Yu
	RcR50KAACJZtW8G1Wp8qntWWpgx0HOnaMFiw2/iEN6/Y8m+A7Wj2oCiBahbZHUqr9yQOFlLfRh4
	Y6waTkXhUHcP8=
X-Received: by 2002:a05:693c:63d4:b0:30b:6191:7f96 with SMTP id 5a478bee46e88-30b6191bf72mr3509252eec.30.1781589509451;
        Mon, 15 Jun 2026 22:58:29 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e92096esm18135283eec.15.2026.06.15.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:58:28 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:58:26 -0700
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
Message-ID: <ajDmAmq4_hYCDEfp@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-1-54b4736a1e77@gmail.com>
 <878q8m1j9y.fsf@yellow.woof>
 <aioJ_5SIXdGQg55R@blinky>
 <87se6tejoe.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87se6tejoe.fsf@yellow.woof>

On Thu, Jun 11, 2026 at 07:21:37AM +0200, Nam Cao wrote:
> Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> > This is a weird one. The Ziclsd extension introduces it for RV32[1]. All
> > of the data is generated from the riscv-unified-db and because it is in
> > the Ziclsd extension, c.ld is included for 32-bit in the c.ld
> > description [2]. 
> 
> Oh :( We probably should amend the base spec to mention that.
> 
> >> > +        compressed_name=${name##c.*}
> >> 	   ^^^^^^^^^^^^^^^
> >> 	   this name is misleading
> >
> > That's fair, I can rename it to be something like "compressed_inst"?
> 
> My issue is that "compressed_name" indicates that it holds the
> compressed variant of the name. But it actually is empty if the
> instruction is compressed, otherwise it is the original instruction name.
> 
> I am not sure what is a better name. Perhaps just inline this to the
> usage below.

Oh I see, I'll come up with a name that is more clear on inline it.

> 
> Nam

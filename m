Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A938D407
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236907; cv=pass; b=cVaQ62LIvBv+oQUmp6aB+UE2wP2cDaQyr+IRU6D0DQGRGiZyOBej/MfIBe+fVg7wArB87ZGMH5Ecboi4owVjvvnOE1QnygvSXgQfHStIl+2IzHY+HrsjssxvFnZLeM4k+PrBEfwwr+srhM3zXupKhVF2CJn0s4TLSl0iM2QOpt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236907; c=relaxed/simple;
	bh=Y9+yQ6m2SHjTMQK+C809Y49D4LsiLBGTR1bcbiYo9aM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5qmIXKQuGgKFyIPvF6LBFoc8WDJ2cxCYa8wTRGfpwxoYYtoS6s0bmKrcwYeejcZ9CUoHwRWBq9q/vcGBNaEHpZ/Xt3w3uNVeaQfRD1vTDBycf252i29IL590Ono08JLvzTWNxt7LwGenkSQsTQko9ed2PiLZmUnEt5u+Ky7SVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhhWaiYD; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhhWaiYD"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-697d677fc3dso119592a12.3
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 10:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782236905; cv=none;
        d=google.com; s=arc-20240605;
        b=HQRDBLIXwPbTrOp3GkN5UdE1LhHBWoFNHnzuY/1IrMMtwHi5D/aeNDeBWO3BtWqym9
         j7Eq4qHiiA5aEUJLP/GWKZdh9ThI+6cFaRiT7SHX7ErRqQDbdbGHN1utzguuhQJVzvQu
         APtFApvj3VTRDN2LzUJMhT1FUGQJFphUPxXk9A7tPRORbxQ6vJLqiEVOhusXxJbFGEro
         jMk2IdktVGo6YZsiPBpcAYhwmMNgDvWRkdVqTicUQGYMJG1XfLHRVkU24Esw/DSZVOOf
         yz2Rw8PzXbwgWODOKSC13kbEJgbQqMKnJe1VCk5n/lQKDIpt6A8qGAM9RMlCF1P3fU+s
         FWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Y9+yQ6m2SHjTMQK+C809Y49D4LsiLBGTR1bcbiYo9aM=;
        fh=9ZVS8MUoMxw+1RMDbr+DtC/gvxjXQBzjMzwP6r7JoLY=;
        b=je2tWIZm3hQlNYL4wUzNZB228NTteSt4DgG18lreGlXHJVk2nywxtv2dtsYpXy+C3L
         obwW/ifln5EyNK5I4HIiljft9YoMrpZLfqAay73j+3wl86wgCtLdrpKEBbsiee/3fh35
         U0vhLQBb0iSoqzr41uq3jfD6K+ibsfu7/uZQKb1s/bxs6d9diK0vFXW/Ik3d/oWVnKbb
         sattK3SV6eZu3czERYxnwDNcs6uKwCl6sFHoUbAvhcceytKQ9HrVIp/fJDc+lmexL4r2
         TccanI8Xd0r1yJkwaY+l/Paxnuq4sAzf9yP72oufChAucuH336/bEFDOwWVhYrmETQe+
         cfmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782236905; x=1782841705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9+yQ6m2SHjTMQK+C809Y49D4LsiLBGTR1bcbiYo9aM=;
        b=dhhWaiYDMzmVCqcZLo1Ww3Q6RIeRFokXwQ4T1o8H/LynuZqN4Z7RyHZfdXFkeFFidq
         ubPPHyqZQLpsLaqcqa924TbJKj4h4xfhYsUXX+VB4M/+nET5Qzz3YLiGsTC4Thgi1BWy
         PhxiT6s0tCFa6xb/wfz31ZCcdfdj9nQWhKqehJG5ghg70fLZrBfqmt9veN9c6Wa7GlTO
         ADP/Md7DuZuxljNyx05b1jFCB/x4YcvkgrlCrVCmvKX7DYdTzCnju7qmu9mZzRmKlYzh
         S0asHwr7I0Hg/B2mu8qtekrOqBl4ZWlfrdGWmgWp9vKCYTLF3FXzEfoyi/Nk4cqn7I2F
         ehWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236905; x=1782841705;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9+yQ6m2SHjTMQK+C809Y49D4LsiLBGTR1bcbiYo9aM=;
        b=CJvd9RUUNsai1ef2U/Nb+gUifYULALKSrJ79TZTMJueHl0exbgNdqQ2hFgD6NUKarC
         NBxZNWoDJSmiJoUkgKq7Mfs40KJqzIGsGN/WZOKD5wZ+H6IoNbMWXgvUQd4yK8KRuQVk
         UR4CCfi835lLWRSK0T7nptVymaxvRyuMPxsGm4m9rb66rDw7AobHd3uWWAOXARzSGp4G
         Y958Xw4ZwlT7xwyB5N1R3wuYgIg6As8ZpMue8zTnwyejRMhTxvHG8gXLTF6aWqbVfzhJ
         CWviIS4BIlPJsEFCGaUtZl+bxo/Ba+cQhJJg8vgiJ7AxWS8v3+NRvYZ0Vg5XPaGS2yCB
         HxkA==
X-Forwarded-Encrypted: i=1; AFNElJ+UM5Ye/SuzQf/pBP5UKTt3yCTzOwVxVexV4Oha5jwX3gBn/98HhOEOTB7jx7+cx9p853w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUeRcXXlOsvGSxI/7c8pwv3SyWJd7cqgUjeOlgIHeZ3ej0+4I
	F6ndJzRiYD4+NYVAomkSRWMHZXMBQVeChg2gP8cZU1p2zFT54soNnO5wu78xn4bC4vkJT3H5smU
	/LZ7rHaO80RnD69ukn1YPoIPOmXpzosDLXdqdYa9B
X-Gm-Gg: AfdE7ck7IOmcsIvM4ZtpxzgpIAVX+wfAvsUte4RnFd1obPGcbetkbdciKka/XG8dcBa
	yacy+UVsD/e+RTfgxkSdMcL0Qt+DGt2bzuzjsLRh5dOymzpkpwfzL/H6GzvxCMEAXSKi8WYg/nu
	WFDtspfcU4nWFopN9Y8OjX+kKibPM+l6ZmVTwfTVi7rDmlT6wPNWv4MEhlWRLwLqUOdSYZOAXs7
	eRzq6cJGde4FA6cJpvEYeqZAztMXMO23Fks2Utu90vAw66/a3juIckLEYx6hn8Hs4QpNOT+WfVH
	a2gfLrOd0NVN2wlowYSBzZEhFDLX/BBcrlVIITJKMWPD4uWxO53NyY8175OLdTOWBhlMhw==
X-Received: by 2002:a17:907:60cc:b0:c0d:5466:ce4c with SMTP id
 a640c23a62f3a-c0d5466d9dcmr844180966b.1.1782236904428; Tue, 23 Jun 2026
 10:48:24 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 10:48:22 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 10:48:22 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0df3b665-3a9c-4c46-a7aa-14388e8e1577@fortanix.com>
References: <cover.1781419998.git.ashish.kalra@amd.com> <1feccf6e2a56d949b30f403c0ca7949f580e5982.1781419998.git.ashish.kalra@amd.com>
 <0df3b665-3a9c-4c46-a7aa-14388e8e1577@fortanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 10:48:22 -0700
X-Gm-Features: AVVi8CctYJVp25OwZWeFxJ-OUwcfHXzFhyslZieHlTKLg5vqXDjAr-hhZP5Iwqw
Message-ID: <CAEvNRgHDNGCETxLsy0v-_cBO1=1U+tXtOXWEFrXLU7pYz7U9ow@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] crypto/ccp: Disable CPU hotplug while SNP is active
To: Jethro Beekman <jethro@fortanix.com>, Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, seanjc@google.com, peterz@infradead.org, 
	thomas.lendacky@amd.com, herbert@gondor.apana.org.au, davem@davemloft.net, 
	ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Jethro Beekman <jethro@fortanix.com> writes:

> On 2026-06-15 21:49, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> The SEV firmware enumerates the CPUs at SNP initialization and is not
>> aware of the OS bringing CPUs online or offline afterwards, so OS CPU
>> hotplug can diverge from the firmware's expectations and break SNP.
>> Disable CPU hotplug while SNP is active.
>
> I think this is too broad. If I have a hypervisor that supports SNP virtualization, a (non-confidential) L1 guest running Linux should still support CPU hotplug while also running confidential L2 guests.
>
> --
> Jethro Beekman | CTO | Fortanix
>

Were any other solutions considered other than disabling CPU hotplug?

Is this temporary until something else is implemented?

I'm not sure how commonly CPU hotplug is used, and if people are okay
with trading in CPU hotplug to get SNP.

Is it that fundamentally the SEV firmware can't support hotplug, so
there's no point in keeping it enabled anyway?

Is there some way of supporting hotplug for CPUs that won't be used with
SNP, for serving non-SNP VMs on the same host as SNP VMs, or is that too
complicated?

>>
>> [...snip...]
>>

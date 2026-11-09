Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256495;
	b=U4UXfeHE76sU+8F4IeaRErMrPbJlD3kijgjJROTamHI15fxO8lBuJX4VD5iw6mS5Js8o
	 QRBE6AAq0HysZPcCYG8MnS/bfHHw24iq/pYLcQltUQfj2ATd0NExOpKOpKMUcSiEvyZaA
	 19XtNBpkfxtI+i9M5xGzsjbRpcM8qXLOX9xj9AqeSBJ8XA8BY2OJLsAqulGIbUSPuOYnh
	 Wu+FBWqn1YlAEgrQa/banlzFXpyTxPvKLI5D9PcT4pdqsUrLNwuD4caAKAZuMAtX/gmmf
	 mhsKz9ESozJHw3J8O5HpMu06MILqV5R96cKkAFgyYypjPRsSmy9aB20uudbhjN5Vjlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
	b=x+zApRJtlgMJuH7DLNSu73vRHtNtTMEmZW8ZjXk2eANisfVC1+h0dosjzFBn8+fBc8x/
	 1/wV/ylCjvX63n+sAsIqGH3CMz4tVMxi8/dcVfA7I19PhO5FtSdRDjASPk+117/ILsIwk
	 s9EakujTodSj3jH7P+l7LDhEhPodMfReU2/kKHMafkNwfSRTFFsqh2Wsyh7a61QxFASF2
	 VOetcURWBDmKkSMCXWayO8Cb8eLr0OiE4crVmeimvH/h09d/54JJjO8bxqAudpfmBQ8WO
	 YF77bcX/IB7Yxi7vVmZMRCpFmdMte+SsTCUJXU80A4wOFMCdmOuH9dA2/d8+FPRsnKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I3ID8VOZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093F606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7093F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I3ID8VOZ
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso3453a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794256494; cv=none;
        d=google.com; s=arc-20260327;
        b=FFpj7yXJGkilhFIsZzqLXT55JOpzKe8HPGL3SAs09qJr9n1tSNETOPfNqG75ohmSd0
         Q5VShdHdL/8HxsLOFlmdZvdAA5pn+xu38rJRAGvHvVwg+qmlhdJgzkhmvJgY2oi4ZY6u
         ZIJf1DYLQaBKoVrIGZ9F45c5f2u84qFLRVG3VlRkm+kjF9EhhmqtvvhqAVscLLhXKM3r
         bE1W6FFrIOKtQcFpF83YbAbfmzDyOBfh6akrrsxfrx9Al/SyiiXtTKeEhXD3hGTBszbF
         8tQ5EQhK67SA8ynrTKDo8cmf+aXCWEsYZDfphFlqcygli6559pRDHykXKGBUikK5LGog
         lnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
        fh=QbIHTDcWkEfjIn2EZJjSUIwWSxy1f3a0HdRS/yCu178=;
        b=Oe7jlp94QTFuaXcbLOfSAsKZUUVXn1CQUvD3wTZrcJbfKnMZWI280mwT2mSjTeakoE
         Bvkp2WxJ4aBWaW34X2wGqV+r+C89YnhPvGNIEpoG+gjYfREvD/SyK0HkgVv8zrrF87GE
         AIBzpC9Lz7Rx5pBiWAMYb/rXTmIdDkd+5B0NLQDfIOzzXUn0TtbN4/9H7StVr2YZ3sVg
         I7yjMlpVtzAqc2pap+xkSQhVjMu0wb9qu0Q3O2dzpkBfklIwz4MOnxooDls0dt/n1RAz
         zeJmzHVnhebpKYlgO5YVcnLp3tSevmdWw8MCPIkf4osxRoclgSWnSuvGWeTgdqny5BQY
         Hipg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794256494; x=1794861294; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
        b=I3ID8VOZU7Mvl3ZyvAZDoNtB1FYO55LtWaM2kPwTA8uuYnjrlLBSYOJqBuTsRCZ8Em
         WRnmrzrP6z3nYs9EyLX01tRQJYeN0xLS0aFekJH2Vscg9Y6xrmMXPRTAhzlrepnGYJ/g
         ImaV+NSNQeuTsr2ehVtzPPLf02nv0ICMzohj82vnEa8FMDk9yjz+FGbGn8Rg12vquR5i
         xPRwokCB5cD/CFo5E3nlemGC43m8RpLbYbStxb/cUBCnDKYOY6w5lqIt7TKpk3V6cLCY
         Uv3FFEnAsLimn2xGUerd80iNIsPrAhTYCK969PUheI/o7wBIithAK6rc6C0nfhm2Lvku
         ULOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794256494; x=1794861294;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9u3/rYByX8eVYRmHYfD33g0tR7bxTZ5dSd8rv5zn2pI=;
        b=lRbJZeOtH7A0jXLY+0MIOHk2FEHpskfFCzqSxvpuqMDzB6qU+sFIDb9JMPI/Kb4P9j
         W7MNOTm3BJbX8FAUr2UAQ3fuiqPvCCKM2M4EbPgcGf9ytWcyYBdqQ1xtExoPZeACSdeD
         mPqi6zpRV1obBEX5lZderhkm7GSYZx/PlKChEoOTTxd1wcAaXU42uiPvrSj6P6LyGZ1N
         MuMGc41PKTJ3DROqA7INg8v5rewym+f8dNUU7b1xPgZcjt8DFmMRyAaJf2C6469vM3nN
         zMSFoOq4oHQG98l/fsCiniDsSQUNafkXbgsXbaj3otFWRtGY7cBMGkxXXHLpxWOhDZi3
         g2zA==
X-Forwarded-Encrypted: i=1; AL+hErGw4xi9fZsWFFL9QNTgztwKId5StxkUC2V2Kh5BE4r/mUk53g0PHbgd/nBNnJc8KiMQfuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MRqnR/NyNXlO27K3iFxV0nAW+/WUBnqhQGJvn13tiRrOGJ9ZR
	evD4fSvfvDOpogOiBXdbDYQudzTBPK08AhWXeCfjHo4Nu9EtfV25xL4lZn203dw0xyG7182xn02
	Sse8kaVhjYj1ccbdX4TNsxLOA0DXL5nXwRFvdFUc=
X-Gm-Gg: AYBFou3iHx6paaa8Ui89Q+Let2axUl+A1J09GkkcaZjNMQi8E3MNpchRD3uOpb7L75f
	Q4voDiZVHkD8+SLjwyVZkCzskPJwscvZxmeiTYzYXF1T2lvOMFD5FwPRPseEHMr/c2k4TZpU5AX
	CiHg1XImINDU/5EWI0INtjQpDPT/LUcqDlcpycdmUq2ydpCIespWs4di0UAlF4S4J4AegmLKOX+
	zGycSrbz85hmNKHKJnmLCMrBdtkR6q9CaP5s8rj8csrFSQ72VEKSG2YA1r9PEcIDJojKewcfHtY
	vttlioj3Kjo+4wBHYnnyHFjuNw06pGtmHtkUqzVK7NjcAO0opSMYopQZwa5+TEo192unFZFhinD
	kfsxnTdA42NKyYGP3ZGa2CICemJaYFr65hui8ODDQ3vQhD598dtafex89iiZ5fZy+KKcoBAX47m
	D/tegHyBpkp/FLyi8=
X-Received: by 2002:a05:6402:a6c7:10b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b757679a25mr11807a12.0.1794256493443; Mon, 09 Nov 2026
 12:34:53 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
 <20260818-feature-pkey-dev-v1-6-8c0ef96a4da9@google.com> <b360f0c6-b4fb-4e32-ad75-1b50a8c8a0ad@intel.com>
In-Reply-To: <b360f0c6-b4fb-4e32-ad75-1b50a8c8a0ad@intel.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 9 Nov 2026 12:34:42 -0800
X-Gm-Features: AclHuK-EiagYwmBWPxUnhfzsYflLnWduTA8NJAEDllfRxo55u5DmLTzix-qh-VY
Message-ID: <CAJxe5cuGCyLTxYEPR-o+acCA9VVUwXgzFPbS6+d2GvLK7SmC2w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] kvm: Implement SIGSEGV sentinel for Pkey recovery
To: Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"

On 8/18/26 14:55, Dave Hansen wrote:
> On 8/18/26 13:44, Jacky Li wrote:
>> +    if ((fpstate_64->sw_reserved.xstate_bv & XSTATE_PKRU) == 0) {
>> +        return false;
>> +    }
> It's subtle, but this wouldn't quite work for pkru when in its init
> state. I guess the argument is that pkru=0 wouldn't cause a SIGSEGV in
> the first place so this code wouldn't ever get run. But, if it were me,
> I'd probably warn or _something_ if I ended up with
> (xstate_bv&XSTATE_PKRU)==0.

Right, that was the reasoning: a real SEGV_PKUERR implies PKRU != 0.
Agreed it shouldn't fail silently though. v2 will check XSTATE_BV[PKRU]
in the XSAVE header, and warn and fail closed (i.e. not treat the fault as
recoverable) if it's clear.

> I'd probably also at least _check_ for the compacted format. Basically
> make sure that XCOMP_BV==0, too. This isn't strictly necessary. But it
> would help me win a bet with a colleague, so would be much appreciated! ;)

Will do -- v2 also checks XCOMP_BV==0 before trusting the standard-format
PKRU offset from CPUID. Happy to help you win that bet. :)

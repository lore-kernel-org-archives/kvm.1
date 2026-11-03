Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699807;
	b=ytIL2jEMYEuApJxe0ozqWA5k0U4FGLwjbUIqsG0IY3kyMGeo/8rnH6SbeTaJ8Q096obo
	 azGt22D3R9x0ytRWZW2lvW9PzYTqqmzRNyhBoe8h63fqtiplx3DhMLW9lylTUaYOwBI5j
	 aZlWBgxma7i2wHrcfLzxT4bwO5kscNmbCINMFr13j6NnTUGbMD2mCRY20F6Nl/sTvj7/B
	 y9/6nA+YP6THgQxxQzo+mOVYcZ7oiL0ClTONFMQ9x21y7mEXUBXqq4moz/uJXHlArW9ax
	 43XmdymRPIEwRQOazzUz6IXFe6v5H8zPzEWpMCEJ/VrUqhTz+J9W/riebjL2dJUTmWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
	b=FXz3tqaLtmabA0OGUr767USBBEB9Jin3+eq/DJpS3qcwPiYSCnkHngaolkh+gcU8yScC
	 XkCEPyIBP/Rac58MB7mYZRaVlRMFl7AZmSz0ASOGMD7euxXMJBr+HcSA+Ycfeo5ljEVTC
	 MkIqIQKP/2fmmteLeEoOxFDf/Yl7bEF/aWg40zjZXA4UgtT18kY803jqh6f2RFME/kBfZ
	 swbI/h9me5RhdsJyAbbCzHQGC4lNDbug43FtWRJC4MLD5qMrWIKWoCIGmhkVyLjSQ61Wo
	 frk98BU9O1SJmJnroG4WhdPBes6QaPitr4YN7FAAeR2V3qEKVEGm1ESJQyQ+vxU7fLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=S2+DZbZG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576E606A336
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 09:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D576E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=S2+DZbZG
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-844a8bf7e25so2729344a34.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 01:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699806; cv=none;
        d=google.com; s=arc-20260327;
        b=JcORzk+q23l8LSsYXhSNzFVvHr+6b1W0adnwdpqkDiWTXqeFalYgbw6FH6bwNJhFmS
         JeZdqfAUTmsRfJz+skiAuDqg447mmAXHJjV/4303RmXdG4aF7RCCcoEB1luJNVyf14lP
         j2CQD864o6UBMJ6Yz0iCDgiolSPwb6lYwVB5qdOeZJvUaFmOpKppZrerAkIeG/slxuUl
         z9rJ8JJ5rjNI2QWwRvie+irCLLgN9l614t0TMuGoqU2Ao8uWqYEDvDh2p3CCtMUeNOJ1
         w07CVqP+bc7P0Hh+wE21KWBdgWAILUhRmXY/Pc7KPPaUL8HrPEZca/r13Pj+RAh3tRyi
         jTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
        fh=J+XFRYHiWb7GOyK3fFcPbYoo75X61ldcaS8kBtEPh1E=;
        b=pGbRa9d8WJjCF95py8GOLL1CAdHKw81g70c6reLVCI/s4FYjp+rrbvt0I7SniCxtJP
         AQ007t20EphnPEZ0c/gbAmzXraSj35tG2iJQTu3el268Ab+syW2jJpzm8/ONu3DugLOp
         mysx/MFsUbwyHkN3JorGh8gqzP34RE3hG224Cu+RzfG9exfk9Pnj4Qxh4B1rrY9P6vSd
         cMJSZC40JPqYx1OKFWcFoNBRNrmaeMTmBXRXM++jnuKbdGZYxWG9MXNvu6OMeT+Edj/I
         1Py8FfdG7Cpi6537XU6c7IEfSfWeugRihKDuOcLXvi+YvmQV8wGkNdtH4Y7RZ2t8hK/K
         GlVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1793699806; x=1794304606; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
        b=S2+DZbZGfkGYEUmOM4H6oUoDwS149KfIEKV9z2GMh3SdJF1ippnDz9fJUMrELY+kyB
         LlweaK1g0h5miifipylhvsV5b5/c5N7UCaWG91bNx3gpSwIzMlcACIf6ueuZIKx7e3tH
         M2OMexqbCPpTzN0KJt54O4mXO7XNVmdWtH2vNvG9OIcUpDvFd2hrRODF78IpSrNArOZd
         bSHFrVIM/QCOX4kCnFTHqVj3qh3R2iCdZk8nwnv1EOlbXHASU8S6sv73a9+ucLz3quc8
         JMRD6KEkaPW/e+C3LXJ0zrPHbq5+EjYx3Rhl291JfJyoLFEPkQf5weN/WDQkDd/SyC0Y
         vLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699806; x=1794304606;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iqwD6eaHeERb7Ot7SCnGyIPnO7ssTxQvxGidKCgiKP8=;
        b=TZ38fVBjcBbnxxyd0S3bul8AnOKZjSxf5/GLCyT+qi5svjFwpH4Zi6GU2IHj0Rlkf0
         MQEyk7hkFKYmmXJPmRmL4NAZY4HHh9Bh7glcqBTxqEbTPnW4x89ZTJ36sa/ivY/Cj5vi
         IKjkh6CnGzQJSMU0S2F+TdbW6fv/piTxEqwkVDhDJZs/Qw0oKd8Zw7JTX5SSlXjCC5Lu
         X7vpnFsd1sBttEAA3r07OstLBO/G6d/4zJ4UAAQFLXZvKKzIAS8syfdJ8KkxyexPt0O0
         6S8nqZkaNg0xQt233zp5cKkbhlTXCiqx4m88khClQIjk7voOCo7fTbXyXNctU0ajb655
         Ys6A==
X-Forwarded-Encrypted: i=1; AKwUvBzZnUWgk/qymmAM06F+ymVcRCkPIBvCarAUFQA2BXqSMfKfp3FudukOpqinhHm2Kwnwu18=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tGrkK6ZQpfrQb59hUaJFv69MYOP4MJyV3Hy5eGP9LsjVKUdw9
	7XQlxg3veR6wlUTvh9kFIHYkKHtxOo1lzTIr9EtrOf+n46eVykoe4DrDgRd4xExvE5BHH734A7P
	WUeFThAjnp8IYzZRdoXwiUuGShAp8jRGtc9sr1WYeLA==
X-Gm-Gg: AYBFou0jbi2pu4pWur1Imym2m1hGduPHlQH0NPbQIZGI6NtfFDSWWvH/dD5801yiYoT
	wqwgNPzlMGrIxlD5hWdxH2Aqu7cefrCfsD0uPDtIZxPX4HybgMd3boC4y/ogq/8Rs+/9+xaHAjB
	jG6avx83KZbQBawuSLrxmWXdon6wXJxwkm7w4ln432tTY9b1G8i1DhfhuLPgDp/GcTYQA96CCTo
	NFsKfLZ7TgXGnpq/pmbQEYi6TCmO7i0CDCmtA0uJ1Aq9SPMQvvt0D2eJPkMaj35NNboLtLKaTVz
	ADNGldFXhZtdCraDPHJLK+mP9JSKPjNryAEG4qms04jVyxdGT6nzy+eBd7KpaQFTiNiy56Td/SR
	nDI/RvrzVRLuWrUSJAjf0JgTuExUdYYk4xZZZ17Y2ArF1qnZutb1OL1ayDoEnHAVAJI+eXre4A2
	sBRkVH6kuNJMAKbQuRQHiWAYfunS+jnDnYca62
X-Received: by 2002:a05:6830:4c05:b0:844:4959:e855 with SMTP id
 46e09a7af769-85d3636d94emr9384433a34.6.1793699805932; Tue, 03 Nov 2026
 01:56:45 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net> <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
In-Reply-To: <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Tue, 3 Nov 2026 09:56:35 +0000
X-Gm-Features: AclHuK8Doz0oEKFnQPO1b0h9OeAQOCO7SR7lLXwryMRNxDi7qBGsHP1Qzst1PTE
Message-ID: <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2026-11-02 at 19:55 +0000, Edgecombe, Rick P wrote:
> Long term though, isn't this a better option? This patch is
> essentially a performance optimization.

Agreed that interrupt-driven completion is the better end state where the
VMM supports it. But I don't think it can replace polling.
SetupEventNotifyInterrupt is optional in the GHCI and enumerated through
GetTdVmCallInfo. KVM only forwards it to userspace (since v6.16), and a
VMM that doesn't implement it returns SUBFUNC_UNSUPPORTED. So the guest
still needs a polling fallback for older KVM/QEMU and for other VMMs.
Patch 2 is about that fallback.

> Polling is always going to be weird. And when the attestation speed
> changes (possible in the many upcoming attestation plans) this tuning
> could again be suboptimal.

The fixed one-second interval is the tuning that ages badly. It puts a
one-second floor on each Quote and, with quote_lock, caps a TD at about
one Quote per second. The backoff assumes no speed: a fast Quote is
seen within a tick or two, and a slow one at most 100 ms after it
completes, with at most ten wakeups per second.

Polling was originally chosen (f4738f56d1dc) because Quote generation
was "not time-critical or frequently used". That no longer holds for
users that bind a fresh Quote to every connection, such as attested TLS.

I'm happy to work on event-notify support as a follow-up: use it when
GetTdVmCallInfo reports it, and keep the backoff as the fallback. Would
you take patch 1 now (a standalone fix, Cc: stable) and patch 2 as the
fallback improvement? Or would you rather see patch 2 together with the
event-notify series?

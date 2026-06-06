Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4D2248A3
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709122; cv=none; b=gmVbLHSX5S6lPAnkBHKNwa8Xw12yy7axmmHg2fckJ9/mEEec7HptfwvveNc/+lIWm59XZp5sDS5EGMBnxXYYN/mege8AcMKTGtb6+zC9ZQuSvS7i15hvxwmZ1wmja87DIfsK/ec30QYsoPXXjEokxtDNjiQLPaiFUsIIyUKCow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709122; c=relaxed/simple;
	bh=Zghga2gWe/toL9pwA3mj+ss7L7ysOvkr8dnfmHYAMhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX6W4HSFbfIcRggVYFUf4TK3/nn3JQ79Mu/ETmPvR9lO5iTTpeBvTslcZoQGnI9oWl/dTVWxOMaZR/w7+CTj8J7TJVnD5dWuKcTokMshC3pkogAYsaEIP9d4f23i8kHDx9ZulWcNhtiiBBKnqn8yDd5Ujhlj80cs1Mbf2uJ5pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka3Lwfnr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka3Lwfnr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso1618625a91.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780709120; x=1781313920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xlHM4SwEYzgUkF12NjO2fDCV2nlBM3gTJYEltfg6ZDI=;
        b=ka3LwfnrG4cmspNhsZMOJ8mMuDUSWbj3DXK3oQY19UDnkvlRgu2dcfPFNwQyuunNj3
         QjzjNo4nbb0RfM7glSdfeKy9WzdaSDyfoAGNOsmjVxoj0TgvO1USmr7MvQGY5SPuxWTe
         gBEIC2qCHLVDlN7DIyikkD10kWgTGlnwbhq5LvwHHuXjq1MbCK2Lbz/4gczSDUHCxynu
         OU3wAd3kusx8fAKqNuD2Qo+mMXGLfaFGfnZjDxwVW+1E1Zcm/BgAtDYad07NwJINbv7d
         KSS3PiE9Ao3eF+3OE1g0EJqpqrk8BxZZ3/cJBhYntmZSrXSFp45wpNiQJFFE0h8YZi5c
         RDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780709120; x=1781313920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlHM4SwEYzgUkF12NjO2fDCV2nlBM3gTJYEltfg6ZDI=;
        b=odYP2Ky0+k9hPCLGrF4n6eZDBImz+mv6RXRQky3RpiTRZKTpoqtOTTh2FE0DwzNnT7
         MKxSt7moPJ6JS/h4I5eBJ+pei43TNfvBa6CBrb8bHNEBI+dA5ttnula4mb2W7TtQMShO
         5nce6i4NDueVZKeZPPX2u3GXaNGL1WXk7ltPSIeUwbZykpsAV/CLOs6M24kiOzVk6N+x
         n8Gq61k30XfIz5MskcG/H7y20vm6Adgo6nje+Uo78QcE/N/jjWyr0tgYwLHtAfM9f4WP
         E9SB4xmmG8y9QOh6/nndMOdPiRx/DwE/WHWwdovpm0/IVBaHQy1xsIRgL/jHEn5rJ7DL
         O8EA==
X-Forwarded-Encrypted: i=1; AFNElJ+YL/xtitClJWJU5zcqU47+ol65ktf+34WYajAXrfc2kZ3lzDTxiAKKIjnXTI7ZxSoP9mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKiVSrGjvfwMB4+pBpKrIb2IraH9bf/Ift3r+lMsp9ubL/i8h
	oeVRz3+47uD9axOMLByuJXCWCP5mpCdc5GS60gFgBvI6JbxwStex+4Tw
X-Gm-Gg: Acq92OGQlDR+xr3cUxPrmo00QgAhuHhQJONDGE5bODEyuRjcfa0kn9e/4yPm0DNFr2K
	p5tPMBaBLacLaZSGCRcznee/MfZKfMpSdeRWE2n1tdmM38OO+6iFJp6h7q9dg9T9n45grOxdKhP
	M1FOURtgyoV8lKHEGu7Ib0yCbAxZvjdHxdOdkHCiA7DGlfygAtCQRRy8iFiZ3y3JJw+OLYzOlxB
	xSP4uLI0qwjrOCWkxQfR8aIGg+vbTPdJgaiT0axl32MtxXj72x4/u8u25kCKre++pOn7iYw5Z3T
	tdlVK+KrcFaE+WP48AcO3DiKZJ3w1F3ciPxNdEL3rlmIqTqM5e9wr8SS3Gdsv6tYOmKgGaVgaIU
	Nu3vHj4lPYAF0k0aSJXhf883xli+JmFKlmyqNUJyE0GMeK6tWAfAWafJVwZNUjqccArOMAVGKLV
	oBsyxoqg==
X-Received: by 2002:a17:90b:4b0b:b0:36b:a2cc:4857 with SMTP id 98e67ed59e1d1-370efdaca8fmr8095897a91.18.1780709119770;
        Fri, 05 Jun 2026 18:25:19 -0700 (PDT)
Received: from localhost ([2a12:a305:4::305d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ae328sm101642545ad.84.2026.06.05.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 18:25:19 -0700 (PDT)
Date: Fri, 5 Jun 2026 21:25:12 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 08/15] riscv: Add Zic64b to cpufeature and hwprobe
Message-ID: <3kr2pj3za5skl2auqezmdh32ctyw5uhswvro4jr6fqtyznp6lx@2sslriot2zcv>
References: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com>
 <20260602232800.768311F00893@smtp.kernel.org>
 <CA+Ck9FbKRM0wjJMg1fQpdwmow8cf_zTfir7V6+T=CRxU+vomdg@mail.gmail.com>
 <20260604-rice-protegee-3a0b8e4cb609@spud>
 <u52q565xhv5s7gz3wbh4heplhbm4pv732s5kqvf4deiw6ceb4t@n4bnpzu5kabs>
 <20260604-activate-antidote-ebb9197b286f@spud>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604-activate-antidote-ebb9197b286f@spud>

On 2026-06-04 17:28, Conor Dooley wrote:
>On Thu, Jun 04, 2026 at 09:31:36PM -0400, Guodong Xu wrote:
>> On 2026-06-04 10:17, Conor Dooley wrote:
>> > On Thu, Jun 04, 2026 at 02:42:22PM +0800, Guodong Xu wrote:
>> > > On Wed, Jun 3, 2026 at 7:28 AM <sashiko-bot@kernel.org> wrote:
>> > > >
>> > > > > @@ -154,6 +154,23 @@ static int riscv_ext_zicbop_validate(const struct riscv_isa_ext_data *data,
>> > > > >       return 0;
>> > > > >  }
>> > > > >
>> > > > > +static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_data *data,
>> > > > > +                                  const unsigned long *isa_bitmap)
>> > > > > +{
>> > > > > +     /*
>> > > > > +      * Zic64b mandates 64-byte naturally aligned cache blocks; cross-check the
>> > > > > +      * cbom/cbop/cboz block-size device-tree properties to avoid inconsistency.
>> > > > > +      */
>> > > > > +     if (riscv_cbom_block_size != 64 ||
>> > > > > +         riscv_cbop_block_size != 64 ||
>> > > > > +         riscv_cboz_block_size != 64) {
>> > > >
>> > > > [Severity: Medium]
>> > > > Will this check erroneously disable Zic64b if a platform does not implement
>> > > > all three CBO extensions?
>> > >
>> > > Zic64b is mandatory in RVA22/RVA23, which also mandate Zicbom,
>> > > Zicbop and Zicboz, so all three block sizes must be present on any Zic64b
>> > > platform.
>> >
>> > Where do you get that conclusion from? That's not how we treat any other
>> > extension defined in the profiles spec. My understanding was that even
>> > if things are defined in the profiles spec that they're fair game for
>> > independent use.
>>
>> Ok, I get your point. Agree, Zic64b/Zicbom/cbop/cboz can be implemented
>> on each hart independently (at least spec doesn't say no). With this in
>> mind, the validation of Zic64b should be like this:
>>
>>     if ((riscv_cbom_block_size && riscv_cbom_block_size != 64) ||
>>        (riscv_cbop_block_size && riscv_cbop_block_size != 64) ||
>>        (riscv_cboz_block_size && riscv_cboz_block_size != 64))
>
>Or you could check for the extension instead of the left-hand sides
>here, but I think that becomes more complex because you need to start
>returning EPROBE_DEFER sometimes etc.

Agree with you. riscv_ext_zicbom_validate() is already building its logic
on riscv_cbom_block_size. Adding EPROBE_DEFER will make the logic look
like code duplication, with no real gain:

+       if ((riscv_cbom_block_size &&
+            !__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICBOM)) ||
+           (riscv_cbop_block_size &&
+            !__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICBOP)) ||
+           (riscv_cboz_block_size &&
+            !__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICBOZ)))
+               return -EPROBE_DEFER;
+
+       if ((__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICBOM) &&
+            riscv_cbom_block_size != 64) ||
+           (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICBOP) &&
+            riscv_cbop_block_size != 64) ||
+           (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICBOZ) &&
+            riscv_cboz_block_size != 64)) {
                 pr_err("Zic64b detected in ISA string, disabling as a CBO block size is not 64 bytes\n");
                 return -EINVAL;
  
Just for record purpose. It's not my intention to do this. You won't see
it in the next version. ^

>
>>     return -EINVAL;
>>
>> This will allow :
>> 1. A Zic64b hart with 0, 1, 2, or 3 CBO extension and block_size 64
>>    passes the validation.
>
>I'm not too worried about the 0 case here, people shouldn't be using
>zic64b if they don't have a corresponding extension after all.
>
>> 2. A Zic64b hart with CBO extensions but block_size is not 64
>>    fails the validation
>>
>> Thanks for the catch.
>>
>> I will fix that in v4.
>
>btw, can you fix your system time? It's like 12 hours in the future and
>that impacts the timestamps on emails you send.

Fixed. sorry for that. It should be correct this time (and future times).

BR,
Gudong

>
>Cheers,
>Conor.



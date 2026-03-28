Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB4239E9B
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714871; cv=none; b=cgZXksjJjF85o+CB28rVMG/h61ezSEs4TUWMlxlCZTwngqzji29tyHi1slxPdROVOL9NnXAU1BwT3jTYZ5NHqUq9JzAUnJE5Klf8TKK0x/KbW31jWmV5lJo85cTqJO8h1pcjMt82yZIUsT0LnSR55DMuu5pac3pVczta5BBLNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714871; c=relaxed/simple;
	bh=/GEXZkmKX4s9b/SmUpPLX93M0m6mbEsjeCZUiizWuRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Np7Z9kMXWMsuGL+XAKcjxPmw+bXSpZxMDQRu9ue3MfWr/TYua91r9sauSNIbGHE16vqJAhCKDZUN9q+6Fjf3SDnex/Tt6nUAA0tknzwDBONFFXdayH9HR16uJkdZyGd6K3DkIujLU/0lg/4VAzXhnPKnP/bQ8bEGcSdGir86v7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk6/E81D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk6/E81D"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2a5236811so2248203e87.1
        for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774714868; x=1775319668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/VNplDWWCZzS7/n5RiNsPZoo6NH5P9/pGe+zWFZeD0=;
        b=hk6/E81D6cClSEGFnMqTMmF+zi8ptjtz7PeWuB+bAqJILXbKbERttj3BUZveYoScs4
         BnkhclGwiEuVtGRKGUU2+Z/evi1g/W0pid5nTr3J2P0xU3R+W+Wu4LddJ51PLVDG0Qxi
         XGTtJxZ8qGMAXZLAqWXeo8mbV5Ou12TnA2Ptj9DEFZXa0JYgNpi9cG8U+taOo2yFxzAz
         nTCjaRTZRY63jmJVAzlkpGWzEplNg9c7sfZP7tKs/cmXUXXrkApm0O0M0Vpu5MbrnAtN
         rMob7frToW8EEHdaFxfBCcKHaIM2dQo/QzYVNwv64LbNhOhCDnWHG487O7hzKENnb3Jo
         lyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774714868; x=1775319668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/VNplDWWCZzS7/n5RiNsPZoo6NH5P9/pGe+zWFZeD0=;
        b=kSANXhWzKWS902F7eKyKkSYXiyIpVBF1TVXt/3XdVQujVosgnrHwa5GXDb+byLjrPP
         O0JP9q4TgAAOmVCwCkX2iBIuPj1jMsMOnOMJfE4j/iEN096e7/6k6AcnPHOSJTJk1Y5Z
         H+ts19oZqUG6+sW3flJWx8Ly32vHyWyb3YrP5UIBJAjSwqA4wz3FfuiXiVLXZNZ6ibz0
         Q869QZ4fa/4rz/m+0exLjLiD3ZL5kVaS69lghPDlOxCMV4veWMEEwDmBEQV9hTwGVC8K
         imXOn+Wb7A2nM2faog2lsA1Wd3vq1ohrx/rqFG0/YY7CrNQDCeJsxVj7OBX9dbRob10+
         cCSg==
X-Forwarded-Encrypted: i=1; AJvYcCUUsU0YcuOpRHBMk7gGfQV5eh+ovhEfBjab+vQZsQx7sFnqRgbWuz/OofampvCc/HnZMKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEkGhCchNpKUMuN7I7ML1O7IUQM4HEukGhr+2SfsqBIpw5HDb
	8Y7g2h0OHvuWtWsAwIoEIPVMNdZ+PKeOFplKMfZXjVSm3ncBff6rfW75
X-Gm-Gg: ATEYQzwlvPWBtZ3SRiJo5tEoXsIx1ZzMdlVSqbdARMKreAXoXrApvUChT6W9aXg2RBd
	kmKOxrofVvUYtP/jlofpdt4MEq5usnzorFbMjQeFITGnGBE7O7k5mYnAph+yYyRZC9twbeQc6mm
	3rc6+7M8A14jVEeOQfM3YkNmsdaCrUU/a2IF5qZvtb6NPGJiFZLdH0GFOYyx/3ryP2dbJoE9iaz
	ax81Mo5GxRKNAMXu+And8xGwA5Rx5psEi1THKYVCRGHx7/BQhAFA4YPYN4ET/1F8le+g+0otIhn
	KoCncnLqgwAnPfvniSmwyurq7zy6EbKWZtZ61HYWGmY0QPzRYwywYitbAASEhgoRlvfVse4ZueY
	51Vm1PM8zztr4Zea/xtVMFFIaJW9PgBRr2KA45YJil1XO1wNvBCUDfGiqAbXzwrE16dTFpStgaO
	ojcqTFGC+Kouw2HrilIjhl65K3mfZBu6s/86NJHPKSpAcWVAc8j/PTWVSNA6AQfUtm
X-Received: by 2002:a05:600c:828a:b0:487:338:b4df with SMTP id 5b1f17b1804b1-48727d8818cmr86841645e9.15.1774692519962;
        Sat, 28 Mar 2026 03:08:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872716799dsm32314725e9.25.2026.03.28.03.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 03:08:39 -0700 (PDT)
Date: Sat, 28 Mar 2026 10:08:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jon Kohler
 <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260328100837.7e6dc7fe@pumpkin>
In-Reply-To: <20260328004256.mm2ttj5iwvu5kdpa@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
	<20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
	<20260326104557.24295cbb@pumpkin>
	<20260326202931.wlggnd3nfj6hngpb@desk>
	<20260328004256.mm2ttj5iwvu5kdpa@desk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 17:42:56 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> On Thu, Mar 26, 2026 at 01:29:31PM -0700, Pawan Gupta wrote:
> > On Thu, Mar 26, 2026 at 10:45:57AM +0000, David Laight wrote:  
> > > On Thu, 26 Mar 2026 11:01:20 +0100
> > > Borislav Petkov <bp@alien8.de> wrote:
> > >   
> > > > On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:  
> > > > > I believe the equivalent for cpu_feature_enabled() in asm is the
> > > > > ALTERNATIVE. Please let me know if I am missing something.    
> > > > 
> > > > Yes, you are.
> > > > 
> > > > The point is that you don't want to stick those alternative calls inside some
> > > > magic bhb_loop function but hand them in from the outside, as function
> > > > arguments.
> > > > 
> > > > Basically what I did.
> > > > 
> > > > Then you were worried about this being C code and it had to be noinstr... So
> > > > that outer function can be rewritten in asm, I think, and still keep it well
> > > > separate.
> > > > 
> > > > I'll try to rewrite it once I get a free minute, and see how it looks.
> > > >   
> > > 
> > > I think someone tried getting C code to write the values to global data
> > > and getting the asm to read them.
> > > That got discounted because it spilt things between two largely unrelated files.  
> > 
> > 
> > The implementation with global variables wasn't that bad, let me revive it.
> > 
> > This part which ties sequence to BHI mitigation, which is not ideal,
> > (because VMSCAPE also uses it) it does seems a cleaner option.
> > 
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2095,6 +2095,11 @@ static void __init bhi_select_mitigation(void)
> > 
> >  static void __init bhi_update_mitigation(void)
> >  {
> > +   if (!cpu_feature_enabled(X86_FEATURE_BHI_CTRL)) {
> > +       bhi_seq_outer_loop = 5;
> > +       bhi_seq_inner_loop = 5;
> > +   }
> > +
> > 
> > I believe this can be moved to somewhere common to all mitigations.
> >   
> > > I think the BPF code would need significant refactoring to call a C function.  
> > 
> > Ya, true. Will use globals and keep clear_bhb_loop() in asm.  
> 
> While testing this approach, I noticed that syscalls were suffering an 8%
> regression on ICX for Native BHI mitigation:
> 
>   $ perf bench syscall basic -l 100000000
> 
> Bisection pointed to the change for using 8-bit registers (al/ah replacing
> eax/ecx) as the main contributor to the regression. (Global variables added
> a bit, but within noise).
> 
> Further digging revealed a strange behavior, using %ah for the inner loop
> was causing the regression, interchanging %al and %ah in the loops
> (for movb and sub) eliminated the regression.
> 
> <clear_bhb_loop_nofence>:
> 
> 	movb	bhb_seq_outer_loop(%rip), %al
> 
> 	call	1f
> 	jmp	5f
> 1:	call	2f
> .Lret1:	RET
> 2:	movb	bhb_seq_inner_loop(%rip), %ah
> 3:	jmp	4f
> 	nop
> 4:	sub	$1, %ah <---- No regression with %al here
> 	jnz	3b
> 	sub	$1, %al
> 	jnz	1b
> 
> My guess is, "sub $1, %al" is faster than "sub $1, %ah". Using %al in the
> inner loop, which is executed more number of times is likely making the
> difference. A perf profile is needed to confirm this.

I bet it is also CPU dependant - it is quite likely that there isn't
any special hardware to support partial writes of %ah so it ends up taking
a slow path (possibly even a microcoded one to get an 8% regression).

As well as swapping %al <-> %ah try changing the outer loop decrement to
	sub $0x100, %ax
since %al is zero that will set the z flag the same.

I've just hacked a test into some test code I've got.
I'm not seeing an unexpected costs on either zen-5 or haswell.
So it may be more subtle.

	David


> 
> Never imagined a register selection can make an 8% difference in
> performance! Anyways, will update the patch with this finding.


Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73230370ADA
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925240; cv=none; b=hQlU/h8Vk+vcdaE9iBuRYiw1HWcH2ar8q1DqMGbDHOAS+pjl7wOedvvby9sZtZiiiHOANiq3yFJnYTp4wYTDOV9bjIeWINdTCB+0+iG11c7LBY29x+jP/im3nkXg5N6HQQBd+4HYLPwJsJivIQL2BnUektKox5coAoKdXqN1Glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925240; c=relaxed/simple;
	bh=ulrrB51K3AYQ2OlwuYLkbpXtaaGcfRbDlWD4dwEzaZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7H3su0Cni7vU/U5JWfPGnWuUH6AotMjR6GV9CLHa7e0XrjNRy8P/5fq/5eRE1DkmJrwoz6RD484hv020jGCZruvDXC/mMVN2+7WyGOa9/kgsQOG5iEnHFAyVCMUkD49ZrSLYMqjq67jhL8HXlCRyzm/npZeGCWgVv9yQyy70/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF/I31DQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF/I31DQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b786d6c0so4749005e9.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782925236; x=1783530036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLmV+G/PpTG3SW60cUQIz3Ts53d+g5oeBKqSg4USjMI=;
        b=VF/I31DQ7vn3lCBeVWC2VlRuhczWaniHNC8uGxQdF+HW7QcflIi8ROyKufYiN/13xe
         60gV9MpZ/3vvXTVDXDVlUt/8sls5CYL+2V52zpSI4+Skd7YQbInQSQQN/dR4ZxRUhNrC
         ecMKvtUxoOdxPIHJoOOzi7DXbZBoesIToWnUfBdSZq3LB2YakIJOfAYUfOAR2Yl0JPxg
         uyb+ceJXHzXIJ8XqRp87oSjmiHQE10GZywHhsC3qbbXLGO1LLKoj/jk4P0gR2BGN9cyc
         fEFyFRdsD0tMD/oKEmHa4aceZlmN0JQfzkm8BpCasSYXCkdO1m3N4rFIaSuJbydceROd
         n50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925236; x=1783530036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLmV+G/PpTG3SW60cUQIz3Ts53d+g5oeBKqSg4USjMI=;
        b=R3nS5ZzbFUQPg5ds4emlqNA42Wg06wEEpmtwRgBgLhHgz+IosFHh6GdjQNmkO6J1A2
         mmwW+Lcii4y3hBJlsHWrWww9r7GNuZrMYVAxFKkZvMu/OG4H/QoHLb6DxfqdxeQAb2KZ
         BS4t+CUjj+I23KsyreKbTm/oubIGtASk423Lr9+xxvP4W6+3WrNLZIi80dT1+0kh1HrB
         ehAASxhAP2u5POyMbXd+m0PRcegHPhUqAoQAcWZ5bMzhJ09JzNDUOYhtEaqi51VYXRqv
         J5JIXFjQsvkL2ux3JzbqLfgtxbJTUBM0GDbKijfoYiS4ZC0gkbAt9n8ufMu1c2s7gqJ0
         hZgw==
X-Forwarded-Encrypted: i=1; AFNElJ9aQYLewI5IOkcjjDp96XqHI08RiPZyJC5myLo+eWDciGTVirLxlBauK3NHIx5sAtb99yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINrkVt/s5c1xEzpr9EyqrtPhB3utvEQKGD4rP4cJG6LIa286q
	WzijGGlQt9J99rgjfgHXBXQILUpJY06hj2ImE26cxx1FnhsyOSWCjX+e
X-Gm-Gg: AfdE7cnRUYAMzcwMolgB5zoOawCwMZJFkR8K6/lr9jj2OzVl51PYBykKFHmMmxBaKza
	owEvUkRL1rEKyUjVBOecfBJNTpyey6ZEdTRrUyIny76Y2+vsnTLZO1MKLZqiDXVBPpakywA33co
	g0K2M8TotUtGb/9FTTk68A4fji1jrUVzZy5yDf2d1taNKe0yVKc5/6QdUM52L30fWGJ0voZV2Yl
	51pp+Bs3BqqH3AFt5TO/ubK29uh7bxvgI43rKbJoqDaPKa5JqJ0+hFtUXYyb3cDxBTb7IqnTtrk
	yv1OvOe2P1TUTZApE5rRJjEiEuf5mO/2llF3e7Ocv1svrBCWIoMJLBn8D0NGO2Y/h6onZlejwxg
	2Qpqb0Kkp3mUnQaSqYIziBsI99W3BhF9CPE5mK4iAkdhbUKHFS8KPOVriCGE6JD1c9H5oXKbZUx
	lHXQEUGeoBmaX+AzrxMFU1kDSoYFzuYpKE65pZ9I0/J+IlQQ==
X-Received: by 2002:a05:600d:111:b0:492:53e8:3bc1 with SMTP id 5b1f17b1804b1-493c2b58b3fmr32580785e9.17.1782925235694;
        Wed, 01 Jul 2026 10:00:35 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm129586375e9.15.2026.07.01.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:00:35 -0700 (PDT)
Date: Wed, 1 Jul 2026 18:00:33 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang
 <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, Andi
 Kleen <ak@linux.intel.com>, Dan Williams <djbw@kernel.org>, Borys
 Tsyrulnikov <tsyrulnikov.borys@gmail.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/insn-eval: Add insn_assign_reg() helper
Message-ID: <20260701180033.6e9c07aa@pumpkin>
In-Reply-To: <akUrORhAmRur-lHP@google.com>
References: <20260701110547.764083-1-kirill@shutemov.name>
	<20260701110547.764083-3-kirill@shutemov.name>
	<akUrORhAmRur-lHP@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 07:59:05 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Wed, Jul 01, 2026, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > KVM's instruction emulator has a small helper, assign_register(), that
> > writes a value into a sub-register with x86 partial-register-write
> > semantics: 1- and 2-byte writes leave the upper bits of the destination
> > untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
> > the full register.
> > 
> > The TDX guest #VE handler needs the same logic for port I/O emulation
> > to get 32-bit zero-extension right.  Rather than copy-pasting the
> > helper, lift it to <asm/insn-eval.h> as insn_assign_reg() so both can
> > use it.
> > 
> > Add <asm/insn.h> to the header's includes so it builds standalone in
> > callers that have not pulled it in transitively.
> > 
> > No functional change.
> > 
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Cc: stable@vger.kernel.org # prerequisite for the following 32-bit port I/O zero-extension fix
> > ---
> >  arch/x86/include/asm/insn-eval.h | 30 ++++++++++++++++++++++++++++++
> >  arch/x86/kvm/emulate.c           | 26 ++++----------------------
> >  2 files changed, 34 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
> > index 4733e9064ee5..0c87759816d3 100644
> > --- a/arch/x86/include/asm/insn-eval.h
> > +++ b/arch/x86/include/asm/insn-eval.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/bug.h>
> >  #include <linux/err.h>
> > +#include <asm/insn.h>
> >  #include <asm/ptrace.h>
> >  
> >  #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
> > @@ -46,4 +47,33 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
> >  
> >  bool insn_is_nop(struct insn *insn);
> >  
> > +/*
> > + * Write @val into *@reg with x86 partial-register-write semantics: a 1-
> > + * or 2-byte write leaves the upper bits of the destination untouched; a
> > + * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]  
> 
> The placement of the "(matching IN[BWL], MOV[BWL] etc.)" blurb is confusing.  I
> *think* you're trying to say this behavior matches that of MOVB, MOVW, and MOVL
> instruction mnemonics, but the blurb is buried in the snippet that specifically
> describes the 4-byte write behavior.
> 
> FWIW, I think giving examples does more harm than good, because the behavior isn't
> instruction specific, it's architectural behavior that applies to all writes to
> GPRs, as defined in "3.4.1.1 General-Purpose Registers in 64-Bit Mode".  E.g. for
> a MOV instruction that sign-extends a 32-bit immediate to a 64-bit registers, it's
> not that the instruction is exempt from the normal GPR semenatics, it's that the
> instruction performs a 64-bit write to the destination even though the source is
> only 32 bits.
> 
> And the B/W/L terminology isn't architectural, it's AT&T syntax.  E.g. trying
> to encode "movl" with NASM yields "error: instruction expected, found `movl dword'".
> Yes, the kernel uses AT&T syntax for assembly, but I think this helper should very
> explicitly document that it's emulating architectural behavior.
> 
> > + * etc.); an 8-byte write overwrites the full register.
> > + *
> > + * @reg need not be 8-byte aligned: KVM's instruction emulator points
> > + * into the middle of a register slot to address the high-byte
                 ^ it isn't really the 'middle'.

> > + * registers (AH, CH, DH, BH).  Use narrow stores for the sub-word
> > + * cases so that the access width matches @bytes.
> > + */
> > +static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
> > +{
> > +	switch (bytes) {
> > +	case 1:
> > +		*(u8 *)reg = (u8)val;
> > +		break;
> > +	case 2:
> > +		*(u16 *)reg = (u16)val;
> > +		break;
> > +	case 4:
> > +		*reg = (u32)val;  
> 
> IMO, it's worth keeping a short comment here, because even with the explanation
> above, I suspect most people will think the code is buggy.  E.g.
> 
> 		/* As above, zero-extend 4-byte writes on 64-bit CPUs. */
> 		*reg = (u32)val;

Or be even more specific and use '& 0xffffffff' rather than a cast.
Particularly since the casts of the RHS in the byte/short cases aren't
needed at all.

-- David

> 
> > +		break;
> > +	case 8:
> > +		*reg = val;
> > +		break;
> > +	}
> > +}  


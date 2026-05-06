Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913782E0938
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103169; cv=none; b=ldHVGfv2XjY0ymVeEiRq81r5JK7DoZZ9SEmStOkbttuiCeE58OWqLLNdUWSByVHBnNYKyJXWvdjtX+xPFLPmdLhmKhy64URLIaMKZN+SSuLyx7mpFEdI5zznhiKMsrS3uH6cBCqUF+P0xXrYkw3APDl2ZGCzkTwCgIFRvGz3P4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103169; c=relaxed/simple;
	bh=LT8MRjBazYQv4FIKOphIZRPURGyteap5HaJ02H5fXSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SFZQ8x3Z44mQEi5j8eqJ5RQlXKojfnx2GEkme5cwGbEU1NbUmD6CJhUorlGh5Xin05fs3kgNjkxib+VDjltOht/FBt2tUS+xkN/J7pg+WPcWOBLaa9P1KwIZy1wjd4EFoma8orXT6obWLUTgxxilREJ2PJaxsyikE3Kua417T+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Travssk/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Travssk/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso1511755ad.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778103168; x=1778707968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUj3rkHO2vu1Dk6fPiJDKAACha/tOeGqR26InhUgyKI=;
        b=Travssk/bOYkoCtr5Xd9RvrC5RAXGZHqTsZpc2x2K2jt5REYn+e8gYQMhnOx0ati/g
         KUtXES04PNeW8/YMTpCYRc1M4FHF6THEv0bltMi0H4cQ7igY1evx+i0Wnq2M22jXgN0M
         I2WHqOT9u/ZvMpWlLrdcjmMya36Ca+tIwtJC5CiFI0ST3W8W89ER+rAjxyYY/Vqi5V9H
         oxgmQE5ByIhHk1z3s9nNVa4AAxXKExTjj6YGvKmGFrCSLVAuT7En2m3UysxAB/XdyXa6
         NouJNdUXi84QahyxDXOvwSiTD0Q2p0MTqvWKW045wjPKik+ANXZdQD2uAOe/tQObCZNu
         cpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778103168; x=1778707968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUj3rkHO2vu1Dk6fPiJDKAACha/tOeGqR26InhUgyKI=;
        b=dPQoFeUZXvOsa2szMRkQp/Jnp9H0NfkeeD7DfGsMH1LEo6pU9NP/HTYOlBDUmzAHgr
         N5H5LQAYxOdDlhObqXxidFh0+zhM1oA29L0qHS/Vbn41mMI7aBHJDiZZvcGND30w6xA/
         c3ui2A5FT11t1TtHbV1u1O/PEoxnvrdiOBYGv/Vk6r3sgbbMlb+xKXjy9+ToXG7VP2Nb
         P2W+CaH1f8IgF5RuiGdcIgHbk09WrGc3A4XrOOud97r2DZlo6Nmx7vAIpwBsomny4+9S
         qm6+jxXTlBEpZv06P43ZXsJFBFRiorUn4Nr/unlR5nUGJsBgkxREUwv4tUGYQkSv8/Lu
         ZoXg==
X-Forwarded-Encrypted: i=1; AFNElJ+iOPMfvAgVdzk9tK3eeQV7tc4GEd9u5WeuwCPoziNxo6FPxTtFygATth0vGanaXuGSsnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFmqS5doI9G2lmWFbrREqVxIdIVbWoXNALkA2AQsGqvN1XZdb
	tvZpAq1WmVbHHoGLV6xu//2hWtcYG4KE9Ul05qnwFqZ7mdR2WG5H2gHziEWkqOVCL2OH19CHiZi
	KIsnCTA==
X-Received: from plpe4.prod.google.com ([2002:a17:903:3c24:b0:2b2:a70b:98ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cd:b0:2b2:4a9a:b149
 with SMTP id d9443c01a7336-2ba78e34b7emr55355555ad.9.1778103167782; Wed, 06
 May 2026 14:32:47 -0700 (PDT)
Date: Wed, 6 May 2026 14:32:47 -0700
In-Reply-To: <afuupCOAeaO9A9y7@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506185510.2723091-1-seanjc@google.com> <afuupCOAeaO9A9y7@google.com>
Message-ID: <afuzf6LHHmbJD9uP@google.com>
Subject: Re: [PATCH] KVM: x86: Swap the dst and src operand for MOVNTDQA
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Eads <josheads@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Sean Christopherson wrote:
> On Wed, May 06, 2026, Sean Christopherson wrote:
> > Swap the MOVNTDQA operands, as MOVNTDQA does NOT in fact have "the same
> > characteristics as 0F E7 (MOVNTDQ)"; MOVNTDQA loads from memory and stores
> > to registers, while MOVNTDQ loads from registers and stores to memory.
> > 
> > Per the SDM:
> > 
> >  MOVNTDQ - Move packed integer values in xmm1 to m128 using non-temporal
> >            hint.
> > 
> >  MOVNTDQA - Move double quadword from m128 to xmm1 using non-temporal hint
> >             if WC memory type.
> > 
> > Reported-by: Josh Eads <josheads@google.com>
> > Fixes: c57d9bafbd0b ("KVM: x86: Add support for emulating MOVNTDQA")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > 
> > I have updates to the xsave KUT test to verify the bug and the fix.
> > 
> >  arch/x86/kvm/emulate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index c8c6cc0406d6..0bb832a76868 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -4450,7 +4450,7 @@ static const struct opcode twobyte_table[256] = {
> >  	/* 0xD0 - 0xDF */
> >  	N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N,
> >  	/* 0xE0 - 0xEF */
> > -	N, N, N, N, N, N, N, GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_e7_0f_38_2a),
> > +	N, N, N, N, N, N, N, GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_e7_0f_38_2a),
> 
> Aaaaand Josh pointed out that I wasn't paying attention and stomped all over MOVNTDQ.
> I'll figure out why my KUT changes didn't detect this

*sigh*

I made the same mistake when testing MOVNTDQA, and didn't learn from that mistake
for the MOVNTDQ half.  Comparing the src and dst buffers on a "src => reg => dst"
sequence wont't detect mismatches if KVM wrongly does "reg => src, reg => dst".

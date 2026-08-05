Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41F477987
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943075; cv=none; b=uk7TaKlHbdm+HQwapqYm1RjeYMdv3RNPPvXk1e9OFkbxNoxEXOL0tsWNTXQTXzh+5YiP7/abnRDEipNz37QstgD5uNT4niMbDgn640Q4DnV6xGfJhF4lY5PPZZQSlccy4vZ7z1NprBlfPuJXmzbXU93BS91lUw9QUBvJl23TBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943075; c=relaxed/simple;
	bh=S3Z3rnyOq7JZQ53Rdv4tbQRYk3CanTRKPf6nPJmbOXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M+7KqhrVhjrj0qOnzbRCFDg5xlRrcy4ubHHPbIGJhlSIRkJiGPAvgGOfUZtwPZ4UBNpKMLj+GBt58c91iPYHYD5Zqp5G+gBTiGuaO/B9v4CP4t8vZU5+61nCSep9acIvPo94vsq2gSU9AhBSIKzwfeXlMEHuMQZyc3d3hv2SF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoSktNmw; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoSktNmw"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84eccf9d899so1547500b3a.2
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785943073; x=1786547873; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3YZ5iTtFS4MrvF1HOSKp5JT5qkAOW11RqUF8i4nnDI=;
        b=FoSktNmwrnLuQZ/A5WPYx2x79RDHYUWltJBsnAkkaXevwqr/ENx6wUSOqsBOgojfDW
         +8uEVtxVPwhjMtNl6bdCghJwpYpA3t3kYTUyt6GPCmeYTa1v39T0tyx3qmH9mkxcxa8E
         FfnwYbURyUNgTjA5Z1w/+87/zhcT6tiZv61wcZhlm4i4NtQa5ZcfWbO2gYk+heu5p3DY
         IyZ8YtFmQK/Q+AbjF9vsMzEb1yeb7Hm27Q68nJKjUxiQhLICpMbHi3gOxR/CefWZhRmH
         F5SlnorsaOfTmI6WgH3bE2ARdQ3S/5WTz5mAfyuwWwKEjz41ffv9+cRXjfcS4344MDXy
         1nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943073; x=1786547873;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3YZ5iTtFS4MrvF1HOSKp5JT5qkAOW11RqUF8i4nnDI=;
        b=Zr+Ub5LfOGLr8pyyV6DPJ3kCNCLvFia6a8ThF/B+YcBSQr7bhzbrCLXa3BX28JL67/
         thEkmouE3pPdKK5SUguiDZ7J9zPkHGqu+sjHEnFmFfVl3qILe4EDVllazflKlRwgEviU
         TOmRCB2uvj+zm0Op4e7PeZS7yRvJGLmGrro8shWhvx400ApqV9oi2c87Vg+0Phmk7I5t
         S1XjzVhnqv4f9Iv8wzCu7/LoQOHLUyiyUGMeqPL+cFm3nxmv7N55rvrGDM64slzC4I2r
         UVCDbirp8h759tDc5lfjNc/HCKbcZCMOTy2eup9IJGYxlEhE1VlVydbAdrPqb82kYjBq
         ukXw==
X-Gm-Message-State: AOJu0Yyci+OGqGBUQ0cQTFotkK7mkHWZ2abyUsBcSUazLqPt8uIN40nt
	otQAiLNWWYK/PLdkgmuNDHavytFl2SgQ9zyzBSMGqNgsomKgcZ6yTNAxfOoos0ziOBvfJaf2IDj
	zwKTabQ==
X-Received: from pgj4.prod.google.com ([2002:a63:904:0:b0:c8b:19f4:6228])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3928:b0:84e:d5e6:a085
 with SMTP id d2e1a72fcca58-84f2de7e930mr6860423b3a.0.1785943072271; Wed, 05
 Aug 2026 08:17:52 -0700 (PDT)
Date: Wed, 5 Aug 2026 08:17:51 -0700
In-Reply-To: <20260804235204.559041F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com> <20260804233923.3504629-8-seanjc@google.com>
 <20260804235204.559041F00A3A@smtp.kernel.org>
Message-ID: <anNUHwk5JvUik6Ra@google.com>
Subject: Re: [PATCH v8 07/17] KVM: x86: Move "no master clock" fallback from
 __get_kvmclock() to get_kvmclock()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, sashiko-bot@kernel.org wrote:
> commit cb25993776f1881f5ff66de261984bd8992ceece
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: x86: Move "no master clock" fallback from __get_kvmclock() to get_kvmclock()
> 
> This commit refactors the kvmclock retrieval logic by extracting the master
> clock fallback out of the inner helper and changing it to return a boolean.
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index b520928579129..7366d4602f89f 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> 
> [ ... ]
> 
> > @@ -1667,8 +1673,6 @@ static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
> >  				   &hv_clock.tsc_shift,
> >  				   &hv_clock.tsc_to_system_mul);
> >  		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
> > -	} else {
> > -		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
> >  	}
> >  }
> 
> [Severity: High]
> Does this function need to return true on the success path?

Doh, yes.  I botched the splitting and incorrectly added the "return true" in
"KVM: x86: Wrap all of __get_kvmclock_master_clock() with CONFIG_X86_64=y".  I'll
fix, and properly compile test all patches (I did that before splitting the patch,
but obviously not after).

Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A417745
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777250232; cv=none; b=vEU8SoFozy22nKjqKT/uuiQT/bFtIiMaNcFcQw75n/4ZUZNbxlHJ0LTKKl71/1VHUfUjVmS6F/mppLakBvQkwNl2ddIejeSP8F1SG5Yxgq7SVmldnN5/xS/m2vh39e+f8LmHrskc+0ifgeOj52uimlfqi/v1CBdW0XEW9aLzpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777250232; c=relaxed/simple;
	bh=JA7fhWQUKJ7bKOO5WZ2l4tLYAxtvAQeGMTMWREFP7ac=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ph1nsoBz9s00v84bGnGUbvvVkYE4bd3YraSbPLZLfyBGjxnwBSXoFkBrtSizusjrdstm3SIhLFhUesWTV9owGco0gzZfStQhciLAuH5FNr+3jS4vkO1SfeUPj/cR3mUrNU7P+b3XS9GM42UukjELdfuU40+Jmi6wL56gL+Cl3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTyGJ4tI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTyGJ4tI"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3546741b3a.0
        for <kvm@vger.kernel.org>; Sun, 26 Apr 2026 17:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250231; x=1777855031; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mVdfUhTIoRGg+RbxdXBCn/qp3+VQxZ3cyedRP11wnO8=;
        b=mTyGJ4tIEkwcSzOMZM7wAAaDbcvVUrt9wbByfgJ4/esK9zB/pGp0DaNtgGSDMnih60
         REwRmeA9M8HeOyta5gOi2YFvTFIYetAAFf3ApdyEF7aATEG1yQikhiKKub7j5hIjSrVi
         drEzT9sThYH5dZ3dULmetSZVOMtIP8G7M3Fgh1ZvdolS3W6aCJ3h56Ri1ZrLqyKRcyP4
         mJcfsdSxtj9c96RPHKIfmUXPH5BAK8ayPuvIoDaS+v5fHZhSzu7IW6dJkpmpTG86Jghk
         wPuN5ewG2OJuG7KFSj6dauZjwfvSsNtZMaTyE5bfT+himnZlJaNpWY2LsqtRHLEBAPNy
         kjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250231; x=1777855031;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVdfUhTIoRGg+RbxdXBCn/qp3+VQxZ3cyedRP11wnO8=;
        b=ikBuBwqmPbP9mMMZQd+7M/j6jnAiui1jVoZ7V6PPD6WHCgD7pLVMZN1DBU5HCTsaSj
         Vae52SU/h9y4EcjcS9rafyquiJsJlaHsvAgEFnR3XegJWiIuIbRfTJt73DtSNL95Eop8
         I8R+CSWYAT8PV3HltEHV6wjC0OwebrDPiMJx5HK7K9M3Z9VgyRlXU4cdEu1fN5BOGhl4
         d6Fb6wgNYMRMD0ye5p7VcpRLbGbi9DNvGdx8JIukNDMUZ7fThdg5B39I3FOYN6Q0ro3V
         JpUnAhoofttA+0X1frY3iJzqkbdvl3OOBJ6QXTTb9GQICHZBeWcFmihAb2x5WWTyvE1b
         RwLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IdfqOCUqBf8XecwaFY9BUEHk0pWjiV21gkGzMlJkqTzR/iqQNxU3+DlUQnK+T5WkdbH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKJT9xUoR8A1RWwJZzriXhF/Gum3MbObIEYlTsLBNDT8Yj8zV
	LzUWFF/FNnol8EFrGCuqNSs94FDY5K3beuiKHD3c0PRu7wVu5xjzKiD3XJTf2A==
X-Gm-Gg: AeBDies3HTw6MMDa2K0T7ZZrnhwtDl4DQhccndhNTqYLNydS4k5VivF++V67gZBDYnY
	K90/l/RQvjnmQvk2HEtVbOWfiaiMm63ypiQLw47pvSIXL22BsBzvZUP8u5+SkMZsryGD/VxoP2a
	j6MV1l3u1aUlbplwOpefaL7I6CcT16aztO5MhA2Z5MZdOR8lRM9wlzo1F8ue+K7IcZ+3QI+85Kq
	i7HXkma17/nV0jKmbx1e5wk117nehdxpX1XMdUfIs3r9U0UuuEz9jJOrc5SJdlBd+1aBJjPeK3z
	ZUa15SKtlu6OTPSfw/rx5sO7vaT6nyj+xIJgRh8eKg+Sg2CenfD/UqWxkXMIneEZSUz6CaC1uv4
	diaTOWY1GOhlC963ea/41quxnc8pkzcSXrmDdB56UJyjl8NqwlXFx331k0+pzFc8PleSK1mHtCd
	XLbBDwHqA+tCLzaCJ/Od6uV1mm5zoKpcvBPHfkwBVntKg=
X-Received: by 2002:a05:6a00:4308:b0:82f:3733:2f96 with SMTP id d2e1a72fcca58-82f8c82e853mr41049342b3a.8.1777250230657;
        Sun, 26 Apr 2026 17:37:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83336687182sm2598534b3a.35.2026.04.26.17.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:37:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for tracing exits
In-Reply-To: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
Date: Mon, 27 Apr 2026 06:00:46 +0530
Message-ID: <lde9s0qx.ritesh.list@gmail.com>
References: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Gautam Menghani <Gautam.Menghani@ibm.com> writes:

> From: Gautam Menghani <gautam@linux.ibm.com>
>
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/kvm/trace_book3s.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..eafbaeb5a9db 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>  	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"},

So I ended up looking into other trace_symbols too and I don't think we
should have a trailing comma here. It may cause some issues silently in
trace-cmd or other places. I remember going through it when I was doing
some other tracing work earlier but I don't recollect it now.

Can we just remove the trailing comma and send a v2 please?

btw, 0XF80 is correct as per "arch/powerpc/include/asm/kvm_asm.h"

#define BOOK3S_INTERRUPT_H_FAC_UNAVAIL	0xf80

-ritesh


Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10A3E8C4F
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313547; cv=pass; b=AxKxIr5Umn0m6u67sF5hxZj3263b4XZQHBWQIEdV/jmg4chHvpyXuYKgoWmxqN6KKiNfQX4ihABedbBNz78XvGPX6JRRxIaSy0Jl4W4VPdVa4JGd4rLINA6IkQWK5SG/j6NbnAlowWG6+GqEE2PzPqPxKTChUTaul3XWi2CcVvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313547; c=relaxed/simple;
	bh=Bv6BTNFx8eotL6sCX8FOszmjIvqGdco6s4FUj3kQRLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhYDmzB8R026Plb2kkt7U9Gl8/zmF3wABNJUBX/Mhx9cigKlB82wqtg4+qEovPy8YNrfU2D/KwQN9J7RDu8yDmZtTyrWqtviTXpiZYlS5sVDlYWhJ//T/+V2kJ22djLpBemV6dxTkmYbJMxaLKjy7eFZ+NNYboafr3QRdGxdp7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoP7TYg4; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoP7TYg4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d836552daso69471cf.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 11:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777313545; cv=none;
        d=google.com; s=arc-20240605;
        b=MPa9dbpw1vpIUywZMBfVvGREzcV9DBrcq6wBtnouQ9HHi3jht9/LNlGpR1y8E6jMrF
         WRA6+Z6bDfaSb4PQYM+r5p2dkACOXc10ZWWqIsV3R8/XwXDUHklF82EPvCRhZjSPSpIu
         fqMwkoe5t+Da0XrEPhlDIuL1bgGa2btFE0Kud/ftrVcTB0QbWNWdcd9YnTCBn67BvItI
         Q7+hww0y+jSddyuWE3bLajnNEJ4t2UnsXskspVxQYCiV5j9bJavBZdakf5dtmBSLTCJt
         3p6P+uE7Y5RredLZjaxBKRSxfM3XN/ZYG/FYRZUfoiXInZsg+iEJYKthaVm5kqX4yZ+h
         FDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=462X41kdBtO/lLaDMT5cvpDfu7D1CiZVzDMruqarSW0=;
        fh=KidvXKJHGLQZwtmEGhu7JZdmBmxqCpr9/yyJeRZYVio=;
        b=LX1jXRUtxcjFxOyFrTis9zKIkxcDfWf7G/Hw1gEeNCypfraHM3byqSJZWJz6aTR2SZ
         TH+1QYKFV+HhLcWooqSJFndru9y/2xjbdSINpW72V9dDmYoXHJ7Az1kGj27KHRtiBp3Q
         Mp8N7fNbrtT+2x62Xh6UD81emRHv28YtoJHGJDJp99nKEGnXWVuzjTmwlNeJaNahMQ+m
         6AGWiE8rgT7ar+0vkigA1qtl70egBMLUV6XpdztatV5a9nLWZ4c4WcpCsi0kHFhgYbr1
         quSvYjpxEczkh9Kav8YSKr+UOYxRx/zKfjohNMVD4kOXfA/U8vtEk0eLE3VZPD1dlIU9
         uC6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777313545; x=1777918345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=462X41kdBtO/lLaDMT5cvpDfu7D1CiZVzDMruqarSW0=;
        b=OoP7TYg4eSMLlBtiKHpyDKHtgnnoJGaWfKiWHehu6l38sgGjT+TOas2zrppnae/yV6
         mBLWr73bW5gciUQRNyectc2jwHrFjS9jlLLn12OFbPMn/N1G0JgNA/oMRkvb87w2t8o+
         SLDyYH5s4++xbkAQGOLq7lVPp7JLzDR33KzAQHda0Nvx7oBtjgXwieRfNzXOXcEol+mY
         9ewOcrd6MiHB/jf8IqBXPnyNnxi48eHNvibiKwuiqf1LBxQeO0EOuZYQpT7MdVtjU4SJ
         umHgN+gUflDDa4zpGIif07saeAiXq/vDBkeLywkd6KxM9dsGOIxc5azUmCGnBwI+CeM/
         2IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313545; x=1777918345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=462X41kdBtO/lLaDMT5cvpDfu7D1CiZVzDMruqarSW0=;
        b=YF6VIgqP7TJD/R8V8ufxBz2jEBItrulVUe8ne9HKntwvNNT9GSpXY2DVsT0nrqkP11
         8ghqBCdsJSbajub2OBEu6zbigZojIiObEkgbbdrqF8HcmPOlKAGg5bQq9lUYFSGxF0t7
         t3OwiQjehTNEkTqB6QHKlJgeWC+k04HqpkveWO2xbjPBhfex0tAhtk8mPL1NQTrfUnVc
         ARYm4E4L0jtBR10IzQKjFHn088gM1p5NxZBIgx1Awg7zKiytHTJ2fvYG7kSStohSVXJm
         yp+d2b4lDnRbhVv+iznacmucebPYzqLjen85zt0J6t0KghIYTXJERySrfLV3FYvOhbmB
         y0+Q==
X-Gm-Message-State: AOJu0YyuD7bI5FfUWvjRuR9py2owI8pXpTgXsN6IFRWK4GoGTt30RZbv
	ZWKuUl86Er8dxkviHm0QomvHi8ncxffdOZ+XEMvFGxy9LGAewyYH9HDsjUBRXI5jclHKVvi+2Ld
	QY2Kf0ikpmRoFWjLUtOAaSiff/REz06Jzpn9migUu
X-Gm-Gg: AeBDietxQv6zxrnpFn2BD7J69bH3pF5qSudA3iLhJHdnWtTAMOcuFo8xXm+PaROaOyD
	C2S81KXWyPnp0UfeGBmTKSpOhHV/WpXbg2pCH2e0JwWDN7vHEIymsXnCFdO+i9JN21/MLWCyat2
	4umToqNI+Jk1uSDW+AecIJ87qmem+qOJII8fIX/lVXz5+udcH/v1YRR0+OU8iA/M4C1T4z7Qc1n
	ZNgDWPcqQKSy4MBE6g+NuKQFkVKV7eI/DMbS03aSumw+y5KWzW6yA0PRGIsMnTFKINGB3d8Nbox
	UaS0n3pTmUZraEAMDxffOZEnkmzVnD9EAq3OrX/3Cdgwte7pXDu7HsB3hr3Iq8vZFqMp35ps
X-Received: by 2002:a05:622a:5e17:b0:50f:bea3:9475 with SMTP id
 d75a77b69052e-5100cbe3608mr1392371cf.14.1777313544554; Mon, 27 Apr 2026
 11:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427152854.101171-1-chao.gao@intel.com> <20260427152854.101171-2-chao.gao@intel.com>
In-Reply-To: <20260427152854.101171-2-chao.gao@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 27 Apr 2026 11:12:12 -0700
X-Gm-Features: AVHnY4L5q1UHrVRtKqKnRAb0L10M9ZeW4_EVR8OMjdp9PtmE7Gxn7pe3CDO74Ws
Message-ID: <CAGtprH8mcz4HTBQvnSfWuZ_yErDUKq9PX3Mr55KAfw2VK_o9Mg@mail.gmail.com>
Subject: Re: [PATCH v8 01/21] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, binbin.wu@linux.intel.com, 
	dave.hansen@linux.intel.com, djbw@kernel.org, ira.weiny@intel.com, 
	kai.huang@intel.com, kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org, 
	pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com, 
	sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com, 
	vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 8:30=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrote=
:
>
> From: Kai Huang <kai.huang@intel.com>
>
> TDX host core code implements three seamcall*() helpers to make SEAMCALLs
> to the TDX module.  Currently, they are implemented in <asm/tdx.h> and
> are exposed to other kernel code which includes <asm/tdx.h>.
>
> However, other than the TDX host core, seamcall*() are not expected to
> be used by other kernel code directly.  For instance, for all SEAMCALLs
> that are used by KVM, the TDX host core exports a wrapper function for
> each of them.
>
> Move seamcall*() and related code out of <asm/tdx.h> and make them only
> visible to TDX host core.
>
> Since TDX host core tdx.c is already very heavy, don't put low level
> seamcall*() code there but to a new dedicated "seamcall_internal.h".  Als=
o,
> currently tdx.c has seamcall_prerr*() helpers which additionally print
> error message when calling seamcall*() fails.  Move them to
> "seamcall_internal.h" as well. In such way all low level SEAMCALL helpers
> are in a dedicated place, which is much more readable.
>
> Copy the copyright notice from the original files and consolidate the
> date ranges to:
>
>         Copyright (C) 2021-2023 Intel Corporation
>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Vishal Annapurve <vannapurve@google.com>

Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48B54B1A3
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060695; cv=pass; b=sL+V6sPN1s8jXqQGTB2Q2UzZgQA92D6gDRvterkfwrnHGLxBqMWz02GVkOLsxWxWSAnY3xSRnvp9oTcQBVYr7NPB0xjYMsjxCCxhjnEwc63u9nZaOEsV1D0IvMpwmaIOHFC2q13TPbw3OtTQoT7pcT2G1G60wSdah1q5qjZb0Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060695; c=relaxed/simple;
	bh=/v015ZI2cSC/eglT0djeEARyRLz+9lux+yuLnGVDWVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbRFPeEwk/rEzdaApnWfGwHUqdT0nRXD9G5CUuFI2pXMrx7K63T7eVWSSYo6ILBztRzzDVpfYLt/jeCKQLTfF40gTbHbntQvV1gi6l94yBNVaHhRr9MyScQMR+Lb+4y2Xz8v0A2LNj4fvHxSbrBki/yDmo3teAwxb8Q6RlTr+gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDJL30jt; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDJL30jt"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5302b692c8eso234611cf.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 10:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789060687; cv=none;
        d=google.com; s=arc-20260327;
        b=eXaSlYJLXclZoa47+iWIy+r0XtnD+f8I874HMUFGVMtLD1PDV51Fv08pP5aQBGDwq+
         fyrPndCqFn2rhttkedsaiC4nnqNJ4C9r9cqvG3P46l7hS12cFSHBJPEy/FXO8PW4Mfij
         ISXn43Xjdt8CM7rJDjusP+Lyi8YoCGu7iK1n0UMJMaIRr/cur5/4c2V/0J2FrgsLx5uv
         Y+qczXj7em7eznt1X7+XtZvxWRPlHjYMx7QiS0eQjQWGjk2Ug61N5za1qUqEkhEBaFoG
         VCVQ950z1OqVCDQ363WzHLHYU8eurNF+mES3izfxDYzyPrO9vR7oxBjKEb6xwNs8HyCn
         OpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=waC8vF2dtDUS7XnDxfIfPJDfjo2BuEf9qI8Li791zgk=;
        fh=8H2cHrlMOAqwBb+H0o1kyddUs5U4z1sLXe0/DLdTZ5g=;
        b=CFBrteSRoY6fFyFA0uIpctH/HK+NMZzsdVaWgFoNt1p2nDT/ywxVy5VfwCeXtmbTMs
         pdWKoyXmaTjqzpmOns9Q2O53oPW1hb5ddDlSz604Rc3SzgtKvIC7EBCfXoF3wmwCCvHD
         p9VabydA3VbuAFlyXVfJ3LNP7VGldZsdDXNe2zwn5Se8dqxm69Hx0HpBH4K2dFllakLa
         lG9AEPGX/VTg/9Ym6sGTI4xOaPEtSGbQVk6FTSxtK1uHDp0TVRsJoswa18js6vEUwYN1
         fHX+GZD7y3VHPofgkHnQPacy4bazVm6eglFOEnqVSKGo5pCrb5ZfOBsN0r/yx8ttih3O
         +lzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789060687; x=1789665487; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waC8vF2dtDUS7XnDxfIfPJDfjo2BuEf9qI8Li791zgk=;
        b=JDJL30jtA1f9hKxncQhHSP8fghV2HHC41q6CuqMPRJh5t2lX6iy++zxZctLPfffbi0
         nwgvcuhU4gsKptBdiHFwUfD81TchhbCIfU5xyN8OQ4FmSdPjTqCW7AEaZKuPEWNNdh9f
         i8UmmSZMmvqKufimOlQMHTRd53aosdggEXpOSE9FaW7WaRL+OtClbuxdpunTkGAUj2px
         ZBHanqlerq+CM1RL6jVnVKVXl2DpgLGah4H+BHFFzlOWFJKjfxGo8kUiI9UK/n01/g4E
         hkwDs15Fo0ZTb/0kvzPSUHpP0XyHlaQNALZ5N7ZdnAbvW1Xb3a3mOXXFpPqBEzGq/97K
         RU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060687; x=1789665487;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=waC8vF2dtDUS7XnDxfIfPJDfjo2BuEf9qI8Li791zgk=;
        b=XLo6frt2E2T17a3XS5uKPWRS4crxJu4qXWlsXaP7LDm1hjzAVhnFRfX9WN/0bQW3jL
         jD9nNX9kRFsGX7WDlVhYWD+BIEt6GysGaYli4OdqWZwyVhJAmcl9RUAbGi6lZp6ImLw1
         kn7PdM1UiRlxcEL+BQTfgJ8qaboToL5eB4a2HS1rzV5KtC+8PP4zFlwuMOLv5RTMzA0f
         qglCjK7hD4eo099by0ec74HF0iHiH/ggFZrsTjZCY1Uo5vbyURtGVmt4cd0lx+uOM2oE
         wkfrIYxtRX5quAOO6x7HRlb11257W8zAFH90KRXj069E99SEddplaj61d6TuAke7qbLc
         c4lw==
X-Forwarded-Encrypted: i=1; AKwUvByhDxJ0SjuAKP6pi1/WG/JrC3mL70HF/ShuQ0RSm+h6a/rUhmuDdVBcxq+v2sdmYuWENeg=@vger.kernel.org
X-Gm-Message-State: AFuF++l10fQ/iyf0ldwcWB40uU/Krkkc8huo22Pzng8ZklRJbH4ImDlj
	+LAVs9aVp9nAV/1C6sf20onoek9DVGg6BqlC3WG8amANn1mXeCfNedNEKn3cBymNjGtZ4hacTVG
	tuThhMMHuNbK8wIs5a/Vj5zfJKYMo+k43zuYzvSkf8LJd+EAHW3HhjwDN
X-Gm-Gg: AYBFou3ky4l0RCl3AplvR5ZpDjstp2pLcPbI1oNfQ/crv0h491bS9sGWIsf8iEBjhW4
	zZyMIxNK+Qhb4GQvX5GxcsF2Ih9TnI0gKehw892x4Imdd1Y0HVrce16X288yrgP9dNP08ZUTVHT
	c/2OmNVvuA+EKA63ibwPze6NMMmkIAU+W+xLGrbbUJYzpWKpXDyiCZDFfifwSEl9J0Us/k4yRGr
	S5TxT8P8fKOXy7nuFxXeTLlj/gSPIwg0Me0PyomR5AHtttGRrUPfQh0PuiCGQKwFK5ZlG95EPdV
	YoY/oqTgipzNbcdIihbg2k1K80qaQAJOHdhn99bEPGaoNBCqSFVKRVJVknA2870i8OQvcNfCDek
	CeDZRh6fvVvNZTZXrRy+F
X-Received: by 2002:a05:6820:3404:10b0:6b1:4a71:775a with SMTP id
 006d021491bc7-6c0bae083dcmr10697eaf.19.1789060331694; Thu, 10 Sep 2026
 10:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com> <20260910162343.4092060-3-elver@google.com>
 <aqLbHvD5lqQP8PRd@google.com>
In-Reply-To: <aqLbHvD5lqQP8PRd@google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 10 Sep 2026 19:11:34 +0200
X-Gm-Features: AcwNN1X74FFLXo3tfvC8iadNXegd-2_Lr_knvP8WkNgyIr-_V-yJ7lG2ubIqDNU
Message-ID: <CANpmjNOZPFQ9FcaA6+GH9PZ8DRyEMYW3+FKBO9B3d2CY+2C-5w@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] KVM: Allow reading memslots while holding slots_arch_lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sept 2026 at 18:30, Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Sep 10, 2026, Marco Elver wrote:
> > kvm_swap_active_memslots() updates kvm->memslots[as_id] while holding both
> > kvm->slots_lock and kvm->slots_arch_lock. Holding either lock guarantees
> > that memslots cannot be concurrently modified.
>
> Sure, but that's irrelevant.  The goal of the srcu_dereference_check() is to
> ensure that readers see a stable view of the VM's overall memory, not simply that
> kvm->memslots can't be written.

Functionally, this is irrelevant for readers. But under lockdep it
isn't for writers: srcu_dereference_check() (with lockdep) asserts
that the srcu reader-lock is held, or the condition 'c' holds, which
here is holding any of the writer locks.

> > Allow reading memslots in __kvm_memslots() when kvm->slots_arch_lock is
> > held.
>
> Why?

Holding any of the writer locks guarantees no concurrent modification;
therefore, if any writer lock is held, it's not required that the srcu
reader-lock is held. There are few places where only either slots_lock
or slots_arch_lock is held, which is sufficient for reading.

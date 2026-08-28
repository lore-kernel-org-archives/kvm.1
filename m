Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22F39DBFD
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957546; cv=pass; b=m7gJ3C52jTVIAf5BQwIFxJgtG8ENov9CCdQY1AmOoIarA4FVER48Y9qNRVsrJ/3dj9cqcRiKvLhxiamrPUF+on6UljNGnFjtJCuD6peBvUmzK5Amr5GijMX9ZgSxMEEpNJKa4AtSTVRIS3JSl7zYTAe6E5646IRxggxzmViYiGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957546; c=relaxed/simple;
	bh=WrsvomBoIOTykSZbu/ot0FOcIRpwAK7V3umLl1yq6rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEGLvxKSitdw/xnMS/zacnd4m4HY7SJ6hj8iKtQF+FWk9QyQ8M7zQjgbEKQEL61341k8FnuevwOtEQE4xb91WZGT9j82HdWi5KTrJ5TW8q7UFf/1jXiI2QxGVb+avst+5x+U6YDeitYuhD7OvjP/+qSwsuxI7K9oT5Znn5CTbbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dXknUyG9; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXknUyG9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52fac937235so44781cf.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 15:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787957544; cv=none;
        d=google.com; s=arc-20260327;
        b=OO9VDPF3EBcXMKXonBCyhXfkVIxxMwnyAhjwVmEe2dww7tSjVRW7X+ArmeMyD5q/Jx
         3G6Co41qUJ/LNVQ9xlq3F9Qn9a86hNt2vqenCSZe5ssKiSBBpNzHxr8UwOHHziURrCpH
         Sbup43W9T1dLGzzU9m5PyyF3VExp4kEbHcwGNZLDjISD3BQqr1BudS6P8oUSVyRxbgqk
         ORKeI0rHQLKiDQdvExIHig1XH7OPtn7RB9VaEK0vAeqSBVNxbxCLG3PJN+NzpODXWYDw
         vDKumYbB1ERAUv5dNf9tjXtqR6FMIzIKSDOviCuA6GItbt21v+eD8+sYOFkCS4Ff7/+o
         5g/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Awwf+UFW2ONQrXT/1UuPyCRQCWHRON77Fg6o5pZxO10=;
        fh=Ck+oSQkh7siq1BuYj4MRLFUr/GyF+iRwWVrXMPbIQz4=;
        b=K9BV36WvKSiKR/ggSiT3MPZr87qEQPf57HI2RI8jOvNd5ObtXVpUOvGdLPaG80si3L
         mJgLk7GCkFoUC1KQdZcF9B2zqpLyBqz40iy9B35kOSnFxbBUqF3pGfGfwua8tPBWbWW3
         qdcp6xn+F6WOTv2Wd+bUfl/QxWgDAX+Jqt3Lo9GGDX6GfdUtBncRliquw45jkltQOvPC
         p4nsGZIN0m6QAGEU6ETjk7RxJKLsTZ10lVItXCiS4eFgn1Y3jkvzYuM2WGU+kcDkFe7K
         4BahjkjoULFaHdGxAwxfx+CWZ/EcvSzktBCQTg8wUz4C3pw7mkx6p9PKwlV1hlgwA/ck
         SnDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787957544; x=1788562344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Awwf+UFW2ONQrXT/1UuPyCRQCWHRON77Fg6o5pZxO10=;
        b=dXknUyG91mtcfBGaWwFNQ5riozqqkSfZCg6+5WAdFl1bWRmMCszAN9PzJVDYz0326D
         dOrC0TKZQ/8C6nLA1pAMY7U6FWhP1WSa6ipJP1MaTtd2crYDLY+GoHUezzRMGyHaloZa
         5GHvkk5q1pGD7rysF78hRGA08fM7KfExoKVOjhIfqpVnEqzWGQ58iaA7GNYOwwK6CtHN
         CWwlYoY+QAn2NSOpLZba2Y3Y/zgV6EeGe32cyYzvYWcbeE8dYHQVzj5e1DNsz7lRhvG6
         F+rLm+EaCohm30vRM9+Q1g43hfVKdZ3kXOOr+j6PQ+VuLAzEX1gDYDZJz6b4sUVIVucb
         VPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787957544; x=1788562344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Awwf+UFW2ONQrXT/1UuPyCRQCWHRON77Fg6o5pZxO10=;
        b=brmrKN5FW2+EbxbQQjsoA0qiTeMTL01lIcfCPls0o+vh1ncwHZUUEml9aYHRT/cxoz
         FE46fmneqn2pV9wtKEW4P7qQasMkr01L+Z404Zb3KEytPHm1a57MMRX5YuyWGBhGkwOk
         I73PPmUs7w2AoR0na0F+N1Jnj805JtXJziuUe7cxIgFRx3drU2GfeNBSLFQf/oTRBweY
         Ig7tVZBKTHd8yFVjr2AIdLBmC5YPQqwDeqShNBSgadp2U5xl/0Zbw/Y4Gufd0Lrirlp/
         vtWvGYGmUS0rT1xfpVZ1X/rwt73h2441nWMP/dFcwF21kCRgLUcpCqYLAG22l1eU7aRi
         VIWg==
X-Gm-Message-State: AFuF++lPLORjHy8Wuoq8BGLqzIh/hBHkn78moKm5vGAgiyTSaBWsBMe7
	Yew/ERtKsAzFtJy/sQYZVC7qs/5f0WINf5BGZ404GnNLGBcH2uQOAotrtuIq4LvSgV2MgeUt1+Y
	+WltFLQjIWsoDHShnCsjLoy2ZGwbJqBlOfybInza+
X-Gm-Gg: AR+sD13WgVDQ2YSePGDbTIwjG520urIXT2zSfXg5o+ldBBiGZj9mIdHsSV6HIzAZBPl
	9tWBgK1wRP28Me0EJddsOdOR6az2LJaLWXBwLuO25iBhlYVrPRjg3pcv0n140lHa0zj4tgoaBIH
	1iEgyjCylG6ce3QrJg4PPYcYfZD6556eVPH+8s8T+A7xX21bPs1RRS7N9P6caWFFAoteOUJC/Vo
	gXUzhrlwYnMUUK3TQHKBlFMiGiR9ihCherdaQL4GAQ9RGj4/Srzk1ZnCGijhQM6N34P6B3pUoWa
	p0Aq/dA5oZrZb67FXy9m8vto/mXRz/3KP4H9Fpv925soPyZJKLSAseUBEKs3OyW2m1cj+sRCWjD
	t6i2zutfgWg==
X-Received: by 2002:ac8:6109:0:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-52ff710cdc4mr4682421cf.14.1787957543079; Fri, 28 Aug 2026
 15:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
 <20260806020850.1221381-8-rick.p.edgecombe@intel.com> <CAGtprH8XJ+SbxQLTowch3DR6N1NSMUKyVnGf0hv5N+iKWT3q7A@mail.gmail.com>
 <74bc9f2695959f335f2f502ded1ae7c944fae13a.camel@intel.com>
In-Reply-To: <74bc9f2695959f335f2f502ded1ae7c944fae13a.camel@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 28 Aug 2026 15:52:12 -0700
X-Gm-Features: AcwNN1XH7bepxRkIbUoAM3EdldcwR19TvPyf1EHxlXjEwu1TNfCd8rn9aVcKinM
Message-ID: <CAGtprH-WL9MioyJUwJf7XK8O+UM6d1hUwWMtPj0AWC4FdBxScg@mail.gmail.com>
Subject: Re: [PATCH v9 07/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"hongyu.ning@linux.intel.com" <hongyu.ning@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:40=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2026-08-28 at 15:18 -0700, Vishal Annapurve wrote:
> > > +
> > > +static int alloc_pamt_array(struct page **pamt_pages, struct tdx_pam=
t_cache
> > > *cache)
> > >   {
> > >          int i, j;
> > >
> > >          for (i =3D 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
> > > -               pamt_pages[i] =3D alloc_page(GFP_KERNEL_ACCOUNT);
> > > +               pamt_pages[i] =3D alloc_dpamt_page(cache);
> > >                  if (!pamt_pages[i])
> > >                          goto err;
> > >          }
> >
> > If the alloc_dpamt_page() was able to allocate a single page (not
> > two), should the partial allocation in the "err" handling return the
> > allocated page back to the cache?
>
> I think no? In the case of the cache not having sufficient pages, it is a=
 bug.
> And if things go wrong, I don't see a risk of big security issue. So opti=
mizing
> for more efficiently handling bug doesn't seem worth it.

Sounds good.

There is another allocation in tdx_pamt_get() that consumes the pages
from the dpamt page cache but returns memory back to the buddy
allocator. I think it's not particularly harmful, as the default
top-up should cover the maximum spt's in the fault path. But do you
have any additional thoughts on that?

>
> >
> > We observed similar failures internally with a slightly customized
> > setup which had retries for pamt cache allocations in the fault path
> > due to SEMCALL failures with older TDX module functionality.
>
> The best course of action is of course to fix the TDX module bug. I assum=
e this
> already happened. This is the default upstream approach for that kind of =
thing
> across both subsystems. But it sounds like this case is even more special=
,
> because handling the specific bug would involve other code that is missin=
g.
>
> That said, this code can definitely grow in the future if we seem some us=
er
> value for something. But can we please just call this basic version good =
enough,
> and build on it later?

Sounds reasonable.

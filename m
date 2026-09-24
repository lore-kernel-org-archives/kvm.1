Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764326AE5
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208230; cv=pass; b=DQOKadInItPlGA4B5eDdWA1vIUoiejz5WPtr+KSoYUiqKOyYG5Kx8iiczB0NBGl3BJgDzSGXULrjO3QIfLUObxvxbutoChmy8HT4GV9BoKVFlpK+4t6m53K/x9mFO2ixa/srZijtAzveIylWCiByLJT4pvLvqgM9wywDcjQGqYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208230; c=relaxed/simple;
	bh=i5wuNzpc5WDc6HWeWDqM/EGiLl0MHtsGMySScfyZ8rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeSkSkwWV16gcufF4dIA9cc0J6M7wrNxgKkgmwOxwFV5eaJi0PnCnvuDlID/5ogXei85akiPncvO08gH1H6CMPUpCAJe+pDIqEALOnzlb5qCnY4eb2z3bG/EGWyoPgv6GOr0435F5V+NgYidMS7ogFc6RBnubW4a1BFTfG3WraA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQJFl+Fu; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQJFl+Fu"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52faa58bff5so61321cf.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790208228; cv=none;
        d=google.com; s=arc-20260327;
        b=Kldn4ey23u9rM+PunX/spbn9jQbXHascse6yl0eRymSSkB0xtnZyxa/YPjok2/HgcN
         rIhuEpl1AszHWJ6tfdwaHzHNXX0w4olC0YXNdfTIyqO6RysOEorsq8BlsSh8LSz16s8w
         p9VzN6KH+ybgPnBpX6SaGToKsOoqgSuSZ/69bf/Rah1YKgXalbAWMi89DkDLIVu+SbSc
         qvg38XHSqyiN1H9mCz4lRkL3OqvsZSyMLRuGiJe/LgvRn4zMFcoEDQGqCsaK05NMO34M
         RBy0xSiOAZQKnB0VAbY3j3L9OsJotaVoUatJE1z+7pEFbWNmEs9nnWZCU9cbgjczwnTH
         /3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i5wuNzpc5WDc6HWeWDqM/EGiLl0MHtsGMySScfyZ8rs=;
        fh=ppP0ayaIkhDxZ6t1ezFDTd8gaGNWHV3hE+ngFXDkgV8=;
        b=LqoAggrvHUAOSo4hUznvPnxSANdDpYX4VxY9lsho+P0y3qvegUhsJK/u1by+zaLRuD
         lxZ56fnN5RcWLsD5lVgrC4aaBdwyQGNybmHArZOQ5l/8UkqabrTzxN83Xxo7RBHfU5gu
         fQOz9EgB1l4+yVX+EfNlqTy1QmuJBY227AjJG43xVDAGD/XaJEQIXIu/sVBHTgYXAxJW
         M4sMoLqBdV4UP55sz9X7zF2j+CbrNwUDFCvLWQk1MKvRlPC7Y/vn62mTZw+SYZSgJ5dC
         30Kb5Wax8Ty4m3dpVtgBk1B6K5CFjmOmY5QVPXTij9UrUil38qYvIhZif0P5rh/bh9t0
         emnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790208228; x=1790813028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5wuNzpc5WDc6HWeWDqM/EGiLl0MHtsGMySScfyZ8rs=;
        b=XQJFl+Fu5AWt/OHnSVp8nDxu6JTcigtAYVNak6nyy42xLOGu42vGLOVby02sRQysky
         QuOfez8Kk0AWNtPIEHSTAJ6SgvnofLTdpLCXMjW/ugKUe+yu1LykZNmjdeoSeCko2z22
         UghWtFeoGIEzTpd+n7MK7OrAXgUhXlLRQWynbVBwWOfzusHFAeMqf9ztRys8iL8n81Tc
         SwxHTODItLFNwXmMEtSlRPTjxj29HGUUDAeAxN1PuDdOaP9iHzchtN62ekSk3/eXq3cE
         C97ELE2FecS1MhIfWkLWaqx1H86CWDAGReMRNG9H/0MlLAay37dlKWFDaor/ooiPuyFy
         yhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790208228; x=1790813028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5wuNzpc5WDc6HWeWDqM/EGiLl0MHtsGMySScfyZ8rs=;
        b=Itt1+C7Sl8KX7GV2TcZdgYIosavrZw4qUSdK6F3PKr7GYF0flJhNxnNvBOfn4eb25z
         XYooH1rp3AsQjRKSH6wti178FwwAMAhRjVSAkZ2lMEHZaWvSPGChL2vow9HGAIIFRhBu
         tEAyUdvDvvlbL3xOaj7l5lZGfiZg2Jt/QwD+CberBVp17owAGUZV5t/6BuzyW302RbsJ
         GVV/TLHUXyL+i+3KTuLpRpetezN//gvwK3AC8QCQjxbb/VrMWVZZe5uHZESNjzUJZgyw
         +KFdCBcr1tgwfCPpxUKW6E4Fnlwe17PmuSgAZnl1F1vchwH/no9WMPVjmo2eUlDfEjGq
         ypFw==
X-Forwarded-Encrypted: i=1; AKwUvBz8RfodFLBHYPy5pMOaFBzMUrnGzdUgI5/G8cx6Lf9ETetLHI0mim0N3VIL1v0WToKRHvc=@vger.kernel.org
X-Gm-Message-State: AFuF++k420gbTKr6HzXDK6xDz3+vNWOT0vV6xTjUJVfvSDxVu3a61iQg
	MoHXybIOCOiArSEOhuQuckZjn6M+MfLbYq7XkhF0rcrI0TTvl9kjXqjWVQcyB96mnEt9+xFMmvj
	IdKIpWr8RnQHGUdqiGpSR5gd4x6Xuqxly+w8LFq5B
X-Gm-Gg: AYBFou0Txg4H8CWS8x+51MWnLXolHh1FSBtnuU+nLveFhsbXeyx6OrGMZPRqowMCTzG
	GtIPRbTRnAMQWp7MDSCC2uhrPz8zSPYMr5B771efkO5AMBOiA6CdvEjjkvBizEXh5Em8oy0+u0U
	vTxcbcxZg34xFzuTjyo4hwC5/4Q5CEPbzLk3BnLPAzQgTy7ovnCW06CRizAt7g+Z5yE8iXgstIp
	4hI5tPJ5YFS6/urRREFuKeoSbAb+GYpvVOYZskzrDbcZnVLq2bVihgqLLPsNPY+Y/XtZdGBJR4t
	wzve38YpsAdLm6ht+U6WJgMbO1QxH59igrtJlbZmpGZgQrWqGF2nB7rpRmocctF1PcbXCpC2C0F
	TSarejkNpVPDCVrVt/qwWaN8=
X-Received: by 2002:a05:622a:2507:b0:531:6de:6028 with SMTP id
 d75a77b69052e-532f9d11258mr7798591cf.13.1790208227286; Wed, 23 Sep 2026
 17:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com> <arG3KvaVqWCDAyM9@intel.com>
 <12541025-6579-4baf-911d-dcf1453b3e27@intel.com> <CAGtprH8t2OAh59XeWGtBLUX4JXaJm_NDpPE1ZJeGTjppKWrSLA@mail.gmail.com>
In-Reply-To: <CAGtprH8t2OAh59XeWGtBLUX4JXaJm_NDpPE1ZJeGTjppKWrSLA@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 23 Sep 2026 17:03:35 -0700
X-Gm-Features: AclHuK-Kzmj2oaU6ic8oRVJmNSiD7U5A7TObREdVllm9wJeM4ytUhxflIb0kq_I
Message-ID: <CAGtprH8syQUQf9PjPe8o6rBFSg+01k=Hb4cvvn3TqED3uWb+yQ@mail.gmail.com>
Subject: Re: TDG quote analysis
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Fang <peter.fang@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 9:09=E2=80=AFPM Vishal Annapurve <vannapurve@google=
.com> wrote:
>
> On Mon, Sep 21, 2026 at 4:06=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 9/21/26 16:00, Peter Fang wrote:
> > >> is how to hide the fact that someone in the future might think follo=
wing AMD's
> > >> lead and putting a precious resource into a tiny microprosser on a s=
low bus is a
> > >> fantastic idea.
> > > As shocking as it sounds, there are actually cloud providers out ther=
e
> > > that are wanting this, or at the very least wanting to see how it goe=
s
> > > in real deployment. I think memory side channel attacks are a real
> > > concern for some of them. But yeah this is not great from a performan=
ce
> > > perspective.
> >
> > I'll believe it when I see it (on this mailing list).
> >
> > If folks want complexity and low performance in the kernel for
> > side-channel defense, then I'm your guy. I've made half a career out of
> > it. All that I ask is that they come and ask for it in the open. Here,
> > please.
>
> Google is tracking use cases for deploying S3M-based attestation for
> both TDX guest workloads and host workloads.
>

To clarify this statement further and address the discussion from the
PUCK meeting: Google is tracking use cases for deploying S3M based
signing of attestation quotes (or S3M-based quoting as referred to in
this thread) for TDX guest workloads.

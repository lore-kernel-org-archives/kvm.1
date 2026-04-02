Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DD3EDAA2
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142719; cv=pass; b=OWW9s2t8WqVTbDjLk13cdTzF+rUrn+U1en7yUwMro0YYXpiwu/+UQcjWJkgvgQnF3ESYMp+cpGCQZye8Jd7cgs4RI+QCtu3I8V6FQ14jOSyTHbwoek7ZMuSUz4KPe36iYvD3u50nPocEJ7XL7s3amOWb0D63oyVsvu5Y4BV/h/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142719; c=relaxed/simple;
	bh=w+loe5TWlSXN9U6ODJ58b3CvRng0SQKuEDz0GLsUofI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj+pD4LJBBILe0GOrd/REQz5hd/moP3TH+LQLVTk5ees2dcTLZ4mJvEc8HAOz9JDmBwPx9Q0Cdj+Zsjits+SiUEtsc2vTUo/WejWny6u685mO75a5m8Y7yf6IhE9jY1TIV6IvmwLrBfiUyVroIsgUoQ7xjiWgI8TR8n60xpseDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzfAkDLN; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzfAkDLN"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b6c45781aso752361cf.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775142717; cv=none;
        d=google.com; s=arc-20240605;
        b=T0yjEhEI80Dk35RiHpO9JlVqXZKW7TpzXIQiaKcHxhQ9WQSfGqV8kNy8a0Ee/eutOf
         ku5Wf5EEtrB+kwnS5vCQrOvPn2icsCFGaqGsMDpMgZWSLEv15R9Xub/JrCkdQh9TUSUI
         e0umXFpU+xBQ92kKA8S98SkWIoh8F/VCdeKRilY5lGX9ID5MA2IxjHOM++HnHkIgtmyV
         MN8GZEXAn+h2iMX+d8a04s9hDVQXOsGShQtHIsQ6Rnu3XK8opSEbND2vF2K4HEyqNjVG
         R84ZeT2HqibGFRDnkxw3PY1JwCoOj+QxHpitN0MiGOUXZsHtD4OWaRVQuhgcdOk1fXtO
         Bb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        fh=b0KW761fcRwUH+en7QiQvSFRebWiNSvUJiYi8yTTAQM=;
        b=IwDSxtUmyWG8/2yEJr1eaXC9lc/wNhx+OgZMqSHoq8NfEEmCeVfin9pOfLebYW6mri
         uDTlewpiVS4iwcwbYBG/NgLyHBljMVqNzBqXCA3MTz9V3wL/XEYJQEIxUi6eB32apYg4
         MwQlxJxi/Ibngh6j7Q/eSUyCkSgLZ5EbAC5+xzxp6Sy7LRGIJxfZVAqXDhFvBT1ZBryB
         /qVFPHyLnXvjNpC0tbloZHCXNUjOZUn7ddc0RAho9g5kmOahUc1W0U2ZL6mP8reome1+
         uywqLZjM76o8wI/q3NLRd1iho7jX2AqPVU4y9+3hoGtq9otOkdAYtCFgxQttDxO8A+hv
         vZwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775142717; x=1775747517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        b=DzfAkDLNJfbjW8FIAqG4U09cR6ik9V5jcjIvcGQ+97r2HgdVCPsa4PLEHNUU6Jxul0
         Pgp5gTerdDyDf5e5HRQtwr9SEbue+crOGV4MCbP1CkwfMqanLnkbDZchNk+9GS8MkirG
         9OB/sDhKSKWtocpiLulvtVcu+Q+qvdFb9lzg0qxBrQCyQCLm/AdngBaLUkEoT5EqZmaf
         Oub1FeRjW0SDpOGmNVmZFumLk4VId8pjSBe71g8PqXGczOKkuntE8qt4T2nZJK1jy2VQ
         mFQVegl1JZYJE2hk/p8ospgFEH6iSgfMhLpjDvGo6tOG5+zTtj94NMkgRgPIe+c8VsDE
         rGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142717; x=1775747517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9DxMkkgytWR9am+1WQeQWH9Iy5mfAjxrdhUB29Lo7Q=;
        b=pMjLak8YizGyPfTmUSziUX9iAzUfjyCufcbQdfP+SXNFKjV0GgfNtRI17Q+zts+LRA
         U1krYGXFnnDi6CHunSzwv/2y5qT4SJhubVcefc7YCZ+mxCCt+g651kcls7s8Lg1hbWRp
         KbPLwxDPaSQTsFg2A840VXnZCZwzrd9nTtUnwLu/xtz2OmNQEeOLHGsoH4VKgpfgKcIJ
         CXja5ms7JzqY+NHLrJlVXKddO1DkbEl7LkVwbqBQs3Bc1t6ElVpXGzMHGjcJkfLb6hAQ
         Ger59v1zcEaYXEKIRTneLNzyXoiSSQ8QTg6ROgzIoO/hFnnn76AsMNP7ZP52UNmYq4my
         r5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUDnEdZypX2XljaqdDSqSmqhuzkq36J1pmEkvXJgeCMWjwmJBrKNrptf30RL8RSuJg9Mp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDHVgXMstJY6cJtfWGprBo0eT9yXubjxJHLNR33sf4tpzE8x+
	uBRoWyK9iFUbCrnNpNhk8CV1EI7sSMzQCjkQ8HHk0ZyNkAO03ACaPMmYX2wg2bJdUrzAgBNsP8h
	TZf3XdG942FuE0jdtsMOg+jALNlje26lQp9ucX0XH
X-Gm-Gg: ATEYQzzJToZvbRay7By6B0A/HHZYrMvr/S6HQpUxQfyTJTqjGMOFVfS0y52xm6K7YdX
	VzXMeMpdA5yh78LWA+B0OJA+M7Nmt8yfPwTxll/sqUY2hyhqN8/IuqFJbsLghQInBQToExlLtcC
	u2MHN3mf87FOmTIf1rxP+rVMg9iIMBe66lgfrxEPLLqa8GWEI3wlcUzS1ta5wXaSPetbv802ss6
	3Rxzql+S1CEMtgzsJapGUr4s3+fWj7Niykf1brcHIW1qdSoiCCWgaiGFv9tzUhdFf8IwHYegLo0
	tgTilhd2cwDYOnJ4a2FRufuzPf9Fa90zpwa+ug==
X-Received: by 2002:ac8:6907:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-50d504ad8ddmr11393801cf.3.1775142716382; Thu, 02 Apr 2026
 08:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local> <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
 <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local> <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
 <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
In-Reply-To: <495a4331-6575-4eb5-91a5-245ab0ad3637@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 2 Apr 2026 08:11:44 -0700
X-Gm-Features: AQROBzDDBiQJXBj1ghnJLgm5n9vUtQ0-AtJqWv_KWozRinmr8YW0M_6ikqdSFOA
Message-ID: <CAJuCfpEn53AgKkjLBN2AeaHxxV8vHVj697Cb=Hb-U8LisNztxw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:19=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kernel=
.org> wrote:
>
> On Tue, Mar 31, 2026 at 01:14:51PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Mar 31, 2026 at 11:47=E2=80=AFAM Lorenzo Stoakes (Oracle)
> > <ljs@kernel.org> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > > > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > > >
> > > > > > Instead? That is, assuming we really need to care about this at=
 all.
> > > > > >
> > > > > > But I think I don't like this change at all?
> > > > >
> > > > > Yeah, this was the part I wasn't sure if it's worth adding. With =
your
> > > > > vote confirming my scepticism I'll go ahead and remove the parts =
I
> > > > > added to avoid extra vma_start_write_killable() call (3 instances=
 in
> > > > > all) and will post v7.
> > > >
> > > > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advic=
e on
> > > > v7.
> > > >
> > >
> > > Ack, if we just drop the problematic bits we might still be fine for =
7.1 :)
> >
> > Let's get your cleanup first and then see where we are. I also hate
> > the way I have to report a fake error code, so with that cleanup the
> > patchset should be much nicer.
>
> Ack, yeah it's horrid, + _my fault_ :)

No worries, I can wait.

>
> I can put something together now perhaps that can potentially be queued u=
p for
> 7.2 at 7.1-rc1.

Thanks! That would be appreciated.

>
> Cheers, Lorenzo

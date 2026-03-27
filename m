Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26097392C29
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645258; cv=pass; b=gtnocptgtUnr9lqNHeD4EykhjPbN/EboQ5ZUNLfED3ua6mGFEIIj8jzlXLTStr62LkSr95g3ojsEa+FmkQrTBOtOx+M2O5ufJj9NdEN92l/RBA2mp0oYW9OjpNfu8esJXasd2qwu925kLe1dsvqGfAsWUW7vQOnGPGq1w7Rt01M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645258; c=relaxed/simple;
	bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gck1+N4qDXmxqPWxm918kI4KFLBZztGwBHihauB5AAixbXcHtDxSAwqem4pl+AbAnvCOzScCwCEryAEi4grUfLWJNTJKo6zC9Wxp9qz2hCwpc1LuVqmwqUfzFPx9EelpzGfDUEx6BDPASrUuqkFfL+cd+Jyd2kT35tlm14WmqRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5TK6hWr; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5TK6hWr"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5091ed02c54so50461cf.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774645256; cv=none;
        d=google.com; s=arc-20240605;
        b=Jjzm64Pou6tYFPSftFBSyUll3J/KojG/YgZWACr5+v6WF8/nPbCAHlJmtEjXgOhBuf
         NZ4hswPdzhZx2MW3R5Q6PQFO6XwpLwOwakEJrq6uQQq1AwVYxWjwLMkklarE2Yx/G3ay
         BT3w9dhJ6hVipaaNbPQXb5U/XLNTgZUdeXxXW2r2M4CCSNBxn+9SlE2TqYZVGlhb1unk
         ZDUMmY6H1K+Lmho81mf8rwmAWJTInndtBV05OoqLG6IFGz4yyWCuGutkaWpKXrjdZrKx
         6/T13ttTR+GWaq30LQUTrww6nupv3C+PGomV552hi6/66kLOt8Q2fvHDvsRgQnyCke5/
         wxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        fh=u8FOVQ5MOat3mLyLv9HBSSl3pF2fbDcqHfMUpAtgZms=;
        b=FVXC367q6nvgnnIumXBKP0W1ncNNvv94QABjN1E4ASf7EIk82CFwy5HyL0DWHgJb5e
         nw7dBEj0rDIpsXxu4WgyvaTZN79Tqc5nrhV+y9NV6AZcy8y0pSAxKLW45UxLiW0ggtn4
         lqSKjZ5RvxicweFxlIeZHTku9GPmlufNN3dLv7J2GuRlIdyHF3cpex1X2GObeM1rU9xn
         VzNi81Tfs3p4edmg78V/eHg8KRgkPgOt77y1JIK8oTG+HcApRI3q0gJFUesvzraU6ylu
         UyQ+1jqBl09+gpaSUKe2NDdqSwff7vqoJMgLzEKUeoDPNW7NpK1SfV/w8hUgtvq5Ftgr
         GC5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774645256; x=1775250056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        b=C5TK6hWrjmO6CCAKwL5L2nRhyZs/VMBTmgiL9+IcfWS6Bjam9Vm1Hd3aUX4A2RYEJ0
         D1YMrEIaEEVaXJm5wp/4tlbOAKnolmX5qSU7ltpNnSbICR/fwmXzvaXQ2NgvjskxFHlo
         mXh688ehejw8dOT/zGrPPcaxJPps+QcvMi+pylNy18IaSzhBQProQRsFaV5LAG7X7x77
         jHJbYFaQLsd6NjQYDrnHWnW5Zh0ISaCggUaA6cqfA0+OU/REzuwDkYArZSGzAbX078LK
         0wivDuKWnMiv3HbobfaSZ00Il1mjUkx5wk+MfrxeQxhCy73hMjf3lTr3XqJuP66DpBXB
         IdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774645256; x=1775250056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHvMP9KDYXp5B8fQ+exmdFOH4CKDCprqxecGbubjPqI=;
        b=tWZUPP84X2bdG2wMR6ESbBkoNaop7PSSXL8H3dC1dXLpYokSs7eujbGDG2Djvk7ehD
         1RyM6bFmPJLPW41663Wp+DxsFZ9eNgwY++N2+xLZXzqRpR4mmRjkAr74WPFF9ziYT+9G
         b4eaL17g+Jr1TFTYnZ2/Mgb4faSNZMOd/tywNl/cbWKKSZBU2o+lNGsXizFFSH7uXO3Q
         Are8dDFhj+txdhMv0xgG0IQFEMFyC+ScScZ8/5WvSAAvlpdxRTR/hywFqSIHiwj2yu+X
         hU7Bhmn7GtkcLjz883Rb4e1x5jeJ4qxxngBEUVSaAs7eIJ5yTKRTmAOOFwBvG3gpXZY6
         mXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLn+AynInoaivALbVPsPnHBFMRbdUjizi8WKz+xRzZbOv1xm1sXdmIO+i2INbuJkA1KoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJXWpfa/n7/KxFwVGg6UyljsaNTG31wUl1r7fENtyeQW0LcG+
	k94/I0f/1d7AdlH3u+oxvo6DNVY7rvHiHYum0XluWtJxC6D3TO2AGhvaZejz9I4CBecJu/REagM
	tak0iJxV3M3rTlOwqOfkoGnYcSg9D3Y5GN/u2D1Vc
X-Gm-Gg: ATEYQzy81VTh7r1febESZ9o2218DWbDmWnuzwoq5i2k7VICIfgcUDTDwCs3Mf9qCCF2
	4R+9tc7ytlmcZS+7rqMO0AzLcLYfLhz9RJd7P280XOdKA+NvMjhayKe1+QN78CVbtn5+DWhVrnl
	3DetjhZ/P4EACmUnVzk3xGuUEtR58e6GilZZ3qgFzUmUD1YNS1DYpaDaA0IBUgNnLfTzTElHEaK
	IfSTubnJqIhD0FJ+yDmVpgiwC4Dt5WZcbCfNfbRP5xZE5IKPR4CZ3JdW4LNgsC3Z+EbCWiRNLHn
	+/7cu7VYaYT2C8V/vcRBNjb1BBYyohpwGr6x
X-Received: by 2002:a05:622a:aa50:10b0:509:371:f2ab with SMTP id
 d75a77b69052e-50bb288a2e6mr3465221cf.16.1774645255554; Fri, 27 Mar 2026
 14:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
 <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local> <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
In-Reply-To: <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 14:00:43 -0700
X-Gm-Features: AQROBzCX6JW1WY1HEKM5C3tQVZuMaYiRbHqFEwYBGPSueKMxsSn6D7aAg6e_Ipc
Message-ID: <CAJuCfpG78eMr8JjXLUi3toipy1chx76Bq5qRnt9dBqVLrxfLBw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
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

On Fri, Mar 27, 2026 at 10:38=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Fri, Mar 27, 2026 at 10:37=E2=80=AFAM Lorenzo Stoakes (Oracle)
> <ljs@kernel.org> wrote:
> >
> > On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
> > > <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > > >
> > > > > Three of your patches lack review tags so now it's 65!
> > > >
> > > > Three is now zero, thanks Lorenzo.
> > >
> > > I just finished fixups for issues Sashiko flagged. They are pretty
> > > small but important. Testing them right now and running Sashiko
> > > locally. Once done I'll post v6 and will ask Lorenzo to re-review
> > > those specific changes. Sorry Lorenzo, I'll point out the specific
> > > changes I had to make and will try to make it easy for you.
> >
> > No worries :)
> >
> > Could you send to ljs@kernel.org on the respin? Sorry to nag about it b=
ut my
> > email more and more set up for that and makes my life a wee bit easier =
:>)
>
> Absolutely. Thanks for the reminder.

Doh! Just noticed git send-email doing this:

(body) Adding cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> from
line 'Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>'

But it should also land in your kernel.org mailbox.
Just posted v6 at:
https://lore.kernel.org/all/20260327205457.604224-1-surenb@google.com/

Lorenzo, please see the cover letter where I list per-patch changes. 3
patches not listed there were unchanged. That should help a bit with
re-reviewing them. Thank you!

>
> >
> > > Thanks,
> > > Suren.
> >
> > Cheers, Lorenzo

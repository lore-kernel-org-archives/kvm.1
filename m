Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED579423A85
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988106; cv=pass; b=tGbrS1icxsgh0BWfE1hQZjtfvRjQJ4Oa4Tu6HQZf8vbVrURLTtFu6kp85+RGt4Ke74J2S/DLk1qjrFU0Fl7/JKuzl0UlRGiZRFs/OmAUCsz1JGws4zMO0kTxfZQebY/VTfdx5fkLEu1qVCtasMIj9AYNcqo7bcEVITXwSzAgMOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988106; c=relaxed/simple;
	bh=+UtQ9UG0ypfwQxx3wOqbv8WfIkTy4y8DvP/oXcbPF+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRdXIEA3itiBRWBesoWiD2DOEp80KYz6g9JJxTq1GJWqVa9lSJhsid8UYuwv/zjGA5RIIdnBcHOi1rzdO1QJTe8qPDap+Q3ffj1KKilVXbzUTkHFAt1eEGhO3cR8p9C666Casp8YHM4D11MgGBhJrQFXk9TMqxdH9VNNa2+z7+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0gLwiUo; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0gLwiUo"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509062d829dso755671cf.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 13:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774988104; cv=none;
        d=google.com; s=arc-20240605;
        b=eK083KTe5ayMP/DahsGsnmEKAF7oqjubl7flKYHREn8rjgAe5+pYUvvQu2h2oukqw9
         /qeLcJdEFBMg70rE5HuzPSu5fq2gSDKDmj2irMGgKVKgR31FfsEjizKA7A2ezypAkKa8
         FDbmF5+nNzDMYin5f7RZjnrfWPt29CWU+ehxJ2TxqAH1zjQOqnZ0OlT9r7zywufk3LTC
         fSjzQ6aCS5u561d/GgSybi4fdo9u/LXEh2cS3fQ3DrY/yMlWbz21c+xBATuc2sdH2ocj
         KL1kAeAr9b/VNuZlhRINxKkX52ABQaRkurpYFqvwEG6I4MKBMnYiAlPUKhyM/pHiWK27
         kisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        fh=UhOujgFvn+xlZ6Dy8ox7aSn0EedJRm9ofY2YGLWf/Lg=;
        b=aFanWPOZNF/HM59f5IL962C3Kxy8CZ75ibBO1ywp41V4BkIJHs8z/ybmZfPxsEfdk0
         uM8Awm8f5Ok/p6cB9drolXSwY1kSIx5wzvQdKZaBsNs5W3WmT8NXYmOJ12wbWIQ+1bVN
         Vukp82KQfqtZv4rblIc/bNHfpKjbxGw+ecjXGWCL6x0D9Y/yWAAtQ4eVE4vEOxxi/VbS
         tvHkBepn/TDt0dBk74yUYDqGt37Y48PIaZMTMf10spBwsclanTRrHZo6v2zyRnJF5LC1
         uPN+oYOKK/HZA9b7sTqjj3M7tVDa7z2oF4RnPb2+jp7gw0+CIBU2r5c9Jwd2x7TbCPeo
         1cIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774988104; x=1775592904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        b=v0gLwiUoYlYp0Vy4hhoJjZE8jJjdf/gRmcbwBz0S15B/l6ul3A3tNx77/rzE3gKuiq
         hu3eUy36ejuGZ8UrGEy9BKTYHXHZ8keyfdDiiztwG/P4YTY6AO72qqVr8EbHEcXgK7XT
         lZ982kXPPw7jj+k3+43oi7vqO3LCYKqAR92yDnrEByLzROavkbyDBcxvWMEI5ySnLtGD
         Bvmk99a2T6k8Y/2d8BjnG5LDnmAjDn9Uxq7EWxiD59gY9YUsdiw/fVXAYX2ElXcTbIIq
         Zs+xCvfZYHmk3JZnZel4bk4Gj1AAgkEarFasj9lL5QH2+TiEamLtTJPlxuSou59Sf0yn
         eLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774988104; x=1775592904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwVpGG9S8p/uX+u7seQVpxC4moFh4X8htIhQDky5uWk=;
        b=ZcWjUSA5ya0Z4QYuhmj1E7MTasVkQQZLvaqJGZkmQyfdEePF7X4sI7ILsjNf0fHM0L
         M0vXwb3JgAHl6hg6CPnceSLzwdBRyPRO5q8oIWiShFeyNDrTS38qVDWt1zSe2hMhVl/X
         g8VQtkTprFrZYY71PyJlcgGwe/ya6Mzdy9iHyyWMMU/TuDpq7HHUogq+rx+RbH93C0hk
         Uaz+ZNlPVAQank4KU5kbG3msL/sq32X/56r9V4cyHZktSecYh6W5/hrJWFzZq5F9UDOK
         AYs81iXevGS0T+VAAUxDj1KEpGsjZTw+8dooroXrT3BsIUR2vmWKDTiQgjglhvzcjldm
         AZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUe4K3N42DDtcUkLcagi9WCUZzTTl3o+b/JhY58XIp39eUQfNZB2EvF23uLSremS82Sql8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6UWpwqY5p0P7fvm3Iu9L1YEshBscV/q7Rn8jEk1htlVNU3+p
	WBiS4JEbHvUudldZ10E3neJuX0VI6Kkh9HaU51LPI8X609DFyijaJzj6/2ErFL9stZqvohWRAtl
	ktfNp1g318TydffA+oVHHA9y0v6u8j3xml5FYVnzh
X-Gm-Gg: ATEYQzxhyJM1fY/ZE5cp/eEX0Co/LLXGTyAyoCohe/+TxXayONYHGm/pYC3yyJmpqOL
	mh7Jfgs/dXlQXLNuowBGVBntbShLhq3SzRxTiU8mQjPxAPXJH856EUmjh51ZSTzq8bBL6UOJ7wm
	Zv6l96VcAS9C0lbCrXy3xJdsIuUmr6LKTbPoQAeCXkqROLDlHJlYJ0fs+TMHezThP4RBS17fq3A
	LXnGVNzy3zJWhzkRfhGfKcW/5OlA9IF6fxWPxPYr/kA5Pw3q39kA7JlP4r+JTeSyiMuBjNmCn88
	hIrsmfyhO3dYulf9xx4WZaX6vPJKFmZJ5OHixw==
X-Received: by 2002:a05:622a:a987:10b0:507:35b2:6b9 with SMTP id
 d75a77b69052e-50d3b7cb8ecmr5105641cf.7.1774988103375; Tue, 31 Mar 2026
 13:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com> <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local> <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org> <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
In-Reply-To: <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 31 Mar 2026 13:14:51 -0700
X-Gm-Features: AQROBzB2U3UmDFrQdi2wX1twdn7twB7j7RYY85tO9ykEBOm_M_3vRiUWXjbFQEo
Message-ID: <CAJuCfpH2eomYbZ0DzKpkae5DKVF69aRsfXx3HzMfPc6cTT5fTg@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 11:47=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> > On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > > Instead? That is, assuming we really need to care about this at all=
.
> > > >
> > > > But I think I don't like this change at all?
> > >
> > > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > > vote confirming my scepticism I'll go ahead and remove the parts I
> > > added to avoid extra vma_start_write_killable() call (3 instances in
> > > all) and will post v7.
> >
> > Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> > v7.
> >
>
> Ack, if we just drop the problematic bits we might still be fine for 7.1 =
:)

Let's get your cleanup first and then see where we are. I also hate
the way I have to report a fake error code, so with that cleanup the
patchset should be much nicer.

>
> Cheers, Lorenzo

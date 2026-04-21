Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79A3D8138
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781299; cv=pass; b=I49xaEBvouoy3QzIUIWi/GiL9Dhcld3T1JR5mf6pxAP5FeGr+te9XOkLCaHqfbNiOEZaeQs9hUmOIXeJy9aFQVH0+y85qXCDKJ9X1mZ5YjndvRWmJUGnSIJX2OUivlb+FHtAJe5k/j5CPMrJ7QfCr6Qn5evCXzqTVc1OOGccYEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781299; c=relaxed/simple;
	bh=AedUMlSyw6XFjPVA5iN7FhX2vHC7C6TuLPwkgnCkKs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0tkS3ON4fMzV6n6TA7ns5QzBTOlnnnjhGK5v+SEQgc/7hrqtRjiy9OA0yj6VAv0DG1N2NRfLVkD8cfIojFi+LjAwk0pGxONltEXE4LgnVOr9lNFRAUH6w/A64AJdEvGu7zO21rrjripp501kro4T5pMIJBvueseJA4jF13Rgkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pmr1qC6N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kzBAojWY; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmr1qC6N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kzBAojWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/8vteKWjSpSAOWpO+HbYmSIDFTvx1X2FVCJuYT1S1w=;
	b=Pmr1qC6N7mIfsg03Tu09eNMtlZGDH7KpO8w3GkI6yOkQbobIZeUin1dFVrjJ6zoIZLejgg
	VH1OWmPXiGQnytT0EocA3eSL8qmUkwgrNVXpJwzQ1fM6WT4aN8jRBnjWSH+imam7eX0vZU
	i6wILU1VCCXS70mk4M04mWD88Rduspc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-jzmz4173Ovagr4grzowBFg-1; Tue, 21 Apr 2026 10:21:34 -0400
X-MC-Unique: jzmz4173Ovagr4grzowBFg-1
X-Mimecast-MFC-AGG-ID: jzmz4173Ovagr4grzowBFg_1776781293
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso1960226b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 07:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776781293; cv=none;
        d=google.com; s=arc-20240605;
        b=KHoaKFrnZFbd8toNy1WKKa/Djzl7GDfdzk229U7MCbbUjiv8TcLiDKmI0tnCC1WuVl
         Nf8S4LIN12USgYmLcq6y87Fps8dif/NruW/+og34xwbQCYxcxhGKPhUPtH6MH5UlAP+s
         0gXnwAAUXKPFCyS1k6gTLeyNXYCgwL7pTVzmVO+XjL+tOh2z4xporsDpBDzcC2Fw28+y
         FawobAFCgomaVBz5sgqkXbLCN62mbGwAbIG43kKOilH2dDd++tsERn30f6A5lhkpJjr7
         RTKnacGz9ljcYBXAGoyqWnjk2hrn5u6S2rt97G0kxvXubXWVKkJjcO6t75ppLbwoCnlw
         x68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/8vteKWjSpSAOWpO+HbYmSIDFTvx1X2FVCJuYT1S1w=;
        fh=PA7XaiBebkSIMi6sfHzQG5N3IOOHbgRGP72NMSMMOUA=;
        b=jguEaaZx9XQmmgY6nv4pNDS0byowRwDB4KdUB3Vf4FbxlbozN+kpmklC/znm5AV141
         n2g292GtWcS1bhC862rDKKkV3h2g2LSQo4PEUyMTwEAVb+i+nfP/gu2TQs+HuBbbFFM5
         EXDzjPwx/pVp9bEDHe5CBoN7S6nTKrNUMDO/e2yhqUzQLVIf1yaju2YJNkz4sHvlGmAv
         L/mXuY4ywBsN+9EaTqLhpUXLGzbySAxB05R/CBiC82+gwk49ppshw/5GXS2N/w55UpH/
         G7fcKHu1ih8cywgQfz3ssfrScGWuPGvOcn/1GqACMIKkGXlKS+VQIe4bFeQqZg0mCEMb
         DO8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776781293; x=1777386093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/8vteKWjSpSAOWpO+HbYmSIDFTvx1X2FVCJuYT1S1w=;
        b=kzBAojWYVkBenmu6ycQS5t6XrcJdRiId8TooXJqmVwYYSaJTAuznG+/ob9o3EZtxcZ
         lSCeoG/j9G5cjNAagbaOMPepkj3NghkC+nKxi8SybI3b+9YOYnA1sl8rFLTy9J7mPa/i
         1QacWWW51XLtNCFUi0fL15fqHXcRYfrUzDz8r+wLtWQK/jFzkxcsNfTxRKUQBLhAs0Zd
         vxsLuPfQGAQbjk48K+hWUeeXPtoNBN+9QeeWj/slDaYRcsje2nl6e2XE+5aF9qx+9jYf
         lpJmqEC/1os+rQHj2nRVynfd93/QAdK+xQwNsUoPq+b5A2i53J6FKVHgG2UiF0ailphQ
         PTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781293; x=1777386093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/8vteKWjSpSAOWpO+HbYmSIDFTvx1X2FVCJuYT1S1w=;
        b=o6FnsZSB3x86+5I/bPjC2uzec7JtQk2xvYmjuo0nKII9/Cu6EbOZRWlz4g4OjY9SDs
         jgpvRn2iZV02nEr8r6bXM6Tq/z+yTRNttcc3RwgRzBiKD02SL2UF4JEiTHaEJICIzDaD
         iNwr5lDUqo+OusHyFKRSeK/poF7iIkqjAY1X4J//uVei5dc5reD3aV2ITCho4OMa88QB
         oqri0/jUuh+GTd7x1LPhzoYyDi9pHvpUQRKf8mndJd7+shNTdXwhzpoo+4nYjciWBnBW
         XGGii5M/hpJpK971fvHue6H8tYfVWaoPQofo6x54ozykIY6+JLdh3jMvoHpTpV7dqrzw
         Vh/w==
X-Forwarded-Encrypted: i=1; AFNElJ+16xiYUkuyNB+cPce2IOPiiObayg4HO5alhQGafkiedxwDCTZ+qtmWU58psg6x0fxarRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKBRgnbhiEr2VIDjM03FbA265c+RbeYw6kAdja1j0Tm41XMse
	HifdhNU9+1y88pN3dMw43r2eTcEZ3Ina38ERS5PyWsFYnODBhpEbda0a5IdYiLv9DYQi5AHoQO5
	Xpu4uGXQe9eqdlMbGGwFclW8gSEFYZBdd4ZIrPpnFFKrd2jPUvUvtQP5YYx0WVE/fX74PgaoDcN
	/Hf5HZKq9LliWRLmsfpVjmNUDIYdbC
X-Gm-Gg: AeBDievCn4Euf5hi61jDZZMzI7NeO8VWz+/5Z9izRy/lcd/8v5/Icil87qAw8xOEoPk
	h/G6ogXi1DGXkXaenepkWj0cE/g1OSWo8Vlq7FDLlGxfgbnbGjNjUbHkPexPBD2ohr6AigNZcWX
	HVuZUQc+00+GDFxVqaPc6rGFZHbuL5qFmNsy+RipEYdFBuRUTGR1ohOMja1zNX96V6gzqjvA9KL
	Mr41UVtYutswObwCj0EfsPz5b3unxEuBPxHOO98mFTU3lCss5wcnRoWni8xE+c4OI23H/GfItEk
	89XttXYu1fTohE0=
X-Received: by 2002:a05:6a00:2d8d:b0:82f:38:a5b2 with SMTP id d2e1a72fcca58-82f8c99aa1cmr18917684b3a.40.1776781293156;
        Tue, 21 Apr 2026 07:21:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8d:b0:82f:38:a5b2 with SMTP id
 d2e1a72fcca58-82f8c99aa1cmr18917635b3a.40.1776781292628; Tue, 21 Apr 2026
 07:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421100455.324333-1-pbonzini@redhat.com> <20260421100209.7535e26f@gandalf.local.home>
 <86ik9k1jqs.wl-maz@kernel.org>
In-Reply-To: <86ik9k1jqs.wl-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 15:21:19 +0100
X-Gm-Features: AQROBzCHqdW9w1Itv9qFdyXz20N2UJ_Tm4C-PGQnlDGcI3ssuL2JTM-6QB9jJJ0
Message-ID: <CABgObfam470W_Cq-jFHXc7H=xkr4CRMOGrbuLd-HtkepvwA3AQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: trace: do not generate undefsyms_base.c
To: Marc Zyngier <maz@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:18=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
> On Tue, 21 Apr 2026 15:02:09 +0100, Steven Rostedt <rostedt@goodmis.org> =
wrote:
> > Marc beat you to it by a few minutes ;-)
> >
> >   https://lore.kernel.org/all/20260421095446.2951646-1-maz@kernel.org/
> >
> > Although he didn't Cc linux-trace-kernel@vger.kernel.org :-p
> >
> > But anyway, it ended up in my internal Patchwork. I'll take his as they=
 are
> > both pretty much the same patch.
>
> On the other hand, Paolo's patch has the SPDX tag on the new file,
> which I forgot to add. Your call, anyway.

Yeah if you want to get the best of both worlds, take the commit
message from Marc's and the code from mine; he has more complete
trailers whereas I have slightly cleaner formatting and more comments.
But otherwise it's not a big deal.

Paolo


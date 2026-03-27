Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1212B93
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633141; cv=pass; b=VTVjWgfC9dk7BIS1g61TQ75TE2HOgEIiFubD1NAyrwT0TB6PUjhdj7VFYd6vhudPawFqB0hQFNFBzoXGdSwSMBkFPrpn9rV4KBkWbQMJkAOe6GsW0Fvb02eiKaSEcfwGLJ1/a+DH7736ip9bzZtodCtFsMhrhP2C2ZEiTC6CtsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633141; c=relaxed/simple;
	bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2N1h9A3/Ta7DZtATX85n49Sk1AJd2TWbjm5KB8So0KvzxloAtztBhwGiw5NnxwORPhVrA7jips7m2hQgZfLLgqFwL0XfEVsXe5DG8mCxn0zq1kRxc6zTpWWPTFCUcmm0f6tmjbPnlnJxV/eHRMrmHsE/3tZnyc8IqtQh1fWB0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opSKs3BP; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opSKs3BP"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b6c45781aso51961cf.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 10:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633139; cv=none;
        d=google.com; s=arc-20240605;
        b=JiguBv3NjFuezEun76cTUU/32Pn4WV3lCXweRfrXh2+mV5xjcnCUut6/QSLhHp69AT
         kJ1IrntNmrFBmSg417Yyzu2bWHEn8/3nJuwboAlr9OCYx4ATpqTEOAAyVdEAhTcoeMtj
         mfxgA5hdagGr/vod8E0i2oaycX5FBPHDigubHPu6cXueb3LNLjX9cPIlAa+Opm0Eb5Lp
         I2uhiuvwpq1F3f0CfafDgLxZuvgp8/8nE6Oku0nGP/3LJKxJqG+HxAZ1chM7hCkWMSg4
         3fP7VfC7GaWlrDkPeUqSn58RmID0gJeYlu3V9N+dtpEqWTkqU6hK6NDziel3e6IntUGi
         KKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        fh=bssmhnV4bP9GVctTGlAZjLXUtFKpEuxZJQznMrybQgM=;
        b=VzjkRgC9wmw+Frrago2OrZvwWcIHD04eaaKrvrOtz+uLeRXxIu112PXPmhsMvFxtZI
         W3tCOZjTHapD6BaM7nql86ohTtn0dqdOueLu0ZdVoHihFufEzaToFGghUev1yvzbA/GT
         D97g7YGMO5CIZGQqyhzU38GlJzz/j1AA+2xRjEZLhgzxsYioYG0Dstx2Z1ofxygl2RDo
         ghKn6VZ0AqN3pxe3oQ1AaL3KO2CvZxwlE1siQFBkMRIw8y95KkG62lFmc8TXLpdpk7Dq
         iN8nUeQ+ZTVq68qgAJpeLq0bU798xe7DjYvTfxVasC9h4lulEcvQkSNslfBtqWO4Juzb
         P01g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774633139; x=1775237939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        b=opSKs3BPu7dSxGPm6JNfm+Omgl9uoKm/frGzekk0adgkPgGVFARjSNXYovVTKkOm68
         xTPjhA6zfYiENlv7JTzz+oJF9BEH0sNvBwLslwPpSHgXr+TtAHieg+CwQUxDWzmZhi0e
         HwBS/XGfdlQ3PG42XBy078btdTGuGKCdDJYVJPe9htGkUQfDagKyfOWHmDHg5RDC5eBu
         GVJy2EZ6xJYDrEWSRDCLFJqI6WqGbr1GgKfk/9BxJ5sM9sRtDbhC3P+b+snpFj2Fm9kk
         76o1sjVysDGw+g6xkm+4G+fhiaViWS6pdApI8Q9YPMc17FW151CPJXrNHlc0yvTzcA5g
         hRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633139; x=1775237939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iIqtQ0hEleo3fj3bC+fegFfEomfWKxCj28r2/iHbUtQ=;
        b=peiJz8nzDCv1YM+CmhQ5CoEGyRjisihboruFfZHxx0Ryenh3FtbB5ux+58Q2dAYZbY
         Y7zgZaEf/uiCZU9KH5jkUajU/0XhLiesj6dEbNVq6Hxk1G5eYvuF6z8+krLfGQDEfAYV
         CT0xEhsaCXXMM9Hg4cs5/o5W1JCieDVmMfjV3BNBBlTwY+GFQl7PgoCyAEmDYP7K+T9m
         uVnwDbc9v8nc4fxpknw/C8gIYp9oUARxFcHrHxV2X0nFP7DB/atALXZE09Rumpnzz9TN
         rIHrRY6yMdx5sp44Dnk648VBOnGpjbNvZTYhGCg7ozy0ggM2lQa6n2rW/Klq1Nn8Qrr/
         0E3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbMcecpA0SKQyQQVPKbbx1B4+4oKFcuKhcxU7mCuCUruQNaPvPg72O9jJsI36KAr2lk8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQZaGgUI48BqVhox9++wSueVBJpwMmPFW/4qshyRFZdLS2srAs
	rDRfaZHNavy1hbhi7Bge1MxdiPnIU2FsGIBTUycV3ZKdf6QFoGvuZkPI/UITFAOJe5S2tgEBUkd
	GCelbS8Gu0GQDXuL4EinzR1SxihQBbwELU9vdBirr
X-Gm-Gg: ATEYQzzNgrTVTERa59t9+soTEnsthrFRYhbO+rZCyGWhzeLoG+YG4aTPfGH9lK/jJPh
	sYE8M/P01G3FlTtV3LBy9g+0ORHY75PB3gI9uXq+u2KL1CGw3SZot0fKb+b7Cu46isA6wKPljOp
	ICcAErbzz0BWe0bOigFLS+1NSaITfwY6AJYjsvamwKR3c+KChNhR48Lvc3S4dqw7NrKXHS4jGuJ
	djvecDOK5WiY1zU2zAZvFAnKNb7eLUfo7hmpJ/O1rONPkY3CXZ+EM3V5J3/HS56jmeWTadcfePN
	6JpQT8ht/wq2dXJndrWd+bMHphYfo7TdTz2P
X-Received: by 2002:ac8:614b:0:10b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50bb268ef28mr670671cf.2.1774633138943; Fri, 27 Mar 2026
 10:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com> <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
In-Reply-To: <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 10:38:47 -0700
X-Gm-Features: AQROBzDcdJIiYfqLEUVIyX_QE3l_JxzoPz7imokMkPm7FnH6uOW_OZAJgfsGn0o
Message-ID: <CAJuCfpHthntC=BNpWWYHePTfJJ5WQr_UkByc_-LViuy5V_xQ=A@mail.gmail.com>
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

On Fri, Mar 27, 2026 at 10:37=E2=80=AFAM Lorenzo Stoakes (Oracle)
<ljs@kernel.org> wrote:
>
> On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > >
> > > > Three of your patches lack review tags so now it's 65!
> > >
> > > Three is now zero, thanks Lorenzo.
> >
> > I just finished fixups for issues Sashiko flagged. They are pretty
> > small but important. Testing them right now and running Sashiko
> > locally. Once done I'll post v6 and will ask Lorenzo to re-review
> > those specific changes. Sorry Lorenzo, I'll point out the specific
> > changes I had to make and will try to make it easy for you.
>
> No worries :)
>
> Could you send to ljs@kernel.org on the respin? Sorry to nag about it but=
 my
> email more and more set up for that and makes my life a wee bit easier :>=
)

Absolutely. Thanks for the reminder.

>
> > Thanks,
> > Suren.
>
> Cheers, Lorenzo

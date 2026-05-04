Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C012E1E9
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909544; cv=none; b=FWj21Hc2SkOTM0Kk72tg9OCo5W06DjHzy39ITBmbKqSaK394ZS1C90uU5CRfq32WgU8/oH+IoEuPeuhfueL0ia2S4AH89Lw03RH9cHseymmHTN/UT4zvO/AMZ1TM9yrVqq4c0WeD9EPzV/YPTlQ2VcaRutBN9rS08G8Vt0mv5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909544; c=relaxed/simple;
	bh=fNaKE01uXztb3VH8JxttmnbVYt15zF9UuVDpbAwCQtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J04+t6i5X9N/nyUoQdvITmZxo27an47wh0rGPFY1dd0ZlThxFGck+1orlP2JSUdBDQdNYzxxqEHEZjuRffMxlnIRB8YPFY5kHKE53apB35h7d3owokhnDyicZBZTnmIQoy/GYOxvtt0c+yli3S5xPbTxB9RPl0hW7pY+m8tIZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkgzWUs5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcuWZFkV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkgzWUs5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcuWZFkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5bRnxRmk/pYWIdfgPlgCrLwQUTby8d1J2Q6D0qNqVk=;
	b=QkgzWUs54coFiPBQxdpJsaRZNZFQlsR9GFLLBsJlB52A/qEKTaPPMoCfUkhb7Na4ksIdHh
	wF3LQS9k4vcws6ZBlxXb32kRlHqgnG/edrqY/C1mHK1CmyOZ74K4WB/H2vKJiN5lPr7pPH
	nQ+YxbS5cBblZieHFVUNkJ6ynL4imds=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-uRi4yx-PMJur_8ymmbOANw-1; Mon, 04 May 2026 11:45:40 -0400
X-MC-Unique: uRi4yx-PMJur_8ymmbOANw-1
X-Mimecast-MFC-AGG-ID: uRi4yx-PMJur_8ymmbOANw_1777909540
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca3b7b536so142035946d6.3
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777909540; x=1778514340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5bRnxRmk/pYWIdfgPlgCrLwQUTby8d1J2Q6D0qNqVk=;
        b=FcuWZFkVbOEbLw/t8wVUXVEJbbhH2f0U+2e/73ZE/h7UN3KSvWBZVC48KEl3Ta2KLV
         AgcPUcVQg1VEZWHOZh/t9x+IPpeNgl8qXUB2UJgyJGKgMPq9x2/xPl9/77AMV+IMpa6O
         BE7hmJhb1RmqnbYIEmBYNwQPd2PCijcMQmO87UlOEM9bj4VlBosdMrhfeU2oX6wfHWgQ
         SNHOFUTU01wptwnpckAfLZkbx47RH2bZaNJFAp73s0FZLmsQPgEhI8eelvQuZdRmtCIi
         7ySQQWO7I7EbWInEH733d3qaRBSk3v+tdGLKYzJsl6MGX0xoSgRaiEL4R95d91djLW4q
         6ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777909540; x=1778514340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5bRnxRmk/pYWIdfgPlgCrLwQUTby8d1J2Q6D0qNqVk=;
        b=EqWDPZq7jwAtyhyVBl+mTMM2ntVsLDxXFdQVdav+73BmZKq9nG0o82rKHRrLNbnf+Z
         SjBKQNvIePXM+O0jN484/Hj+IiqYbsVJ/qrXECdaZOJm0E+bq/t8al90UEFBRT5qEsz0
         pT0kaa6j/jC2XOUxbUFyMbVrvohkRJC15n/rNK6gtXedWRkBuJKlb7QTAdjAWv4quF3f
         wQua0Jb7JeUZt5T5DlSS0t439kQfBY8V+3+TrkiDXrX+0pllP9CtF4PJWIalbVDMNLyB
         0Do00uVNUls9keqpy/d7VaChDRT/TO2R4vMfZof0B9WZ9E0dNXDJ+LT/BFNDtCN8p/XR
         +bWw==
X-Forwarded-Encrypted: i=1; AFNElJ9kyOscxqJNSjf+WIys34yvReArqvR3XvJSKQkAC06f0yONMTtJZb5mxs1LnD2jH77RZZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RhkCZ4M7FdPkbgb7ehKPWP++aIQIqeHkKXqv9GX2dqhLbhcb
	86dmSxnL/5oHYYedBuKtIgK6cuzUszVBJVWaGOLNqKw27/Jbp8QnexT8h8/cGL9R63RwHvCa1J3
	js81wdgOyEIAPtxtAqwfkmUCok05xLselyR5uPuJ/XyQmmvSQWsAhNdxuhnjpEQ==
X-Gm-Gg: AeBDieu/bJbkewVPKoH0vjgaqxMAhj4I7m19yyHk1JjdlKkg7xPGyevh2Fj/9Pojk8r
	k+Vp3sOJClUFdMcM/eJiKS86Ru7+UkrmJrjIjLlGSqc98QlRL9ieU5MgvYsuehnPsSXN/VP/Uo/
	VHjqVYRkS5gczJiGBSufzYXO2P4DhVMmvmq6XhVZAWaeCJRPVYsCW6lK0rRe5b/y7G5nc2yXfmu
	mPPl6NrUyRWE4dl1f4DTqTiKlm1caXmDdz9stPmL5x17C8MTNEEnQMbomKknRIzzDJSjapt6WCP
	oNRGjZ9McBXMQ590TVGQkZR6yavo7V4HBagh5ZPjAGNGI1E5gzNqnzKeYhVMc4JLf+oqva+yLSS
	qCB+rgvoW3sw6h3Dx+nKXUyRPqwLemJQ69wRfSDBjshQ4sUBijzRd5z4VbA==
X-Received: by 2002:a05:620a:2996:b0:8ea:addd:892e with SMTP id af79cd13be357-8fd18531a04mr1573400685a.49.1777909535629;
        Mon, 04 May 2026 08:45:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2996:b0:8ea:addd:892e with SMTP id af79cd13be357-8fd18531a04mr1573391585a.49.1777909534987;
        Mon, 04 May 2026 08:45:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a81049sm1190576885a.18.2026.05.04.08.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:45:34 -0700 (PDT)
Date: Mon, 4 May 2026 11:45:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Yi Liu <yi.l.liu@intel.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: intel_iommu unit test is also failing (was: Re: [PATCH
 kvm-unit-tests] realmode: load above stack)
Message-ID: <afi_HNJoObF10rwz@x1.local>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>

On Mon, May 04, 2026 at 10:07:25AM +0200, Thomas Huth wrote:
> On 04/05/2026 09.58, Thomas Huth wrote:
> > On 04/06/2024 16.35, Paolo Bonzini wrote:
> > > The bottom 32K of memory are generally reserved for use by the BIOS;
> > > for example, traditionally the boot loader is placed at 0x7C00 and
> > > the stack grows below that address.
> > > 
> > > It turns out that with some versions of clang, realmode.flat has
> > > become big enough that it overlaps the stack used by the multiboot
> > > option ROM loader.  The result is that a couple instructions are
> > > overwritten.  Typically one or two tests fail and that's it...
> > > 
> > > Move the code above the forbidden region, in real 90s style.
> > > 
> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >   x86/realmode.lds | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/x86/realmode.lds b/x86/realmode.lds
> > > index 0ed3063b..e4782a98 100644
> > > --- a/x86/realmode.lds
> > > +++ b/x86/realmode.lds
> > > @@ -1,6 +1,6 @@
> > >   SECTIONS
> > >   {
> > > -    . = 16K;
> > > +    . = 32K;
> > >       stext = .;
> > >       .text : { *(.init) *(.text) }
> > >       . = ALIGN(4K);
> > 
> >   Hi Paolo!
> > 
> > FYI, the realmode kvm-unit-test now also fails with the recent version
> > of GCC 16 for the i386 target:
> > 
> >   https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/14195195727
> > 
> > It was working fine some weeks ago with GCC 15.1:
> > 
> >   https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/13977260961
> > 
> > When I apply your patch, the problem seems to be gone again in this
> > case, but since there were some other issues with this (with older
> > versions of GCC, I think):
> > 
> > https://lore.kernel.org/kvm/49f8aadf-6e3f-4d2b-a32a-8ba941a3a2a1@redhat.com/
> > 
> > ... there must be a better way to fix it?
> > 
> > Could you please have a look?
> 
> By the way, the intel_iommu test now also suddenly started failing (for the
> x86_64 target), either due to update of GCC or due to the update from QEMU
> v10.2 to 11.0 :
> 
>  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/14195195728
> 
> Two weeks ago, it was still working fine:
> 
>  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/13977260962

Looping in those who take care of qemu's VT-D now (Yi, Clément)..

-- 
Peter Xu


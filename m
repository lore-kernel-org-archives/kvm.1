Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94D374E48
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115251; cv=none; b=sZ6XnWj0+/0B0YvxpK1ls0J4Mcrn2DGYxAhfnmAmpBbByoBuVrbRXBHOP9nDHwUKUTlWmd6um8XWb3yR7OnB9OIi6zWxZsv487N2kG4ni1BJ20hJ7IBaGi3MthrImhZRJGMwx7TnPOxYmJ2OhYXtze5AjG9LzgslmPBeA+WnmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115251; c=relaxed/simple;
	bh=uJdoWf7uP5WFjQzz87wmBTCbqaUGfv7i5Mx98GNa5SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmaTtBJ/ITggqCDTrweCAVKG0k94kRWYssICwO9ryNp0qBPxNQU0xKnO9hwVZ1cXYVHOiT9iz1ZUkGvoMyda5I2rwr0BAZovwOGR8a6aRKpFn2Q2JBD49oW5zADc12FQPGDWFkPcs5sTVxfYm/zfSP7n3UFEkKBzgOKiqUr7pkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxhkT5hu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEkr8DTa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxhkT5hu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEkr8DTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779115248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pElHc2+i5XQ0IekejspV3qshzABoy3Ro/TwG7oPKG/8=;
	b=JxhkT5huIbcN9WHV3Dh1yRjn1V+dNHVs0Awb0U08G2da88YxwxJxT/sXWr+HooJXrZxLOa
	KWg+s1uXxTQ1zWbQWu2OBz9hqI3gFtqplYV+j1MeAi0hAvtNFuMGY63naUipIBBzm499A6
	0I4ESxtDYiL9CAWR00FqhJjiarPHbuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-P0i41WVJMFy27LxBborAHQ-1; Mon, 18 May 2026 10:40:47 -0400
X-MC-Unique: P0i41WVJMFy27LxBborAHQ-1
X-Mimecast-MFC-AGG-ID: P0i41WVJMFy27LxBborAHQ_1779115246
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fda34ed0aso9323695e9.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779115246; x=1779720046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pElHc2+i5XQ0IekejspV3qshzABoy3Ro/TwG7oPKG/8=;
        b=dEkr8DTa04uTusiLp9BVblxKPpF6la1YAqWxX1a6RVgvOf6LbTdOPfGn7MG6L79zib
         kzgXiGleWG+Nuv6oTlyvRhPlD+mmUIjGiFWLWSSxt+jUbIknLlS8H94BGDKvv7sm7oHn
         wCpYX02nMql474f92ADBqvFheHwydm+p0i27gSF5vhKDWefL6CO5UAGVY1lfWK4/Yy7X
         VSTYUr9YnMG7593IW0T5mie7Lo/0JGZp/WpS7D1kJHpGy6hNhsNC5ACDT0oDx8kKMpRt
         M2NSF25G+rTQwoFToaK+EO7BybnP3OddrrZ5J1g33kgaOKY8Z9cAJGj1rEuZMRMuUBoL
         FCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115246; x=1779720046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pElHc2+i5XQ0IekejspV3qshzABoy3Ro/TwG7oPKG/8=;
        b=gkSc283M79abqrWV1asXA214l3TI7EdCI+xh4+Cq6y/FkhWVMzuDcMyHY8wbwnpc09
         w76N6mvIVSwr6EtzyyHEW1IGY/bRxGrAU5L2yCZ5tAxPqzyO4To63jCcAKXTDxnhj4Y8
         WiIoFXvmOalOUvK8LKKIxHTwIK5FnKlq4ftZQsy0X3l3xGPgMx0ZPQOpsgv7x93JhMXK
         xyMkxzDxwWG9Agq4UbpLpfY1GQeotZJTVLxF5UYTXf8Lbp4tUsufDa49Rt9TMykTyyHr
         htsS8SfUQo18qdnbeYI+d9H3e1Rkso1g+US4oDn++BlkzcozCUwn6gfhZqDt2Zb6PSPI
         LB4g==
X-Gm-Message-State: AOJu0Yw4rINMoXR3iEsqEYBPjLICP5o9Ai1HHeMAIuxpsx8kIvMJttmr
	4mbejAbPvopGvfHWJng52ZPBhn/NlHM17CaoDCruKHYeK82QPpyeOJFbqadoP5N8ea5J3+nvFDQ
	vMaVdSiAAhu/0TnrHbqpw6a9DnvJwrOrRUmbNWobgp6mAZxQitLupuQ==
X-Gm-Gg: Acq92OGmahvf2FBdmFY1fKRvFcpvRclMSFBiRPhjJ8Sst8tDiOlkoJN2BW+dNRwZJ9t
	mkiaEP03BEAoSs2xhfym/5GRjl6GrnjEB8/W7MjP3xJjJL2i4asOrGRIiYKWmaEfEZnaXY8Znye
	BML51Vyyhy3vM5JveZerURa0LalYLdcT/cOwYlhGjXHHO12GQJivQ7mlM+38L8Oq3TpEHrY8YrF
	WwTGTW6eJlZ9acEvdQ+oX5epra5cOFq0gbJIeScjsaLvv6KL/QnxNgzH6UwBUSVdGE68GtL7KoU
	N6PPcoKUvIYZT5dgamc65H0fQkRcNNbGYaPUUwBN2Xt1jpiVnSsOIhUcNz7wTZSiBn1QXB5tKti
	CD441+g==
X-Received: by 2002:a05:600c:8906:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-48fe5fdd63fmr183175995e9.11.1779115246087;
        Mon, 18 May 2026 07:40:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8906:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-48fe5fdd63fmr183175705e9.11.1779115245758;
        Mon, 18 May 2026 07:40:45 -0700 (PDT)
Received: from imammedo ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm444206845e9.1.2026.05.18.07.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:40:45 -0700 (PDT)
Date: Mon, 18 May 2026 16:40:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, babu.moger@amd.com
Subject: Re: [kvm-unit-tests PATCH] x86/svm: work around Virtual
 VMLOAD/VMSAVE bug on Naples and Rome
Message-ID: <20260518164044.5f06f840@imammedo>
In-Reply-To: <agsidj11-eY80au1@google.com>
References: <20260515111957.4188366-1-imammedo@redhat.com>
	<agcVNezX5lf1_3O7@google.com>
	<20260518143255.3795625a@imammedo>
	<agsidj11-eY80au1@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 07:30:14 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Mon, May 18, 2026, Igor Mammedov wrote:
> > On Fri, 15 May 2026 05:44:37 -0700
> > Sean Christopherson <seanjc@google.com> wrote:  
> > > > +static bool has_vls_bug(void)    
> > > 
> > > Probably need to be more specific, because there appear to be multiple flavors
> > > of vls bugs.  :-/  
> > 
> > 
> > would something like this work:
> > 
> > -static bool has_vls_bug(void)
> > +/*
> > + * Naples (Fam17h/00-0f) and Rome (Fam17h/30-3f) cause spurious VMEXITs
> > + * on VMLOAD/VMSAVE when the VMCB address falls in [0x78000000, 0x80000000).
> > + */
> > +static bool has_vls_spurious_vmexit_bug(void)  
> 
> Works for me.  Any chance you have a specific erratum number that we could reference?
I'll try to find it. That's also was a reason to cc AMD side, for they probably
know better where/what to look for.

> 


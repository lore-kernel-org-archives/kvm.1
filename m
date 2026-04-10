Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7658253B42
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845130; cv=none; b=tH2FIZJDvLR8xnWE+Sl0BTv6XWznr1QT4e8Iw7dT1x+TsO5cLy+8dFSV9Zl7YdBZT0sPallYbgDn2+wkw/N3Q5kz2JR0hmAUKy12QJ7iijkcfYHLmBKRgwZdlpDCWeEpnfnpPxSnDFQpivySyhE9KBsaz+4azTYuwPhgo5IVL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845130; c=relaxed/simple;
	bh=82W37ZURpitumCfaNbWD0CDy2223Trc7ZxbLH7eGH/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3BoTYWBI8I1nrMbvu+wyy0m2m/By+lQpYyRfgl/LOz/mpcyJTuZjEPMubJwLd6PDY3WLTHZHI1rxhWhJfsc8i78+YW1/nm7hWC6JRr9HnmAXOl3h/y0TDHsj8dTDn7UwyZWXkpGbVdRkWAPZYepwQPxAW7HQTucjnNid39tX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q7em18U3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q7em18U3"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89fc4147f2eso26966496d6.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775845128; x=1776449928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TI60TYUX37UzbgHqtB7WH/OT/FyRRuVOskjfGwN9GEY=;
        b=Q7em18U3cAi0LssFNU4qwTlAKai7YkyCizqr2Qcy0FrAEB6eV1s2BCjsZY0aOONJdp
         AzYPUlwZ6dkgrCjpz6di7E3vPikls/dhovkkdLIBOSe6yocaWLpm4Deee3GGOJMxaYfi
         KjPKjaQ0AaL5nzeyT/75B3M+kmRhKiHAJcp9dW3MR0Me3Qaj/R1yhC+AsZS39yTttFVq
         YbfayNLVpvPWHXbPGgfo8abd/QPKGSbAApdLKwn7m4vhQardRTH0y2vv3m9P4hyQkxzS
         C08i+HG95xb53mX08bnrnEIvp/JWGAweLfL4W1PynPlLXXCbty0GeOVIsbbGyA1rameH
         /yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845128; x=1776449928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI60TYUX37UzbgHqtB7WH/OT/FyRRuVOskjfGwN9GEY=;
        b=Q0uuvFdGgWwna6IDNTq4iF68PV0L/E3LVElUIIE8d5wX2IRyZ3/F7PLnCqiNrjvVZE
         /xsXhP/zBMU6M0dneuarsvNsG9ob7zRNQ8VhkgslegKNYFLaC0p6oRYvlEkpTzownG2i
         7KprLWp16G2/DXEVUzN3zSDTW3xR5dgWWIIqdw6wKqgHe5h+qzG0yZBiM/SXANwdOZ+f
         Dddr1ZRrYTc3x8qn7wmmQT6v5rDtpnET/7keBDshfe5wIBgM8kO1dbSpcFtdQcdq6cP1
         s2dWA7BJRf37fl4CHBorzLvTOaDGJYeFvhsPpHyxgQ0b90nibkiQ4DQpEj6XV08LhSOp
         JX4A==
X-Forwarded-Encrypted: i=1; AJvYcCUqSoXBJ1xMObW1lYdPtTNi19sczcFaqgcalkW6yWR/HQZSSrhZEHElm9IvCPyCPgL4rts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQP99xEKnNAX8kmCX3AyjbUWi6rM7+flo43HHbOILAxqI2pw9
	xXXJ71/JueJZ2ljYW1GXudmE5e9E86Iv9xagMvL6Buq9CNrrJGDhiQDiljjTV4zG9qA=
X-Gm-Gg: AeBDieuGeHx7X/HAgz8ixIizyqPxvcIwDYMVWzj9/agWnN5t4bTK47L3icixb53pu1W
	NfaxlrvLvBzzYTrcR9Ktew74wt87SlInktuqdafTqyiQJfKLh+76zeV2WDK7rks3E3FcNC/NlaE
	CEVuIyM8Gj4SWRSXVpGxje2xuJRzlui5EQU2P0am6alJgz3l5niH9GXXC3h784s5VXnbUso4hBb
	WknNgu07aMoUtsC40E1YkkUeQZbl9X4eq1R8k4bSoeCF0WsYQNdngT+A1gW1Tc6ZLRTOh5u47B3
	F/0YU8JFtyeCXJAWYdZJUM6hudJgE1SgXo7XVBi6Lx3Tzm86laTPKe1YvTGYS2Wta9VOfVVVlnI
	D5BEkwnWkKzNWpcDzTMVg+/CHLqX/GAiBX4G6iPbIhNTYwwC7dIN5N8bAT4r5zIOCnW4lQGB1IQ
	0BjvsqT302dNYYQhImYlkfGrUEfmrvhqv3CIOoCHmTRbFA6xl/+Cu7O7nuE086cXHSws37+A==
X-Received: by 2002:a05:6214:3f81:b0:895:48c2:aedc with SMTP id 6a1803df08f44-8ac862aaea0mr63595236d6.39.1775845127107;
        Fri, 10 Apr 2026 11:18:47 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db735sm35512216d6.2.2026.04.10.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:18:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBGRK-0000000FSR3-0OBy;
	Fri, 10 Apr 2026 15:18:46 -0300
Date: Fri, 10 Apr 2026 15:18:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
Message-ID: <20260410181846.GH2551565@ziepe.ca>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com>
 <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>

On Fri, Apr 10, 2026 at 10:16:09AM +0200, Paolo Bonzini wrote:
> Il gio 9 apr 2026, 20:59 Sean Christopherson <seanjc@google.com> ha scritto:
> >
> > On Tue, Apr 07, 2026, Paolo Bonzini wrote:
> > > VFIO is implicitly taking a reference to the KVM module between
> > > vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> > > symbol_get and symbol_put.
> > >
> > > In preparation for removing symbol_get and symbol_put themselves
> > > from VFIO, actually store a pointer to the KVM module and use
> > > module_get()/module_put() to keep KVM alive.
> >
> > NAK?  :-)
> >
> > I really don't think we should do this.  We're reinventing the wheel, and probably
> > doing so poorly.  As Jason suggested, the proper way to handle this is to pass
> > a "struct file" so that e.g. fops_get() pins kvm.ko for us.
> 
> We could get rid of the reference count completely (get_file() as a
> replacement for kvm_get_kvm(), get_file_active() as a replacement for
> kvm_get_kvm_safe()). struct kvm would need to add a back pointer from
> struct kvm to struct file, therefore adding and removing a reference
> count would have some additional pointer chasing. KVM has too many
> kinds of files to seriously consider passing around struct file* in
> virt/kvm/ and arch/*/kvm/, and you'd also have pointer chasing to get
> filp->private_data so it wouldn't win much.
> 
> Passing both struct kvm and struct file, instead, would be worse
> conceptually than this patch (because VFIO doesn't really care about
> the fops as opposed to the module) and uglier:
> - you can introduce a back pointer to struct kvm
> - you can change all struct kvm_device_ops implementations to receive
> a struct file*
> 
> While I can look at using the file reference for struct kvm, I'm not
> sure it's a win overall.

I would be much happier if vfio could just hang onto the file and kvm
could use file->private to get its stuff. It is so much cleaner and
simpler and keeps all the kvm stuff away from VFIO. We are trying to
do the same design for iommufd's kvm handle too, so I would prefer the
symmetry.

It seems to hinge on if virt/kvm/vfio.c can call vfio_file_set_kvm()
with a file * instead of a kvm *? A back pointer seems like an easy
way to do that?

Jason

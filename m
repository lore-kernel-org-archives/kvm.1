Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87913A3F7
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107640; cv=none; b=eOYPJKkuda6I3o1uALSN8epZetD7dCL5SdIDPQppHRFvoo4F8urYDviIwUqt/0ayXunAtm9d/gqlA3X/ULkFimCqeEJl8LfBDiGXmfMEMT6o0YmKm4nTgpMTtaqgXQ5xxmWnDzMIDH4NjXClvOpkPQsew8aMaP8PApJ1GZvsguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107640; c=relaxed/simple;
	bh=ENOHIiG/nJeUH4p0ivNLtckZo43UNbpHEyq7JiiHQo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enT+DnmisNFHYbs0jTiDzwhNxOrpE0A1zv92QABmv/AKSpk1Nr4T1g9mervq8lM4p0iP0fQC6HqGZMYXt93PqkswhxuU6aIOrh/eyB2IQSzmLyi0+/zvHi2ri86jgbe8qVHeZz4PiKWjBXCsndJKDHKF3YXjwuXKxWLpOJCcUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l01U65lS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l01U65lS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2591757fbso69645ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775107639; x=1775712439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkCyRr5ozKiXkuDknWW56qbTFqxmRYk5ffbC+bP6wlM=;
        b=l01U65lS1eZPHQFyA+KXOu7mK0Q9/ZXm5pfu8VqdnH9+6euXJlsBFPYpm36HqlyDb+
         b3cdZyrakYjrvUyYrIb/u9I3yTVeWgbJ2Uv1mr+0QovGYuKz91yAtVTJIg76DEh8ZZ9A
         PgY16SXshWwZ+YKxCQ+jqbbgOLo8yvBy++Y7kwTyzvvUpDCPI8x2emKNr/SN0zYrLU2K
         vRzi73bO7mzKiEcSaMf5vxdu1qlVwRX8cxjVPs8VBmvjKLN3Pr5a78+9biqZaBzXn+d3
         o3bdAPufzeARoOC1xUW37QdiYC6aW/M7WM6Pk3mcVKfClt6i+PHQT51f7fD3YPusIvXj
         RoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775107639; x=1775712439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkCyRr5ozKiXkuDknWW56qbTFqxmRYk5ffbC+bP6wlM=;
        b=ss1g2scPP8osqili5RpBDgLZKv3IWX5NuZuhELWWm0E2Wb3sgQ5Coc0NYg4BNbM4G8
         FfAX+CXoMbIvk6s7CvN76y94mtT7tibYHRB9O/um42HOBqFXdQmP9CKPNLLxLkpLxMgs
         1n3d5i/BT/d8rDb9AVOEhMWWQ4G5tQ03WEfGIertaeRP62G0QQl4q0+HZg9KmQwFvyNO
         RYKI0SCGuzmLpvOfCF3s5N21Vi7y4/mI5WCZkPR5jljapQeKHM9Ta5hsBszCHp5OkXC3
         zFWXdy302KXbKSW7AFTxtfFyeSEv9sVdycvNr+YGE2tuJFXrkzkkqGnWqUxwR4zHUsXb
         gnRg==
X-Forwarded-Encrypted: i=1; AJvYcCXW+Nn5z8Qfp5Ak3YuzTkBFSMOsgBeLA9TSjouGsV5599ORzIHBg9I+MWmsQeXKe6HtsME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAFP8bDziV5+q+L7IE87rDYpuMnsWMeNYqWFq/GVa+J6cJuLy
	F2JAHGs2V+/l7Ww6ZzawVUDc57mlQzeFhJZQ7iCsZroVsuUAivHA4tHG+WRqeYqj
X-Gm-Gg: AeBDietwb/ItdXAUaOBQptPcP76QrsYFIa22G/AizvuxddzBmDg6SEbsF/1LI36T2rU
	p/kkx042Gu35phH3z+G5uhozQBmMacIfXvixT0+B4bAJ136LdgNU089GfhrTIAflFelOd4holI5
	up9Wir/MUQxYHd7Pi4xU8/lj6EdQoDRBr+Tox1JKb2t//OH2Ig4j9KvqkyJ4tNePEGgpCNoxCkd
	9GZ+gm4gDkzy3uWq1CBCLjBvi9pXPVpp/h589w/L12jWx6JT28N4GuaKCVeRb+hAifJoaVVMu+V
	rbEYD7mxbb6iIPVaLr9c3XNnR6F/hg3jjJHo0iyxg2UMpvQOuNP7rVHmCHlga+szt5tHKawTgrM
	PHXTn/zWNP1AU587XlavYitPm8NlFQxlLUtTmsUxENqAXitKzF4PvnHE+fPVQgnpYcVoP8RTHFQ
	cmAtgKb1TZuQIsGoq0+i9/Sxhb79xv5rI2dXtQQnXXSl6UdZhUZavzZm3Fmlkk4Q==
X-Received: by 2002:a17:902:f64a:b0:2ae:7fa2:6bda with SMTP id d9443c01a7336-2b27842642bmr1013075ad.1.1775107637991;
        Wed, 01 Apr 2026 22:27:17 -0700 (PDT)
Received: from google.com (128.161.199.35.bc.googleusercontent.com. [35.199.161.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749c38adsm18227835ad.69.2026.04.01.22.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 22:27:17 -0700 (PDT)
Date: Thu, 2 Apr 2026 05:27:13 +0000
From: Josh Hilke <jrhilke@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 10/14] KVM: selftests: Add support for NMI delivery
Message-ID: <ac3-MX2wzd3RDyWj@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <20260331194033.3890309-11-jrhilke@google.com>
 <ac2ANoivTv4t41_i@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2ANoivTv4t41_i@google.com>

On Wed, Apr 01, 2026 at 01:29:42PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Josh Hilke wrote:
> > From: David Matlack <dmatlack@google.com>
> > 
> > Add the '-n' flag to vfio_pci_irq_test to route device interrupts
> > to be delivered as NMIs (Non-Maskable Interrupts) into the guest.
> > This expands test coverage to include KVM's NMI injection and
> > delivery logic for assigned devices.
> 
> The original motivation for sending NMIs wasn't to validate NMI delivery, it was
> to validate KVM's handling of delivery types that _can't_ be posted, and more
> specifically KVM's handling of transitions between posted and remapped mode.
> 
> NMI just so happens to be the easy choice (SMI support isn't guaranteed, INIT is
> too destructive).  I.e. any NMI testing is largely a bonus.
> 

Got it. I'll update the commit body to reflect this.


> > @@ -125,7 +132,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
> >  
> >  static void help(const char *name)
> >  {
> > -	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] segment:bus:device.function\n",
> > +	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] segment:bus:device.function\n",
> >  	       name);
> >  	printf("\n");
> >  	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
> > @@ -136,6 +143,8 @@ static void help(const char *name)
> >  	printf("  -e: Destroy and recreate KVM's GSI routing table in between\n"
> >  	       "      some interrupts.\n");
> >  	printf("  -i: The number of IRQs to generate during the test.\n");
> > +	printf("  -n: Route some of the device interrupts to be delivered as\n"
> 
> How much is some?
> 

Every 4th interrupt is an NMI. I'll update the help text in v3.

> > +	       "      an NMI into the guest.\n");
> >  	printf("\n");
> >  	exit(KSFT_FAIL);
> >  }

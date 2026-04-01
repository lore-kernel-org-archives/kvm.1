Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05353364051
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075386; cv=none; b=sYLzwWclUOz4Vw2jeRTJKhNPzHEAanmjadWvO5uDcFeYUZagZAn5eKpdA06mcrYGIkxCpVu4xGmeBd3xBPCa8TGuNFLWwpcCxVeyBGPkfIuKpzPuS+uie5ex2JUKb5aXRX4zXd2Tg1TdYfF03MsebY5QWOV0s0Dg0J0ltLV3rnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075386; c=relaxed/simple;
	bh=j1T+6fEZYvRIxAEmwYBkQXoKiib8Tx4r5vp7gOLhpa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNU7MZm1PYAjCfGYd/Fnq0Nezfe69z8pvSwvnfnfZeQEvK6Ek5bEeNjSijO4LjTEd/1DcVqXeNhdEwkJcgyBqEwk8HcWFw9J0lL0YpWaa2S78r67BnMhn2BvBUpaSt/P9UZZZSD12wucAJrmcVhxHOOjXc/9G4jGrVPvoDvA6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WC7LoZVV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WC7LoZVV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24a00d12cso1073035ad.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775075384; x=1775680184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq/5oujxRikW3Lsd6F8h1mGJPNH8oAg5gusGERAuSDs=;
        b=WC7LoZVVMBFyZ2COrU7UeVNdu0crL2zeieooNDWhrCZPX68WUaoLW/Pn/BFMvDjM4s
         869TVCOhRg0xg0/7a/mpj0KbshrXEQXVIVuUBAVWb417dvaLxVg4zQaFHo/n7O28mJI4
         zpNqEDyP6OHV20GGwGkh8irRf1+eX8114+m3rOfYHG2rRWqTxkp5bLxKAbXUplb8lIY6
         iw/S/5m1bMzCnx0jN38iprD+J7RdWRAwx0fjGo0mtm7JIXMIOtq8y05iDSXeikeM9fqT
         zvy7f27uXoDOTYAHoCPxAEnT/XzXjlGGFZGjwaw5xVHUrL+9eGl6TE73dEVTGlYEMiwG
         eqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775075384; x=1775680184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq/5oujxRikW3Lsd6F8h1mGJPNH8oAg5gusGERAuSDs=;
        b=BppTKt5WkCNcLQODksx2+aLmCYvNoN3rnZTtQqVgTGG/nwhU7k7zF3pFnsS5hwXJo8
         vEYrLdc7jIYemlZwOWHXfogSJ83VRCmsbzGAUjSMSjpeGXxVTVFussIQLob265M4+wh1
         sppzCSmYrMhVh/M+UsQgffsDDyvvUg/+AOMV2F7hnW3MEKl24rjp2sxy7UpUFPlyBMpX
         WeTD5SSiFsugKOXJf75qBnrLd99pf0dvZI4DTaekvaJd3T/idyglFCct51e5wjU2fqCh
         t1og4ae5XFsVIVFZ0dtIm/SrHdT3k/93RRtp9JgqTHQMaZT/hFoRkcg8Lz+UiHcMAN9r
         O4hA==
X-Forwarded-Encrypted: i=1; AJvYcCVDD/lhBzeqCEmaaL2l2+EfIz696C7yGVKRJrXr7FPk3VmPGF5RWfTVPsjMPk6jp7ppeY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEorIDCIhguB81HO0+BdLLZdr7SKuunNWSZ9HmjGfnE0hdaKU
	E3ki6gE/7janMqs6LPn43P1mZSzTp2m0MaeUq8Js14DTGJXrIcUg7A5b2UeKMRYn6xjidj9dr3y
	0EDxEoA==
X-Received: from plkj6.prod.google.com ([2002:a17:902:6906:b0:2b0:4cbf:3183])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c26:b0:2b0:7026:24c2
 with SMTP id d9443c01a7336-2b269cc3833mr52107925ad.36.1775075384137; Wed, 01
 Apr 2026 13:29:44 -0700 (PDT)
Date: Wed, 1 Apr 2026 13:29:42 -0700
In-Reply-To: <20260331194033.3890309-11-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-11-jrhilke@google.com>
Message-ID: <ac2ANoivTv4t41_i@google.com>
Subject: Re: [PATCH v2 10/14] KVM: selftests: Add support for NMI delivery
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the '-n' flag to vfio_pci_irq_test to route device interrupts
> to be delivered as NMIs (Non-Maskable Interrupts) into the guest.
> This expands test coverage to include KVM's NMI injection and
> delivery logic for assigned devices.

The original motivation for sending NMIs wasn't to validate NMI delivery, it was
to validate KVM's handling of delivery types that _can't_ be posted, and more
specifically KVM's handling of transitions between posted and remapped mode.

NMI just so happens to be the easy choice (SMI support isn't guaranteed, INIT is
too destructive).  I.e. any NMI testing is largely a bonus.

> @@ -125,7 +132,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
>  
>  static void help(const char *name)
>  {
> -	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] segment:bus:device.function\n",
> +	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] segment:bus:device.function\n",
>  	       name);
>  	printf("\n");
>  	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
> @@ -136,6 +143,8 @@ static void help(const char *name)
>  	printf("  -e: Destroy and recreate KVM's GSI routing table in between\n"
>  	       "      some interrupts.\n");
>  	printf("  -i: The number of IRQs to generate during the test.\n");
> +	printf("  -n: Route some of the device interrupts to be delivered as\n"

How much is some?

> +	       "      an NMI into the guest.\n");
>  	printf("\n");
>  	exit(KSFT_FAIL);
>  }

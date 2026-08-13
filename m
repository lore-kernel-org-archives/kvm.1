Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C7361DC1
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664825; cv=none; b=IlYs2Clp7Q/sYXIU4jY2IRDLpV8J6ZDU6zZ+y66lVp0IjftQEaDyiEvrsc/4Ect9GGenlwoVCFdEP+rk9cghFWwHS4fj1+J07a9QQ7pcHusrRSbSumTihDlwrJB0DgWla+6RlVTTy0urf/eR3VUAReyV1SRQI2mykF7PCkX81Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664825; c=relaxed/simple;
	bh=zp5+WItBeQBsyncdAdjSae2AKjZo8igsIiraO/m9VbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rgCtWOwbR/0tcj0EdEyMOesKzJi7HIHa88aIBJZviQftFAspOUvMblA5wKBuvGnxFEJnFOo5LPukRsZ/VMGbv1+waW0kWZXYsvGfk77mgXgi0u0nq5qOHQgWp7m3tHKyT5gwHL/wlUaK5zSLLXm/kotcDXw/BOMmLQalQHY8Ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8b66lox; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8b66lox"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so482155a91.3
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786664824; x=1787269624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnPLset0fgUp/N6cL01J88RlEaFM2/Zb6Kz0PUF7QRU=;
        b=b8b66loxBKgxHmTScXIv3XUnu24fE/eIpKlrO77LLslXE9CjRBq/hEMzTggEywKbxY
         BZMwyFfkQ5VHO3ON02NuaVLSkPh+iriPJD3b5t1eEJgS2yo+JIW7Th+wEnEMczgBGE+g
         iqxPIR4zeUlsIDO2A0iu+c6+/g5ls2B4r+2G+ToZR5tvt+mXcAZ1KIMnpn6ZjJcYzA1T
         NvSEjjmjlXjKEoyRXGESjBsycHowNEPcAFP/0dRwT/DRygegbQ5oz44SEK8GeBSpEQVR
         FAD0L75wS5TTmA8arANSPZaQtmmTh4xOHbKHXgnKrgf0VVE/9UG/QeGIMOuxBhPmG4B4
         LTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786664824; x=1787269624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnPLset0fgUp/N6cL01J88RlEaFM2/Zb6Kz0PUF7QRU=;
        b=pYttRRdz5d3FiSTf4RMORMugxZD54yy6wYnzj7w2FddwFkGzpkbfmu8JPgk0NuWLgK
         2OfNDt9G95I60x6uVV8fghUDFbecHQq8pZ0RF4PrUPj1+/oKawD8l6ct6WALXfO3LU7c
         MDO8RmwJdtaLfyA+1cerGV58aS+IZBPE8vlNvFiil2W04pfkddZJ8lraKNdfUJsBF2bT
         0l22oZ9u3a2MKH6p+iaVuX3j1f0vujeue6XsgsVaNfIOOI8J9I7joE+5osKXKLeCJ3VD
         LSSp2+tkeutGDPA4HXXuHwUzOJApj3ZDXZvDLRm/GcdoA9o8/FZmjl535TPK7SW4SJx+
         SxVg==
X-Forwarded-Encrypted: i=1; AHgh+RqdMWekEZp31PgBwNmztQqg0XRPz+b9aWMHht2QSr/QY2YrE0UJRVPRFXUmz8T+YUFXXoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySYPjA42eDP00qeGReXSygEqlvmWUcGWERRrO32MMYbtShxcV1
	0kAYx9pvZzSwzeM81HUxY9uQS03fCt0iHi9ZG2MYrqECci6CE80wikPjhViYsyE0AhaLoWy7VDW
	NeJmcYA==
X-Received: from pgch28.prod.google.com ([2002:a05:6a02:509c:b0:cbe:e700:725d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a83:b0:3c4:2036:3032
 with SMTP id adf61e73a8af0-3cc71f9de41mr1678436637.34.1786664823529; Thu, 13
 Aug 2026 16:47:03 -0700 (PDT)
Date: Thu, 13 Aug 2026 16:47:02 -0700
In-Reply-To: <fede3476-5c56-4cee-b0a9-2e89e5a334ae@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com> <aauJ80pZrw_SfF31@google.com>
 <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com> <an0BbcxUNRKqnUSJ@google.com> <fede3476-5c56-4cee-b0a9-2e89e5a334ae@amd.com>
Message-ID: <an5XdrvIoMKreMLp@google.com>
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Shivansh Dhiman <shivansh.dhiman@amd.com>, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, xin@zytor.com, nikunj.dadhania@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 13, 2026, Nikunj A. Dadhania wrote:
> On 8/13/2026 4:57 AM, Sean Christopherson wrote:
> > On Mon, Aug 10, 2026, Shivansh Dhiman wrote:
> >> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
> >> while setting intercepts? Or is there a better way to deal with this?
> > 
> > Take a hard dependency on an upcoming APM update that states the control area
> > is valid after shutdown, and rework KVM to not clobber control fields on shutdown
> > interception.
> 
> AMD APM 3.45 [1] is now publicly available and has the updated wording:
> 
>     "After an intercepted shutdown, the VMCB control area is valid (with
>      the exception of offsets 60h, 61h, and 68h) and the VMCB state save
>      area is undefined."

Very tangential side topic: are combined versions (all five volumes in one PDF)
of the APM available?  	Having to open five different PDFs to find information
is a pain in the rear, especially since I can never remember what's in which
volume.  I can manually splice the PDFs together, but that's far from ideal.

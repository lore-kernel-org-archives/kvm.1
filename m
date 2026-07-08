Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A136F8EF
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545377; cv=none; b=bk/QGMsvZBV01tngjCJj7Hve0Wwg1CTddHSV5530nGADcfcHSOJaYWybfa2PBBxKCP3j/HyLaQbdzTbw9yXCqIITORRR+omV8LajJx5M9utc0ve9P+REWNj5LBraG7xCitNURroixrQIGUClvcMsWwrIqiLXPEFuQ3q7lo1CiJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545377; c=relaxed/simple;
	bh=b9IXuZEhLEq8kcoaJ9iHTDPfKz7Q+etiiYjfpVDU2uI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zk+fktSnJedE8YqzUsIhEA1JHJz1qpaysXSco9pDUTUPZG2CiEHIu3uTVR8tVZfdzrwkOZmRmp7Ack9xXob7VYxpXQRNsSq69nUSBJagdLA9bEgfkEuxyofV5cAnCKuWKOg2YXFjE54dEpayxCAj4XsS8W7JIh8bMSzwOGCHwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHZw5QW2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHZw5QW2"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1651843a91.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783545375; x=1784150175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+YJvj0J4VBCeG53gEFWtVblMViyxqA7caDQne1cfRA=;
        b=gHZw5QW2FQWhEgrH4A4MFJZCoiyckmVMYkQRswD8kslBnDqjZMNKON3j1+vzyxjcJH
         KP4tJjKovzUIYy8MM6I2wuvjqdyiL2gaOxrR/DdwZUx/nYYcEtBX5n22h7MpsCgRrWvp
         v0ymOVQXUMeh+5RxZC1Yqqu31TbJFWfOyHBCuYdFA6gDl+DsuUrV97CPvq+Mt+t1XlSX
         xRsIeLgVEtZBy6CQsA4OwuPYGZKGU9I5QjK9TUJGzgfH3Y2nWe4MdIqrQimJXzLRC06F
         V3rz57j8QoI9TB5ZeTQXdi1Zrw+BQIKfNEHXF+6LtvMiU7Mb+0lrPlAoMIPlyXnEVX/+
         cT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783545375; x=1784150175;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+YJvj0J4VBCeG53gEFWtVblMViyxqA7caDQne1cfRA=;
        b=l4UOa5xXCKHOisVPOo8NzRy7+DndF5DLA05ddMepC4e28LiN867gEfUmpuSXxq4ZZD
         nxHaNsQb1RuI7661D9jSDKKJ7smg1ZRWaL1/uSTJ7/v1WjSxqcVIY756mUSYshtkeOCB
         dOCjeQJkqeFhAUgcCx1QNCLLo/NfL8c9NGQRTRLXMYj8KUoj0Y2Drr1lFK5nbd+L9/7P
         Z/vZY71WIfeVma5hZkWuLYz32gd9D15K90Ni39RoW/l+hjXpZ5Jbw9bzgB14SFywF4MC
         CjCfvxShE6GxL3+Curvi96tjwrRFeBbLF2owSCzKlnWnbluVUNEs68iZ6L7bfhPOpmuo
         hEfw==
X-Forwarded-Encrypted: i=1; AHgh+RqnSJnCW3xn6k7K5GhuXsvHem75e+Ko2fauh3PTtW8VJxGf4QnCA32C+qnRBHHFpD9U3r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAB8NRk55jGGmuFuE7oAS+4Y8+Ab4agik+6vPqm6UGneaewiL4
	SZG3dKRcsu5TDatgwNSkrfsGCxYzOfHBIKeAnQGlYGykY+leKAeTTXe7SCrMFkwq2pUy/0DbGB7
	z3FvlAQ==
X-Received: from plbld3.prod.google.com ([2002:a17:902:fac3:b0:2ca:f171:2082])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce87:b0:2ca:f8ef:33e4
 with SMTP id d9443c01a7336-2ccea30689amr37483195ad.17.1783545375091; Wed, 08
 Jul 2026 14:16:15 -0700 (PDT)
Date: Wed, 8 Jul 2026 14:16:14 -0700
In-Reply-To: <08c9bf2f-75be-4244-b99c-153ec1f604ca@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aj1tFuwZWdPGfUoG@google.com> <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com> <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch> <akVNdxCzk-n4bgMv@google.com>
 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
 <20260704054342.GB2169894@pedri> <akvsgVjwb00P1EuA@google.com> <08c9bf2f-75be-4244-b99c-153ec1f604ca@intel.com>
Message-ID: <ak6-HsAdwsXhywbZ@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Fang <peter.fang@intel.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zhenzhong Duan <zhenzhong.duan@intel.com>, Kishen Maloor <kishen.maloor@intel.com>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, Dave Hansen wrote:
> On 7/6/26 10:57, Sean Christopherson wrote:
> > What is "the S3M" though?  Is it a separate chip a la AMD's PSP/ASP?  Is it a
> > per-package thing? Per-core?
> I'll give you my rough software guy mental model of what it is: Each
> package has its own S3M. They are microcontrollers which are discrete
> from the CPU cores. Each S3M gets some CPU physical address space routed
> over to it.
> 
> > How is it accessed, and what are the "rules" for for those
> > accesses?  What types of latencies are we looking at?
> 
> As far as I know, the latency for one round trip to/from S3M is on the
> order of a "real" device. It has a physical address and when the OS
> wants to talk to it, those addresses are mapped with ioremap(). It's
> similar to any modern I/O device control plane. Note, though, that for
> TDX, there's no ioremap() because the I/O is hidden in the TDX module.
> 
> The real overhead comes because the I/O window is essentially 4 bytes
> wide (IIRC) and all the data that comes in and out of it has to be
> squeezed through that window. It reminds me of a UART, but with a
> slightly more arcane interface.
> 
> For TDX, though, the craziness is mostly hidden in the TDX module.
> 
> > What else uses the S3M?  Do we have to worry about contending with
> > non-TDX usage?
> There _are_ different users of S3M. But each of them should get their
> own I/O address and S3M firmware has to handle talking to those
> different users at the same time. The TDX I/O window is owned
> exclusively by the TDX module.
> 
> So, while S3M has and long and growing list of jobs, the random software
> (like the host kernel) poking at one I/O window doesn't have to know
> about the other piece of software (the TDX module) poking at another.
> 
> I'm sure I got a detail or two wrong in there, so folks that know this
> better: please correct me. But I think that's a halfway-decent 10,000ft
> view.

Thank you, very helpful!

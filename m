Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F393D891E
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287655; cv=none; b=Y3xIELkJyc6yyCwlq3og3XZKM04Nbw7RSW3xIVvnhOKXQ+6bIiH6/NG95zi/vnp8hBDPspCcb6xnWUKpKxyV4+R1W02Hz1vuaw/k2zcWK9gnvYGHv1UpJU82oK9TCV10vJr7EjpHbBMZUHOLSQ9/VAE7yiyxxI+Nh/5Xnf0W2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287655; c=relaxed/simple;
	bh=YAEY/8fWKMo3CcDwM2zOFRQbxppMAukpFHy8TPUsejU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FW8h4Jp+rZAbUlZX14eepEewcQPeDPTaqLsaoKuum80nxTngPoGLYUARqQ964P0T4QBOQL1SROKndNMYHHMBO2ogT4TBBIEEcm4yIyR44F+rGWr5GVuQVm9rGaDL4ztgA+hg3jPlSVzN/XJTEM4qXeedbHXJvZyGRTOkub/0VK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyxEMT6R; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyxEMT6R"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa860e71eso2592038b3a.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287654; x=1779892454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz5j9nqCKj4ufpyXbbuEEc7hn/CqbmZdKizVLMVbsrY=;
        b=EyxEMT6RyigaXviC6H9PbCIr/NQuHZ4KVJF069c1h16yZb0dWRdxKkgbprSmw5LVYo
         GuJb0Qmb4R+nW3FiKK7k76ye+OhOL0ItY6dfLwYasTX3ZYxh+3cYFKBwOlRxewMQFnoF
         WjuV4yI5CbpPxRHwIIv8SN2UgNRSlHC4ww7FV8PQUa15gyzdPVwOn7bNsM15chSic9df
         q+EpQYhUJp+0IeJOICGIbdtPtZ83uW3cJxQR7RLJXhp6GWTTfoEoPEhqJKt/5X0GCif+
         X0z5YdMhx7WqZOJcWRu5oPOaaQ8LUhLEzv+ggk41u+haAlg8NeWKCHonKmW3OjnO40t6
         1nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287654; x=1779892454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz5j9nqCKj4ufpyXbbuEEc7hn/CqbmZdKizVLMVbsrY=;
        b=Di4SjRMwzapm2ko9n+wUETkye9kKbg8yaDNB1NUBwzwfxtORYL6UVYmfsUxfDp9Wkc
         2xpaHiQA0KDaumvG7fLVaGuM6Fx1yGFiGpWZlHOaccC3t4Lu09ypTQkJpcJItJvZimYX
         GeYGvS72fvPxuz1PZkTXzgvHyfMrhFrj9eJo2AO2TnrmQyYRaQtxOfE2ulXcnJmON2EI
         pI9DjXtXVDj4OmjeK0HceVAMvQ2nY+t9I+HJr9RaPbH7lqu2M4r5Mv2y0TaoE/pohEjE
         qovD2fz01mYXSqbwOTAYMYcRhPP8j7A+gv/goolJ5MSEhAiUIsUTtvOgGBjTyXvFGVls
         QeCg==
X-Forwarded-Encrypted: i=1; AFNElJ/GsYWmYvY006NAxGi0YypZoO1+eC8HuJyeb8x+mK+dq4deMq6qdj0vNBZMPvhgb18c+vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazHj1widqUF+BHYs6yIQ1B/nM4bHC5vwEdBORPOeWtssw8Zxt
	k+ld+50F+9gpG4gO/1aoWrQ1qdNxa9fUw8lXrcU5V1kR1JVXm91tGnmf/+jDKYSX2jjgwksm6Mh
	VH4Bptw==
X-Received: from pfbg4.prod.google.com ([2002:a05:6a00:ae04:b0:82f:c34b:9799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cd4:b0:82f:b0:28f0
 with SMTP id d2e1a72fcca58-83f33cbc0fcmr25940056b3a.34.1779287653172; Wed, 20
 May 2026 07:34:13 -0700 (PDT)
Date: Wed, 20 May 2026 14:34:11 +0000
In-Reply-To: <ag0H28jSbSTHXznK@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <agusSarZr-R_o2xD@google.com> <ag0H28jSbSTHXznK@google.com>
Message-ID: <ag3GY3P0SgZPF_IJ@google.com>
Subject: Re: Sashiko review email for kvm@vger.kernel.org?
From: Sean Christopherson <seanjc@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	Alex Williamson <alex@shazbot.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Longfang Liu <liulongfang@huawei.com>, Julian Ruess <julianr@linux.ibm.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Brett Creeley <brett.creeley@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?utf-8?Q?Micha=C5=82?= Winiarski" <michal.winiarski@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Roman Gushchin <kfree@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+KVM and LKML (to capture as many of these discussions possible)

On Wed, May 20, 2026, Pranjal Shrivastava wrote:
> On Tue, May 19, 2026 at 12:18:17AM +0000, Sean Christopherson wrote:
> > Hello people with a MAINTAINERS entry that uses kvm@vger.kernel.org as a mailing list!
> > 
> > How would y'all feel about enabling Sashiko[*] emails for kvm@vger.kernel.org?  For
> > a variety of reasons, Sashiko currently only logs its reviews to https://sashiko.dev
> > by default.  If subsystems want to receive on-list mails, they need to opt-in.
> > 
> > I really, really want to enable email reviews for KVM x86, as Sashiko has found
> > an almost embarassing number of bugs that (a) would have been painful to debug
> > had they escaped review and (b) I'm not convinced would have been found by
> > traditional review.  And for me at least the signal:noise ratio is more than good
> > enough.  There are still hallucinations and false positives from time to time,
> > but the good outweighs the bad by quite a bit, it's cathartic to flame AI when
> > it's wrong, and worst case scenario I can simply ignore Sashiko.
> > 
> > But, currently Sashiko is only capable of making decisions based on mailing list,
> > i.e. as things stand, _all_ of kvm@ needs to opt-in.  Before I badger Roman to
> > add bespoke logic to Sashiko's email flow, e.g. to special case KVM x86 in some
> > way, I want to see if there's a general consensus in favor (or against) enabling
> > review emails.
> 
> I vote for enabling it, it has proven helpful at multiple places. I
> would wanna ratelimit the # emails it may send in case of a malfunction
> though.

Ya, there's definitely an implied "we'll turn it back off if there are major
problems".  But I don't see any reason to treat Sashiko any differently than
other automated systems in this regard; when bots have been too noisy in the
past, we've complained, and the bot/system was "fixed".

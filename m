Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60303ED3A7
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288249; cv=none; b=VByiYA+PqlbUIdPwqrTsVy4DL4NF0woeTEjxs/D3HtD819AUnubjR3JLpcTbopv6y/uaC0FGmzwscbwHszVEs6Nu5jhvd1RXmm87IPHhOPVsrBEjkSTN3Eq/EoMK7DPTBUnkSYAhL79x40IeQ+9SyfwcnHis/Qwnec6LvHVYjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288249; c=relaxed/simple;
	bh=IbqBppi3UPCAVDBr8Wdzbg0LS9uMUthSSk6144XtZEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJpvGEssK44d2idqhSSY78lYNRwHW/mbugBE+qwEN/25TUlC9dc/DLOnifMXOaVzhkZpM4mnymGlBPJ3rVwpBhMCI0hwLZPztNXv7rVE1kXW2FiNELaPejmv1K0ecQmUt4+DDl6rJcVdXbqbXeyopL9lwWae1Pv+kGjiN9Oehvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gtN9PaOh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gtN9PaOh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1055ad.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779288247; x=1779893047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa0g4SHC40+ZGcmvS1PxCiS4poMC/f+w9xSnfF9PXt4=;
        b=gtN9PaOhTpCLGhGIxkFV2h9aIHBHCyQg8NjGa++erWFWRkLgSNvgZWCk/8GN6uGjKM
         FHpNRPipY7Pyfe29yMLKWuIKMqXVu3Bhqx1r2K+tWlWlpDaFX/RK91FEDfwRU2EcelFN
         hx9Y63NKLAnpcS534oxYvroW8IYjmhbaL9nP0DFVAL3SK2FCZFl7KHhP4gpWmA4J89uy
         B4tOqWaLnr4lL3UEanmkjdQkGtIWGpLHPx1bsoHb+Ph1Ulvk4Yj5fAJT+1Xj6kJSfkJB
         VWiNtzXZmHya4SsQiwTWR4+Ps8hrfry0u2s08lQzjuT03Ancr9081HDigdABNPHlV/6h
         GwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288247; x=1779893047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa0g4SHC40+ZGcmvS1PxCiS4poMC/f+w9xSnfF9PXt4=;
        b=EvZThOenP2PWtFCzXiFWuCDSgWAxy6PeEQC2oBBTWYKQXVXywhcDHRPYJQM3z9OckD
         L7r9Y4unB7W5KwfsZQydr1pnzgDBq++lVUZ1akzSbxTsItOaS2svsS/tNFyxWIk/PZBC
         vgVdolBxdh82dkWoGU/30OORg4jYhG7sfcE96n/VJez7xlLD3qkgUJwrtHMY4JOdqpKW
         paA2+z9a2lBRqurnBc3aofHrXx/zp2LN3pLVijX8MPsLzOHauNKLD7VyGUtPiCDzMYP4
         bfoeGmfvBiX5++6/QsbVTn8MKv45aOsQfbzjRY3gr2G9cOGJBkGVeaqv/dwBbqBUF1c8
         KNJA==
X-Forwarded-Encrypted: i=1; AFNElJ+l6bxz//yODSCV9hW3rS/eXtM1yHTvulF81/nxVE4qvp7tWMufQNemjJoh1fECpDouDas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfMdN5x2TnuxAOYaL4c/J8TuKBK3EFfmBSaoOlGTQxIxxbEGm
	7pCJYAGmmbPXZr6SNHRhaArhBhOxt80B/gKUlb9mK2v242VjQ7ElAY0FQNB/yzGoNw==
X-Gm-Gg: Acq92OFOdHnoVvJu3KTbFL9NT9rLM/AUNzPInlZPZMo12ICHiRbKavQSkUiyoL7KRMq
	ZWUNltUwpruFJ+Vr2eBW5Oyhx8F1M1sdsGV/xI25l84r0UCGN3J1dcVJJhDTmjOQqJVrnBRVjTO
	eWlnYQwTOUisHREOy5RaC9rWfiVWzqEjfc+pzYB7Jn2cS798rtIUOKGdgaAxKlCgVA0pRxDYphU
	Dztb01Tc9kmW1HsqW8k8ONFUTzeogQPDSfRlDvG7HiffHC3dr0CK7Kmo9pxEpvjbPDEpTPx3YFG
	nk97/RZYNos0Tx6WjRB4zndU10Gc6n3HjA/uYMJak21IV9gjn/p690vGohfuMM7C+J1FueWlLOy
	7m4acAoOrt7s/n/WQ5Og1Tl/WMGaRrJvAzRLEYQmY94ac1ndlNzyEALsu3Z//qe7NLmH2Us0+FU
	SuUDRqAxoulTvI5xErqF7GgZPhiobC/y/VoXNPgKCNYLrSUYRi5oShC6dUKvQ3fVnS2iaX
X-Received: by 2002:a17:903:3904:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2bdb03a2a4bmr9928575ad.12.1779288246205;
        Wed, 20 May 2026 07:44:06 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe51sm221346295ad.2.2026.05.20.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:44:05 -0700 (PDT)
Date: Wed, 20 May 2026 14:43:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Roman Gushchin <kfree@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Sashiko review email for kvm@vger.kernel.org?
Message-ID: <ag3Iqa8Ct-H-qKzR@google.com>
References: <agusSarZr-R_o2xD@google.com>
 <ag0H28jSbSTHXznK@google.com>
 <ag3GY3P0SgZPF_IJ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3GY3P0SgZPF_IJ@google.com>

On Wed, May 20, 2026 at 02:34:11PM +0000, Sean Christopherson wrote:
> +KVM and LKML (to capture as many of these discussions possible)
> 
> On Wed, May 20, 2026, Pranjal Shrivastava wrote:
> > On Tue, May 19, 2026 at 12:18:17AM +0000, Sean Christopherson wrote:
> > > Hello people with a MAINTAINERS entry that uses kvm@vger.kernel.org as a mailing list!
> > > 
> > > How would y'all feel about enabling Sashiko[*] emails for kvm@vger.kernel.org?  For
> > > a variety of reasons, Sashiko currently only logs its reviews to https://sashiko.dev
> > > by default.  If subsystems want to receive on-list mails, they need to opt-in.
> > > 
> > > I really, really want to enable email reviews for KVM x86, as Sashiko has found
> > > an almost embarassing number of bugs that (a) would have been painful to debug
> > > had they escaped review and (b) I'm not convinced would have been found by
> > > traditional review.  And for me at least the signal:noise ratio is more than good
> > > enough.  There are still hallucinations and false positives from time to time,
> > > but the good outweighs the bad by quite a bit, it's cathartic to flame AI when
> > > it's wrong, and worst case scenario I can simply ignore Sashiko.
> > > 
> > > But, currently Sashiko is only capable of making decisions based on mailing list,
> > > i.e. as things stand, _all_ of kvm@ needs to opt-in.  Before I badger Roman to
> > > add bespoke logic to Sashiko's email flow, e.g. to special case KVM x86 in some
> > > way, I want to see if there's a general consensus in favor (or against) enabling
> > > review emails.
> > 
> > I vote for enabling it, it has proven helpful at multiple places. I
> > would wanna ratelimit the # emails it may send in case of a malfunction
> > though.
> 
> Ya, there's definitely an implied "we'll turn it back off if there are major
> problems".  But I don't see any reason to treat Sashiko any differently than
> other automated systems in this regard; when bots have been too noisy in the
> past, we've complained, and the bot/system was "fixed".

Yea, fair point. Enable +1 from me.

Thanks,
Praan

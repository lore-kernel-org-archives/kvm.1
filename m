Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA5318ED6
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303277; cv=none; b=lLakpcG/+yUCqd1zR41ihEubgSzQ+3JBn/5b4jlg+83d/4HNnh7JQB9lgOPFnItnfKiThs+GHpYv/NzAEDnkLG9Zqc5/tuUpv1NseTUK9fmTw6P89JWmDZL31DHPvQA1ooVDRnybSqUcnqsqyXT3INyx+rR1mNZlXc0tjEuUR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303277; c=relaxed/simple;
	bh=6H0gsGaMKlR4OpEMIn4M6H7DgXyJHZ13f05GCdP+s74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TECy4cize3linvqA8Z2/vIRqO0NuntmXUCsLykxYUu6WLI0QrRlftzvVqgVYBb/jsCle996U5kRVIo2BWZIhmpiWemSRoiXhRgdrQqsLJjb9gf99NmWNYayZfm6gtFoZ1M+4z4/ykLKqpxY3f47sZ4uFY559yJdC7dj3QN2DI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb32N2J9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb32N2J9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so41110525e9.2
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779303274; x=1779908074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTyAy/LIiDay4j1cpOqZG5BjMVSNCk92/hkBpskJyfA=;
        b=Eb32N2J9Lbz0Y36HSpGOssNFVb9G0VZ8pxUfua/dVM+Yk78PZZioi4e/z3G5I1yoU2
         q8cRU4IV1CQLw7QY/UigttbQSKqEzClVfcbwZwGEyEw9MFbYjXGEHJpgUoknPBHXe6E5
         atOcXJVOhv64KvIWNPCyX/Q7ssBhDVw72WbXWGVuDw1b5X1PVrF18e/dfTUa59KRLcbc
         RqsNsVTTdEhzyI0apVcWoDVqE7lYwhffg5jDU4A3Dj4L+W1sqhq0wRpBZOxC1tXb0X9j
         j0IgEP200ATv6USiiewKf60i8U2d2TEQvXojNuni1e+ssM87HMPuWhbtwpGkZoYJVWZI
         XS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303274; x=1779908074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTyAy/LIiDay4j1cpOqZG5BjMVSNCk92/hkBpskJyfA=;
        b=aE7nBakPHc7/h8aXqjmn1iHCqZUL9+ViclHYfry56Y+StGxUIHH64G/SiALti9mYhi
         4Bm8JfDLSEjAM0ySlUuGCmzJnk485wXipWgVKhaGgtNzGNMnLQlARAzpoapibQKI0Gbb
         stZGigWSx1FqGQNO9i/SFfHhj8jzCxdRqYMO14D9SZyCVnBH9ear1gDoF/Jm4G3lVn0M
         f3gn50P9GENxApIUo7aeS6ksOH96UiZ4L+yodOEcLJSWsvTDoQSzP1e8r0YjLPB8jDqj
         Quj/RHUtvOezx22cRCsBPqpv4U52WzD9rT9bq4CvqDAZJSKploHECajsRmSgZgEFBjoI
         QSqw==
X-Forwarded-Encrypted: i=1; AFNElJ/7B7zzQfdGhiBRiNfx/smiWGxuxINLhQ5fN5cZEpZzHHw3PWTAexj5/95chcY9MCP7ML8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVc/YN5KD1W46JUPyGx9NtHJ57Jwd3xNhvtIv8YHIuQz0v9ktr
	vk/686xK9OsnvCIM51BbgAzi1SZ9eOvGqfEzfztCtG7d+hcFENHxMn7q
X-Gm-Gg: Acq92OE9NM2pHT7LkpUszmEzEmsHTZenFDzfC6aPl7bCcNiAmIj7gSY8s3NrAPlSd/W
	7W9Zp4bRD3v6jF/HOc2Uh2Jemq32/ZC2firEA670OJV6fIA/Ny/mjkFLRJdh64BZBXb4c/pw3uy
	jBTzBssnLQMa6/ZjX3vpHSBHCu6eK2xASJHopbvC0ibngQ+XlYABLRNbpgzEY5N1//lAD+Ouejf
	rgeTG81eF9n53EOMc/9jGjnmU7aDStVmODysT4EoH3G2YAhGiY4pYr7DXfC2X8X+gImclBwkBws
	D6TfA8AbXqx1zE/mALMrQPA1a3hMvXc+4ZSJM8h/7xWsDRP+Vl2wrTHLx5YAKIzNLxjMCnbmGaD
	exWMVtQecOJu/ndUqxZVQJz2VsFsgvE1wIEr+3KOeiRW/28ZYC20biDAW8/oThqqU98KCq9h0bs
	6Af4ZM21FhhajWdwMcxUiiI4clLd0rzCc1I4yw5JvVlPdCBuBT76YLzj7UBh/zSqTw3GZYpKE3f
	ik=
X-Received: by 2002:a05:600c:c173:b0:48f:e230:c3f8 with SMTP id 5b1f17b1804b1-48fe661b50amr419468595e9.30.1779303273633;
        Wed, 20 May 2026 11:54:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033dab0besm9243005e9.15.2026.05.20.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:54:33 -0700 (PDT)
Date: Wed, 20 May 2026 19:54:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, Tianrui Zhao
 <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio
 Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil
 Pasic <pasic@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil
 Agarwal <nikhil.agarwal@amd.com>, Alex Williamson <alex@shazbot.org>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Longfang Liu <liulongfang@huawei.com>,
 Julian Ruess <julianr@linux.ibm.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Ankit Agrawal
 <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Brett Creeley
 <brett.creeley@amd.com>, Eric Auger <eric.auger@redhat.com>, Mostafa Saleh
 <smostafa@google.com>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, David
 Matlack <dmatlack@google.com>, "=?UTF-8?B?TWljaGHFgg==?= Winiarski"
 <michal.winiarski@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, "Eugenio
 =?UTF-8?B?UMOpcmV6?=" <eperezma@redhat.com>, Kiryl Shutsemau
 <kas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Roman Gushchin <kfree@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sashiko review email for kvm@vger.kernel.org?
Message-ID: <20260520195431.6ec8e6df@pumpkin>
In-Reply-To: <ag3GY3P0SgZPF_IJ@google.com>
References: <agusSarZr-R_o2xD@google.com>
	<ag0H28jSbSTHXznK@google.com>
	<ag3GY3P0SgZPF_IJ@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:34:11 +0000
Sean Christopherson <seanjc@google.com> wrote:

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
> 

Given the number of emails to lkml a few more won't hurt :-)
But perhaps they should come from "Sashiko (AI bot)" to remind everyone on
every email.

-- David

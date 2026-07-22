Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAF306776
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784748879; cv=none; b=jdIW9Cyr/zR7bKgo8t+y7iC1htW5eXGe1FC0rUOF6XISXMeg9kKtIdNJJf82btaRp0bwVmkIo/MSNcvJ45K+ItH4XlNnRxXbAAJ6GYUB5OdSbJzu1xz1AzPFFaNX+KEDWK+9LA6fsu2yE4ENFDhmV4ywwF2Cc0KPJ4uBTCPRRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784748879; c=relaxed/simple;
	bh=1xj0gKyVDg9BPa8UAb1IrHRIih45Z44r20ovKTsMtlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lp3QXYp8IWYUCNFqcltFhPQhzrl88m9FZGD2zHsEh12uYuR2ncm0c350sL6MegEWMO4PH/Kor8bWlbakPexqdrDz5qON7l/VynHguwRpptMvkYvL/lWirsI1cwXBc/EQZf6osx104ABaxEA8VK5dSBAzofbPQVF5nOPkwazCuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeTN55ZM; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeTN55ZM"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so271910135ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784748876; x=1785353676; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMWtzkw+88B3doKk+TNewGk3CZeZPu1IQm5Y/qLTIEE=;
        b=JeTN55ZMd8AYzaQUul50g5q0KyEIRtoMt4FLBNuHIM6IcFgt9a5o7KeVpvZMkER0Ze
         ZZ+yHUvjcE0+stNOvVfpI8s4Vn3DvaVOnaaLhQX3orcBl+in8Kg9j/V2RvqbMlrnU1OZ
         Gs7W8JUB9tXWJMLr1D7VDAk12UDJ6oLVxV1KcU0+g7++hjYKCVBEPDs34L0NDtcePhp8
         P8JQehufBedGNjgnTQAlYMJNhv5KGq9evsgi02DI2iNsI4BVV2g1hoCad6bYNkD06z5S
         /QjR/P2Mr3S7dFIDXS/308MKBoA9cVwJ8DHLcwTQ/n7XUPpXkzGt4JssSfaS80jhgZuu
         eBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784748876; x=1785353676;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMWtzkw+88B3doKk+TNewGk3CZeZPu1IQm5Y/qLTIEE=;
        b=DRkZA5ZWPXZHaPGF1Fiajx5L1Sonzj3T1r/p5wckNmq5+sK6kmDCeqQLJTnxumNKus
         jljBGM45AuXIJIL51mBoS1GsUAfM/bB4mrZji4UKb4cGzKEQTnR3yUOyDjmj/xsGSXSM
         Y+0ZLqYcxGDBr3wR1F1dwQ3QarJi7n8YYQ+U9PLoewxT4QYwDSBEf1AtJ+fkFfj84LHP
         vJ1hqFhZhkVuu730+7+aGHY0iddlhPXapm2CyrF/bzjI74YJnnRa39luliqWW/CGjz7X
         7CH2xo1ZSSaEOinLXJKdF6BfveGDwl0UDtfgOeSLqgGGfo4E7wUGtEPz8Y/qrSpk3TA7
         uSmQ==
X-Gm-Message-State: AOJu0YwixQRUvuZV3co7wSOmLyJLLWIgWOBMSAa+d0hMkXtjcJeJwtZe
	jbceA3IBYq+Cwvt4bNzB+nSQaGRFQSgIRw0hnwLeiMHHTjt8t1MyzSGRHsXzkQ1Htqrjiyk18uR
	soMyORw==
X-Received: from plbaz1.prod.google.com ([2002:a17:902:a581:b0:2ca:c2f8:a319])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f681:b0:2c9:cf5d:d9bc
 with SMTP id d9443c01a7336-2cfa74b13famr1966725ad.35.1784748875968; Wed, 22
 Jul 2026 12:34:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:34:35 -0700
In-Reply-To: <4ad035a82ee10dc4645e26a4bd1daf40786a743a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com> <20900cd6-6d05-4a20-a21d-2a1d4a6ef5e5@suse.com>
 <4ad035a82ee10dc4645e26a4bd1daf40786a743a.camel@intel.com>
Message-ID: <amEbS6WDEyrvW72Q@google.com>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	Chao Gao <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 22, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-07-22 at 16:46 +0300, Nikolay Borisov wrote:
> > > +static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int
> > > min_nr_spts)
> > > +{
> > > +	/*
> > > +	 * Don't cover the root SPT, but cover a possible 4KB private
> > > +	 * page in addition to the SPTs. So -1 to exclude the root
> > > +	 * SPT, and +1 for the guest page cancel out.
> > > +	 */
> > 
> > That comment here doesn't seem to correspond to the code in anyway. 
> > There are no +-1 adjustments.
> 
> The +1 and -1 cancel each other out. Hmm, how about:
> 	/*
> 	 * Don't cover the root SPT, but cover a possible 4KB private
> 	 * page in addition to the SPTs. The -1 to exclude the root
> 	 * SPT and +1 for the guest page cancel each other out. So
> 	 * make no adjustments.
> 	 */

Maybe put it in code?  E.g.

	/*
	 * Minus one page to exclude the root SPT, but plus one page for a
	 * possible 4KiB private mapping.
	 */
	min_nr_spts += -1 + 1;

	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB237AA64
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517666; cv=none; b=FVRUiNZ19SfGX//TptZQf8hzgOYEp8hm7WCdBMByBK7hAwK51imuS9DpW/gm5J1S4PMvbXWKlmyDrU6vk4s6sU9j7QTChvjrg66UFhYdb8OfwAEVRdZHCbBZl1FB+bQ8+l8TdVCo09znlQnescgi+/DvYyBnVKKI9quji4heZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517666; c=relaxed/simple;
	bh=agvT6dldUAVHGkvdHJr9GDkFukAf7X5C//m3Sv3mbM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5EbO7rJyHi4c0zPWlfKitA/ol4JlG65HqgedoCkYnYA3uxBvrL7eC7z7nTa86512kRsQyBIlgrLPBmM3S+TkmGKJRUdT26ikssqSQNjUni3ldFFqf2+S+RV71ogCbg8NBlGWg0ZJA296J0YFOlHEtKIl74OGCfKWpKPYOjniZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bt/u+WAd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nJBNMuhi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bt/u+WAd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nJBNMuhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783517663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agvT6dldUAVHGkvdHJr9GDkFukAf7X5C//m3Sv3mbM0=;
	b=Bt/u+WAdyD2rIzulZ1WUb7wRVa40SVQD8bZii/XtrFtWWhF1Fv2YGkFbIYltotrunINgR5
	EwYKFtEha9MI3F4wXeCLXg8GE365oPfRzYRQ98t4KXyLzQXUzmVd9sGjFitUZn42HnxCXP
	pmvPcyWJYPCdRjWNgdMhykliujj/VD0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-VIjfaeL5MiyXyrN2qxKA9A-1; Wed, 08 Jul 2026 09:34:21 -0400
X-MC-Unique: VIjfaeL5MiyXyrN2qxKA9A-1
X-Mimecast-MFC-AGG-ID: VIjfaeL5MiyXyrN2qxKA9A_1783517659
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15d4224f9dso44917266b.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783517659; x=1784122459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=agvT6dldUAVHGkvdHJr9GDkFukAf7X5C//m3Sv3mbM0=;
        b=nJBNMuhi8ApwLQW1V3HfDCyZT1EXfuhrdgynf67y8vGIENvnIr72HurDPqVLVLfrEA
         5SRjrjZYN8fGAwGKkFZxccEIknMVehg29vq+gJLcTqyXAcNvJlpenfCCIGd/Jw0qXnBf
         xBbWNAPa4E5VhzPlc/E6ox6uHfEISlw2abMfCtPYooWu6GConhA27nlLf2/UQaIX9KHk
         ahe8HQ2zGiklhT2a4BvCkKjI9Q9wnFFuXT1bD8Sr8hlpoJfJISA/c3YGWirVnJKBuIaw
         3YsLDuIOD7xqeZz3jb4jc4POIayv3a8W6YN3ciF5SrQXE9V20Q6qLl/kNlBYiHUKhItJ
         g/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517659; x=1784122459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agvT6dldUAVHGkvdHJr9GDkFukAf7X5C//m3Sv3mbM0=;
        b=YZolazRQctm2obGNsmUtgTgxBVyOjRCbgsQuv5ULLyAi2AKK9jMwvfRpTlZ6XtY5yx
         ya+Cd0C8MufA3rN5OO7P+/4bS+bLUg7LN9GxvBFmmsMf2WLIEpu+zR+jTgVfWi87XVAi
         TOAV4cgIaKARUtCudqv6FWsNmwZvKiFXUvMGlhObW7zl74oi4qXj2QXrUfupG1C42TUU
         eazUyRK1Gh7gLPg9ugrwfnmsT9t3BEdS3ACq5ta3zrPQAPCGocERRZKcXJVQc6xlwHHY
         WIQFbniswh/xFgI3DM3E+xmq4y5bg9zNhmQTYXuadnSJNoHm5zs4lv/x2l0to+ow6OQa
         u6zQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCwJ9Vz+4hD6wi+PeXeaKoe+GOEwuHTsU4EqAhLmXcYHPCNKnn8onx7VXcjxeLF5CHfx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnR2igY5Zv4inymFUvASRpUXp9fSCA/HiuU2SRpSYcMyPatpRw
	S+an/APEJq1dCJyuYIhSXGoVfxQEAzorhbFMd62+muErqE38fY8UIwcw6KBxJnozwtvqx2W3MaI
	b+UwBlV42uSfceYxh/65pBtMbOgBxfeAJBYacz3teZ7lHhbdprbvPTg==
X-Gm-Gg: AfdE7cndutH55f7rqMnx1iVZYmawfAlRlHoeE99rEHbK9Dxy0PF4ArTtjJT1/+QQoRb
	9luS2Zsi81K1tkm5R2vSRAkKnWE5WNaDueXieu5CzMnYT+dwpyStZuDnk0onrrli1iqaM+3arXw
	XiFHknZMBLn/kgM8j+vXLxZ5STZs0IKZIeL5Oj6u1twR4T5u8TSXFZHYeB2vw4dKRVHV3AakgHa
	zHXXOnMcIlHJzPg1yPsI69DAI+lfg+eOG9hLprCk9DJ3y83RzOUHZTPzhaYlLE7CmM+Z60SrZ4n
	TUYxH7wB2Zx/R3X60TOw9ZPpx6jZh+ooC3J7/R9mDQtDU3Wpnf34qpWSr1OoiK0qUrBP6TuyXYr
	ZV0UdVsjPLwuEnjz/Vf0AJJNMQygIf8AV3AHxO09+4uRG/cqYArPzz7hfXAoTd+A=
X-Received: by 2002:a17:907:a286:b0:c12:2acc:fce2 with SMTP id a640c23a62f3a-c15ce128c8dmr130689366b.53.1783517659331;
        Wed, 08 Jul 2026 06:34:19 -0700 (PDT)
X-Received: by 2002:a17:907:a286:b0:c12:2acc:fce2 with SMTP id a640c23a62f3a-c15ce128c8dmr130687466b.53.1783517658811;
        Wed, 08 Jul 2026 06:34:18 -0700 (PDT)
Received: from ?IPv6:2a01:41e1:62a8:c300:7322:3fab:8db6:d28c? ([2a01:41e1:62a8:c300:7322:3fab:8db6:d28c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad84483csm333878666b.17.2026.07.08.06.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:34:18 -0700 (PDT)
Message-ID: <bceedaf195adf713db70a1dba743055fe4f20bc0.camel@redhat.com>
Subject: Re: [PATCH 0/4] KVM: x86: Document and enforce APIC base memory hole
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>,  "H. Peter Anvin"	 <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Paolo Bonzini <pbonzini@redhat.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	x86@kernel.org
Date: Wed, 08 Jul 2026 15:34:17 +0200
In-Reply-To: <akwrncCjosItvAeO@google.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
	 <akwrncCjosItvAeO@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-06 at 15:26 -0700, Sean Christopherson wrote:
> On Mon, Jul 06, 2026, Tim Wiederhake wrote:
> > When an in-kernel irqchip is enabled on x86, KVM installs a private
> > memory slot at the default APIC base address (0xfee00000) during
> > vcpu
> > creation.=C2=A0 If user space has already mapped a memory region
> > covering
> > that address, vcpu creation fails with -EEXIST.=C2=A0 The same happens
> > in
> > reverse: mapping memory over the APIC base after vcpu creation also
> > fails with -EEXIST.
> >=20
> > None of this is documented, and the error is reported far from
> > where
> > the actual conflict is introduced.=C2=A0 A VMM developer hitting this
> > has
> > to trace through KVM internals to understand what went wrong.
> >=20
> > This series documents the two undocumented constraints (irqchip
> > before
> > vcpu, APIC base memory hole) and adds early checks so the error is
> > reported at the ioctl that actually violates the constraint.
> >=20
> > Patches 1-2 are documentation only.=C2=A0 Patches 3-4 add early
> > validation
> > that turns a confusing -EEXIST at vcpu creation into an explicit
> > error
> > at the point where the conflict is introduced.
>=20
> I'm 100% in favor of documenting the behavior, but I'm not exactly
> excited about
> the enforcement.=C2=A0 It's not needed for KVM's safety, and while I
> appreciate that
> such a goof would be somewhat annoying to debug, I have a hard time
> believing it's
> a common failure.=C2=A0 I.e. I'm not convinced carrying the code is worth
> the marginal
> benefits it provides.

FWIW, I did run into this exact issue myself and debugging it was
indeed quite a ride. The EEXIST from vcpu creation led me completely
astray and I was very close to just giving up. If I had, I wouldn't
have written this patch, and the failure would be perceived as even
less common.

I don't mind dropping patches 3 and 4 (the actual "enforcement"
patches) for v2, the documentation is more important in my opinion.
Still, if there is interest, I'd be more than happy to rework these
patches for eventual inclusion.

Thanks for the review,
Tim


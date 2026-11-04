Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806727;
	b=tNMNT1fKsR++l7dqlfHAF3zdsHAaxt0NzStT6tzeyhR7iOI/qCguihnBJMXr+gheSkET
	 NVAaq84yLVK0itJGHHPILeJjwl4RPIej5r6qHvGRnJAHGe4HQpDlnLNEcMLGUa/y6bEwB
	 zCQ53alYGMQGvA+Gp0Wn2cQ4Tr11f/B94mSNzlkmaQAU9PHSTjhkxohq6SFthpGY+QmLq
	 6bV6Jjlc7r7QIR8FwpVEr0CW/aULewXNALaEGxbUV7+rVf/vJOiK7bfE6VXbAH+FkD4nH
	 5PFcO5bQGi4MSglbjpTbmaEXDpn+5bIRr25VVSywSqiuXXF4FYBy5CUy0h2LxJkWClA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=BgXz8h+/nQ9U/ZFrmreR3nTmSbeRNY7GAtat9khBnZw=;
	b=lXBYuHoadiAHTdPdLkgXJ4sAhAWJkeb126T12Whrz7X/OCCgJF5U496gLaAY+KGKJ5mO
	 cRVOzSjXzAdQI+czmRMwlkFfBppqvJ9i9j53WMwj4VjxC97N3c1aU1dbUpPmwqUrt0lLF
	 YGnOrsQTCZ2bjYNoVL7qTkUpDnoZr/ADoM/Y6qHIB6h6SEnu2o/+OFqe6VS1cSh1sPb6d
	 HtWJJftDObmsQzsNGK/H56Rbz96Rh93FgZZXL7iQZLVlbkxYWooCIG2m15wtkI6kanqbd
	 qqBb3Usjad3hSn84LjdTX5zJqXwWQTQICsTypsE/38Yks+Emdk7A60VuPgNU2jPqOxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="k60/cWcu";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC96083636
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 15:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CC96083636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k60/cWcu
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ac76132001so730521a91.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793806726; x=1794411526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BgXz8h+/nQ9U/ZFrmreR3nTmSbeRNY7GAtat9khBnZw=;
        b=k60/cWcu0pkGc7cd1FnzHVa4LKXDGgriJrIpz1RFwsEIJOnw5JFHmCUyNY0IOHskiZ
         bartBh1Ruag9njIoguxRQCRQqBZQBg2lwfP6pCE/RGNCFlRFdcsH7YnkSoh332dXiqSC
         4kbSa7ySDV3T3LRz20vpcFwFraHll8xZ5FDqQe5Q5ADOQW0Wyq70+MF+Y8njcwlUa3/y
         4oZMutPoVESQuQfvz1SSB9ZoBciidOm2pq3RdgJnNQQLN61QxmRmFdyKEcpQ1ZWIIP5E
         9sXwEOYyQBagULkULsPq/YttZCiZkM3zuFQUT5DT96+KBqE1/VGvmfO+QisrcDSJsJ6m
         YZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806726; x=1794411526;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BgXz8h+/nQ9U/ZFrmreR3nTmSbeRNY7GAtat9khBnZw=;
        b=VV1CJTVcii4eusIioxM5holln01wwXITnqnikpQ4SOMdx2Yr7M9zQK/WVa1EXTX7SS
         vqy+uDrs+uFnt8jkeED4vO2MDDOnh7uE5bvYdKX2khvLf+K1H7U8KLMcSAf41TUjEK9o
         faHHPnyFEwrbsPp93UBwHqm0BO1xhmq/qWkIak8uvr+mMApDWkB0ZM2SnLItk19Kys9q
         ODPYNRwgA1eezaULrXsBbHAEtg+RSDoODqz8xAwsPO7mJdaNtErqCRt67mi9HK18Yrk5
         t7vbQiQp6OaWFEAE7OPCMO71NS0dAMVy7NhAsuS+/R3qsdDCt7Hl9AUy+TnmpUd+HxnF
         v+rA==
X-Forwarded-Encrypted: i=1; AKwUvBx+4gw8u3ytawGUhE2sMc6253FkQErgpHwJBCrNxK703NvX4kzBGvZoyIx6b8aC+xoQun4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gw4AQxFwYrNa0ARGRh0Tbkb9KoBaimlDFXjNanclNf3+CR+WP
	A+aAYgROEufv3asMe8Acr/OeXq9oMi/hHmqXgCOFPq4n3jjPgzqYE7hWlizvmk+ChyfAHSd2p0E
	pRjWvyw==
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:3ab:5803:73a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3806:b0:39d:f08e:e6e7
 with SMTP id 98e67ed59e1d1-3ae89574d67mr12860378a91.9.1793806726299; Wed, 04
 Nov 2026 07:38:46 -0800 (PST)
Date: Wed, 4 Nov 2026 07:38:45 -0800
In-Reply-To: <7ba2ca65-1eab-40fd-ae4c-f7cd9e156d8c@suse.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029143336.390231-3-clopez@suse.de> <20261029175203.5bdd51d7@p-imbrenda>
 <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de> <20261030133939.630e29af@p-imbrenda>
 <auis0SaMkRB6odsK@google.com> <b9ed9dd4-a1d0-466b-a6cd-89a4e70abed0@suse.de>
 <aun3w8gxwlmRy-GW@google.com> <7ba2ca65-1eab-40fd-ae4c-f7cd9e156d8c@suse.de>
Message-ID: <autRhZjOfLyw2OXo@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	pbonzini@redhat.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026, Carlos L=C3=B3pez wrote:
> On 11/3/26 4:03 PM, Sean Christopherson wrote:
> > On Tue, Nov 03, 2026, Carlos L=C3=B3pez wrote:
> >> On 11/2/26 4:31 PM, Sean Christopherson wrote:
> >>> On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
> >>>> On Fri, 30 Oct 2026 12:11:07 +0100
> >>>> Carlos L=C3=B3pez <clopez@suse.de> wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>> regarding this series:
> >>>>>>
> >>>>>> on x86 you don't care what the new permissions are, because you're
> >>>>>> updating when re-faulting (if I understood correctly). =20
> >>>>>
> >>>>> Correct.
> >>>>>
> >>>>>> for s390 it might be beneficial to know what the new permissions a=
re;
> >>>>>> of course we could look up the vma and find out, but since you are
> >>>>>> already checking the permissions, maybe you can find a way to also
> >>>>>> convey the new permission bits?
> >>>>>>
> >>>>>> that would make our life on s390 easier :) =20
> >>>>>
> >>>>> Right, getting the new bits from vma->flags should be trivially don=
e
> >>>>> from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users i=
n
> >>>>> this series though.  The rest of architectures still need the notif=
ier to
> >>>>> tell them if the change is an upgrade, since they don't have an eas=
y way
> >>>>> to grab the old RWX bits. Passing the old RWX bits from the MMU not=
ifier
> >>>>> does not seem trivial to me either.
> >>>
> >>> But why is core MM even doing mmu_notifier_invalidate_range_{start,en=
d}() in the
> >>> first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just ski=
p the
> >>> "invalidation".
> >>
> >> I briefly mention this in the cover letter, but in short, denying othe=
r
> >> users the notification seems like an overly intrusive change for KVM's
> >> benefit.=20
> >=20
> > There are all of two other users:
> >=20
> >   $ git grep -w "\.invalidate_range_start"
> >   drivers/gpu/drm/nouveau/nouveau_svm.c:  .invalidate_range_start =3D n=
ouveau_svmm_invalidate_range_start,
> >   drivers/infiniband/hw/hfi1/mmu_rb.c:    .invalidate_range_start =3D m=
mu_notifier_range_start,
> >   virt/kvm/kvm_main.c:    .invalidate_range_start =3D kvm_mmu_notifier_=
invalidate_range_start,
> >=20
> > and AFAICT neither of them wants an invalidation even for protection up=
grades
> > either.
>=20
> There are more users that register for notifications via

Ugh, I didn't realize we gained a variant of .invalidate_range_{start,end}(=
),
I thought those were for what is now arch_invalidate_secondary_tlbs().

> mmu_interval_notifier_insert():
>=20
>   $ git grep -l -e "mmu_interval_notifier_insert(" \
>           -e "mmu_interval_notifier_insert_locked(" -- drivers/ | wc -l
>   12
>=20
> I haven't audited all of them, but I'd say that at least amdkfd relies
> on the invalidation for upgrades. Without XNACK, GPU page faults are not
> retried, so the driver maps ranges up front with the VMA permissions
> (svm_range_validate_and_map()) and relies on an invalidation to remap
> them when those change. So mprotect(PROT_READ) followed by
> mprotect(PROT_READ|PROT_WRITE) would cause the GPU mapping to stay
> read-only and the next GPU write to fault. Unlike the APIC access page,
> this is the application's own memory, mprotect() should be perfectly vali=
d.
>=20
> This is the kind of subtle reliance that I mentioned before, and why I'd
> rather not open that can of worms.

Yeah, agreed.

> >> A flag allows users to opt in instead.
> >>
> >> It is also not clear to me that secondary MMUs are not relying on the
> >> notification in some subtle way. In fact, Sashiko points out in reply =
to
> >> patch 4 that the notification lets KVM retry the APIC access page relo=
ad
> >> in case userspace shoots itself in the foot by calling
> >> mprotect(PROT_READ) on it. This would require a really weird VMM,
> >=20
> > s/weird/misbehaving
> >=20
> >> as it would need to go looking for the page's address, but breaking th=
is
> >> would be a "regression" nonetheless. I will address this in v2.
> >=20
> > Nah, there's zero chance any real VMM is doing mprotect() on the APIC a=
ccess page.
> >=20
> > More importantly, doing nothing if updating the mapping fails and APICv=
 is enabled
> > is wrong.  KVM needs to ensure vmcs.APIC_ACCESS_ADDR is fresh when runn=
ing a vCPU
> > with APICv enabled, even if that means putting the vCPU into an infinit=
e loop.
> > VMX doesn't support "inhibiting" the APIC access page, i.e. the memslot=
 can't
> > disappear while the VM is alive, and if userspace mucks with the VMA, t=
hen KVM
> > needs to prevent running the vCPU until the mapping is restored, irresp=
ective of
> > mmu_notifiers.
>=20
> Fair point. Should I just carry the diff below in v2 with your
> Signed-off-by?

Nah, I'll send a standalone patch.  It doesn't have a direct relationship t=
o your
series, and the bug is pre-existing despite what Sashiko thinks.

Thanks!

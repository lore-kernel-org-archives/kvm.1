Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718214;
	b=zySmwlGzZj/1XDhDM/jSzKIlKlZ6n7Dry3YQj6i2rtsCPCvsqW0R2OfAz8qbvDuO8Kfy
	 0nEKl1bC+PRwJczXRrU6ykf7zGiOb90KtOO0qPUXVPQX3Y29zdxqYtN6rla4U2RRbrK7j
	 H2u9klm1pdHlToDiYjyLweWS7JQZIVAMC3ElNafTWhF9//XBTdqvSLRMwHFOuDYBkfK/N
	 lInOM8eZ4qVQSmeghADtVDT4DZtvY/Rg0pM8x7I9YZnTGAHjdTB2oI0gOyedeJypWHWzD
	 tzlHq3oqOsnhnq4xkJkAFI085bAvxajh8JmrM1LenR95pSnk1CLHwRlCNGR27bXWXMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=U1cgiMD/xdrAAoWIqAxeQiqT29OTjecADPn89igAbnA=;
	b=ACdD2C0H7WRG/l6RDEsgr3fJ3Xh45OFnlMtRPjw03M7ke6dCV+/0oVyP76ONkTCjAYTP
	 /63Palunctl98dVBcCLAY7ee/4e1tw4X8sTuav7+OUnVUJuoYAP8bjy9vwvwf0Fq+z9Qc
	 ZAk47fYNop9R6httiU7FLYMvUmmoggtPqYKeOxxj31Is+mHfhvsd186ZQRokPCVMx/A9I
	 UWs/aC+iKs6goxdkbh/xPvgrPu+Z5J7WgV4PcUv0K6+oNKPOSAYchSujgQe2+EcCI4Hw7
	 BqpL3SmNzx6PSsyxZCOfW3Ks9mBJa1/O+eUtNY3869RDRq7bAXOLlKK7fFDvRRDMDEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WYSLWugz;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29838606B269
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 15:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29838606B269
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WYSLWugz
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb92868263so2308549a12.2
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 07:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793718213; x=1794323013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U1cgiMD/xdrAAoWIqAxeQiqT29OTjecADPn89igAbnA=;
        b=WYSLWugzFuNm4Kq224vW+Mtkvsl2neSTgZBMrPgSmEKac3ov2ufcElfcvoyepJJn6f
         JxnkQBp8SHxk8VB+L0keiYB1AMoFJ5f9ba1S8NanI1pf6f4huAEPxuLXeTJgl2gQ60a+
         HQhmM5JqlPBt8lVUK8hIOVtUdNfOWTZvu8F5RWqWzRLAhu0TcdpXLYqO6fNF2oREz7k3
         XryMJ/6DA3O6a1N/l8ybWr85Ta3prQYffWP0qlmXpH+hrTSSzsilEM/FEcVJ7On+Y9zh
         3VAKC5vThgpSeJT17ky9XTa3Ll3OdZ5oakw8OkcxH7BQzM+uqaA5T97fOsetveJ1XdD/
         oQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718213; x=1794323013;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1cgiMD/xdrAAoWIqAxeQiqT29OTjecADPn89igAbnA=;
        b=qQ0uDSZKFlxmXKw1PXV3pSzuNB1EPXopiOYyFsQLYex34z5MKjo1hpLWUFV15dax+j
         5vdRYJnJEdOOFSv3nVb90VQdkVFsjD5+KuNwhOy5m71mNWqaiRb5BK9XH1q36/SsBdXP
         reAwyBAWlOywsy3Tz7LoAGAuwHWkjYk2WD85imUy7l3kEblSm2VwHuDD+ZvhLmf8iMno
         ZunqluF1Z40GH8DdhvwuhCdcecTI/hHv+645iLnPJSa5ahZVOTKvXFX1OCEAEl/6ALc3
         Eo6w1CcRBl5e9ro/KvU5ws/jWtjuyGw4jqy6xSL/oFsUUcJLoi/FrYe3zzYs9lkY3lxT
         9uRg==
X-Forwarded-Encrypted: i=1; AKwUvBxeMN25vW5xJzRBw4NFi3UY/ScoKGDlnD1KV0m6RiOflZqweQB+a5V2uBtd5WLOdlT1P7U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dDoZOECbFU4855uxexIQG6/IO5Bj1Z1RHCpaIPvlQsjbbwwLP
	Zh+zGi6tXZXJN+1dJOz09fzMJiIzS//aQ3tOMF8PFt1XteNBfd2lUiStU+PMa600LSuCR7KyKAU
	kl52h0Q==
X-Received: from pjdn32.prod.google.com ([2002:a17:90a:2ca3:b0:3a8:837d:95c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c5:b0:3ac:a11a:7c79
 with SMTP id 98e67ed59e1d1-3ae89776aebmr10680806a91.16.1793718213083; Tue, 03
 Nov 2026 07:03:33 -0800 (PST)
Date: Tue, 3 Nov 2026 07:03:31 -0800
In-Reply-To: <b9ed9dd4-a1d0-466b-a6cd-89a4e70abed0@suse.de>
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
Message-ID: <aun3w8gxwlmRy-GW@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	pbonzini@redhat.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, Carlos L=C3=B3pez wrote:
> On 11/2/26 4:31 PM, Sean Christopherson wrote:
> > On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
> >> On Fri, 30 Oct 2026 12:11:07 +0100
> >> Carlos L=C3=B3pez <clopez@suse.de> wrote:
> >>
> >> [...]
> >>
> >>>> regarding this series:
> >>>>
> >>>> on x86 you don't care what the new permissions are, because you're
> >>>> updating when re-faulting (if I understood correctly). =20
> >>>
> >>> Correct.
> >>>
> >>>> for s390 it might be beneficial to know what the new permissions are=
;
> >>>> of course we could look up the vma and find out, but since you are
> >>>> already checking the permissions, maybe you can find a way to also
> >>>> convey the new permission bits?
> >>>>
> >>>> that would make our life on s390 easier :) =20
> >>>
> >>> Right, getting the new bits from vma->flags should be trivially done
> >>> from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
> >>> this series though.  The rest of architectures still need the notifie=
r to
> >>> tell them if the change is an upgrade, since they don't have an easy =
way
> >>> to grab the old RWX bits. Passing the old RWX bits from the MMU notif=
ier
> >>> does not seem trivial to me either.
> >=20
> > But why is core MM even doing mmu_notifier_invalidate_range_{start,end}=
() in the
> > first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just skip =
the
> > "invalidation".
>=20
> I briefly mention this in the cover letter, but in short, denying other
> users the notification seems like an overly intrusive change for KVM's
> benefit.=20

There are all of two other users:

  $ git grep -w "\.invalidate_range_start"
  drivers/gpu/drm/nouveau/nouveau_svm.c:  .invalidate_range_start =3D nouve=
au_svmm_invalidate_range_start,
  drivers/infiniband/hw/hfi1/mmu_rb.c:    .invalidate_range_start =3D mmu_n=
otifier_range_start,
  virt/kvm/kvm_main.c:    .invalidate_range_start =3D kvm_mmu_notifier_inva=
lidate_range_start,

and AFAICT neither of them wants an invalidation even for protection upgrad=
es
either.

> A flag allows users to opt in instead.
>=20
> It is also not clear to me that secondary MMUs are not relying on the
> notification in some subtle way. In fact, Sashiko points out in reply to
> patch 4 that the notification lets KVM retry the APIC access page reload
> in case userspace shoots itself in the foot by calling
> mprotect(PROT_READ) on it. This would require a really weird VMM,

s/weird/misbehaving

> as it would need to go looking for the page's address, but breaking this
> would be a "regression" nonetheless. I will address this in v2.

Nah, there's zero chance any real VMM is doing mprotect() on the APIC acces=
s page.

More importantly, doing nothing if updating the mapping fails and APICv is =
enabled
is wrong.  KVM needs to ensure vmcs.APIC_ACCESS_ADDR is fresh when running =
a vCPU
with APICv enabled, even if that means putting the vCPU into an infinite lo=
op.
VMX doesn't support "inhibiting" the APIC access page, i.e. the memslot can=
't
disappear while the VM is alive, and if userspace mucks with the VMA, then =
KVM
needs to prevent running the vCPU until the mapping is restored, irrespecti=
ve of
mmu_notifiers.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 464d6ed862d5..11b24a42e482 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6928,8 +6928,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *=
vcpu)
 	 * APICv is enabled, but paranoia won't hurt in this case.
 	 */
 	slot =3D id_to_memslot(slots, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT);
-	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
+	if (WARN_ON_ONCE(!slot || slot->flags & KVM_MEMSLOT_INVALID)) {
+		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 		return;
+	}
=20
 	/*
 	 * Ensure that the mmu_notifier sequence count is read before KVM
@@ -6946,8 +6948,10 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *=
vcpu)
 	 * if APICv is permanently inhibited, i.e. the memslot won't reappear.
 	 */
 	pfn =3D __kvm_faultin_pfn(slot, gfn, FOLL_WRITE, &writable, &refcounted_p=
age);
-	if (is_error_noslot_pfn(pfn))
+	if (is_error_noslot_pfn(pfn)) {
+		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 		return;
+	}
=20
 	read_lock(&vcpu->kvm->mmu_lock);
 	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))

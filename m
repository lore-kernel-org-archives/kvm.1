Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3F3FCB18
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849335; cv=pass; b=jebAgDOc1neDhXIXXm6AxkL2h0Tsw08ZXHWqvNIXpi4Jokh+HZyIQ6tuDeolaCRjZ2y8E5XmBSeB1dkKPdjrwVlv20K5hVMcwuu6KBczeV82ccAUaDVYHC9uk5GR9IowEAJBlNwKpNIRD3PsGWb/mWN2aO/PdB3jtBuQCF2CO/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849335; c=relaxed/simple;
	bh=w2zc50HKUG9o+RInvj1x3Miawc6wAjSUnH05JPrc5Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsxXIvjtgMzKYuiJdvvhiKc2H/q8FRTQbJ+yrl/uJuzPLLiDoK7t+eoFvTC4o5D/nNqOW2SVFoXlCivx2u6cfceFvMVMNAkGS0wq2sgQ2WhL+OgUUe3E97ODlVV7QxCT0nEI8pMsTk4f4EnrzCnzpc4d+3ZCtGklWQEmtUjBlYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0TBDlox; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLXCmpaH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0TBDlox";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLXCmpaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773849330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2zc50HKUG9o+RInvj1x3Miawc6wAjSUnH05JPrc5Qc=;
	b=O0TBDloxzKaR2nCXSAWjFBe4OQqAezeNeCsLwJCHDkRpqJkjTU34oL+l9rLdZ6B+9Kg/yn
	fOJK4AYabnYpMmL8jIRZGuEwv3uHpIEzRSwh23pTL0lCNsNJaauabcbCT4YxobUrFVYWDu
	vFEPqecUzp1ehcq7ZmpF7JqaIbA17qk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-RHt6rkuWNE6eDtDnOp-lNg-1; Wed, 18 Mar 2026 11:55:28 -0400
X-MC-Unique: RHt6rkuWNE6eDtDnOp-lNg-1
X-Mimecast-MFC-AGG-ID: RHt6rkuWNE6eDtDnOp-lNg_1773849328
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b46b2b161so3300982f8f.0
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 08:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773849327; cv=none;
        d=google.com; s=arc-20240605;
        b=WlJRmKCoEFGgCpScIphIaDl4mQwR/FbYwrO8KZZoAgRPsbi6MrXbXo+tJhS0VXgMz8
         9FJdui+66mqvgUDEE69uH6c7y9VIAyeBwPAY7ydyymMLl1b31CHqDDDG20pdgCKB92xM
         jW/c+pzouKYZMpAQpYvJMBab0O912end1JLdDbz6DrZsRFzPINPTTi4u5b04sKNpR1xi
         4+rpZF3YSj2axPi0CCdz9Uycg5MQinnb01PwDPHevQUVxene+RQUBvqIXa+Av4MCD44l
         bWEij9tYfMhgS2ilaAagjl8cHSpFhEouxVZxRLHbRcfd2+58+dI6b9/8rVDM20f+KA7T
         zJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2zc50HKUG9o+RInvj1x3Miawc6wAjSUnH05JPrc5Qc=;
        fh=vrlbWIu+b/lsn22W+NhPnGOdslLoK2fuSf87d/6FL0o=;
        b=PJy1//EzAw6C3VWAkFn9cmMBjBSb3jC/z24Dmbl10XIY77DDLa4Gpf4UC6m8ejCaEs
         7UqGhMpvR7K1bYO4mmsnjLDQZoRmCtzNSi9g+nFgS6oZJ3gxY8iQjsgz/yMaWRb/QR+5
         tnj0xHz16sfo57T/qsXMu2zIam2shBSnUSgg9yKW7dtWIhHDZ5tMjZOuiNuSbr4BdyEp
         w7ljuc0FbSChK7+BdLIOOLSBdh1yj7iv9Wo21R9I3hDTfkgkSqyg7gGYAZLSNQ2BD/wY
         zNLla/SRiVKDrmglxzWJUlXDfTQM4GNtRlTjZgyZDHyQCSXm2Hw62k6bzoiUNMvtS6el
         2rhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773849327; x=1774454127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2zc50HKUG9o+RInvj1x3Miawc6wAjSUnH05JPrc5Qc=;
        b=GLXCmpaHTHK5jdmGZxlp+N58hWXZ0ceXV3Nf3bbAYH61dOROQxGm129P+LcuUZbJ+Y
         82so2jqQMnpKgjxvZQkEryPjkyTkLZwW/J6c5bjpRQ1H0qTXemMQ1PHOpYIIir47LRAc
         rtgYiRByMvP05jhh5ggmFZcuoees9UcUH1L1HAUFsw6ABgz1E/PQ2m9JKQQ88/IYCJV2
         ckFxkI/PW2TTBe6pRZPlSjm6cCexuTCrcNJs+yK37YAhFTQBUbuf7eZqk57Sg3lpFWN/
         YVpxE+zczeGli2FT4RcKGqXCs7KlalYqXg5XeUUtCAPIycZAYh4XwFlf0vWhnegGcjV8
         nCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849327; x=1774454127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w2zc50HKUG9o+RInvj1x3Miawc6wAjSUnH05JPrc5Qc=;
        b=ZSjrdFP/CVKzdWOOjZv4LCSAMNZOqbZWKKdcIAyvQLmMvSZ+4gpFldS8KMtUwYSXZR
         EKqykBLYvT2ophEsCkWdMYALZ9Eu7Iny+afm1ElG3Ey8j6lyzwY5AYYS4d/Bzjmcy6IS
         bp43ogZ87ZTWY51fGqOb7RkzIdecfJlv5TtCI3KST0MECO5e+vHOU/pQk5M/fRvxOsC4
         QAaB8sWJk9JTqmj/0MBo7USuUMyPzMy3FjBw2CI2kGkP+pL/vXzwzwuuM0zNBhz2Yfz/
         9Wp75Il5oSNS1+e8zvUULQX2WwsOCeaPdZ8KSx9PMylqBMMlR55pV175DMCB/TGD3dTk
         6fCA==
X-Forwarded-Encrypted: i=1; AJvYcCXmL4H747uEVPuvfleRm3+p8KBc8YXTbFpPAJ0ySSjd22XNH8etGdYiHWMP+OMzcoV+2q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzb+l4KKUq6qph46fJorMUIBVoLFiMozyO9JaTv4t/n4y855em
	eV27QN99GabkrZMgT+Rco62zOuuUd25qhQyKVD225/Wa1A4Au2UmAGGvbZUfryQXuLKV2Bv/o9Y
	UnTvWZoV1I+ZOnZAA6PpkOhQKHGW3Cn4MCOUx9H4tjEH8G71dy6S6TCaoE8QoYzbFl65+LpxFt4
	odlRRswo8P7iXi28kvNdnjGDKAghgK
X-Gm-Gg: ATEYQzyUo/spAln7TATMqyTjpwdvdDNGGENMSMULmDlZhT0n+bFU/GMzWW9UqvfPmBr
	My1HddHxRaJFLpR+DRjr3UbqsMp4jbDXig5nWIKlRTKUl3ogNZVEH8oZd16AnMjt7wxZDMgyAjg
	YeDTBMQ1qu5TVw3JmPLrxgWTgRXO8h+u/QMcg5KXPa8pC2m2RarDHrwBPxCTD02w52MtPFbsTOs
	t30V7oJqAw4T6vtSp8BzFhuwPpRtqtOPviri4mNSwCu6hwbcbmVXGnH+ZGLSRNAksZTfMEpwI/V
	XgOaNG8=
X-Received: by 2002:a05:6000:288a:b0:43b:41b5:e023 with SMTP id ffacd0b85a97d-43b527a50dbmr6928089f8f.1.1773849327530;
        Wed, 18 Mar 2026 08:55:27 -0700 (PDT)
X-Received: by 2002:a05:6000:288a:b0:43b:41b5:e023 with SMTP id
 ffacd0b85a97d-43b527a50dbmr6928026f8f.1.1773849327017; Wed, 18 Mar 2026
 08:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001024.136619-1-yosry@kernel.org> <20260313001024.136619-2-yosry@kernel.org>
 <181d8563-14a2-4429-9e18-ede7a6aeb030@redhat.com> <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
 <CABgObfY__euhy8YRpWbkVW8V2q10HS0nXmRQrfPOkt5iENbCGA@mail.gmail.com> <CALMp9eR2rAcr6OnmaHfiDFzSdDsGpWEPqNV0xf6OfSFPnEYU7g@mail.gmail.com>
In-Reply-To: <CALMp9eR2rAcr6OnmaHfiDFzSdDsGpWEPqNV0xf6OfSFPnEYU7g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Mar 2026 16:55:13 +0100
X-Gm-Features: AaiRm50hMOga8UvAINbpT2LVyUmr8LvxnNPeIHcH503HUG5CztC_5aS34uQMNIQ
Message-ID: <CABgObfYPYOF6d31EW4iOhhjvk2-orwGa5cckq-mPWxxB0VR+Tw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] KVM: SVM: Drop RAX check for SVM instructions from
 the emulator
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 3:58=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
> > Yeah, that part was clearly broken when physical address bits broke
> > AMD's 48-bit limit (and I don't think the details of what is
> > considered an invalid physical address are part of the architectural
> > description, for example some SMM ranges are carved out by the
> > VMRUN/VMLOAD/VMSAVE microcode).
>
> IIUC, VLS is broken because it applies the host's microarchitectural
> physical address restrictions to untranslated *guest* physical
> addresses. Is that right?

Yes, look at gp_interception() in svm.c. I'm not sure if AMD ever said
publicly whether it was an erratum, or intentional even with VLS
enabled (https://lkml.org/lkml/2021/1/13/513).

(Also I hope that, with VLS enabled, the check is performed *again*
after translating the address).

Paolo


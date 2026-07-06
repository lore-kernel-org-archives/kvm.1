Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5D423762
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375821; cv=none; b=jEzxEPGgjAwmPk16erCJfAFBGQ2vhgd8+Yd6Qu61GUiuhMYvVM7M5IKvtfVfrmfch8P+wLLbEgAMYaqpS1xYnOnq0EAMU/zRveJMbPeSl/XQkq24ETAY8WQorPovQ9g4dY2B+7DGeHkJ9i70omXFWmkpMwTqFLdWD86tEq2IF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375821; c=relaxed/simple;
	bh=scRh2OdWbDi2c/x8JjbQezLmH0RD0LXwZD4IFksG6E0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TLu4Fw9PuFxk72wfbGsRcEUdJ0J8MP/kIPEMxmoQ4QbT3chrPZHbyuUGZZIPYksS+IaK1lQv6jBqK6V/J0MN9zkMNeiZWOr1Z/9AXD7qDuHsRNMVYat5dlGpuxHxrWcnhAnojQ+3PsVHALRMOrKvZis0R93k8ecywOI/AJpWrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdsJuyjk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rRqFmv93; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdsJuyjk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rRqFmv93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783375819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mah/HpZO5BAes8mn7X8WZEkXgN+0zHJkp+xqEAPaVEo=;
	b=HdsJuyjkb6BmbKlG/e5f7SwMXZbEujjfndF6KfFOlaGReUVaZNE1wKOdjoGa/oUYp5rOjq
	FPPDpi1uW9Iv40OPkeCcfTTUdRzP/P1lF97yTqZxtlw7TA4Dd9QC06xBJJoHGloFlcj5pr
	2X9bR+Uoq/7anktbVNm0v47swQJQtTk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-DJUGyhrwO8uUPFldomQyhg-1; Mon, 06 Jul 2026 18:10:17 -0400
X-MC-Unique: DJUGyhrwO8uUPFldomQyhg-1
X-Mimecast-MFC-AGG-ID: DJUGyhrwO8uUPFldomQyhg_1783375816
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ec3314f65fso38026636d6.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783375816; x=1783980616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mah/HpZO5BAes8mn7X8WZEkXgN+0zHJkp+xqEAPaVEo=;
        b=rRqFmv93YAkuqRbmuA2N0poYHtxIKf0okDfRn56JL92Boi8aX9SAzpcGW4WC+6uPuT
         VCXLaDjpk6ajc0NUFeSoW1GP4ONd8d09Nr3oCNvmidDBjTNg0ffYJRKMCZMlaN0/WtHz
         IWaoPX8vtEMCVh+yoMGFBUgiWtJ9EX+5ofGYZQBDE9ihQYQPQtAJjy+psZgwzAt7Wiwz
         jOY54UUqb30rFy7dMHYSqVRWmwp5y9BpwVQkcrJ5BAtStBi2ri3GGMcwQE4HsvxUF4xY
         fnSG/weAsX1G1CEb0rjn7tB8THgHBjKBDnXyGCmQQV4Gq0c08d0Dx9o8wOnL9ksK+Gag
         Eoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375816; x=1783980616;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mah/HpZO5BAes8mn7X8WZEkXgN+0zHJkp+xqEAPaVEo=;
        b=TJ6MCUeMQ+raq8k1VCEJb6FHcGIIpwvcEI1mPSVe/A58DPHeuPjEW++d+TfKa2fnbJ
         kjO/BexZ7pt82z2wqs+mWdG9YVW/VRdZRc/3726INo3TlBkob0tr0oZom606Z2rIXXwN
         nMnET6quQqYQKPpD+Ib1vZ4Oofa6X17JTA3kKpay4rzWwmodwZwnnqMduh54HwFtndTW
         ggQaRNLl1pbBdAXVmYAVFeCNFnQfxOfX1qRwMBXkdaY7jBdBo2nJ60e1qeFzaiEYBXo+
         l0Z1xdsdJ/kMw7VlsomqrF54i6urA9Ylfm0aKhT50VCb1U9lZSHMIrsf7i16x2eTgQy0
         YiTA==
X-Forwarded-Encrypted: i=1; AHgh+RppSnMiSXsWxf4FCCY71z0xR1yU5t6FijJlNp6L5704FV4sunHhdDsakSi1b2g/ZwxIhYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDKT6qfvhk1IJeExBMyiCJZvLqz8EGWs/unjxL2vARXKPbFkJ
	B1LZJRneHyOcfOopFlIZul/hYTXAalty0s6dpfxYwFev3AcopHl9kbl6D5nswYYJsFM1YT//c1v
	qHoTqeJqL7xsidV9AeSgBD26YCZFK7c8NFWhaSAl6oE61lC65KaWb4Q==
X-Gm-Gg: AfdE7cl5KNybK7D3n9//eH3cXPsoQPMXuJ+D7S3k7o6sh/lfKFX/GKEENIMck4YFowR
	/8QDQryIfPQTOXVX7MxuoZrOhnUSo8f8PxN/vKvvBurvSM733k1+EdFNeMqDBdqzWuH05PwFdQV
	VhFaNdkcV4682ymb4S0Ai1V0Z+cH17Eml5WtVOv95RoXAQMrWAyrCjDr5+strNC5dATdYaJiEsa
	QS5HTdl/u4qMkHPafPo75cyG4XyheSyH94HWuPLB8/R6Sha87lRaaCLIOQZYGlAnIaOVExr/xjP
	gJ5FS38ER3e6Tvc2PPS+ErYLOk1pbCR9+i3SMd53wsUMZn98lqBY30cS0ryt227uDXBTB5MmZeh
	9g4YEcDY7cCs3ScF0Imo=
X-Received: by 2002:a05:6214:2f8f:b0:8f1:64b4:421c with SMTP id 6a1803df08f44-8fcb648cce0mr33728016d6.57.1783375815594;
        Mon, 06 Jul 2026 15:10:15 -0700 (PDT)
X-Received: by 2002:a05:6214:2f8f:b0:8f1:64b4:421c with SMTP id 6a1803df08f44-8fcb648cce0mr33727646d6.57.1783375815069;
        Mon, 06 Jul 2026 15:10:15 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:7d0d:91f2:ac3f:2776:92d6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f30c04fsm156615146d6.22.2026.07.06.15.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:10:14 -0700 (PDT)
Message-ID: <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: mlevitsk@redhat.com
To: Jim Mattson <jmattson@google.com>, Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn,  linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 18:10:12 -0400
In-Reply-To: <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
	 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-30 at 08:52 -0700, Jim Mattson wrote:
> On Mon, Jun 29, 2026 at 5:57=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.=
net> wrote:
> >=20
> > The SVM DecodeAssists feature is reported in CPUID
> > Fn8000_000A_EDX[7].=C2=A0 When available, hardware provides the length =
and bytes
> > of the intercepted instruction in the VMCB, allowing a hypervisor to co=
nsume
> > the decode information directly instead of re-decoding the instruction =
in
> > software on relevant VM-Exit paths.
>=20
> DecodeAssists actually comprises four components:
> * GPR number in EXITINFO1 for MOV-CR and MOV-DR VM-exits
> * Software interrupt number in EXITINFO1 for INTn VM-exits
> * Linear address in EXITINFO1 for INVLPG[A] VM-exits
> * Guest instruction bytes and length in the VMCB for #NPF and #PF VM-exit=
s
>=20
> You only partially address the last component.
>=20
Yes, and I also remember when I implemented some of the optional SVM featur=
es,
I decided not to implement this, also because of the same reason - pass-thr=
ough
is easy but for all the emulated VM exits, it can be tricky to get that rig=
ht.

Best regards,
	Maxim Levitsky


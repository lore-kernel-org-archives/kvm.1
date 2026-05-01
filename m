Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC0284693
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607632; cv=pass; b=r3M2WLBpjFmLhuwitX3snHY24CIinVZM8qa1jdRDlcriaFrb8zYj2XQZ15uS6xN9CS875Pmcedxp8q3jJgUm8vCV28kffFTrtdier039ymzPlQg6DI0T/zJgBSdugdCc6EgtudCc+/RA0/5V8pxLY0lT39Bfq2ldvgdElZUprLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607632; c=relaxed/simple;
	bh=pU5TQJxJ7YvOhZGnzVBDKiNqgQHVxRqQLKDv1L1gnqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0JCvllLvEDIP1QwftjEkY/1yIPhOloWkKsy90tmeXnqWx8WH6UPwV1h6VPjhw8hVj1uVgp94GgpLe3sf1k3cGWsxT8Bp246e+cx5J0nEF5LnEycq22c7AOW8Lfj5qhM/odfe+8Pqk/q3k7iRh/GhN4/bpmdSertH0KnLEu9hrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKKdThiy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjuP4jOv; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKKdThiy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjuP4jOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777607630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv8i1DZfFou1IkenGdvY9Nh69fATkMJeOxNwRa1PnJQ=;
	b=hKKdThiyyIvlXXAeVp2DusO/wCrJcMG4NJQOVsdLlLkRHil+oNprkmNs5Ba1APfarwgAFI
	J5vLW062KesT+HD30NbAyze8y6ABGNoeKgq53j6Sbt5UL8pgeQ7wSOPrrdZkSnH+ujRLPg
	7SAnj4QccUWbBGE97RdYEu2YguvLbPo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-At34p_FeOMylVqtaOzo0qw-1; Thu, 30 Apr 2026 23:53:49 -0400
X-MC-Unique: At34p_FeOMylVqtaOzo0qw-1
X-Mimecast-MFC-AGG-ID: At34p_FeOMylVqtaOzo0qw_1777607628
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43ea7a5da57so1003891f8f.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607627; cv=none;
        d=google.com; s=arc-20240605;
        b=iGKEOkW+MMc6U7uJPkHfale/D94CkOcTN2a2jYRy9D/lQIOu5w/pT4BdQaJrzy0HpN
         Xj3HmvxwOmLWOJFNhqsa5peiu0Vb2kuOx/6IvxaFyP+MrJxNCdg8osxzPL+roJopzzuT
         y1MTqtbt7Byps1WSA9c7p2niM7DPFRBR608Mu92BGK6Rc9O3hUWt96LsVb9eRWLQlbpr
         +k5uQRY1dcOJAfcygwSKYnAxJHPfaSWa98TAXk6sevCg9GGzgZA9cLf4NVF2Vo1eB4y7
         E6/yPyIVGeLYRO5J8HOlBF2x5XlUKmoR8GINh8pJGJW+XHcB2L3gE86NSBhIdpNuroz4
         gxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cv8i1DZfFou1IkenGdvY9Nh69fATkMJeOxNwRa1PnJQ=;
        fh=lswSEFIQrcdwvahKfK5u0IhnIYjfOxr40HKreZOmT7o=;
        b=Y3pF+HZ042OXpTy9jtn75CF7c6S9+gWPKG9hVn48lHwe/z6FQ4kWS9c+Kbqn2al66l
         tzc0BnPXHsaSBtvutggbukQzLPOdDK/QjKwyJmYycb3a4YFyGKa2Pa2jzySLAr0rDG78
         C4e+DsEU4Ue4W9zrmIACaMFd5pNnYz0SwC3I/uR2vPyCfgJ21/3PIevnW1NqHhcuUvGy
         XHwJN8mdrqFjgNtySeFgzIq9L/IxU1HhPyDCXQdaae1xW5bxFoL9QQHNdaTkw/fqlH0w
         Kj8K1IFw6LS8/y89X+iTpv8jXwTJ8LZBNPBshV4POnfLtmcP8hhT6RSjxZKds+0RpKWu
         cHXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777607627; x=1778212427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv8i1DZfFou1IkenGdvY9Nh69fATkMJeOxNwRa1PnJQ=;
        b=FjuP4jOvDRsStMwkYQ/rzM2Dz4BWEZXSl6UTvZ0YnEc/fJBF+TAsBXj3YusRvB7i8h
         XfApDK3VmwDK75SCGx6fjW8NWJyAB74lI5B6G2W1b7FGkZoMN+P2GLVdubxewFKtnJdh
         OEWW5hMw+VSoxuCZKBtTGmQwyvoVNBq80nWBBmfs5M1KO5lMbQLqaUIw9XtXiYDYRS5d
         ssM9Rf8f4h2ZmXPQtyixnAwjtf+qgtoCcGX8Cil0BMiMZjeC5AObMaD2XU3WxuOB+UPg
         pOSapYg1gCpGM5LHUD1LEMUrONi245RZkQa+c0vcIaCoNwwtlnSc/IoitfqoVXJTmtdd
         NQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607627; x=1778212427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv8i1DZfFou1IkenGdvY9Nh69fATkMJeOxNwRa1PnJQ=;
        b=V5XTcYgTJ8ET6kGPVcrXgZ530CkhPT+F3OBn8NS1zxPClPoLXnc+Nqd5Lsn9xU0U4k
         gyUlzgWeSQcQRFfAxkacbXELonngoXcv+s0RFJ/6x+NZ/WiHGGoCBYOIh0eo0ARErNA6
         OF3cJY5McWviEcT41HLtOFcKDqzSMVGktad3FU0YPjv0AgM6UjHeobsdElj19EKQ4+Nh
         3c9N2KZHJkAKeZrfGVDLnjfMxV774mU2hat1xVHvjkP1rTJ8Lq+e9Gv6o0z14Z2789uF
         jreKHMGQ4mwS8SRhFovblKdPJKJllUNEwe2HQouWVYp0vo869JwgIYsx9UR1NgXrT77D
         jT/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9YLOtxrIk/ZFgL2CfPnd4KdNC6ZFCvq5okQypcBgJ5vPc8QDhUErCSAnfEl1G8j9yQS+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8K8XRzow/E6U68FWV7oUhJ/MTcPp/qZNA7JW0W8HQ/ktLIUi0
	jivA13IK+ZvUtrZ7FB11+Hnuc9/bXHivkp0PxIEFA9ykh3GV2ofUd1LCQ2tkP+HFL5gqS7IKnEi
	//mv7UaAeQzmXS8zQ9GL7HQVHEmPi6JVfZ5XhwswHmbdwMwzucWW70Ch7x+VUlvh9q266tD1l3H
	PDMI3CTqK1xrTlvOvI4KfgR9XTGC3VdfJIFWOD
X-Gm-Gg: AeBDietpyKkZOmOHipik6PnYb9lAMNnrPdzahzEV4y/F5JRLq1NvAcLEcvmOvTaC2li
	gR7+u7ejU2kJNO3F7KcmIspd9ar+t61kKOiiW4MRvsCR/5szG2SBCHFl4IB+uLe81UW2RzDeZ7Q
	V1TrYw1U5uM93lWrruMgTnTZqBKtz08K7Ej4RJqgDVmmmEsPJCj3FFxgFygZRbX+3KYnhlh1j8l
	30fziLBFNZ55AGC3You2ZUpPrN3mwV6fceavhMISGzpCiryjpowvkWyNvhUbSEE6Gw8wSP75QBF
	01/z3mDuD3wE390=
X-Received: by 2002:a05:6000:1862:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-4493f42beb1mr9574110f8f.39.1777607627315;
        Thu, 30 Apr 2026 20:53:47 -0700 (PDT)
X-Received: by 2002:a05:6000:1862:b0:43d:77c6:be78 with SMTP id
 ffacd0b85a97d-4493f42beb1mr9574098f8f.39.1777607627032; Thu, 30 Apr 2026
 20:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-13-pbonzini@redhat.com>
 <afOlFSfWO6oTXmk3@google.com>
In-Reply-To: <afOlFSfWO6oTXmk3@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 May 2026 05:53:35 +0200
X-Gm-Features: AVHnY4JK3hjBDBLHWSwNaryEdhwauKVrnm1cuW2jz_KsattsDQvT60JFXuz4Ufg
Message-ID: <CABgObfaxUn5H4eipE+9gjStMGEQZwzr7tQprs=-Q2tdsFs-mzw@mail.gmail.com>
Subject: Re: [PATCH 12/28] KVM: x86: make translate_nested_gpa vendor-specific
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:53=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> >  struct kvm_x86_nested_ops svm_nested_ops =3D {
> >       .leave_nested =3D svm_leave_nested,
> > +     .translate_nested_gpa =3D svm_translate_nested_gpa,
> >       .is_exception_vmexit =3D nested_svm_is_exception_vmexit,
> >       .check_events =3D svm_check_nested_events,
> >       .triple_fault =3D nested_svm_triple_fault,
>
> Paolo, do you have any objection to adding static_call() support for nest=
ed_ops?
> I vaguely recall you not wanting to do so.  But we're reaching the point =
where
> quite a few callbacks are in relative hot paths.

No, I don't think I ever objected to it. In fact I do believe it's
slightly ugly.

Paolo


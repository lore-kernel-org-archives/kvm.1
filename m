Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5073A63F8
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642201; cv=none; b=KUErJZjhEbWyWue+Ay72ax+MtsCv5NViZPot2KiLG/QPqbUInBxcSLMbVAYWUq0h1j+wMw7Vfw4u4jEVN7btBZNp7qYCLxevSbjR20ScKlSQC27WfChR9vVaGFZld73lP3/gh14dS+ImLtJ7WbutLHf0Z7gWJV+iTFQk9F91Ozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642201; c=relaxed/simple;
	bh=QMAMQMcXmXO5iDgO9R7Ml5i1jurNhgR83adu1yh9MHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oc6EPByoWUVKfBYosJ/lGY6dAKvaKxfW0W2QIMs0II5eZbZgCCUCtt1oPjGZWLZ6wCoJyZSJTwBuFPFREDC4m/E20IcFtxMDJxwAmDBMzrvyDipWaeEvBjmjlEVDZiNG0cVj0zJJq7DRcb5FMOHRVDUJrokvCRsRaXZR6f+U23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkTmP+ea; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkTmP+ea"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b461b36990so21904235ad.3
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777642199; x=1778246999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyM2EguwA1qrtJl1DRIhILftf3E18FPrc3foabc2hdo=;
        b=UkTmP+eainjXuJ5Jvgjo05Ouag0yXCmBuXw/Gajurjcx0LulOS+bZnHscNCf9oy3X5
         OcODUGb7+LpBYdBADMiVDBlOEhzFMR9A9TUxXra7A6RFwnsyqFABqgix80ZllGOok+cJ
         yEEW0Dsv/GCtPuXdTodmKHV2P9Y+nlILuOdS7K5XYSwA7Mzt4pP+ogz3wv00FqPWZWpd
         9TLRWMNqQ5mR/lCPJmzmDuYImMXMUHftEpjNtUrsLqFRIps96jKrMvjxENz7oA/l3p0a
         MQOdcnwRb5ziE8VHTRu/TtZv3uMYhKtFfcpExj1bBesEW9dkOOSDxgwWogmJyLhqQKxm
         VUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777642199; x=1778246999;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NyM2EguwA1qrtJl1DRIhILftf3E18FPrc3foabc2hdo=;
        b=ZzF1Srx5Xnd++yavhYRQq3QzQf60ykWJHG6iz4QQezYfQ2G9CoplNx1yzcDEHidXez
         SA1UUDkYHwsxbmaKr0u22z1HXdtAlA+SzzksH61YW2OEXbNRPiwnCVmqjhKAVXZGKOkG
         hzmRyE9Zj/3DmFj+FIK7UIdbN6tlFHFTxHt3GY5TZ/0lDx9SUsm+mm5rluiH+OsMW6vL
         5gssbzTIe2gB+vBCSb27bLAM2Kbib9zRf4SGdf5pGV6ceHBglgGbh/XGDpJzebCdWCHQ
         rLum/hF0zzsD2uvzCdxEll0gbPi4kFs1+NChzuldEZWK0im/pJdVUr/M0RlqVf8PVCaP
         CT8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9E0sDnb3o/Up8qKjgYU9N6ZJO4CbBTPCw4oSsCUx7pNpyNDjxvU2UVXp2aUFBK3qqMg6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMh6lrPRbksP80KLwvcSJCzG7hybtQT9muv3tbZPwx1g84Qr2f
	dolYieAaOVpNkEWW9JDAfmOqd41Gug42xRFJmU5q/MsK9aynvgxEYSbd9jZ/U1RwlaJbyk1hTcd
	OpQpDwg==
X-Received: from pltk6.prod.google.com ([2002:a17:902:6946:b0:2b0:495c:f3ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef10:b0:2b9:4941:7f6e
 with SMTP id d9443c01a7336-2b9a2319b9cmr76970215ad.2.1777642199127; Fri, 01
 May 2026 06:29:59 -0700 (PDT)
Date: Fri, 1 May 2026 06:29:56 -0700
In-Reply-To: <CABgObfYXLPtp=DauQkRaD98XPBowzr0bPdqd1cCgHt1cZk9xWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-25-pbonzini@redhat.com>
 <afOo4xvnIJn_FvSx@google.com> <CABgObfYXLPtp=DauQkRaD98XPBowzr0bPdqd1cCgHt1cZk9xWw@mail.gmail.com>
Message-ID: <afSq1I1hgw7QAZ-L@google.com>
Subject: Re: [PATCH 24/28] KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026, Paolo Bonzini wrote:
> On Thu, Apr 30, 2026 at 9:09=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> > > Likewise, clear X86_CR4_SMAP to avoid that KVM erroneously faults on
> > > supervisor accesses to an U=3D1 page.
> >
> > What, don't you want to more closely follow real hardware?  :-D
>=20
> Uh, I cannot parse this. Is there an errata I don't know about?

Errata 1096, where the decode assist fails because the CPU tries to read th=
e code
stream with data reads and trips SMAP.  Not a truly spurious fault since it=
's not
software visible, but I couldn't resist the joke :-)

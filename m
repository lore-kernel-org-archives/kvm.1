Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67D3C5845
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603124; cv=none; b=DuBAQaz9UdkXugu/WwlwsSLWL6tdygH8i3tKpF3pTqUpW2/Jhd+QIANVYXl/J7/ndMGNCPigvEICT83AzKOM0dD87HdyNuot2dolRlsCzabeJgH0io0GGmKOMwqUPk7h6CydVQb06OJrWJwsKhy/k3wunlh0+MQvKhYkYNx39G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603124; c=relaxed/simple;
	bh=Jm7YinvVbSvReMReGzBTNouks1rmhCdB6Y6bhY8JdNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OIkHqBs16fKkt7ETmlGQC/WnpZfXJzHyuWxIodK6DUPDQnYxsD+yCMzCNnQBYqNZzEz5wiDmuiNQ6s/xpR9KB+xs5cJqXaBhlw4MuqEbNYW+QMTJNUw7GRRFhloNiqFiOQXzb52ITVk/+xURYsI8AsHNDxv6tqClER5i9ruXSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQ0+REBE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQ0+REBE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423970cb30so713952b3a.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780603122; x=1781207922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1mTM21TlGmY8X4hPpp3UZLp1x2aaMy6UHN1ZJZs6gs=;
        b=SQ0+REBEDFWMf3YDE8NyHpnK+uqSIfyCrRXdAPgK6h5PxGMMMwnHQqZPbuCCM/4pQ8
         tY/jZOjZ+WsjhUe1dE/Q8bxZLH3HCGbwlee1bvuj8DpJVHihXCcs4obwfFkslIWLRscP
         dicB+Aeg/f3/AAibPaFAErmkJfzRMkCGuncdBHzf0eM5D8uSIFTM+0u17YL6aq8RY3+0
         hN4tn3k7fmOw1M6NTvc1M3TACTgPozAd6aQ5ANAmWZEV4Dh4xiTk/EDpa2p79mBgfR1L
         tXKK3AzZiuYZG2VvmujTZtHF20v3/Y+/rA50iU5CS17w+/1zVoz29WGRWmWb8TZo7RHm
         TWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780603122; x=1781207922;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J1mTM21TlGmY8X4hPpp3UZLp1x2aaMy6UHN1ZJZs6gs=;
        b=Ywhqt/NUF+D6mvYwwzipNKJfGZLAf6Fy/hQ2LQVSXPo72+ovU7qS6Zn7hajmXEkL1l
         pdp7rbTivqDFnx9OicZ7GUSfE1xDEFzzFruBeMnJW0nLJWRUqVXqENzoOODGKfYYs1nA
         Q4KgB8jCoSFRYKHgL2D44WihaCBKGRLUdYFsq55s7DM2xwP6Nctx0jyvql3irSGtm6zE
         F7icneK4weTw+ucJaQ5u9aGRblfCfwXjBZEuO/MQq5vGvFTAavUNQzhQ9ZEkmdiMG1dX
         aKSYfnf0HluvXZUM5HbN8FB2C+vhy4Jee03OorZRdHIuWasZ5Eyq5juwAVEBs2kLaTrI
         DGQA==
X-Forwarded-Encrypted: i=1; AFNElJ9uD+q+nXUpM/1+lghP5ek3NTrZj3KpeND+7ixtOK4+0fE8AXpQ3M3E7dzAEsaPB7c/JLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa75zHZrH5Y8by7NDqOxwVNtz3cOKOPu5QmMEdHzVUpwYFy9wJ
	1QzMgtK72MQCvppnL/uRkivMC7aib7vSeQhKF+fXDbs5m924C5rv+jkvkrQLy+VRFo6vb43vmMt
	MKHkjEw==
X-Received: from pfbdu7.prod.google.com ([2002:a05:6a00:2b47:b0:838:27b2:c6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:808f:b0:838:127d:a167
 with SMTP id d2e1a72fcca58-842b0e6bb0bmr189707b3a.16.1780603122098; Thu, 04
 Jun 2026 12:58:42 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:58:41 -0700
In-Reply-To: <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718214999.git.reinette.chatre@intel.com>
 <2fccf35715b5ba8aec5e5708d86ad7015b8d74e6.1718214999.git.reinette.chatre@intel.com>
 <Zn9X0yFxZi_Mrlnt@google.com> <agPUfzbMzTU1ebii@intel.com>
 <agY6JuEJRhwpwlRL@google.com> <aga+jCVUW0d4GufQ@intel.com> <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
Message-ID: <aiHY8cWZYZNb-DED@google.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Chao Gao <chao.gao@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, mlevitsk@redhat.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenyi.qiang@intel.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2026, Jim Mattson wrote:
> On Thu, May 14, 2026 at 11:35=E2=80=AFPM Chao Gao <chao.gao@intel.com> wr=
ote:
> >
> > >> EMR158. VMX-Preemption Timer May Expire Earlier With Certain Large T=
imer Values
> > >
> > >I assume the same erratum applies to previous generations as well?
> >
> > Yes.
>=20
> This test still fails on our SKX, CLX, and ICX systems.
>=20
> Sean,
>=20
> Were you thinking of enforcing a cap on delta_tsc in vmx_set_hv_timer()?

Heh, to be honest, I wasn't thinking of a whole lot of nothing.  Falling ba=
ck to
hrtimers does seem like the easiest solution.

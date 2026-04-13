Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF5282F1C
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098661; cv=pass; b=gRQvhXOsxtSY6etwSPX3mk2G7H4wjWav7MmQYfArX/dT8lARt8JS9WsbEchi8nBSwJNLOYCGyvHoMgEpfHxiscFJD4WlbW1MbZhIY7bnIwl0u2LdkJwDZykQf9fpl8qwPSUZjR1XO/Mc3hw1HLYgN/P7DKvhYPeotX8gcO1565A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098661; c=relaxed/simple;
	bh=b/pe0z7HCtnOHxrmC8N06rOBxHgLiHy08YRt6dpG+rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiDhftJ35J3foZNETwcZhQP4wjtzLCt+7fs1/ELG6KrXfqnjuOxbRwVJh0sH6cv5QjdCE9d6QUVZKtYDOwKNGHFanXhWPhp8bnsF43OFwLs7JHHD8ruVxW0iYffD3W0UttCso+wpVSAouGkenBcRH0eiFyX3FgAcjtlVs6BxiZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vl3IS5yK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qqrbOUY7; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vl3IS5yK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qqrbOUY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776098658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QinWo9Aenh7noN26qv3lnlA/589VFNF6tJzopX0vwC4=;
	b=Vl3IS5yKl61GXGpu7Q4z5fWbqhPjpBQ5M3B2JHNNDCTYW5AZ2dghjyAWQTgMTqjSw1qu/y
	6FxYhqGB+OLAN98l7OnjQBhmGXS8nKyrCIn6NRfPjQrbD4+IgoPz5BiQQMgP8/oGUyiOcm
	AwCtQ1F7Li14CfVJvtZfxVRjEuiT0xk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-gYYu4trVNYeR_jpA5bxbrA-1; Mon, 13 Apr 2026 12:44:17 -0400
X-MC-Unique: gYYu4trVNYeR_jpA5bxbrA-1
X-Mimecast-MFC-AGG-ID: gYYu4trVNYeR_jpA5bxbrA_1776098656
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so4967642f8f.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776098656; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZb0rAYhWL53PZezYS4o86LsDTwjqhAv2V2NO0vhxQ8jfPVOv1DLfN0h9+dNWQ3tOa
         vO6DNxnev+TeTpQiK58oOc9dClpLpGdlJ1EuRCD884ihlqBZUKqIp5Ut5K/Ro2j7Im6H
         3HXuabC/SgbDryhSUTT9V2pUYPZOo2CJZm8/eLuVcej+koWM5FJRm6N9hOy/tOs9GbBG
         lHJO2J4Qn1LxO5/mSrmO4oX9wiFxqr5MfQjATLpLbXSnABIVFqFtNsGz0aBobsssM5IF
         LVpOcDX0iBxhuPwuNAvqmXJ12kYVJEAyZtAIaEJ14IekJvYRNBUddPuOGM1ae6utJ5oV
         4ZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QinWo9Aenh7noN26qv3lnlA/589VFNF6tJzopX0vwC4=;
        fh=d6QI1e5/TQ+8KNqlNX5cnPwQAs5nqPXFcsJ/vK8mm8A=;
        b=QlZg4L1gGMQVW8miZ6DN9KgOsyyNPzaCjl78iJmc23tpk3rhcekSHj5vH8Aq9oUq3W
         kgYUx1Biipo3Ju1GSDcSojvaKdevm7XOS1G/wzkqXDdSjh4zwfitwF7+WX5vuHZD3Cni
         vLhYUv+6ONYDP63+iTIOSRcpqHMdVwTG4ftm5ksvptimAbbVHou2LC4wEo75uJI/BxB5
         uaSp6z7WIZAz7uYTCGmOwJHJzpCnW6j2XgvhhiSxOdetFn28HWZ4/nGUw4DeyvuQ4OGk
         4pFj/qe+k/5KvUqs0dJ9pPf2NYmG4TXXHVNBidcsTrGX4B2Rb1HgQm2o3VPly5B3JnvV
         trUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776098656; x=1776703456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QinWo9Aenh7noN26qv3lnlA/589VFNF6tJzopX0vwC4=;
        b=qqrbOUY7uyhSNrmMwWDDCNnWr/Tp5E6CXHY1+dHrGShyXa+KG0o7NKHpMlM46rMTcI
         9f68iV2xsKqCr2ZV5Ng7XuliQP9fVbotV83eRa7kMurQ6ZjvXdPffJp74ZBf9VWh1YAc
         vqTY003axpzBr61jC4/XxIVmyDrP/+OYzHCIw8mOtsABpEx0N546v9IGQ/yFce+kKEwz
         ZX84o9NRpEfwu4IKus5A6M4YyFWsuMEFTVy4/1UQJkfyiZ8hyHYAbdLAOvXk/nHHfwdz
         pa/i36Xukj0mn3nALhPyPqc8ILI3Q9wUZe4euQocbc1iHX4o7B044r9wgnAArWutpcA8
         ewWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776098656; x=1776703456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QinWo9Aenh7noN26qv3lnlA/589VFNF6tJzopX0vwC4=;
        b=np17WU1au9bedw9FGGYiMRht9rxXYNWYJPNSyEJEK2YX/eja2Aq6cCrom5WLP7Qz8m
         EXTmLq5A3QUiF+Grbhy4BivGVBJaw8L6Ur3720SMWBpiniTXksHlfCKAMwBwSdZNlmIG
         hmFkpyIPU6iVzKjCKTCIuZGwU64OqU52Wk+tnvssNyb0DOEZSG+shBuf08Enq4DIgdiE
         Kjvn0kn1lBwmx8UyEBF9J22dPAhZ5IuUfSWXkXkF9i+J0bXQafauj+8hW+7AKSf+ywGw
         mwBx+/MmB0Muux+abyv/IqgS/KX82OHQ3M58OuQO1jbsMhvE8+bNXC9la0ePytOPmoc3
         xpaw==
X-Forwarded-Encrypted: i=1; AFNElJ9gIb0R27prTOMkVzTXm4fzPmO4ssXk5Qte0lGXCAjySLs8+BoxvTK6dhnArKESzkKhnx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa16AHaGDLWoC2+NDyL2XYGQUU+HqUq7Vxnm8v+KrUNrI0/fHq
	cpJCnwXC7/qyFY83siWSm3KRiX/Hu7yNXyOwYldZEbo2q8bAaxTZ5+JKF8HCS4lpmPDkWFi3l1s
	5vKgpT/QcBiTGv+EzcJhp2Jb0lb4tJBF4PbmDhtIoCPBLJUHgHX3BnBvfYF43bx53jWVgCw+XLf
	fVQYu1MjvfSiOs5muVCpjv4wW1EpdR
X-Gm-Gg: AeBDieteiVQeykzDkL7H9Cnf4FO+9GYUYQfcObrnFGnvxod60GmRz4b0jC7kP+30mxG
	tjmXw1/qZ9QYppbW3q+4pNipx1o9YLEXps9JJbi3kUXcTXZUt/pyE/ZsnORw3rXusakg1cEAJec
	Th64td8DDedECM2tCS5wT1jVocUBC+HujWQ3kz2MTQb53LPmg5gKEYfK3WQMSRzq7MqYhIKOTdD
	hFBCoFu8wZIY0q70OW13wEAeLK1L7AGEVL0jNltgTe+i/HiWLYcjwDuENMmlD9iJGKqznzOWXKf
	5HF3
X-Received: by 2002:a05:6000:2888:b0:43b:3d44:6624 with SMTP id ffacd0b85a97d-43d6427bad1mr20760607f8f.2.1776098655700;
        Mon, 13 Apr 2026 09:44:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:43b:3d44:6624 with SMTP id
 ffacd0b85a97d-43d6427bad1mr20760552f8f.2.1776098655216; Mon, 13 Apr 2026
 09:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202604131813.Sp3bcsFp-lkp@intel.com> <ad0c8lNL5ZoSRZI6@google.com>
In-Reply-To: <ad0c8lNL5ZoSRZI6@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 18:43:42 +0200
X-Gm-Features: AQROBzCmhNlgjLbboQMvOQmRweVH3YNctKQuxweJHyEPJsOZUQn15zDnx5VIbKg
Message-ID: <CABgObfbv1VwPYB3N5P+bxkxBgvPTU5cUN5eF3jCQHMe+vA0qVA@mail.gmail.com>
Subject: Re: [kvm:queue 12/12] arch/x86/kvm/svm/avic.c:240:39: error: passing
 argument 1 of 'is_sev_es_guest' from incompatible pointer type
To: Sean Christopherson <seanjc@google.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org, 
	Farrah Chen <farrah.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 6:42=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Apr 13, 2026, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> > head:   8f65c76d62f1f07d68b8a14829a59049311547b1
> > commit: 8f65c76d62f1f07d68b8a14829a59049311547b1 [12/12] Merge tag 'kvm=
-x86-svm-7.1' of https://github.com/kvm-x86/linux into HEAD
> > config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20=
260413/202604131813.Sp3bcsFp-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20260413/202604131813.Sp3bcsFp-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202604131813.Sp3bcsFp-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    arch/x86/kvm/svm/avic.c: In function 'avic_deactivate_vmcb':
> > >> arch/x86/kvm/svm/avic.c:240:39: error: passing argument 1 of 'is_sev=
_es_guest' from incompatible pointer type [-Wincompatible-pointer-types]
> >      240 |         if (!is_sev_es_guest(svm->vcpu.kvm))
> >          |                              ~~~~~~~~~^~~~
> >          |                                       |
> >          |                                       struct kvm *
> >    In file included from arch/x86/kvm/svm/avic.c:31:
> >    arch/x86/kvm/svm/svm.h:415:62: note: expected 'struct kvm_vcpu *' bu=
t argument is of type 'struct kvm *'
> >      415 | static __always_inline bool is_sev_es_guest(struct kvm_vcpu =
*vcpu)
> >          |                                             ~~~~~~~~~~~~~~~~=
~^~~~
> >
> >
> > vim +/is_sev_es_guest +240 arch/x86/kvm/svm/avic.c
> >
> >    232
> >    233        static void avic_deactivate_vmcb(struct vcpu_svm *svm)
> >    234        {
> >    235                struct vmcb *vmcb =3D svm->vmcb01.ptr;
> >    236
> >    237                vmcb->control.int_ctl &=3D ~(AVIC_ENABLE_MASK | X=
2APIC_MODE_MASK);
> >    238                vmcb->control.avic_physical_id &=3D ~AVIC_PHYSICA=
L_MAX_INDEX_MASK;
> >    239
> >  > 240                if (!is_sev_es_guest(svm->vcpu.kvm))
> >    241                        svm_set_intercept(svm, INTERCEPT_CR8_WRIT=
E);
>
> Ha!  Not my fault :-)

Yes, I have already pushed the right one.

Paolo


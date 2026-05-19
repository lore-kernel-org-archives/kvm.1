Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF53A9639
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186346; cv=pass; b=hw0qAZPHQWwwNQJQ74KgHSXh7sHoAMEcBXM9QdWT1oKCUptbL1oTvyKKuqm4m+4Blq3VzXgjrZ3d/gMnHdxT2F1oW4NP2AVOezkK19lyORwg4zc9Ddxyr5VFaCNbvZGbJER1s7SJHoEzHAhcVN1lFNon6SFVL9rZUJLfqvd0sSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186346; c=relaxed/simple;
	bh=Y/MyPdyjV4qZIDnwUh/ZZpRIHIGf7i+MnsQcNfHNL7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDinUGSkoZKJst2PmDrJdv5KeZG4ldYD5AlURXdA12dEW233vyPbNtF3cUwF0VGLY+y7ZPlI431HrT3Xj0P6TuBgh01RRYiZHszD0J2QMUXy26E0i+h+1326ZfPdyoR1Jd0aSPiRRPlm6O6iN6OrTAxfnDJVFc+U1RjOZ+B/kvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awPYH88q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtWhzJD3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awPYH88q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtWhzJD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/MyPdyjV4qZIDnwUh/ZZpRIHIGf7i+MnsQcNfHNL7Y=;
	b=awPYH88qwiT7BqkkkF2p7RcdWJ2R/66cXNQMMDDL/FQ3cdbdI2d0+V7xynlUnglnbCh8ij
	IPC97yhUE/FB0AbotJByGfbbfdQjfrU+QN+g9wzauGx8jK/D6Wa8e6Sch1G+l/DXZc+x62
	muqF/4fSww8pTVDB4vfhWOTSYi/cElY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-PA0iDZkpNEil2eM7E3O9ZQ-1; Tue, 19 May 2026 06:25:43 -0400
X-MC-Unique: PA0iDZkpNEil2eM7E3O9ZQ-1
X-Mimecast-MFC-AGG-ID: PA0iDZkpNEil2eM7E3O9ZQ_1779186342
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd3449e6dso20856985e9.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 03:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779186342; cv=none;
        d=google.com; s=arc-20240605;
        b=K32ih5TWkMj50BELPeSlzVOTEpIppm9YJdLNPtyzEPN2r7s6Zwo00gkBEBJFw0tf6n
         1omo/klghVO+EA9pfpdaXD6ysA9FJsh3ajwOTSG1YYYi1+iLHv/887oFiZS172CRtjVI
         FOam/Wr7x2UBJqnooDXq5vHG2yR2HXjz1KZRm7embVPdDoTuCK9GGap6DVLT9l3hR5qY
         +R6vPyf4KVq4OCJJ2CLsj5z46UOBNINC5rBZm6T0R919BNUonwnkGx7brsczpsqfHFbA
         xZKP14XWLj+VvqNHUS4dtEXrP3ZvUjGe6MZ6Dpv8p4aDh8B+cD1+xhaKW51tGD72g0Cw
         v24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y/MyPdyjV4qZIDnwUh/ZZpRIHIGf7i+MnsQcNfHNL7Y=;
        fh=WsW5hzMHI82mfAVvZuLXCZOcHNRhp0m1ojsik5h2kXA=;
        b=kqFz++hsbt1n2nXvuWo96clS2+sQwNmrXYZ4M/rSk2alcgAi4/8kOXIjV58MMPGNJS
         FdPG0GpDO2aNmQTqdEKyObJOA3CBsNt2/fwvUqMmbhp0DK5C2EvIn8mu0nS6YxewtVEs
         jNYMIBgQmN3BuM5mHp1KGg2zCQsgVmD1MWmPpRa9B3EJ3tROkL7F5CyRBAXmLzUJQxOE
         wVLft3juu89lUSGw9sQt0/JroN9zeibyfX5A9q5Wy5arRvsHiDU/5/y/eq8oaDYy/5Fw
         6IPfSNx5nRzNDCG6S2VDOUDLEwNEPUGCZZH2CfamjmnKkz7swyeHpakdoE9Gylwuj9a8
         PFag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779186342; x=1779791142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/MyPdyjV4qZIDnwUh/ZZpRIHIGf7i+MnsQcNfHNL7Y=;
        b=WtWhzJD3cP8ahekxd1sMACPi0xEeQXKt4qS9W4o7/gowFvDOXiTpmtK2qZ59UAMmGf
         9K4+nayIZ32cZSjwC/CcjhCicvbBZV3KBgksi6/wEAeR9KDpW5ImY62zCpCrv87MVVXB
         XEG2B1Zyu5117pqSfYfaUEOq08T4nv2jlQh+hRX7u+XdyEUD1ypY3voK+GJuPCpwQpuf
         DWSynY0CdJqrx5HZkNHCfh72TqzXjKutN58la18xYTax/3MAIjcAVfQDqENiR8Fl0qlM
         ilBMyQPEmUGqw33OldN+pUZPwSl1Ykwem5pK2/Un9iGgyzgbvtng+BPYitJFyeVCQtVC
         I1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186342; x=1779791142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/MyPdyjV4qZIDnwUh/ZZpRIHIGf7i+MnsQcNfHNL7Y=;
        b=fK7yRZg4A2yrJ4uTy9xrTxv66Gkno+UD1IqI1D6PPdmEpcny/yUfevDBpBDF//+V8I
         awMqwCpCrReSjkBCUi+QFILFxkr5367fWI0wxdMo8ekmV7D30ZGfEU4e6bAhyt0F6cUH
         pSCi+dGUcjz9TjcF4KL/6AoUyeyJvj3BgBFKNlU2h1jJRzsNkrq+6kFSCqjxBlXP2jAe
         3xEBSVDLWbflorUdckX1jpX/XFkfvLP3fPDMlbk58fAroXjFcjyyi95NghzDv4dADcS8
         L27IBHJRH1fJUy/181UFIficTfDkPm7IhHaCi2QnldWNc+t7rcK0uLyVJBAiWW2ycFtn
         oQQw==
X-Forwarded-Encrypted: i=1; AFNElJ9RoRDnz9pOPviBvd/DAtx6vZxVTeWzeunz8d7vdb56aSSkQT2cV6flvWkYY+ylXfpxkYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUn2ONVqCotBQT2gMEsNtVauaoID36Ld0ls8Tn+AmHEj9+PvGn
	Kwnl/j74b9yKe11fH3FAdT0Kwqc0nFo2svFEPiOX360QHtqNN5LFNVMMBdnf0gB3OLUM73FdnCl
	qN9JOWiRR5GqNpv14DwKTJUJIRiAVQcge6EBdR86QLPV4eJZdnP+SOaj7Wo6DcMUYem4JVG67tw
	2QpLkJIwxvUYAhDPYbRm4mN/sHs2gX
X-Gm-Gg: Acq92OE5YczsoZkGwRj8Oz++trHwAsj76goB7jCH80SU+aUFamph1qUq0qyZYREth8e
	wOzUhQYou/YM9uiwV+uUkDMcrPKRjo3nD6IL6OoiOyRp+N2RK/xON5nlAjkOTCpmcx4AItR0zKC
	378rUmYpNmvPZUOKavEqSKc6kPteuYnO8dCjwkW3uYtwubMThGLVpN3HIc6lWdoVdaMqYQwF3X1
	23iaq9p98of4lzuSKrzLDC/8c8lUupdTxrguc87N+FENTDCFaz6GbNKtPnLdVHaVL8e8JOuDuZn
	R4SNOw==
X-Received: by 2002:a05:600c:6992:b0:48f:e230:2a20 with SMTP id 5b1f17b1804b1-48fe662a1b2mr292957705e9.31.1779186342097;
        Tue, 19 May 2026 03:25:42 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:48f:e230:2a20 with SMTP id
 5b1f17b1804b1-48fe662a1b2mr292957105e9.31.1779186341591; Tue, 19 May 2026
 03:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511150648.685374-1-pbonzini@redhat.com> <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
In-Reply-To: <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 May 2026 12:25:29 +0200
X-Gm-Features: AVHnY4K6s1unkXJ7fswgTMd12_xd9pc1LT-39zURix9ZnAOLu7clWa9QQNdAA64
Message-ID: <CABgObfZ+TXrw7UpMt2DQUYb6Gwr-+vHy8E3iNbP8WB2z=+1ZTw@mail.gmail.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Jon Kohler <jon@nutanix.com>, "Tosatti, Marcelo" <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Il mer 13 mag 2026, 23:36 Yosry Ahmed <yosry@kernel.org> ha scritto:
>
> However, I can't immediately tell what vcpu->arch.cpu_walk is doing
> either (compared to vcpu->arch.tdp_walk), so maybe the names can be
> improved? If these walks are tied to these MMUs, maybe name them as
> such (e.g. root_pg_walk and guest_pg_walk)?

No, cpu_walk is always GVA->(n)GPA and tdp_walk is the optional
nGPA->GPA stage. While there is a 1:1 mapping from a struct kvm_mmu to
kvm_pagewalk when doing shadow paging, for *emulation* purposes
cpu_walk is used for both L1 and L2 and It replaces the
vcpu->arch.walk_mmu pointer from the old code (which led to either
root_mmu or nested_mmu). In fact the main change in the series is the
removal of walk_mmu, with cpu_walk always representing the CR0/CR3/CR4
page tables.

I could call them gva_walk and ngpa_walk, but I think the current name
are also self-explanatory (especially once you understand that
walk_mmu is no more and cpu_walk can be used for both L1 and L2). The
confusion comes more if you look at the walkers from the POV of struct
kvm_mmu. Which leads to the other half...

> I also think root_mmu and guest_mmu could still use some improvement
> but that's probably outside the scope of this series. These are
> essentially L1 MMU and L2 MMU, right? Maybe just mmu and nested_mmu
> could work? But I am not sure if we can reclaim the nested_mmu name,
> it's gonna screw with anyone doing backports :/

And even more important vcpu->arch.mmu is the pointer to either
root_mmu or guest_mmu. I wouldn't reclaim either mmu or nested_mmu.

guest_mmu is not L2 MMU if L1 does not use two-dimensional paging, so
l1_mmu and l2_mmu does not cut it entirely. And root_mmu can be either
GVA->HPA or GPA->HPA, therefore applying the idea above (e.g., gpa_mmu
and ngpa_mmu) would not work well.

I suppose guest_mmu could be ngpa_mmu or shadow_tdp_mmu, but another
possibility/refactoring would be to adjust the code and call the two
MMUs direct_mmu and shadow_mmu. I haven't looked into what this means
for the code but it would definitely make for the clearest naming.
Having direct_mmu->w be NULL would be nice, so it seems promising but
not something I was going to do soon (the *real* reason to submit this
patch now is to get rid of is_executable_pte() half-assed support for
MBEC/GMET, and that's where I stopped).

Even with the small complication that CR0.PG=0 is a direct mapping but
would use shadow_mmu, it's still a GVA->HPA mapping and thus pretty
understandable.

tl;dr: naming is hard so I tried to change as little as possible in
this respect...

Paolo

>


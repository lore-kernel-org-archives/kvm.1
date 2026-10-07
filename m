Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92948FF8B
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374742; cv=pass; b=C+A1tneJzLZzZlmp1THc1EZZ51ClBIOGWSuXL+42m8e6Sq0SOdvJYQhMmJKne9orTMhcZZ/hvRX+aWfu8qyDKqdQ8bunUHHqRG0aOqgdaO0u3epWZyUw2XCOclu7h02gz+3CrEyu5vrpw9mnkWZ2Gmq2PankiSzR3u7MkVP2kSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374742; c=relaxed/simple;
	bh=dgDkNP42S8yAyp5fESFUXhsuKZ5enHVJU+M+6HEcSN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvYIh6gF/lSymsiEIiS4AF/bh1O7XMxEHggAcjBJ/PGXiGBiIL4GEBKIsAsI/fBZRgQxkfz0RcjRP1Thha5FKyGRqQwuYdRf/GHzdhWJxb4FW26lN4dgfpoNiCtVdV0WjM/YgKrNqbZxzTJ65rIpxkXxkxXk0oW3Mrgp3AaSc14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSUt0tyr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qCIxOi/3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSUt0tyr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qCIxOi/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791374732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpfwXVRlOin+tq2YsuSqD/pQTBJRbFbnWGb/A3VMuf0=;
	b=OSUt0tyr0CbvxUG16yCuITYxae0fJ0nZ8kTVnq6kWcHs6R/BescDq6f0/4hqPZju+ILWFM
	KcsYSkXQaHQl3cn1DvhrCMP5sAp0pVxOHeBlqFOJyHXmyqGkqa6Jvd2TM25g4H0nRUMXeu
	cvtyTc+SI6DRjpoDzh72AhGU+WgO/5M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-MxldyOIgMeeNQfByoVOzyw-1; Wed, 07 Oct 2026 08:05:28 -0400
X-MC-Unique: MxldyOIgMeeNQfByoVOzyw-1
X-Mimecast-MFC-AGG-ID: MxldyOIgMeeNQfByoVOzyw_1791374728
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c50ed05abso2973174f8f.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 05:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791374727; cv=none;
        d=google.com; s=arc-20260327;
        b=kNTsVjlPMiIGVbDLBrpebKjDlz+3aTiG1REYVWRZkh/oMZlWXjN15EOAhDv39mFiS6
         HW6KqtzskkkvfEy7RFWsd/NWEX24dVR68Wy5EXRDRB2PQR4VjcJD3bMTASfz6MZEz8qv
         9x6c9H2BQlYiBnuCEcXJcSl7Yy6l0yAd/R48G9pmNAzrUijVpJKf/gAT6MQQ/wPbBF6x
         NYcs9CDurz1Ckp/x/SKQRw+6qUG6/6dqWwg2J/kGM27j0g4ifZEXad3UV/CfCDJg8mbw
         +ppmEjZtBWFMtQI9oY4v/DfP2cznisyA+oi8bI6ZuCTNBar1boAZbULnDraYMYK/N4zc
         ON1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpfwXVRlOin+tq2YsuSqD/pQTBJRbFbnWGb/A3VMuf0=;
        fh=BCeWSOj/6YsxKTAZvRe2ti21nvNdnmMTutYsCY1bCRY=;
        b=AnZ9YNPuiOjHvQhKmso9kWO7OiVjJw6UwFNlswo4QI/NW4EgqbSHUUn0Usxr4LuAio
         g0vmoAqOg2Czz6/9JpgtIsziEgF6QXHGm0Ka2yZhqslu+cHeyHDw08u85kpHdYqfr56G
         aeDo8TYpiTXaW03GvMrUV5otYrSKsQOBF3qe5hvLvPYs4ijXBI1tGQEBlDuYcj0+XzuJ
         Yc5WKe2Y63jQj2WEHdjK2bvgdB9bROeQE0Fqdu1LkSD74vT/WExK8HzK7QfrX+u3uwFO
         JpKoLQLN+fnmunya5zjcbIaAbBHZbOEomk4JHG4C12JC3Da0hkE9rZAhBfEptNaYLKSw
         vXCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791374727; x=1791979527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EpfwXVRlOin+tq2YsuSqD/pQTBJRbFbnWGb/A3VMuf0=;
        b=qCIxOi/3PkxgSdGk7zROfQ1RsaJNA7K5goq6DNTCPRrIecKNm2oC+a013VKRBMNu5w
         bcSwXdnbgrouMTI09V+C7Bm7ItlJDGYLyDzjvcbtZHuq0Xv4wHaz58g3Xn69TkCbW4uc
         dyN9tjR1kA9VB36JQYXfmbR9wU5au1o04i3plbatcfAQm7kGZgiVngIDe8NaV8IbWJsf
         3KaAdPTaj5N1bXmrMtZh8kBhbqfBGL7i+KhSs0fByoIQJbANccx6oslThcbsixI/dUf+
         iW6lI6rKGNXsvhpeWPcYG0q/9C4dLdTw7xtlgYdspMv1FRTd+U5DhlwoPz5bZtRtysi8
         wMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791374727; x=1791979527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpfwXVRlOin+tq2YsuSqD/pQTBJRbFbnWGb/A3VMuf0=;
        b=fPuaZFG552pXxTxqqjzFxsq/Qg2ImZMPcETn+NS1E8WQAxuwP+fk0aCQIOm4RCDZBc
         WdabjIMpulzF/VPKW78IiIrgGSgEWX90xeSInT0e9mJIayhzQ0/XyCwQ6pRo+X8bX57x
         DKMRGLFTlC305oj8buHyNBQSbR2vEFwqhs314Pj/OfDEm7fKrdq+4ug9YeD0jko7LnHB
         lGbqK+4Sr/ohgle2G5BqC8gMCbDhSmUOxLQDXB1a/wHHPvqGfae7z1eqOtYT4S/xkMYt
         B6vxleGA9U9IgvZ0PJnHTEKYpINFPohEhMoi9E1TPx1QTDhsnc31Od/RZBhKdj9P/APP
         h5cQ==
X-Forwarded-Encrypted: i=1; AKwUvBwP29wS8Pjgf48swUUHN1DdiDi1tw9WMXV4DxYnc1zQ8mqzPZViNKTPlUJk+YENrcY5qbg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJz5x0KvBhMsntZAOd3VjOGAn2Q1ya0u5EsYj0mGUlhvtPahZU
	310nfgwcisNePGOkFa6Oi+8klaQMUDP8E32hQ5TsBHo7dRQ0I01EpX/Byak0YvPGF2YUdZC/gOi
	00OtHOFFJojgz5A+OGmowZwx0RWQzh4DWwV7Nx06EWetL/it70GBXxQ68fbTq+JqeFCrg8gulXh
	Pcn1JalrgQwJ5s/Dg6qKCrOdJNY/hJ
X-Gm-Gg: AYBFou3i4lAw355HXaGDJgz/LDxsFPr+Asn5RW1JUWVZjO7jNXODQlr/2cRyUENQKD3
	e3D+oDV8F2u6FyKs3WNhWAsHsD8IQu63amWZqJLeu8NyynZ6FstGUdnfz0pFeNskBjqAfpOGIfM
	FldSPmDKeweVTRX4UjD9JEqxBhEi3PVzwhb+VU9QMBo8LM/hEgubOXMPH2M9kPvDv5QOaDhx8ry
	iWND6qhPGndYDDkKRn+msGLmxwPvEqvTfJj9EsSlKk6KKnP3M9xbSUfims=
X-Received: by 2002:adf:f001:0:b0:48a:fbcf:6f43 with SMTP id ffacd0b85a97d-48c72897157mr2889201f8f.54.1791374727559;
        Wed, 07 Oct 2026 05:05:27 -0700 (PDT)
X-Received: by 2002:adf:f001:0:b0:48a:fbcf:6f43 with SMTP id
 ffacd0b85a97d-48c72897157mr2889153f8f.54.1791374726934; Wed, 07 Oct 2026
 05:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel> <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
 <asYw47C3kHRtrzk8@mailbox.org>
In-Reply-To: <asYw47C3kHRtrzk8@mailbox.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Oct 2026 14:05:15 +0200
X-Gm-Features: AclHuK_Z03ujIQiOF-7TRNWQCnrBuxkAj8rPGfOtnF0oirqxDAMT1PCbQRT6hqI
Message-ID: <CABgObfasfsz8ALzFjLTVn+YCe2qXyfjTqc-mQYJ6se8zhxJLXA@mail.gmail.com>
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
To: SimonP <simonp.git@mailbox.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:47=E2=80=AFPM SimonP <simonp.git@mailbox.org> wrot=
e:
>
> On Wed, Oct 07, 2026 at 01:16:32PM +0200, Paolo Bonzini wrote:
> > On Tue, Oct 6, 2026 at 7:37=E2=80=AFPM SimonP <simonp.git@mailbox.org> =
wrote:
> > > Hello,
> > >
> > > See subject. Happens in permission_fault() on line:
> > >
> > >         fault =3D (mmu->permissions[index] >> pte_access) & 1;
> > >
> > > Some output from a printk I added, not spammed but keeps happening:
> > >
> > > kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> >
> > Can you confirm you are using nested virtualization, and if so what is
> > the L1 hypervisor and L2 guest combination? Also what is the processor
> > model?
> >
> > The issue is weird; it is caused by the SS bit which is apparently set
> > in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> > misc_ctl field, and KVM never sets it. Can you check if the attached
> > patch fixes it (modulo the fact that it shouldn't happen in the first
> > place)?
>
> Will test the patch when I can but for now increment the weird counter
> because there is no nesting, this is on a bare-metal hypervisor. The
> guest is Windows 11. $(lscpu) is below.

No, I mean nesting another hypervisor *inside* KVM; do you have
Hyper-V enabled in your Windows VM? The stack trace has both
npf_interception and paging64_page_fault, which doesn't really happen
without nesting.

If you are using QEMU, you can use "info stats vcpu guest_mode" from
the QEMU monitor to tell you more. If you're using libvirt, likewise,
that would be

   virsh qemu-monitor-command ID --hmp 'info stats vcpu guest_mode

Thanks,

Paolo


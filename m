Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BB2D9EFF
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051764; cv=pass; b=tyG7S7KrcYKZJCPwsIgy84D1wE0sf7hgGy0rKDgrXiWEW2jgK/Gt+jM994BGZ4EQdARrhs/tjmCYO8c2RQ+uRZln9y09uOITinFW0Lmshojpi2GnSAxJ0h6DkTsJDBdGTZjDrEmsUBMHOtgIfPgmoJa4jFMlFyxjN+BrGWgjo9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051764; c=relaxed/simple;
	bh=5qYm6zPYNqac98SQoyo7C4ZVZBOAqHceCiyqEvOO3Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8CEkoKL2ekhBO+1s0mz4S/Lkx7XoReRxLZ3xOsUHsO4iJCWTDTLVpP2BDT5IGK08nzGCkmOEGWXHY5PcVrlUjOYMWCWoQnpUiWGeBknf6qvyHkOgBQTyrDloSz6L4jjLBvd/6GTGuzsyqy3GYI/fVXKUdBAF9GVu2l/PhlOtrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4kZ5mYU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxTi0TS3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4kZ5mYU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxTi0TS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2e2JSmrXJ8LGho7EW+hH76+kheE6YeI0dvV2kfc7TM8=;
	b=R4kZ5mYU4Wk47F4hl5DnrlzWa3TV3COFNT3YSMqhOH+kErjzu5g0xfFUPXeMtNPMizmRZ8
	l41ppcfxDId+2kQbNGxNondA7N5a4EbEfguCkvrAMFZ1DCjw0/mmnElZzhW3DfPHIHosdq
	38SEHlA6AN94pS+JR3BWKWNJ6s4LRGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-fO17L664P5OamvekzDYyqQ-1; Tue, 18 Aug 2026 07:16:00 -0400
X-MC-Unique: fO17L664P5OamvekzDYyqQ-1
X-Mimecast-MFC-AGG-ID: fO17L664P5OamvekzDYyqQ_1787051759
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6d70223dso2593087f8f.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051759; cv=none;
        d=google.com; s=arc-20260327;
        b=MUsxBeNm0SvPlGaVXOGK2CZ6yUZm6aEA+G0Uesfz25/QEBpdM88psGFLE4IdpqiXRa
         tOgxb7xxGdxfTigkqNVTLsK4MuzkDiwejuNbHqxPWHY2CzZ+gyJOtwF2Y8PPYkKM4VJ4
         7kz9lugTtJNdDZL+WGMVabLhljw3pzA0SLE/HDfrWv2/M6/9HY73vl9ThCw5i7i1frM1
         LCQ3I9uBdG+6r4Mny6E7Mr6kt6vJtCkT0zLJqcvlltP0tbi1wGd7RdA9gbb+Wqedh4xr
         Ktxq3tl4uTamhKjwp2at2ObS7Ia3a1SsRngWcMD1g0XyCp0RtRBE0WeiUtdLUGLCyLs0
         7ANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2e2JSmrXJ8LGho7EW+hH76+kheE6YeI0dvV2kfc7TM8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=CgZfIlg9NL5JFwKABGG4uagWLm0kFTxOcsYZCB8yOg6rRSLpRjpchKLsxj2NBHNXGp
         nKH9Xr59REwgZ5InCDwVkvDk40azBVnvXFO/bdJe/ObLpYSLlKbD1i3fEi451E07HGMH
         0HPXE1EVO8nmiptBg1W+WBnkF0u0Uo7S7Y3CjVTLiBhEMy77V2mMdL9cLUGc2E7ji8ZL
         6tDU9/0wUX0SwUADYQNz3ymXF9adSZnNL7CqLyT2aVRrWgYWcHuGLjTqYcOJBReLuChu
         Utyb3AyOJq8ITLIqVFbNYiqoLJzRvVLOLih0PF2aHg1H05mpWdEX/l4Og0rUEXAOEoro
         I8sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051759; x=1787656559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2e2JSmrXJ8LGho7EW+hH76+kheE6YeI0dvV2kfc7TM8=;
        b=hxTi0TS3Y+T9OXYeZazE3rCIRqb8OG1z7ic7bj14lR+Cy896Q2l2VgaWs0mdPy5R9G
         SM4ZqzAbRu87uUf7y1m6CdX2bWN5WKSmNyUCV/Q9jgvaINanQTZRkKRKcOLLSqIdHVwc
         o0kEWCugj0rsCLAJ00NhaRIYmpWo5N8DKZ9iMy6K+sr/Cpos8vjLaVeA+FVeS0DZCOQa
         BW8SnApQWoKkx/x64QU1/8YtZuC4uAQOLICfufJfC8/iYKi96qirBVm66vfkngsjnA0u
         XaRQMsqBJ9tNyzFl2zDetckLm5AeqQE+7YotwQqc4dwMXFhLb+1ik7r8L6M7/grNFlx8
         1mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051759; x=1787656559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2e2JSmrXJ8LGho7EW+hH76+kheE6YeI0dvV2kfc7TM8=;
        b=bLcwW8lKskTCJd7VkVnwcOiz0ENqMt0QBHb75Z1tMLTKrjqPKohovPu2n9/PjS+Mjk
         6hHODAn41O/IgMULTgQCXVu1/e1hHJOqQC8Jb7wEloA4qSyFoLMvUS0+JW4FJMuEMWEJ
         TP2KGW5Aw5cNYDhkyfPDrXdHRCu41we5y0K9lrHZ/WWP1OjNVKi2xdVU2K6GB+5o/bfo
         p1fM55yVtiJIHAH56n+iAWkirwQuBo7Gpr6AGCXb+aNo6zVr2cOrlMzmqqiyA/UBL7/n
         Fh3lZAb/oMu3QgY596l0T1PJaFLe5wWwyCMEeT32vhwHWrjxmHsKsYTGaKU3DH3Vwh7A
         Oa/A==
X-Gm-Message-State: AOJu0Yyteo2P3Lk3Z0qoRqXB7OXAM1MqLgIJws/FOtDh4nrFowE7H20F
	+Cx0BUtTYb8ZBn1a+aUur6VPgeXRBJt9U2XFtaaX/nyRgx/SFL+PaBXpbbucR9pFsuY6k1ZikHf
	tXUps1OLpdvKHyLpYIW61vjOrgaz1ubllqRkVmCRCrOOCNjMV6jZYjRC91baKOe77bv47mE3YPZ
	dZWKgaGV6Zf3tpkdpRzF4guGi7tQAD
X-Gm-Gg: AR+sD11AK/faUFPlICygV8hAgKI7wB5BPyeJFXjGiWKaXrSpdlvd2VnGM2OPJ0GUhEp
	QbMFrvnJSFeTf/qhKMyzlhvaYmI/nGg8RTnTriM+k7IQqXzgwKxEL/HHZ/RcSrk/q8mBlqHEyMI
	cANxDe6zw1Q3HcdyIpyZma/VIaxslrHNL7XiPaSaw8Ig5eryO1GhvPDfAB3WzTU8Qt2e2U7t/nI
	lpuLa1IqI0+PXpCHCMGkwnUMvE7C73OSzJ9dNhmmTC+BVUcADz4JxQODsU=
X-Received: by 2002:adf:e013:0:20b0:481:98d:b24 with SMTP id ffacd0b85a97d-482a903d8c4mr9645122f8f.19.1787051758827;
        Tue, 18 Aug 2026 04:15:58 -0700 (PDT)
X-Received: by 2002:adf:e013:0:20b0:481:98d:b24 with SMTP id
 ffacd0b85a97d-482a903d8c4mr9645048f8f.19.1787051758382; Tue, 18 Aug 2026
 04:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <20260812213206.1564354-4-seanjc@google.com>
In-Reply-To: <20260812213206.1564354-4-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:15:46 +0200
X-Gm-Features: AcwNN1V-1ZdwzbqIcuquNRPeGPgWnQx-jz-_gRJwSkP4iTomUqZy4QrZEEs5bYQ
Message-ID: <CABgObfaroMnHEw9imhKLxJpL=SmhkGmrn1UO5FdDwvmQNZVxSA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Generic and documentation updates for 7.3
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> So the subject is a bit of a lie, as three of the five patches are x86 sp=
ecific.
> But two are common documentation updates, and the third has a hard depend=
ency on
> a common KVM change that might be questionable.
>
> The potentially controversial change is to add a per-VM bitmap to track w=
hich
> vCPU IDs have been "claimed", so that arch code doesn't have to guard aga=
inst
> duplicate vCPU IDs during kvm_arch_vcpu_create() and kvm_arch_vcpu_destro=
y().
> The part that's a little less than awesome is that the bitmap is effectiv=
ely
> wasted memory once the VM has reached steady state.  But, AFAICT, it shou=
ldn't
> be a meaningful amount of memory in practice.

At 512 bytes per VM, a single struct kvm_vcpu is (more than) ten times
that... Pulled, thanks.

Paolo

> The alternative solution we came up with was to use another xarray so tha=
t the
> tracking entry could be deleted once a vCPU is fully realized.  The conse=
nsus
> was that the complexity of the xarray approach wasn't justified, even tho=
ugh
> the added complexity is relatively small.
>
> The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f3=
70:
>
>   Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-7.3
>
> for you to fetch changes up to b41f2ca6c06011c36b75f5d53aa17c05ed90be21:
>
>   KVM: VMX: Fix stale PID-pointer table entry left after vCPU free (2026-=
07-31 15:13:31 -0700)
>
> ----------------------------------------------------------------
> KVM arch-neutral and documentation changes for 7.3
>
>  - Remove kvm_debugfs_dir if kvm_init() fails after creating KVM's debugf=
s.
>
>  - Document some of the "fun" gotchas with the APIC base when creating IR=
QCHIPs
>    on x86.
>
>  - Add a per-VM bitmap to track which vCPU IDs have been "claimed" but fo=
r
>    which the vCPU isn't yet online, and use the bitmap to reject duplicat=
e IDs
>    before calling into arch code.  This allows arch code to consume vcpu_=
id
>    without having to worry about cross-vCPU clobbering (at least s390 and=
 x86
>    have had related bugs).
>
>  - Zero a vCPU's entry in VMX's Posted Interrupt Descriptor table used fo=
r IPI
>    virtualization when the vCPU is freed to fix a use-after-free where ha=
rdware
>    will write to a freed vCPU's PID.
>
> ----------------------------------------------------------------
> Dmytro Maluka (2):
>       KVM: Check for duplicate vcpu_id as early as possible
>       KVM: VMX: Fix stale PID-pointer table entry left after vCPU free
>
> Tim Wiederhake (2):
>       KVM: x86: Document that KVM_CREATE_IRQCHIP must precede vCPU creati=
on
>       KVM: x86: Document APIC base address constraint for in-kernel irqch=
ip
>
> leixiang (1):
>       KVM: Remove kvm_debugfs_dir on kvm_init() error paths
>
>  Documentation/virt/kvm/api.rst | 15 ++++++++++++++-
>  arch/x86/kvm/vmx/vmx.c         |  3 +++
>  include/linux/kvm_host.h       |  1 +
>  virt/kvm/kvm_main.c            | 10 +++++++++-
>  4 files changed, 27 insertions(+), 2 deletions(-)
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8F3A1697
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077443; cv=pass; b=gEVrmQNz+1J+C5TcFFHcz2LYdbCZEoviwFak3ef8n7fl9Qo1ELoakdXRDJuaknmVUP9YAnoHfT+YI50mZRTJtlg5vtPQLY++l1dMWjOJvGtFNYlMOeClImztPd03dkjODj9NXvhoRLtwRwS+L5kuZ/YUVsfWOxZt5Kfr8eWzwqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077443; c=relaxed/simple;
	bh=qsB/wtE9zbhGMgjlY0bWTxFbPf4h92ifHVI9b23DI9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3d5Tzicu6nFikm6fA20C4M9DbrdsSNtbNwklYUibAwnzsJX2+OBEvqUPnaZ7liiFPV1b8TSgwL3fN0s0LvQlZ+2B//3p3/ZnoKqiofDtXwNPeGeCwuzW5y+TSX6IcxQljWHTJH1RcbAx/QmwfX88S+qDbb8kRUM7C2fFFJj9v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/yLRpak; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pST50b9+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/yLRpak";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pST50b9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wps14MsIqDtbGwsw6OFKuQKKc+LdEBWxsYvni/OeGe4=;
	b=T/yLRpakOa8cSFb3e0YtDjfu6NhF4+NKPqzxmCAVAd+w96jLsY2ZFKIZlc3x946bOBIL5s
	v9SXrzGjzr6+vThNee9E4k5A8zqD57pR4WCIh6niHJQilFNdKKg1RlHXf7ulvyarwceld5
	ndD+FnplagkaDWeQmUghqRuH4wmXwfc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Y0gBsDN-N1OjmathEY-v6w-1; Mon, 13 Apr 2026 06:50:39 -0400
X-MC-Unique: Y0gBsDN-N1OjmathEY-v6w-1
X-Mimecast-MFC-AGG-ID: Y0gBsDN-N1OjmathEY-v6w_1776077438
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488e097a270so9724155e9.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 03:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776077437; cv=none;
        d=google.com; s=arc-20240605;
        b=KG1n74rIH+TKPsUSs9J03D0m7vCH9s+rdBgo7OG/J+QTJgk334KK+/EzcndU3P3jWE
         u/AcEhhOi83TFzKixdQx4kdSBNFBuhvfy4Wd16qS9TQCHbDfuTAfoZlYLK7+GaAJvwv/
         H6eQVxsr92a2TZP/Zh3YsNOveFA0e4F1jt1qt9e3P56CytWMCnSPXlmQPaqd9hK+APIA
         WQ2kyypOJRkSGlwijPyXbOcad4fIAIN8MvWIFl+XpIs/9PZANHShxXyrUgT4yLGPNhWS
         E5G4fF5OWNE3vP4X9KQzncDOoybzV9X3Z9tIaViatufpGVRLXPLywBd9+qbb8WzA9niZ
         fgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wps14MsIqDtbGwsw6OFKuQKKc+LdEBWxsYvni/OeGe4=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=YSFU6io3+oOHBHB5QgWL56qBWbYo1u8tO7TcjmHRdit8gKYpAU1vdXUMxiTOuROEOv
         eZCM5SbpuyNmXr1WPpJCMPcBlA0v2t4LDiQ2IJpS76i2Atb2W7f5lAHMOwBjLA96gkEC
         6UDD3Pnl1TthNECge9upBkC/nWDZd8rfPvm2KngNreDa+EqJONk+amit3WKHmTRWivzB
         fKy1rQuJBEoktzxri4Bf7BfoEhZApEXTYc894OO8RyUgUB7t05Bo0WMyiLnLbhhR7nf2
         w/T1Qi4VeQiyP8HBOIW9vXZyoQReuXZ9L0saQpaNR4XveMzDlNTZ47/40uKdOsw8AlQ5
         xQ5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776077437; x=1776682237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wps14MsIqDtbGwsw6OFKuQKKc+LdEBWxsYvni/OeGe4=;
        b=pST50b9+EMe/NRbWKLKbhzwfMwVGysdoY0YW7L7zXKLBJT95u5TSJZYJ3F8LW+0rvP
         g1mlARgoq8hsmr3cEl+DAz5QKN5cDghaiIPWzpp5L6VFZTjldi2w0TqK4I9l3HoAi/oh
         9IyY7UzdfPJqVlKddoTS2fUNOMVzKFgcTmta1LcEL9AFsAug0J5SklWC424XPjwfQivt
         tcjWbjAvl2qBDclXO9FcQAo0pLcKWHAFb/HS6+Krbz6Lvb/tVV4NDlTB3HArk37q9rpp
         V99As+bILxWdXDsK162PwG5+yi1odNn7nUApCg3B0DeqzKIk2EFW39kQlruMEjolsc3o
         /ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077437; x=1776682237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wps14MsIqDtbGwsw6OFKuQKKc+LdEBWxsYvni/OeGe4=;
        b=JZlC+m+YUy5abj9skzva6czkOvEmBI1nRylWDViRlb5gUb/PBmiRtpAHb681ufSUBE
         BtRd8nQ3w5HwBD+UZVzA8ODvXIDiJGeeU58kE6AjrQ1m2jjQxr0FgOmwlk0GNUbHjxMb
         5zzWd2w0O8TBABLTRhFWoFBtRDfbPmiywgPgo8MotuQ1tYFw17EW0z9Op7ZwNtL032BF
         ukxbSKY1G/Jqld6lf5lqCnHscD1x3msm46lKNl7IT3O5i8U43rLicSrEcxTMpVn/7LKc
         lL1qucByY7/sPU3rVnDaZhoe3bc57AXMUvnHd8I/3ViKMuKt/rZwsLkPoYdTknlm5JVk
         BlUA==
X-Gm-Message-State: AOJu0YwBjWQOiSo2dZYooi81JlAm4vDNcoqB6kBuj/aKbkBariQXu36u
	qxfy1qUKWvqPBPRD6qT66CZrrRpY3NZVU8P6D826QhvsuZ+GIOZ+0ZVx4HiZfI481iPUDFH/8DL
	3F+MtsUpVAijVUJILoihFKQymu0eu8XoJb/7bmvm1n8UtlOY0UdW3khRHTn8LUEUPejFsGcDtqk
	CqJucOolJ9YQuTK8ILBcwl/duWYkp8RVFbg4Pz
X-Gm-Gg: AeBDievcCl/4nTB+tkyGHndgcPjMWFSqdz9RtbnxxhN5T6+C4cIyxCt4BDW1ufG8Cg0
	trV5z06k1NxWJOjdW2vjQqU32ZVNbMYjagDL51HZ9vUoYAiTC3MII8ffI/aNrn8USawDiD5qfh6
	Maed5XroLviZk2yz71affb3KPMjUA1xp5gxkboAK9ZOgMov+3/7t0MO0cUQ2BPkndRXmITPKmyH
	uRjyFyAAG7ZvBX2jB88RtjPr+Z2qv8UfeoJmFR4l3siHYzMmcBuITccf85K7RzoiS16eAW0YdMq
	T8sy
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id 5b1f17b1804b1-488d68c7fc2mr154273295e9.29.1776077437354;
        Mon, 13 Apr 2026 03:50:37 -0700 (PDT)
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id
 5b1f17b1804b1-488d68c7fc2mr154272965e9.29.1776077436903; Mon, 13 Apr 2026
 03:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-6-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 12:50:24 +0200
X-Gm-Features: AQROBzCPGNI4cbYdzBZxSXzS68-wLgVu51f1Mfk5SK0kAX2MWjUrIrqBjS71sEg
Message-ID: <CABgObfZqvwa7ZWzDkb8m_SdpXwPRg+NCdnQZqPVKYjJ0PuHAxg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix an amusing UBSAN warning where nx_huge_pages can be read before KVM i=
s
> fully loaded, optimize the unsync flow, and micro-optimize hugepage split=
ting
> in the TDP MMU.
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-7.1
>
> for you to fetch changes up to b3ae3ceb556945724d0c046ddb4ea0cf492a0ce6:
>
>   KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowed (2=
026-03-12 10:36:01 -0700)
>
> ----------------------------------------------------------------
> KVM x86 MMU changes for 7.1
>
>  - Fix an undefined behavior warning where a crafty userspace can read kv=
m.ko's
>    nx_huge_pages before it's fully initialized.
>
>  - Don't zero-allocate page tables that are used for splitting hugepages =
in the
>    TDP MMU, as KVM is guaranteed to set all SPTEs in the page table and t=
hus
>    write all bytes.
>
>  - Bail early when trying to unsync 4KiB mappings if the target gfn can b=
e
>    mapped with a 2MiB hugepage, to avoid the gfn hash lookup.
>
> ----------------------------------------------------------------

Pulled, thanks.

> Gal Pressman (1):
>       KVM: x86/mmu: Fix UBSAN warning when reading nx_huge_pages paramete=
r
>
> Lai Jiangshan (1):
>       KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowe=
d
>
> Sean Christopherson (1):
>       KVM: x86/mmu: Don't zero-allocate page table used for splitting a h=
ugepage
>
>  arch/x86/kvm/mmu/mmu.c     | 14 ++++++++++++++
>  arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>


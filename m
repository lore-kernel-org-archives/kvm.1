Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17B392C50
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561501; cv=pass; b=H9EvBJoKi5p5Vb+wxPXM7skz0PSKWyVA1bDCokUTL9zP3o7Rt5hrzSSClPrw3rt3RinEORO6xUBTJKfbNbzqvl5vWX5hDeNH9bsGhoyHEUjo9tvzlVBE6rWQ2N0VXgX4OHbtlmlWWwFw30MYkzy62Ie1zZPgoboAKZ9sSjagZi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561501; c=relaxed/simple;
	bh=H5HgyIlsw0FH+q0vPjCvMUxollTUJgEt/Obula8tczI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdHo23fV/1d3SaEiFX1vp1kz2iK2c9+TMe7p4LJRaiaRGcnLn4UVEsLQDjkl44krvWVtviT+aW73l6++ZRQDZc8C2oxdfwVQJ+Z79WoHzDXgaFeOTLHXvNVOYbulbCaz1gD0yh5kHjIsjh+sHu90py77u0F8DcFS5TxOBHfrfkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8+ED2jM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oTyom0ns; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8+ED2jM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oTyom0ns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791561499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsWl+jQaevR81Yppcc5u0OX8FaKpUFiecTztMLcffMY=;
	b=X8+ED2jMM4A1tTESmjXGhdUXMHxfjdFrifL7M+JlcYDsHBb/ayC2Q/BaFBOFW5xV9I/wiY
	zJRfTB/sQICshLtWG9viWVb7AUTpYDpWturBlBk/lJlRHEyL+1+E8rChAeITXsWYYQiX++
	lh0MQlu0+OXyZTDhHliGO33lsEP0pxI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-2sRLzWPQNTuBh_E7xFtmpg-1; Fri, 9 Oct 2026 15:58:17 +0000
X-MC-Unique: 2sRLzWPQNTuBh_E7xFtmpg-1
X-Mimecast-MFC-AGG-ID: 2sRLzWPQNTuBh_E7xFtmpg_1791561497
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48af4046a3bso5497694f8f.2
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 08:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791561496; cv=none;
        d=google.com; s=arc-20260327;
        b=kVEmhROsPiuFOx9MnWIYCbgc8BRUqtm+kqXEm3XDeki2A0JxSuTDIXBpoE1zXOeIUV
         +m9yotL2H+n7Ba6+gNVQrzb1uGEhAPtFBTht57HbSVVguVutkV0c1hXiGaA4rztx/7e4
         2ecjhesdDBehxMqnt2hfSOSTSkb6SSNpV0+PYU6Okp/TvEAUEu7/mWlVrQtqIF7cgi8+
         mUM2Uq7XYTC6au0ManH/79ho+NnH9c1gJom/P3tk+X1RtGvHvpw/xy24L1JPnfm5XUzi
         RWLQ+bevuNCIbOAjuOi0kpRyoQW9NVDCzl2fgTpmVTKeiVyXv3c5x65aq84NY5CcKlvV
         NJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bsWl+jQaevR81Yppcc5u0OX8FaKpUFiecTztMLcffMY=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=pCGiP2/V3jiwli2fPEn9OSSxUA0pCM6edxGiyYuNlqDx7fpHFt2XeNGaXlLctH5t2p
         N6HOV6TktsWH3/Fyvz9KzFCjGLa6o5CGv9unExFAl+83FyzVzHVimSNL7sW/qaqBPsMd
         FCeXsoLp/ELIvFwy+4mo0kPaXWF1ahXNO45R7b1iJKgOuQ9dTIl+jXkBNT7rbgcUH2YR
         afdwcL79+3r69L8wdRIOuHe/fHa7CzJ5Ck3bXDGX8i3RWI0e+tJ1Tbo0yIPClwOlpzKR
         p9nsHJ/kql26Kt5kEcHdOUWl1AePeiAEg/dkun2UtoRLDwujBkMB3lLAp5XxnhfOgsfq
         eloQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791561496; x=1792166296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bsWl+jQaevR81Yppcc5u0OX8FaKpUFiecTztMLcffMY=;
        b=oTyom0nsapgbl+rqUAHhPlu4x/0kKE0XcYU4VNQ1wT7hiu2FBpBj5As5Oga52cF8S/
         2lxjgbXxlx4ICHufpjk/HQFqK0nGk+Kb7VWJWN6V2o7W9TwwWM964VimQGafI3XPQiqL
         3suUs8ZRo5e0Nfyw+wev5GgRB+XCa7WBDUFMjuDRoaKmp2xxmOllkhw0Cc4jQDhfo11b
         pnVkscej8EzPt91g52FWpKIbr3Pi2DwbinSCLRGR8bqletpTTCJ5x3t86zlFGkjrBk5v
         zbm5TKZ6mxCmdWzQ9nw4RNSAMVevsn8ul9XI3kIDQJluLguorxiJ9KdypiXCiPBeOfkJ
         cXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561496; x=1792166296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsWl+jQaevR81Yppcc5u0OX8FaKpUFiecTztMLcffMY=;
        b=hZgAPkKS6BsB3mXvN499d7L62jZrvL/GYSwf4kWgNcSMifHme38PteZzaZqa5ZoOap
         4KqT2k2+H1FHWHcozGEyCqTdMemucO2bVxyjkbOFZMSrJD/yNbbiprfpN89c6rUzsz5K
         kFF71ccigZzHO+Lycia+VpTZlcgzO2AsmD5/nWruDE3PkYyAQTA8OeIqz+Dd2XhJntWe
         6yY8u98rSijSkJ8f22Zww9evaP8p0+NAoBJMEDe0cYu7voovPxUyNcFumW3yqWs/qw93
         BZU5ocLPrYc1z9h0Pt6zZX7oEolgf9eof1q1sZiqaVhCAwLuG/AlpWt7MvcnGsqbfbrC
         0Tiw==
X-Gm-Message-State: AFq9FYKn22T5cKYebeP2nerOuPH5k1h9xZDa+9HpVpm2VMyCtN9NBAap
	O/jM7Jn6Gcz7Pr2vDGuqw1hkW93Xas295rnF0k92AcPeMJYsBiqGtsKlvO5Ph+u3wFus8g7LZwA
	yRIe0xtiw6zSL3tEi3gxnwU74ZkBC+17Euk8xHpmGWzZcT1Je9Ggjl9uN6hJbDt21akSK8mcJBC
	/q0St3LlCMDvlXqpV5KGeOdScWo5S//ANJIjLM
X-Gm-Gg: AYBFou12hlVQ+TR/CtaVa7MfgGTBUvdG6tf3MXns5DHQ8bKSbSeh4eUU9l9LXgJP1km
	JFK3Rr/5drbOf0/A3M1kZhrMZ/Ll2VnWs6ofHuohucjHZ47pY8+IIoOJREkLB6xCvPI2POv/uUY
	xGgSKfi91h82aT5RfpP76vZ1LhA15DyrLJTYSbk5VGYe4o9jErCcPx/IyAfUEe2HDT18bDM9vU8
	nqja3WiQaKcAC8t7J7TO9peQmNmugGRDux5CVL7K3AhjyHPfB14OWTNMNsDGw==
X-Received: by 2002:adf:f88d:0:b0:48b:6bb:6d37 with SMTP id ffacd0b85a97d-48dbaade236mr3490750f8f.25.1791561496594;
        Fri, 09 Oct 2026 08:58:16 -0700 (PDT)
X-Received: by 2002:adf:f88d:0:b0:48b:6bb:6d37 with SMTP id
 ffacd0b85a97d-48dbaade236mr3490726f8f.25.1791561496196; Fri, 09 Oct 2026
 08:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002164750.3981742-1-seanjc@google.com>
In-Reply-To: <20261002164750.3981742-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Oct 2026 17:58:02 +0200
X-Gm-Features: AclHuK-7M2P1s3vmGyha3Gb1Dl0I5jX9wU2nbwFTblAHJjssh915xjEcJupkhJ8
Message-ID: <CABgObfbVST40ndfetLvBfj3m7PACQOcA3BC8j6zYnJvGjTUB-Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 7.3-rc6+
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 6:48=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please pull a few more fixes.  These aren't _that_ urgent, so feel free t=
o
> punt these to 7.4 if you think we're throwing too much into late RCs.
>
> That said, I'd really like to get the AVIC fix into 7.3 as I very deliber=
ately
> didn't tag it for stable@.  The fix depends on what ended up being the ch=
anges
> to hold kvm->lock for all of vCPU creation, which I don't really want to
> encourage folks to backport to LTS kernels.  So, if we squeak the AVIC fi=
x
> into 7.3, which is presumably the next LTS, we'll save a one-off backport=
.
>
> Thanks!
>
> The following changes since commit 973ea70393e885e540f714904e51bc6cac80e3=
d7:
>
>   KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV s=
tate (2026-09-28 17:11:49 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.3-rc6
>
> for you to fetch changes up to b3e6212dea2e4328a841ceb37f377583176dc735:
>
>   KVM: x86: Use active memslots for the per-vCPU MMIO cache (2026-09-30 0=
6:40:49 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM x86 fixed for 7.3-rcN
>
>  - If creating a vCPU ultimately fails, clear its entry in the AVIC Physi=
cal ID
>    table used by hardware to perform IPI Virtualization and delivered pos=
ted
>    IRQs.  I.e. plug the same use-after-free hole related to IPI virtualiz=
ation
>    and posted IRQs that was fixed for APICv by commit b41f2ca6c0601 ("KVM=
: VMX:
>    Fix stale PID-pointer table entry left after vCPU free").
>
>  - Use set_page_dirty_lock() instead of set_page_dirty() when marking a p=
age
>    dirty after writing back SNP firmware's desired CPUID state to userspa=
ce.
>    Using set_page_dirty() is unsafe if the page/folio isn't locked (as po=
inted
>    out by its function comment's big DANGER warning, which no one reads g=
iven
>    the number of bugs of this exact nature).
>
>  - When checking for an MMIO generation match, use the memslots for the c=
urrent
>    vCPU context (non-SMM vs. SMM), as a misbehaving guest can coerce KVM =
into
>    incorrectly identifying a write as MMIO in order to bypass KVM's
>    write-tracking.
>
> ----------------------------------------------------------------
> Jann Horn (1):
>       KVM: SEV: Fix page dirtying in sev_gmem_post_populate()
>
> Jinu Kim (1):
>       KVM: x86: Use active memslots for the per-vCPU MMIO cache
>
> Naveen N Rao (AMD) (1):
>       KVM: SVM: Clear AVIC Physical ID table entry if vCPU creation fails
>
> Sean Christopherson (2):
>       KVM: SVM: Add paranoid helper for checking if vCPU is AVIC-addressa=
ble
>       KVM: SVM: Use "is AVIC-addressable" helper to sanity check load()/p=
ut()
>
>  arch/x86/kvm/svm/avic.c | 22 ++++++++++++++++------
>  arch/x86/kvm/svm/sev.c  |  2 +-
>  arch/x86/kvm/svm/svm.c  |  6 +++++-
>  arch/x86/kvm/svm/svm.h  |  1 +
>  arch/x86/kvm/x86.h      |  4 ++--
>  5 files changed, 25 insertions(+), 10 deletions(-)
>


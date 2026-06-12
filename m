Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E035F60E
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252115; cv=pass; b=M+QIoQ1ypDkW8jX2nJe2VyucHpUImDwQBUH+56/SC79NETKwnwQMDnVdfECe4D0mud8m+5klBrnvxmi7z/+U2sgXwFgnnF/Tl5ymwjfveB8KO7O21thNCaWiEzvIgJjFUGMCOmcyk1uWIL/rAcAr4mzvmoRVfzb5eKlWebMZFos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252115; c=relaxed/simple;
	bh=OOef+hJfsAI2prviVKOQaIrv1Id/AQar3Vw9KfXV3XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMebyiWrX5iRyi6JM5c36cjNmfpo121z7uy8WGSvQ25a5Hd1zpBgjZoPJXI8sVgPo/mfdMtglFVofS0jsOpi3jD5u4YNAyChQBtRBjgLM4qBG4WXNUPgCV84a3zQXguk9xRKThxY2O0LvaSFmc6fvmdou0+eKzly7caGqfj07qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQN9bjvi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qrNtPk9h; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQN9bjvi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qrNtPk9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781252113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2jugKakI8bOmr8a7byaUAqvbiTNisbiZDO8vsAs0e4=;
	b=WQN9bjvi3f0sYQ1xed9vLrdiHqtOs3nWaLujLKyESVfFkCqcQoQ7eynVsqDogWAalGZLTA
	IAARlYBPcLErXsgjcrr+h880Gpiqjhj0eNI1khQD6n7usO1t8j0is0NBM4NNBk2P9si/Oi
	wcfdYOxZ0XXKwHsxQfhmyEpnFV9tchU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-CmNV2qsoMXqdyj47DPa-BA-1; Fri, 12 Jun 2026 04:15:11 -0400
X-MC-Unique: CmNV2qsoMXqdyj47DPa-BA-1
X-Mimecast-MFC-AGG-ID: CmNV2qsoMXqdyj47DPa-BA_1781252110
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf32259e0eso10016215ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252110; cv=none;
        d=google.com; s=arc-20240605;
        b=H3rmQHasTId8rbir+sxLUTIFROhXcZ0Hhm8vlKTA96BoMZvJ4IoOGF+4WYdRYTm/VO
         9IOvEiTEquKQivJps7BBRh5Q32GhNXx1HaQBo7VYk2EQOnmW03mj5AJCwyCsjbNLBpDg
         xKuQ0R40zfR29D5fCL9J5ge23wDEv5QUy0g0eqoGtQtdDCAZrvdmc3wr5TSMDBOI5Eu3
         5K4PL9L/viS9wH/wnjpmHoaKXQDUzmht37eNkydkP+IBcFbyRBH+pRKdEAzdzn/haVVI
         7hrGHCB8x3VJ3/hXVphn65z2XQScV2KJdoU9Y2jcrJt2GrB9uraA/NwCIE+ARlggpyyf
         ROiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2jugKakI8bOmr8a7byaUAqvbiTNisbiZDO8vsAs0e4=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=EBWxqctr0x7o8LZre8wost1LT5Q2SOp6bW/TlBFJdk7o/zHHiISkGGSG57dTs7R9Rv
         64e1o7fAk3NMO4WqcX/fxRRvI9b28g1eJi4SmPYYET580uRRVaiNEbAgk9ZLnh7Z4yfx
         EoEgfNsxHCGYFd69KoepYpOwwa1VUNn/UNDpDfoKppLfAIaxp9ZD4SS2T/xfaks7k9+R
         QnjeeZqg1UN7RakiO5tWcl6ZtwrQ0ubJG9/y346w7mFkueGZ41VgUyn/b8ehCKDAVnur
         Jjm4PBGyQrLBeTvCz+aflbklqI7LwQGdeBVJSO0cibqQl4Sa/nl1cCEQ/XErJ4PnJxdz
         lMIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781252110; x=1781856910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2jugKakI8bOmr8a7byaUAqvbiTNisbiZDO8vsAs0e4=;
        b=qrNtPk9hKYeiSdV+JLwfGXZ+s12e5fVGXTJYPb7eEOE7AUQ91/jWG3OdRSwc1RtXtI
         lMTdsTceAxDQskt335a0I3Ub5FEOAeekkdmGSRJ21zQ22ukK6YlZGFyFfH6h04qIO81m
         89m0AM8Ts4cC/obIovcK7PBzUE+cJgWYZrWiiPgapN/GcGiPx+1vc6E+ycrNyhY+cC8Y
         jGuxhpBK544iTJks/b3s6TH9/amutiC3n2KiCVIvPQ6yLZ/yrURrxRsA+BHvU7zY4dWM
         Y1va6C1krdLFhVjSfTSeDLAzkIvC6zCPS482uos0o1NS3KnXzcY6eYMVGPzDI918nUkD
         r5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252110; x=1781856910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2jugKakI8bOmr8a7byaUAqvbiTNisbiZDO8vsAs0e4=;
        b=AJtU7Xp97DwV8JEVGi4ONBWdH6+mG/K90JsQ7mKqrDyFwdZg+eLfHSZ9YYoVflGvn5
         efjEy5kM2GaxnauJLNf4IhN569YCtttTLe9DrYZoj1DQFMU9XHEXNWux2t84hP6/m1eV
         7GqSs7RRETqTCqeFqy4OlzOgo1K08ELOacAhG8iJtoMz8OoccwQXaNJAdT9P4qYWY3aV
         DsoyKTfZrzHP0geD3OeDXjPbnBse8G1/5Ne88VXCDBKhLWtWWzdCZUzs9B3nQy0Iyu5e
         e/eFGt+tDk86CJ3c8hQWgllI8hfZN5krQggA9TjsjP6inq/4hoPxs/lIIcPvn5kFVQ0n
         aPdA==
X-Gm-Message-State: AOJu0YyxUpy7voKwjAY3Ceu7pBhAcN/0QEhCNp6lzIWHdR7AJHKXbcpN
	3or0eBPk2xeN389nwo2CkVG+lZcbMGjYy7cDlda1VjX16MwV4lwX0J1/6SHwEtX1DXSth5YJCBQ
	g2ZrTZLQnnKloMfbrTrLynpctLUmq0hN21NEjdle1e5WKeV03ip+DA89eR6eybR1UJzBWPhB687
	dF3AopbyArSvKsi9mWsWM+yRZoLfgv
X-Gm-Gg: Acq92OH4/Jv5RBvAszHhTgzWGM6vcMzbpJC90dviO+hc16ufg+ThVCCvpB4kFkP/E7T
	jb9+FHvk/hCRsDnX5n3IgRCYYeVvW9LKZCWZ8KiGiYZuQLMYE7RiWW80eIGp8T74hCyDBSaEmr7
	+uNx6xix+Ms9MGsl/BQSdTw2ew7aByhbIwbYBYIsNK79cDXshOxCe17A5HkrT9cwWjmeTBVevHV
	NziDRNe8uycOHNcO4GYQwITs0iC2ZKx5yolVtZs3Z2H4vP95kSPqYAXa0p1E4OvhY48PLugfeNk
	Kc5vuA==
X-Received: by 2002:a17:903:40ca:b0:2c2:27be:39a9 with SMTP id d9443c01a7336-2c4109ecce4mr22599805ad.9.1781252110291;
        Fri, 12 Jun 2026 01:15:10 -0700 (PDT)
X-Received: by 2002:a17:903:40ca:b0:2c2:27be:39a9 with SMTP id
 d9443c01a7336-2c4109ecce4mr22599405ad.9.1781252109828; Fri, 12 Jun 2026
 01:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-9-seanjc@google.com>
In-Reply-To: <20260612004755.349925-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:14:50 +0200
X-Gm-Features: AVVi8Ce6k1l0qaT0tIDwOxqD0VxxXFLzDPNfYzBv5-4OxPdpqffmcLo31Zoti70
Message-ID: <CABgObfZBsY7A1a1bWO25ZtoB1tEr8mGE56Yaucm7CBUMQBKmzQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: VFIO changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-vfio-7.2
>
> for you to fetch changes up to 156615264fd3430e7f90b36f46076b2f6ec4a24a:
>
>   KVM: VFIO: update coherency only if file was deleted (2026-05-13 11:12:=
40 -0700)
>
> ----------------------------------------------------------------
> KVM VFIO changes for 7.2
>
> Use guard() to cleanup up various KVM+VFIO flows.
>
> ----------------------------------------------------------------
> Carlos L=C3=B3pez (4):
>       KVM: VFIO: clean up control flow in kvm_vfio_file_add()
>       KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
>       KVM: VFIO: deduplicate file release logic
>       KVM: VFIO: update coherency only if file was deleted

Pulled, thanks.

Paolo

>  virt/kvm/vfio.c | 98 +++++++++++++++++++++------------------------------=
------
>  1 file changed, 35 insertions(+), 63 deletions(-)
>


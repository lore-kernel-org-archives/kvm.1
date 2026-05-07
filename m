Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42544BCB2
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176198; cv=pass; b=b9/6HSysPfeARgPWLheUonAkN6J3LmunFEv+9fd/IG3LMzA4uxF6f5V+4tbUZW36L54qP2z3aNK9hpZt6y/ie1j+/f+/qhNSZG7drat9kuH8eyMJL4GGpWtDT2Mae4ZdSzKS6ggRLs8RmALoq6VqThqL23bBPXuPgsv8PiQIgQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176198; c=relaxed/simple;
	bh=37nmJyEj2HTA9kn0coiYZTEKnPykjYir3mw3FiKySrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jt3Z6hSvFjy/NuBnaaOgHiltEEowmtLglMfsCQeXM3mCqeliOXJNBqzDtJQNGbAnJvIQcACIv6aA55UEJUdvyAocv1UvwJry6DmvfrXcQCyYKfU1mF465ZgkUFoJyO/XVNDs9QcpH9chreb7Z6bsx64R1QN/LVUOfrXfUcuZD0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FypHfYWt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TT2T0Mgt; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FypHfYWt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT2T0Mgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778176196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2iYTcZJpRS6eG3O6e1GUtiLqW+EZCCuRxZGxNCwSTs=;
	b=FypHfYWtZ2HUc1lw6Mc38E86YGbAXB+FE6W4vR64/dfL8OqFx0i+MKz06g/cb9ICBgyMJd
	C4CUMuHLSL2hi+/roQTa6GfzF1EPGQBIqjk8rCxFm4euPOiD0oGx90NVFRSj5Ei/ep+ZMz
	h6Hfg0AUcqOeGDtfV6uElXKbX30v4Fo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-F1oP9onyMGaC9-a_5wiSkA-1; Thu, 07 May 2026 13:49:55 -0400
X-MC-Unique: F1oP9onyMGaC9-a_5wiSkA-1
X-Mimecast-MFC-AGG-ID: F1oP9onyMGaC9-a_5wiSkA_1778176194
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d127eb013so6862195e9.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 10:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778176193; cv=none;
        d=google.com; s=arc-20240605;
        b=N2OtJc9IcvZro3QsHPjzGYN6KgkdzSvhu8LmitPAGXwuojtkNuaVCu3jtRvChDZWed
         /6Z5T5lFm7WNPWnX8M86RQzzGf4ghHCPsa50WWFaw+alZ3y00f3FRglwI/aPylEN9dPv
         1LGu6kvMEYXKBH0EjPm0JpzO0DtlznAnBglGaDYUC1D6zEVgzbYFKakIz/7vt3NqOlOz
         sAmUKK14jp/lrFz0BOgo/FD4dCO6kmyJ/1Mj7lIkmVAWq/WohMNSCWU2B8WEuDpu3vN0
         hI72H0EHzbe8FGs0DnBhA71KWr7xDmWerBGpWa31/tRM/oD0kRoMQSWGP2m4KLI5MGV1
         q65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2iYTcZJpRS6eG3O6e1GUtiLqW+EZCCuRxZGxNCwSTs=;
        fh=X+mjhu5IXraqaMxIwcou5FY6/5MPrW/IWmGqmMiTzNM=;
        b=YGJDPQdX760fIK8Yk3CVQy8f2AIVaAefbKnzM+cOh0Q+IuraMF0K8XcLagzGp5erVB
         mWHcIt0KkH5kI0j0tNKL0hYtMdUCCzce9DdJ/6+WLzgpbkYCgCGym7dLbrMgNv54MB4e
         yOU9/rmqTVnVPiq4n6x2q1a4N75P8ls8xkQatB64bsGjyOjpUNt9AhqjrJzxtU39FDtp
         zVJcBkQRXvWTuMGODFCex66ncY75QaYzFP+t7wpxPhNR3zkMptbEJdehCZRPdTCSn9tV
         Xe3AqxZwT+iQJ5HpAK3lq84QmggAUgMpjy/O3kwmOKOxSFu5GFfiQl/jsLG7IjJ5d9PM
         c9Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778176193; x=1778780993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2iYTcZJpRS6eG3O6e1GUtiLqW+EZCCuRxZGxNCwSTs=;
        b=TT2T0MgtP+MpoVdmRCBmobYfVdLpuq4OXSz6B3j2Dv+Fct9/YjxdPGgEpg5c7GgUjz
         t4GGvcUmM2b8rkBVPkUmnARVHhramkEZ/5wRcGRx56W7TF0Eo98ZPhuTXY3k/0x7X11x
         u/gKr6Un06J6WEIJpTLBv58K5fbeUy1ceSLmuLxnzO/w6TtUeBrZREcvF9HjuEuDxMv4
         3jrFE/OF1qudPqqPQifDnUA/gNW0OrwTV898oJftryGWWXypad1RiHha00Fv2QZBruBs
         BeXxdrQ6Hh5NiCfoZXPXboNO8W7q4fRaXXRBNMJkkLYC5FVpxoacz2CgooUM8NVzWpPQ
         Da7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176193; x=1778780993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2iYTcZJpRS6eG3O6e1GUtiLqW+EZCCuRxZGxNCwSTs=;
        b=Qq4MrQyx/Op5XWfBgf5VRrEsH0bfhE7bJXrRk6MvYCa10zhM2A1HMojMcY8AJkhyLk
         tSC8I7RefmGt1Me+4h17Br+0TrPiTGgvxbZxocvXokeMtYZiyOTkINETu3zx3fpj7/QZ
         VQUAQ4/MsE5vP/cr2q1Q/rxpFvSkbjm04Ksfbq7hQ4/Xh2aw5JoajBhEy3182aEDt13O
         rio8HKjrlPN4CgXYhU+QQapBNkDrXRKHj7gCtmynmPA/SgoIAhuRKNTLb5uzqREgkOHC
         YOCiBYrxB20icZ3uPpzCXKS4fTxvAcs9tREtsMZtW9Uifg1jmXSwxjQeG0wvyZgZhH1X
         5oKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pcjFcVSnQxBwAPOIBucjA+boUCndYRU2uToeQ5RItUWy2glXOkbG/QOekTnsGQXoATFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJF1xxrEY/m6bHZTCDRV3AA7UxHdW4LrTNI7yzJKxWH2MZLNKR
	ZxNG7UfuECyhJuypbxppoyLWKWbxdesJcnu4eF+VbP1m/5zJUI86Cu4uokviOv6EYYgajXnp9/C
	9EBc+btK7S9BxkfWOKpG2zqir6fYKkIjWJx8qodI4w+YYHYkpKJ9sfXcmcV5sWw7a0m7dR5i750
	lTXrUYjoqmoBzIcxZfzRshApc9Gmx+oKgbSbe3
X-Gm-Gg: AeBDievx2/VnAifN+FLj3D8oSRqEkABErvLrY2Xu/AMJOXbI41TlhfSlsvZMG77UEaK
	n9TLGSu2M6BbrqRrVv7tSG4elXwEMnSYuuIiaspvSBDQ9f96YSJYl5khycqMqnNOA6s9dBjhvLB
	MIroYFY3IKjo2W6IaP7UaTjy49zdArEC7NM/xI5rZxqL0kgwVxulho3IAKHKBXH0JdG2JNiLwN5
	la6w6nIxRKAhB63w/eY+lYkqb87V3eHR8n6Ws0Jm6SxZXJrGsaVMD15xtSkXgwgvT5AEueg1/wZ
	XJM0vravMyK9xyaDnNs=
X-Received: by 2002:a05:600c:a10d:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48e51f483cdmr110164725e9.26.1778176192885;
        Thu, 07 May 2026 10:49:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a10d:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-48e51f483cdmr110164305e9.26.1778176192391; Thu, 07 May 2026
 10:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com> <afyla1t8eYsWw2Zc@google.com>
In-Reply-To: <afyla1t8eYsWw2Zc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 May 2026 19:49:40 +0200
X-Gm-Features: AVHnY4Kci6KRrvl3DblTgoKTBIS2B1VLWSrI-Pqn_9nuaX6j--osCwJa5vuPWrA
Message-ID: <CABgObfaY_9b4z2T9kt3=75C+0Yu5s6wLwh0wEEQxDzAG+dNR9g@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 4:45=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, May 05, 2026, Paolo Bonzini wrote:
> > This version can also be found in the "queue" branch of kvm.git.
> > Since it should be final I'm including again for reference the full
> > description.
>
> I still have two nits, but on my end the most important thing is to stabi=
lize the
> hashes sooner than later, so I can use the resulting merge into kvm/next =
as the
> basis for 7.2 topic branches.  I.e. feel free to ignore the nits for now =
if that
> makes life easier for you, I can always send patches to apply on top.

No no, it's fine. The ff one I just missed... the other I am not sure
if it gains much but I'm not going to argue either way.

I'll push with the stable hashes tomorrow.

Paolo


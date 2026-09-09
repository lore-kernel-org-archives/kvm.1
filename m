Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA34582E0
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940862; cv=pass; b=SitK/SioE/cJbMUlxhoppd0dXYifZ3eSdshMdfuD8ctZhfZAn1qK5pVpcKIzWIiqSFAfSqVksT2Y2ozLPIDypVfHVh7XPWa35zbLHlu64wridg1txvWGYka3HeM+PV1W+BQdY/v+08t2BWUJA2AguUM23KRigZUFURJNVUExwyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940862; c=relaxed/simple;
	bh=3ucIodV25H4f/E3Otu92DPDMc08uUsFK0OMoN1m35TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teCWXPUH99rFZ9Tph8MQhAoaOrOXKTgRxYhLHJnF30FENjV/opfmo7zio7Suu+kJpaqpxh6ku7+yFarFVYdNmqpBkycBcAe9xrQXN22hWT88HamcexbszDOVN86HrPpUiEkySyCqQAo1dWnkD576A8vLseqIkW55IWI3tuDdN8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAaBaJqV; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAaBaJqV"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6bd07679624so1291898eaf.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 01:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788940859; cv=none;
        d=google.com; s=arc-20260327;
        b=UsXW3RGtxrsZIecw+kSIw/y4HWonWwcBYbt+V95R9nWTWVNrc6heH+jXSeZ/wyPHH8
         nRloQoFsrhHeDFkiBR6yPcctubPCqtU/g31r0U9P5A8PZuDnvONyCEprtHVu6lnjwmH+
         4FnLu5Hhdu4wOZARrKZpC40am0Ghf6cP2yhzA0jylIr6vmHdxJ5Jnggb8cb80/cqJKb6
         dlhN4DpgYhTAv3hPZgNkeD7LGb3FBlHxaQM8bqFEKjER4YS5h2S4Zn5A+NhVRgJlayQ4
         XBQURSnmkMFqjwwImUTdf533lOUfjKfxpXn91JrQmpTHJX+oahxu66rAf5lvusS//OjE
         kvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r6ojG7KkisYtK+a5wUQDcdWxUyw918+UeZlJ6dvtgzc=;
        fh=YxhMtLxZImQ2QjNCEQ2VFD13ANjB0Pscii8inNUMus4=;
        b=fh+ZSv3fZ7Xc66DzJGpdoVtNAbx6sYx0VHym1hmVkaJuhKGS2Yq6cK6mjPoStsycL7
         60oP24lNayLQmtY7wJtEPlFfvl+pJ94h/WO5MTScbtEYLAYxQlhyk89Lytktk+NqUw/D
         qIlYvEQCWhXXuB+tziSN+9hWLOly/ifCpPXIkPNM0fjcgNitzEPLjGCZJfPvdpJvcScZ
         gNBSkI7c1oulOadKrpVzL+Uq4bZb7MMoumqJhsEaESvtT9nEYa9qScbVOcpdWngw/B8c
         yOPAFRz6w3M6iguCCfIM7Rv56eOZECScBC/2lf3I/gy9Ffg0y1rWzI+mY0uVALfwbpUV
         76Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940859; x=1789545659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r6ojG7KkisYtK+a5wUQDcdWxUyw918+UeZlJ6dvtgzc=;
        b=lAaBaJqVFwbtvNU1Rpl1bxMI2XLo0Vl5xuppeTvGKoDuJ5gg4ffjEYkdMmv3db4bLf
         Fis2oWvBJddUyzFSamIMiTkFA9CWuoVECRCQ7uCqMVtyzUyYsuGm5SPp5eoXorenNYzO
         FFGrkL2lrcLhrafn1d5oxJjA5obKhqF1ouCj35qxH5nE9hpqkFzTiIVIyh+kDePGTSes
         wgcg3SFKpmrEUkaaqNr5rfzdKT5XktHi6MjoWBq2nz40bVXFYPeNwUYKKoDIVwLRYHbt
         uHlLfVmKQ9Yoth6pZL/RoOiV62PchVianvM3gK//4xohZLHQSY40rv23dW6ltPKH2Y9m
         xMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940859; x=1789545659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6ojG7KkisYtK+a5wUQDcdWxUyw918+UeZlJ6dvtgzc=;
        b=RM34CpXUJdtUznhuuRnYkk2s53AhxyVA3FaVbeP/aeUZ2uha3yrC2PLvRoJ6daVyEk
         lppi3ITE/9S3xjAEAOrlgsIO2aoVSvuiiFTew5d7RKYFej5hLh8kbyRgLdY5R3WJ4nSf
         /CqPW/t168zcvpCw73JjVa2cGS/yK+8Yy+rUcGb+5cL7kE+MoLwBbFREbLgPrwOiMlqI
         08aIqrA7B+18fwbUKVaWfqElr0Lah5dCmVkjHaxwj4DdtQG9pwber7Lw/iMYXheSSK37
         GibZaC584C3wZFRKJnru9lvRaD7Ok0NpO8xvdBLxio/GsvDIxLtNtFAxyCFqZSHrCCAN
         aueA==
X-Forwarded-Encrypted: i=1; AKwUvBzDbj6oPfPQ4TlhqSf+avoA4k0SI6/tD3PscYrfiBI5jA2y2IkBRucsq5/Ckr+NrRce/Xo=@vger.kernel.org
X-Gm-Message-State: AFuF++lj4uRw8CvtTrh9p92HA1lenJxBipgtfIT5XSDfJ/EP5SJoNC7e
	GhoW4o5qBHPsQw028hWfc3o2Nk+zXIuq/WBCnxS0yc4X0Cy+xJxu+iyx/SWLo0PBR/HMPRHuA1v
	uODRrPB5cTiiZQGgzIr77XudVLHMUMxU=
X-Gm-Gg: AYBFou0gqzOH0bVjnLn1Fj7/KAOlBxRS68fPXDyXQZc4LSebvXCzaVu7KtW4mlIOg0P
	Af89aSVw5n+H85OJEn/O7xOise7/sZ1zkjWkKwLJ7ehrfYk2HW9bof4MlYrk9uvgjV/rKwgzh3K
	3AiuaAoq7PJCmtjgX8xWu1md87AoGnLkhcb7RlkZ020RaUHq1ip8YZmKm4X9/l99fxaTyImry3I
	fpyBFfbnFW0fh5GNRyVrz2OqbkMpTfHhoXHZeXCj52Z2iRKVi9BiAWRFmijfKJFWFZI4HXx2OJY
	wrbL6Ur/DDcxmUptIMdhHZvyq/J3R7KQx+9iERHjepl/KguPrKyQdzw=
X-Received: by 2002:a05:6820:2004:b0:6b9:2d62:960c with SMTP id
 006d021491bc7-6b92d629902mr12360812eaf.68.1788940859557; Wed, 09 Sep 2026
 01:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com> <CAMd06XfsK+X1xVX7=nW+U572OxnZp1vFyYjBNdr2AMtb2zgYXg@mail.gmail.com>
In-Reply-To: <CAMd06XfsK+X1xVX7=nW+U572OxnZp1vFyYjBNdr2AMtb2zgYXg@mail.gmail.com>
From: keqiang duan <duankeqiangcym@gmail.com>
Date: Wed, 9 Sep 2026 16:00:47 +0800
X-Gm-Features: AcwNN1UAqaMukPjOzxIcxUWiOmebC4V-Yq3pNFBbnlgQ8z-xNu3lccJjr6eb_88
Message-ID: <CAMd06XcQEv2ezDzRWcgccw53eXVcMPBqjGh--qZ5xFo0FA_pJQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
To: seanjc@google.com
Cc: pbonzini@redhat.com, Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Qinguang Chen <chenqinguang@kuaishou.com>, Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

The patch still applies cleanly to the latest kvm-x86/next and builds
with KVM_INTEL=3Dm KVM_AMD=3Dm KVM_WERROR=3Dy.

No rush given where we are in the cycle -- I just want to make sure
this hasn't fallen through the cracks.  Please let me know if you'd
like any changes, or if I should respin on top of the latest tree.

Thanks!

keqiang duan <duankeqiangcym@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 20:44=E5=86=99=E9=81=93=EF=BC=9A
>
> +Cc Chao Gao
>
> Sorry for the missed Cc.  The patch is at
>
> https://lore.kernel.org/kvm/20260820123512.87236-1-duankeqiangcym@gmail.c=
om/

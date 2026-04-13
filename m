Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C43624C3
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078246; cv=pass; b=RY7S/ETrXByfcrtjNE2vZsGelW3jHd2KeHv/UBIuSWE7cyMcMkCnCEXSv6EQzD9CvvY6KDEPX9TVZXhZU5NAs0qYfYjQjoXapTD9lZOzyS4jjkvZE3dRaGw0of9C1e5ebaDpEmqd//+R4piFTxV5SlxoHtopwYsIMhD3yU7FKyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078246; c=relaxed/simple;
	bh=qdFQDiyk50wdSUd9NCQoZ5HNxul1QGCvGFwaaA6Awkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxyAzXaagu8TurGyYHIv2lU/1vmGfve8AUM+p8V9EYSydZbWis+jOqptcMm6B02TpGMgle1PHMt1YpICiaUZXwi8rqnysgVQYT41GBbSoDdJ1PKaYxo7A6gKcxYEeI2en81P84KVYBQzHjylTCpNXGFQbYgi6HvIB5Jl4xmdRJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQ2ZSK7Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAUG4kpU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQ2ZSK7Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAUG4kpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776078243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw04ogwEEXV2qrP7fVQ0wicJZP9ZyzOSMPA3iwTqygA=;
	b=VQ2ZSK7YUpkumqAr3crSVFg1MCdLX5yD7fRzc+5EJ9MBxvAAWrJHuORrPH/x3NQvu+K1wF
	WyoWlcI7wpYPaFmvnl9nBNfoZW/Duv3npX2Bb3GDi45IuRO+rVxJAav/BtVMHOm/WpeczN
	J5YTkwK8me0JL2DhUgWTbo5JUWXPxjI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-xDrrLzaUM3yLy0wd8285jA-1; Mon, 13 Apr 2026 07:04:02 -0400
X-MC-Unique: xDrrLzaUM3yLy0wd8285jA-1
X-Mimecast-MFC-AGG-ID: xDrrLzaUM3yLy0wd8285jA_1776078241
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d77286244so641800f8f.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776078241; cv=none;
        d=google.com; s=arc-20240605;
        b=IoZv+kBJl/uO1Aigt9fhLgjrI0PoqNKgu4ISDYak4ch7BpqhB37+ybrPIcfHW764mg
         3zb01VE3D46of9yzwwFikWJuNvBJRbzK5i5gZVc41dRBL/OBOWftFWxp36Y90+Sy8U9f
         YneO7YOwPtaqklQ9F4AURK+Do9Fs4Rh2L6+7K2q8jPGj0Rx9d3uzKfA6rvQ6iVlUfjdB
         DNXvbXBK9Nent4qvfP7wAcY6oC0Xit9Ws90jdJ8ctFzU7Jh3S/r0UoDBH7+O5eT8/L80
         bNOZySjyzb+3e3OWGlCv2pu/AUJMplmcnN6iVmvi9a7F2fgQhZk/lx+n89p/KeDcP1Zl
         hswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iw04ogwEEXV2qrP7fVQ0wicJZP9ZyzOSMPA3iwTqygA=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=EijR+o6pIuhC9AmeE0/M1MGqg9xV7p+nLg/pf7EGynbXX6WqM94M9iMh3b9jTNR18c
         RUEIPkWeQFSgG4aAdoIZkkR3g0HyGyYqLHLqi9WVV5gv2520LVsI9v4IPQkYHIth94iP
         9qEALE8ZP6PYN8y62QA5ofl8wcgneYihbbM5puqnC01K3IkuL1n/jjP++Hmpq0DhDLP5
         naM+i6tfdPPbmoSTav36q9KdwdLcbXge+wuOJksEMaaG0K4Lhid34HKKvPZ38svxn5jf
         zw9ludYplVRffEvupo+ZcRO71FKpfQ2R3CVFw2XODlevt9PU9pdWX2V8hGpS8jKmYPAu
         v/8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776078241; x=1776683041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw04ogwEEXV2qrP7fVQ0wicJZP9ZyzOSMPA3iwTqygA=;
        b=RAUG4kpUwL92lcQWUUK56TdjBAB4+txMjrR8p4AKxuzKo8G8T+5O6mRBhxXHo4VKvw
         0+isBKoQaCrjOvvE3CwO15OocDgv9M9xWOPbSV52fXKnLvUhekt9LFtpsPK3zxKl6sc6
         EmlBwF5OWbAcooKOt6hu+3YMAsZOB40Uy10EMZBObE2OMae6qDYsEfwKOLAGrtMPoMcv
         +Xt61yViqgYaXucogPB7czxAf9a1pYhhM2+c5om6Xp6u4Xy7DthAaOa37nVOEtviKnrx
         yGTwji/KGHdMZ3klfyR1WsLWHLcBA/AYAGm1HiCwm8Pjm8VBwv7w767Z221DZwBxM/jm
         UMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078241; x=1776683041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iw04ogwEEXV2qrP7fVQ0wicJZP9ZyzOSMPA3iwTqygA=;
        b=Ujuda9Zjg8GH16A3iYRmJ4jTyqUbUKS4L7MP4EaZPrMRi9NJuGXd7OhlW18rt66SQt
         N8ekSQ3BzLJPFR0wonwCn2RIvT+lhv1b/zWZt0iA72la9bU4hOXpHEiktFsArYglwgoW
         TTAvf6CUCRHxocANHT3rsb16uk3EEU0a9VNwnSJJK4IPxsBdj6swzC/Z9zc/qcSCI7Lm
         p2o9GLN7KVH4f3MUIp1c+6br2xnOIQwUOTwTdm6VVgj6d8l6dZ0ST7sXqSVWpZLDi3Mq
         qqOiTBcjfy6QZ5LChI2HgcHjJOakX05lZCtr8FRRoXxl4hlLIB31QJcL2LP41uJ4+m7J
         M3OQ==
X-Gm-Message-State: AOJu0YyWTEzUmSv1ZTA4IHQGr44As1Ncaf7gVFJC1xTphuVb1wTUzs+c
	aD3JaAGpSxoJdcNBqMC4YOLN+3eMur3a106DS7Ha4VZAZZnaKW1BW+5vucuh6msRq0iMWeAALa4
	Clmo2WSU8yWPPYka7BBVCXh5aj5jdwUvewACv9HrMk+V22JAaKP3meXx38O0Nj2e7tb/iqiET/C
	OmTNPzCMWougmVabwv2A4Z5Yk5lhzi
X-Gm-Gg: AeBDieuCwOaJq4MvTtLcjA/SLrOt0+sJPW6TB6k9IbQeOIdo1dFJR54e2GT1ZnR0bPY
	JiKy3nCKqBlXQ3VVMrlHG7U5bvf1NVs7K4qfECWnllsg3DY5844Tl8iAjub/a4QpCGTQ0vsUHbV
	Np0yuhDPOljvwnsBJjQ2sTDVZHbF4o4mzB0S7Vjk8eg8GuFYarMRsu+T8fwe3npgF+dBd5aZ0wV
	GzEAaYIvLT0AVQ2B6LxzdotzTyarflf/df3WvJQhmfsPQjXDoc2QbtZdYe2GzV16HUkDYhknadj
	CPvf
X-Received: by 2002:a05:6000:220b:b0:43b:80a0:d92 with SMTP id ffacd0b85a97d-43d642bd578mr17004639f8f.45.1776078241279;
        Mon, 13 Apr 2026 04:04:01 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:43b:80a0:d92 with SMTP id
 ffacd0b85a97d-43d642bd578mr17004588f8f.45.1776078240786; Mon, 13 Apr 2026
 04:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-7-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 13:03:48 +0200
X-Gm-Features: AQROBzA-emtV19oWuXmmPEBl0WZSwPw_4_5bHv5D07xCt4HP4JYk2Uj1-RkKKLk
Message-ID: <CABgObfYK=kS2J+uev3m8k9hdba5wvVsFO7KbQk3-bZb7DGaf4g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Nested SVM changes for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> A massive pile of nSVM changes, the majority of which are fixes of varyin=
g
> urgency (though nothing so urgent as to warrant a mid-cycle pull request)=
.
>
> FWIW, there are a few more nSVM series lined up for 7.2 (gPAT, PMU host/g=
uest
> bits, and #NPF error code fixes), and I'm also hoping to see a series to
> optimize TLB flushing sooner than later (but certainly not for 7.2).
>
> As noted in the "svm" PULL request, the virt_ext =3D> misc_ctl2 rename ha=
s a
> minor conflict with the sev_es_guest() =3D> is_sev_es_guest() overhaul.
>
> There are several much-less-fun conflicts with kvm/master due to the RSM
> fixes.  Here's what git shows for my merge commit (or just make it look l=
ike
> kvm-x86/next and hope I didn't screw up? :-D).

It's not too bad to resolve based on the changes to the prototypes
(arguments added to nested_vmcb_check_* and removed from
enter_svm_guest_mode).  What I did looks the same as what you had
below.

Pulled, thanks.

Paolo


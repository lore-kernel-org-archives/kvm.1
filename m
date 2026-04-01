Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312C42048
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087384; cv=pass; b=J4YfNnkh+ljXS/EsqsppPhYn24PsE3auewH7Tet1IzoNOdjWBC3N0AwLew5rV6hLSvJMdPVwgU6DGW3nSs/MPPlVFzpWaE7Szr9QbC7/SFW/OlHylRngRnD5Gg7vjf3mO676q61IiZNZhm3Dw77w49sMBi8kJWIklK0JwunCoT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087384; c=relaxed/simple;
	bh=iG/nvbn3Pb7aYhfA0ETCNPN5CmuEko6aAtCikb10pKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzeciHeIhU2M2zPIeatiqBQWijLuGOz8lWgtM+ZuunwrQl7ziDFtq0X0W3Ono5EnJ2IYZFqwOWVvxdM8uX6GU/DDArtv1CETmZuDqFnnPbv2B4xTJNh7Fx2KF1TCLcLKxGxCpipRjdZmti1PYkSWTL8ytxoUMCN+gI68xSJjQDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q15E9qiX; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q15E9qiX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509062d829dso137771cf.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 16:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087382; cv=none;
        d=google.com; s=arc-20240605;
        b=JVBXdQEcbOR9OBjQv6rhP3cRIBITArGG7u/DMBP0Nsp/lqEZL6qteHlaFj6YwosyGx
         4o+vHK+6R7MEYg3uCmBDpL9cv7fyr6eOijXQw+0ZPeT/vz9R21HRm1OfYbBW8BgQB6uT
         HekMmKgbEooqTJLnas3+wwVDA0UKW9Ojk2YPq3RponE8XYzz2HsOuCRPy/TI7Niv587f
         Lf+8PZubwRAAxpuYDk0UWSk4GKMIssZGELxrsLEVaEmZnS87KvMTUJuCBpSneTSSfkSP
         1fH+43d+S+NFnFEwtS2zb1a+7aXihVNGMm1N1oGclzjAvTMRPUyq5PhbmJi70IGf7/G/
         UatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iG/nvbn3Pb7aYhfA0ETCNPN5CmuEko6aAtCikb10pKI=;
        fh=mocTuIGOCx5uTTZsWedeeWKiCMGCgtomF7tEK/xiGDs=;
        b=R2Y4IWO7eAeH3lnQ1blXkqQFquxTaFqUmoGzVZtw3mwri8W0+UdA5AN0vr3dyFTidI
         3BMdn1i4PZfRN8x+SuJY8Wnm2ZXGpLaiizyph1B1chfGZpX/oui+mI46zSKPWugz1I8v
         m1lH0S9uP1Xua5Nx5lqGoeym3dQGBfPakF8TsqjRVneiEVOW/gioy9YjwOhsc3fQ8naT
         LyjKJrH+Bpw8LtNCUr1ZMrq2Z8igYOY9FjnuiRNofZExSxSOSTAGFHhyTST3l5MQOfyf
         tvp6qXvdp2MH6J5hIIjkix6kVgS8lRxHDEROiYEJAZxstIQB5DbMDxCaQ6vYXSD45FxA
         HNkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087382; x=1775692182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG/nvbn3Pb7aYhfA0ETCNPN5CmuEko6aAtCikb10pKI=;
        b=Q15E9qiXFn/WSZNXYz3vLsOhc5U9YfKTatm2xeiM5xeTv4HJ86zHcF8nBfr41x69zh
         7uwRmGhk3NE0bpaF2SJxTq65n38bcUIIsQg2xVZ+JfKKRpNNPwNTnQQVyDaygI+BAWjx
         GJRoq9OSzIngedDYIpP5MgTyIpxcwH2blZ1UcbfaIz1yxjXh993LkBPyUqTaMN8VH2oR
         zzvsvdJjkZ091Q2dD4NmKJmQXsH+xNw/zx4xwhl/QFXkV7nsX1c2+JgJ9mdKVhL/irb/
         rVNEQdoH9VjM/0L+6S3V78iClDgWTcXD4MkPiD4uJvsbTcFrCUrY2Bzlpw+Vz3I6V98x
         tOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087382; x=1775692182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iG/nvbn3Pb7aYhfA0ETCNPN5CmuEko6aAtCikb10pKI=;
        b=CEwf2yHZsP/7BPoz88NeTRpi21dQ08RZVaiqMR9CDZ6LozzgV4DM5b/5je3bTAZERk
         yfZcewcQc3Tw1EptQk5MsP3wHy1aLPxQmgEdKibCZsUDC03LXyqxmX8OPfqmePYur/Rr
         68NIueMH0t5RuOeVtN2KgOJPElAkHKEPh/HltrBLARkXrzUdrLh3VPVrvvYrL2JXKWzc
         PhP8wmcwDGQBuuG5L8k26H0dYVwOLc3pqG4J1KmXurIsFWuFVVFO8EjDDOfh9CiPy99E
         ruKTYntIfbiW5rYjn4KtlfEMC0QDNCLvXjGJEw0kgW1Fk3hGv/zltT6uT3LOnkBIVjG6
         ZNMg==
X-Forwarded-Encrypted: i=1; AJvYcCUW3Tj8cyWUhV9roJT+FsdLxl2yQXdYMxnuAk9hNBqXkcwkEh5GV+VuoBqt8xjXp3nUH48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBG1AZ3kYMrhMd+qDLQEBCEYQVYqdacLcGewqj4k55JqjtryL
	9cYPkcnU4KRM+pt8/+I0lScw6dAD3xNjxxQz8WRMvpsSp5gnLC7HBrES74MsGUeqcCxpltU5Ef1
	6fK1avMchtYfF7l2qDnAkakEC5wW8XNaVXl58Ry8=
X-Gm-Gg: ATEYQzxittbBJHxH62r9XMdOB9O7dw/+39H1E0NTBhCz9VC8n9BEK2sWipYlG/OFq7b
	pgrG01KrCkzegiOQq5X/4JUP4REjZulrCKC5Q/aPDGXcDMjeNPBayflZ9MNozlqfbj/IvU9uV63
	se9oqKKlqCRuKPwbBDspFZgCdJEkLxRP5cicIVEtWn8qh5ZlBapvV6Ib85jUY940rAHlFtwnInH
	JOCq4y51ourbmXmwWHymfB/54XLYFoxGhy687yrqrzTVgbBjUtKp8u9teoUMnpuDvwe15oAlri7
	Gijt2G4ODQlp/R5QxSPDKI3p21m//q7bwH3X
X-Received: by 2002:a05:622a:1f8c:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50d5062a2c4mr933551cf.10.1775087382102; Wed, 01 Apr 2026
 16:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-2-jrhilke@google.com>
 <ac1hVBR9qxp6whvJ@google.com>
In-Reply-To: <ac1hVBR9qxp6whvJ@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Wed, 1 Apr 2026 16:49:31 -0700
X-Gm-Features: AQROBzDwYY9vVVPNhQ68BJ6YBElyBmavaz4nlTRwfhCOX00wT-JnY_YjfLWiLmc
Message-ID: <CAAdrzjvr7Pwt6q=Vf-zc=OtXj_x3ymnavctC7=CJdbrncvTXhw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] KVM: selftests: Build and link
 sefltests/vfio/lib into KVM selftests
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:18=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Mar 31, 2026, Josh Hilke wrote:
> > From: David Matlack <dmatlack@google.com>
> >
> > Include libvfio.mk into the KVM selftests Makefile and link it into all
> > KVM selftests by adding it to LIBKVM_OBJS.
> >
> > Note that KVM selftests build their own copy of sefltests/vfio/lib and
> > the resulting object files are placed in $(OUTPUT)/lib. This allows the
> > KVM and VFIO selftests to apply different CFLAGS when building without
> > conflicting with each other.
> >
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > Change-Id: Ib76374497945025fff60f77e6c72308e900b33f0
>
> Please drop gerrit's garbage before posting.

Ugh sorry, *face palm*.

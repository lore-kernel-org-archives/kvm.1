Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BD0386C36
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279761; cv=pass; b=c/6X1FXtgsQV6Gep0X4NXw3KKq9awkwTi79hwtOEF4qB1TOtLJ+fLTjo1HmssxhWf8j+JDVvx12qXLmsEsJEEUlxbwWy6zCNoPxHTzar50YUHmxN8KnDaS9uSpvzEfcIRClumEn04W0yBk4d5kNyhN+iwKlK6iHw6pued8Lqf7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279761; c=relaxed/simple;
	bh=H6Am3uVt3DNgjA2oGEJ3FedMywpLpFTMNRXP9GXlqYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm8rg/uK6AZ3XjPFPsOXzp36LiippqSUQYB3JKhonU1NGdgNJcQ9DNi5zfT2XW679R1Fd4uXVrzXWi40LE2FpoPsbYd97qdSwFjGWxm9RuxcGmQ2kaGvYM2DBM2kq+/dOcDV8E4jqtgO/HfTBPwo/TMFmeb2lcUhmodf1fslovM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAiEuWCM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWU+fLDj; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAiEuWCM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWU+fLDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777279759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1v3quVUYGUtXVenLkGC0x/9Av7Dhy2+itJqpwQl5jXU=;
	b=CAiEuWCMlIbPzVIeaKr6Ic/vlyYO3mkTpvKNi7Sn0UKJn+BanrFKBwPDCZtS+CvScl39Dx
	3Se+K6/KPCjsrQAgoBvb6fp89AeE/O/WQfQaC2w48Br0nQSbkRPegfSpljGRV/a+rUgOEe
	OXEsgbBnruLu/JCDBtlqFHK1X2PKc7I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-Ab8H0uK0Mlm40aI_Z2kPIA-1; Mon, 27 Apr 2026 04:49:17 -0400
X-MC-Unique: Ab8H0uK0Mlm40aI_Z2kPIA-1
X-Mimecast-MFC-AGG-ID: Ab8H0uK0Mlm40aI_Z2kPIA_1777279756
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a55ecc249so47736005e9.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 01:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777279756; cv=none;
        d=google.com; s=arc-20240605;
        b=DoxV1IvuZfEwzn+OiYVZUV9dRWCfT8CP/VkB54Gtj7VmCIUkstgNEwn5s2FpFHGd43
         i9dYZzy/T9Ts4D0sXh3+Oym6FmooF4HyL5UGwum6TOP76JRB8q0hg6MrU5dJaC5Xs5Zo
         Rb3gp1AwHFLpiQ8D8rmmbTIfEeYJO5wICoIBkXm3EMIPSoIUQsJROIelrQ+kEyb8VWlO
         zh8QEFGUGeud6wn5D9LGyb0zRJ2MvbFJ/rdMVq05Sk9eGcHaOWJ6rB65GWqAxeMzq1/T
         /7fX2+DUsXuFtd0LGm8O+3lC6orNGE9EM8Ys27A9/CG7+tsB1f1NF+/Q7xuUHajizNYp
         K7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1v3quVUYGUtXVenLkGC0x/9Av7Dhy2+itJqpwQl5jXU=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=f6Jq1SQrQXEz4fDonRXdM7qaJtaqQfdE/1+ElTuy4HcKfi/Wr34Fk+rpZbdDf4R9Ol
         o3n+CH3mKzaTUKmgbDcg/ZMO5H1KZSSb+ADGYTVW5iFrNfbJVxm2+aAtXAFU/d8e1C1/
         650MoJc2Jm0AHTwTrrNDpoEVYLgBM5BXA3Sr0qTN1o+JUkICiKoLkA6yr4oOr/WD5jbb
         6RrA0MMRvqrpPDmD2+x+DMzwmWsQehQ+eHS9/icfMoh+DVRwtATBGXNppp0fFmhBY092
         SsbJ/22PAJ4QR2xDvO/ApjX4jih4Kw+CzkuUsTTu/en1mKJywNdD8YRWOOX8oaXeqPy6
         UFfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777279756; x=1777884556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v3quVUYGUtXVenLkGC0x/9Av7Dhy2+itJqpwQl5jXU=;
        b=PWU+fLDj0hERyHUDjTsLpFv7B5/o7iZPWvbB33T3EcbveKuCwU+xXM5rUyu9+UFYPB
         WABzThRLtjY0gi4vX7DqG9oy11JljUiXwF6VOlBAbErUkBMfVtXPc4hV886JSv+aYlfH
         /5vs69Miwi1wPNGAvh6oESLXzkZDw1mnWSrbcNvAoHQzoGPDOu7nM/Ou5QUwAxf2PTeF
         3C9MqW3e1WGUPocvhGAaChnBAc67B9SLIbTub2fNj+SBSDKsYtVy+0wM0Jeh5XoDiK29
         ylrzUjUwGgs38vZGr1Hjd9vQjYWApqco/YK97klM8lk8VmQMhleSstqxs5bXWefhRdeU
         GChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777279756; x=1777884556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v3quVUYGUtXVenLkGC0x/9Av7Dhy2+itJqpwQl5jXU=;
        b=Q9Qf6nPNgyT6s1RvEmRmQbcMkJzOIoZudxauPJR47CPm0kFA9NIhRT60+GcPpMgi9B
         W8TIqz0A1ePds6FGXt3/fGmxJ9iEHgNMrZsT7IVaH7Z334/aYeaiQoNE8LA0lv3zxuSx
         vPGeu4EVKEoqzj1f6RSRN0xguiYvF/sMIAo4lFbsK0D5WdVR/JEH9Pr5SQPOBZ+hmroP
         Ync7cih1JT2Hq4WS5RJFySw4wjzzCsFTR6FWAQAVD2f8RETnTOoAkPqCt/rMhkyW46PP
         QXHezCavz8CLlCxXxLcS6dcesKhyhtJzPElJ3Vsp+xiPJxCnYzdPuqu34mSR3ww6fJN0
         U+vw==
X-Gm-Message-State: AOJu0YyxWjlPkHArw49mAnAq9SXldc6C03v/7NZdKS8ei39oKyoRBuSi
	7HsIqIXHtogTH+LF3g1cEOAjjXg/9Y6X3QOhQPxaWTi2lENrZqO90Ux1L5JXypq9+JVgP/Yg++N
	bihp9K5iuAqDlQYpUdOLxooawWRJGjF7/m5wTkmxeas9kly71SvXclLNjGoVCExXhlN0BwQWS4E
	UZeEOZk/N4KMTzeUPIBil1AUON0yZ4
X-Gm-Gg: AeBDieszHbiw+OojtuhkIUNReg0J0lh+7eCkkWCL7L3Z9LaPaeDVUUDwS8sNP4rbuKi
	ZqIKkF/WfG+z5rp7gDJ2rQ/1+SuJVBVIsvEbiLsYwoFYpws8Bth5HZBD8eyWu/7zw9EZc7iD+5k
	qjMpFZAswFF4MUObbkfoGFfvLUavuQF+RWxSSVgfngLqLVkl/jdLPjH7whba0j9BBgVJFV7/C4o
	1tpVQIpZh9E2553yiJUE8sNveO6y145O7wi5uCtl50Ohdp94kvCJK5BINYvZn0uEJDLyXjHy164
	rOoWbYzRvLP5Avg=
X-Received: by 2002:a05:600c:64c8:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488fb7a0d24mr618668245e9.30.1777279756092;
        Mon, 27 Apr 2026 01:49:16 -0700 (PDT)
X-Received: by 2002:a05:600c:64c8:b0:485:2fe9:336f with SMTP id
 5b1f17b1804b1-488fb7a0d24mr618667805e9.30.1777279755504; Mon, 27 Apr 2026
 01:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423184932.547047-1-seanjc@google.com>
In-Reply-To: <20260423184932.547047-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Apr 2026 10:49:03 +0200
X-Gm-Features: AVHnY4JE9bgBczo1yMjB0lmfZVUwfBcg9WAvc9UtEwYu1TeWLIM_GktrL3Yq5Xg
Message-ID: <CABgObfZVwAs2jW_KY-bf6d=nUxufZcFHcmwT9R7reLxQygzsxQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Selftests type renames for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull an invasive set of "tree"-wide changes to switch selftests to=
 the
> kernel's preferred naming for common types and variables.  This has been =
in
> -next all week, and I verified a variety of selftests generate identical =
code
> before and after, so I'm reasonably confident I didn't break non-x86
> architectures.

Since I didn't make it in time for rc1, I have pulled this last in the
pull request. For now it is in kvm/next only, we'll see what Linus
says (95%+ he doesn't care, but just in case these are the last famous
words).

> Speaking of non-x86, please also apply a patch to fix LoongArch selftests=
:
>
>   https://lore.kernel.org/all/20260420192644.3892050-1-seanjc@google.com
>
> which got broken by the RISC-V changes this cycle.

Yep, done.

Paolo


Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1E218592
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097172; cv=pass; b=B8SwbMKAtGBV5ezQebiuVjVrKbUpE5KjYfgMlg9hPswhDLg7xvnKd8cQ6J9BxOPUA7DPC4oeuyo6TNDhFGGYdSJQKoDu1wIxdEE9oypqKwV2sVwvexp+xvvP0e/o66Cye3OOc1Tb+sySln1EbI/IiUI6CByTBJJ6Ddv0d2tY158=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097172; c=relaxed/simple;
	bh=EWhZVEWfE0YJWZ5dNklZIETiPemOV0lWEOiNJZNCwJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zjb+5uTo2pgAZm7l5mTyp7r70oijk6EaiUzwkmZOIISTU1ORrbg/0b+BQjrIUsXM37GgmXaIQYsLLZQPHf8oGFUi4dyGV5dbQl/shGOa8jxtqOvByIWPhvDIDqEdVjgj+rwpy7DFxm91EZAVF/WHYbDj3mQuSuN8l5Etn66sx0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7DmlQyE; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7DmlQyE"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so3568a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784097169; cv=none;
        d=google.com; s=arc-20260327;
        b=h+4bFZvv29/R0LPk1w+B02DKOhtZx6/xTTZHAuUNSUh9AN2mJzL0Ea68xmFMLPTd81
         17cKDoYT0DirbxZp/fVX1XkwrHhheeb4JD+b/kjf9fHGt5sKa2gyxuTWzzXPIGeT2rfR
         6eznZ+N5FFQFvYtjnd2sW11TJEOwpr0jj47qhmbWuy9LWlaa+m2m4RAIX5y9M5/rjp3t
         inbAwFnEZ0blLNi29WXZFB2meOWnSGg8E0JT2sUA+MFp7em3TpqQ7OFZErzKr8q+KMWi
         Ct4LIrCYqwv4H0NupkbQyLQp5/7N89fMSJre98B6YS2EwUxNykF7zPynurGLqVg9IZ4/
         FqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5cZJBpaaxc8KC2byZJ5AqPmmnmW+aFxX8qC8RfwjEng=;
        fh=cYFram7oYGZKlzWDozkM/c3w8XpwPBiYRDR6YJ4HarA=;
        b=mhxGx+6DBEHHv5uVBjM7MvnZHSu99Ju7lcGGvmvSwQxUXSs5bnPLqteUATu9g42ggL
         nR6U+kR7akF+gHDzMrMSk21v8lSNAU7reYfsGkfVRu8qa5KetyuKHh73WHa2UuqEe4vw
         9OCOs6P86p6KuG2bkagi6kTyh0n2ryUMrZa80QBn4RPN7yWgeApSs+SLqkHfefU93LqN
         AGSnWdsi4PSSmfIaRs559UxzHPGP0C1vhHR5XiafNoK4nNaxOWptD7c7NgMRTzCkCuCm
         v9p4uXnA8gjqtPIRw8SwAmA+RlMrO5/CmnJ+H85OUnH0M+yFsKGLjuM/1o0zQ6IgbhGF
         CJNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784097169; x=1784701969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5cZJBpaaxc8KC2byZJ5AqPmmnmW+aFxX8qC8RfwjEng=;
        b=u7DmlQyEWJN22TeGeIq3BF7k7N60pGABXIf5NOEbSy2kftq/jnvz1u/D/6RerQ7+Lv
         1mwBvlFHuy+a4deHCtwBIENaDIooxy/0ZTFy82rK7PSipoK9MDFmzuOT8T/XEWlbQMcq
         IQ3VjdDViYREUX0Y/KXbXakYC4I5jLf1JErEi3YKn7953j+ATp0OonOJtVm9DPHpsBNN
         7hyZMw9IYhywN4vv1SCaMDpEt6IOPOufxnHqpDZEfwhHe+M25hnaDR/wtkJU1oDQ2FHp
         l5t2va7AjN0K3w8JF6ohZMy0iwMPaHI1fQbrbzj2sc3xYRCX4gCdiW8QwP7DOctuGfWM
         XOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097169; x=1784701969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cZJBpaaxc8KC2byZJ5AqPmmnmW+aFxX8qC8RfwjEng=;
        b=AhScf/9pDs8oaGf9uyg5ND6w5cYorWuU17Y/LItcbGlmC7Rp+t+fehI4L+3l+BXKtb
         T22h/+CU8MglFCwRJwWQCeHLgk7L6sPKZry+2G1muaVDW79gav1kPO1Q1eg5B5EpNUll
         21C+XiAopkFBZUfC6YhWQ4/hh27C8OErSt9FnBPDqtUJosy2kLBgfk2oGaEsuM+3zD00
         YT4+NXtj+HkKA2YpCOufBSRuTB3sZf1m12AJaJX6UGExJX2izqP0rACSB4/wvFjJJWaX
         7ElZwZb+54Ju168XKJ38/T9cW96NbOcnskgi6sK0I3328zEyJIRX54JrM2nLI9pTvUou
         qAVQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKnfrpgWTVfD9TITl31cCKP29MYIw88WbAs9vzz6HAkfX78lDUu99OKjmXGwgP06byZ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUbB1OGlduKR8XcSffECfgXbzF9w+9LVSn4QwX+RKs4dsC/KM
	t5VsSXbztxDlC5JCNwFrKgWuqDoWLxg6Fx/LhKssbPAno434HhNF4F8ArA6moBdNIn/hwQ/UDmq
	aOoKbeydtVbxIPvgZ2PSYlB3JalzwUGvzl7/Vph3l
X-Gm-Gg: AfdE7ck14dVJU/Pj40OO2UZSMV3Sk/Xoy2z4YZtil2byyE6fAXgM3qR6Cw2rvngdpF1
	5Zeas/aO7etdoiZfEU7OeAGHLoLrNi9LZI58hBHtJBZcKGnXXKbX9n58cLP+mGC6ro3fb5NjY3S
	tIA0W9tlKUYhC0Emox81YNXewafaNQyhDLYZ0C9GVUg8NyMGM4VHk6H/q/JlNDiB4MULDJatDDR
	fyeY3JOyppaM6r35pprGlaeIVagIrUU5ar7cLcrPMPbakXAuUbNyWKoXizBMnsls2TxkrtG
X-Received: by 2002:aa7:d484:0:b0:69c:83f3:4831 with SMTP id
 4fb4d7f45d1cf-69ccf0dc33bmr155727a12.7.1784097168979; Tue, 14 Jul 2026
 23:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com> <albJNb-akQJ97Yor@google.com>
In-Reply-To: <albJNb-akQJ97Yor@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Jul 2026 23:32:36 -0700
X-Gm-Features: AUfX_my0WJrjpXW9-kGwEJQ19LeexB3ETxZwK7E1IQMxb69gZQPJDCkT1516GIE
Message-ID: <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:

> What complications?  Advertise the lowest common feature set for the pool=
, just
> like userspace has to do for literally every other feature.

The problem with passing through the number of host ASIDs to the guest
is what to do when the combined host plus guest usage exceeds the
number of available ASIDs, particularly when FlushByASID is not
available.

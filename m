Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C8443E58
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139654; cv=pass; b=s+o6lrZsyWSXqC/ruETCnHs1EtxCyQnNiFTZu0uC80ggyhhCM0eZx8Z6bgbid7gHHVQeqPSt8pkVbg323JhZD5MPnQ+IUTplFuvsaYlCqq+OpGjQZDa46cqLLPS1Vm7173UuD1vU8GXHJbaCL31cx6m8ZDoAdiQj4W9rMQwXo44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139654; c=relaxed/simple;
	bh=EBRs1jP8g0o8CVmqvy7HNzb/ah+z/4qEFrKmzANyGL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZDam/QeOEmbKTogVnTGzLn4Ct61HFV8whIXHcMemOnqpXGKITxTslgR6H4CwSRk1SjjYOPA2ivwflowYCRJcS1CvDjv1B8VCfz9c2j8Kq1wOV8hjb2SbtCpQeZ7jess926xtoBMgcMcM6hVTZd5YtMSdk+YcwkUyKrW5IHjfXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OC6AZR8k; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OC6AZR8k"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c10e86e52so30231cf.1
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 11:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784139644; cv=none;
        d=google.com; s=arc-20260327;
        b=i4+eWvRVojES7m5KfkfQEOS2AIX3gC39pXT0LodvBK/Gs2Znxm9Gn1biCcHwdTezdG
         AJvDR3RFJ2O5fzzWaMBgPWM1e6EYdiaSEgdNHQRctGJdt0qFZlKwbLTLewtAR2sPfQij
         MqtU3J4FUz/FRAyY9BaidLxJEST9O+U7MSNlWlnR85tZiooQf//y9ISbjmsV3ba8cx7E
         DFZqgEkJZag0sbRPkqFlMjS7jEpSSYF5zbkZQraI2K9yuFsJ/lRCb6+SCWgUhQ5m3sQr
         GE2ckSdaqIa3oxp5Qj7q1Rab/c92P9iK9VHzZYr9gmc3nOJDwi/rVwuT4Yu5mtsVlXmz
         0+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jqFQW3VI2xB9cJBYZXHxc4O7XLQzsGnZ6Ymjuvh9/hk=;
        fh=2w+HdvUhzHLR8bTEsS7OXU4YOAzm7YXfPt0BQTIdifA=;
        b=gKPVCREE1XmsR8YMolVbKFJGLi9l6fi0ffj2vPTnigk6nMvzW3PDh3gFGBLotQM1c+
         3Rb0kycsODBYC45zpkBUqZLQxggzKI4bwI2uYQycBvQ1rJgu8+yDP3bvrrE6/OfFq0ma
         sbrdoOIDUT7cEtYxajMd5qNdOH4mSuPhutZNyFjrTtA0sWwR2Lm15nPJV05YbQqkTzd2
         sR+aAjWzF/CvH3cvTn30wZsds1T9DCMIltdyONS6FHaL1ppMa0tC0novFjFMWRJHOB0b
         rSSY86o9lHocsbNorSd7S+BH1C+ZUzUsqbMyeM+Ku8jSnwULgEtwDy6M0FpY22QCcCDe
         ahZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784139644; x=1784744444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqFQW3VI2xB9cJBYZXHxc4O7XLQzsGnZ6Ymjuvh9/hk=;
        b=OC6AZR8khpR7h7MFMBceZ3aS9y3teCbgxQFZGCIVsUo0qwmrNrUdQ3W7bXBYvNwecF
         asTRMSpoHKa1FrPZBE1S702cNC2plhjaI4YPclgjHXNtLduuGQ9gonVy2DNsoYjooZlL
         QG/PKZAnoxYJeJ0FsKeLSc/0yLKUzfEMj6xMSs9SsU2BZE7T8LDZVnEo9vh2KFYJejWy
         xuVcfUXgtOdwKzWPs/2jq1cFqPvVvu244G7GhfnyQGm+CCpa3+jFIu42vMJT8FGzkJ3H
         K4c14tkYG1EqhmE1wZ6mwnu9DYm17oI3K2mcTCkM/kpB7+IuDD5ETnz6HkdcNRLlmVsQ
         Zlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139644; x=1784744444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqFQW3VI2xB9cJBYZXHxc4O7XLQzsGnZ6Ymjuvh9/hk=;
        b=RenK+SWtgj4JpNaESr86NKfMDi2Vw7ExsnWJMSZts0M5IL715093qf4c9nIq8Yawk9
         5jyMKhjb5CxMzVy7EEub7vUc8z/f6FqnNcBYxa1CTZ4mZUzpcF/tLhv1Mh5EkXNnR0Kt
         LJgQCTDCM79Hgl0Wk4S3oHpLorJ2TzoG+bQCzyRoJM5tvdvoCfgNWND6rktbBHS7xPX4
         btgVn5bAFVNvvH95e9FlAdzwSkc6ufjUPEUBnhtjRnLmNB8w3ddM89cRysiHRsKE5Xn5
         bo1OzTZ183Reah7fIxzYxtRJl+HP9gJgzbyfKs/k2PhtTK2ZMWsEZtKQ/yfj2QFtXH0c
         28MQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcIjfkQTOmE4M1LXhwurBHhUCklUWxwEjbV9H/ZmxJ+OxzzgYjUcsuEygvO7WPk9Zuf7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/RhCBpazD+jMrxWnADXjkbhVJT0214wbfU8wT8Tf5W0XQ4xm
	xuxqrvwOu+jp4XXR6zU651SU2eKksz1WphDGFpvIb1+uFbLVf1O2Vdy2s1+0a5V4pGNHiRwYBXe
	/I35z7etqNdja4GhGlKGvSsGps56M087HhMPUyWH9
X-Gm-Gg: AfdE7cn8fnu38VLF26GN0bxoBSST/g9TizW+NA3I+1GJN7vxpkdAv/YLa6zrSApC2Zj
	ZBCrgAE5W6Xf6RYvShQ3XGVjcOY3GJN73s7wma8oEwqlcsFqnqtktnwhoy+lvLaLFDgw/8zAyF3
	enPuFr3onCNZO+gDt5gjDJUsR5BeJTeEsG7XE0fFBiv921pLsxogsv4KQmbm3JBxAcY9JAstjpP
	4rKw3uHbJ261H5+yW2IeXzawSrnvr9eGIOT4CzdqKYi2dg6vLaF9gLviHDWKpylDqzGvP0A
X-Received: by 2002:a05:622a:588b:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-51f8045c1ecmr191801cf.1.1784139643139; Wed, 15 Jul 2026
 11:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <CAO9r8zMYDn_zY47p5Fe-tbHk2Cij1eZJ8u5w8taGoZEusm2Gjg@mail.gmail.com>
In-Reply-To: <CAO9r8zMYDn_zY47p5Fe-tbHk2Cij1eZJ8u5w8taGoZEusm2Gjg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 15 Jul 2026 11:20:26 -0700
X-Gm-Features: AUfX_myGBVCr0st8b0vLnDEvllxFAaY1qez-10tNqVwpVlwPj8PY5nNbsWntFtE
Message-ID: <CALMp9eQVeEdaaZGEeXJ3S7Ycmc+s35uQykMyirnMc=7hCogBqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 10:45=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Tue, Jul 14, 2026 at 11:32=E2=80=AFPM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> >
> > > What complications?  Advertise the lowest common feature set for the =
pool, just
> > > like userspace has to do for literally every other feature.
> >
> > The problem with passing through the number of host ASIDs to the guest
> > is what to do when the combined host plus guest usage exceeds the
> > number of available ASIDs, particularly when FlushByASID is not
> > available.
>
> I think that particular scenario is fine because they are two separate
> domains. KVM assigns 1 ASIDs per vCPU for L2 (in this series),
> regardless of what L1 assigns L2. We flush that ASID if L1 changes the
> ASID it uses. We can use more than 1 ASID in the future, but I think
> KVM will still allocate a certain number of ASIDs per L2 and the
> domains will remain separate.

IIRC, Hyper-V uses two ASIDs per vCPU--or, at least, it used to. It
might be worth checking to see if that is still the case.

> If your concern is the fact that without FlushByASID KVM will do a lot
> of full flushes, you are right, and this series aggressively falls
> back to full flushes when FlushByASID isn't available, rather than
> using a different ASID like the current approach. My assumption has
> been that we don't care about performance that much on these old CPUs.

...until someone complains? :)

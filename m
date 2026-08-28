Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407C3B531D
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894815; cv=pass; b=UeIdNu3adBlLQF3WJUlepahQIsUAu2bkISxOHsY97CZuPbjdonpA6O/cUuqhoRrQI/xMPmlhV9imciPmoxzUHsgCUwePzdjmrdYLCDwq6jmZw28FwBQryXehY0TEqzL1wVw9wDlRfs/Eyd1naD65Rt90ePgU5zNN1I24jfq2wWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894815; c=relaxed/simple;
	bh=/acu4QQwLSk/J23zJpKhduESFdBM59ssC+egexoj+94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdAfNpWp0Kd7sXGPxkMby8uY52i2KUZqK+Dx2sja1tMt7DNfIOiLtiHDQe9VuQgv40pLSGseolRr/vTrDBIokONNNHDGLopErB7uvbe3buxYaALCfBQyNTWbPAdLe93FSJXcD0Ts1TE/OknUCjL9YBGScjP3SVbYvS3zfweT6kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQnDqb4s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKd6lfQN; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQnDqb4s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKd6lfQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787894812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZxwtLd9NQj1SCiju7H7ZTUiJe6NYWWpG0fv1lpkTxw=;
	b=dQnDqb4sjJsgI57knEH/qOl1cv/BK9z1rrUI/dHF6tleQk6dGGfrqUqiG72QwuaC8Rx4Ri
	8JXwAnyUn2v3VobSMP35rlTvDOLVTTaZKHgTPbhe4zMmqnH4HLmzUmOT8CF280xki8Cb5F
	B5WUwp6yaUD962tlXqOT8eTCfkLQFd4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-2f4tNOKQM_KRgRl5nanuzA-1; Fri, 28 Aug 2026 01:26:50 -0400
X-MC-Unique: 2f4tNOKQM_KRgRl5nanuzA-1
X-Mimecast-MFC-AGG-ID: 2f4tNOKQM_KRgRl5nanuzA_1787894809
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482e2541c30so269415f8f.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 22:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787894809; cv=none;
        d=google.com; s=arc-20260327;
        b=XkNCk7l4U2mX8RkzY3uONHzEgR3zVh5V9BcwmETcgXwwWler6fGmh7JDS2JFnPWZAD
         BIxgbtZPZDNTB0oMAnwwsYhgOISen8S7p5AcZFUt7LwVv9bQj4y6qRGbb+QXP18ksEcz
         xayMcgN4yRrh46DPweta2pH+He8iQzqlMfeZWKgfezeIJU1/+bBxoC9B31HryeF/3Y8b
         1kYIWLk9GgHwBGYI2AIpVVZp9SusfWcWBVLMYiAAhMMOjySIA9bdmhtTtpwI4iELAeod
         9mrwfD4CUOcQfuRk2j4LpMhTENUCYAKAKdqFQQQlq5isj3geE6EoatqbcjYGIunxJkRN
         o9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xZxwtLd9NQj1SCiju7H7ZTUiJe6NYWWpG0fv1lpkTxw=;
        fh=0Eg3ZGd55inBktZ61xI0ipXSUIQe+dB0wCTSuaDrlaw=;
        b=hb8fsL/lfNEPzdUsF4VEphxcCDrQOKy8BF8qRfxjXqzMhOqwU4rHIzoXWHPSHqzcIV
         XG1PoEbsIk7c8Ps29FjYezuObdQhob8FN7WuJWUL5EXc2EUFc2b+UypJP9SCUFSciviJ
         FCv38zgeqq94lkDbZFOHBOxRotdwZ5yIvOku5VjCidFaChEgazci3wuWTz3SzmqWibPC
         jyx5blTemnhL+MJD3kPG6rzE+LnVIz9t6I2OZ1nyx71uhxLlVcsoQGEG1SOvWNIqOe59
         IrK54hXNO1p8jJ/XZbotoH7eI+VdYx16+HYkqDMpcy8MyLTBpBxD3lhMAe7s6fxNfcD6
         ZbQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787894809; x=1788499609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZxwtLd9NQj1SCiju7H7ZTUiJe6NYWWpG0fv1lpkTxw=;
        b=fKd6lfQNwLfIsZemsw8yUDy2YmCh98QASn/IU2YztahP/qFbl+iI6lwvG8/L7Lfhkg
         OWDCfB4Qa7b0y6U4ueizT75GSiQcAJIzofU1M+utnRmRkGUNr9IOBwCWFNZuiA2gaTDV
         lvvUNvvIdtxGwOnRzNheDUc/2l8SB8Sn/c2mwKlTUZ6vqoKDmn2TfkeLTbm9dVESt3ST
         42SmrXYlGYFJpNYxtZrnFSjTx49HYcySMnmF4ACcV9ezR4rNNQUgy2SQRkZpolZ9qOMB
         kF75Qk01WdaSBpzaHGvwpjZBmF9iyWNumT9Ak/CdbOetmJd/bPyq2v0hFd7sFIfOkHDB
         evuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787894809; x=1788499609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZxwtLd9NQj1SCiju7H7ZTUiJe6NYWWpG0fv1lpkTxw=;
        b=AYGWk43r9MmS/yWKQoX5JEKAv+hDOobxUvV2UlT/+U0wwixbLydhU7pURQYBLVEu20
         W6T8DKV87asI0A2NOLBVUxsRghd4E9enVj6FUlj/M8FkqVEqcRoX76c3P3RIIretu56d
         wiFYUo31EJXPm4ifsVU2vToFr7p9SqQH40Ebv/C1O6il7VW7OZnXIV4GN7cI37DLwM47
         TVKC2YikBuRbzHtYNWWD7SXuTkiXMhVDj+xi3abrgKO/Kr6NLQCKS7zch7aMfoVo+nNF
         p0cZvHjb0q/Hxi+OdvK3z7T/VNHvLO/w7BRVl2OgTruE53MjPHF/Xn7tRx4oNyk7iFcC
         j4eA==
X-Forwarded-Encrypted: i=1; AHgh+RqXjB0bj8SsCqx14p+cide0sxAnN189yJHGbI6lQcI2VXaOUFEt1OW6ZZVAHuN4CJilxe8=@vger.kernel.org
X-Gm-Message-State: AFuF++n7R9SrQP+Tlr7LzJDegs9OcdmFLDDaEUn7GTnS/N/NJOqiGM3j
	r3jzdVTLqso7QOr3pIoZQKYtLwK7FG7EHEa/IFYm8jAdkNZQzgKO8CvXYgGBAovrpwMP2gA2d3w
	Eun+nS/RiH5OD6NP/wyCsIeRFpb9xqVTxQ5I1pLYaHYwdDiPAvVPED2gS/D3wCeDRBv0dmm8cCl
	WcPsHwCRUSIKtsCzwQpADXaGf6iqxY
X-Gm-Gg: AR+sD13wlXhXchZSCV5shJpjv+1WPSGmkhaTwL65Ca42KQsg0u4DpFa61p7ybR6iYu2
	O1a5z0tNbtVA7Eyb0WUUNbyn5fbA11qRDm2lm9T8VVjUk7XaDQw/RBvq96ezR5GgBEE5Ue9/LhO
	psnR28GXQZHITsT3muSWAbud5UExbNgj2r4Zz8RbaN2Q1+JTkJN93PrYEtE/uJrzryx4dt+91kZ
	Y04WZJiXjWeQcW8//swZGhs+psHptrEHcEJy69zAAuX1lbu8FhUUU5TSJii
X-Received: by 2002:a05:6000:4711:b0:481:5a46:dbef with SMTP id ffacd0b85a97d-482eab6f628mr17265091f8f.5.1787894809492;
        Thu, 27 Aug 2026 22:26:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4711:b0:481:5a46:dbef with SMTP id
 ffacd0b85a97d-482eab6f628mr17265030f8f.5.1787894809125; Thu, 27 Aug 2026
 22:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
 <apA9eLuaMxCLdCmn@google.com> <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
 <apB1A5Ln_lGTI4oy@google.com> <018f411b-9c7e-4baf-9d55-a153eab64dc4@redhat.com>
 <CAO9r8zPDvXCdD1oyBmvaXoC+T+ABx-iZ3b9XeNpqUrKqPMcMAw@mail.gmail.com>
In-Reply-To: <CAO9r8zPDvXCdD1oyBmvaXoC+T+ABx-iZ3b9XeNpqUrKqPMcMAw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Aug 2026 07:26:33 +0200
X-Gm-Features: AcwNN1WX2e1gqOkMj0AU1lUBauR_ced3DSgFbY8aqWVtRY-Kk8j9u8fsxBCJ86w
Message-ID: <CABgObfZxmmRJW168aBXiGjDN9oRYQWyVjcdakQKV=Df5icGgsA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 12:01=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Thu, Aug 27, 2026 at 2:42=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:> >> If the goal here is to keep the checks here consistent with
> > >> nested_svm_check_permissions(), aside from the new EFER check, then
> > >> maybe we should also check CPL here?
> > Perhaps, but nested_svm_check_permissions() is not reached with CPL=3D0
> > because the #GP overrides the interception (table 15-7, instruction
> > intercepts).  The same should be true about EFLAGS.VM=3D1.
>
> It is reachable in the odd cases where KVM intercepts #GP.

Oh right, it does not use the emulator (which would also perform the check)=
.

> But either way, I think having a CPL check in KVM_SET_NESTED_STATE is
> probably the right thing to do.

Yes, that makes sense.

Paolo


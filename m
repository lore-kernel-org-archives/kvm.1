Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B713D5646
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443360; cv=pass; b=XLglTWiUIfGOy+Byd4tazYQGsysUMblNl+ZjVMUwJAkxH80SDOrgmB2Ku2COQNYiC18jia7xvjIeZgFIyZ3eD6K4mwOSUdwqn2iKowq7il5j0toMhhxKxVHl9zi0spU1QJk084CiGxQUpXY/djWML9b5xEaPFmOafBNtByuXVw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443360; c=relaxed/simple;
	bh=gCIIxQchOfS+s2uwk8j9bc3HXsvFxAXPKNaELsOUtL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZeDBRvjN7+d3ZlA7RBMXK69PW8F75vbikxgIOQrSKqIeCC7oykynhXhOP6zQaQ9uFnOwkzS/tdurPnof3Wd4mII3+PGNdt1jAgV3NfRfLcyeK9stSmLYZaQavihtef7IXrbXUNltwzWlxwokFyhq1AfpP/ZLc743iwBm5c/NnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCK4RsNX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nYwGvEMc; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCK4RsNX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nYwGvEMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774443358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akJQPaGSyGYnIRdq2AiDOEew7+F/guWgVP6P69hdkWk=;
	b=FCK4RsNXuKuLlEKbuh5sElxnXLxkUcRvqIG+YUG4E6cTG4xUgl6sGTFzYHLX229UFzF712
	HWatSrLR33LXm+RZSOsHvOOLw3MDJ/AhppTXLXU/oNiyh7SyQ0xyIDn4svQvJu6F1OuWeq
	z04Jk6hetlb6ks8ptwy+1hDVh+hoYDY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-dp2nPAg_MtqXtUaaA90ehw-1; Wed, 25 Mar 2026 08:55:57 -0400
X-MC-Unique: dp2nPAg_MtqXtUaaA90ehw-1
X-Mimecast-MFC-AGG-ID: dp2nPAg_MtqXtUaaA90ehw_1774443356
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b7ec737c1so2179720f8f.1
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 05:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774443356; cv=none;
        d=google.com; s=arc-20240605;
        b=Vm1POFFtF/O6sz1Z0GJoooCdk0oknWAQyVnAkIZAbgyTxQ/TYmcD1F+viPv6mcSFjy
         84TP4UMZBatqrYknqjt4/L0fiMkwb+C1f6tExlDeqvATjuN8EuQ01l+Wyp8Ny8c4LOo+
         EhhEYIMP0r/dqM5QxkvzlYL0l1Vb+oaoCB+kkjYESVMF8YNQpmwmY3s2DFPP9RsIrq0C
         Hk141YG7fAqGDCBwnepz/JJ0zlWW6dErJBtB0Hgbm6hmWkQf7VDRFt2Hoj95nnkGxXeD
         5taZHJG+TMP6flZL0A197eigzu3MO/wSiLnJUpTf/SraibP+kO0hIEtzOaN7wC5WN0fo
         kovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=akJQPaGSyGYnIRdq2AiDOEew7+F/guWgVP6P69hdkWk=;
        fh=sbSoIo2lEmnAyIRJzmbcg2Mb++BKHSoNcbnWnTpUyDg=;
        b=J5NZEsSDzd2HQZOs/+BsAEOj56IC5JmXSy5O4r9zBC0M1sGvfo9aPacMFqWhlsQ+W+
         1hA+xUB+VWiIvSrqlFE3cdKqmUxID3MrpRMcx98HOzfD6SDAEbzcZQXXt1saHP2aHEHk
         3QHY2iy/fOq/B8gXDBwjKcTrDJxWiVkvDRn4wzjBaPUofETVMi/9f7gF7ipXNePRcnTs
         f7ZrLElHbzTe+d01nmPBtcG7hgrf02FSXEF75iDqTYBQz/pWp8B0HoJCWI9vw8HK97j5
         HHGHrOdvxS/1O4+h/cfg/gwMR+ue9TRu073MOD1QSMUJ9r6vPL6qTjZF61DBqQBVNcPm
         AW+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774443356; x=1775048156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akJQPaGSyGYnIRdq2AiDOEew7+F/guWgVP6P69hdkWk=;
        b=nYwGvEMcX4uiqqdSUvejbB2slmMP5R6w65KbihfBqsNpv1VfxuVIWxbkYPvPvlACrc
         zHaqtjhv0AW0mda3v2GoFq1StaRj+lg2SFoauXvRHY7iJvlFotnNjbyzib7HMGXTuhmn
         wHXM8Qe7CMGHIYq5WSeobxOFjzQMMzfLAUES/P4BdmZwV8XQAPkGB7cY5ZlcyXLQs+wI
         q0OsDc/lKH9UQrG4DD0swjZAvKhVwr0VhUzIKr3XAbqpH1CH+Z25VjM2hUltLV5N1Y9f
         fYv5cChkMg5Ot5RJiPKFP73J6wFqz/HFblSV4JbCNn4TSXBm1TStb1JzLr+VxwQR3SzD
         jBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443356; x=1775048156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akJQPaGSyGYnIRdq2AiDOEew7+F/guWgVP6P69hdkWk=;
        b=kNoMDFz2YEQs2pgp+A6duhUeqtUf95KYhP6P233h4vWHa4Y08Ntb7lWrZz6rlwfnrb
         5OIULUra9y0aqCxxMG3pQ2Xy14dGP2WSmsvX18Ldq01PbSbShm18hIHKcfKeI7XiNZxk
         eP/2bUXcXiRGsorL7SPSXLGI8hEfZ7pJFHsW1dg+mMJFJbWVaAGhijBL4lGKDhxvN5Mk
         dn4umOzPTYVNMETZKmCsN74gk+8r2zdw6NPZ0HrAwBPFN6tT7BKq6UqA7q/Ewh1vWsHb
         y/EC1WC1rYn8gCJLqVmlBUTWymakFT07fGHkUdSVOO46oe5zVaia0f3nUiL1/NGuDUrf
         F8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXPoqapHyw21zO5FxPZY6aL2lpUxj0QUuTMQ5xzePfmihk2JdgWTs1OZhNAAOVRSEFmUdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7fapc/4Xkz2o6x0nvdY2gDuky9nyhYR9f5PZb1w9vvUYOwC5
	7w7mEmc+QUXrfeeccoJQ4QybhQkH1mxrtSTpbHKcNvXjuMp3RVtOu5CqrGJPTqgt/vZ1QNJzjDW
	751tZBTGst2mstXPxs4UW3/Ag3olslQAkhsc8Tkpdh8UP309iDWFhuD9CDcQo021uB/sDdTWA2k
	wC38sCmbWvNiZN1R0nN99YCpJtp0fB
X-Gm-Gg: ATEYQzyQUSBBRBBiOhR6dG2abGTYcRwenSY2+oC/XrmjXgqKfGcdjnZfz3wLsNjqncd
	1c6DmWW0NRMGr74ltudPD1/R6N70wgJdU+uIVqFcyWublbWnE3G5IItNBZJ/YwqjP1kW6mOtwSn
	IiPuFRLIxpsHk18ZU7YNR9AVMx4BYOyO6Eu/7CjnRr9LVJNEqzrGV9umE9h2pgdSEsM8FRY2ob/
	tsRp+lv1y3t/+Oi1YIyE4aRePfd87FdAYTPfHExdSCSpG+rqWjwb8f/zUn4B1736smAjOQvK1nk
	v5Hh
X-Received: by 2002:a05:6000:2385:b0:43b:6352:a262 with SMTP id ffacd0b85a97d-43b88a1ac8cmr5409553f8f.41.1774443355873;
        Wed, 25 Mar 2026 05:55:55 -0700 (PDT)
X-Received: by 2002:a05:6000:2385:b0:43b:6352:a262 with SMTP id
 ffacd0b85a97d-43b88a1ac8cmr5409495f8f.41.1774443355343; Wed, 25 Mar 2026
 05:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com> <20260321000931.1947084-23-pbonzini@redhat.com>
 <721959CA-F869-457E-A410-694D205E8F0D@nutanix.com>
In-Reply-To: <721959CA-F869-457E-A410-694D205E8F0D@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 25 Mar 2026 13:55:43 +0100
X-Gm-Features: AQROBzArd3hZuhQxoC8dJQ9KLgi3heCamuR27qn3JzOnWMtsWvn1-izkmQPuBPM
Message-ID: <CABgObfYCW0S1B0PR9nqFMmtPZ_WD07PNdwRj1s49pssr51mGjQ@mail.gmail.com>
Subject: Re: [PATCH 22/22] KVM: nSVM: enable GMET for guests
To: Jon Kohler <jon@nutanix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:57=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
> On Mar 20, 2026, at 8:09=E2=80=AFPM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> > vmcb02->control.nested_ctl &=3D ~SVM_NESTED_CTL_GMET_ENABLE;
> > if (guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
> >      vmcb02->control.nested_ctl |=3D
> >            (svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);

The issue is with nNPT disabled; these four lines of code have to be
moved inside the "if (nested_npt_enabled(svm))".

(The giveaway is the kvmmmu:fast_page_fault event in the trace, which
never appears with shadow paging).

I have fixed Kai's reported issues and EPT page tests, and will post
the next version after doing some more testing.

Paolo


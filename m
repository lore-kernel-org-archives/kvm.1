Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3117A2EA
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780025; cv=pass; b=IQN1fX2iWnyKy4SHnq41LWvPAs1hHcXPxDqqJtlM+9xVi3BEftsqtAUENWFw9Knzd5N2oZo3aChdyvq60XWH4jFuECk1zZiIEEFmP0ajam98ojOYRMk1aaEUhKrHBRry/NAaH6JCvh7XAKtacXSU8DDoDY0L8avTT6QttjI623k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780025; c=relaxed/simple;
	bh=LxANhLw80KN8Y+NFL726n+5RSykYC9D4dEjWowgMZlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFxZWdjF3VEy514/hDlCQnrG29SGIfcCemXO0J1VRsn8RdJncQQwuXMoDetPBdTi99wndsUzucf+1XCnla7a7qbuNIg6WPbKF3LX1cgwA9flwF+r3vx4auzvb0cCCekz6G//MSNrxLO/eNLCUwb4vkcd/GawGO4U9rNNmibm8Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3QoyFXY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB95qbhb; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3QoyFXY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB95qbhb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778780023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8IboQfLLwmc/2a3atjk6g14pcOvaqj+fayzbJ77BXs=;
	b=N3QoyFXYETMv3YvJUt+ajZwSqqhgqYtddHELVY6xlVkyWWj6NRE1kJLIWgywATzF/jxS1s
	Bf8q6Amqv4rSPEY334bbHvQ8FTGKOyuKRhXe3d7qCBd3n0JVmB+wd7mCbO3vfuVhbJ8nMz
	41FYO3oZNthV4nf7QGD+wsEMusuSSgI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Jmw1y_oXPyWoyws83yDaoQ-1; Thu, 14 May 2026 13:33:41 -0400
X-MC-Unique: Jmw1y_oXPyWoyws83yDaoQ-1
X-Mimecast-MFC-AGG-ID: Jmw1y_oXPyWoyws83yDaoQ_1778780021
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso7386489f8f.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 10:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780020; cv=none;
        d=google.com; s=arc-20240605;
        b=h31algOrNtKRV1V8NzD5AnJFdV8PLow1SmK62d6TXz+4fBE82sIcYfiIf1VEZRXtJl
         XJGImtvMNG/79M1KR+Kd5Luh4pZcoRODHDKEIXRgcIf8v5SQJcHtnVM1MwvsrIN5e24B
         Ge6QlByTEM4AKMPDBrxFMkJVE7yF57IdWodYhEi0vbDNMh6LaPksoU0aJ27xy163+Lzg
         rv14sU5oGjJ9tSRj66f4bG00oGSGCI3BAJTjGwebOTn3wlzx+FVT4MlpUmJYpGCwid4S
         3JxGqhVAXR1Jnuu5Jfop3Fy9OcxZ+AsnAMBX4V78Vw6DXc5pgF4o7/Kse1xgsC3gqYK2
         cxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8IboQfLLwmc/2a3atjk6g14pcOvaqj+fayzbJ77BXs=;
        fh=c32Ip6MBZ1sDZExTsnqWNgSaLsJ1max1WSA/ApEnYZQ=;
        b=hGFDSgfjhdy7C4VG5HXPtKksI+8kA36WzQ/HhIZJ6YTbV1bHBwtTevl+qMcTuIsw9J
         +El8t32w239P+v8HzGEy+ddswIKR2ZeRzDUaW5DC2NU++CdrcFxZcIvjP+V/QLVexHGj
         wzRcapzPRlpvmSxZQks5SRkqZ2IIAys1nUqOjTTSTYZYb6By6hWT2cvFgXYljGfMCKF0
         m/qhExIu72PHebHCPnYdHYDeG5vN/xS+djkXtz9ok3tD9qB5pqBqBI7hctxKlShw3mjd
         wz5J8sqsxxA2jhpVNRLdkI1xM8Qxi1MY2DmO9jxr1rb3N2/533pdzgXQPhkICxsr0SCT
         WpLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778780020; x=1779384820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8IboQfLLwmc/2a3atjk6g14pcOvaqj+fayzbJ77BXs=;
        b=UB95qbhb5D3VlloQGxAPFDn9whtcSERNIHpjR2LcUWSz6JLvIwWnpcznYb8zYi4nTh
         dXIrGraVS1LBUQDAAVnxYzRGIn3NG5/5rwhFz2DlxTvXCDEiwwOKjtcvKc8toqUnXMbL
         ddUaQKRwTF34fwimaH8IWRKXgEmywpVwa6m9Ln3AhOCKc+6d/larcWLWMrGox9zFRuYz
         /YuTQg5aBXBbu2Njxs209T7I1pQtg7MaOnNc++qhH3kuqOQIyEuaL1bckLGdwijnn0mE
         U4WGZg2/NEKafaCUroEVQFuh6L8FhDWOOVJ1rApqvHu4pH5MEk8xq11X9Inc/tYf6wKP
         gryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780020; x=1779384820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8IboQfLLwmc/2a3atjk6g14pcOvaqj+fayzbJ77BXs=;
        b=KbR9ZZc7FleBZ0j40KJzSBwhTfErCX5jlkItINlQTd5+2vctDscInP++CMR2j7od2J
         0uo7IY+RqKw0LkXPZhSElSr1ck66GYflWM7pEE1vyZdiCj+ScQb1pUKtz71FfgqiM9+1
         tqrysrm4Ms9tZDWlz2mqMxN26SwJSmqC+se6V0LYXeaCL1vgbN0sIfJVO75HlZ9X5SYy
         vs/geXDsBWiWS6Kyz7/o1hboLE6TL+MInNgkltqpSlJp+IcCpCPGbgSYXgJM7OtTJvI+
         0ibsFH7PA0o2GZs4XBvHmHjdXd7g/pHjz8QvXAReuxoW+JmFv6TyOvNtO+4HHZ+qO53W
         lXBw==
X-Forwarded-Encrypted: i=1; AFNElJ+03Wl2IEhtCyIkjQ9lZKSbhnH2V8MpXCDrGjkbBTzYFSYYeysaGmn9fEa8AjlQQccQjj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtMpz3OJ0gqS3UN/DEgql6wJbW2y8sQEPksDC7JCUeBzVyrhY
	aPMMVWoIhiprGD2tlDEWjExYMuzgCD8bmUzp4gKz7rXw7F6yJr7FOCVh+sxZSpH6uBfNZFvP2Z5
	/N9gahrZJtsJLG3VyZtRr4VCci338XMLe2HRoRZyRhoq2SpQ9DJ8NIEFqxeZdMacM1gJN9eggVf
	wwy54grYh7MLPtFofgGi3eS3i70ngP
X-Gm-Gg: Acq92OGlYtz3BMJ5iluRQ0Ak5y0J0vMI7y89fa3CerYDX36UPbVB3gUiAMpi1MUjRoP
	u+ebGRGWVcm91cnCxd3HLvXF29dWAMA3M1Ljw9MO5YMNlfMqti39tH9k+cCly5BfomDpXTrPgkq
	KTmZCOgmCunRn4jkPDsVzi8Wv6HvzudBCVI1Lu+sJL2bOFGcqaXPJ1sFGzdjyZW3GY5tTVWbX76
	1T3A1BhiOy/B1LaJ7v/wk6BBlj5XRs39areDvajBwQ72w4NOdKZVuznTlUb80oqZbwWuiPdrMD8
	/3BxAFbHo2bOWew=
X-Received: by 2002:a05:6000:268a:b0:43d:68dc:9ca6 with SMTP id ffacd0b85a97d-45e5c367ademr105418f8f.18.1778780020598;
        Thu, 14 May 2026 10:33:40 -0700 (PDT)
X-Received: by 2002:a05:6000:268a:b0:43d:68dc:9ca6 with SMTP id
 ffacd0b85a97d-45e5c367ademr105403f8f.18.1778780020271; Thu, 14 May 2026
 10:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
 <20260512011502.53072-7-chang.seok.bae@intel.com> <6adbdfb5-c4fa-455b-b427-2f8350bc9c2e@intel.com>
 <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com> <eacff6d2-50eb-4ac1-93cf-f5652651df70@intel.com>
In-Reply-To: <eacff6d2-50eb-4ac1-93cf-f5652651df70@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 May 2026 19:33:28 +0200
X-Gm-Features: AVHnY4Llo-UOt4DvtdyAfQfc91T7Ic5c4KUdMvtDcTAiuTDjNEGDQPW4yLh_fKg
Message-ID: <CABgObfa8A5xxr0kPT_r4p1cCokW2OXgeHySN80ALOSM-B65d5g@mail.gmail.com>
Subject: Re: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest FPU
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:17=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> I think we're getting into the weeds a bit. Maybe we should focus on how
> this affects the ABIs and work in from there. Like you mentioned, we
> might or might not have kernel APX support and the ABI should make sense
> no matter what we do inside the kernel.
>
> The functions we're discussing for this patch [...]
> implement the meat of the functionality of these IOCTLs:
>
>         KVM_SET_XSAVE
>         KVM_GET_XSAVE
>
> So the question, visible to userspace, is whether the
> KVM_{GET,SET}_XSAVE should APIs should be able to manage XFEATURE_APX
> data or not. If we decide *not* to manage them there, there needs to be
> a _separate_ ABI.
>
> Are we on the same page so far?

So far yes, but the next paragraph is the kicker. :)

> If we _just_ look at making a good, consistent ABI, I don't think
> XFEATURE_APX is special. The registers can be managed by XSAVE. There's
> a KVM XSAVE ABI. Why would *this* feature be special from all of the othe=
rs?

Indeed, it's not special from the userspace point of view.
KVM_GET_XSAVE and KVM_SET_XSAVE *do* include APX, but the copy needs
to be done from struct kvm_vcpu rather than from the guest FPU state
(which as of this series means arch/x86/kvm/ instead of
arch/x86/fpu/core/).

This is in the commit message, but it might be easy to miss:
"Therefore, let KVM handle the APX feature on its own *when executing
ioctls to get and set the virtual machine's XSAVE state*" (emphasis
added).

> I don't think the fact that the kernel is using those registers as GPRs
> changes what makes a good ABI. That's a kernel-internal implementation
> detail.
>
> Now, that's not to say we should ignore kernel complexity. Maybe making
> a nice ABI is so nasty to the kernel internals that we shouldn't bother.
> I _think_ that's what you're suggesting.

No no, I'm only suggesting to keep the complexity out of FPU code
until we have an idea of what the needs are for non-guest FPU state.

Hope this helps,

Paolo


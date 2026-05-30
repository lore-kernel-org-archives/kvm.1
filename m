Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531939FCD7
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780146177; cv=pass; b=sGFX0VrvG4C26/hapORzi2kKV8W4JA8CBUcPMk58mfEeF5u9+IMJ4FIXDnQPAAyNdPD+k5AuaF9y3yX5xyQoHeunqRlvw80kQO06AGmSAQouLia07RkJ87QmzNYeYSmetiXG2oAEGFe6QTCsEb68AGDcoSivLUM0jTV16V3GNTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780146177; c=relaxed/simple;
	bh=oD0+JEMRWLS5/yO7Fm6i65PIA7M3P+tAi8cgGnjFQlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK5LRGTNSd6NsGS6tvs4sqsR0yBR4x5Fx27PsP10ltpiXWW68GnF/EQcxjpusjVzoJy/drE1oNytr3wiVX1tJ3J8U/FeRHyUuZbC6kNC+QKsxgeyIXlXlpbWhFILb7QU8lPIv1Gg3XoZNt5uyC/CRfPRW+3pX6vCKXBK/ilEQN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeEnxByf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nRqrc1Q5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeEnxByf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nRqrc1Q5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780146175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJ/CHIeLJBxrnEF/NOp/MLNvBzq3leuLnjS8O1PUnmY=;
	b=ZeEnxByft7Mupe4Y6Fo8KYfY/NHRsybIvl0To1MrOwZ95f0Ipj0QWDG1aViXf1lWCEdpkp
	YhtDUdJI3W/VAEp5e7hiPuA2l8Geb4V5sqb8csEdSRfyRrITtYipRz53SUse73RtqBF+A5
	/WAnJf5k2hbNWYhslysgnTKQNPMds8k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-proWKkPKMVCyz4GWKfD1cA-1; Sat, 30 May 2026 09:02:53 -0400
X-MC-Unique: proWKkPKMVCyz4GWKfD1cA-1
X-Mimecast-MFC-AGG-ID: proWKkPKMVCyz4GWKfD1cA_1780146172
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef63d1214so903129f8f.3
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 06:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780146172; cv=none;
        d=google.com; s=arc-20240605;
        b=A0rNcClvH6YTIDZ3G3b5b1s+jJpLGFdqapLujK5YWg8ml4YADKhO/9ex92vxzQcUuT
         zOOTYO2mxmZ4LRga2MJXUyAbL5QK62YISQyEm4Pv3SLdgpMXhWCYp4ToGsW7FG4IZRIp
         G62gvTyH+CxIGH6u7l/e0lE66j89t9bEwpON34FsiDuHjkUd+aPGyEmRJ6qXYN/NJY15
         F00lAaywFKFHpNyePCCzxrZJQxmoJcXpHehE6/yaj+myaz5Fioan6/Dm6nNSxoiCoEW6
         u+s+NhdDQS+phhdZTmIDjDkfejcpD/jCN2jep8gfGdzXC720U2SyxblVw7bzKp0zKOdr
         dHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJ/CHIeLJBxrnEF/NOp/MLNvBzq3leuLnjS8O1PUnmY=;
        fh=Ag2Dc21FtYYMM08ogJekN8qUqceSK+bw/XwMPskG78Q=;
        b=jwClckd1zzOOPdfCn8rrUaD7QTPsh8BtRNymjfQZ1zZBEoAM12E32fv3+/iiB/jKmu
         qWuMHmywnRODFr9lyh/SWx8KPGRBaTm1+HiqV8rJVQ7KZGeNjeFwFcx6CWyTdJL0lnjo
         G3m0n6CMK3k46fWBxlzhNiB1CZB40ntkG+6IwqsJc7e3LDOPBR2yHJvOXNWZmEiMakIF
         gpJJWuQwUhABZkAeDn3SZJCxxRZwooL8LDh7IeGh5iUUI5FhBGLKRWFpdCz6mLcwe/TB
         4ZM/Z1sCl5x0zf79VnPdaERBn2uMYEsOOr787v5PtLTWQR/L6vTGt9YDc4dKKG9JUxCo
         /Y1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780146172; x=1780750972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ/CHIeLJBxrnEF/NOp/MLNvBzq3leuLnjS8O1PUnmY=;
        b=nRqrc1Q5io+xBOiyVBxi6pTv+RiYiDm+4NFlsMHg5CB2mT7yMjcvDza8y6tof7QzDw
         1gMowT2wV2lW3Hk/bNv8R0hArlBQw6+P/d2Qfo9umWim6f5FPYpn431EKlj55i9DWLks
         /7WL8tYZ1k1YqWExqJ1rguYk7ML5MKMy/29tc6JbZlz8VUmfZi2iKc7i4TmtCq3+OpI+
         RkzEMLIh/y5i//Rh0PuJloJakbmUojJ1PXHOd1FRxsbhoIGEa9nT2MIWZ89ccmNN3Z5C
         4H2eQyaFORGjfnfQGqAAzRcmMXr/iRr1sj6/94yXYPbiTYm5zr3IK1D5Eqv4HhVzPjow
         LBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780146172; x=1780750972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJ/CHIeLJBxrnEF/NOp/MLNvBzq3leuLnjS8O1PUnmY=;
        b=hZObeZ0OmDIovGbElntoLktlNTG8lk20x2CHC5EzFm1yNAbtlpAnMh/6B9QvWCz6+V
         B2jYCHo+THc2XW6S42Uc1E7UxZMgdXfLi0aMTsIV3WtEHBlR4ca5dBdEg4Qaiit75TEO
         pMEJvdMHVsprVbpp6mqglKa8ZQajhUoHWcJQfEUBQukYEtiAED8+DxTLK+DKhz23znsf
         bVpJ8ZOA1oe+//kGIvRGCn4qapEbxf3U38Sdt0QFM0kNZqCwIIN45TG/BoygSH1mOXYL
         ZgkpYXYtf/TGkSID3LhnhrqwAc+B8GH5D6wV9Vn77xvji+RjbMlxv04OGXgSOSNjzrq/
         rsAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SFaRSmdtAkHNPFtfVlFzR/Y0BOzQ8LQY09hBKT/gN/fTcfIIrDiiux4+jJtMalr2zZ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinFpEsKE47rK/9uC1z3+6L+Y3XjtnExfqTn1s2Y/NH6Fh0Bws
	QhcMXbPLh4t6897t7troMsLZk8S3K0FqtKEmLjqyuT+YloR5cPNhG5CqVBIy3BIgvBoE4lPswjx
	f1TpSVcjQpmcDXYVuK9c5KQms9cICimfy23IVMGwaJcbYaGqORPK13ypYqQrIIxRhFa27lw0pnX
	aJTbi5IzU6HGJkV2y3kJaV8+qcNvFo
X-Gm-Gg: Acq92OGlBAwSBMI9JErp7oQcQIwn7pHU5IFxsRkKtyegpHuCU2lnkCitWZ/1aFzW6jS
	EXsDJN/W9D//Tmko3ml5b/kNqdwMIdNcgAuAzCCPpmzzFtFicE//UU6225pz1A9zx2dLkUzKJOu
	pvGMM1+gi4KPCvFAuwdo2b45o5Bu7vnBCoeEB7PyxQrkx9NRx/uC4G1DgPfgPOqVeP3REtOBGUI
	Pm1LwDLGxQ5ESPV7PP2YVtOcp+OAQpvgHyG85YVVaxMvkwJUSSead+UXSOPrBE+XjXgCilw/rhq
	KF667Q1yvbS5kIU=
X-Received: by 2002:a5d:4536:0:b0:45e:f381:cd7f with SMTP id ffacd0b85a97d-45ef6b026c2mr5186065f8f.5.1780146172084;
        Sat, 30 May 2026 06:02:52 -0700 (PDT)
X-Received: by 2002:a5d:4536:0:b0:45e:f381:cd7f with SMTP id
 ffacd0b85a97d-45ef6b026c2mr5185996f8f.5.1780146171309; Sat, 30 May 2026
 06:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com> <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com> <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com> <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
In-Reply-To: <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 May 2026 15:02:39 +0200
X-Gm-Features: AVHnY4J0S9-fDPB-0vXCW_wZmBSk3Opv6ki_nGjvzeQrL2OEYKH4mMMTo2zpapQ
Message-ID: <CABgObfbZyQjBV5M5sUtPgggv2rGpZ0+FBHB+FbKP0fALz5K0qg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
To: Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 12:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> There was a pending patch to allow the MMU notifiers to disable
> themselves while still in sleepable context.
>
> https://lore.kernel.org/kvm/20260429222548.25475-1-shaikhkamal2012@gmail.=
com/
>
> It really needs to be split in multiple parts, and the allocation needs
> to be removed.  Looking at it.

I did clean it up but nope, it's broken... You can't really stop the
MMU notifiers while the OOM reaper runs because the victim's own
threads are still running and can do whatever they want.  If one is in
kvm_swap_active_memslots(), the callback would reset
mn_active_invalidate_count but leave the thread sleeping forever.

Unfortunately this doesn't give me much confidence about how to adopt
SRCU for the gfn-to-pfn caches, unless you come up with a way to avoid
vmentry after OOM?

Paolo


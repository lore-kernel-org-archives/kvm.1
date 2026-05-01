Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8413B584
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607990; cv=pass; b=W14+mngrSIVczCU+ROCW1gPVqGVK1xmosl6VlWd62QHT1YsKSAkV6UVuYKlNYEIOmu8jsyxXkGSj3CClOZNyiIWsuKY7Zk34r1ofAHotEW4qjQLrG1VNJp+8aa6rcHozX2zuj9ye6ZnwQvMaTMVv8iqjME7pmbi/s3warepqXfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607990; c=relaxed/simple;
	bh=SB0Np+gOIxrgCBJ144s8IzsBKMOFqrvc0XMD/QdFvxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC803FvIZ2mHHIeQyjWrkQCiNfS+SgDDs0/GTgws0hb4iQCs3Bv6t6qrwG0tDjqZq03JI1um7gEotCZnYyPq7k+6eLbMVYjfCOTaH72LQZvyMeJ4S1ysqt9HvvMuL1gdK2XSwFf592X7UZXGcw/ckVIh11c6kfR4vhXdwuYwwgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUtADle7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeuE+nJe; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUtADle7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeuE+nJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777607988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCL8DA3zB5MjNcRvLVRvgoYpbXn0RP/jEQuf7w+5rHg=;
	b=AUtADle7SHfgUJ8px/CtxHLj2NGX7zJ3QGJ7u0J2uU0gbfkaSHxTWtiJ1gjCbI2ANBsXGj
	XnOjpu9qNLT7yS60TY3fUYNPNiTuJBNRXy6877FAGh8dYtpNQ7Tu32g/86zVXZZbNNwjde
	6b+AWKEgluolnz8BphFwFQMYuAEatpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-rPgZzeEwPEOTlvHoOmuqAQ-1; Thu, 30 Apr 2026 23:59:46 -0400
X-MC-Unique: rPgZzeEwPEOTlvHoOmuqAQ-1
X-Mimecast-MFC-AGG-ID: rPgZzeEwPEOTlvHoOmuqAQ_1777607985
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5952c635so15085265e9.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607985; cv=none;
        d=google.com; s=arc-20240605;
        b=TYhbSMzyos0I7v8+Ghk72XsH/uWE3bldsFyKIxduKGvGhTLv9/mha8xiFxn1RXxu2T
         XR3XjSlJcXdr8k8y5jKwxfp8NXafgvUpQ+sq1zAwsGHv8xFuWhnJkGS5uAI/BhUy+PoK
         WRpCFjc/pc6Iv9MfukVDnd+zkbgU5hVh4Sxe9GpuiO95DOzmGm798DhHFzNNFipZ+6fI
         qCgvb49xDdvYR1YLHoM2K8Zaz9y4302egCZNl/qTozbf56QFWvtotKz/MxGMKlub8Ztb
         ICOOFzFp2IU6QjRSkF1th6BHEVJlcWda9iV4+4ZJ1qACsi5eG/oCxWgXf6VG/YwemOiS
         WGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCL8DA3zB5MjNcRvLVRvgoYpbXn0RP/jEQuf7w+5rHg=;
        fh=jwYEKFWP5EM1py4jlRM+1/JF+NregRiOH8X7DwPHEH8=;
        b=SOolfZxkdvJctRM8OibRF5aYoUJeZ7R16kxHOzW97glvjBWQc1aJLKBlYJeDYFD/Z8
         x/+m58MsWZemMsWlbmW4zYXGIAMbUnWjfuVv1x3s4IhrYreZm+ghG/iyLtuut42nFNCZ
         89huJyq9+dN4Du91HN4zmgLNIElJclU/O63Cnq0qQZzA95k5dMyTEXjw/+ebt/UtDRou
         WSDhgHrMnXBlVUzIPOXHRlH4dImbivk8hNNVd53LE7YI4zH4yY2G4qqRQ4K/cJZwRdao
         pHXgOrAPhdVa1sJ/WHZT4yRNoZtPszmddUXms6u8mSskd2oBgXQRvnm+Uv3NF62JW4L2
         NCPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777607985; x=1778212785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCL8DA3zB5MjNcRvLVRvgoYpbXn0RP/jEQuf7w+5rHg=;
        b=DeuE+nJe+8rfH7ZatNtFkm6n0V7Hye/fjJnf8+jbYTgnnw30LLCy7lncYfIs1RMFsY
         +679zEUD3qeNg4dzy8Vx9o2iaSFEoNptz8nx9pFu3IaagbP5t5dw3i8j5hnpn+zTPuuH
         TV53ryCnYbqxEHirQYGZ6faadqte4gbxe5AIcb3Q3FE3DIJ7XeEEmRiIqnQM8wAl9N+o
         b65zgTiva3CUIJuZGpRK4l1mNDubYLEwipD0/dbQxSIz6kscQJgOP5xHXlTa5qDGdb5N
         MT7eJoQzrFCVE9Ue8uZRUdR33WYuqktPgJjBCIsvjneR3d3sFoJNKNIEq4r0WkZH6eBQ
         JD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607985; x=1778212785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RCL8DA3zB5MjNcRvLVRvgoYpbXn0RP/jEQuf7w+5rHg=;
        b=jD3BV+Zxv36nRwiszk3mbDUuv5eaO7ITR84is/LScWsls5QgcNmMAN30gEMXhAh+Rs
         k4d778zwu1anJep7SaXXcC3PXNNjWvSqON+uS7CdW9Hm93F9wCf8sNFsD/lBbL6n3/2s
         nRLS6+g7EaxhNloaTZiogFeBwMTbb8b+JwBHDe4uPmQ/FNgTPg2ezvS6uIy0PxdtbMOT
         IylcSLkgAUnJy5oDcyIa/b8Duqvr0Fisoy5sYJhgKWhptTkf0dJS7a5MhVbaD5IcjDha
         ng0f3CKf+MRmJq55zy3jFYjMV2kdWZSMYNs8oYEWQts2eGyY5uFNXv6IcuNIglq8ZBf9
         PEJg==
X-Forwarded-Encrypted: i=1; AFNElJ/71FYK3eWw4LQuP5s5ReRlje63Tcm4UCACkdBrCc9oBow5FZWbUJwGF6iOklac1hSSj34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZwF6Eu5YNLSzGYJxGiSptYHgvZbLGgnmuT+vumTNSmWIyRm1
	VEei108iXSkIqtxjZsYykwnjV93YD1k1RFtNRdnJCwdrOV2jpkFwtwymv0vCmgf9N71H4L2ffyT
	3I1aDBCCl9UYNe8ddvmCak3dov1wxTrSVmrypKr1+UyFj8GlbaHBFBcz7x9qpgUI58o2TvyhAhC
	kAJyYmQUdLkhEdVS+wrGPzYDAjJ9aS
X-Gm-Gg: AeBDietilf1P9MI80e0kJJ0U+XCuvqn78cb0rOpFYlWG82voPAjgVftUsGhfIiBalHd
	AoUMirfaQPv2fkbhaYuYH5kZbJMdarurM9s4Rp5AI7R4xH3P9hkDEgs/rEvr3QcUvHx52tOy8MI
	keXefDjTlwuXe6D5ERH89lTWbOu7LF1fJR7udhk2Ct73GcPwjsNMWCQqYr0sXgZmzC82FoVoizj
	WmWFfrzGRfPUPWfF1KypAh738DasL6LXAd/dWRnx3W039LUDwq2qHKvxIRLSsjY5A8BLGreMXBS
	xujkC4FDICLTBqA=
X-Received: by 2002:a05:600c:628b:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48a84452792mr101574255e9.16.1777607985045;
        Thu, 30 Apr 2026 20:59:45 -0700 (PDT)
X-Received: by 2002:a05:600c:628b:b0:485:364e:9328 with SMTP id
 5b1f17b1804b1-48a84452792mr101573915e9.16.1777607984694; Thu, 30 Apr 2026
 20:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-27-pbonzini@redhat.com>
 <afOqSkJnemK1B0PE@google.com>
In-Reply-To: <afOqSkJnemK1B0PE@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 May 2026 05:59:32 +0200
X-Gm-Features: AVHnY4Lf2EX9VEl0S-HGewg5IzCYmBO8wXO3pd-Rj2akrNC-BQNzF9WNF5FNAbk
Message-ID: <CABgObfaCVaKfn1Jh7SdzzjwFpSURJTQw9fP0tjM2==PAwfP_pQ@mail.gmail.com>
Subject: Re: [PATCH 26/28] KVM: SVM: enable GMET and set it in MMU role
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:15=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e7fdd7a9c280..3895d8794366 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -138,6 +138,9 @@ module_param(pause_filter_count_max, ushort, 0444);
> >  bool __ro_after_init npt_enabled =3D true;
> >  module_param_named(npt, npt_enabled, bool, 0444);
> >
> > +bool gmet_enabled =3D true;
>
> This really should be hardcoded false, with no module param, until "enabl=
e GMET
> for guests".  Otherwise stopping here means KVM is over-reporting support=
.

Are module parameters reporting support of nested features? I thought
of these as "does KVM know about MBEC/GMET".

This is I think the only point where I disagree, I think. I'll fix up
patches 6/7/8/17.

Paolo


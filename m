Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F319E7F7
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433350; cv=pass; b=jNv7HDLlqbChWF4ZP25mmNTXiaX1yeAboe4jv8CKIfCj6aOhTkncMiHL7VHE19MYBeqE6p+HG7OEgd+7SzD9YUpht3S8Q+FoPynnGcGwkpiGi6uL1Pi56iSaQqw+Patf4EZg7m25IwSyNb6XbOYgqlVRvmjHFHUqvU0A9YbceG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433350; c=relaxed/simple;
	bh=axcvgsILTODf+S/WAUYZkJY3M4i4uVn6By4rKm4EhqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQgvWGVxJpJfK8QTSrP28dVIeki3PDDWZhZYVjAuD4N9fYj92Eo4wbNkFdLl1HsiJujpt3PAzMeB0zD036bKm6JOnsp+IV36ErPeECQ6SXgGsHJFlBbVGAmlkIP2WcGfpAPh8H2NjLXxYS+s322If3AHSXOCylx3c3NznUBvLGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTZ0O0ao; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvDMBoU1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTZ0O0ao";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvDMBoU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774433347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pDFhyXF7rlG1aJ4yZ9frjqXe9ZDZwlGtcN452nmEaI=;
	b=bTZ0O0aoeErMUTisX6uF8q+5M8FNKKRmDglXRWX6ClVTVCq/k6FA69gDj0v/DXdF5wAa2z
	v8Zi9twXSsVcpvo1EKgB+saDfrGDCelEyeYftRPlojv+lbommLJtKPrJFo87ZhrR8w8jw+
	9t5YcWlif94KNbwGcKTCHP/QQBoxGhI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-UgkXBMZZPsSUewvKmPXVEg-1; Wed, 25 Mar 2026 06:09:05 -0400
X-MC-Unique: UgkXBMZZPsSUewvKmPXVEg-1
X-Mimecast-MFC-AGG-ID: UgkXBMZZPsSUewvKmPXVEg_1774433345
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439a85832c0so2042590f8f.2
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 03:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774433345; cv=none;
        d=google.com; s=arc-20240605;
        b=gTq1MQksBe25XHfvuY2px7onwQ4uNMeiIZgFEBdlbXmqKc5G7G7g7jI0yARo5EiA0P
         1FL4Y2SXzTjHh7mLViG5Y0gZs4NfDUbkIErOKK49tM3DcFz8vJ/o5/J5apkgC8DbW5PV
         CNFLUCnjj132gMQvsQnSspqcBonh+GKYccw0QDe23KvSFxbww0gvxi71wfXxZmilX8xf
         heDPPReD+FQv63NoR/cFzxDmXpv1RE36kCwMMKlKNz9BBA9BnUtTf6+/vW68OWuQhMed
         i2hCaRyoLPmPO1+YCjoyvwT72mo7g3CABh02Rbx4w4BGqGKIu7ZGxzby7GdRDaodhFWx
         aHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pDFhyXF7rlG1aJ4yZ9frjqXe9ZDZwlGtcN452nmEaI=;
        fh=hNxILyYl2lMKKI372gy77Mz9Ze4y5igiahysOnFwtqw=;
        b=ZoymEkCveMhdpLGqRDsvgoPbfryBTUwp3fflVhLf2hWpA5TpdqgMXXEiNcCuMR7zjZ
         BzdkGnz1z+gzLBOFxsMrICN88pmwgIaGrE22qXbXkxmCoYaVDCXLCaQehQzTtQnj/9MU
         ZiysxORrwL2BZspdWbLEtGSWvC3tUT1thD/2N24j5wSIHvUY53WLfhvhjWFy8M8SZhUx
         Br8a2BRwovX4QUnHzzb+inQR0aGfd65cCTJsC6YW3nt+tFKNyPw0XmPdfNdQSxv02mJS
         ix+ZpEDoLFwEwOS2vvSnfQD7JUmZpi32kHFmXSRCFbpldfrC98Um2ncbmfsfQQs1RnAv
         RDfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774433345; x=1775038145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pDFhyXF7rlG1aJ4yZ9frjqXe9ZDZwlGtcN452nmEaI=;
        b=AvDMBoU1gjZQGP/LOAP80IMsCLc1dMxUlmqjBuAh8wHRg1bsDLexb3vN+wxK5a3hqi
         CfmIAZTh+i0jWYBhXYkRWVo70NtU/pppnP8KCBeXERXPuXC3gvCxnGdqxdnUJoT4tXvo
         R/LpZAkIT/M3WCcdQc1WtrFAbqo153Dyybxz4upO+CuHIevJx8NrfbAi26dxrlscluv8
         GvOx4H/ccbABoYmSG/R9mF8WP1V1m7ca2ye/8eEddIjfiqDW1LxgSx8+81G/Aw9pu7xX
         Jp0rQJCcIFgoHLZDJcDTFK9LPi/la/ZZJY6xQ2M8LEp9rJ5bq2pYoTyPtNOJJBp+JrJ5
         +Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433345; x=1775038145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pDFhyXF7rlG1aJ4yZ9frjqXe9ZDZwlGtcN452nmEaI=;
        b=oxUi99INz3GBS9TzGjz6Ci4LXQPNsHqoySizOVcTybvrNWKDg1q8RMOxFI5Fo/m5RV
         Y4iSpLRdDr9F0rPaMMwn1HuE+Ivr3xGyijhz/616F3L4nexR1qBLpot2giBvVIc6r+Us
         ahciwIgnTuXLgpcjkftKsAgvtLvTZbou1Crhy7UJz964lR5aWesFQShhsdpneHj//2Wz
         d+I8Tp45kF620w9GygcWPFUEyuHzOE51/sA8WlgU73B7GT/Cgjo9Z7tqOKs5WMglTPRf
         u2jEOdIYaJhGld2wq45UL7nC+pLWJVLM5qopoKCjaata9Fe55HOyct6yZj1ZvA+xBp16
         Px0g==
X-Forwarded-Encrypted: i=1; AJvYcCXBWNJPUD1UfcaSJGJV01Mo6asAHGFe3HHcqsL7QkVC2imlvJ0zZX3HDU5/jnZRQD/VzMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztFEYgw//lBt3OdMhYy8n01nx9uAL4exuw/jtg5F/4Tdg/poY
	GW4lss3GZwYDvaJKa3OX19FrJtIm1J8kIsW+kdnFwuYUdKEx3XrvH2a+pZxH299oxT1bfiVsC7V
	ZoJSrN3/OLjUOeQ2Pslnt4SlhCjHQOqlTD0KFDkjsfqKsDdmgfQcUqOqOIpI26XP3LVXCT+n7vF
	/52mOFNYt5LDIyx7sh6WivYiFOjyDw
X-Gm-Gg: ATEYQzxS5Otg0Y1J4jWRqwYqgRucSFM+Ukz5u7d8LqOxF3xB6HehBvdU6ob2E1PKlm3
	N5z2MJOQnBmKxB0U58sFCMN+qzYqI/EgWlopo7deySthP0syW0mRVvl7+X2wf+cJlCz58iv23ma
	E38jQNkIe2LkbxqV6KOlvarRIsYf3fnaDma72RWuqv0oJi7GR3NTYqcKCmw/r37nA5PGZ1bCE0A
	wSZNBWTncKlv6zSCcsHSbK2uCxFOJv3Suhio+ahqGH+0JGdaW2hfHdbcA8/Wt3si3BHpOD9Bemu
	NDDE
X-Received: by 2002:a05:6000:26c6:b0:439:beee:43aa with SMTP id ffacd0b85a97d-43b889b2667mr4066817f8f.16.1774433344633;
        Wed, 25 Mar 2026 03:09:04 -0700 (PDT)
X-Received: by 2002:a05:6000:26c6:b0:439:beee:43aa with SMTP id
 ffacd0b85a97d-43b889b2667mr4066692f8f.16.1774433344232; Wed, 25 Mar 2026
 03:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com> <20260321000931.1947084-21-pbonzini@redhat.com>
 <ca466041-18e6-4935-aa0e-8c1501e120df@amd.com> <CABgObfYL5T1K6VUQPjor+G-GjOoKGaGS6rcX0wriOa27ipG51w@mail.gmail.com>
 <e9c64748-7d72-46a9-be95-6003160ec06a@amd.com>
In-Reply-To: <e9c64748-7d72-46a9-be95-6003160ec06a@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 25 Mar 2026 11:08:52 +0100
X-Gm-Features: AQROBzBJhPmaA2X3BNJEjCc7zZ1sL154CopkrTla9-NJkEeHBRUPU_Q3QIBm5b8
Message-ID: <CABgObfYYTCy_gFzQdYsZPB4uL2bpHBrO8U0UDa9J_3Z0moMP4w@mail.gmail.com>
Subject: Re: [PATCH 20/22] KVM: SVM: enable GMET and set it in MMU role
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:40=E2=80=AFAM Nikunj A. Dadhania <nikunj@amd.com=
> wrote:
>
>
>
> On 3/25/2026 2:59 PM, Paolo Bonzini wrote:
> > On Wed, Mar 25, 2026 at 10:26=E2=80=AFAM Nikunj A. Dadhania <nikunj@amd=
.com> wrote:
> >>
> >>
> >>
> >> On 3/21/2026 5:39 AM, Paolo Bonzini wrote:
> >>> @@ -1184,6 +1187,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
> >>>               save->g_pat =3D vcpu->arch.pat;
> >>>               save->cr3 =3D 0;
> >>>       }
> >>> +
> >>> + if (gmet_enabled)
> >>
> >> if (gmet_enabled && guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
> >
> > No, this is the non-nested case (vmcb01) and I'm enabling GMET on
> > purpose for easier testing.
>
> Win11 guest with memory isolation stops booting after this patch. Boots i=
f I pass gmet=3D0.

That would also disable GMET in the Hyper-V nested guest. I'm looking at it=
.

Paolo


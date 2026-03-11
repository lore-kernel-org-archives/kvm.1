Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90931717B
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252326; cv=pass; b=NXIYVWLyqLztNgyu9s9bBxyoWTqQ7mfhyxHmDeLGqIeuOHF6AwEDQkhdyxJAmxlHm5Tjw9iwGoSlo/3J+99HXpZwSmwkWdYnBqr91A6SALNDp7I3j9agPzV1lfO0ttv0zrlHP2Fhfn/ocy023N0aiV/F6Kbv85DFjNIvfBbea3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252326; c=relaxed/simple;
	bh=nNyIc+yYb+TPiBc/ThD0Q9mj47EpjIiZPGpwqhFoPXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRgyGG+6GG2XCBe7ph5Htr1WpKqWFMH73C+DBJn23HrDXTj7GJVB6oz2XjOcasDdtWZz7TVb6tmYGg2mcfz5q4llkGWlo7QYwAYRHCicsjS6SNQYZpYhe6+/BIo1AFaTVLiVWkpg0vQUs0Rubvov+E2hclDY1rYtUGkmXeihUUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2lSFmtC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTOiKqrt; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2lSFmtC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTOiKqrt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773252324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRBMZLTjupZuI1xytEqp4PdUvSeRgmgy/O612/5V5C8=;
	b=C2lSFmtCqlTY26i5w3lEgpX5BlkVMYcf0eKx116FR9/xOliVasbQHp84h24Xb9WQEiM0xX
	b1ikWoTt1i4C2MVNIcZgi1fb6SHoiivu4Ode4ioX1z8YobR4nY+dXuk0YIo0dfKGcSlUJO
	ENSkGxwXEBhz+DHWCmzlKMKAXgAoqC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-X0QnHTMGPkSfW53i1g_-wQ-1; Wed, 11 Mar 2026 14:05:23 -0400
X-MC-Unique: X0QnHTMGPkSfW53i1g_-wQ-1
X-Mimecast-MFC-AGG-ID: X0QnHTMGPkSfW53i1g_-wQ_1773252322
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439b484ee04so876966f8f.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 11:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773252322; cv=none;
        d=google.com; s=arc-20240605;
        b=dVcG7XJDICeJe9xh2/i3PQ7rXpGeljvfBTwrOXi1A9kEtneCsQEFj0LkaN5Ky5g51a
         9SDog5In1XdYj5Tzhxqga9qw8duas0zYcRRvN7UTJPADuY9vn31w1SPyydeyfYfJQGsN
         D9YjJhq7hwxI0YHVqdpvFyJHouG7BAoEkmwWUwFX2VGrF8Y+OtmLtXPpJrLdHrH6QG8t
         pSk130ubTLeeJWF90wUgQU5zWzLUviGtM8UES2OCBzAGEUEms6jJGCI7o6+F8TlgVNcp
         5lpN8kN+7N3ZvgueTkOWNFLNqCkpKZxqtZuUshXkCcqYuLeYZMZ7bHKJCvZLe4UtCkZN
         3IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRBMZLTjupZuI1xytEqp4PdUvSeRgmgy/O612/5V5C8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=ARBfeeltuZCsw7SRPvb063vCvGaZ/+NckpQdumcRJnd8yKb8gTfTaEMZQ5a3Td+wto
         LpbT3UjQe87l8+K8R1+1lbgpa8AwbFKvJCNU23roVjx2CZfOZlJ5DH2Or6Dg+BZhjUW2
         2z5YXzyX9OWLS5OpVf32YRhAfOPQV1bRw4FaKZ28fZ6zu5JDvQBHVBHW3FA8TeC8yJV2
         acPRQAAwDGr7NTwPNmwFNhtU5o+75vlsnTcVmFDu0jx9d8v7cpkgQQ/P5urJl4bj+vja
         HI7tr2JmZf4nhumrycYkPjE2R4m681XEzDHwlwSYteTW+j/pdRCLdWE1esWKjimQEdXi
         YWkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773252322; x=1773857122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRBMZLTjupZuI1xytEqp4PdUvSeRgmgy/O612/5V5C8=;
        b=gTOiKqrtY8gnV/FewDosgyAhOjptM9iV71ijk4p32MnO3nUw1OE3QRs0CqYfi+WTfX
         Sp+7Z2S4PsRyEC+Ed6SnJXFhct6IP8gCPbfxfv3gxNeV7oDTtpQt06Gb2405+vgQ3cP4
         xQ4ogOAiGzJ1C7iF5lqQ029/53tbXfdo5Nbbe5hjadTpon8bNxcwQz/hbiJxRMdDCABy
         0sRKtxg6wMD+kiO8oSGfqGxLzItAf7Hjy19/dYkpjYXfR9zYVQE15PAbCDCqgvCX1pN1
         3gy0ajAsg1V2wMSsCxNeXV7JKpT2hShx4Y1ULFlR2WpTdtrof6yoF9CAWcrISMlfzKY1
         6KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773252322; x=1773857122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRBMZLTjupZuI1xytEqp4PdUvSeRgmgy/O612/5V5C8=;
        b=sFd70N29dE6bfv4K9Re84jNRGzOdHHsFwI1QEKoTlMZ2wBLbeew+Gi9aKaj4WCqvLG
         mRB/GLzsaK8+KOwv4jNra31MfH53ibzHy6o/vI8DTbyCq4G99xregZgQIFjmEiX7j3Um
         B2ylM1yCir9B0MJBN2/3+9Piw+iIs8LQ0a+XLkcB+Kdlfom3lt7ppcK1o0xIudPUoynm
         qmhmJoZH0I401pdpj2Oq8dVWvmRNkvRXXBnuM6L67oZkuECxEUhL3E+DdfaO1AN9GM8o
         a9mSLDflG/n3GjcmwQ8GAV4zYsfYJG/Uk2+c+v7JT9FKhKZ3stG0lCRHCLpgkik2qAHH
         xX4A==
X-Gm-Message-State: AOJu0Yz/hAF/ggM9K7FD1qK0cQs2AeVcd2gRMT92GmeZx2c1j68FPDEp
	Pj7VqfzTZoT7NAwfMwtE8Uw794YRgIUbbLf3hRDKBHG+zvjAiKvcQEEn7Rub77ZoOV1/RusWeYx
	KvLM01VTfk9VPEmwTOCCM9QnrbbWihgKO4NeQeVhuS49B/B5LR6cDwhXxAPT8MPdGsRYqVH+J5W
	JVNrkyeGVkBYytpN1u+DLrni4XR/7g
X-Gm-Gg: ATEYQzxSxCVKXkOSXb5AcgOFWqnVGWoCBelwgG4m3eEpupvhzkq9PcL8e/52aUPw7w6
	hxq4hWVHgWkZJz7vA34Qq2kHVx6mZGeHSTmTbMY0Q0XD2opI8uH1shlXCuIX8f8J5bok68Cd6g9
	vrqs5Gs0WIgSNBd3pVNN/19/r0bOZdEcsoGN8Vz4BjMF3FwCt4FsVrbC4WYDiv5KTiUH0NYag5q
	P+cnzDZLzxC3+6NOlgI3jWlQwINO7gAsOVQggqexgzDIhMi5lJvweiVVjz17iorMhofckAJ+39T
	URSufaM=
X-Received: by 2002:a05:6000:1889:b0:439:d0bd:225a with SMTP id ffacd0b85a97d-439fdf42301mr1260314f8f.7.1773252321985;
        Wed, 11 Mar 2026 11:05:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:439:d0bd:225a with SMTP id
 ffacd0b85a97d-439fdf42301mr1260258f8f.7.1773252321532; Wed, 11 Mar 2026
 11:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305193053.1643463-1-seanjc@google.com> <abCLG4axO2gmpBb-@google.com>
In-Reply-To: <abCLG4axO2gmpBb-@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 19:05:09 +0100
X-Gm-Features: AaiRm52jgVuiwiqaaNNob5M7ojQ1wR-WLBNxXbgBrQ_8Np6AwH5x9XyG65xwssY
Message-ID: <CABgObfYY5GVF6iubP70jmCYj+3cbsYc7DCxiRsPRr=JDbZjQmg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 (and a PPC) fixes for 7.0-rc3+
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Mar 05, 2026, Sean Christopherson wrote:
> >  - Update CR8 write interception when AVIC is (de)activated to fix a bu=
g where
> >    KVM can run with the CR8 intercept in perpetuity.
>
> ...
>
> > Sean Christopherson (4):
> >       KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-=
kernel APIC
> >       KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activ=
ated
>
> The CR8 write patch broke SEV-ES guests.  If you haven't already prepared=
 the
> PULL request for Linus, can you apply the fix directly?

Done. I also took the occasion to rename
KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM because not having a verb was
quite confusing.

More boringly, I changed one of the entries in the tag description like thi=
s:

- Fix cases where CPUID mitigation features were incorrectly marked as
available whenever the kernel used scattered feature words for them.

Paolo

>
> Thanks!
>
> https://lore.kernel.org/all/20260310211841.2552361-2-seanjc@google.com
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C03DDDD4
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330310; cv=pass; b=Nf7MnpiQ2ECU1NurT2v3SdgSQKioD7Qk969SEnwJhhmqbDomctklfjGVb1i1wkVV4D4d3y++EVCULxgcpqLNW8iPpO+aYe+xCgM1GRzlMYfYxdw+pqvbROjcPasB+DUejMAumVPsG9mgz5vDaCkzk8sHpNC3dBcYu+11tJyYhFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330310; c=relaxed/simple;
	bh=R8nbmeOv8Fjlg/MxbWq1dcrfmLGnXG/kKosi+sTqNqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFUUYpoeitCkRaamdJqpVJ6gW4Z39d7QVPJjHo6PAs4D8K/iavoQ9xvTQ/V/+GcpDN4YuTlmt/oizul6tGw6GXS8ZOkwU/PIA6Lx6xgt89GzQDgkxIyPSYZ3nMObDgwwo1LSIJGRUGk9OA48hqi0uP+1dakuwiA8Uz/49w6mrjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebSZJjiM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j3u04PoJ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebSZJjiM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j3u04PoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773330305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpFHt1IhvLhVtZE4n/SNbQXsQhNkDcsZEMPVxCILAMk=;
	b=ebSZJjiM+duyePklCv6QwxpNvwPuluzRpltosAgjBiN/oxASUOxiiE0GtQMbqTnZ5HiqKh
	7nCK1Yc96xYx2bUJi1F2xtqpMz2LLRAmrs44Q/Q9SwXVBmnXZuJ3djR1oMmyhav5vhj+FJ
	k1fAIcUZCoc8UXJTCVX/7UsGTKgJgBk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-JQDVoTjiMnK7rR0DT-9UCA-1; Thu, 12 Mar 2026 11:45:03 -0400
X-MC-Unique: JQDVoTjiMnK7rR0DT-9UCA-1
X-Mimecast-MFC-AGG-ID: JQDVoTjiMnK7rR0DT-9UCA_1773330302
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439c4d71603so1781060f8f.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 08:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773330302; cv=none;
        d=google.com; s=arc-20240605;
        b=PX6WISAfHnrMq4D3HqpSzIKfsAQtmTKpS+YheFkR7VXyc2cdJIebkopi8EMaVAurB1
         T9vrkq5m0UIWbXHSAts3pZeQM1gGcsHdzFBLgQ4N+Se8DEFTVDso6W0u+HAQeBcMnrBI
         dBq1B56+cUxDkIoI5LGGsCuyfcMIeWqMYK6IZtPSRgVFqgcbLF1e61YJDo25E3ifIhj7
         IVlbM9Ke8DCr/OBhxaKUCm5T2KkBe5PqsSx7n1+QNcbSkWQjJ/43Ybc2vSqY8n91r6qu
         xVlE10cf8aqogv3teHoNPwxIaKPhLwzfmGGAq3yZ3w2Bkh37cDtHtdiz7FfqogHoxo2g
         zjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HpFHt1IhvLhVtZE4n/SNbQXsQhNkDcsZEMPVxCILAMk=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=V41k9DJAYeNpZpjIG1+IT4nhJFW6Ecx86q5qiWrj8huiz6+8x+AcMfYr/KFsJbeuq4
         uvJd3ORIp0+A6z5Z70JT9b2DayN40kE8HtbMD+yxdlROcw+DeuLajeWSjN/mnz8/myLN
         3OAefPJHF5FTMMWIxYCqNGEbycvW5dcTjWt/bfIBkxpfNVgYCqCAsIXUnXy5jCFBDLuK
         r5lNxBICTZs6V0hRSgGjwIg4ZS7T2xUvrVVPI6U7/yPVTli8BUcM4FDsvY+7JndycOW2
         Q1CjeXT8ipSXQxsRxYQSdF5qBwnSECSZRVIdTbPkAfZXuCZBs0naOy/HWo7m4TwDvn88
         USjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773330302; x=1773935102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpFHt1IhvLhVtZE4n/SNbQXsQhNkDcsZEMPVxCILAMk=;
        b=j3u04PoJ6kD8Rmc8xkHoAKxuEnz0/25zqvg5J+cQWOve1Mw2jNmMdjwC38VTt9vRUG
         Ec+SAowa/cq5PqIagCMNT02xAUlv/GUpI5kRyb7COltCEn2c8IuyXVEytzspfiiSS9f0
         wuJWJttckjWy0OXRRSZl2mju30D1A3sgZ+GTV5DZrjXHC0JQVXSjxu8gfLzo+9CE1c9w
         I8H6lQ7Cx6NvM2bHCJ0xx++9t7LFDyj7lNeww6w0I2GkSrm2C7nYMTG0ShB4MLW7E/vC
         L918P4xHltY48qnce3OAiGn+iYNcz2f5sC+8FEdnrjSObZtE/abd3D4E00Pm2SCumXKe
         JL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330302; x=1773935102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpFHt1IhvLhVtZE4n/SNbQXsQhNkDcsZEMPVxCILAMk=;
        b=lqNj8jk2AH5KR6MVu8STdiAYtVsYLQK6ZMS2vyZlX4nW597h2yng0GdW5Se+1F+HHu
         9+cNLGmPDcrIp0usA+19RXIYesf8Ek7OO+zBmOejqzG8zPnjDH6w318xJVUPuO/olGSH
         mnlnLkOPGYxQdsBcsh9oE5Ao3fN8vETq3MqA5LhNtKEE5CDc31QtqBbFUxTRMnxvDRoA
         yQTxT3L5UESekOpBTJFBOO9yAiaowuRl1dbxus3aIm/sQnbvv9Hpbn9tR3XLd2HBgO4q
         G1F2OXay0JI0/SNmvsMAeJbbShx2vYMjy+SCYDBjZ3rHJB5nbbhpcq2QrF1jqN/J9LKh
         cyNw==
X-Gm-Message-State: AOJu0YxpHxB7URaHtXIgIcScwbOkVBnwDYoL+odqtDtVylg3lIpSCwtx
	IvthTOOGPygD4wu/LT4Nr+qfwXfNoYO1fRTIAw1VS16qcRYzNDp9gWwfMiWoB93yElZa91hFCUQ
	VV8gvmFcSkIHpsOaEhSe/t/kmpYsRBl7VlrqWPP2pkCdnqG2V9GWPwimzDSBgFQm1negzw2rIbr
	ladXh2TseqgBVxTvW0w/j3NSiHmNpN
X-Gm-Gg: ATEYQzz7nCQjq4JY1gSY7BSuDk5gpbC++HZ53U7l89e0QIVrduJbEV1jwkRrqEDm6G9
	vjk5fWDOWbuMBhZrUw8F19zg6nTmss3hJ81mnOSq/D1nklUpi1ZFQg2XqrpSZTVf0eCU+j8vTnF
	VL8ajAE40Tt39jDdE8MkWmzrsX+3s81lFUmRiF6C7Pt6inNGQpZjf12aVRmxBOiDGJR1+vAAGo4
	ydjc3JMnAhkrHVg1hn1zjzlf0eyRcJOMu8vHRfQh0so1PQR3yV7Ac/W0/z0vbH21z0CwrRUOQuG
	7Bmr
X-Received: by 2002:a05:600c:4343:b0:485:39b9:9680 with SMTP id 5b1f17b1804b1-4854f5b155cmr42051395e9.16.1773330302274;
        Thu, 12 Mar 2026 08:45:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4343:b0:485:39b9:9680 with SMTP id
 5b1f17b1804b1-4854f5b155cmr42051145e9.16.1773330301785; Thu, 12 Mar 2026
 08:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305193053.1643463-1-seanjc@google.com> <abCLG4axO2gmpBb-@google.com>
 <CABgObfYY5GVF6iubP70jmCYj+3cbsYc7DCxiRsPRr=JDbZjQmg@mail.gmail.com> <abLHkWQ7ib8m1KhV@google.com>
In-Reply-To: <abLHkWQ7ib8m1KhV@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Mar 2026 16:44:50 +0100
X-Gm-Features: AaiRm52nfhHVFT5dwaqXwD6l3nzOci0QdaM_EsFGvBxv5fYFl5ZyKbDdsqWmmpc
Message-ID: <CABgObfbnKz5HpwXMW+TjLRgQbuoiga2M-cXJ6no=K8hFsd9MCA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 (and a PPC) fixes for 7.0-rc3+
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Mar 11, 2026, Paolo Bonzini wrote:
> > On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Mar 05, 2026, Sean Christopherson wrote:
> > > >  - Update CR8 write interception when AVIC is (de)activated to fix =
a bug where
> > > >    KVM can run with the CR8 intercept in perpetuity.
> > >
> > > ...
> > >
> > > > Sean Christopherson (4):
> > > >       KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with=
 in-kernel APIC
> > > >       KVM: SVM: Set/clear CR8 write interception when AVIC is (de)a=
ctivated
> > >
> > > The CR8 write patch broke SEV-ES guests.  If you haven't already prep=
ared the
> > > PULL request for Linus, can you apply the fix directly?
> >
> > Done.
>
> No?  I see the pull request in kvm.git, but not the below fix-to-the-fix.

Ah, I had squashed it in directly from the original thread.  I have
now added on top the testcase.

Paolo


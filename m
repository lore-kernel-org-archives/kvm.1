Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA53B1EE4
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360924; cv=pass; b=hR30/PDhRvsod2aOd031Pbxf4KKK1Z5IM3kqiReyUNZY0IQ3htjtwoKSImPc/bv+KuqHlkrebRPNsUn6uAHvPU+NJ38r45mntj3WZaB/lH4eKvL3RfvwoQ6TMNmXPcyyjrBg0VPxklg1l01vxOnaGWnTKIwNWHm08zxa9evXuf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360924; c=relaxed/simple;
	bh=CrRbln77Kyv+OywhjYbw2p4w20REkjlHNanexGR2C04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJwJvcdhsoDoZIKZohFiAtBL0VkZi+RClNfPIAvqkE7alTQr/2PLgrqWbDl2PeFleXKo8VzGWUpsH86RCvrovOle5vjAHedgZepfWTvHUxgwJM3hsYM+XNIFIQYYakg1U4rjbFllShoZkWIV+0JV8+QiQ0mzMb0UTHhvLctKh7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECLICZ9X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=saKECl08; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECLICZ9X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="saKECl08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779360922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwj6kDFxb81RRUVd41tB3m+Y+isZjmM4bjc+QJQlsJ8=;
	b=ECLICZ9XWLpSWmQKpVKM7nrEHIdsZaa2tYNE55/TCKNjLFuW7EC6cpJ3BEpncwYkZ+Q+Zg
	qjEdpMy78eZHwGUgMelG5kUuOvOhLbjOwKIelh9HhpRW4/GP3+dDGHgrZBvptezAYT2Cwk
	fPRqVVpHhme0aXbBN47Nx8DPgasTsgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-wRkXEEg7PqaTMkNAxdxvfw-1; Thu, 21 May 2026 06:55:19 -0400
X-MC-Unique: wRkXEEg7PqaTMkNAxdxvfw-1
X-Mimecast-MFC-AGG-ID: wRkXEEg7PqaTMkNAxdxvfw_1779360918
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ea19f2564so929780f8f.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779360918; cv=none;
        d=google.com; s=arc-20240605;
        b=NQ5PwvH9p9LkQ3SuIkdJJdwKl+5C1fBIPbLqS/3V2bKygKmuessXwXuXdnWahhw5ix
         OJe0xej1y9o+47I3tz7ScbC8cwfru4cDfNiL78jGH6GFIoSxXrYBApFvqFL6Eu3AyXnP
         woVQULfHhCTn2MDIhjg+G2ge180Z3BJjhwj1O/PsQz4wpu2cwlWmiDBPNma0ud6S94xb
         eTtiB17rZOTx1WNdVa5yWRWREWZGk88nGjFO7wrb7N9zoTPPgR6pLouEZvZ1122Ibnxf
         sfuey94fRe+SdBnS6JpNjTYOJmDGnPwN8SLugOzuDL4fbxgE/FyDOHQjuHS6I1GdW7Wj
         +Org==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uwj6kDFxb81RRUVd41tB3m+Y+isZjmM4bjc+QJQlsJ8=;
        fh=SuKINV5t+DuPSb+Acs0TUr5oYzUC/JD/zMyurv7+RLs=;
        b=QpyGBZ2AXS15ryWi89TnNbSsX7+gfSOsI4nadGy0ISkIc7dL1M5uKk6Hgj29TmTgaT
         WZsHFnrGd453zAqf5FCJE4pdq4XaO/CmB1A45VpHeaIAi3Ki3uZo+hLhD0z640DswChV
         1RpSx9P77Kpz371JLxIXBDeyW2he0/ShvE3GpU6P8+9C/RNQVyCRaWC5Z6jJZtxpkB/m
         ygo645WV5OqQ5Y97h+7PnQejBzJFImijWVQZr42dhPvfbAANQS0EUboJYoOrkUH2nGuT
         TtjinggeHooYKDcHnNq7XZJUBacmrUGEJnBj+6T74zAAIVFOjg/b1whUbdN2g8R73HAR
         64tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779360918; x=1779965718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwj6kDFxb81RRUVd41tB3m+Y+isZjmM4bjc+QJQlsJ8=;
        b=saKECl08nUEh2r223HUrAPPYt3nCCI519BWKDVqRjiMiZ4YPk6rcjPoS2KalpzC24q
         0A5rxyzyvcp2oLoLLqBsXlBMFsi70AcKoOFOZmEy6wtCcXUHRbT45gTJRmluk2HDhUC2
         O+PDYWAKPrCv4k9lVpwjYRKTtK63JhLUoy1vEgM7BdmH9TH4uJZsA4RKqOx+wSdWEjnU
         6qUeqPJoWIVhNjkIVmhzQtp1rYYNTwyU0jCd01lIz8+uCNVDeSbvW3pNcF9Piigg6q2n
         6/G5fSEGlDgTBxicgrdyDWdRcJ5G/okvPh7L3xPTxBhmFHRRUvOFCm2mKKQB4Z47UuaS
         lJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360918; x=1779965718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uwj6kDFxb81RRUVd41tB3m+Y+isZjmM4bjc+QJQlsJ8=;
        b=srBgQbTEnB+0CwcSqH+QxjhVFebJmQokJlW/KyEIlViyJ0pt9Fgn6H1ClbIbILd9Qd
         EJbsNYR2CvaKAku/uSX7ufJiDtDsdBLbdO00kfytN3/l6nQ0Sb93UMyue0d1ikgO1aAy
         QhKdN4cnzYDnCGafsihln2XIiaVI+BbSypS1S93eDSfKnU3OD7QgSu3QL2/dJoUhioJs
         d/m58lwo52F5VFZLU/9mAEjhpoOIkk0+1FgV+c/YJOzUJeKtlE60KAWyt4EeY/BBagKn
         3gUNNoamuZDLIUAU47b9z66DRsRnqALrcYNK0jl9+NCBXBKEd/cI3JWVsMMPedMfZqHe
         k/rg==
X-Forwarded-Encrypted: i=1; AFNElJ8f455jJl5pd2f0aoaEubfEKZ6wctEiu9nGyPZUj8E7B7sx4AY0EQUePnMjhL9CLt9/LFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdzRlua+XgzM0LtDEJYjRghuWsgnPpwn+KIp0fOw3biZ3o3vBd
	ZJfHwh6jTP5Rw9oZI2vsBrixi6G/M42K6jfT7pS7cWuQzB/WjlIh6Z95W2lIGokiKFIRICH4S0N
	U/20whERG64KO3Vtguhijz/KW4biDuiqMuIfyZ8lEa8+EmdGvE9DdDdEdGv5Esp16I1i3U4njxO
	rpwdzTNkV6FiaCcLkRpDZzfZh7IX3Y
X-Gm-Gg: Acq92OEJW2K6A7wTbFqXeMxoNtlz9ZgehQGlZBgflB2uB2Cepw31p1qL7ljFO5CJl92
	C6tJxQ657foWm+QEy3TrsBAbs2BmGXen2K9cWd8fPo8z392HE+eDQXdjKPy7VbQSUZiGn6xpr+H
	gZaNbJrVYj9tIGbCUZpzpwF5imOqrhB7dGj3pliUsCHrQ9gK3znw5bkAuBd8+24dM1v60MrR2iz
	3h+SBcoqJHTS9iG2XHilK2xNJk+T+Il73Hhs7bhHKsG819pV6UmX99Wnlcg6dnLAzbgmeQQ9rT5
	02S9TAU=
X-Received: by 2002:a05:6000:4284:b0:437:711c:8754 with SMTP id ffacd0b85a97d-45ea37be805mr4130951f8f.7.1779360917703;
        Thu, 21 May 2026 03:55:17 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-45ea37be805mr4130885f8f.7.1779360917217; Thu, 21 May 2026
 03:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agusSarZr-R_o2xD@google.com> <fbb937ae-62e4-4386-86fb-67d9b85c8fdc@linux.ibm.com>
 <agzHO6EXfAe_40F4@google.com> <942574f6-3959-4ca4-be24-6500b420e422@linux.ibm.com>
In-Reply-To: <942574f6-3959-4ca4-be24-6500b420e422@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 May 2026 12:55:05 +0200
X-Gm-Features: AVHnY4Iy5-HelHkSuOQqlqEoYvg6VeW9fgpIgsmz6u_meiw97K41Rb8fEI-jtt4
Message-ID: <CABgObfZFZSveoEQgMYHeWaFZot6eJgGO1rR2rSXU=cjAPfStZw@mail.gmail.com>
Subject: Re: Sashiko review email for kvm@vger.kernel.org?
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	Alex Williamson <alex@shazbot.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Longfang Liu <liulongfang@huawei.com>, Julian Ruess <julianr@linux.ibm.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Brett Creeley <brett.creeley@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, David Matlack <dmatlack@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Roman Gushchin <kfree@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:33=E2=80=AFAM Janosch Frank <frankja@linux.ibm.c=
om> wrote:
> > Beyond that, I'm struggling to understand why folks are opposed to gett=
ing mails
> > from Sashiko, especially for a list as large as kvm@.  As others pointe=
d out, the
> > volume for kvm@ is already high, and it's trivially easy to create a fi=
lter for
> > mails from sashiko-bot@kernel.org.  I.e. it seems highly unlikely that =
mail from
> > Sashiko will require anyone to significantly rethink and/or rework thei=
r workflow,
> > whereas the web site approach is very disruptive to email-based review,=
 at least
> > for me.
>
> In my mind there's a clear separation between human feedback and
> non-human feedback. So the disruption is something that I prefer. Maybe
> I just haven't yet fully evaluated how much I trust its review in
> contrast to my human coworkers.

I think this is solved by saying there's no need to *answer* Sashiko,
it's treated just like any bot. It should be enough to mention on
v(n+1) what suggestions were taken (or otherwise influenced the code,
for example by adding a new comment to the code); and possibly a
single reply to the cover letter saying "all remaining issues that AI
pointed out are preexisting" (and if there are false positives,
perhap, include a short explanation).

Paolo


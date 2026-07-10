Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED921331A7E
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721312; cv=none; b=c//DW5b/VXMtAhMaBImJLT48YvT0CXbZIdURC6jF/duRBC/8veQSxbe+MSN68e8OMZQPytXlqsNIBZTS4DRL/fRS4CCjEUOtumLW6kkkqo8CXd+1pWSmLcSno3pfGl+O13z+Y40+CHCtiR2KW5Iip7Ntlfx8+3kfThfeuTbjSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721312; c=relaxed/simple;
	bh=gR4mP1S3qImFMhCQcTpLVk2zYNsizzXC9HRkM7W+smw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LjMtqs6uaHDYKx0aB73yxJNYtLW27YUsZnwxE6kbijar2q60QVoczZpsYCo/4tjMzBY/iiE8LWQrpfcdsfnkddLGnm0Q4HuWbLTVW6ogbhX/qqpS+76hgzj5vwOFiDsB+1dWXNesoLesuYlHJZoCe2qRxpzPyqFMAQB06uwCOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdkSJR7K; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdkSJR7K"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88da04b719so1315505a12.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721310; x=1784326110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZHItdN8uCyM0MrdydaYJwZCKgiOLSRUiSaHEQuFVyE=;
        b=gdkSJR7K0mJBXZNL/qY7vr+CJiX5GwKx5hEMXfiZ+PD646YGP89fb+vDz7yB3rK3R+
         0A8mWWRMnNSHZfIvcR8vdbxoH3nATWY52DHJ8XizENOKf08XWe+2DgObkky6lD4wXhEI
         HXuDu3WpgLBXfuMq8DdDtg1gvE9diP3NKfqxUzmFuevkGflUCa8C0ldJ0lecjqgpmE0P
         mDep0QSPmCI+pQ+7qbvP1cPQnDo5lQldlNnXRrRfaGVpUbTjdYJyojXHWEZAZkec2SbK
         YnmBvb+dH37Fkk8jK7dXvW0o3KgynDoIg3a1fDwFWi2eAij+s3J3m+3KKCaT4MnZJJ4l
         wv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721310; x=1784326110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZHItdN8uCyM0MrdydaYJwZCKgiOLSRUiSaHEQuFVyE=;
        b=tFs734siT/xB9jWHESMdbFabLptLIjWetKd6Ee7dv8U8v38fr0SXsINnBjHc2MwNym
         jY70SAj4YyPAJGeuIUR5lKZt8fx/NyNuWOadfRkcDUeCa4ZuPv8akCno3rRw4GERrFeR
         X1Hr0ISDwstw3zOqXhOeRo7iuJGskA5wEJsxKuq7oEUsbfFRTi0RAICVQReKboOMfIiZ
         +ETX5XiFotiNnSFWMrGfUfuxAaKtQI1JIlGXqzAW+lgHeLSHdFjoaO+ECpiOZZBNPm5P
         A/2K6qTSHopffZY5S3+5TGk2mY0zyUAS1uA+AGsanLXdBpRGNUe1wQ4aAxYfzoHqeiC3
         p4+w==
X-Forwarded-Encrypted: i=1; AHgh+RpJEDVBrNaRIFdDCAiH83FRPefLWINDLy9p4o4wX6Rt9SG3ziZHfUjqaar0P3s0VPuYojw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVAot3ar7f2GIKsVYwwgfVNPyhji32Z/qZqomLqMwf5bKYYjBb
	g++9Rlr3Kc9mJUyre/y9TNR6A2u1x0CKelOpY5CbGhFJUpKdlNlrNqpNqM8QXh6ypZ/lK1KlssG
	T/J1PFA==
X-Received: from pjee3.prod.google.com ([2002:a17:90b:5783:b0:380:5fd0:5ef2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc8:b0:37e:2005:6507
 with SMTP id 98e67ed59e1d1-38dc75f4cf5mr642561a91.15.1783721309993; Fri, 10
 Jul 2026 15:08:29 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:08:29 -0700
In-Reply-To: <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-14-seanjc@google.com>
 <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com>
Message-ID: <alFtXYztr_Ic04bb@google.com>
Subject: Re: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to
 prepare() hook
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Pass a GPA instead of a GFN to kvm_arch_gmem_prepare() so that the GFN/GPA
> > can be made optional in the future, i.e. so that guest_memfd can pass
> > INVALID_GPA.  This will allow reworking the hook into a general .convert()
> 
> How about defining a INVALID_GFN instead of using gpa just so
> INVALID_GPA can be passed? The SNP side takes a gfn, so it seems like
> the 2 PAGE_SHIFTs are extra work.

They are, but I am very hesitant to define INVALID_GFN as I'm worried about the
potential for subtle bugs if both INVALID_GPA and INVALID_GFN exist.  E.g. I
almost made a goof in this exact series where I was going to do:

	gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_guest_vmsa_gpa);

	...

	if (gfn == INVALID_GFN)
		return;

Where snp_guest_vmsa_gpa is set to INVALID_GPA.

I suppose we could define INVALID_GFN to gpa_to_gfn(INVALID_GPA), but that feels
weird, and I feel more comfortable having magic invalid values in only one domain.

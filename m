Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B937AA9C
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623574; cv=none; b=rsju5SzVjCX+c5zKzUihf/RXo31e8UWbjHCcqp3Dpv95sMug82DiJabBf3DLLtKGl6xS+B4DUnsCDZ10RaH+ZGckC8hHDmvmc7zNCDWGf5LqAiCGB8PY+tusobZ115atrUb1YZIEIDGDdessCUksHw03jgqSozAiWafYqNSLLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623574; c=relaxed/simple;
	bh=j/6Iu06N1bxUnrcYFaW7Y+bggLuadcmx+PEc0B3682w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y7pL4+V/TT541OgBM+I8skxYsNRKnOrTXAtKAhLuQdfpYxfiVNF2xXNOmOw4plYwrouAUwUleK3KJSa2EPsuIwB6lBoF/ceV/sNklDfSHFINyxBKk4AiNrovix/HST82DKdH8BIPBEAax/G4/hWiEwxZD/FcM/s+lt8/AAzD8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyrLF3o6; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyrLF3o6"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df8484f12cso32910525ad.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790623572; x=1791228372; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNYJ9iXwZtkkaIquLN753az1rX5eiSNS35Ev0JuX/44=;
        b=qyrLF3o6PxiP6qvD1EmYvtyRtqRVU0rRLCAE3bA1XI+c8bGvDEfsQZx85tzdCPfNuK
         Q2avXamuY1f0115kEdrSQj9WMqlCUX8mzeFT4t6K0FcIazIb+wZEyA1012mSKQEkJcLr
         uKCwxal8a05VQNYwZHyQrVTqTPw+8w9FreVOq9BCdQDgnu25N/l15OjrRNwI03/ElWHN
         ZvwyCpXzD+PhRsu+V48aTudU7Qi0+tFM+XQY6B6F6DLVv92pG/p5ILtdv/qRYDq1X54B
         2bRxF1MN8ffx5wdSUc1eWMJ52EPCzxtwL+5DJm4hvzAvyLhAYP4aObC3uKzh9bjdpJKS
         erIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790623572; x=1791228372;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNYJ9iXwZtkkaIquLN753az1rX5eiSNS35Ev0JuX/44=;
        b=tPm3/bTfQ7wTWUl2qUZBUgIzSxxqc+W8DJRBuB2ArH3CBvDJYPXfogIhDsMH68Zqte
         n0qQFjPxUyfQPqKO1XnbhbNv1qk6/my/nCdJ945lAKg+atVDz15po9cqIM9guLO+TeoG
         h6jnJe8JyqZhJ8DXEuqUtqvnWjeXyWl98AzmAGLF70Cu1TvydthY0P6+jA6PSwy969Rr
         hXpSUqmPspf40IHO7gFAJjAcL0OMtv5LrBnb2Y8xT4+t6kotqFX2bFPOZRltXHW3z07I
         zXPDhrND9LiRMqLSik58s2jJgznX7ihm7jdF9oasi0NLktQIo1YHsqjnEcM139xMCGwu
         009w==
X-Forwarded-Encrypted: i=1; AKwUvBwUwtiBSPrI1JON7aq0+ZI2JIr1JbwphPP8mRD4EmKx+4D0LSuc9Gv0idP9l5g31bVc6yk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfZak3DF0/AZcfDzrMzXj4adVIQ2vr3ofhBYZPtx5JTn42Ys3C
	Ufm8BuWxZivP8v+q/TIw2XoiBvgfTYfFpL4cuAueoYlYIWSxRxwCZCSPMnDl0YcVSztSYxEVvRV
	ht9tczg==
X-Received: from plat19.prod.google.com ([2002:a17:902:e1d3:b0:2df:b3e8:1983])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:2dd:c053:82f8
 with SMTP id d9443c01a7336-2df7deb7760mr122583415ad.47.1790623571619; Mon, 28
 Sep 2026 12:26:11 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:26:10 -0700
In-Reply-To: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
Message-ID: <arq_Uu4cXOT5PA5C@google.com>
Subject: Re: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for KVM
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 28, 2026, Steffen Eiden wrote:
> This series switches the KVM-VFIO interface and external consumers over to
> standard file-based reference counting, eliminating all external KVM symbol
> exports.

...

> Steffen Eiden (6):
>       KVM: Introduce file_to_kvm_<arch>() infrastructure
>       KVM: Add file back-pointer to struct kvm
>       KVM: x86: Use file_to_kvm_x86() in SEV
>       KVM/vfio: Use file-based reference counting for KVM
>       KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
>       KVM: Remove unused file_is_kvm

Acked-by: Sean Christopherson <seanjc@google.com>

Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562CB47CC70
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574136; cv=none; b=bFy4g4W1N460rH/qS+X/mhXeyoyf5lpJXym2pTfVCDKuPjyieNKTPvWOkyJq7OoxiNd1OyT1NhqUc3NV/xsCXn1MAhlzLF7YdQPNblfBjEf82PUyrj3KhS71I5Q8q6Q8H6qtbshtsKMR48iLIcN1lgPhwd3Csb+SQSwLtGIT/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574136; c=relaxed/simple;
	bh=Y4KkG8qoKDnLhDQotmibI9+qqH27W+yFT92Z7qXiYu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ek0NooCuhFdTCY5cRBtV76tY4zwpsYQIdzWos643w0S6WEP8fzGRyH4NcUgj7FGJzLEYg9LaOOsyxdf1UpUnSJOj+DVI+UViFqAoMHLkTQZ16KzbU4brS5OWPQULv2+mv13+moMLuPBL62Mn1jsGd9jlsLhNy/WjbDGIT/RyBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUR1JbLO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUR1JbLO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso2351297a91.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574135; x=1778178935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6bC288Bn/GClBvvz+4xeWuMAamNmEszwFvQibk9bYA=;
        b=LUR1JbLOeG8tvGJp612a+2yQRY4m+wu82yK+6bJCCxjPrR3DriA22YNeXu6ZFPqp3V
         SjhEznYtC10XVACEtDCtXaW7MpIaa04ImbL9xPjsgVLqjVKYugXQtZOqXwTY4u0siher
         zybFvIecDbqfJCMlNfM54HMdsNHYpfrC3zycVaw2aVEyQPDK6PTARVUBx/iEa4M7cUcO
         e1Ojzjev/0/ZI7SUsVtmWkxcRJtjYqI3C4hiclZma9phm2BpJ1M3XBdKcqC4WccLBwU5
         mKRC4pfwPr4KXCpwXXtMeeCjguAbl50W0vB6RCCsKd4ewJs+CAxTaPDIvVxMVqU2+P58
         80Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574135; x=1778178935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6bC288Bn/GClBvvz+4xeWuMAamNmEszwFvQibk9bYA=;
        b=NyOu/hl4bKmHwasPaxTiMNd7vuQhZwVkFx3LAKrJMY8imBeR2qdd+7yEZSdwCEN8GS
         nDEGTfiiXGrBj9eKUkPGdw1AtBRJV6GFmtEbNh5zQzYqz7gJIeIoEah4oNhZUBgLPSV4
         6fISsJZlrK7aFIWE9Dfi4/3fH7/u3HSvDNfZLuu70M7Q16/61qWktNW121lL7Y4Khc65
         Pjf8FTlBC0nepNIC6Cf0rwnwY/hwQlkEFFcmzuIjKDru+A5GuUE2eTln1r6S+wVDewcs
         ULMgQjyClP2fKApgHVRnRj5TM8I8jkm9xCi0BAe0i2eUEUCB2M7scqBNtPBtAPe+hg4B
         XKmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fLh1g43HTFTVo6CllkKJVhZhOjPbUvw+EYVj8VeedJ5yx7XbsGqa8+bmOuIBTIx53Rns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzlpP5+G/T7wJihb3OqlE8SRbyX2muyOxHxTnaxltUnUDsbfH
	lVGfTohHIL7VzxfaUxYJX7cxkfGpkmF21zFf6KLncZnLlUDxjD27yfexOnDlDnbmJh4e0nMtvXt
	3eAVX4Q==
X-Received: from pgcy19.prod.google.com ([2002:a63:7d13:0:b0:c79:7778:c050])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3396:b0:3a2:e8f1:b862
 with SMTP id adf61e73a8af0-3a3d20ade27mr3957789637.23.1777574134522; Thu, 30
 Apr 2026 11:35:34 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:35:32 -0700
In-Reply-To: <20260430150747.76749-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-9-pbonzini@redhat.com>
Message-ID: <afOg9NsNlqYwIuiq@google.com>
Subject: Re: [PATCH 08/28] KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> -		if (!ept) {
> +		if (ept) {
> +			rf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> +			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
> +		} else {
>  			/* Faults from kernel mode accesses to user pages */
>  			u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
>  
> -			/* Not really needed: !nx will cause pte.nx to fault */
> -			if (!efer_nx)
> -				ff = 0;
> +			uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> +
> +			if (efer_nx)
> +				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;

Uber nit, probably makes sense to do:

				ff |= (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;

so that the ordering between efer_nx and cr4_smep doesn't matter.

If you end up doing fixup, this patch really should use (u8) instead (u16), and
then convert everything in "KVM: x86/mmu: introduce ACC_READ_MASK".  Doesn't
impact functionality, but it looks odd.

>  			/* Allow supervisor writes if !cr0.wp */
>  			if (!cr0_wp)

Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3823A9BD
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219482; cv=none; b=qsL/prusUF60w7r1Fz4s2sdEpqYkYznX+lNyZCiMPkPKrsrMDYGx4xuKmU1UKNGlKz6QCFjrjmLQSEvCJBxx/7pqurIdSZPhvBAvKBX3d1Onpu1kPtGUQLduKAy87XtNScWH33IGsfgT5nk+Uslf3cKm8TZB9m3c0P9Lhm0FDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219482; c=relaxed/simple;
	bh=MUfdRUEiHnVw1WgnwmaZ1IXlokSHEukC0IVBDks3u6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGuzOdoEjoReAdrf6RQtjC9lhUloRgvPotHKlXh0XTzsu3+3bxiKpv+10M4Emyrm/J4kDVyM9Rj8/WLOADdfDjqxGGz7nVsW4I5cE7PpGNCEDy6fE3S61g0UpFz0737T2YoZrT6BqP5R7G3sSzCjhjQ+8mDjbMc93C/jlAh5gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/C01c7W; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/C01c7W"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8426ed9f24dso691358b3a.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782219480; x=1782824280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUfdRUEiHnVw1WgnwmaZ1IXlokSHEukC0IVBDks3u6w=;
        b=d/C01c7WKBu+YtH97K2uq/uZDmWTHqLKKcwHghTh8WGsYo0vZj+7ZwRjENKq8IkMMh
         5i1zUaVUlXCJf2ItCndt18BMkTVsDcKuCtqgzozUZxAOVow5YtVfZV7u1P+DzkpsZkZ6
         75Lcj/tvMVH1AAj2828XCVr8Ss1Dr+AlAjIO7J4B085p3F6kXCOshnmzew+T2GpEEWMr
         7wUZ2QEUlRKamXBb5C1KV+cKkLaCKeGjGO4IyRwoN5zweHY6s7OWvWT6Cylqf8cEkfwB
         zn603yr8+AyYgN9eRlcC6XkCd5ngUUSi3NkI98fkdAsEI63Dla4Rm8l76Yp4KRkyXUJI
         3ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782219480; x=1782824280;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MUfdRUEiHnVw1WgnwmaZ1IXlokSHEukC0IVBDks3u6w=;
        b=mFctzOu9lBJUdIq91PUaA6bbzMwarLwI1Ve77d1B/Gi3Hr2Xfm/pF4pZqfRTQsRkxf
         zKF+j1W3sAcMNeBulhaphSM9rxrEQaz7iG4p26146IEGC45Pae+3b9oGhkDiQOaffe3t
         YMvNjGvD+tRo+e4dsgaJnWTL9UkjMShd1yiRRkV6tXXwRLOz2hrI5TQVdswYk8Zm3EDO
         pX9m5mktoGwzZP3qw+bi1vTUURZdGtfxZmgSobtSJIf0JbZsfPaPjzXnwIxHTo4nWyaZ
         E8Myk+Kb2sOnIRynlaCLrJoweU6m1IexkNpgpW6amRnBm1DNPcr5dU2s9g5lnglmK2HG
         2hhw==
X-Forwarded-Encrypted: i=1; AHgh+RrIdu7KEuqmK/oJpM0pBfyfz2Qwf18QHJ96OGrlPyL4aA2Plmrd+T1RDPWzTyJ9KfXGU3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzohxtxNJNfbm9A1qBXTwhXWNYWznjWI813IqlyfbPnmLSIlFn
	XwARh0F2Y0jQvLImb8e3hwPHM9oJWilncNRqvKdYoJsuo3I6I8lG3yw5C2KW6PH30u1Fg+juxey
	Prx/NWw==
X-Received: from pfbmb7.prod.google.com ([2002:a05:6a00:7607:b0:845:9e1a:1d94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1394:b0:841:d7f6:7286
 with SMTP id d2e1a72fcca58-84591c68753mr3097217b3a.18.1782219479903; Tue, 23
 Jun 2026 05:57:59 -0700 (PDT)
Date: Tue, 23 Jun 2026 05:57:58 -0700
In-Reply-To: <20260623091556.1500930-4-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623091556.1500930-1-joro@8bytes.org> <20260623091556.1500930-4-joro@8bytes.org>
Message-ID: <ajqC1k1VV23_Xe5F@google.com>
Subject: Re: [PATCH 3/4] KVM: guest_memfd: Add `write` parameter to kvm_gmem_populate()
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026, J=C3=B6rg R=C3=B6del wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
>=20
> The call-path of kvm_gmem_populate() might subsequently write to the
> page provided by user-space. This is used to provide detailed error
> information in case the page population failed.
>=20
> But since kvm_gmem_populate() only acquires a read-only reference to
> the user-space page via get_user_pages_fast(), the error information
> might be written to a read-only page later on.
>=20
> Add a parameter to kvm_gmem_populate() to optionally acquire a
> writeable reference to the source page to make sure page permissions
> can be enforced.

Already fixed, commit f13e90059908 ("KVM: SEV: Pin source page for write wh=
en
adding CPUID data for SNP guest").

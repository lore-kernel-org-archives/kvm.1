Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25923314A98
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005702; cv=pass; b=g29T+0C2VK6EYk3VC3qJN1NLkLJfBEaF/ELeSSHNXWpaXWLXpS4ydCUn7UlNTpjtrmk31WgID8PPkZtKuLacDqNEfN1SzTz8LYO0hdAObMOMZxR6tdQuAiHL/js0dCqllEXKmd+6ObGBwYDn6uI41RhSYTFvlhdk/6JYADFDKKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005702; c=relaxed/simple;
	bh=KDUmXU6pA8170xUyOTNOJFlIuTnys+uoNUwB2I0VqRI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a/VbnPgazXwlnaP+Hth28nGc8hH2mGX/QhUcZGTLEd6oySAMVLxr1KBVkFoEnVDJHidxVB7r9nlku7v1EMGrPVFKGX08lVVGDUAsMOrUX06+MjBmN958dtxfDUk6rxT9n4rj3AUntRQkr3qgzCryU/9uqI6WrtXCpeDV7ouYRBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2O8SCg/; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2O8SCg/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so2285486766b.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780005699; cv=none;
        d=google.com; s=arc-20240605;
        b=NR4E4t1M+EsK5pJFfK+zITwv+iiaJiglAgSMH47fYoTDq3+CG016tfBY3QZ7RlnFoH
         NKUl5eRS9G7qboRY583eldg02A0a2apYR6I5wl4fO9mMzBzEBouFAen/E7ZmqeHneMvc
         eRCFT4JBR27V9q+Vh8YBA47aM/QocB9MlzY6/nfsRbOXFm6DU0tLeMoHrFfFHpspFk9/
         jSVPSyeQiQhOT0nX/utnimCTTnwje8fDOz/kL9CgVhM+9oUlglveBZZKE3VmA4xcQdmz
         N2uh8/QUPWBL0NP6O/7GgrzBBQP6TULUw8E2m1RVw/ACEj6DNXCbBvv8DgYLssfbQ4qV
         +q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=KDUmXU6pA8170xUyOTNOJFlIuTnys+uoNUwB2I0VqRI=;
        fh=AKRwHXT0ImD8iXlF2jOCyR2AlUcXs7g8L8ilm7D8RKA=;
        b=HQu5KLDTT4kOnZQxBBz2myKep3OLEnzV22nNhcoGGRhJ3dWk7L4jZxRBcQ3pzVLDx3
         l2FWBUjdkCrDozfFOFBdyE1TRP646suFAjdI4in5vS9octIBbRrYs4WGArY2mptPZNhk
         CY7KmTZ12ExCHg89T/tqxzFQu+jAaDxeQtEjZabxUkYy5txCEkB1W/X1LMZnP9tgpbU3
         +9Y3YsyNe6VehPKqgyClXjIm9AhejJayzJ4H/rwsIswyU8WZ8v6YkVRKusut8ZnncuoO
         uW9McF1ZFWwCLg3w94h5e2Ax1BZLKHAoVplFS00roHQu6hmB2jfEjixKt5R3z/DOEGXV
         NXjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780005699; x=1780610499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KDUmXU6pA8170xUyOTNOJFlIuTnys+uoNUwB2I0VqRI=;
        b=D2O8SCg/afd+owKuMNO/84ccoAnUpnvT8XHxuD2kBQ6uIlP1+6WPBhGQIbhDLlCNce
         6inYUyBaSGlQrgK9c7v7y2ujQstTgDGWHcc+lLe73NL6qIIK1yCOdEUF13+b4YW/SIFz
         HDT0LSkCVGr67CBdnaXNf2dUkM8RvTlmQCwIbv9OIoyDHYBk0xUEorrfi5dsoBQvLUhX
         IeO86xgze8yiuE4qUVGYSpT9Cp72fhUThiqp1fobi6h7UM8WAN224kl+awDU/yLNuyAd
         3JUqlZtspfkvakkSO9pO+NENVQe2Eu/PNiD+BApup5UkF6JfXqiHjab6GgP1Io2p+RUS
         UXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005699; x=1780610499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KDUmXU6pA8170xUyOTNOJFlIuTnys+uoNUwB2I0VqRI=;
        b=BFqzffe+xbmTNZYbBzItw4CbF9g2Kfj31ozGDBhwNAKqoVJwYoGOXMOCzoqa+aN6i3
         qaCKoSC2fYtgT7RMEwFfLM/BZNpgMDkP8iiqp81Aoy5+tKqVnU3cl1mhYkZW5IfqzqqE
         Z8bjh4Kdk/dh0+p+tH7dqLdvGfm0kGviC0XJWM07dcLNOCkgWuATuhE1J9JU3RHr6hj4
         WGN1QnaiBSDhMUJtQ+TUTZa/CK3XyQxM+dj3+O+eKsmK78AEFO/oaCOS8KDUVKUONl41
         JVMxj99Yy05c6s4Jh7/TxWUt9nEA/Hb1gq0SVObLX0KzSeqkIYkVJarZ+ORE4gTW5t5i
         l/NA==
X-Forwarded-Encrypted: i=1; AFNElJ/tqshNpJpS2c5eRpdkV1gkplceaMkFg3+dgEpltdSb1nSCfnprSJTnKb4fc/RpfhrzZOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagrSpSR+a/wMIu1lj1Hjg5ZvSG20g0H1KMlfmUrUoqU4QeILV
	vfov2N2gqsS4G/AQ7FQpmOO4WTbIDv8KE+V1L67dyyN9LV9nH8DuwIQ3zGYIO6rYuF1qpG5Q4ph
	SZmXWbSVnkEgmrqJIa3JrNWKmj8xjlBM=
X-Gm-Gg: Acq92OFUKoXsoAACrcHVKzRJxUUtyH1hza32wDriOw63sD4r/rmCAC12YozDDjZ+tJ9
	FmQqcugeC+T5O/0LDzGqkk667pxJVDyILQHBfvIbd86G0AgRNKLBChQj4STlBnrJXEBw219DUSF
	MI5Hzp3opypL9Vh89zhD5n8d49Svur9lPjEuKu4xgkcRiOmNhqhNICcGQTCyk60llrrgWXTF1Li
	fDtQsZrwov0+bbry6HrghX1rttBo/EK5WEf/+gt9aNkFopzxwYQ46GQZTB4VwY0EBzPfsAXJ8c5
	ASGFAqge8ACK0KRiKkf0z8PO9zjQNns9X4l7mf3Ulz2iQwPu8kk=
X-Received: by 2002:a17:907:3ea8:b0:be2:11d7:8b05 with SMTP id
 a640c23a62f3a-be973d225cemr56376466b.24.1780005699259; Thu, 28 May 2026
 15:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Thu, 28 May 2026 15:01:27 -0700
X-Gm-Features: AVHnY4I6cWDmc9HAi2Pkjt5rLH3sf-RhVkX5I81aJnp9nA7gfgMJKR79V69XtqQ
Message-ID: <CAKSQd8VrNC5F_7c8SCsuJHe1oFMJBCZc97Ez3ZAUfabUay8ZzA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
To: Jim Mattson <jmattson@google.com>, "Kaplan, David" <David.Kaplan@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
	"ctpence@google.com" <ctpence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> It appears it was a deliberate decision, due in part to the fact that the=
 traditional flow of checking CPL exceptions before intercepts typically ap=
plies to using instructions in an illegal way, but the user is not doing an=
ything illegal here by executing CPUID which is normally a legal instructio=
n at CPL3.
>
> That said, clearly the behavior is different now between the vendors, how=
ever at this point the feedback I got is that our architects want to stick =
with the existing behavior unless there is a strong reason that it is a pro=
blem for SW.

What is a HV expected to do for such a CPUID guest exit?

--
C.

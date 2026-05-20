Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51C13F44E0
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289254; cv=pass; b=daQc3Tgy0z5UdWQWjHhMK5QLocr2Z3LGI67Ov5dP8HnVw36rIzUOzCm89jpvhSwBzdryviXYOGDka7RUetcK4qMubCqcobDlpmJ0wHhBNKtlYtiYStE8GNWIInNmuCFjGeNEESHqj370oUBsK6obRBgVJc5P/E6LLojVFd6x7iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289254; c=relaxed/simple;
	bh=/bLpiLkD8FcUToqib7ndl+nrrPa0NqSgKK5Ijqx+kyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvzGA90BRTIEjinNxrGYc1QIFrWdDYl8aMGLU2jcPI1ezBTknaDmV5n/rLMLZalXIKgZGOwwbf3TU+xmFfA8tIbn4c9B6rc4TcW8Cm6XdjP/SLUpHO9d5Bmps0rivk4YE8L6Li9ShFSjSD18WMc37AWGDc3Gv+cgSMdI3x26lvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7PdHkU/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcIFalq6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7PdHkU/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcIFalq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779289247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiA0ziyBYHubHqkUG1KaQfkj4rnUievkeJGL45S3T0w=;
	b=g7PdHkU/1dDYMZbrt99jf9j+R5bq0hFIwUPApagTXR/5tU3wIpG2k0bvaU346tIsWoW9SF
	OvIcDZ8W5XPUYwKlwCRyn7FDulcj8IHg/8b1tnoDcstn8y5MqnU1grLUSsBa5b0+pvv0zY
	1fIKhh0zSdBq8gMzUa8PEanObtv9wFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-5VeXIFLHOoihO-FTD5cqhA-1; Wed, 20 May 2026 11:00:41 -0400
X-MC-Unique: 5VeXIFLHOoihO-FTD5cqhA-1
X-Mimecast-MFC-AGG-ID: 5VeXIFLHOoihO-FTD5cqhA_1779289240
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a36715dso3223890f8f.2
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 08:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779289240; cv=none;
        d=google.com; s=arc-20240605;
        b=InSaQlECNBrtpYBQD0XZNuvvNFkKQFbgvPDxL+btVWRr2laYPxxz+/nkqNHS/esO6h
         MpStYHbAaIS0nUdgfmYRzAZ07Y2xwFQWdjmJpGR/lN9rXHnH6mS6BNj+9YsBSLSIbBfI
         2qqcxypQ68TY4sD8nF6wqe6qlBkHrvCk/rYO6qaTukE7w8wRgWKpxpFM55Wpzyt90gsx
         bBJzCa+Pe2dliS1GxZAPtVtCza3fnPHm75A6/RRS9eGadJB5igPQ7/Cf9awzt6Vf/3So
         Nvi/rU6TQuRAV2CPjx2FB2LHYehuWX/3XC0tGkEkDORGePk5+NVxqktkIAeDuR0m7Iz1
         S68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QiA0ziyBYHubHqkUG1KaQfkj4rnUievkeJGL45S3T0w=;
        fh=EFHqHlUD6WHpaibWExk4RYBhObCkSCS0HjAb/FKhpE4=;
        b=juX4ywH9iMum7UblTJyjDYs+cLoxUxSgojMcNhjnswQGiPlniS5L2g9+HH3CtRsV9N
         ansoRV02KmUkvhna/iN85KWN5/VJWxByjR6nbCsjGW5DTW198RVB/M1ymw4xUlTiUe1r
         l0VrsPW3lfeF5K9wgzDENC4+NgKjCACbW0eYrwPjQGISOfgBeaeJphbM7BDshd39yi6/
         sagyu0xn9vsTTQk6i6Aurr3OEnpSwdhjeiwmcVUFpCO0cQo7prVYJH/1VGyqE07uWFFU
         1upbDhikEZwTpJp+EM+Xf01LT42ZumX6ZoM/OvAwT+JPL6E6zl6LF51Zfk8gHVlACdKh
         fvfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779289240; x=1779894040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiA0ziyBYHubHqkUG1KaQfkj4rnUievkeJGL45S3T0w=;
        b=TcIFalq6gGDsR40wPkDcPLkSMbNUkKw8e+wlV2htwIySDpvO6w6x0wvl56SweeFxoI
         8dORiAQ+f+czKHLCectzTcz6xT+UCkC7rrOMs0wtD2XEfMtlo3/QtimqovHHY+N/T5W4
         /smFt39Kje8vmathqY4WeZ6iq9rR38SVVTqTY8owaI4puR2v6kJokv3sehGS6ogiZbhU
         oHG+GS9uqA+RvMJCn6QWaiAt7DfkgYJg0vcvzNVdzh2Tb/jUt+UgwTlfBdDmsRomVKAx
         JuAgxKwwL891TzhLsbdoepmC+f3tCgrVC9ZAuw5bmok/iFb4DD2THEc6CCRcpvlk1a/n
         XYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289240; x=1779894040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiA0ziyBYHubHqkUG1KaQfkj4rnUievkeJGL45S3T0w=;
        b=nkgmWC2dRapx6Kxy9DzFqYdHuA1kXqhAobsCim8KWRXNnpMw9V8n9OJT/9RH6xsKbb
         uNexb8fc4gQ3iPTJYSXxg5gIAh2y+08A3BjAcm8oPUeooNPA8QiBni5/kbFTSs/7LkJ5
         9WQNI2GmRKOCej4KIY8NVljdzu1EsrGwLArQE5LucX1FnV3vGpR/HVqvCsOcUoIkEMdB
         yRG/4KhvNZlpPxs2vOFOC41D2UCGxWur8mtyn1LYbjkew3Puk9EkBoe40chXsQwyT1rn
         Rxg+Mnm7aaiku02v9LH51w8Bl5gadHE0ms8J2B88fLriNCNGqdx8w1NUGDv5w7sKYmSI
         dnqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4+6jYMJzAKHLHsrjOhk8bNa8OVfqM2RyAiWvnfWY09ZI63p79ohfD1c0ajhGJNnTu2bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQ+9nSk2W/3nUWNwZbj7azA22Xf0P8bF0eqUTtJA6438J9SVe
	5geyPUYzKApjGrLoejK66fQvFJ6MCV6qYIk9UupNhL55rCwnCshDEIuQvz5sq5RI/YxlXVEXyCb
	eio2jHBRs7ehNYtsor23RoJ0f6HXRK5cmE7bepNKSyEnJJbCYECnBE1sdNi0BPKzq24eAP/ddb+
	w9ZQqbABaXxc4fKovBWljmDd3OAu0t
X-Gm-Gg: Acq92OHztvvpzWw4NstijK7JgO9dCWxonc9WRdS6U1tzwQEtd0QK2KXJ2t/7auBdkyO
	04C4InncXDLPQxz5/epewIu3/Xx8GaJ1Hgi3Ah0cuViPn6+sLuP0nrb7WgkMp7QsQrVTSgpl/P6
	vKxcsa4yU+lJb+1MKT1z2kP6c8wIYmXEq91+ev0sxrTbCbMl/vVtROSK/6fPKg7rMSQEb6+BT4D
	4x43IM7l58sZik1ALuO2z/tFvxVz1ZE6pY1zS0NT7Vov2LHhT8wKZf4PoCkZyI9KeJ2RTuQqvRy
	ypapEQ==
X-Received: by 2002:a05:6000:2485:b0:449:9aee:4581 with SMTP id ffacd0b85a97d-45e5c367692mr41624364f8f.12.1779289240324;
        Wed, 20 May 2026 08:00:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2485:b0:449:9aee:4581 with SMTP id
 ffacd0b85a97d-45e5c367692mr41624293f8f.12.1779289239981; Wed, 20 May 2026
 08:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224014324.1307211-1-chengkev@google.com> <20251224014324.1307211-2-chengkev@google.com>
 <ag3LzpVEPuZvCXAQ@google.com>
In-Reply-To: <ag3LzpVEPuZvCXAQ@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 May 2026 16:59:58 +0200
X-Gm-Features: AVHnY4JIyGWkBTSym5_mT_GnK5chr0whDlb1rrTxUJRXc4gXzIY0Od9h5hoxwTc
Message-ID: <CABgObfYBEPeMLyEyEtAqH+b0vMOcoCPrPmKsJ82D-MReUk0mNQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 1/2] x86/svm: Add missing svm intercepts
To: Sean Christopherson <seanjc@google.com>
Cc: Kevin Cheng <chengkev@google.com>, kvm@vger.kernel.org, yosryahmed@google.com, 
	andrew.jones@linux.dev, thuth@redhat.com, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:58=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Dec 24, 2025, Kevin Cheng wrote:
> > Some intercepts are missing from the KUT svm testing. Add all missing
> > intercepts and reorganize the svm intercept definition/setting/clearing=
.
>
> Please split this up.
>
>  1. Add helpers to set/clear bits.
>  2. Add helpers to save/restore intercepts.
>  3. Reorganize
>  4. Add "missing" intercepts.
>
> Maybe #2 and #3 go together?  But there's _so_ much going on here I genui=
nely
> can't tell.

I agree, splitting all the way can't hurt...

Paolo


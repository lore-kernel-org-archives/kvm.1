Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C73FB07E
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632761; cv=pass; b=PTuojyj9/F+KgEmnTF+RE51JovefP8MFWSfB0K0KX6OKw/lOndp1XSYu9PuGZodErVkF8vtt5gAKqJ2KT9vUDq8SWTml8DJy1Lr7IQqJ3pSlUTHrU4SWUP9QHWjTpmGlljSofunOP1dOwZGoeGdD2UFSKIWMl5y9zvl9ZVj7XxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632761; c=relaxed/simple;
	bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lByUYNFOqbeMje5xvjb3sW2fJlCuYy9Duqjsh+hj1zIvOyoG0GHL1lH5C3DQN47tSImK77l3Qoyn9dBQiNbfRCUa4KUNyUZT+Q2yhJ77+ykyobGrC/4qgZcFceuKR7nFP2l/BVNc4ALIVP+TaaHDWRwbtsVbNaLx3Oh/7Aqvkek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vM1DOUFg; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM1DOUFg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509069a7a7fso40931cf.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 10:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774632759; cv=none;
        d=google.com; s=arc-20240605;
        b=Ie6Y/gWUtl4oDoSDITMRsgdRrsU3XpZcUqSkdk1r7IIrcs5tbLPs44ZuwJYIZ+G6SU
         ogx5OcTBjId2ZE5yXoH/lblZet2LvunhWl3v6JLbCuk17kUAlZCJpoq6kNdhx8r/CYsH
         QkvsDV7iNg2jKlZl1n5HVVrCgTZ3C+T20Ouxkv9+fwzxzDkLa5hgqUcMCB93aD9Ldvkr
         RCoXUfVZJiQX9lbdIW7qADYQw1xizaxlbbIhGyLYS35RPXWUuPfXix0mWC6OlTmQeh1U
         49ZlktR4Z2weudgQhSEh9BtjQtZx36FbudVMy0pRv6JuXlKlqZlq7idPpaAzu49JLecu
         7K0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        fh=4rD5NjIlf3bGyKskcdidnlxLZSd5/e0tdsLg0CjJCu0=;
        b=btcHMixAT576pWumnaNaDsg9YzqeCALhlZ2Hoy16Jb8xpZWpfYwvb4mCzSDt5mMAO4
         PsYlskQiLQf8dcktvrYVJArmXyuQm+wKP2X6iLlkmN42yTMFV05KftekHAyTG1BmIBa5
         24WTMXaSRagfI8BBB25M6l7YJfvd4W7lpoqmFSeYmNn42yMe08WfrWaOYMQi5h/5Ecu3
         e0xFVKRT+wSlalQOUsUlmpsCMUOl11Gv4tMlnfPPzVMZ4opk20PpJc6gAFpLEpys5rfq
         kiU9BjwMafA9+gyHme75TGHBAVO9K1p5wNxf3qoa9y0B5EqtvYO5/NCLIgvlvOYuoqXm
         fLQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774632759; x=1775237559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        b=vM1DOUFgxvUQcPEgb0q3du0IcadHXlhcgmuFmYJBSFYqjoHI6Ok0t15jST7697ES+f
         GVFO/6niFoCnqPPvWA+n/tYB3xBi2mx0oXD3cYBOui/tgLxhLYgP5/JdrP8mbxKXKnbG
         pY28y/YFlRpUInPQ47UUZd9fL/DB64HYyrc7qZBRcLLZeY7M6Pvz6UHQVhNo9zHgJik5
         H9/GeDLUeox+AIWeyv6BDn14XS/3ZtLKThh4zCGXxo+rCWI1QPBCoe1nGzSyfg8ZXsZn
         EjeiRzwCsIvgjUfVa4K7LP2qWArHEFsWPppuPiUyP6jZdg4eDZJ1eDB+u+nYYdOyVqOA
         Hk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774632759; x=1775237559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        b=dIRcL6K1gBtfEfd3UVWAfCKWp1/6pX2owih8QCTMdqTOdXl8HqTkypJTLjr555CzZA
         6XaS3bGa0zt0J0TuQ2FgAiGrPwTSkFiUfZ1dMLIPtj30VJHR4i4XD/iE732SRCIAdrHN
         XUFcabVqR1MX2/WCycbk3I2pQC2gV9n4BnpJAZXhNowwhzkD7klQKnGJlKs81XW7BNIb
         +yqf1CcrfomuYhXKAFnpdV2WOQLH/H86Fn6XAeYWQ3Tcn2Zv1TIsf7JKq6e7eH9gjGBa
         DYo/RWe97dok3IGf//M4uXIpq0pUl6VyzoIz+IG1mE+EcI8s5Z59P+H+aasQ1+fLhO0z
         ZzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsO/UOp0hXvPvd/MkVD2NvCCAr9KQHFAtwHXAy+bEtMJ8Ug4wU7ocuvW7hj3G92a1R8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQE1ajAXIG8GDg5aZ+5cSFD3twu91tHtVv0pKjCh8ZPbkS15g6
	ez27ybmrPD1jQPavNKQ1PwGORaqy3/s0wOWAPvhwo9hIYeZFTAVM3tPlT3ETOjjmXKeAIJWvkM+
	dlQTJMHJjjIhttH6ikHOaKranUMpdHcOKYYx/DTNY
X-Gm-Gg: ATEYQzywqjBIBcH64RA6cX6FHqzHuGtrK+AgkqwtHCxpkod/EVoAe1S+t8Daalvl0Ko
	0bzLju620wouVbVbDgCtYxhH8Nf+QFPYieCDCvzd+RwkgR9ewNkPvqqB+JOubMi4PVwFNJXovJM
	SVOGnS4ngyPILn3aTOzgdpZfawnE3DcpsZBCyZcStclBADMOXvU+v50s04yRyYgy3hdDB8bKGzl
	5shbbtJgERPSCLutzsKEuCFLsH4DK6tjn6N5nHMZEadUzZq4/1CL1efE0GMtb0gJ+yh1Y/QFKR3
	0xr+Y+FA9B92GNLm3ieNo87Ts6Y3iB7z2CUe
X-Received: by 2002:a05:622a:8c05:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-50bb292f320mr200991cf.13.1774632758893; Fri, 27 Mar 2026
 10:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
In-Reply-To: <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 10:32:27 -0700
X-Gm-Features: AQROBzCNRgKBqW9q5PX49UYqB837bDipJe3mVx90Rrm9LZ-wrkWrRewJtwtbwBQ
Message-ID: <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>
> > Three of your patches lack review tags so now it's 65!
>
> Three is now zero, thanks Lorenzo.

I just finished fixups for issues Sashiko flagged. They are pretty
small but important. Testing them right now and running Sashiko
locally. Once done I'll post v6 and will ask Lorenzo to re-review
those specific changes. Sorry Lorenzo, I'll point out the specific
changes I had to make and will try to make it easy for you.
Thanks,
Suren.

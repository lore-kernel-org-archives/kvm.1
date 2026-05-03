Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFD35DA46
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777844855; cv=none; b=aED0jCOzF/gJaPe0vFGXNCmQH8678mdfZr4EHEo9+4/BbRybLVw1S/uXfSIqQcE93B5rOSlf9Is/4T2Nrm4g8CTRocL7rJX2Gi8DgV02itElq1woW5NFmE9IC5iFEKd7T5zYzYl/+DR2wbzn8gkrPm4dqI8ZLT0NVUs95k6QMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777844855; c=relaxed/simple;
	bh=Oy13R2u7bK3vATN8lpRrxP2GJoGzJr1vkAvsAvVpaBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATl4uKwc1n+hV/GrGP3H4N72ja1RH+DdzesBHA+2FZdsUeo9ftIkBSSYg2kIHr2mMnj+IPmaU37MurkNMR2UznL5KG+VF6IsaYNYwj8r7spjUQ2twffdIuVbOoGCkxfwriTybLKmlZkKhbwdVTzFDVaAtcpoJ8I9mgSKU+608d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FbTeOmUo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FbTeOmUo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-678e678970fso4806382a12.2
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777844852; x=1778449652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=coO2RqxQevJoZjvcL2S5BNWRNyr/bQDBKmzTs5CHpyM=;
        b=FbTeOmUo0vz7fLKn9EsLgHuUSLi+J4T/K8BiUTaYKAZ5DcCLSJABLUyJy7A8k66hTZ
         5iYZOIsVUPHjxAfoIB/0N1xxpvpO0fYVeOr49peTmNBOSDM3evYAnNyCrZW/BpObAQoy
         ceOHBKeO3vQhEo5t85z5fTgTKJRFPjBH78VUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777844852; x=1778449652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coO2RqxQevJoZjvcL2S5BNWRNyr/bQDBKmzTs5CHpyM=;
        b=UVh+Ni9k2ENvMkOP5Z+08c01QN651alFdt0jjOv0YOzjbeWb/cJpMImGOQzk8VRCNL
         4Hn2wY99vXFt0bf8Sfnj47OIVz11H9YHcC5nmoDBUONK/6bkrLZrg8Sd3aVngz6h0qa/
         BRogqo+Td/CsiJ01okEwREkeck0J5WHDLk4lSyw6VW5WZ0L4o7FGvFjdFZ9eKZNbMhdN
         ctoG0vtcjJyC9+Oj3oI9oWBoEztLDCjjY0J3TSmcT+8gt8peRncDO1xfEjtOH67xCOlj
         t9u3ccvtPlZ+r5RC+f7F1QGu5+uS45UI5Y8dvuwEROp8KN0abQyXlNzKjbGQ9TkL6gTi
         E8Ew==
X-Forwarded-Encrypted: i=1; AFNElJ+TNmzCzoth6UXZgTV+iKcy/+S/MqdwHytdBDYlwSej+3J6VotqAnEJ7V7ayBhIFaarct0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0fMUtMkOtiPrcuOu3X7HVbKyNt9TUf+AIGqcHWt9QUTKxQbP
	s330RtsDjJh/Von3Y4AOxbQsRcIPEO2ZLvA6eTTfu2X4DQsyZn1hDIhZM3K6uKihBBL+RH+lE7j
	3tqmm/W/Pb8rmfY/ZIA/TsQ1mHMpFD/Zmg6o8uHdG9zjQ4L3RI6Ts7EIhh3nYrHg=
X-Gm-Gg: AeBDietJEckKG94NkY4C37AJsxO24ebBLSZdWcTb7rvTOIh3al3LEDBbiG/iyz13T/Z
	mO++1VGatAjsezzrNEUM5LZ3bI+zQFXXIO1PD75GA+2ztX1Bni9jdJuUovKwpF3YOoTY8BgXjqu
	pLqQmMMKHhPhdE0PM8AJM70MEYKeHax3D9KG+CNWO2DqoAPJhK0RcatNxlCp4mP0X1ZRgPY8RAi
	XtOiQ3G3tTW67qwOhmpWus+LHl56byu8R/PEbSIPxIJjGC+AhF2ZLMZ2rIFxNZYTng/Lr5vIjq5
	lWUoARcPBsR88D0Y/nmqakgOuyCIJObC5QUj8hABeBIToSURw1xgXk0GFilf4AiNrcK8ve5Mv0Q
	923hCNfnoiN5HfYhnoxPJ70wdjVJ41NWVz5xXMKrbmVQBkTAub3tChINCpLf697XrU2XAL+zhYX
	sc2gsP/v2uZ7PDPVaVQZ4uOcOVfDIA749jsMimOXZAVEtNPzuS0Po9+pxAySaoi/O4b9NgxVhvJ
	YKicd5A12M=
X-Received: by 2002:a17:906:f595:b0:b9c:4fa:9141 with SMTP id a640c23a62f3a-bbff8dc777amr379574066b.9.1777844852214;
        Sun, 03 May 2026 14:47:32 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6a64c66csm337720666b.21.2026.05.03.14.47.31
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 14:47:32 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so4407933a12.1
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 14:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GDOkK2wRBROi0RwYXkjGKgNbU1pMZzzERMWxVttRChP2UR+3blHt5bA2oobXhpnbtX4Y=@vger.kernel.org
X-Received: by 2002:aa7:c707:0:b0:66c:17d5:c18f with SMTP id
 4fb4d7f45d1cf-67c1aab2f5fmr2292390a12.21.1777844851428; Sun, 03 May 2026
 14:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503212815.127436-1-pbonzini@redhat.com>
In-Reply-To: <20260503212815.127436-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 May 2026 14:47:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYdZRrGas5CRytYGK1JBe-MXA9gJx5sQ2EJAHGopOYDA@mail.gmail.com>
X-Gm-Features: AVHnY4JJhSsTKNUUAwiq198h5xV0KOicxk8okl2-COYfHf2M5940L6WtXaM7NOs
Message-ID: <CAHk-=whYdZRrGas5CRytYGK1JBe-MXA9gJx5sQ2EJAHGopOYDA@mail.gmail.com>
Subject: Re: [GIT PULL] Last minute KVM x86 fixes for Linux 7.1-rc2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Sun, 3 May 2026 at 14:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> If it's too late, then it'll be for -rc3.

Well, it came in 7 minutes after I had locally tagged -rc2 and was in
the middle of writing the announcement email, so it *just* missed the
cut-off.

            Linus

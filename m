Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26B2DEA68
	for <kvm@vger.kernel.org>; Sat, 20 Jun 2026 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934037; cv=pass; b=ro8jPmN+F98lWAJJk1WLEQmqWiKs9ih+RwAzLdn6+mp7PD9B10nYxKobjCFcqTJVzQBhOJMle+u9CQ+EyGzl5Chjfj5QwGB3MtcfzuVzb1Z4TWHG+FnM/xk0OY64TeeO/q/tL/w7EfDMg75ExApAiJR9o6OD/QoSj4XigpObWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934037; c=relaxed/simple;
	bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thByVjZr+sq4/Cs9fvBiwVkmdVuFsrqhgdJlW6+LecpUakWl0pHQei/p3juO0apWeePGvi7H4vkWD70g5J6KvHKE7/t0BJzklBTqhAe8cr+at9hE2Ky4YHHCIqbRsiiX7c6zmXFJZn3JII++gzYWM7d3nOv74LdEGwtKrHmqh44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjibknvF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBs4L9WA; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjibknvF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBs4L9WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781934035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
	b=KjibknvFo4/4z1xCk5FSSqjxvM12B/2r4X9mkJTbdZFRHvx8JWBj4KG4A1thr6Rffc1rE+
	9AZbtkllrEUJRaCu0stw3O5qoRRVVphYnd/5TTjiVfJf1VsEiQE/uF7ATISFQlGNRxM6Zl
	tgIBCJqTq3lCSsDYIrIh23UCzMegL90=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-CmLNR0QZOlWScdqczES1_A-1; Sat, 20 Jun 2026 01:40:33 -0400
X-MC-Unique: CmLNR0QZOlWScdqczES1_A-1
X-Mimecast-MFC-AGG-ID: CmLNR0QZOlWScdqczES1_A_1781934032
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso20655485e9.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 22:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781934032; cv=none;
        d=google.com; s=arc-20240605;
        b=UrIjS5hXQ+xpXzQ/kzVsg1npljF5MyOs5CxQA11+iyG/9NXWWnILcO/kzPcPEoIm+G
         6gomRX0B39Q8zBj1N+5VOf4Oi6Ez6PNJd7wz7pigtIC823x1uFFwWeM/jasfOel8f7zl
         BE3DPmqYjmOTCSEh3zbrn8j/BHjmaUJoMSusjPl+BMks6q4orEbmwtp0rO+Ugw9IEE3o
         dnR6H5RmitIoRR3rVArs7FN1dSegi3onL4mlFR2iaz9rDp8papczv1sfmU+Kfyir8yvI
         2jlA/D4y3ROh0sz3Sb0x6ptVD/QxcSroxS5ks1oAHZRuMDhmtDo5gj9Xxx7/e2uPFg9i
         6rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
        fh=3UX48qOLTv8rEUF1BLbBsFL4AXQ44GHyVHDlYPqtRYI=;
        b=eCqcZxe3fqXoGM1yZPGMOzORp8cwheHtibQRss6KlJ+hJT8bEfuWzOzirlRlUUjNmd
         7w7VR7SjfUc3Yzxa+XtU4S/DNEDHG/PRh6nrbTG44w7MSNFiEOPnNmzYZsiHuPQO8jOz
         RhRuTu/MX8JaM0ulWRd72d+b+3MZIhXS0hSZQmUptEB7HdeRhfZ8T6cg+3wFvi6rAT8g
         EXwUrDrYHXk1CkLG1FnpuZPFR5JAuAZx2HOmVuI2M6cU/Cq3vYGYepY87+0B8T6tqgL3
         J0Dfs9bxOnF4G7Dgc1Nr3jhp40ayKP5b3pQqyXCdIItWz4K5McDhgamLskiRX98KGcw+
         u5aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781934032; x=1782538832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
        b=gBs4L9WAjY67fM9XLZT2WkkwmBtCXEmznn7Y2DUPlbjOUsspqFuiUEfxS+occMv/8h
         kciRl78Uy9i1rCugWq65m3sv1Y7mwNzZNVIG/MS5AYRoiNEfMLEx+zTVauTaWS/SYMaz
         DOcvUsLWMvC2BNKTs6SkNsXQTu1ugBWGiDyueFziEb8e4pfhJS5sG0XV1MiNqg2gkLk3
         A7i8LedrvZk6ELL62INYp0Qa9berGsLXUvxpdZkCGN9zv05bwFtuKVKp5iuux8cecYog
         INO59fxzjMw1PtcBYNlNVkwuFrjmauetQExL6DIEjmL9hTdy+nrcI4ncpr99D+kiTHTV
         DTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781934032; x=1782538832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
        b=jLCvATavl03FXL5iz0SDoj7bRr7QAoARVs67o96Ud7vusqZ/ZADCyU3vLJ8TXbJmkl
         JJ1FPWmGHf9LqK62ZT8Gz0mt6YHrt2PYc4TbnY4d1wRAid5jNN1OKHX7h6WO9Qtr2lCK
         +aSP+jcyvN5j5p+GQK3XzgPn1AK7jhknxIhZ//L+8C42Vl7n/r29cBBC21rlvLEacf9/
         kK/Suqvx6LLNlVNq0ZwzU6QRL6vaIS8EkteiGlqsnwoU8UV1Z2b1ihGWZQRAXVjkGaBJ
         4CuGAM3ahlAIs8K6TdgYXo1zwZQsETur/XLzjioyY4tCrHao7pzUOPEWfjMnmLWw5Jrg
         FHUw==
X-Forwarded-Encrypted: i=1; AFNElJ/u7qbE9saes4OlWY5DymQbjFbvEqw+1xLV9tbBrP+iRRwOUcmv77E57QfnW/1UQ7ygOZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRTvSXL1QwRi+N6h0C34eijTqodOt7l1nXGA+3xeS4D78yEBL
	psvLhjwXtugZaW24y++VJgAUbRqJrnLUHT8LeXDyfzgl05pyqPZ2LiSuttlMUb+2CBLfq3QpVyM
	pPPqOC6Fb1S64t68QEQBX8AxrYflmOL1pYIcovZlTIg952kI098q756Kp5iYq1Hamofd03tHup9
	A3woJVfZIVt4ccNhEDGJsxAhh88clI
X-Gm-Gg: AfdE7cmu3tLJ9tYP+m930+87l9f5LI56Im7St+l97z3AdHwZdqqu1/5ZjddzaiZQcCX
	UTnjG3NP5T1aRYewDv1b+txrDOKJ+wXVN3grvL99BcBeJjBk9/yjOVxCtLC0n8jU3vpAYmUKRQI
	QvperkLEqUWl7RM3cxPijvkUBUPGGp7bnfaPFFoteL1rgFGkuH1Qkqrc/ZavzAk15SPKzP3IFFg
	SgVnG1qL3NPxk0+be2wHYs297HmDU+ygqMYbRfMO8SIcH/4a7z4/5oGRdVbuc1xqMn+LU6f
X-Received: by 2002:a05:600c:5020:b0:490:d946:47cf with SMTP id 5b1f17b1804b1-4923ef47d08mr108763505e9.4.1781934032092;
        Fri, 19 Jun 2026 22:40:32 -0700 (PDT)
X-Received: by 2002:a05:600c:5020:b0:490:d946:47cf with SMTP id
 5b1f17b1804b1-4923ef47d08mr108763315e9.4.1781934031793; Fri, 19 Jun 2026
 22:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503201029.106481-1-pbonzini@redhat.com> <62bedd23-a9d8-4c05-bf39-662c2d37b793@redhat.com>
 <ahlQQlD1ygfiQ3bG@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
In-Reply-To: <ahlQQlD1ygfiQ3bG@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 20 Jun 2026 07:40:18 +0200
X-Gm-Features: AVVi8Cc9pgh_rugpxF92QHP0_KXWWdqXna6GpieKRqAEmkG8WgK-gTKAo9E9NdU
Message-ID: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
Subject: Re: stable backports for "KVM: x86: Fix shadow paging use-after-free
 due to unexpected GFN"
To: Bjoern Doebel <doebel@amazon.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Alexander Bulekov <bkov@amazon.com>, 
	Fred Griffoul <fgriffo@amazon.co.uk>, stable@vger.kernel.org, zcgao@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 10:39=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> w=
rote:
>
> Hi Paolo,
>
> On Tue, May 05, 2026 at 12:13:34PM +0200, Paolo Bonzini wrote:
> > I'll get to testing and sending them out, but it will take a while; if
> > anybody wants to help testing, I can provide my tentative patches.
>
> took us a while, but if you are still looking for help, my friend Nathan
> and I would volunteer to test these in the context of Amazon Linux.

Thanks,

I placed everything in the linux-5.10.y and linux-5.15.y branches of
https://git.kernel.org/pub/scm/virt/kvm/kvm.git, adding also a couple
more issues that were fixed in the last merge window.

Paolo


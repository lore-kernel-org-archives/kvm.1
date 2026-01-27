Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071623A9B0
	for <kvm@vger.kernel.org>; Tue, 27 Jan 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502907; cv=pass; b=l+FuyyDa38YzvWfShGjWoZDL+xGaE/bzrb1zQrT8vfKdI1CDjnpGqA854SJFf21I1eLBcn3eK7qIAypNY4vAi1c0rOn1bIiwJPBeX53RW+AKeUoadIhGDPWuDCUdfpX8ET9fskIIlICbzy1vzGO6fXmYKoLPx7RrU/GmsiI1PD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502907; c=relaxed/simple;
	bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APCAswJy/cLl3AZbonvhGHue2sFNONGYiQy7S1fAxVy86pHZVQRDhcXSWVCoDhOUt1JDLDsr5dHR2MclnKomntiCH3wgd4s9ZKVUKyNIRx/7j/AVWqL8yCiPeGVipLZPGA1wm5Nehw58nK/U5oZj+E8HaWBWOGFAi+WJUY/+y7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1QiPS9X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mL/m+IYW; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1QiPS9X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mL/m+IYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769502905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
	b=O1QiPS9XQMQJLfapnsEMO8QQExvnzmwADNDlYIXsiqWaC30TA2AfZWK5i/G953JUuDmlPX
	yTSAqsTWRZ9KNEMn/ZoaeewGNVIHKwQsuONrv5TtXvfKZd3THN56eR6bClQzjlSsXKfzRP
	qN61g3ubms32Za9xam5svTxGD3ZDjRw=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-7qcfaelzPomJJ0wk-ML8-A-1; Tue, 27 Jan 2026 03:35:03 -0500
X-MC-Unique: 7qcfaelzPomJJ0wk-ML8-A-1
X-Mimecast-MFC-AGG-ID: 7qcfaelzPomJJ0wk-ML8-A_1769502903
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6446c91addfso8119113d50.3
        for <kvm@vger.kernel.org>; Tue, 27 Jan 2026 00:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769502903; cv=none;
        d=google.com; s=arc-20240605;
        b=K+mjeWK1zDYerdtqf+Ei/hBUcqgZk6LKUlKus/OMywWqPV1O+QsF8oiolfOp26QcO+
         BWe1khzY14s/3k9H0PFCI/X1wo4i6kLBtUToI+NeBVLLJgCgquhdmms2Jr9h/Da4lTOa
         G6Hz1w7LWoc5cBsc8Fd8x4ZPomKUfZ5BiQrRUvTWfA853WGLiMW28W9y/yQHqGEBv7d4
         svN+OQXx/+PL1Xq6VnxnDXzCjzH0Lz5XIhYTwqwX4qZbdEuhNcrXDBp4Of6IDwWMYxic
         sDYY1DYL+2l7j7ONJfRBf4kqzaOKYItxGe48hPXCpDrk7GCMDfu2JlmUIliCQQJH/GCa
         x9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
        fh=igOtuWTPs9d9njzQnkY2CQk/TVdBLrjYfXNGVLNoZ1k=;
        b=ZNyJd6ARZLHBWg+ImbrTT37IAIbtSDWcA+NBlaSbK218HYHGU7CCqiz0q8kwfHpW/2
         lY++ztN5PAy5bdeQt7Z2EBHmJ/YTlxKJAl7uCmzEte1KT570PPdCtl3ptcyomPP676Y5
         7XUHS9E2a20QwLYXS/1BrfId09MA+h8J8+D+hgfNfHekPEJoQGCTL9PXaqOEk+pGj+EO
         RJI7nLTOs0ts+7+rqRaLr0jgFyJ4k3xKk2wlK/zRnRozm7VytpnfWlnv+6QAINLj+9zv
         mwIXSBSIrXw/NTlBDFn+Sfkf+qpYac0T9Mo2W4UYIhZ5nzOkVZY8p32U6prjSYafSBLf
         u7jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769502903; x=1770107703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
        b=mL/m+IYWbf/bsSDBS+DlO+7p5m92U0tsmQP8muz2n/fhiXMSBdYXOEhMpUULM3nPuK
         6X8V6ppZpr4Sov0KLTBr1mfs9TXNqLeloqKVANPCa2bmu9dB74iwFokgdnIUmcxRZjcI
         WAM9PXvSXsGbGCgSwJReFT8GHnjW7tapPE08DNl1TLE2/p6sgkRIVx59KccnomFvLphp
         KoIiD98MS8+xTvMPo2K0CVdwFpxbYXubYnJgsqd7kOHKFS6xHa2E79Cu7tb5CCfWFE/Q
         yalTBX/4CGDZtWjWtpN7j7uRu3Cp+c2XaimSbzio//dIeUim3MD5REUkEWOJaIBazf7W
         QQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502903; x=1770107703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
        b=ROoouPXxlmbvlkVKhwq1XeQDmr85yHZQD0qysjbqwFkpODvnFiawQTKZ5yE2qUuD15
         mJkY4p/pNxTwjW6I1BG9V8VR/cumzwlfLgiaEb4qelv6fZhrAS8nBunUhFTuHrM/zWyp
         CkpjKnH9lSbcKfGKrSodN3JA6AeGydUgy4iKWPHVY3gzoqs3Eb8HnTdXomFQnY7Rmm/G
         VrwS5vn9APbeTmk8P2B3kphgRcpBIbVZhlJNHGTAHOOHyVLFhlmaVWtnyq6DwRg+LwDz
         cBg9V7OMAm7xbBMAm3dDSP6PCWLh0dVo5Wda19SJia4hASd8P9hwAaXOTupTvkMvUYcA
         Vo+w==
X-Forwarded-Encrypted: i=1; AJvYcCXB6mFu6Z9fy/YiIFya1tM6c89wjY6jzg8aNRfcGSCHDOXnWdG2aX3gooGVN2y/qtemCD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqBl5p0XaCGCjostchqXTQ+lUkAquwu/phFOHnYWNTFi5O8Dm
	uMShyqLd//QIHvvPOmOj9U6rd7lN3xvvluQekSL3XbjDx8kG0y4PyzMl6xDwjvmFd+EB79x55GY
	iiw9V4SBpUgDx99RPh1vlSoDdQO4x7GcDigXPu4ZsF2/jSQrj0/l7+ie1RZstTb9ARmfT8JYP9s
	ZGl62CxJk9wfx97CYbj+50BKQgI6we
X-Gm-Gg: AZuq6aLSrK9uCLMHkvAUq9dvUdRqDUxtWCp5/CVdMkqa9/AWNL/NPEEmXVqWnMIqfYz
	WJA4AglVm6B96pe+lggNOyLY4a9SX2Z/x+ceY94NODqA1tD61Cp3PK552oOHa4Wqcz5tRLj/Koo
	5E3QXcKlnEitx6yZwFnQq3tTBhQ5+Wi6Qrfm1mH0Tk301Yt1qhev25UjrO8GV/9VVr
X-Received: by 2002:a05:690e:bcf:b0:644:43f7:11aa with SMTP id 956f58d0204a3-6498fbd599bmr495572d50.13.1769502902744;
        Tue, 27 Jan 2026 00:35:02 -0800 (PST)
X-Received: by 2002:a05:690e:bcf:b0:644:43f7:11aa with SMTP id
 956f58d0204a3-6498fbd599bmr495519d50.13.1769502901431; Tue, 27 Jan 2026
 00:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com> <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com> <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com> <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org> <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
In-Reply-To: <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 27 Jan 2026 09:34:48 +0100
X-Gm-Features: AZwV_QhI0P3cRWPsJjKXrEZADOuDplxIF_8okSx2j0TBYh6xtcOwzzZxaSgroPQ
Message-ID: <CAGxU2F4K5mAhwKSLkCk+f17=1FA51WG_XEzhSr_hxNKJTAGi3Q@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
	Pierrick Bouvier <pierrick.bouvier@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
	Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alex Bennee <alex.bennee@linaro.org>, 
	John Levon <john.levon@nutanix.com>, Thanos Makatos <thanos.makatos@nutanix.com>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 at 23:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Hi Marc-Andr=C3=A9,
> I would like to submit QEMU's GSoC application in the next day or two.
> A minimum of 4 project ideas is mentioned in the latest guidelines
> from Google and we're currently at 3 ideas. Do you want to update the
> project idea based on the feedback so we can add it to the list?
> https://wiki.qemu.org/Internships/ProjectIdeas/mkosiTestAssets

Hi Stefan,
FYI we are going to submit 2 projects for SVSM and 1 for rust-vmm
(virtio-rtc device) soon.

Sorry for the delay,
Stefano


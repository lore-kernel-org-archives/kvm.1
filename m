Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA03CBE8F
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652066; cv=pass; b=IoIwUm+QpCzkDFdpD8QfPxCWFyCc92bhwZEmeOeEGFJFKkQGtbTQrN42vF7lMuMQhxqVJ5uUlV2/+1n9MDiNFr3u7Mk8MJncxzTgFGk5M2AspOifHnMfCUr6B3/Ejt1J6UCWmDdm+ZXGzhSgAYsfF3jLcEfGvAOPqHT+YOQRlEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652066; c=relaxed/simple;
	bh=qO6qLQCq8xrnlfLNLJEVsXfC/7lRKwr6FvDujx9vSzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xa6VgpL6d1+amFptt1tFQSFXF4UXDnhYTJd3fbhtO4eE/JzM1IOtCj/4djtxIacxTYiR1pCehVpwgaPsXwEdynLmgPYvsEC5ln8Y66XOj4xl1sQz7S1Uj6Ki67NXBSF29qshRqChJ9J9d4iHs5GDoVjTc9E9n0mCnYEWm+vEYaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YK7oRFOl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qXnIfeVw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK7oRFOl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qXnIfeVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778652064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
	b=YK7oRFOldAjRqwKdUHwm36iy+D6DAo69wHKZbpnuGdB9MBU36hAEaj8uL6i2y7w/m7xGcZ
	zbnS0G50Rf6s4Ynw+ZFXaW6HtQKJu5ELmPg3gBjK574gLNwHZ6R+0CIcn+Lu6ALJ+X4nty
	dY46ODFq4NbJ47hcTY3o2QdLsBVhn/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-TmHi7TiQM1y0HaoXQ7Pflw-1; Wed, 13 May 2026 02:00:59 -0400
X-MC-Unique: TmHi7TiQM1y0HaoXQ7Pflw-1
X-Mimecast-MFC-AGG-ID: TmHi7TiQM1y0HaoXQ7Pflw_1778652057
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-458e7004f63so2865878f8f.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 23:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778652057; cv=none;
        d=google.com; s=arc-20240605;
        b=jtPnMT5+0mZDIa58srMgp4KkDLBWuaEjWN0yWKJk5MegZWpXXq8q2Sfu2Ps4Jsj+z5
         GiKFN6dv5F7WGNvEPL1Y0YWGzq72fLLE2JMUs7WXtIClceu1J6pEj5i+ll5hlmYYoliE
         /UlixBSgsWULSR6VhsXMFTemHfHCMBrSmFWjgOUQWfaVN3rmaVGBpH6SmNOh+pYb6nBb
         B3J9vXKJV3UnhFmvu0tAq76AETZEComndptyY/BZBm37AiioI1lxUsIM+0gAwOmIPPiw
         WPe8ZC7sTnOGAUcY9r9LK17W+6u8QdZMpCOYfIIWC/y1T0yzcYH6lGUNnkpOaBuqvT5O
         +bNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
        fh=clqpoeq9vDUnKreaaRbrhyAVA1eSfkitUqDB+cNZsgI=;
        b=i2F1gezqW9h6OFxybjBMvpyiKyrcMqMKCpJ6W9JmY69l0zIQMEmFpCI8b10QUtrRbF
         HVDv4x+AiaLZvrbs9LOUYKYsNGajoSw1xlnnM/D2iQHduajj00hN9neq5mvRoWcemxkd
         p4RiQ8NgjIH133za2/OpTPdO6B1nihAueZ0S2Dzwb/WAx7TNQBk9YW+FzVw3CmbQIVT+
         WUlKIJGZxl6iVGiddFdcAtcdom/nVDxtQEV01tg7OLh2NPtYFvSm/LLpM9FB/SLftkKt
         /zS11GoBqXqbcgwIiQGTQq9Erju2U9sEgLsSMd0fe77iA2xGRUknmx1zDsvd0a4MeJEu
         dQAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778652057; x=1779256857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
        b=qXnIfeVwoE8UmKTin4NPjEHXvzJV6nPUvaWuI64NLzp0L0YuTXwmuItUJXW0DUiPGU
         jZUjcPrT7wh60f23oyqcwGpQssjkk+dEP7NEhuhUakpIe+yLZh5Dt0z8LHl+hcyfSMKK
         AXsbnnrUKIBg0Cj2m/K5AS62Go1cRy39QtsXPJ1GVB2CqV69ergE3L5b4n7xp7Uvpbc7
         58ZJ+k7JDLeXCJf63aoZ5LKdUM6IM8UtyVpbwQH9mwe9RqNdrJ/s1tIm+lreaJioDL23
         bL4qbxQGOqdoRUkt6LfYeeJnh0g38T8/6pVkaCxbLcn22k0JxV/wV6vZtWdPlH/ghPzH
         ZbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778652057; x=1779256857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
        b=DSVLajxG2Yq5Z5iblVZSKq+l3ad89Sjo/wdhfLaUX+lp53dvZxPx/Tp2OrJZrW9VNC
         4fsXbr5/DjT8+e31V9eHmzFHVoOI9OSC793jgIkwpLWSDmDu5fAxLZkJa/8qS1xlNNvI
         f86RkogOxaPF9ipQVKbtfzMDDgr4KrefG/vkCBKuE3WDEFixfKwpwGI4U+i9PArdmJbp
         SqDK04lRkYVY/+UyLROekQ4a8A4MLfeuwFa47TlVs2KEgi4zJMCzAE3wmKfDM1jMI5eV
         Ev2iLHitqKd2Ubi/k0TH3BZTDtbJ/MO+DgjbOo5IsAalb2ztbYK4lELp+vlk8GemtsCq
         D1cA==
X-Gm-Message-State: AOJu0YwXebmHbIvAh96bIdEX1gJYcU6Lc/azI3q/V4HldDctAHhlqy0Q
	kjt3YAsIc++vVG6WBaYkD+t6DXFIN92meHXr0JLAt78U2pvkOuAD6zmMi2DuR3L2qrebaFLrsqp
	i+gUAT4bcU9aRy6M9IagsuFqOBnzRD1/wM5+gaVyNsZulqYqj7vW8P1l/Ev5IZSmRvxFk1owY56
	C/nOGfO1TadA3Twpbq1wdKi2cj1jqZ
X-Gm-Gg: Acq92OFv4Dn9NHiuenBTZNxX/ZKzBHeP/JpYqTf7dkzma5Xk4we0DqoAOA2IObIKigj
	dtBc2hsYVaA1QCIpOOfyf9TGqMIpIcA7tIdKmO8p2jx/sWSccX+YztWuL0o5CXotcBjG2QgUUc+
	ALXSmpeZrF0pQk4e2Wmlz9wgCK92eMd01i0UJ6hcd0har9No7+/+jicHFRIk+xGBQYPjaktt2GH
	7gO7F70z/mzNPlCwUHAR4U0oVB9W1lFaX6F1M2EpKOMR/kkAMw/G25zwJT1m1l4I8eRS92DZKoT
	Iz/7kokE
X-Received: by 2002:a05:6000:40db:b0:441:202e:3d2d with SMTP id ffacd0b85a97d-45c79a5844bmr2094571f8f.19.1778652057043;
        Tue, 12 May 2026 23:00:57 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:441:202e:3d2d with SMTP id
 ffacd0b85a97d-45c79a5844bmr2094486f8f.19.1778652056386; Tue, 12 May 2026
 23:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504152026.587578-1-borntraeger@linux.ibm.com>
In-Reply-To: <20260504152026.587578-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 May 2026 08:00:00 +0200
X-Gm-Features: AVHnY4JFaakgD_c4M9KCMmdl9SUs0_-UgVt4TN__6UOzOrmt5oGsTFRdWgsvRCU
Message-ID: <CABgObfZdq7dzMvpVDpcfFAci=fKzfbpup_J0cO9be5EadC4QoA@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: pci: fix array indexing for master
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:20=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> The following changes since commit 028ef9c96e96197026887c0f092424679298aa=
e8:
>
>   Linux 7.0 (2026-04-12 13:48:06 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-master-7.1-1
>
> for you to fetch changes up to 0cfe660559e857d7c00ab86c73e4510ce069086f:
>
>   KVM: s390: pci: Fix aisb calculation (2026-04-27 11:14:45 +0200)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: pci: fix array indexing
>
> For large amounts of PCI devices its possible to overrun the arrays as
> the index was miscalculated in 2 places.
>
> ----------------------------------------------------------------
> Junrui Luo (1):
>       KVM: s390: pci: fix GAIT table indexing due to double-scaling point=
er arithmetic
>
> Matthew Rosato (1):
>       KVM: s390: pci: Fix aisb calculation
>
>  arch/s390/kvm/interrupt.c |  3 +--
>  arch/s390/kvm/pci.c       | 10 ++++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>


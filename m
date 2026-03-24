Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC835274B5C
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370796; cv=pass; b=KCn5LCk6tf8n+rYkZ5DUhoZurTdqFJ2Dr5YmjD+iaZW9tsydcykty/oVq2Vh2sEsOM7nH8CLvSL2W8ZTTFbHaaElBtlxd8cv+lhmfK3XQraKu4jTI1Xfg+dDmhRAIaN5VV13fAl0aqaB9MvoSLT8onQxbUOQa8dd7uImveSq/Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370796; c=relaxed/simple;
	bh=kRBNZYBXvdyd0G3IRhmHcdN/BFg2bxldCxeHP1r/m7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYy5KtfrQjPuZNNhSLzWecIZ8aFpyscRAufHy90eoFU2fY6fvDXt17WhdvWo5zDm95svi2Af7CQD8l0JybqEvXAps/wS7om0hnSln1eZ9hADrcFctGGnDjFUokvTFcy4/hafSilm9lpgqkbFUpA7WtQ3Y4yzviogbgFDbHxAW8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4sO8PKp; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4sO8PKp"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a2e62b893so11442541fa.1
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 09:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370793; cv=none;
        d=google.com; s=arc-20240605;
        b=aqmBP+ckKSd1PMyf00uIBDdg67UjDkWZXe6t+g+G5RB6gSuWpEdi9RM+pGnepztWd2
         WZD8shD6I82kOypFCpSJp3AHmlvlxGRcMM/4fTeBIuTnieYbPuEheLzuK6Yok+IEpk8R
         7WJGiflt4MM+NpqgN8y3kHOnXOg5sZbhE7l8demQSUrE3KNn2kO9xAy1mM8MQD4NhlSY
         BlBLf1TFOCTIr0AjbKpW4Rk0U+lnuoUBFD4Dh8ju2FkSNZNp0+Dz4DzYE0emrZDw7uG2
         7893xPi7vBzTlk34oFFSjqyFipP6i4uV1KCbrnzkUTGlFvSLP4MgQU5jne1rH18VEhaR
         f6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        fh=b7wowDB/mMP1H05/SwBhYt2efjp0XaD8oymGUHakMjM=;
        b=FiPrfFTx4pJ5+qwV/jqk+bbDqPXAN+djxVXOOGy3g5SSLOyA0cPBGLA/ORKfnp4HG8
         c4oLg6nfc6y40Ik2MPHG93GEz0K0YEc2/g/cJJUnK2oZxH51eg2k0c/8mD7V72xLRnlI
         /DHBcBLTDa81jl93zY3Fx9VxxB6GAnk9S4W7J9XSw5Qfbqo5WizKo2LRycy79kwBJgt0
         SHVwdza5ivAMIJrks/LIzEGbBoRuCaBN/jNAMRIww+zucYFT//9VF+1kwv8Ve2OUMfX6
         vopyUaOLKFsm/9zixeynZcygskFqTOe1oP/sy/H5HFLRPabz01/lApq7m4CdBjOk7R/q
         UUgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370793; x=1774975593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        b=H4sO8PKp9fcAPhpWTxNV+tFmYJ/sEMYatbvIzld2dPiEOMw9aGpQ+WGNGjATEm+51/
         YbUcXFrcz97hbxrzxsEftuOqLKQiOSrFXG8T8HXyVGKMdQx0HKHJye0LmCsymPDZPSvG
         M/CHqF2rcTta7qW3KZgb2NMHPAsk5WrMBrhk43stRUaU83lXDhrC0HIe/9Bl1cZQ4HWb
         MFIwP/f7Wk9f1aXFttOJmUlBwtLno++Ijt//Yg+3pVY62V59rXXtcCnbpzbyAluM8rv4
         cpGGN572WnyszDNQd0dUYDT9JLIypM2+/qb1F2bL6BWSOgFP/9k2jDhbbXODCuJNqqJx
         AsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370793; x=1774975593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        b=UL4NRLeEQVnioa9Mb9mBuq+okzCiVOKrPJYg/Yw5O0rh6TuT2+hF77McWa5v+z4YW7
         sa5Op9j0z+O7f/yT6x8Bh5FADifJC8Tyt5DdGKO4pshcV0Po1EQgSP9S4IaZ5jiOiDQp
         OUB8c4qI2Sxe2F5vAVJCBou6Jckjux/020+82XFcsa8XhCTN7eCnwwikX9w+R6VX/PyB
         j365cSmrziAPp6EhxL71T7jmx7j9oWV7PCcgLUUkZS9i42pL30iP3p+jQ7kqFdcvTi5j
         Q7gq2tLAcBS4nAxWovKoYKvhb75PvyxG32cVko2ofHJ1UYhXgxQsKfKEzQ+Bxl5TX+MY
         mFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpsfhCvnt8idhC69LQlWqL1LyrH5U9BaARyTBLHh5ewilkHz8cifoD1K1CdyWIvXSJ2L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ks6iorGlHHQFXTcRWjmQuv40TGb9o4rVg6SwvJF5HvwcNTAd
	8i3OsMEngjIC2Xuu77+Kv5fo6dcYsCUfc71C40ZASn5Hjah2FsjDmCtBhENiZI1EAftjL7sjqB5
	TmFQ788CbBTeBMeS4Xs4j0TFYdeAOEGR+5LXPoTZf
X-Gm-Gg: ATEYQzwpK679Pq6opy4iiH7EI+tHvJKjLbO096TLIqQVUKKLFXXYlmkDcx66wMGiRdz
	jy2d+/IUZM1rvRkny8hUPGCuqdg7jmFQG7BQxny4awbENVh2wVNmwSXT/57buQqXEYcQncVp6tQ
	XKgepOQQ9LgAyG8tN6kS+fNT+els5EuoU3XUBN64jqcH0lY7kPKKx+KhaMHJUwf5TQtBGzIU7RK
	9P/0pE1GZ19NCVutYnqZs9c8N1chRq/029TFOKZySiKQkHW3m+oUSmCmdQm2Hk7hUMIG2iSvcza
	5PxIfj79
X-Received: by 2002:a05:651c:198d:b0:38a:45d6:c246 with SMTP id
 38308e7fff4ca-38c4309f785mr403821fa.8.1774370792285; Tue, 24 Mar 2026
 09:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
 <df5dac48-8a54-49e2-acb8-9370b7078033@intel.com>
In-Reply-To: <df5dac48-8a54-49e2-acb8-9370b7078033@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Mar 2026 09:46:03 -0700
X-Gm-Features: AaiRm53x8nRAyhq72BKXQ8vBk2jNU8cpC5QwT_5hu3qjlEbsk36YMzg6v1f1PaQ
Message-ID: <CALzav=cGzzZTL-tyaaG_AhC3gP7ULiU6hWS=X6joLTjyoo-6sg@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:01=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
> On 3/24/26 07:57, David Matlack wrote:

> > + * Usage Example
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + *
> > + * VFIO PCI devices can be preserved across a kexec by preserving the =
file
> > + * associated with the device in a LUO session::
> > + *
> > + *   device_fd =3D open("/dev/vfio/devices/X");
>
> /dev/vfio/devices/vfioX

Will fix in v4.

> > + *  * The device file must have been acquired from the VFIO character =
device,
> > + *    not ``VFIO_GROUP_GET_DEVICE_FD``.
>
> how about "The device file descriptor must be obtained by opening the
> VFIO device
> character device (``/dev/vfio/devices/vfioX``), not via
> ``VFIO_GROUP_GET_DEVICE_FD``."?
>
> just be aligned with the below words in vfio.rst.
>
> "Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> user can now acquire a device fd by directly opening a character device
> /dev/vfio/devices/vfioX"

Thanks for the suggestion. Here is the wording I have for v4:

  *  * The device file being preserved must have been obtained by
opening the
  *    VFIO character device (``/dev/vfio/devices/vfioX``), not via
  *    ``VFIO_GROUP_GET_DEVICE_FD``.

> > +#include <linux/kexec_handover.h>
> >   #include <linux/kho/abi/vfio_pci.h>
> >   #include <linux/liveupdate.h>
> >   #include <linux/errno.h>
> > +#include <linux/vfio.h>
>
> maybe follow alphabet order. errno.h would be moved to the top first.

I will reorder errno.h to be at the top in the previous patch (where
the alphabetical ordering issue is introduced).

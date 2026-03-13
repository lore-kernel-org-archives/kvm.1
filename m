Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BF39D6F7
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412093; cv=pass; b=BSF5KyygIRn2DArsAhlDEXlnzkwe3nRsuOHB656QO2cZwIYjeM9fFKlkhI5WLkdTQ+xzzjuvyTGWKN2DNUwhvCoNcHF0AO5OVdbv0JTHQ2TEBxqge39D5r9eKWN3zVaP1qRvDW6ggEjh9rJq4j04q+tHCxKsv3rPtdFaruD9ox8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412093; c=relaxed/simple;
	bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z79iEO1BXCV103I8fr/+T4MqXAkz2qDaDQZIRMOarocMhUzXR8YtCce+v5s1VD0kUQkNZuugrZWvaQ6M4gbszAcLuujG03dl69Q5aCG2XkkfVkde+1XaYhrFJ4ZoArpOQi+FNzsQPz/ncgI7qQtTGnOB0C/f9dnyu/hatgvlDWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YWB87fJu; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YWB87fJu"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso4222417a12.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412090; cv=none;
        d=google.com; s=arc-20240605;
        b=I6oKT3ZhnsCggtdWJPlr7Dd5Yzksf0F3Uye4lC42YngyA9wJS063iivt+VQFeJlDRu
         G4cjZ/Xe8QvZ7LGSyqNOunEhB0YqL05MDj55nwVjMMeq8IMJbUavmzE0p6Y+bYaoBOXo
         uShrv+Ee+su3r8P543ymo7Kx3ZUGQ1bj9kq1KH+EYTJVhahnLMu6zAomwj7Xu0AVU5Lw
         DdJu9X83cT1bK/GFZBll2T7FuP7wX5ZeCFe1+2rHzxwqzoLLYBup6UnnU+EFzuZ40oTI
         2LWn/6md12clCpMYdgVCe/mTj8AZeyb5JfPRv9D2wucgW4Kb48mm8yr+EcNxLxU93KYt
         U8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        fh=KFHYD+eG/TskyTbD3tZPl1pcxvx4tqIiJ8hfPopgINY=;
        b=jIoc1T6lvNpxovUPLuPI1vbfGCKzgN96ftR0RqZ7uDUqWqXNI8kDrDi+Pg2AWrjTuJ
         NzWrKgQuh8VBT/Uq11GObHwjfnQSwm1DFO5+a1V68cWfbPZ1Aj2+LYJ5U8Wk24ztf5mZ
         GqGpLmycuYepZGQcndi+NuhyPUvSAZOwbZk925TUsZXW18BucHbx7CiZoBdX7n7SZ9Gf
         6zD8Yb/SNCR+E6j7uCqXdnUiWtpTSmlLy0qxB1BTpk8riX1fO8jyzJSsoCm4kedNRn97
         IMMJ4vyE/6lXk2MxAi37DnuJHyx6mXlzS2aBleKkdrAULBUe68HJxr/yvg48FdYr2CLq
         nqdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773412090; x=1774016890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        b=YWB87fJu1urKVHYo0MietW1J8yEK9dBucNkODt2BZV7FSS2FrPohmTdi/nTZOWcvzL
         mWwh5Tq08dzYSAwWdFMpHd0JgwR5JJrMJkCNh94LNN+0BcBeR7VGRXO8B76QeamtUgDr
         pxPFHv+LxsPO7Osn3g840JJyjI6LgEKSzuISp9fpgbShhzaikX2bcX8d5+CQ71//B8H+
         w3rs3wMbtcj73jePmfDU1F6X1iH3OLkjbGX6ru6+drlOLnYyNLPJxNfF75eh3oJxxNOc
         b5B/yvERWCKrj3yt1SwhCPJJdJkhPRFb6ytDjFY/QAArmFB90B3Qs2XAB0dFFwgjdnFn
         4Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412090; x=1774016890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DhJJ93cKQQk3SpyT61kIFsBKzCFpwnhRvsErphsARo=;
        b=arjfrNT7sIt5R39YfTf6hY2CdyWB4Njkypr9YCNBM4tGGTEdU888/5OXcoljdMJvOt
         8DobYxC0+0ibg4Snd6NndwZNKexnzC+/FcUhSeFfnagUMdznjqEoOE9xkZvHEUDe0QPN
         DEbszFOgeDaiNEmElUKWPkz9KLF8GbGfYfUUw5jQns2G07Cp0zA8xUX8T1EVmARR5gkk
         U/yOlRwVBAuCt+Sqnh84O1wTz7Y+h8w8J1N7/H5jpXhKfI24Lwmy4a86x8MK95pPSXiL
         5PtpvTY727CcSDS9wQxi/6aVw5avPN2Uq0NwZ43T13xhNDwaV6SkB1Had1Gwx1j70RdR
         lTyg==
X-Forwarded-Encrypted: i=1; AJvYcCVh2K3d+jJlLIz7wh7tom9Pu8aF0MurK1bT/Q5y/45aOE4AO81F49Ey8yXAWae2GBrHMi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wMZm2+DGL3bksxg7kGkjdXeTUYyvC20Xd4SKCXszjsjyNNq7
	OQq44R+DMHmOccGjycouMYUJukCQJVPSOVyNCLWqJ9yfAD5M1lwyFotOkKLpTkhZZsEsBQ3AE04
	h1KT/ugv2vCL3ZNpmxcKk0+ozSwpv3cNgItHSHgUoEw==
X-Gm-Gg: ATEYQzyJBdVVnGgDpzjqeflnQivJvofQ8jE5LIORu4kcrq6Nv6tb3qEVDAnKJB5cBby
	E3XThDoqITmYfJlKmFxI00UJBwxzcv8fVPyRRIhoMsxxw+7X0vxDzRwlGvxAlZ9oma+qX9hQayJ
	EeFx7Id7gtK2M64A46aR3NNCWczS6MR5EymFxgoM6vyBqwl2tw6zX5RIn+zKp8axIGSCyBft9/a
	ZkaurlLTI7A2VWA9M6zrwjYLG4SkX2PVqBSdclNxpnBmIj0okPUq8n4d/xl7FED6WNq4nFOsO2J
	QuLB7WqKk2NCm1tL4cEACRsPmkCtrNx/8yL8gw==
X-Received: by 2002:a05:6402:35cd:b0:663:8be1:3649 with SMTP id
 4fb4d7f45d1cf-663ba9b776dmr1936388a12.3.1773412090104; Fri, 13 Mar 2026
 07:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org> <20260303210733.GG972761@nvidia.com>
 <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com> <20260313122525.GB1586734@nvidia.com>
In-Reply-To: <20260313122525.GB1586734@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 13 Mar 2026 10:27:33 -0400
X-Gm-Features: AaiRm524CkK4OBTNvXFWcAvWcl42dW_YCeYpiFYkXzW17TUn9itgLI7yXbb39d4
Message-ID: <CA+CK2bD2ryZsvgono-5Yg0jwwCa-p55wefT=hn3DRsDJVc0ADg@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:25=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 08:33:27PM -0400, Pasha Tatashin wrote:
>
> > If there are active sessions (incoming or outgoing) with preserved
> > data, how can we safely unregister while they are in-flight? It is a
> > rare condition, but since the user can cause it, they need to be
> > notified that unloading the module right now is not a good idea.
>
> IMHO blow up the kernel or something in the core code, you can't stop
> module unloading once it starts so it is pointless to propogate this

I see, I will send a separate LUO patches to make unregister functions
return void.

Pasha

>
> Jason

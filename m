Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D7379982
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432681; cv=none; b=Yc8DNRH6/R3ecFEoEUYbw/TD/xiYLWbZpTEUJROs9JutJzsENlcwdaBopnhR7A9G/9G8u+iyt8cwWzy5UsAj40PsJ2/uQymSKU6ITSgRtvKUI6hgmbhApem/7jGIGIfqN1V6mJAeuUaS8hzbJ4TFU7rc12n3zygYEdQA3K+izlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432681; c=relaxed/simple;
	bh=cn6CtRecj2EaLwpR7S4y/I/iCrHBJcghb35WFG7xfM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SxdqVsHIS6GjYQDHMTE/A5k/ZmPhCPqOMeYeBxs5WyjQy9B21kZLNKm5EpZudSJH5xlZlFRfyG48DVmes2KpKCkJHp9NFFzNQ8vejuAn/T1gOwTT+XuAk38CuuY5BV0JtDdvPupbQL2/04CPlP1JtIDdsk5/P7b52xNgcpE7uTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W37iuxtC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W37iuxtC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76c2bb3149so415636a12.1
        for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776432678; x=1777037478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRvsl2+xaLX15c8bn64K4rh3d7LVuLbPSeYH3sCYDFo=;
        b=W37iuxtCZHZ0j+gZyVI0BuAlDpY1GOVv/hTuN9eS2Vka5aivjj9pPos5yor3v6ijTX
         c8Nq0IEDFuDBMklt08qtiXhr3r7my33fT5Co/0pk0ezL5AITz8F+txIwLaun+U260i2H
         ASvBmVbPjq3XcJgYU0RPznGqKtCPdpDeLAgngsSN9iuBeT0nM44/kaK8qrNnvSjRjbNv
         zf5DtixZSp/wmimdYSvM0N+RRRsCYLI2YWpObav7w8Mtboy9ZtEomkDwjI6kakoLlTxi
         UCHWPap0mAyCpttsaZy4mlDIuDaFyyFuWAR37ol1KLm8/cu3VaNg1HXwJRdijk9xwACx
         4drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432678; x=1777037478;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRvsl2+xaLX15c8bn64K4rh3d7LVuLbPSeYH3sCYDFo=;
        b=Kwvu4k4bEHaoN78WbXo58+HXGcQn9b2YN5JquR7wI1ZRyzk8KjyK+eyot6NcL//7zU
         mL7kfB7abGiSBEaT/48mNBNAqAbtZiUpOju18WzBlxf71SActyatHMjP4+Fm9SNhYG/u
         kvFuSfUU3B6ppMAQ2RjhPQHDEOrfGmSPlcgv528dwGpHFRY2nvSdSDAsoqdD/F1YIKfS
         kJErHTlax1krfs34syrfiB2OpTFKLRntMyXk2nYsBz8lZglWI9tOp4Zy3qeBhOuTGuFL
         SiD/4UUbjtQ6kjnhDBuyq56wW1EjEwMf+zH6+17nq8kyj3gyf7vim+6KxPedcABRdN85
         AWuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jCgQw8qmglwwho0t0WQpHP/RwTWbJ9IahD/vfyJqqGDBeKM+0CH/f1TqLvKXgEhPfNTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9LIeea6BUqYL4vvQt0/Si72D/z3DVOS+T+0WW4RFJVx2jqv7
	08M3CGYwu+pfUVBitsLo8sUFWt4qQl4aLF+kcgRbTxSIH4HoJmJClwTCUQSubRhKhJGOPsUOYxp
	kZS6oQQ==
X-Received: from pgj66.prod.google.com ([2002:a63:945:0:b0:c79:15ba:9c4c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3285:b0:39b:e3aa:df2d
 with SMTP id adf61e73a8af0-3a08c860091mr2686502637.7.1776432677923; Fri, 17
 Apr 2026 06:31:17 -0700 (PDT)
Date: Fri, 17 Apr 2026 06:31:16 -0700
In-Reply-To: <ce3e8a51-63fe-4723-b1d8-6555b8b77817@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313122040.1413091-5-clopez@suse.de> <202604031640.vckbuS2S-lkp@intel.com>
 <ce3e8a51-63fe-4723-b1d8-6555b8b77817@suse.de>
Message-ID: <aeI2JCLldUFff0Q0@google.com>
Subject: Re: [PATCH 2/4] KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	alex.williamson@redhat.com, pbonzini@redhat.com, 
	open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026, Carlos L=C3=B3pez wrote:
> On 4/7/26 5:48 AM, kernel test robot wrote:
> > Hi Carlos,
> >=20
> > kernel test robot noticed the following build warnings:
> >=20
> > [auto build test WARNING on d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-L-pez/KVM=
-VFIO-clean-up-control-flow-in-kvm_vfio_file_add/20260314-053050
> > base:   d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
> > patch link:    https://lore.kernel.org/r/20260313122040.1413091-5-clope=
z%40suse.de
> > patch subject: [PATCH 2/4] KVM: VFIO: use mutex guard in kvm_vfio_file_=
set_spapr_tce()
> > config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/2=
0260403/202604031640.vckbuS2S-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 15.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20260403/202604031640.vckbuS2S-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202604031640.vckbuS2S-l=
kp@intel.com/
> >=20
> > All warnings (new ones prefixed by >>):
> >=20
> >    arch/powerpc/kvm/../../../virt/kvm/vfio.c: In function 'kvm_vfio_fil=
e_set_spapr_tce':
> >>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:219:13: warning: unused var=
iable 'ret' [-Wunused-variable]
> >      219 |         int ret;
> >          |             ^~~
> >=20
>=20
> Sean, should I send a v2 for this or will you fix it up when applying?

I'll fixup when applying.

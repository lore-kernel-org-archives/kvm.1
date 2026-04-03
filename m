Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0106359A6B
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253527; cv=pass; b=cRAlpSNDJ0rVNvw7oYcZbYEISKiFNBtPaFVKUGsk63+2BzTnZ09+WSqBSA7yYECZK/D6qiM6nAATnPCB55bCa7dgwE7PyOnPRL4jkam7e1VRr/QjNn9Hbjm/aXcEXknNyoKBLHQXHFUAq4ni3YBP26XKVNPeioR8+Z1xdruRMRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253527; c=relaxed/simple;
	bh=oCK+sZb08S6huM/V/s1J1l900Tg/cNM1yA6PbfEXFH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGn7pTxc49B2dsEH3FJTeQaeLt51PcAihXqRHKLInMIEQSgNtnm37/L2LB0YfjvpSEtfJAuEFo3XWBSw8xCxCmT5JhKoU4RBNCO1j7bUghDORh8cZArcVBNlOPRskfGg+zrBHLqAtcCEMeFBptt88FiZOxIZSvQ8kwbFCEbBEg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfVInFU0; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfVInFU0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so98892e87.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 14:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775253522; cv=none;
        d=google.com; s=arc-20240605;
        b=iUeRT1fuCBmstD3US8+EllUoeWsW2sQPcwhwnAEpfekaZexRlThDZlW6aJ3uxxUiMk
         PieOFdi7+nRT0e/FEw7YvZRAvn3vaPaoX6IGsaGiJG3xeNavzsgIOyDrCwVXjlPBkejl
         7aRX8Q9rSrRQ4rxHi6GlouUtB9+hiDd189+TWCNrDFO8/jvC/Jb/mJcLlNfeAlnU7PfH
         22y86Mgcnqjhk+Cy996DDpttv+Ntx55xyKtbNH1T+AJrVpE7fAM7fC4d6iGlU3/1bgL7
         MaYM0sh3qDHeLNkoGcJ7DZL8LxFBZKT4FvBNc+4pBQqRiFLn1PlncO3GhlDZIkEojQsR
         NfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        fh=LVqbv+rC4lEKBObltfUL5FW6PHSfDfszzJCQFY45XRc=;
        b=G7nCav2t2ssQjWeGnRpZ2JuzSm4Vk0LLXgjSbG84w1orqvDXHbzW7dFzPqrJBhruTt
         72J2TM3Vtfa7oD9meFMfEe9unhxch66MSV05x4qAWvh2isHsszPBJaqYpOHTlZGXMtOQ
         NIiXjDM1dusiAikTxDqcigGyjai5XV9oEe+FxmCcvuAoBxDZfABWwYHzgyblYSO/JnG+
         WXT8mgy3S+Mnga1MCXBrLiJvsIgbbgSQ/Zb2B5T9M2R0yBIT+bYtz9HtrCo+tcC6jBXW
         XxCU01PirVU78HhZkT8jVFeg12d96OfVFs5/q4JQEIsNisZX+gM3UdkdOOWAn+QaR75X
         5RdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775253522; x=1775858322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        b=sfVInFU01E+LC/YL08p0ZrKy5EpCdGKddjzFyepyUv4or1nGuchn8jkj/IwiXItUrW
         nFN6Eqf/js+yJG1Nuou/6OciQugdHpyDNCfbBaFQNxFv2mul2ZMJg3kGYxTEsEuiBjnZ
         0SAwrWBs8MdwUdwpZOmdRLodQPwWfwrBrfXsRmNbctLQj/AXgQ38BzeZx2GBZR2SNT4f
         RVq3gSCdWgwT73tc6U18cP9lvNsuFCc0H4Y5jo5lATYkVEybeYCOJueCv7GxvQJg39zi
         vouHBiahkBZQ1l3DMVQsRBTbyEwZeOLhEH73PMkQmpcboD2alHYcF0E0Rml6mGYxEvWO
         qoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775253522; x=1775858322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1x++2kh/JMrnSacQAY2WWd8oQD4emJiO8jgrYOFWkM=;
        b=YgW373JhRBNviFjIgsPC2Pv4XVQP4VDi/xnGSU0KHfgCXk2eC/5ZR3Od2mhQ0RF/+B
         msCIJMaXtLSFVpTKrbHMt8wK1lsXw/ppW0HR8xriCdIl/2VeGLwnens9khS2QO0Odmo2
         xbKlLoN9J0TW0hYM7RStHuB6bENq8ZpTHu//KpRqzDROW9AAMuSW+ucpKpDVETiOT88o
         p/7F96gcf39s7H4ALbINRKqE+928BHUc4fElQ84DXeuLrmzeodFnygnovpjFaPowDHY7
         Vuk4Usf3OPWschCxY4xSoYgi7ueA8ZYu31eUhaYY/M/oNiXP2n6uxoVsoSBUkhb+FXX8
         swIw==
X-Forwarded-Encrypted: i=1; AJvYcCVRbqorc5o7f1xa7a1xr8ALLsdVaKUDi7P7cvmQjQ4HfgZIHxl+Lyl+N8G7iH/XdTf5lwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lUe+wgmaA/0qkKDIkMeAyW7skmzvnDKj85l5J44t0tz/HTFx
	eJu6zLZffzO7HUJBSNkMHmtNlHJAUEWbBfrm5gw/zpnGPYSYgcr2BK4ddytuxzpEOYXyKdDGnzD
	ABBWXdTSzfid9+KHNKTyl2y9RilKppXlWoa+GZpZq
X-Gm-Gg: AeBDieu5RMkZ2GJVSIbdy6gMkkYeu/d1cTy+G7navQAsyBCHmaqNBnhGzKX8+g8L4Xu
	bYuQTGyiL2bhurjESQaAwqF9YCAoj0OntvgMFmzh0129RX5hd1JiinaVcXT/wpfhddJm8JplgAh
	hOJZ5wTYWMGyaurXNMG7k0jtgWoFcFi8MqCZ+iTrXRHTU6fJnh4MhaBLb4bwlJI0ejdapra22ia
	oYaH76kHd7mvdWPXt+Dj2w2QHg2qSh47SX3rpUPIEYtgBl0C7XwMa0CALIpspZAt9noHjDbsPcg
	0Q5Bu1z6
X-Received: by 2002:a05:6512:1310:b0:5a2:a5dc:6111 with SMTP id
 2adb3069b0e04-5a337563322mr1534908e87.18.1775253521414; Fri, 03 Apr 2026
 14:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
In-Reply-To: <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Apr 2026 14:58:11 -0700
X-Gm-Features: AQROBzCufsJjSomX3fu7F7ptwK4HJAYNpi3kPBVsC_mFldZEseUJNvIFRhG6pcY
Message-ID: <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
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
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
> On 3/23/26 4:57 PM, David Matlack wrote:

> > +config PCI_LIVEUPDATE
> > +     bool "PCI Live Update Support (EXPERIMENTAL)"
> > +     depends on PCI && LIVEUPDATE
> > +     help
> > +       Support for preserving PCI devices across a Live Update. This o=
ption
> > +       should only be enabled by developers working on implementing th=
is
> > +       support. Once enough support as landed in the kernel, this opti=
on
> > +       will no longer be marked EXPERIMENTAL.
> > +
> > +       If unsure, say N.
>
> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
> (modular support)?
>
> This would allow the feature to be built as a kernel module. For
> development
>
> purposes, modularization means we only need to recompile a single module
>
> for testing, rather than rebuilding the entire kernel. Compiling a
> module should
>
> be significantly faster than a full kernel build.

I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
pci_setup_device() (which is under CONFIG_PCI) needs to call
pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
module. This call is necessary so the PCI core knows whether a device
being enumerated was preserved across a previous Live Update.

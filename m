Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17914333725
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491608; cv=pass; b=lFkYRaAJ8nem9kFC1PE9jl667X0LoOWSHtBnuf344dxUdZ/dYbUdi6JpZn8AqzUCcs2b4qOGm1Au91CNx1Z3gFH/pXpRDuJ7obVScKjPu1xVRBOKEBnDCkEk7y4Qnafrcfs2GZg9ETk+TXgEewvpSHPoSsjwTqA7Vq2FIqdV0Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491608; c=relaxed/simple;
	bh=0mfv2q13bWahVT0s2waY/ovs1AueK0bCMf6E6tJ8ke4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3UnyPr/uj49TePZBTPemnTUhNjB7a/Q4dXkesofx/wFTG1HvC0TfBx+gdaSkkTGd4JeweDVNEV+AGpO/Ml57rgKcLJ8pwunBePi8datEJ/UO5zAeMUFCAmNAdWAm/Ab0PygiwVvAkElt0AEQ7G2sZRvW9NG2jKknWaI1LITRQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwnwHUVD; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwnwHUVD"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso3880933e87.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 09:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775491605; cv=none;
        d=google.com; s=arc-20240605;
        b=OG+5KNvP24/9u9FMrowhFxKabwrVDuLPZ+OTybyK3sLFYCzhj0FLQVZXdQYjHgH/MK
         by8HRFax0/bh8iDvI7nGCh1jfRIHrBTWiRJVb969i6ilr9z+tcMsXKmqvz9VelRseX5d
         ovk6CcWZV2VxmqfMITsm3sGoCEM1Vlf48EaMZle7vAL9F0yVmQ6gnztZQe/qQOK5WjkY
         xV0YEewXoOeBQg7Cmdo7xGqeyd8LimGs1kM5b6O92qjRq5HFCndXWZRxTBAqQzI4UviX
         E0M0Q00gOHJ+TF4/360eQwuj4e1CDh/kHuQmrt+Ypvw2Lcbcc/MCvPv2HSZ7Po99CKU7
         ZPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        fh=ytscstxYG4zsmRV5E0JYYjBuVOBGx2GgiVY6qPGwc2s=;
        b=YldzlyZqKd1ADcdKmWv8Oq28+O/89a14AuXgIINzG6uxC/MhcM02AtvXJpdPZD60L6
         +dWBUVk5H6YGYz0Uv/8V+c/w0xvUbuTkTqiusBXC/O0MHp04Sv5rhNbL4kWNC8xMr1Pg
         5+sLfis5aVvQhdyWRzkoSO1wdEGTM4AJXR6zdAMMMZMphMKaCSflFASY46ApRcmSxtv+
         2F25FxBN5WO/Khzc/vsO96jhF/r7FF/Ubxn0kYMpNYGwNxYxLsmKjuabJkUJ8bcdiyqT
         kVCL9p6SyE3hcXtC6haDDMe8a7y0WMUSDUBKqiOXsbVfoCJzHWIqmVcXssIJ+XllqAwW
         ye0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775491605; x=1776096405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        b=IwnwHUVD2T4Xb+Dd46BueA+Str+szIapn/Y+fyFgQSwlj6mjzlptehM1Sg6sFr/dwP
         3/Y1pkp2MwvbGzpNJKsRRCMnPF4yISFdb1OZv23yZ7I7QZgSWRjtI+UkYbPLzAUNkXhw
         k7dgJGyqBsf48qQdKVz/KPE7CvG1T4JyZDRV/4/3numJsXFFE8ATg28Ku7sq8l9Ns5wR
         aMXQgJT++ZZAj6Jq4q53P43tlh1BPBlIupFJOFOkGTTdquFzsj4NJtEubzYunEHrbwr4
         Pj6Q5vptSf57UeMe8W+fBnqjBlh5WRfD7UwDgIrJ0Szmz1FrYU0sZzEQocx3URM+s4uc
         RSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491605; x=1776096405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOKcd1E+kh/rgDmBatc+5AEkevvJqYiqh34IKuXZ368=;
        b=CRbYgfuQtgTWpPzCzhd2vxm4gayKU4pKjjUlqb5DFlefIhK6tekB6qThw89lYpfext
         4jgyYrjaaBLvC0So5wu9oVBK/c/KxHAJSj5ziDPnhxIXOr1hXT4xKadILw9jrASWPslY
         RKcJxGxeJjqh0kCgyPF1pJUwG3MirdCfRWtJ2jAdH02f5/JLuEesygt2D7AM4qrJilkZ
         cAuOKvIWn7LHTkGsKOXauSjHDdYOnskIsUXo2CpiS+CUuNMnd/RDh3OTiCHoWdM8gpjW
         5CNS7G7A+HDuAOVT26Z5U3WAUbh4Vu+mVSfeU8Br0fOFNvjofWLrEEXO2m86bcXsd63S
         lzHw==
X-Forwarded-Encrypted: i=1; AJvYcCUn2emlTGILtEGo975zgUWu0Aj1PUsmiuL+ck6AHo26HQwBcK4Xq1K3/JmIRifYh0KfybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZn+btMewDCjk+DexL55lpuYd1ks3wq6wSGqTIsJqUbYymE4sS
	R+fNAdph6kstRW90VTu9WJTcASPzxg+KCT1H2uLcfSCR6/aixKJ2+laj/PEoTHeID+SNXUcUlEl
	/nU95dyJ1mIkKtIBzHaq+B7b5Gb/cC0LUm5K5Wq9S
X-Gm-Gg: AeBDietSexZZI8CXOcPkDVsba8MXNBa4qQ3vnBlFLE/zakLohgepspTH2ym4Aa9pTUr
	8Gzu+J+PRrTvplEjLUJ6hgtFawxxbdyzZxdJCXQXu31SAs0nzC2mudpi90fh/9nOqCysvk/NClw
	UtHNRJ5MOdhG19tj9fmNlg6+bPShYtnUUnZm7vlPSAtS+5u5E5mOo8PBYtyQshHQ+4gUh3hBRZC
	JOBt0e1JiQiCZdlRP/9olb+6dWAyuCDsyuRilw4XkRKFLEmHwW92v2Jvcj4eFONznOYYfbVir47
	JXeQG5vl
X-Received: by 2002:a05:6512:33cd:b0:5a3:d2ef:2f93 with SMTP id
 2adb3069b0e04-5a3d2ef2ff2mr3364086e87.30.1775491604807; Mon, 06 Apr 2026
 09:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-3-dmatlack@google.com>
 <e3fe7085-1297-47b8-bb17-a48196e8f37f@linux.dev> <CALzav=eyf4XRTi8MfE_GBNSm+tjmfX7=d0M8Aj5Hh0vJn7huew@mail.gmail.com>
 <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
In-Reply-To: <c4138f66-edf2-4689-b5fe-16dc4839e9c3@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 6 Apr 2026 09:06:15 -0700
X-Gm-Features: AQROBzBbHlG2eO4NjewlbX-rvy8OZhgqlWaRP6spr5d6_KAEWYAdDGH-j6HkrWs
Message-ID: <CALzav=ei_xSfM0MTdPFhGDjNwe3EQ0vHPiEk=vszFX-Xi_KjQw@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] PCI: Add API to track PCI devices preserved
 across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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

On Sun, Apr 5, 2026 at 9:56=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
> =E5=9C=A8 2026/4/3 14:58, David Matlack =E5=86=99=E9=81=93:
> > On Thu, Apr 2, 2026 at 2:29=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev=
> wrote:
> >> On 3/23/26 4:57 PM, David Matlack wrote:
> >>> +config PCI_LIVEUPDATE
> >>> +     bool "PCI Live Update Support (EXPERIMENTAL)"
> >>> +     depends on PCI && LIVEUPDATE
> >>> +     help
> >>> +       Support for preserving PCI devices across a Live Update. This=
 option
> >>> +       should only be enabled by developers working on implementing =
this
> >>> +       support. Once enough support as landed in the kernel, this op=
tion
> >>> +       will no longer be marked EXPERIMENTAL.
> >>> +
> >>> +       If unsure, say N.
> >> Currently, it only supports 'n' or 'y'. Is it possible to add 'm'
> >> (modular support)?
> >>
> >> This would allow the feature to be built as a kernel module. For
> >> development
> >>
> >> purposes, modularization means we only need to recompile a single modu=
le
> >>
> >> for testing, rather than rebuilding the entire kernel. Compiling a
> >> module should
> >>
> >> be significantly faster than a full kernel build.
> > I don't think it is possible for CONFIG_PCI_LIVEUPDATE to support 'm'.
> > pci_setup_device() (which is under CONFIG_PCI) needs to call
> > pci_liveupdate_setup_device(), and CONFIG_PCI cannot be built as a
> > module. This call is necessary so the PCI core knows whether a device
> > being enumerated was preserved across a previous Live Update.
>
> After the following changes, the liveupdate.ko can be generated
> successfully.

Sure but you've broken the feature. Now devices can be probed before
liveupdate.ko is loaded and the PCI core will have an incorrect view
of which devices were preserved by the previous kernel.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133203;
	b=4v+h/K0nLzWyaJREBvZdd5AIV8sLKaiuFc4G8md5jUHjG0cX6nNKKFCfVQV5cdyps6X3
	 idZoEdyP2BfiWum15EDd3rwAPFiINsSJrwmmu0TSvLjuFh5LlV3hGnCIzRxSZwcwvcvXT
	 gzI40k0b7b1zP21/2Iurj047Tr+cBIfP64UFHfc0EEWYw5H+i6hAfVSsyL8vtuipdSVAg
	 oXIAoqdJI5f00Xn3S5F4cugvYJAkcPy3oOJDBdHHtjLnwI0AQS+q6ogPJgle7FHr7OqxI
	 98q4wYTuFuJTSInF0KQZyyr38Y/IS6wc6ipS0hB0mBdKLniiOAxmOTzgggpUEv6fQEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
	b=km6SG5oE+qQXBdRkukbP2uXyahuGi90sZiL5EnY2zm0K+SQmDfHOvnyUyWCIhUAAfKvN
	 hdECsoYbd09nQF2hnUtAkIjUB0I4lwdN1+QAMCLI46I3EmdAIOkew5EAGqPE/ViXLCIkd
	 4qTAYWoNCYhbFin7pcz232hElKuJiwQa9axwOA9B+mH42pUUC+X56xp6Qd3oMiiq26IvS
	 1VOdSXAE4Yw1heRPPmNSNPxp3pG0HeiR32JNklUbemkrX4SfqZol+wI3m2sZWkwoy7ycL
	 bgCOmdgYK/fPJWi4A+Oet7AlyYqIUxRP+/KqKx91y4F6yPBNhKO4aXqukJU+tIKrMdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="air2/dns";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B360A260D
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 00:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E4B360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=air2/dns
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b179528d56so186469a91.3
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 16:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133202; x=1795738002; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
        b=air2/dns5VZwLYk/f1lay/0cC8R/IakufjWjyjlVS/NkwIM6QfW17TQOWTR1hao4Ul
         +5QvgbPksfItTlbIwBAB1do88ljLq3LFNqPJVuAVVQFv3aEB+KPQ8jSq9GBqzZ5g2JDR
         EFBr3yhdik4sQcww1/fIZ3fpCAjfe9zkTGWlOp5IUe6ipu8m33Jtrbu7EmiZbLJugeoL
         wVtgKZxEkfjkaEmkOERrHCTZHodW25y0KaAF+y2rfv5XxI04uL3lmRYwSfyjbHRFoVbA
         rIr7fkQDwkDSG7cYJDYndfUBNdVoHG7JNeSwMQR4yQGxrzMjZgyPy7VEoOETd4Ylvcq1
         Rr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133202; x=1795738002;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
        b=ptmC9xAYTMx9S2qOaZOUXkO6afvsmY1hfxCzn8xPOJ5wxz+reEm7RaQ1jt97Y0OxsF
         a1ETfsTklpslFVEt5UbhxtvWdVbBlJPn0N6hkQeNAF51ZwSjxPirNWk0Bmcp/WfzWldz
         VjgglXolR1oe8MY4QefCHa71ctMSEVn8CNCNf+m75VrDacE8A/cikNCR/rveD4jtlVjX
         NMnqG3PBON+zvR24S2JUpvEw4qFhAA/aN0hE1SGOXEFK21z8rw6nuOT9xIPuhUJkSW+s
         P3+RL2c6agu7tCe6cShwSkWrAbiizRHM8Q8O1WuZWif5yXfZEOUbfixfOAkZ5btN4hlV
         OewQ==
X-Forwarded-Encrypted: i=1; AL+hErE1G/DlmYww6wKGk1vBgicBRXB93ozQ6SOUQ/EYNong1ZNDWxEJHhw2n8YPdmWydZ+qwMo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I4AMkxiRqaAsbuec9JyUc4n6RMcjLAD/ibH86NNehkCt9iwVa
	3Tdk9pm0p79JIVI05cEnbW5zE5+6oDzQS5Xb+PpTsTL28cujiwonyLx/aAL5k5zjvA==
X-Gm-Gg: AZFdTZdQF9OZxWoKz/nOGDCNAd5UKVnwsHN0B9xcqZbkDXRCw/Eap6ThZswjOxk1ebG
	G3C+RPL5sDoeUuP2dBovn5hhgmxMajikjx3CSHqGF2v72xL96IN1v+Lk7Wmd3j70mjaquRPJ1xj
	NsKmFeQJopnRWiFNm8RGFmeHluGaDTNHOmHAyaRUxu0sVkvwkdf/z56tXqJhTNkutYVSAeKRUO7
	pW8NrpRKBNgD2s3bWzqby1RhthB8Kbrso8pqRXz/A1zspGnb+29Gh9sC5sSRh9G94AAzvz+mGGi
	tMICLryaDfhHWTFLsXiNdVQlN1X9jAF0jhl7QTntodaEav7JYevoHAqOkdKymGxuvqYYR8Lc9Ju
	D4yfEvbORzHdDEIPa8UvxMpolVbElBveiyYvSQ35A/8fpDjg3M2B6EgWrCYVz1uAm7zzAj0Ej2V
	2rEY/AFQWIclF9ZFAGF6d99XZQMZ1JDJ0bW9mVmbfZBZCOoFowRCsYymIcpnRfljtMIA0QFiqmQ
	HLSqH8SKkRkB2H5qPX5J6eqvvX840pz6lc5Fg0nHDvkVzwR3QVzQSZZGY5NXMNp/L0bPvA5XGRJ
	tOozafEji6rAi7/zQU5n30k/SzJF2E9E9/gSPfwE5IY0jjS0Q+RDjuDS5lvF/0kN
X-Received: by 2002:a17:90b:442c:b0:3b3:ab74:cc9b with SMTP id 98e67ed59e1d1-3b41c554624mr967136a91.0.1795133201767;
        Thu, 19 Nov 2026 16:06:41 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ff5d3easm328044a91.1.2026.11.19.16.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:06:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:06:38 -0800
Message-Id: <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files
 across Live Update
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com> <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
In-Reply-To: <20261117220059.GA2250529.vipinsh@google.com>

On Tue Nov 17, 2026 at 10:44 PM PST, Vipin Sharma wrote:
>> pci_config_map doesn't need to be preserved. PATCH 14 already rebuilds
>> it with vfio_config_init() in the next kernel and only uses the
>> preserved copy to check that the two are identical.
>>=20
>> I assume the intent is to detect changes to vfio-pci's config emulation
>> between the two kernels, but the map isn't a good proxy for that. It
>> changes for differences that don't matter (e.g. hiding a capability or
>> learning the length of a new extended capability), which would fail
>> take-over and lose the Live Update on exactly the kernel upgrades Live
>> Update is meant for. And it doesn't change for differences that do
>> matter, like which bits are virtualized or writable within a capability.
>
> I think it does matter because reads and writes of unitialized
> capabilities in VFIO PCI config space goes to hardware directly. So, in
> the new kernel if pci_config_map changes it from PCI_CAP_ID_INVALID to
> others then those reads/writes can go to vconfig which will contain
> stale unitialized data from the old kernel's heap.
>
> This also changes behavior under a running user. Writes that reached
> hardware before Live Update can be silently dropped or redirected to
> vconfig. See the comment above struct perm_bits unassigned_perms{}
> in vfio_pci_config.c

That's true. Unassigned bytes passed through and vconfig is never
initialized for them, so hiding or exposing a capability does matter.
For example, 6467d0740a2b ("vfio/pci: Add DVSEC PCI Extended Config
Capability to user visible list") changed DVSEC from hidden (all bytes
raw) to exposed with a virtualized header. Across that boundary, v6
would have served DVSEC from uninitialized bytes in vconfig.

> How would a userspace opt-in? New kernel can change a capability visiblit=
y
> or virt and write permission of the bits inside a capability. Kernel
> cannot know if userspace used the capability or not. Creating a VFIO
> device in the new kernel by default results in a opt-in and currently
> there is no way for userspace to opt-out unless we add a new
> functionality where userspace can disable/enable features something
> similar to KVM capabilities.
>
> For now, I think we don't need to worry about it. As this version will
> be a base and if any serialized data with flags set received in this
> kernel will lead to erroring out restore.

We don't need an opt-in mechanism in this series. Detecting mismatches
is enough to make Live Update safe in both directions: if the next
kernel would emulate the device in an incompatible way, retrieve should
fail.

But an opt-in is needed to make rollback possible once vfio-pci starts
changing its emulation. I imagine something like a VFIO_DEVICE_FEATURE
that userspace can use to enable new emulation behavior right after
opening the device, with the enabled bits recorded in a field appended
to struct vfio_pci_core_device_ser behind a required flag. Devices that
don't opt in keep the baseline emulation and stay compatible with older
kernels. But that can come in a follow-on series.

> In the next version, I will not preserve pci_config_map. Hopefully,
> anyone changing VFIO code doesn't forget to update flags if they change
> capability or permission bits (I will write comments at appropriate
> places.)
>
> If we want to be very careful, we can do two things in this series:
>
> 1. Create a per bit valid mask for the vconfig and compare this between
>    new and old kernel during restore. In the new kernel, VFIO then takes
>    each bit from the preserved copy only where the mask says it was
>    valid, and keeps its own freshly initialized value elsewhere.
> 2. Create a hash or store virt and writable bits in config space.
>    Compare it with the new kernel.
>
> Both of the above combined will safeguard against forgotten flag update
> in the code.
>
> We don't have to do it but it safeguards against mistakes. Let me know
> what you prefer.

I think we should do both in this series, as two per-bit masks over
config space, preserved in place of pci_config_map:

 - virt[]: the bits whose value vfio-pci keeps in vconfig and returns
   instead of the device's value. This says which bits of the preserved
   vconfig are valid.

 - write[]: the bits whose writes take effect. For bits in virt they
   update vconfig, and for other bits they are forwarded to the device
   (possibly after validation). Writes to other bits are ignored.

The masks should describe what vfio-pci actually does rather than copy
perm->virt and perm->write.

vfio-pci can keep changing its implementation in ways that don't break
Live Update, e.g. start intercepting writes to a register to sanity
check them before forwarding them to the device.

Something like:

  struct vfio_pci_core_device_ser {
          ...
          u8 virt[PCI_CFG_SPACE_EXP_SIZE];
          u8 write[PCI_CFG_SPACE_EXP_SIZE];
          u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
  } __packed;


[ Note: I'd probably store virt[], write[], and vconfig[] on their
  own folios to avoid multi-order folio allocations, but I am embedding
  them here for simplicity. ]

The outgoing kernel computes virt[] and write[] through a helper in
vfio_pci_config.c and saves vconfig[] during freeze().

The incoming kernel computes its own virt[] and write[] masks and
requires both to match exactly with what's in vfio_pci_core_device_ser,
otherwise it fails the retrieve. On take-over it uses the preserved
value for bits in virt and its own freshly initialized value for the
rest, like your option 1.

I'd store the full masks rather than a hash, so that a mismatch can be
pinpointed.

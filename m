Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960389;
	b=p6NAHZHI/mCXEef6JY4sKJc7rTRdviM0tIS0lCm0UF4yzF+mX0MORIJQjGWuswBGNLAJ
	 Tj2lXLb1c8feicZhyDa8UHpRi35vpI1e2p0C7q8zpTQ/27S/XEvw0H8qMHxoDB+YvTWL0
	 qC+v22OoTm+ZQXCMqWsZLVocwFOOE4Q/lPvZehMrIHv4DCijzSoHnNdVt3iREunc6V6GC
	 3hhH/RqKx713T+wGx1OSA4Zmni+jDL0qBZDl2lZO0h/5QDbMtLryiPlog304sCiAjoml9
	 Q7maa/YxWdAgaLceCYcFUNJ71OjRL+Bci/JmaAwS1gBNFfg5oNmmv/Qj5E1Xk+v0mxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+xymGBMHB+69JfGsfO7yJc2L/tC6s5DquTHBRYW2RuM=;
	b=DAfpk4rwGmsdAtom/WMWavm+t2K5anxlhaNvWkrLicFA40WOrnFiZjtarpJkdsLcHkMt
	 9OV/Pra6DPGIDPlhqxeeX6pvfjh2OlDXuWocfzvb3gG+cuII9rFngcALSiw7kv285pfLr
	 h984CrcIv0i25hYnn4p4U0O8hYEajvlgXXCnZs4+lLdQzHbXffJ6UW4gWAjh1KHzzWL+p
	 AGoeEpy1tGtDwadm4g8nnAUx2ArSlj3MQ3c4+uvsHKWM1VmG/ceidRZt7SyWkhafblgN8
	 uZO5Hvx3LdeCLkJotRBzLRd7udUkDoZuC/hAnaJ5JozoBfvdj7Y1QoU4cT8hN1NyhWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UEquQA1G;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBE606A32C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 00:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FBBE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UEquQA1G
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9f6a16afcso12435ad.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794960388; x=1795565188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+xymGBMHB+69JfGsfO7yJc2L/tC6s5DquTHBRYW2RuM=;
        b=UEquQA1GKaFVZK88VYdviZy0Zd0/BVA+h4rqojd8tzowKo622JYGb5eLgoDDju4ge+
         N0SzNcmvvbwRPejifezn4wO+yOUAMLdZXzGH2bN7sr46DEvDrXw9qrshLLxfWJSm1sAd
         j+fZ8m3hY5qaFDFJL88f9O0WKh9D8xuBCC7y2b/+eJJ8LYmfZUPu8UiAZjhqBIcLvAOx
         5UGuieDAVUezp94H3qKjJjJM2ouD/lUopTUEfHZHEtZSL4xvkz4MRxtqWzp44wZTarye
         XZzpMKW8+DH2Bz8U4OFX44AhEqXhDbASX72T4QpN1eKMoNQmbacBi2pOkCk9zyg1h1Xh
         kZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794960388; x=1795565188;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xymGBMHB+69JfGsfO7yJc2L/tC6s5DquTHBRYW2RuM=;
        b=xkZSmdf7AtqW8Y3IsW4E2KHJ6EZjG76zC6j52eWRxXyyQp9XLmzyuEqIXw0bIkj3Jw
         xk+Oy437PnTtoRS+3JXI7mhHDf9o7ukjyObtEBbhYu0Od3s3ueRRwsHLvAX46xldfAoZ
         7XcWTGabUdPyccJhMY1tLu7VkPgSqHyR/EQG/u9GJxMq/WjuIKhpjNIUCojaeJAtbmVl
         d5ZZmQ3xi0854BEbQhvnZnufe28iQClCzl9K/hj/jXcfa6/QkGu4+XkdKoFtraFZ9NeS
         8r5SzfbOywH5Tbzzck6LGNqAu8NvTDJbe86dL837nORtiz6RaIqPpqza9ce2v0XLgLCK
         Qz5g==
X-Forwarded-Encrypted: i=1; AL+hErGsgx1fQ3NCDxGQePBRz4DjXxPZCUkEBrLDcM1CF5wiFlM9rJkkMU0GoSGIGkdBoFLZ3xU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+me8LjZ9eR3snVwKAnaFpiTXYm1zO5GUi9aphd6nqFrg0MCg+
	t6f7FOhDoSZoBxbwcgMZ/Tb39NUqwvVJXuaknWriG48tunNBR61Op0nuPJwlXxoDmg==
X-Gm-Gg: AZFdTZfv4HiY0Z7Ps4E4JrkPPbuOxCFwQ0aZaXLqa+b4GTYSo5FR3JtqBa0cX470kAw
	5ew/QsXfLuse3cfUrg0GsoPKotkQq2EYrHqp9d4QMgRl89bMuC88qB1RB1HVNpU2oy1Xw7DkAW5
	jxHSb68K/wE/4eNWvlSEjJZ9VvpNlmX2J7aUFEv57o79zM4P7DY7QW+ekFovXyYXGcqchu++rNN
	xdim+y21djHbVhYlBrgGQywIUVYFtyK/h59D2kTafsBfn7J1+Ep/TgvpyhfAyZaY67LKLD/kDkj
	9ZxuoAIeSiduN7asj36k8m0J3xpFNINLNXFdT27wTgSmzeXoqbAerGGGiXv7tvF+hYq3q9ebvef
	tHxczYD1hdDx0Q58E3wNnDiO2qRFnIf9GtkfWXS/CmoNDVt0MWQIJjTKc2yFtC0+pbFhWw7OAFv
	hP3/XYjlkKWQ8JgYw5jedEv05RiRi7VqZ692r6eF6fQoFEQtZTJ1+dVLBnS2iFlLcJpUbJG1W12
	/wWsaO+AeiCT/MomsbFAkZl3Hre9vOcxFDjc0qiOHu/6WZ2Z/nz+3FZDh/SfBRjVgc7M3gmTfvE
	koh8K3eZmKetnHeM2k63Yj3eE+gg98R85LymPPFOTje45KUtwpHNaZnXq4O8k7DUKao=
X-Received: by 2002:a17:903:3510:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2eff77a8714mr2438805ad.1.1794960388076;
        Tue, 17 Nov 2026 16:06:28 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d19b5e8asm1142449a91.8.2026.11.17.16.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:06:27 -0800 (PST)
Date: Tue, 17 Nov 2026 16:06:23 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, 
	kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <20261118000511.GC2250529.vipinsh@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <an0BOyexLcOjFJw9@google.com>
 <20261117225559.GB2250529.vipinsh@google.com>
 <avzfBjBZiOnJUH4W@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avzfBjBZiOnJUH4W@google.com>

On Tue, Nov 17, 2026 at 11:31:08PM +0000, Samiullah Khawaja wrote:
> On Tue, Nov 17, 2026 at 03:02:00PM -0800, Vipin Sharma wrote:
> > On Thu, Aug 13, 2026 at 10:30:45PM +0000, Samiullah Khawaja wrote:
> > > On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
> > > > It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
> > > > while SR-IOV is enabled.  This can not only result in an uncoordinated
> > > > disruption of the use of the associated VFs, but the ongoing use of and
> > > > access to the VF has the potential to result in machine checks.
> > > >
> > > > This series proposes that this gap is largely an oversight of
> > > > pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
> > > > violates the scope boundary of the pci_reset_function() API.
> > > 
> > > Hi Alex,
> > > 
> > > Thanks for sending out the RFC to fix this issue. I cherry-picked it
> > > into my environment to verify that whether it fixes the issue I was
> > > experiencing and it does fix it. I will continue to do more testing, but
> > > when you send this as a formal v1, you can add:
> > > 
> > > Tested-by: Samiullah Khawaja <skhawaja@google.com>
> > > Reported-by: Samiullah Khawaja <skhawaja@google.com>
> > > 
> > 
> > Hi Alex,
> > 
> > Is this series still on your radar for formal v1?
> > 
> > If this is the direction we are going in I can use it for liveupdate work
> >  https://lore.kernel.org/all/auzftbPFO_6XBYVw%40google.com/
> > 
> > Thanks
> > Vipin
> 
> Hi Vipin,
> 
> Alex asked me whether I or someone on our team could pick up this
> series. Pranjal is working on it and will send out a new version. There
> is some extra work needed on the IOMMU side to make sure that the device
> is moved to a blocking domain when the reset is skipped.
> 
> But I think the patch you need is fairly independent and can be sent out
> separately from this series:
> https://lore.kernel.org/kvm/20260812045325.2733631-6-alex.williamson@nvidia.com/
> 

That works for me. I can send this patch separately.

Thanks,
Vipin

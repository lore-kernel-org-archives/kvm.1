Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201C37E5E7
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933771; cv=none; b=d/No0NXRj1NU6X9QenrKCnaHOIv3/4HMGpcVxcGLS4jHJc8TWfUkigGneISEBylF2WwbFrh6uwmhegdItUkSvpdyOXQ5F88CGDQ+zKTBpyro1a58YQVwKk+IFdNlBzu8A9t0wDbmyBOz5nANB3axqLFu+4a+MMo6mW78jo3e2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933771; c=relaxed/simple;
	bh=B3pqQmJqpWZ8Cb06AdIkKqiDrvfvLs/ppE69ssAKPUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioSkHdimA5bu/5fmqmnTQBLoezDj4rmZu57Kx0ZXCSENRD57iqm96B0x5AVr0V5kLooj+MT7qXq87mI1wqVuNBBinLybtthEAtf9q/cVcQM6Pxzy5PnIlieOAy1Lyn38SN4m90It8OvPyiSSWJQkfQ6sQSoZg8PPf3gpu4rnQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5oeNHsj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5oeNHsj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b440b97aso137455ad.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787933769; x=1788538569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3pqQmJqpWZ8Cb06AdIkKqiDrvfvLs/ppE69ssAKPUM=;
        b=S5oeNHsj7j0+3lkWKVr/tuojxtvByOuel1/pd8QNGnxkXgmPCmGQkBjvzP/MU7ukY6
         D302RjRxxqXvpprEk/Q1ILjohf0WwqUB5RVKXXAvHA1Jpq+3XMbumIWEtpW0nD4auaWR
         rb/2pfnuC0B+sbdhxO0pK9rg4y7jTDzpZ6woghl/9pyQ9Mw2p3D695LyjQFuwdZiTuTD
         cl5a0oa096D4zL0a8ImYTo4/zWGx0VBMcBQ/XEmhVa8R2+EJFFqueR2sc5S5rJDvjBWf
         9MHzwkQBX0m53B5F8hxSPmrbNrUeTtcr4cYLtMr0fzSU+ObVjyz5Y2z1qLx6sgVhmAqF
         27Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787933769; x=1788538569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3pqQmJqpWZ8Cb06AdIkKqiDrvfvLs/ppE69ssAKPUM=;
        b=DwI5gcXkCy0twrW89187BGM4P4PQZbKk3XthsvuECPQVTjSVZbY39yDJUB91HeH+gs
         ++oxWZP3uShzumfMooNBx2vLUf2zCs/bRx31WHKQXapcrHWuBLcsnMv4+BYq8LwdR6Ji
         3OEGPdGYTl5Zad2TFHk89BUfCjErCMHrVkyOz3JoM2GbvfHfoXTihss4VEKbLPBYxmGk
         GCX5cWFv4PeNKpGvk/BjgqVdxei/qxiReoInkmIuE8vD1S9Ied6KWzrMoje9skdEHRGD
         zxAAH32C1obUyjVjqE/xV7kWYOoWbqOtJfbi3JAD8EBSeybeLglkdNbuqmf5ChejmLAK
         KJBQ==
X-Forwarded-Encrypted: i=1; AHgh+RreMRluy0IfqCCJy8htFFhGI4IKurtOoGzJv4u/Uor6gOG/i1nuypl83E97ZGgv73Qb1io=@vger.kernel.org
X-Gm-Message-State: AFuF++k3XjwWWgqcKMoDIb5PZyNAzSXVDqL9EaVQguL/H1L9/z2y8V+z
	7KvskWEkcRx4U9dWuV1YfH3hALJq+Nli1dVfmBFZlPVvFk4x/YBYeonf0fdvHGM4EQ==
X-Gm-Gg: AR+sD10yJ6Fe48kThGwb3qJzKl5ujf1LWsYAFZ0NuBAU1y53VitWahCK0J4aQ6v6ma9
	rltuYNSsBOIVaflAL+cFGLeBqEWBO+tN6g2E9RigJA/N6ESwX2rcM6ONQaZbLju1u1MjnODlyFt
	ZESGXL7kf7HGk4g+ChlK7Mplf5raz+S7QoB0WCUojAVyhV0qulID5xmNYDlchHBt4bpPO0rDX7l
	81Gm2TGFfxXb0puZ14+cDOFafe4KJw+97dd+hb0y9QtTtlBsCycl+Q0Epv6nNqwWCtZm8/Lu7mm
	a2VgSa5pZ7qg9ZlT7ccb2qwlsDpcsQxyq273JQJqARl81bW+kzeMLg8yVoDCYuP3dI1/T2hzLnb
	gUWdrLhyGD4DmLS3BPYl2Oqq1dhseTcG74VoMAvSAKc0vUrwzwQSgbFAYab+CJJKy1AmesW0HID
	OX7A9sbcfwdH5/+zmRvnoq/mvUj/j38VQKmQT3BwvuXBMD/FYIqSnI4jUYtN4V/bY4jOyTQICR3
	mPlWMca8UnjSshNTBwFVL66B/4isHvLaWr1tnQ3pUN2/GdicxvTvscT6ow=
X-Received: by 2002:a17:903:1b48:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d74f53de42mr7697375ad.8.1787933760261;
        Fri, 28 Aug 2026 09:16:00 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a359515dsm724321b3a.48.2026.08.28.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:15:59 -0700 (PDT)
Date: Fri, 28 Aug 2026 16:15:56 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <apGpHv8vy4SWIEaV@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
 <20260828143546.GC3769797@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260828143546.GC3769797@ziepe.ca>

On Fri, Aug 28, 2026 at 11:35:46AM -0300, Jason Gunthorpe wrote:
>On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
>> That looks reasonable to me. I have no concerns about keeping ATS
>> enabled on preserved devices across kexec reboot, as long as the
>> software state is synchronized in the new kernel.
>
>The new kernel should issue an ATC flush when it changes away from the
>inherented domain.

Yes, I will make sure this happens when we do the retrieval side. It
should mostly work well with the existing replace machinery.
>
>> By the way, is disabling ATS an option?
>
>No, many devices require ATS.

Agreed on the ATS requirement. I had Nicolin's patch series for CXL
devices in mind here.
>
>It is not that ATS and PRI are coupled, there are good reasons to do
>ATS to pinned memory too.
>
>PRI is a PITA, I continue to think PRI through the iommu was a
>mistake. Devices that have device-specific PRI handling are fine
>because that all lives in the VM. Devices relying on SMMU PRI
>forwarding must also somehow not loose any PRI events across the kexec
>and must ultimately inject all of them into the VM.
>
>> The current design already requires disabling PCI/PRI during kexec,
>> right?
>
>That is also not OK, but there certainly is a useful universe of VMs
>that might pretend to use PRI but actually only use device specific
>fault delivery.
>
>So ignoring PRI for the moment is possibly OK. Someone using this
>should understand what VM shapes thay are making and if that
>limitation is OK.

Agreed. To avoid the massive complexity of handling PRI events across
the kexec right now, I explicitly evaluated this during v4 development
and marked PRI as unsupported to limit the scope for now.
>
>Jason

Thanks,
Sami

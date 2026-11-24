Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488525;
	b=34KkFx5Cq3IKIEVJpxuqbYR+nE+X0PkHcut9R0K10GZJAcUV8moRjbWzpGa4o8G8b/ut
	 +++gcN3CX0MY9rop4/TEYxa/JQ+BRkkZ6eZ1vDuIiKnqUbwEyMciEJQnoBxvzrrgw7ZHL
	 ihzYUrAZCOlEV3sDU8uqx4Yrx/4OmRp0k/74bJlvO+Y2ZVg+ZwA1XsSgeoDukUdZ1YMWU
	 rtc9OOpk9engFcUDdn+aazILIFlwbnk4g8jguS84u3pQw9Pax5tUGjUYCZDvhQg5ojwue
	 TOI+p9YiQeNxA49i5EoNpqv69udleyvSBILVpXUT18vvyIdAr9jL1kELh+Lg0yH9OKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=feBMC46Kg9xglm0UM1RjR22Aujb6Qvmmma1ih7AmJ8A=;
	b=y/ZtQfX+fyJb6y5VMgCi9WW+dN8nxhHesZJPTQy4euL1zdXkqObl3z/qQpDddZDFv6L3
	 638G23EuSgTqG/EM4CyqF7CCDvFXEjUsN+lZZnq/rmc0tkNKrdpB+lcgFg9HFNhgkSSSR
	 AVaVChwu74NtGjQ3thWpkQPYwuJZExgInaUI3PekrLC/kVdgfyx6CSy7JQdhXT0Sl1icw
	 Ah2HC28wAK/qAT5WBx5DA0FdXjPV9tKYMCBkwn1usk8e00UBLM62jcxtLbiTCyZFKR6cH
	 S8Im+V5or/wWxuEUCgM++u3i1meH7b6drcF7gHPHr+iENsDcfdKf6eY3SgG9LgFu4ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ODvelHFE;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCECA606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 02:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCECA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ODvelHFE
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-92106d5371dso51287336d6.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795488524; x=1796093324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=feBMC46Kg9xglm0UM1RjR22Aujb6Qvmmma1ih7AmJ8A=;
        b=ODvelHFEv1H1fitxrY3MRiNYEMBDVg1At/2gXLR6bhj9RFU2tjIZnEOzaHw/otk14D
         yyO1CPZzlSsmxohkC1xnXGxUIKf2lDLUBFvIxHY9sPBAx0oEyt7QkMssB/M71zL8n7wD
         bBu1pQ3KBa6QY0t4ZwLyAZCUw+VdLDrJ6Ismt2uw0+Gay7FKNuzEUF0VcVHt5llkx19k
         KF5mQSjSSQDRODHfBRv2m/22MQ2JFbEsKyTPkn2vzj/t8eIWG1Rf35Lall1BRQpoXbbZ
         ucrMRWQhY9+oxccmra8UzAHd65tSqZKE27/QzoMVM0Jhcw/epWxAj5RxUEtIV2hkPNf1
         yAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795488524; x=1796093324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=feBMC46Kg9xglm0UM1RjR22Aujb6Qvmmma1ih7AmJ8A=;
        b=ykw8AgN2m4XYDSAS9MBB3jHGpUHl2cN7HrzyGuw2Y7r0OfaNla7Gu5/jagvcaB75El
         sYiSFyJmXDjlrEFHXhzqaqgGHKRgbyWux+N17sw6NJre0m9nelJAy0mpQF3/XmkfcXH6
         pvQ/bCXwspknQei9Xm8SVNSPQMrUfUpQwvWcWbjkmpmlLyhEcZ2QqTc7YvAaM6bVWBaD
         9K5tisJhBc2Io8omhIrhNw2N3JEd6R0/Q4+Lv9QvLU/KptO9zB9/JPV+u6vLzizV3IsE
         z14/FBP7CubqowKIiE8JIe7FMcF0CMupaLnSPylQUn4ZmQP8RSBNVB/5jtgNZAdqrQym
         Mc2w==
X-Forwarded-Encrypted: i=1; AL+hErGhcO8dGNEx6tQ/lTV1NWJT4IbgDFnTxQRxwjVszDr6NYi/9DdNuQGrJZwnyO1ADiwTALs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BX31FJiWoAqfLvRd8nX+kEm7qyaea1AyaYwdCuW5yrjOmpY/9
	OoroZ1ihXHtAgjHjr9vfuiDDUIGSwZGWOXyuH+QnNajpDZ/74EqPNO0nN2nL03NJHLE=
X-Gm-Gg: AZFdTZfuk/FDIYS4nqJ8BnfeQAnTxnE8ZU+Ia6QqgR6uTHwFzxYz26zWrULjZd/L2qr
	7vE7n129FiSBEKB8m4Yxy4TnbKT5SjiF5vYOue3muei5L+QQT1z1/99Jdn+ElFlBGQykjn5hNvV
	C6YoN2oB3swOL3RJLJmgPoc0yQHLoqpZB0dICmFQL8IXOQvehLEpS5u6mOZh5JcgI3E4SHlZoMU
	8knZkcK/JeCTAnntnPos/j+t1uoBXWxoUWdKyd9NcQK4knQeU6yuqD7azfNuKXxoBR8eKItjARg
	jWRlq17EW5a+UpmMYyuOVgJGBRc02tE88ElbE/mQnI/PWEHImQ16Jh7rvti9iUrDhdf4aZbjgb9
	s5XYrla3hbsQ6xDkQFprgKT2WEQleJe1AhMAawPYEqDKzo607ZQl81VOW4USRVs2vDme66Vi/9x
	0UlUwP49FrkzXpXERcc5klGocB2BAhDtEO/lMa+Qh+3dPSj/awWdoB0KHYiB5NxCgLS8tIa4eTJ
	wvAKeQ2HC4PwhofK07S8y/yiGHWJj6xi8y+WOTbJkL63LxEXuIU6prFNCcnEhrC2fi9Cq9Ulqgp
	T2iqR+I=
X-Received: by 2002:a05:6214:2263:b0:921:37ed:5c6 with SMTP id 6a1803df08f44-92137ed06efmr217313286d6.22.1795488523691;
        Mon, 23 Nov 2026 18:48:43 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm122581686d6.18.2026.11.23.18.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:48:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVgaI-000000002sY-302b;
	Mon, 23 Nov 2026 22:48:42 -0400
Date: Mon, 23 Nov 2026 22:48:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 01/10] PCI/TSM: Report active IDE streams per host
 bridge
Message-ID: <20261124024842.GB9566@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-2-aneesh.kumar@kernel.org>
 <f377271d-353f-4c8e-94d5-98159a66ab28@amd.com>
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
In-Reply-To: <f377271d-353f-4c8e-94d5-98159a66ab28@amd.com>

On Tue, Nov 24, 2026 at 11:11:49AM +1100, Alexey Kardashevskiy wrote:
> On 23/11/26 19:33, Aneesh Kumar K.V (Arm) wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > The first attempt at an ABI for this failed to account for naming
> > collisions across host bridges:
> > 
> > Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> > 
> > Revive this ABI with a per host bridge link that appears at first stream
> > creation for a given host bridge and disappears after the last stream is
> > removed.
> > 
> > For systems with many host bridge objects it allows:
> > 
> >      ls /sys/class/tsm/tsmN/pci*/stream*
> > 
> > ...to find all the host bridges with active streams without first iterating
> > over all host bridges. Yilun notes that is handy to have this short cut [1]
> > and from an administrator perspective it helps with inventory for
> > constrained stream resources.
> > 
> > Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> > Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > ---
> >   Documentation/ABI/testing/sysfs-class-tsm | 13 ++++
> >   drivers/pci/ide.c                         |  4 +
> >   drivers/virt/coco/tsm-core.c              | 95 +++++++++++++++++++++++
> 
> I'll take to the tsm tree, thanks!

Lets not take any new sysfs APIs please. These all need a careful
thing and we are not having a good history right now on any of these.

I'm not even sure what this is supposed to be for, is it debugging?

Jason
